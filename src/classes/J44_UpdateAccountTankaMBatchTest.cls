@isTest
private class J44_UpdateAccountTankaMBatchTest {

    static testMethod void myUnitTest1() {
        // 商品資材作成
        ShohinShizaiM__c shohin1 = new ShohinShizaiM__c(name = 'テスト商品1', ShomiKigenNissu__c = 100);
        insert shohin1;
        
        // 取引先作成
        Account acc1 = new Account(name = '株式会社テスト1', Shimebi__c = 20, Kijitsu__c = 99);
        insert acc1;
        
        // 取引先単価マスタ作成
        AccountTankaM__c tanka1 = new AccountTankaM__c(Account__c = acc1.Id, ShohinShizaiM__c = shohin1.Id, ShomiKigenKakuhoNissu__c = 10);
        insert tanka1;
        
        Test.startTest();
        Database.executeBatch(new J44_UpdateAccountTankaMBatch());
        Test.stopTest();
    }
}