global class J06_ShukkoRendoScheduler implements Schedulable {

    global void execute(SchedulableContext inSc){

        // バッチサイズを指定
        Integer batchSize = 1;
       
        J06_ShukkoRendoBatch batch = new J06_ShukkoRendoBatch();
        Database.executeBatch(batch, batchSize);
    }

}