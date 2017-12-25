global class J44_UpdateAccountTankaMBatch implements Database.Batchable<SObject> {

    global database.Querylocator start(Database.BatchableContext inBc) {
        // 更新の対象となる取引先単価マスタを全件取得
        return Database.getQueryLocator('SELECT Id FROM AccountTankaM__c ORDER BY CreatedDate ASC');
    }

    /**
     * バッチ処理実行
     */
    global void execute(Database.BatchableContext inBC, List<SObject> inScope) {
        // update用リスト
        List<AccountTankaM__c> updAccountTankaM = new List<AccountTankaM__c>();
        for (SObject item : inScope) {
            updAccountTankaM.add((AccountTankaM__c)item);
        }
        // update実行
        update updAccountTankaM;

        Id batchId = inBc.getJobId();
        List<AsyncApexJob> asyncApexJobList = new List<AsyncApexJob>();
        asyncApexJobList = [SELECT Id,ParentJobId,Status,JobType,CreatedDate,CompletedDate FROM AsyncApexJob WHERE ParentJobId = :batchId OR Id = :batchId];
        if(!asyncApexJobList.isEmpty()){
            for(AsyncApexJob aaJob :asyncApexJobList){
                System.debug('*** AsyncApexJob = ' + aaJob);
                
            }
        }

    }
    /**
     * バッチ終了処理
     */
    global void finish(Database.BatchableContext inBC) {
        //なにもしない
    }
}