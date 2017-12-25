global class Y02_UpdateShukaMikomiDataBatch implements Database.Batchable<SObject> {

    global database.Querylocator start(Database.BatchableContext inBc) {
        // 更新の対象となる有効な出荷見込データを全件取得
        return Database.getQueryLocator('SELECT Id FROM ShukaMikomiData__c ORDER BY CreatedDate ASC');
    }

    /**
     * バッチ処理実行
     */
    global void execute(Database.BatchableContext inBC, List<SObject> inScope) {
        // update用リスト
        List<ShukaMikomiData__c> updShukaMikomiData = new List<ShukaMikomiData__c>();
        for (SObject item : inScope) {
            updShukaMikomiData.add((ShukaMikomiData__c)item);
        }
        // update実行
        update updShukaMikomiData;

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