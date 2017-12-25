public with sharing class K08_NyukoShiharaiRendoLogic {

    // 買掛データ一覧
    public List<KaikakeData__c> kaikakeList;
    // 支払明細データ一覧
    List<ShiharaiMeisaiData__c> insShiharaiMeisaiList;
    // 作成対象在庫データ一覧
    List<ZaikoData__c> zaikoDataList;
    // 対象外在庫データ一覧
    List<ZaikoData__c> excludZaikoDataList;

    //現在のガバナリミットSystem.limits.getLimitQueryRowsを取得する。
    Integer limitQueryRows;

    // 在庫データの発注明細の発注データの仕入先Id一覧
    Set<Id> ShiiresakiIds;

    // コンストラクタ
    public K08_NyukoShiharaiRendoLogic(){
        // 何もしない
    }
    
    /**
     * 支払明細データを作成する処理
     */
    public void createShiharaiMeisai(List<ZaikoData__c> TriggerNew){

        //現在のガバナリミットSystem.limits.getLimitQueryRowsを取得する。
	    limitQueryRows = System.limits.getLimitQueryRows();

        // 作成対象在庫データ一覧を作成
        zaikoDataList = new List<ZaikoData__c>();
        // 対象外在庫データ一覧を作成
        excludZaikoDataList = new List<ZaikoData__c>();        

        // トリガーからの一覧を順に処理
        for(ZaikoData__c trgNew:TriggerNew){
            // 入庫支払フラグがTRUEの場合
            if (trgNew.NyukoShiharaiFlg__c){
                // 作成対象に追加
                zaikoDataList.add(trgNew);
            }
            // 入庫支払取消フラグがTRUEの場合
            if (trgNew.NyukoShiharaiTorikeshiFlg__c){
                // 支払明細削除対象に追加
                excludZaikoDataList.add(trgNew);
            }
        }

        // 支払明細削除対象が存在する場合
        if (!excludZaikoDataList.isEmpty()){
            // 支払明細を削除
            deleteShiharaiMeisai(excludZaikoDataList);            
        }

        // 支払明細作成対象が存在する場合
        if (!zaikoDataList.isEmpty()){
            
            // 在庫データの発注明細の発注データの仕入先Id一覧を作成
            ShiiresakiIds = new Set<Id>();
            for (ZaikoData__c zaiko :zaikoDataList){
                // 仕入先Idを一覧に追加
                ShiiresakiIds.add(zaiko.ShiiresakiShokai__c);
                
                system.debug('*** ShiiresakiId:' + zaiko.ShiiresakiShokai__c);
                
            }
            
            // 買掛データを重複せず新たに作成
            dedupKaikakeData(zaikoDataList);
            
            // 在庫データに関係する仕入先の新たに作成した買掛データも含め一覧を取得（最近作成された1000件）
            kaikakeList = [SELECT Id, ShimeKikanKara__c, ShimeKikanMade__c, Shiiresaki__c FROM KaikakeData__c 
                           WHERE Shiiresaki__c IN :ShiiresakiIds 
                           ORDER BY CreatedDate,LastModifiedDate 
                           LIMIT :limitQueryRows
                          ];
            
            // インサート用支払明細データ一覧作成
            insShiharaiMeisaiList = new List<ShiharaiMeisaiData__c>();
            
            // 在庫データを順に処理
            for (ZaikoData__c zaiko :zaikoDataList){
                
                system.debug('*** zaiko:' + zaiko);
                
                // 買掛データを順に処理
                for (KaikakeData__c kaikake :kaikakeList){
                    // 仕入先が一致しかつ入庫日時が該当仕入先の買掛データの締期間内の場合
                    if ( kaikake.Shiiresaki__c == zaiko.ShiiresakiShokai__c && kaikake.ShimeKikanKara__c <= Date.valueOf(zaiko.NyukoNichiji__c.format('yyyy-MM-dd hh:mm:ss')) &&  kaikake.ShimeKikanMade__c >= Date.valueOf(zaiko.NyukoNichiji__c.format('yyyy-MM-dd hh:mm:ss')) ){
                        // 買掛データに関連した支払明細データを新たに作成
                        createShiharaiMeisai(zaiko, kaikake);
                    }
                    
                }
                
            }
            
            // 支払明細データ一覧をインサート
            insert insShiharaiMeisaiList;
            
            // インサート済支払明細データ一覧を順に処理
            for (ShiharaiMeisaiData__c insShiharaiMeisai :insShiharaiMeisaiList){
                
                system.debug('*** insShiharaiMeisai:' + insShiharaiMeisai);
                
                // 在庫データを順に処理
                for (ZaikoData__c zaiko :zaikoDataList){
                    // 発注明細Idが一致した場合
                    if (zaiko.HachuMeisai__c == insShiharaiMeisai.HachuMeisaiData__c){
                        // 新たに作成した支払明細データを入出庫データに設定
                        zaiko.ShiharaiMeisai__c = insShiharaiMeisai.Id;
                    }
                    
                    system.debug('*** zaiko:' + zaiko);
                    
                }
            }

        }

    }

    /**
     * 買掛データの重複を排除する処理
     */
    public void dedupKaikakeData(List<ZaikoData__c> zaikoDataList){

        // フラグ初期化
        Boolean isNotDup = TRUE;

        // 既存買掛データ一覧を作成
        List<KaikakeData__c> existkaiKakeList = new List<KaikakeData__c>();

        // 在庫データを順に処理
        for (ZaikoData__c zaiko :zaikoDataList){

            // 重複無く買掛データがインサートされた場合（及び初回のループ）
            if (isNotDup){

                // 在庫データに関係する仕入先の既存の買掛データ一覧を取得（最近作成された1000件）「INSERT後のSELECTが必要なためfor()内でSELECT実行」
                existKaikakeList = [SELECT Id, ShimeKikanKara__c, ShimeKikanMade__c, Shiiresaki__c FROM KaikakeData__c 
                                    WHERE Shiiresaki__c IN :ShiiresakiIds 
                                    ORDER BY CreatedDate,LastModifiedDate 
                                    LIMIT :limitQueryRows
                                   ];
 
                System.debug('*** existKaikakeList:' + existKaikakeList);
                
            }

            // 既存の買掛データが取得されなかった場合
            if (existKaikakeList.isEmpty()){
                // 既存が無いため作成対象
                isNotDup = TRUE;
            }else{
                // 既存の買掛データが存在した場合　順に処理
                for(KaikakeData__c existKaikake :existKaikakeList){
                    // 該当の支払先で該当期間の入庫日時の場合
                    if (existkaikake.Shiiresaki__c == zaiko.ShiiresakiShokai__c && existkaikake.ShimeKikanKara__c <= Date.valueOf(zaiko.NyukoNichiji__c.format('yyyy-MM-dd hh:mm:ss')) &&  existkaikake.ShimeKikanMade__c >= Date.valueOf(zaiko.NyukoNichiji__c.format('yyyy-MM-dd hh:mm:ss'))){
                        // 既存のため対象外
                        isNotDup = FALSE;
                        // 以降の処理を中断
                        break;
                    }else{
                        // 既存が無いため作成対象
                        isNotDup = TRUE;
                    }
                }
            }

            // 重複しない買掛データの場合
            if(isNotDup){
                // 買掛データを作成
                createKaikakeData(zaiko);
            }

        }
    }

    /**
     * 買掛データを作成する処理
     */
    public void createKaikakeData(ZaikoData__c zaiko){

        // 新たに買掛データを作成
        KaikakeData__c insKaikake = new KaikakeData__c();
        insKaikake.Name = 'Name';
        insKaikake.Shiiresaki__c = zaiko.ShiiresakiShokai__c;
        insKaikake.ShimeHizuke__c = Date.valueOf(zaiko.NyukoNichiji__c.format('yyyy-MM-dd hh:mm:ss'));

        // 買掛データをインサート
        insert insKaikake;

        System.debug('*** insKaikake:' + insKaikake);
        
    }

    /**
     * 支払明細データを作成する処理
     */
    public void createShiharaiMeisai(ZaikoData__c zaiko, KaikakeData__c kaikake){

        // 支払明細データを新たに作成
        ShiharaiMeisaiData__c insShiharaiMeisai = new ShiharaiMeisaiData__c();
        insShiharaiMeisai.KaikakeData__c = kaikake.Id;
        insShiharaiMeisai.HachuMeisaiData__c = zaiko.HachuMeisai__c;
        insShiharaiMeisai.NohinSuryo__c = zaiko.NyukoSuryo__c;
        insShiharaiMeisai.Nohinbi__c = Date.valueOf(zaiko.NyukoNichiji__c.format('yyyy-MM-dd hh:mm:ss'));
        insShiharaiMeisaiList.add(insShiharaiMeisai);

        System.debug('*** insShiharaiMeisai:' + insShiharaiMeisai);

    }

    /**
     * 支払明細データを削除する処理
     */
    public void deleteShiharaiMeisai(List<ZaikoData__c> zaikos){
        
        Set<Id> delShiharaiMeisaiIds = new Set<Id>();
        for (ZaikoData__c zaiko :zaikos){
            if (zaiko.NyukoShiharaiTorikeshiFlg__c){
                delShiharaiMeisaiIds.add(zaiko.ShiharaiMeisai__c);
            }
        }

        List<ShiharaiMeisaiData__c> delShiharaiMeisaiList = new List<ShiharaiMeisaiData__c>();
        delShiharaiMeisaiList = [SELECT Id FROM ShiharaiMeisaiData__c 
                                 WHERE Id IN :delShiharaiMeisaiIds 
                                 LIMIT :limitQueryRows
                                ];
        
        System.debug('*** delShiharaiMeisaiList:' + delShiharaiMeisaiList);
        
        if(!delShiharaiMeisaiList.isEmpty()){
            delete delShiharaiMeisaiList;
        }
        
    }

}