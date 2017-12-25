global class Y06_UpdateZaikoDataBatch implements Database.Batchable<SObject> {

    global database.Querylocator start(Database.BatchableContext inBc) {
        // 更新の対象となる有効な出荷見込データを最近作成された物から取得
        return Database.getQueryLocator('SELECT Id FROM ZaikoData__c  ORDER BY CreatedDate ASC');
    }

    /**
     * バッチ処理実行
     */
    global void execute(Database.BatchableContext inBc, List<SObject> inScope) {
        // update用リスト
        List<ZaikoData__c> updZaikoData = new List<ZaikoData__c>();
        for (SObject item : inScope) {
            updZaikoData.add((ZaikoData__c)item);
        }
        // update実行
        update updZaikoData;

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
    global void finish(Database.BatchableContext inBc) {
        //なにもしない
    }
}