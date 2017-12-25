trigger JuchuMeisaiDataTrigger on JuchuMeisaiData__c (before insert, before update, after insert, after update, before delete, after delete) {

    JuchuMeisaiDataTriggerHandler handler = new JuchuMeisaiDataTriggerHandler();
    
    if(Trigger.isInsert && Trigger.isAfter){
        handler.onAfterInsert(Trigger.new, Trigger.newMap.keySet(), Trigger.newMap);
    }
    else if(Trigger.isUpdate && Trigger.isAfter){
        handler.onAfterUpdate(Trigger.old, Trigger.new, Trigger.newMap.keySet(), Trigger.oldMap, Trigger.newMap);
    }
    else if(Trigger.isDelete && Trigger.isBefore){
        handler.onBeforeDelete(Trigger.oldMap.keySet());
    }

}