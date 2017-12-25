trigger ZaikoDataTrigger on ZaikoData__c (before insert, before update, after insert, after update, before delete, after delete) {

    ZaikoDataTriggerHandler handler = new ZaikoDataTriggerHandler();

    if(Trigger.isInsert && Trigger.isBefore){
        handler.onBeforeInsert(Trigger.new);
    }
    else if(Trigger.isUpdate && Trigger.isBefore){
        handler.onBeforeUpdate(Trigger.old, Trigger.new);
    }
    else if(Trigger.isDelete && Trigger.isBefore){
        handler.onBeforeDelete(Trigger.old);
    } 

}