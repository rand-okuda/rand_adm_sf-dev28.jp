@isTest
private class K01_HachushoControllerTest {
    static testMethod void myUnitTest1() {

        //発注書明細最大行数
        insert new SystemParam__c(HachushoMeisaiMaxNum__c = 1);
        
        // 商品資材作成
        List<ShohinShizaiM__c> shohinList = new List<ShohinShizaiM__c>();
        shohinList.add(new ShohinShizaiM__c(name = '商品テスト20150206J22'));
        insert shohinList;
        
        // 取引先作成
        List<Account> accList = new List<Account>();
        accList.add(new Account(name = '株式会社テスト20150206J22', Type = '納品先'));
        insert accList;
        
        // 発注データ作成
        List<HachuData__c> hachuDataList = new List<HachuData__c>();
        hachuDataList .add(new HachuData__c(Nohinsaki__c= accList[0].Id, Biko__c = 'ABCDFFG'));
        insert hachuDataList ;
        
        // 発注明細データ作成
        List<HachuMeisaiData__c> meisaiList = new List<HachuMeisaiData__c>();
        meisaiList .add(new HachuMeisaiData__c(ShohinShizaiM__c= shohinList[0].id, HachuData__c= hachuDataList[0].Id));
        meisaiList .add(new HachuMeisaiData__c(ShohinShizaiM__c= shohinList[0].id, HachuData__c= hachuDataList[0].Id));
        insert meisaiList ;
        
        Test.startTest();
        
        // 発注データIDをURLに設定
        Test.setCurrentPage(Page.K01_Hachusho);   
        ApexPages.currentPage().getParameters().put('HdId', hachuDataList[0].Id);

        K01_HachushoController controller = new K01_HachushoController();
        
        Test.stopTest();
    }
}