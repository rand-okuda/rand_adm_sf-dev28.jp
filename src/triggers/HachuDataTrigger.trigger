trigger HachuDataTrigger on HachuData__c (before insert, before update, after insert, after update, before delete, after delete) {

    HachuDataTriggerHandler handler = new HachuDataTriggerHandler();
 
    if(Trigger.isUpdate && Trigger.isBefore){
        handler.onBeforeUpdate(Trigger.old, Trigger.new);
    }
    else if(Trigger.isDelete && Trigger.isBefore){
        handler.onBeforeDelete(Trigger.old);
    } 

}