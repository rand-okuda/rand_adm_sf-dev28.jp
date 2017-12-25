@isTest
private class J06_JuchuControllerExtensionTest {

    static testMethod void myUnitTest1() {
        // 取引先作成
        List<Account> accList = new List<Account>();
        accList.add(new Account(name = '株式会社テストJ06', Type = '納品先'));
        insert accList;
        
        // 売掛データ作成
        List<UrikakeData__c> urikakeList = new List<UrikakeData__c>();
        urikakeList.add(new UrikakeData__c(name = '売掛データテストJ06', SeikyuAccount__c = accList[0].Id));
        insert urikakeList;

        Test.startTest();

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
        
/*       
        ApexPages.currentPage().getParameters().put('retUrl', 'XXXXX');
        J06_JuchuControllerExtension controller = new J06_JuchuControllerExtension();
        controller.init();
*/        
        ApexPages.StandardSetController ssc = new ApexPages.StandardSetController(DataBase.query('select id from JuchuData__c'));
        ssc.setSelected(juchuList);        
        J06_JuchuControllerExtension extension = new J06_JuchuControllerExtension(ssc);
        extension.init();
        
        Test.stopTest();
    }

    static testMethod void myUnitTest2() {
        // 取引先作成
        List<Account> accList = new List<Account>();
        accList.add(new Account(name = '株式会社テストJ06', Type = '納品先'));
        insert accList;
        
        // 売掛データ作成
        List<UrikakeData__c> urikakeList = new List<UrikakeData__c>();
        urikakeList.add(new UrikakeData__c(name = '売掛データテストJ06', SeikyuAccount__c = accList[0].Id));
        insert urikakeList;

        Test.startTest();

        // 受注データ作成
        List<JuchuData__c> juchuList = new List<JuchuData__c>();

        juchuList.add(new JuchuData__c(
            name = '受注データテストJ06', 
            UrikakeData__c = urikakeList[0].Id,
            JuchuKakuteiFlg__c = FALSE,
            HikiateKanryoFlg__c = FALSE,
            HikiateZanjiKakutei__c = TRUE,
            ZaikoHikiateSaki__c = accList[0].Id,
            JidoHikiateYoyaku__c = Date.today().addDays(1),
            NohinYoteibi__c = Date.today().addDays(10),
            LotKonzaiFlg__c = TRUE));

        insert juchuList;
        
/*       
        ApexPages.currentPage().getParameters().put('retUrl', 'XXXXX');
        J06_JuchuControllerExtension controller = new J06_JuchuControllerExtension();
        controller.init();
*/        
        ApexPages.StandardSetController ssc = new ApexPages.StandardSetController(DataBase.query('select id from JuchuData__c'));
        ssc.setSelected(juchuList);        
        J06_JuchuControllerExtension extension = new J06_JuchuControllerExtension(ssc);
        extension.init();
        
        Test.stopTest();
    }

    static testMethod void myUnitTest3() {
        // 取引先作成
        List<Account> accList = new List<Account>();
        accList.add(new Account(name = '株式会社テストJ06', Type = '納品先'));
        insert accList;
        
        // 売掛データ作成
        List<UrikakeData__c> urikakeList = new List<UrikakeData__c>();
        urikakeList.add(new UrikakeData__c(name = '売掛データテストJ06', SeikyuAccount__c = accList[0].Id));
        insert urikakeList;

        Test.startTest();

        // 受注データ作成
        List<JuchuData__c> juchuList = new List<JuchuData__c>();

        juchuList.add(new JuchuData__c(
            name = '受注データテストJ06', 
            UrikakeData__c = urikakeList[0].Id,
            JuchuKakuteiFlg__c = TRUE,
            HikiateKanryoFlg__c = TRUE,
            HikiateZanjiKaijo__c = TRUE,
            ZaikoHikiateSaki__c = accList[0].Id,
            JidoHikiateYoyaku__c = Date.today().addDays(1),
            NohinYoteibi__c = Date.today().addDays(10),
            LotKonzaiFlg__c = TRUE));

        insert juchuList;
        
/*       
        ApexPages.currentPage().getParameters().put('retUrl', 'XXXXX');
        J06_JuchuControllerExtension controller = new J06_JuchuControllerExtension();
        controller.init();
*/        
        ApexPages.StandardSetController ssc = new ApexPages.StandardSetController(DataBase.query('select id from JuchuData__c'));
        ssc.setSelected(juchuList);        
        J06_JuchuControllerExtension extension = new J06_JuchuControllerExtension(ssc);
        extension.init();
        
        Test.stopTest();
    }

}