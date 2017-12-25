public with sharing class J48_JyutyuMeisaiSakujyoZaikoLogic {

    // コンストラクタ
    public J48_JyutyuMeisaiSakujyoZaikoLogic(){
        // 何もしない。
    }

    public void deleteZaikoData (Set<Id> meisaiIdSet){

        // 削除対象の在庫データのリスト
        List<ZaikoData__c> deleteZaikoDataList = new List<ZaikoData__c>();
        deleteZaikoDataList = [SELECT Id, JuchuMeisai__c FROM ZaikoData__c WHERE JuchuMeisai__c IN :meisaiIdSet];
        
        if(!deleteZaikoDataList.isEmpty()){
            delete deleteZaikoDataList;

        }
    }
}