global class J44_UpdateAccountTankaMScheduler implements Schedulable {

    global void execute(SchedulableContext inSc) {
    
        // バッチサイズを指定
        Integer batchSize = 1;
        
        J44_UpdateAccountTankaMBatch uatb = new J44_UpdateAccountTankaMBatch();
        Database.executeBatch(uatb, batchSize);
        
    }
}