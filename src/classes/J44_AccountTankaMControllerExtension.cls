public with sharing class J44_AccountTankaMControllerExtension {

    public J44_AccountTankaMControllerExtension(ApexPages.StandardSetController controller) {}

    /**
     * リストボタンを押した時に動作する処理
     */
    //public PageReference init(){
    public void init(){

        // バッチサイズを指定
        Integer batchSize = 100;

        // バッチをキックする
        Id batchId = Database.executeBatch(new J44_UpdateAccountTankaMBatch(),batchSize);
        System.debug('*** batchId = ' + batchId);
        //return new PageReference(ApexPages.CurrentPage().getParameters().get('retUrl'));

        List<AsyncApexJob> asyncApexJobList = new List<AsyncApexJob>();
        asyncApexJobList = [SELECT Id,ParentJobId,Status,JobType,CreatedDate,CompletedDate FROM AsyncApexJob WHERE ParentJobId = :batchId OR Id = :batchId];
        if(!asyncApexJobList.isEmpty()){
            for(AsyncApexJob aaJob :asyncApexJobList){
                System.debug('*** AsyncApexJob = ' + aaJob);
                
            }
        }
    }

}