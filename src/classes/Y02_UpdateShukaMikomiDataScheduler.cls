global class Y02_UpdateShukaMikomiDataScheduler implements Schedulable {

    global void execute(SchedulableContext inSc) {
    
        // バッチサイズを指定
        Integer batchSize = 1;
        
        Y02_UpdateShukaMikomiDataBatch usmdb = new Y02_UpdateShukaMikomiDataBatch();
        Database.executeBatch(usmdb, batchSize);
        
    }
}