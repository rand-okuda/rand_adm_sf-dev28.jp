@isTest
private class Y06_ZaikoControllerExtensionTest {

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

/*
        ApexPages.currentPage().getParameters().put('retUrl', 'XXXXX');
        Y06_ZaikoControllerExtension controller = new Y06_ZaikoControllerExtension();
        controller.init();
*/        
        ApexPages.StandardSetController ssc = new ApexPages.StandardSetController(DataBase.query('select id from ZaikoData__c'));
        ssc.setSelected(zaikoList);
        Y06_ZaikoControllerExtension extension = new Y06_ZaikoControllerExtension(ssc);
        extension.init();

        Test.stopTest();
    }
}