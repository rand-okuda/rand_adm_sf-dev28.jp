@isTest
private class J49_ZaikoIdouTorikesiLogicTest {

    static testMethod void myUnitTest1() {
        // 商品資材作成
        ShohinShizaiM__c shohin1 = new ShohinShizaiM__c(name = 'テスト商品1', ShomiKigenNissu__c = 100);
        insert shohin1;
        
        // 在庫データ作成
        ZaikoData__c zaiko1 = new ZaikoData__c(ZaikoSuryo__c = 10, name = 'a', ShohinShizaiM__c = shohin1.Id, ShomiKigen__c = Date.newInstance(2016, 1, 1), NyukoFlg__c = true);
        insert zaiko1;
        ZaikoData__c zaiko2 = new ZaikoData__c(zenZaikoData__c = zaiko1.Id, NyukoSuryo__c = 10, name = 'a', ShohinShizaiM__c = shohin1.Id, ShomiKigen__c = Date.newInstance(2016, 1, 1), NyukoFlg__c = false);
        insert zaiko2;
        
        zaiko2.ZenShukkoNichiji__c = Date.today();
        zaiko2.ShukkoFlg__c = true;
        zaiko2.ZenShukkoSuryo__c = 1;
        update zaiko2;

        ZaikoData__c zaiko3 = new ZaikoData__c();
        zaiko3 = [SELECT Id, IdouTorikesiFlg__c, ZenZaikoData__c , ZenShukkoNichiji__c , ShukkoFlg__c, ZenShukkoSuryo__c FROM ZaikoData__c WHERE Id = :zaiko2.Id];
        
        Test.startTest();
        delete zaiko3;
        Test.stopTest();
    }
}