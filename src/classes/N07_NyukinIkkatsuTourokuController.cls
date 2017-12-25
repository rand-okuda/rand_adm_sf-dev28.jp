public without sharing class N07_NyukinIkkatsuTourokuController {

    //現在のガバナリミットSystem.limits.getLimitQueryRowsを取得する。
    Integer limitQueryRows = System.limits.getLimitQueryRows()/3;
    
    /** プロパティ */
    // 画面表示用データ
    public List<AccUrikake> accUrikakeList{get; set;}
    
    //ページ側絞込文字列値
    public String RefineString { get; set; }

    //ページ側絞込数値
    public String RefineValue { get; set; }
    
    //ページ側絞込日付
    public String RefineDate { get; set; }
    
    //ページ側先払フラグ値
    public Boolean SakiBarai { get; set; }

    //ページ側都度フラグ値
    public Boolean TsudoBarai { get; set; }

    //ページ側締めフラグ値
    public Boolean ShimeBarai { get; set; }

    //ページ側充当フラグ値
    public Boolean JutoTaisho { get; set; }

    //ページ側督促フラグ値
    public Boolean TokusokuTaisho { get; set; }

    //保存ボタン表示フラグ値
    public Boolean SaveOk { get; set; }

    // コンストラクタ
    public N07_NyukinIkkatsuTourokuController(){
        
    }
    
    /**
     * 画面描画時処理
     */
    public pageReference init(){

        //処理対象の取引先一覧
        List<Account> accList = new List<Account>();
        //絞込検索用の文字列
        String likeStringSearchKey;

        // 名称マルチ検索が空白であれば取引先を全件取得
        if(RefineString == null){
            accList = [SELECT 
                       Id, Name, MinyukinZandakaSokei__c, SeishikiMeisho__c, 
                       NyukinSaidaiGaku__c, NyukinSaishoGaku__c, NyukinZengaku__c, 
                       TokusokuFlg__c, MikakuteiJutoFlg__c
                       FROM Account
                       WHERE SeikyuTaishoFlg__c = true
                       ORDER BY Name ASC LIMIT :limitQueryRows];            
        //名称マルチ検索が入力済ならば取引先を絞込取得
        }else{
            likeStringSearchKey = '%' + RefineString + '%';
            accList = [SELECT 
                       Id, Name, MinyukinZandakaSokei__c, SeishikiMeisho__c, 
                       NyukinSaidaiGaku__c, NyukinSaishoGaku__c, NyukinZengaku__c, 
                       TokusokuFlg__c, MikakuteiJutoFlg__c, 
                       MeishoMaruchiKensaku__c 
                       FROM Account
                       WHERE MeishoMaruchiKensaku__c LIKE: likeStringSearchKey
                       AND SeikyuTaishoFlg__c = true
                       ORDER BY Name ASC LIMIT :limitQueryRows];                        
        }

        // 取得した取引先一覧から処理対象のIDのリストに絞込
        List<Id> accIdList = new List<Id>();
        for(Account acc :accList){
            //督促対象かつ充当対象の場合
            if(TokusokuTaisho && JutoTaisho){
                if(acc.TokusokuFlg__c && acc.MikakuteiJutoFlg__c){
                    //処理対象の取引先としてID追加
                    accIdList.add(acc.Id);
                }
            }
            //督促対象の場合
            else if(TokusokuTaisho){
                if(acc.TokusokuFlg__c){
                    //処理対象の取引先としてID追加
                    accIdList.add(acc.Id);
                }
            }
            //充当対象の場合
            else if(JutoTaisho){
                if(acc.MikakuteiJutoFlg__c){
                    //処理対象の取引先としてID追加
                    accIdList.add(acc.Id);
                }
            }
            //絞り込まない（督促でも充当でもない）場合
            else if(!TokusokuTaisho && !JutoTaisho){
                //処理対象の取引先としてID追加
                accIdList.add(acc.Id);
            }
        }

        //処理対象の売掛データ一覧
        List<UrikakeData__c> urikakeFullList = new List<UrikakeData__c>();
        //金額絞込検索用の文字列
        String likeValueSearchKey;
        //期日絞込検索用の文字列
        String likeDateSearchKey;

        // 金額と期日マルチ検索が両方入力済であれば消込対象フラグtrueの売掛データを絞込取得
        if( RefineValue.length() > 0 && RefineDate.length() > 0 ){
            likeValueSearchKey = '%' + RefineValue+ '%';
            likeDateSearchKey = '%' + RefineDate+ '%';
            urikakeFullList = [SELECT 
                               Id, Name, UriageKeijoTsuki__c, SeikyuKaishuKigen__c, 
                               SaikenMihasseiFlg__c, MikomiMikaishuZandaka__c, 
                               SeikyuAccount__c, SeikyuJoken__c, ShimeKikanKara__c, ShimeKikanMade__c, SaishuSeikyuKingaku__c, MikomiKaishuNebikiGaku__c, TsudoSeikyuFlg__c, TokusokuAlertFlg__c , KingakuMaruchiKensaku__c, HizukeMaruchiKensaku__c
                               FROM UrikakeData__c 
                               WHERE KingakuMaruchiKensaku__c LIKE: likeValueSearchKey
                               AND HizukeMaruchiKensaku__c LIKE: likeDateSearchKey
                               AND SeikyuAccount__c IN :accIdList 
                               AND KeshikomiTaishoFlg__c = true
                               ORDER BY SeikyuKaishuKigen__c ASC, ShimeKikanKara__c ASC, ShimeKikanMade__c ASC LIMIT :limitQueryRows];
        // 金額マルチ検索が入力済ならば消込対象フラグtrueの売掛データを絞込取得
        }else if( RefineValue.length() > 0 && RefineDate.length() == 0 ){
            likeValueSearchKey = '%' + RefineValue+ '%';
            urikakeFullList = [SELECT 
                               Id, Name, UriageKeijoTsuki__c, SeikyuKaishuKigen__c, 
                               SaikenMihasseiFlg__c, MikomiMikaishuZandaka__c, 
                               SeikyuAccount__c, SeikyuJoken__c, ShimeKikanKara__c, ShimeKikanMade__c, SaishuSeikyuKingaku__c, MikomiKaishuNebikiGaku__c, TsudoSeikyuFlg__c, TokusokuAlertFlg__c, KingakuMaruchiKensaku__c, HizukeMaruchiKensaku__c
                               FROM UrikakeData__c 
                               WHERE KingakuMaruchiKensaku__c LIKE: likeValueSearchKey
                               AND SeikyuAccount__c IN :accIdList 
                               AND KeshikomiTaishoFlg__c = true
                               ORDER BY SeikyuKaishuKigen__c ASC, ShimeKikanKara__c ASC, ShimeKikanMade__c ASC LIMIT :limitQueryRows];
        // 期日マルチ検索が入力済ならば消込対象フラグtrueの売掛データを絞込取得
        }else if( RefineValue.length() == 0 && RefineDate.length() > 0 ){
            likeDateSearchKey = '%' + RefineDate+ '%';
            urikakeFullList = [SELECT 
                               Id, Name, UriageKeijoTsuki__c, SeikyuKaishuKigen__c, 
                               SaikenMihasseiFlg__c, MikomiMikaishuZandaka__c, 
                               SeikyuAccount__c, SeikyuJoken__c, ShimeKikanKara__c, ShimeKikanMade__c, SaishuSeikyuKingaku__c, MikomiKaishuNebikiGaku__c, TsudoSeikyuFlg__c, TokusokuAlertFlg__c, KingakuMaruchiKensaku__c, HizukeMaruchiKensaku__c
                               FROM UrikakeData__c 
                               WHERE HizukeMaruchiKensaku__c LIKE: likeDateSearchKey
                               AND SeikyuAccount__c IN :accIdList 
                               AND KeshikomiTaishoFlg__c = true
                               ORDER BY SeikyuKaishuKigen__c ASC, ShimeKikanKara__c ASC, ShimeKikanMade__c ASC LIMIT :limitQueryRows];
        // 金額と期日マルチ検索が両方空白（入力が無い）であれば消込対象フラグtrueの売掛データを全件取得
        }else{
            urikakeFullList = [SELECT 
                               Id, Name, UriageKeijoTsuki__c, SeikyuKaishuKigen__c, 
                               SaikenMihasseiFlg__c, MikomiMikaishuZandaka__c, 
                               SeikyuAccount__c, SeikyuJoken__c, ShimeKikanKara__c, ShimeKikanMade__c, SaishuSeikyuKingaku__c, MikomiKaishuNebikiGaku__c, TsudoSeikyuFlg__c, TokusokuAlertFlg__c, KingakuMaruchiKensaku__c, HizukeMaruchiKensaku__c
                               FROM UrikakeData__c 
                               WHERE SeikyuAccount__c IN :accIdList 
                               AND KeshikomiTaishoFlg__c = true
                               ORDER BY SeikyuKaishuKigen__c ASC, ShimeKikanKara__c ASC, ShimeKikanMade__c ASC LIMIT :limitQueryRows];
        }

        // 売掛データのIdのリストを作成
        List<Id> urikakeIdList = new List<Id>();

        // 売掛データのリストを作成
        List<UrikakeData__c> urikakeList = new List<UrikakeData__c>();

        // 売掛データの絞込リストを作成
        List<UrikakeData__c> urikakeRefineList = new List<UrikakeData__c>();

        // 売掛データを順に処理し督促の絞込を適用
        for(UrikakeData__c urikakeFull :urikakeFullList){
            //督促に絞る場合
            if(TokusokuTaisho){
                if(urikakeFull.TokusokuAlertFlg__c){
                    urikakeRefineList.add(urikakeFull);
                }
            }
            //絞らない場合
            else{
                urikakeRefineList.add(urikakeFull);
            }
        }

        // 売掛データを順に処理し先払/都度/締の絞込を適用
        for(UrikakeData__c urikakeRefine :urikakeRefineList){

            //全件
            if(!ShimeBarai && !TsudoBarai && !SakiBarai){
                urikakeIdList.add(urikakeRefine.Id);
                urikakeList.add(urikakeRefine);
            }
            //締払
            else if(ShimeBarai){
                if(!urikakeRefine.TsudoSeikyuFlg__c){
		            urikakeIdList.add(urikakeRefine.Id);
		            urikakeList.add(urikakeRefine);
                }
            }
            //都度先払
            else if(TsudoBarai && SakiBarai){
                if(urikakeRefine.TsudoSeikyuFlg__c && urikakeRefine.SaikenMihasseiFlg__c){
                    urikakeIdList.add(urikakeRefine.Id);
                    urikakeList.add(urikakeRefine);
                }
            }
            //都度
            else if(TsudoBarai){
                if(urikakeRefine.TsudoSeikyuFlg__c){
		            urikakeIdList.add(urikakeRefine.Id);
		            urikakeList.add(urikakeRefine);
                }
            }
            //その他全件
            else{
                urikakeIdList.add(urikakeRefine.Id);
                urikakeList.add(urikakeRefine);                
            }
        }

        // 消込データを取得
        List<KeshikomiData__c>keshikomiList = 
            [SELECT Id, SokuKeshikomi__c, KeshikomiKingaku__c, KeshikomiKakuninbi__c, Biko__c, UrikakeData__c
             FROM KeshikomiData__c
             WHERE UrikakeData__c IN :urikakeIdList
             ORDER BY KeshikomiKakuninbi__c,Biko__c,KeshikomiKingaku__c  DESC LIMIT :limitQueryRows];
        
        accUrikakeList = new List<AccUrikake>();

        List<AccUrikake> tmpAccUrikakeList = new List<AccUrikake>();
        
        for(Account accItem :accList){
            // 取引先　一時保存変数
            AccUrikake tmpAU = new AccUrikake();
            tmpAU.acc = accItem;
            // 取引先毎の売掛のリスト
            List<UrikakeKeshikomi> UNList = new List<UrikakeKeshikomi>();
            // 取得した売掛データを全てまわす。
            for(UrikakeData__c urikakeItem :urikakeList){
                // 取引先が一致する
                if((accItem.Id).equals(urikakeItem.SeikyuAccount__c)){
                    UrikakeKeshikomi tmpUN = new UrikakeKeshikomi();
                    tmpUN.urikake = urikakeItem;
                    // 売掛毎の消込データのリスト
                    List<KeshikomiData__c> tmpKeshikomiList = new List<KeshikomiData__c>();
                    // 取得した消込データ全てをまわす。
                    for(KeshikomiData__c keshikomiItem :keshikomiList){
                        // 売掛データが一致する。
                        if((urikakeItem.Id).equals(keshikomiItem.UrikakeData__c)){
                            // 消込データのリストを作成
                            tmpKeshikomiList.add(keshikomiItem);
                        }
                    }
                    // 新規登録用の空の消込データを代入
                    tmpKeshikomiList.add(new KeshikomiData__c(KeshikomiKingaku__c = 0, KeshikomiKakuninbi__c = date.today(), Biko__c = '', UrikakeData__c = urikakeItem.Id));
                    tmpUN.keshikomi = tmpKeshikomiList;
                    // 売掛データと消込データリストのリストを作成
                    UNList.add(tmpUN);
                }
                tmpAU.UrikakeKeshikomi = UNList;
            }
            tmpAccUrikakeList.add(tmpAU);
        }
        
        if(!urikakeList.isEmpty()){
            // リストから消込対象=trueの売掛データのみ抽出
            for(AccUrikake item :tmpAccUrikakeList){
                if(item.UrikakeKeshikomi.size() != 0){
                    accUrikakeList.add(item);
                }
            }
        }

        return null;
    }
    
    /**
     * 保存ボタンを押したときの処理
     */
    public pageReference saveButtonAll(){
        //保存処理
        allSave();
        init();
        return null;
    }

    /**
     * 名称・日付・金額絞込ボタンを押したときの処理
     */
    public pageReference initButton(){
        // 画面再描画
        SaveOk = true;
        init();
        return null;
    }

    /**
     * 全件ボタンを押したときの処理
     */
    public pageReference initButtonFull(){
        SaveOk = true;
        RefineString = '';
        RefineValue = '';
        RefineDate = '';
        ShimeBarai = False;
        TsudoBarai = False;
        SakiBarai = False;
        JutoTaisho = False;
        TokusokuTaisho = False;
        init();
        return null;
    }

    /**
     * 充当絞込ボタンを押したときの処理
     */
    public pageReference initButtonJutoTaisho(){
        SaveOk = true;
        JutoTaisho = True;
        init();
        return null;
    }

    /**
     * 督促絞込ボタンを押したときの処理
     */
    public pageReference initButtonTokusokuTaisho(){
        SaveOk = true;
        TokusokuTaisho = True;
        init();
        return null;
    }

    /**
     * 締払絞込ボタンを押したときの処理
     */
    public pageReference initButtonShimeBarai(){
        SaveOk = true;
        ShimeBarai = True;
        TsudoBarai = False;
        SakiBarai = False;
        init();
        return null;
    }

    /**
     * 都度絞込ボタンを押したときの処理
     */
    public pageReference initButtonTsudoBarai(){
        SaveOk = true;
        TsudoBarai = True;
        ShimeBarai = False;
        init();
        return null;
    }

    /**
     * 先払い絞込ボタンを押したときの処理
     */
    public pageReference initButtonSakiBarai(){
        SaveOk = true;
        SakiBarai = True;
        TsudoBarai = True;
        ShimeBarai = False;
        init();
        return null;
    }


    /**
     * 画面の入力内容を保存する処理（全体）
     */
    private void allSave(){
        
        // 更新追加対象消込データリスト
        List<KeshikomiData__c> upsKeshikomiData = new List<KeshikomiData__c>();
        
        if(!accUrikakeList.isEmpty()){
            
            for(AccUrikake accItem :accUrikakeList){
                for(UrikakeKeshikomi urikakeItem :accItem.UrikakeKeshikomi){
                    for(KeshikomiData__c keshikomiItem :urikakeItem.keshikomi){
                        // 消込データの一番下の行の扱い
                        if(keshikomiItem.id == null){
                            // 金額が0以外または消込チェックONの場合のみ追加の対象にする
                            if(keshikomiItem.KeshikomiKingaku__c != 0 || keshikomiItem.SokuKeshikomi__c ){
                                upsKeshikomiData.add(keshikomiItem);
                            }
                        }else{
                            // 一番下の行以外は無条件で更新/追加対象リストに設定
                            upsKeshikomiData.add(keshikomiItem);
                        }
                    }
                }
            }
            
            // 配列が空白でなければアップサート
            if(!upsKeshikomiData.isEmpty()){
                upsert upsKeshikomiData;
            }
            
        }

    }

    /**
     * 売掛データと（消込データのリスト）
     */
    public class UrikakeKeshikomi{
        public UrikakeData__c urikake{get; set;}
        public List<KeshikomiData__c> keshikomi{get; set;}
        
        /** コンストラクタ */
        public UrikakeKeshikomi(){
            urikake = new UrikakeData__c();
            keshikomi = new List<KeshikomiData__c>();
        }
    }

    /**
     * 取引先と（売掛データと（消込データのリスト）のリスト）
     */
    public class AccUrikake{
        public Account acc{get; set;}
        public List<UrikakeKeshikomi> UrikakeKeshikomi{get; set;}
        
        /** コンストラクタ */
        public AccUrikake(){
            acc = new Account(); 
        }
    }
}