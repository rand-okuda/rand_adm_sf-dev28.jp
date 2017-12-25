@isTest
private class J06_ShukkoRendoBatchSchedulerTest{
    static testMethod void myUnitTest1() {
        // カスタム設定
        SystemParam__c sysCon = SystemParam__c.getOrgDefaults();
        sysCon.JuchuMeisaiSaidaiTorokusu__c = 45;
        insert sysCon;
                
        // 取引先作成
        List<Account> accList = new List<Account>();
        accList.add(new Account(name = '株式会社テストJ06', Type = '納品先'));
        insert accList;
        
        // 売掛データ作成
        List<UrikakeData__c> urikakeList = new List<UrikakeData__c>();
        urikakeList.add(new UrikakeData__c(name = '売掛データテストJ06', SeikyuAccount__c = accList[0].Id));
        insert urikakeList;
        
        // 受注データ作成
        List<JuchuData__c> juchuList = new List<JuchuData__c>();

        juchuList.add(new JuchuData__c(
            name = '受注データテストJ06', 
            UrikakeData__c = urikakeList[0].Id,
            JuchuKakuteiFlg__c = FALSE,
            HikiateKanryoFlg__c = FALSE,
            JidoHikiateFlg__c = TRUE,
            ZaikoHikiateSaki__c = accList[0].Id,
            JidoHikiateYoyaku__c = Date.today().addDays(1),
            NohinYoteibi__c = Date.today().addDays(10),
            LotKonzaiFlg__c = TRUE));

        insert juchuList;

        Test.startTest();
        String jobId = System.schedule('Test J06_ShukkoRendoBatchScheduler', '0 0 * * * ?', new J06_ShukkoRendoScheduler());
        Test.stopTest();
    }
}