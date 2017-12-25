trigger JuchuDataTrigger on JuchuData__c (before insert, before update, after insert, after update, before delete, after delete) {

    JuchuDataTriggerHandler handler = new JuchuDataTriggerHandler();

    if(Trigger.isUpdate && Trigger.isBefore){
        handler.onBeforeUpdate(Trigger.old, Trigger.new, Trigger.oldMap, Trigger.newMap);
    }
    else if(Trigger.isUpdate && Trigger.isAfter){
        handler.onAfterUpdate(Trigger.old, Trigger.new, Trigger.newMap);
    }
    else if(Trigger.isDelete && Trigger.isBefore){
        handler.onBeforeDelete(Trigger.oldMap);
    }

}