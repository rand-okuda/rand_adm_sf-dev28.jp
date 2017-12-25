public with sharing class ZaikoDataTriggerHandler {

    // コンストラクタ
    public ZaikoDataTriggerHandler(){
        // 何もしない。
    }
    
    public void onBeforeInsert(ZaikoData__c [] newObjs){

        J41_DenpyoShutsuryokuShienLogic logicJ41 = new J41_DenpyoShutsuryokuShienLogic();
        logicJ41.setJuchuId(newObjs);

    }
    
    public void onBeforeUpdate(ZaikoData__c [] oldObjs, ZaikoData__c [] newObjs){

        K08_NyukoShiharaiRendoLogic logicK08 = new K08_NyukoShiharaiRendoLogic();
        logicK08.createShiharaiMeisai(newObjs);

    }
    
    public void onBeforeDelete(ZaikoData__c [] oldObjs){
        
        J49_ZaikoIdouTorikesiLogic logicJ49 = new J49_ZaikoIdouTorikesiLogic();
        logicJ49.henkyakuZaikoSuryo(oldObjs);
        
    }
    
}