public with sharing class J46_JyutyuSakujyoZaikoLogic {

    // コンストラクタ
    public J46_JyutyuSakujyoZaikoLogic(){
        // 何もしない。
    }
    
    public void deleteJuchuMeisai(set<Id> JuchuIdSet){

        // 削除対象の受注明細データのリスト
        List<JuchuMeisaiData__c> deleteJuchuMeisaiDataList = new List<JuchuMeisaiData__c>();
        deleteJuchuMeisaiDataList = [SELECT Id, JuchuData__c FROM JuchuMeisaiData__c WHERE JuchuData__c IN :JuchuIdSet];
        
        if(!deleteJuchuMeisaiDataList.isEmpty()){
            delete deleteJuchuMeisaiDataList;
        }

    }

}