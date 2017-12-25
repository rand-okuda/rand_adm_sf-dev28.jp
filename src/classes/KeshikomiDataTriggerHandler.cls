public with sharing class KeshikomiDataTriggerHandler {

    /**
     * コンストラクタ
     */
    public KeshikomiDataTriggerHandler(){
        // 何もしない。
    }
    
    public void onAfterUpdate(List<KeshikomiData__c> kekoList){

        N17_FumeiNyukinJutoLogic logicN17 = new N17_FumeiNyukinJutoLogic();
        logicN17.fumeiNyukinJuto(kekoList);        

    }
    
}