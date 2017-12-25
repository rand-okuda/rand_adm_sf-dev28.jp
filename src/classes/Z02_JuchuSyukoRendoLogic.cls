public with sharing class Z02_JuchuSyukoRendoLogic {
    
    // 定数
    private static final String A = 'A';
    private static final String B = 'B';
    private static final String C = 'C';
    
    //引当てパターン変数
    String juchuPattern = '';
    
    /** エラーメッセージ */
    private static final String ERROR_MESSAGE_1 = '在庫引当が出来ませんでした。';
    private static final String ERROR_MESSAGE_2 = ' は引当条件を満たす在庫が不足しています。';
    private static final String ERROR_MESSAGE_C = 'ユニット混在フラグをONにして下さい。';
    private static final String ERROR_MESSAGE_B = '消費期限混在フラグをONにして下さい。';
    
    // エラーメッセージのリスト
    private List<String> errorList;
    
    // コンストラクタ
    public Z02_JuchuSyukoRendoLogic(){
        // 実行無し
    }
    
    public void zaikohikiate(Map<Id, JuchuData__c> newMap){
        // 受注明細を取得する。引当不要フラグOFFを取得する。
        List<JuchuMeisaiData__c> allMeisaiList = new List<JuchuMeisaiData__c>();
        allMeisaiList = [SELECT Id, ShohinShizaiM__r.Name, ShohinShizaiM__c, JuchuSuryo__c, ShomiKigenShokai__c, JuchuData__c, HikiateFuyoFig__c FROM JuchuMeisaiData__c WHERE HikiateFuyoFig__c = FALSE AND JuchuData__c IN :newMap.keySet() ORDER BY JuchuData__c];

        // key:受注データ,value:受注明細データのリストのマップを作成する
        Map<Id, List<JuchuMeisaiData__c>> meisaiMap = new Map<Id, List<JuchuMeisaiData__c>>();
        List<JuchuMeisaiData__c> tmpMeisaiList = new List<JuchuMeisaiData__c>();

        for(Integer i = 0; i < allMeisaiList.size(); i++){
            tmpMeisaiList.add(allMeisaiList[i]);
            // 現在の明細データが最後の物である　または、次の明細データの参照する受注データと異なっている。
            if(i == allMeisaiList.size() - 1 || allMeisaiList[i].JuchuData__c != allMeisaiList[i + 1].JuchuData__c){
                meisaiMap.put(allMeisaiList[i].JuchuData__c, new List<JuchuMeisaiData__c>(tmpMeisaiList));
                tmpMeisaiList.clear();
            }
        }

        // 受注データ毎に実行
        for(Id JuchuId :meisaiMap.keySet()){

            // エラーリスト追加
            this.errorList = new List<String>();

            // 引当スタンバイfalse、引当非同期確定false、受注確定フラグtrue、引当完了フラグfalse、引当可能フラグtrueの場合
            if(!newMap.get(JuchuId).JidoHikiateFlg__c && !newMap.get(JuchuId).HikiateZanjiKakutei__c && newMap.get(JuchuId).JuchuKakuteiFlg__c && !newMap.get(JuchuId).HikiateKanryoFlg__c && newMap.get(JuchuId).HikiateKanoFlg__c){
                // 受注データのパターンを確認　デフォルトパターンをCにセット
                juchuPattern = 'C';
                // Aパターン：賞味期限混在フラグtrue,ロット混在フラグtrue
                if(newMap.get(JuchuId).ShomiKigenKonzaiFlg__c && newMap.get(JuchuId).LotKonzaiFlg__c){
                    juchuPattern = 'A';
                }
                // Aパターン：賞味期限混在フラグtrue,ロット混在フラグfalse
                else if(newMap.get(JuchuId).ShomiKigenKonzaiFlg__c && !newMap.get(JuchuId).LotKonzaiFlg__c){
                    juchuPattern = 'A';
                }
                // Bパターン：賞味期限混在フラグfalse,ロット混在フラグtrue
                else if(!newMap.get(JuchuId).ShomiKigenKonzaiFlg__c && newMap.get(JuchuId).LotKonzaiFlg__c){
                    juchuPattern = 'B';
                }
                // Cパターン：賞味期限混在フラグfalse,ロット混在フラグfalse
                else if(!newMap.get(JuchuId).ShomiKigenKonzaiFlg__c && !newMap.get(JuchuId).LotKonzaiFlg__c){
                    juchuPattern = 'C';
                }
                // 引き当てるのに十分な在庫が存在するか確認。
                List<meisaiZaiko> meisaiZaikoList = isEnoughZaiko(newMap.get(JuchuId), meisaiMap.get(JuchuId), juchuPattern);
                if(!meisaiZaikoList.isEmpty()){
                    // 十分存在する

                    // 引当実行
                    doHikiate(newMap.get(JuchuId), meisaiZaikoList);

                    // 引当完了フラグtrue;
                    newMap.get(JuchuId).HikiateKanryoFlg__c = true;
                    // 引当メモをクリアする
                    newMap.get(JuchuId).HikiateMemoALL__c = '';
                }else{
                    // 引当メモにエラー内容を書き込む
                    createErrorMessage(newMap.get(JuchuId));
                    // 受注確定引当フラグfalse
                    newMap.get(JuchuId).JuchuKakuteiFlg__c = false;
                }
            }
        }
    }
    
    
    /**
     * 必要十分な在庫数量が存在するかチェックする処理 
     * 一つでも十分な在庫がない受注明細が存在した場合は空のリストを返す。
     * @param newObj 更新した受注データ
     * @param meisaiLIst 上記の受注データに紐付く受注明細リスト
     * @paran juchuPattern 受注データのパターン
     * @return （受注明細データとそれに紐付く候補の在庫データのリスト）のリスト
     */
    private List<MeisaiZaiko> isEnoughZaiko(JuchuData__c newObj, JuchuMeisaiData__c[] meisaiList, String juchuPattern){
        // 必要十分な在庫が存在したか？
        Boolean isEnoughZaiko = true;
        
        // 返却用マップ 明細データのId, それに紐付く候補の在庫リスト
        List<MeisaiZaiko> meisaiZaikoList = new List<MeisaiZaiko>();
        
        //受注明細毎に実行
        for(JuchuMeisaiData__c meisaiItem :meisaiList){
            // 在庫データを取得
            List<ZaikoData__c> zaikoList = new List<ZaikoData__c>();
            zaikoList = getZaikoData(newObj, meisaiItem, juchuPattern);

            Integer zaikoSUM = 0;
            // パターンAまたはCの場合
            if(!juchuPattern.equals(B)){
                // 取得した在庫データの在庫数量を合計
                for(ZaikoData__c zaikoItem :zaikoList){
                    zaikoSUM = zaikoSUM + Integer.valueOf(zaikoItem.ZaikoSuryo__c);
                }
            
                // 在庫数量の合計と受注数量を比較
                if(zaikoSUM < meisaiItem.JuchuSuryo__c){
                    // 十分な在庫が存在しない
                    isEnoughZaiko = false;
                    
                    // エラーメッセージ
                    this.errorList.add(meisaiItem.ShohinShizaiM__r.Name);
                }else{
                    // 十分な在庫が存在する
                    
                    // 返却用マップに追加
                    meisaiZaiko tmpMeisaiZaiko = new meisaiZaiko();
                    tmpMeisaiZaiko.meisai = meisaiItem;
                    tmpMeisaiZaiko.zaikoList = zaikoList;
                    
                    meisaiZaikoList.add(tmpMeisaiZaiko);
                }
            // パターンBの場合
            } else {
                // 結果受取用在庫リスト
                List<ZaikoData__c> tmpZaikoList = new List<ZaikoData__c>();
                
                if(newObj.SuryoYusenFlg__c){
                    // 在庫数の合計が少ないものから引き当てるモード
                    tmpZaikoList = extractZaikoDataKosuYusen(meisaiItem, zaikoList);
                }else{
                    // 賞味期限が近い物から引き当てるモード
                    tmpZaikoList = extractZaikoDataKigenYusen(meisaiItem, zaikoList);
                }
                                
                // 適当な在庫データが存在したか？
                if(tmpZaikoList.isEmpty()){
                    // 十分な在庫が存在しない
                    isEnoughZaiko = false;
                    
                    // エラーメッセージ
                    this.errorList.add(meisaiItem.ShohinShizaiM__r.Name);
                }else{
                    // 十分な在庫が存在する
                    
                    // 返却用マップに追加
                    meisaiZaiko tmpMeisaiZaiko = new meisaiZaiko();
                    tmpMeisaiZaiko.meisai = meisaiItem;
                    tmpMeisaiZaiko.zaikoList = tmpZaikoList;
                    
                    meisaiZaikoList.add(tmpMeisaiZaiko);
                }
            }
        }
        
        // 全ての明細データに対して必要十分な在庫が存在したか？
        if(!isEnoughZaiko){
            // 返却用マップを空に上書き
            meisaiZaikoList.clear();
        }
        return meisaiZaikoList;
    }
    
    
    /*
     * 在庫データを取得する処理
     * @param newObj 更新した受注データ
     * @param meisaiItem 上記の受注データに紐付く受注明細
     * @param juchuPattern 上記の受注データのパターン
     * @return 取得した在庫データ
     */
    private List<ZaikoData__c> getZaikoData(JuchuData__c newObj, JuchuMeisaiData__c meisaiItem, String juchuPattern){
        // 受注数量を数値：Integerに変換
        Integer juchuSuryo = Integer.valueOf(meisaiItem.JuchuSuryo__c);

        // 返却用の配列
        List<ZaikoData__c> retZaikoDataList = new List<ZaikoData__c>();

        // soql文にORDER BY句が含まれていると「for update」が使用できないので、先に単純なsoqlでロックする。
        List<ZaikoData__c> lockSimpleSoql = 
			[SELECT ID, ZaikoSuryo__c, ShohinShizaiM__c, ShomiKigen__c, ZenShukkoSuryo__c
				FROM ZaikoData__c
				WHERE ShohinShizaiM__c = :meisaiItem.ShohinShizaiM__c
				AND Zaikobasho__c = :newObj.ZaikoHikiateSaki__c
				AND ShomiKigen__c >= :meisaiItem.ShomiKigenShokai__c
				AND HikiateKensakuFlg__c = true
				for update
			];

        // パターンによって変化する部分
        if(juchuPattern.equals(A)){
            
            if(newObj.SuryoYusenFlg__c){
                // 在庫数量が少ないもの優先 ORDER BY ZaikoSuryo__c ASC, ShomiKigen__c ASC
                //引当検索対象フラグONだけを取得 HikiateKensakuFlg__c = true
				retZaikoDataList = 
					[SELECT ID, ZaikoSuryo__c, ShohinShizaiM__c, ShomiKigen__c, ZenShukkoSuryo__c
						FROM ZaikoData__c
						WHERE ShohinShizaiM__c = :meisaiItem.ShohinShizaiM__c
						AND Zaikobasho__c = :newObj.ZaikoHikiateSaki__c
						AND ShomiKigen__c >= :meisaiItem.ShomiKigenShokai__c
						AND HikiateKensakuFlg__c = true
						ORDER BY ZaikoSuryo__c ASC, ShomiKigen__c ASC
                	];
                
            }else{
				// 賞味期限が近い物優先 ORDER BY ShomiKigen__c ASC, ZaikoSuryo__c ASC
				//引当検索対象フラグONだけを取得 HikiateKensakuFlg__c = true
				retZaikoDataList = 
					[SELECT ID, ZaikoSuryo__c, ShohinShizaiM__c, ShomiKigen__c, ZenShukkoSuryo__c
						FROM ZaikoData__c
						WHERE ShohinShizaiM__c = :meisaiItem.ShohinShizaiM__c
						AND Zaikobasho__c = :newObj.ZaikoHikiateSaki__c
						AND ShomiKigen__c >= :meisaiItem.ShomiKigenShokai__c
						AND HikiateKensakuFlg__c = true
						ORDER BY ShomiKigen__c ASC, ZaikoSuryo__c ASC
                	];

            }

        }else if(juchuPattern.equals(B)){
			// 賞味期限が近い物優先 ORDER BY ShomiKigen__c ASC, ZaikoSuryo__c ASC
			//引当検索対象フラグONだけを取得 HikiateKensakuFlg__c = true
			retZaikoDataList = 
				[SELECT ID, ZaikoSuryo__c, ShohinShizaiM__c, ShomiKigen__c, ZenShukkoSuryo__c
					FROM ZaikoData__c
					WHERE ShohinShizaiM__c = :meisaiItem.ShohinShizaiM__c
					AND Zaikobasho__c = :newObj.ZaikoHikiateSaki__c
					AND ShomiKigen__c >= :meisaiItem.ShomiKigenShokai__c
					AND HikiateKensakuFlg__c = true
					ORDER BY ShomiKigen__c ASC, ZaikoSuryo__c ASC
            	];

        } else if(juchuPattern.equals(C)){

            if(newObj.SuryoYusenFlg__c){
				// 受注数量を満たす在庫数量のもの全て AND ZaikoSuryo__c >= :juchuSuryo
                // 在庫数量が少ないもの優先 ORDER BY ZaikoSuryo__c ASC, ShomiKigen__c ASC
                //引当検索対象フラグONだけを取得 HikiateKensakuFlg__c = true
                // 単一ロット：単一レコードのみが引当て対象 LIMIT 1
				retZaikoDataList = 
					[SELECT ID, ZaikoSuryo__c, ShohinShizaiM__c, ShomiKigen__c, ZenShukkoSuryo__c
						FROM ZaikoData__c
						WHERE ShohinShizaiM__c = :meisaiItem.ShohinShizaiM__c
						AND Zaikobasho__c = :newObj.ZaikoHikiateSaki__c
						AND ShomiKigen__c >= :meisaiItem.ShomiKigenShokai__c
						AND HikiateKensakuFlg__c = true
						AND ZaikoSuryo__c >= :juchuSuryo
						ORDER BY ZaikoSuryo__c ASC, ShomiKigen__c ASC
						LIMIT 1
	            	];

            }else{
				// 受注数量を満たす在庫数量のもの全て AND ZaikoSuryo__c >= :juchuSuryo
                // 賞味期限が近い物優先 ORDER BY ShomiKigen__c ASC, ZaikoSuryo__c ASC
                //引当検索対象フラグONだけを取得 HikiateKensakuFlg__c = true
                // 単一ロット：単一レコードのみが引当て対象 LIMIT 1
				retZaikoDataList = 
					[SELECT ID, ZaikoSuryo__c, ShohinShizaiM__c, ShomiKigen__c, ZenShukkoSuryo__c
						FROM ZaikoData__c
						WHERE ShohinShizaiM__c = :meisaiItem.ShohinShizaiM__c
						AND Zaikobasho__c = :newObj.ZaikoHikiateSaki__c
						AND ShomiKigen__c >= :meisaiItem.ShomiKigenShokai__c
						AND HikiateKensakuFlg__c = true
						AND ZaikoSuryo__c >= :juchuSuryo
						ORDER BY ShomiKigen__c ASC, ZaikoSuryo__c ASC
						LIMIT 1
	            	];

            }

        }

        return retZaikoDataList;
    }

    
    /**
     * 在庫引き当てを行う処理
     * @param newObj 更新した受注データ
     * @param meisaiList 上記の受注データに紐付く受注明細リスト
     * @param zaikoList 上記の受注明細に紐付けられる在庫のリスト
     */
    private void doHikiate(JuchuData__c newObj, List<meisaiZaiko> meisaiZaikoList){
        // アップサートする在庫データ
        List<ZaikoData__c> upsZaikoList = new List<ZaikoData__c>();
        
        // 引当が完了したかどうかのフラグ
        Boolean isFinishHikiate = false;
        
        // 受注明細毎に実行
        for(meisaiZaiko meisaiItem :meisaiZaikoList){
            // 在庫数量の少ない順に実行
            for(ZaikoData__c zaikoItem :meisaiItem.zaikoList){
                // 引当は完了しているか？
                if(!isFinishHikiate){

                    // 入出庫データ（子）を作成
                    ZaikoData__c zaikoChild = new ZaikoData__c();
                    zaikoChild.JuchuMeisai__c = meisaiItem.meisai.id;

                    // 入出庫データ出庫日時は納品予定日から代入
                    Time tmpTime = Time.newInstance(0, 0, 0, 0);
                    zaikoChild.ZenShukkoNichiji__c = DateTime.newInstance(newObj.NohinYoteibi__c, tmpTime);

                    zaikoChild.ZenZaikoData__c = zaikoItem.Id;
                    zaikoChild.Zaikobasho__c = newObj.NohinsakiShokai__c;
                    zaikoChild.ShohinShizaiM__c = zaikoItem.ShohinShizaiM__c;
                    zaikoChild.ShomiKigen__c = zaikoItem.ShomiKigen__c;
                    zaikoChild.ShukkoFlg__c = true;
         
                    // 在庫データと受注明細の受注数量を比較
                    if(meisaiItem.meisai.JuchuSuryo__c <= zaikoItem.ZaikoSuryo__c ){
                        // 受注数量 <= 在庫数量の場合(パターンCの場合必ずこちらを通る)
                        
                        //zaikoChild.NyukoSuryo__c = meisaiItem.meisai.JuchuSuryo__c;
                        zaikoChild.ZenShukkoSuryo__c = meisaiItem.meisai.JuchuSuryo__c;
                        // 在庫数量を受注数量の分マイナスする
                        zaikoItem.ZaikoSuryo__c = zaikoItem.ZaikoSuryo__c - meisaiItem.meisai.JuchuSuryo__c;
                        // 引当完了フラグtrue
                        isFinishHikiate = true;
                    }else{
                        // 在庫数量<受注数量の場合

                        //zaikoChild.NyukoSuryo__c = zaikoItem.ZaikoSuryo__c;
                        zaikoChild.ZenShukkoSuryo__c = zaikoItem.ZaikoSuryo__c;
                        // 受注明細の受注数量を在庫が引き当てられた分だけ減らす
                        meisaiItem.meisai.JuchuSuryo__c = meisaiItem.meisai.JuchuSuryo__c - zaikoItem.ZaikoSuryo__c;
                        // 在庫数量を0にする
                        zaikoItem.ZaikoSuryo__c = 0;
                    }
                    // 追加した在庫データ（子）と更新した在庫データ（親）をアップサート用リストに追加
                    upsZaikoList.add(zaikoChild);
                    upsZaikoList.add(zaikoItem);
                    
                }
            }
        isFinishHikiate = false;
        }
        upsert upsZaikoList;
    }
    
    
    /**
     * パターンBで一番賞味期限が早い在庫データを抽出して返す処理。(賞味期限優先モード)
     * 存在しない場合は空のリストを返す。
     * 例) 下記の様に在庫が有るとして、受注数量が12の場合、在庫C,Dを返す。
     * 在庫A 賞味期限2015/1/1 在庫5個 
     * 在庫B 賞味期限2015/1/1 在庫6個 
     * 在庫C 賞味期限2015/1/2 在庫10個 
     * 在庫D 賞味期限2015/1/2 在庫10個 
     * 在庫E 賞味期限2015/1/3 在庫20個 
     *
     * @param meisaiItem 受注明細データ
     * @param zakoList 在庫データのリスト
     * @return 上記の条件に一致する在庫データのリスト
     */
    private List<ZaikoData__c> extractZaikoDataKigenYusen(JuchuMeisaiData__c meisaiItem, ZaikoData__c[] zaikoList){
        // 返却用在庫リスト
        // 適当なﾃﾞｰﾀが見つからない場合は最後まで初期値のままとなる。
        List<ZaikoData__c> retZaikoList = new List<ZaikoData__c>();     
        // 適当なデータが見つかったかどうか
        Boolean isFind = false;
        // 同じ賞味期限の在庫データの合計数
        Integer zaikoSUM = 0;
        // 抽出対象一時リスト
        List<ZaikoData__c> tmpZaikoList = new List<ZaikoData__c>();
                
        // 同じ賞味期限の在庫データの在庫数量の合計と受注数量を比較する
        for(Integer i = 0; i < zaikoList.size(); i++){
            if(!isFind){
                // 在庫数量を合計
                zaikoSUM = zaikoSUM + Integer.valueOf(zaikoList[i].zaikoSuryo__c);
            
                // 抽出対象一時リストに追加
                tmpZaikoList.add(zaikoList[i]);
                
                if(i == zaikoList.size() - 1 || zaikoList[i].ShomiKigen__c != zaikoList[i+1].ShomiKigen__c){
                    // まだ適当なデータが見つかっていないかつ
                    // 現在のデータが最後のものまたは、
                    // 現在の在庫データの賞味期限と次の在庫データの賞味期限が異なる場合
                
                    // 在庫数量の合計と受注数量を比較
                    if(zaikoSUM >= meisaiItem.JuchuSuryo__c){
                        // 在庫の合計が受注数量を上回っている
                    
                        // 適当なﾃﾞｰﾀが見つかったのでフラグをtrue
                        isFind = true;
                        // 返却用リストに設定。
                        retZaikoList = tmpZaikoList;
                    }else{
                         // 在庫数の合計を初期化
                         zaikoSUM = 0;
                         // 抽出対象一時リストを初期化
                        tmpZaikoList.clear();
                    }
                }
            }
        }
        return retZaikoList;
    }
    

    /**
     * パターンBで在庫数量の合計が一番少ない在庫データを抽出して返す処理。(個数優先モード)
     * 存在しない場合は空のリストを返す。
     * 例) 下記の様に在庫が有るとして、受注数量が12の場合、在庫C,Dを返す。
     * 在庫A 賞味期限2015/1/1 在庫15個 
     * 在庫B 賞味期限2015/1/1 在庫16個 
     * 在庫C 賞味期限2015/1/2 在庫10個 
     * 在庫D 賞味期限2015/1/2 在庫10個 
     * 在庫E 賞味期限2015/1/3 在庫20個 
     *
     * @param meisaiItem 受注明細データ
     * @param zakoList 在庫データのリスト
     * @return 上記の条件に一致する在庫データのリスト
     */
    private List<ZaikoData__c> extractZaikoDataKosuYusen(JuchuMeisaiData__c meisaiItem, ZaikoData__c[] zaikoList){
        // 返却用在庫リスト
        // 適当なﾃﾞｰﾀが見つからない場合は最後まで初期値のままとなる。
        List<ZaikoData__c> retZaikoList = new List<ZaikoData__c>();     
        // 同じ賞味期限の在庫データの合計数
        Integer zaikoSUM = 0;
        // 条件を満たす中で一番少ない在庫数の合計
        Integer nowMinimumZaikoSum = 0;
        
        // 抽出対象一時リスト
        List<ZaikoData__c> tmpZaikoList = new List<ZaikoData__c>();
                
        // 同じ賞味期限の在庫データの在庫数量の合計と受注数量を比較する
        for(Integer i = 0; i < zaikoList.size(); i++){
            // 在庫数量を合計
            zaikoSUM = zaikoSUM + Integer.valueOf(zaikoList[i].zaikoSuryo__c);
            
            // 抽出対象一時リストに追加
            tmpZaikoList.add(zaikoList[i]);
                
            if(i == zaikoList.size() - 1 || zaikoList[i].ShomiKigen__c != zaikoList[i+1].ShomiKigen__c){
                // 現在のデータが最後のものまたは、
                // 現在の在庫データの賞味期限と次の在庫データの賞味期限が異なる場合
                
                // 在庫数量の合計と受注数量を比較
                if(zaikoSUM >= meisaiItem.JuchuSuryo__c){
                    // 在庫の合計が受注数量を上回っている
                    
                    // これまでの条件を満たした在庫の合計の中で、一番少ないものと比較(初回は必ず通る)
                    if(nowMinimumZaikoSum > zaikoSum || nowMinimumZaikoSum == 0){
                        // 一番少ない物を返却用リストに設定
                        retZaikoList = tmpZaikoList.clone();
                        // 一番少ない在庫数の合計を更新
                        nowMinimumZaikoSum = zaikoSum;
                    }
                }
                
                // 在庫数の合計を初期化
                zaikoSUM = 0;
                // 抽出対象一時リストを初期化
                tmpZaikoList.clear();
            }
        }
        return retZaikoList;
    }
    
    /**
     * 備考にエラーメッセージを記入する処理
     * @param newObj 受注データ
     */
    private void createErrorMessage(JuchuData__c newObj){

        String errorStringX = '';
        String errorStringY = '';
        
        errorStringX += ERROR_MESSAGE_1;

        if(juchuPattern.equals(B)){
            errorStringX += ERROR_MESSAGE_B + '\n';
        }

        if(juchuPattern.equals(C)){
            errorStringX += ERROR_MESSAGE_C + '\n';
        }
        
        for(Integer i = 0; i < errorList.size(); i++){
            errorStringY += errorList[i] + ERROR_MESSAGE_2 + '\n';
        }

        newObj.HikiateMemo__c = errorStringX;
        newObj.HikiateMemoALL__c = errorStringY;

    }
    
    /*
     * 受注明細データとそれに紐付く在庫データのリスト
     */
    public class meisaiZaiko{

        public JuchuMeisaiData__c meisai{get; set;}
        public List<ZaikoData__c> zaikoList{get; set;}

        // コンストラクタ
        public meisaiZaiko(){
        }

    }

}