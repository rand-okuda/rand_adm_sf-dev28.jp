public with sharing class HachuDataTriggerHandler{

    /**
     * コンストラクタ
     */
    public HachuDataTriggerHandler(){
        // 何もしない。
    }
    
    public void onBeforeUpdate(HachuData__c [] oldObjs, HachuData__c [] newObjs){

        K06_HatchuNyukoRendoLogic logic = new K06_HatchuNyukoRendoLogic();
        for(HachuData__c obj :newObjs){
            logic.createZaiko(obj);
        }

    }
    
    public void onBeforeDelete(HachuData__c [] oldObjs){

        K06_HatchuNyukoRendoLogic K06logic = new K06_HatchuNyukoRendoLogic();
        for(HachuData__c obj :oldObjs){
            K06logic.deleteZaiko(obj);
        }

    }

}