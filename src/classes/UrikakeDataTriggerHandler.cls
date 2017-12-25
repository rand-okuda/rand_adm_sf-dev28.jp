public with sharing class UrikakeDataTriggerHandler {

    /**
     * コンストラクタ
     */
    public UrikakeDataTriggerHandler(){
        // 何もしない。
    }

    public void onAfterInsert(UrikakeData__c[] urikakeObjs){
        N08_ChoseiIkkatsuHaneiLogic logic = new N08_ChoseiIkkatsuHaneiLogic();
        logic.onAfterInsert(urikakeObjs);
    }

    public void onAfterUpdate(UrikakeData__c[] urikakeObjs){
        N08_ChoseiIkkatsuHaneiLogic logic = new N08_ChoseiIkkatsuHaneiLogic();
        logic.onAfterUpdate(urikakeObjs);
    }

}