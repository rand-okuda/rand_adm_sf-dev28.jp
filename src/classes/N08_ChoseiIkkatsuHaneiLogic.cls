public with sharing class N08_ChoseiIkkatsuHaneiLogic {

    // コンストラクタ
    public N08_ChoseiIkkatsuHaneiLogic(){
        // 何もしない。
    }

    /**
     * 登録後処理
     */
    public void onAfterInsert(UrikakeData__c[] urikakeObjs){
        
        List<KeshikomiData__c> keshikomiDatas = new List<KeshikomiData__c>();

        Set<Id> SeikyuAccounIds = new Set<Id>();
        for (UrikakeData__c urikak :urikakeObjs){
            SeikyuAccounIds.add(urikak.SeikyuAccount__c);
        }
        
        List<NyukinChoseiM__c> nyukinMSTs = new List<NyukinChoseiM__c>();
        nyukinMSTs = [SELECT Id,Account__c FROM NyukinChoseiM__c WHERE Account__c IN :SeikyuAccounIds];

        for(UrikakeData__c  urikakeObj :urikakeObjs) {

            for (NyukinChoseiM__c nyukinMST :nyukinMSTs){

                if (nyukinMST.Account__c == urikakeObj.SeikyuAccount__c){

                    KeshikomiData__c keshikomi = new KeshikomiData__c();
                    keshikomi.NyukinChosei__c = nyukinMST.Id;
                    keshikomi.UrikakeData__c = urikakeObj.Id;
                    keshikomiDatas.add(keshikomi);
                    
                }
                
            }
                                    
        }
        
        //配列が空の場合を考慮
        if(!keshikomiDatas.isEmpty()){
            //配列をインサート
            insert keshikomiDatas;
        }
    }

    public void onAfterUpdate(UrikakeData__c[] urikakeObjs){

		// 抽出用のIDの一覧作成
        Set<String> urikakeDataIDs = new Set<String>();
        for(UrikakeData__c  urikakeObj :urikakeObjs) {
            urikakeDataIDs.add(urikakeObj.Id);
        }

        //更新対象の入金データ一覧を取得
        List<KeshikomiData__c> keshikomiDataExist = [SELECT Id, UrikakeData__c FROM KeshikomiData__c WHERE UrikakeData__c = :urikakeDataIDs];
        
        //配列が空の場合を考慮
        if(!keshikomiDataExist.isEmpty()){
            //配列更新
            update keshikomiDataExist;
        }
        
        
    }

}