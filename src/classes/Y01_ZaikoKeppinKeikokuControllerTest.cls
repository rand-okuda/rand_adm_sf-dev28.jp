@isTest
private class Y01_ZaikoKeppinKeikokuControllerTest {

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
        
        // 在庫データ作成
        List<ZaikoData__c> zaikoList = new List<ZaikoData__c>();
        ZaikoData__c zaiko1 = new ZaikoData__c(ShohinShizaiM__c = shohin1.Id, name='テスト在庫データ1');
        zaikoList.add(zaiko1);
        insert zaikoList;
        
        Test.startTest();
        
        ApexPages.currentPage().getParameters().put('shohinId', shohin1.Id);
        Y01_ZaikoKeppinKeikokuController controller = new Y01_ZaikoKeppinKeikokuController();
        controller.init();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(DataBase.query('select id from ShohinShizaiM__c'));
        Y01_ZaikoKeppinKeikokuController extension = new Y01_ZaikoKeppinKeikokuController(sc);
    }
}