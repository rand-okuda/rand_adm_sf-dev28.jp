@isTest
private class J44_AccountTankaMControllerExtentionTest {
    static testMethod void myUnitTest1() {
        // 商品資材作成
        ShohinShizaiM__c shohin1 = new ShohinShizaiM__c(name = 'テスト商品1', ShomiKigenNissu__c = 100);
        insert shohin1;
        
        // 取引先作成
        List<Account> accList = new List<Account>();
        accList.add(new Account(name = '株式会社テスト1', Shimebi__c = 20, Kijitsu__c = 99));
        insert accList;
        
        // 取引先単価マスタ作成
        List<AccountTankaM__c> tankaList = new List<AccountTankaM__c>();
        tankaList.add(new AccountTankaM__c(Account__c = accList[0].Id, ShohinShizaiM__c = shohin1.Id, ShomiKigenKakuhoNissu__c = 10));
        insert tankaList; 
        
        Test.startTest();
        
        ApexPages.StandardSetController ssc = new ApexPages.StandardSetController(DataBase.query('select id from AccountTankaM__c'));
        ssc.setSelected(tankaList);
        J44_AccountTankaMControllerExtension extension = new J44_AccountTankaMControllerExtension(ssc);

        //ApexPages.currentPage().getParameters().put('retUrl', 'hogehoge');
        //J44_AccountTankaMControllerExtention controller = new J44_AccountTankaMControllerExtention();
        //controller.init();
        extension.init();
        
        Test.stopTest();
    }
}