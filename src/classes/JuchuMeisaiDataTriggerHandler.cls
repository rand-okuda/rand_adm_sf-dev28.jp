public with sharing class JuchuMeisaiDataTriggerHandler {

    /**
     * コンストラクタ
     */
    public JuchuMeisaiDataTriggerHandler(){
        // 何もしない。
    }
    
    public void onAfterInsert(JuchuMeisaiData__c[] newObjs, Set<Id> juchuMeisaiDataIds, Map<Id, JuchuMeisaiData__c> newMap){

        J05_NohinKakakuRendoLogic logicJ05 = new J05_NohinKakakuRendoLogic();
        logicJ05.setTankaInsert(newMap);

        J07_JuchuYosokuRendoLogic logic = new J07_JuchuYosokuRendoLogic();
        logic.onAfterInsert(newObjs, juchuMeisaiDataIds);

    }
    
    public void onAfterUpdate(JuchuMeisaiData__c[] oldObjs, JuchuMeisaiData__c[] newObjs, Set<Id> juchuMeisaiDataIds, Map<Id, JuchuMeisaiData__c> oldMap , Map<Id, JuchuMeisaiData__c> newMap){

        J05_NohinKakakuRendoLogic logicJ05 = new J05_NohinKakakuRendoLogic();
        logicJ05.setTankaUpdate(oldMap, newMap);

        J07_JuchuYosokuRendoLogic logic = new J07_JuchuYosokuRendoLogic();
        logic.onAfterUpdate(oldObjs,newObjs,juchuMeisaiDataIds);

    }

    public void onBeforeDelete(Set<Id> juchuMeisaiDataIds){

        J07_JuchuYosokuRendoLogic logic = new J07_JuchuYosokuRendoLogic();
        logic.onBeforeDelete(juchuMeisaiDataIds);
        
        J48_JyutyuMeisaiSakujyoZaikoLogic logicJ48 = new J48_JyutyuMeisaiSakujyoZaikoLogic();
        logicJ48.deleteZaikoData(juchuMeisaiDataIds);

    }
    
}