public with sharing class K06_HatchuNyukoRendoLogic {

    //コンストラクタ
    public K06_HatchuNyukoRendoLogic(){
        // なにもしない。
    }

    //在庫データを作成する処理
    public void createZaiko(HachuData__c obj){
        // 発注確定フラグtrueの場合に処理を実行
        if(obj.HachuKakuteiFlg__c){
            //発注データに紐付く発注明細データを取得
            List<HachuMeisaiData__c> meisaiList = new List<HachuMeisaiData__c>();
            // 発注明細データと紐付く在庫データがあれば取得
            meisaiList = [SELECT Id, ShohinShizaiM__c, HachuSuryoPC__c, NohinYoteibi__c, Biko__c, (SELECT Id FROM ZaikoData_HachuMeisai__r) FROM HachuMeisaiData__c WHERE HachuData__c = :obj.Id];

            for(HachuMeisaiData__c item :meisaiList){
                // 紐付く在庫データが存在しない
                if((item.ZaikoData_HachuMeisai__r).isEmpty()){
                    ZaikoData__c insZaiko = new ZaikoData__c();
                    insZaiko.HachuMeisai__c = item.Id;
                    insZaiko.Zaikobasho__c = obj.Nohinsaki__c;
                    insZaiko.ShukkoFlg__c = true;
                    insZaiko.ShohinShizaiM__c = item.ShohinShizaiM__c;
                    
                    insZaiko.ZenShukkoSuryo__c = item.HachuSuryoPC__c;
                    if(item.NohinYoteibi__c != null){
                        Time tmpTime = Time.newInstance(0, 0, 0, 0);
                        insZaiko.ZenShukkoNichiji__c = DateTime.newInstance(item.NohinYoteibi__c, tmpTime);
                        insZaiko.NyukoNichiji__c = DateTime.newInstance(item.NohinYoteibi__c, tmpTime);
                    }
                    insZaiko.NyukoSuryo__c = item.HachuSuryoPC__c;
                    insZaiko.Biko__c = item.Biko__c;
                    
                    insert insZaiko;
                }
            }
        }
    }
    
    /**
     * 発注データを削除した際に発注明細に紐づく在庫データを削除する処理
     */
    public void deleteZaiko(HachuData__c obj){

        //発注データに紐付く発注明細データを取得
        List<HachuMeisaiData__c> meisaiList = new List<HachuMeisaiData__c>();

        // 発注明細データと紐付く在庫データがあれば取得
        meisaiList = [SELECT Id, ShohinShizaiM__c, (SELECT Id FROM ZaikoData_HachuMeisai__r) FROM HachuMeisaiData__c WHERE HachuData__c = :obj.Id];

        List<ZaikoData__c> deleteZaikoList = new List<ZaikoData__c>();
        for(HachuMeisaiData__c item :meisaiList){
            for(ZaikoData__c zaikoItem :item.ZaikoData_HachuMeisai__r){
                deleteZaikoList.add(zaikoItem);
            }
        }

        if(!deleteZaikoList.isEmpty()){
            delete deleteZaikoLIst;
        }

    }

}