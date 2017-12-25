@isTest
private class Y02_UpdateShukaMikomiDataBatchTest {

    static testMethod void myUnitTest1() {
        // 商品資材作成
        List<ShohinShizaiM__c> shohinList = new List<ShohinShizaiM__c>();
        ShohinShizaiM__c shohin1 = new ShohinShizaiM__c(name = 'テスト商品1');
        shohinList.add(shohin1);
        insert shohinList;
        
        // 出荷見込みデータ作成
        List<ShukaMikomiData__c> shukaList = new List<ShukaMikomiData__c>();
        ShukaMikomiData__c shuka1 = new ShukaMikomiData__c(ShohinShizaiM__c = shohin1.Id, MotoHizuke__c = Date.today());
        shukaList.add(shuka1);
        insert shukaList;
        
        Test.startTest();
        Database.executeBatch(new Y02_UpdateShukaMikomiDataBatch());
        Test.stopTest();
    }
}