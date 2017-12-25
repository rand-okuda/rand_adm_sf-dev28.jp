global class J06_ShukkoRendoBatch implements Database.Batchable<sObject>, Database.Stateful {

    global Database.Querylocator start(Database.BatchableContext inBC) {
        // 受注データを全件取得する
        return Database.getQueryLocator('SELECT Id, HikiateZanjiKaijo__c, JidoHikiateFlg__c, HikiateZanjiKakutei__c, HikiateKanryoFlg__c, JidoHikiateYoyaku__c, NohinYoteibi__c, JuchuUriageKakuteiFlg__c FROM JuchuData__c ORDER BY HikiateZanjiKaijo__c, JidoHikiateFlg__c, HikiateZanjiKakutei__c,NohinYoteibi__c,CreatedDate');
    }

    global void execute(Database.BatchableContext inBC, List<JuchuData__c> inScope) {
        // 更新用受注データリスト作成
        List<JuchuData__c> updJuchuList = new List<JuchuData__c>();
        
        // 前処理から受け取った受注データをループ
        for(JuchuData__c item :inScope){

            //引当スタンバイがONのレコードは引当即時確ONを試行する。スタンバイ予約をOFFにする。
            if( item.JidoHikiateFlg__c){

                system.debug('*** JidoHikiate :' + item.JidoHikiateFlg__c);

                item.MuJokenHikiateFlg__c = true;
                item.JidoHikiateFlg__c = false ;
                item.JuchuKakuteiFlg__c = true;
            }

            //引当非同期確定がONのレコードは引当即時確ONを試行する。引当漸次確定はOFFにする。
            if( item.HikiateZanjiKakutei__c && !item.HikiateZanjiKaijo__c && !item.HikiateKanryoFlg__c){

                system.debug('*** HikiateZanjiKakutei :' + item.HikiateZanjiKakutei__c);

                item.MuJokenHikiateFlg__c = true;
                item.HikiateZanjiKakutei__c = false;
                item.JuchuKakuteiFlg__c = true;
            }

            //引当非同期解除がONのレコードは引当成功完了OFFを実行する。引当非同期解除はOFFにする。納品請求確定フラグもOFFにする。
            if( item.HikiateZanjiKaijo__c && !item.HikiateZanjiKakutei__c && item.HikiateKanryoFlg__c){

                system.debug('*** HikiateZanjiKaijo :' + item.HikiateZanjiKaijo__c);

                item.MuJokenHikiateFlg__c = false;
                item.HikiateZanjiKaijo__c = false ;
                item.HikiateKanryoFlg__c = false ;
                item.JuchuUriageKakuteiFlg__c = false;
            }

            // 更新用受注データListに受注データインスタンスを追加する。
            updJuchuList.add(item);

        }
        
        // 更新用受注データListを更新する。  
        if(!updJuchuList.isEmpty()){
            // 入力規則エラーが発生するため対応
            try{
                update updJuchuList;                
            }catch (System.DmlException e) {
                System.debug('*** updJuchuList DmlException: ' + e);
            }
        }

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
     * 終了処理
     */
    global void finish(Database.BatchableContext inBC) {
    
    }
}