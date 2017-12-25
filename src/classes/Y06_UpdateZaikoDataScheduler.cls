global class Y06_UpdateZaikoDataScheduler implements Schedulable {

    global void execute(SchedulableContext inSc) {
    
        // バッチサイズを指定
        Integer batchSize = 1;
        
        Y06_UpdateZaikoDataBatch batch = new Y06_UpdateZaikoDataBatch();
        Database.executeBatch(batch, batchSize);
        
    }
}