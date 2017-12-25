@isTest
private class Y02_ShukaMikomiControllerExtensionTest {

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
/*       
        ApexPages.currentPage().getParameters().put('retUrl', 'XXXXXX');
        Y02_ShukaMikomiControllerExtension controller = new Y02_ShukaMikomiControllerExtension();
        controller.init();
*/        
        ApexPages.StandardSetController ssc = new ApexPages.StandardSetController(DataBase.query('select id from ShukaMikomiData__c'));
        Y02_ShukaMikomiControllerExtension extension = new Y02_ShukaMikomiControllerExtension(ssc);
        extension.init();
        
        Test.stopTest();
    }
}