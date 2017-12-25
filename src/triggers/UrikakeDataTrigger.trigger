trigger UrikakeDataTrigger on UrikakeData__c (before insert, before update, after insert, after update, before delete, after delete) {

    UrikakeDataTriggerHandler handler = new UrikakeDataTriggerHandler();
    
    if(Trigger.isInsert && Trigger.isAfter){
        handler.onAfterInsert(Trigger.new);
    }else if(Trigger.isUpdate && Trigger.isAfter){
        handler.onAfterUpdate(Trigger.new);
    }

}