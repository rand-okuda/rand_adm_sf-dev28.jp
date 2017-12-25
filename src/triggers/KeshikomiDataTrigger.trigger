trigger KeshikomiDataTrigger on KeshikomiData__c (before insert, before update, after insert, after update, before delete, after delete) {

    List<KeshikomiData__c> kekoList = Trigger.new;

    KeshikomiDataTriggerHandler handler = new KeshikomiDataTriggerHandler();

    if(Trigger.isUpdate && Trigger.isAfter){
        handler.onAfterUpdate(kekoList);
    }

}