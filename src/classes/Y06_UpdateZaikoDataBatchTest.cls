@isTest
private class Y06_UpdateZaikoDataBatchTest {

    static testMethod void myUnitTest1() {
        // 商品資材作成
        List<ShohinShizaiM__c> shohinList = new List<ShohinShizaiM__c>();
        ShohinShizaiM__c shohin1 = new ShohinShizaiM__c(name = 'テスト商品1');
        shohinList.add(shohin1);
        insert shohinList;
        
        // 出荷見込みデータ作成
        List<ZaikoData__c> zaikoList = new List<ZaikoData__c>();
        ZaikoData__c zaiko1 = new ZaikoData__c(ShohinShizaiM__c = shohin1.Id, name='テスト在庫データ1');
        zaikoList.add(zaiko1);
        insert zaikoList;
        
        Test.startTest();
        Database.executeBatch(new Y06_UpdateZaikoDataBatch());
        Test.stopTest();
    }
}