@isTest
private class ShiharaiMeisaiDataTriggerHandlerTest {

    // 支払明細データ．発注明細データ．発注データ．都度支払フラグがTrueの場合
    // かつ、支払明細データ．買掛データ．都度支払フラグがTrueではない）場合
    static testMethod void myUnitTest1() {
        // 取引先作成
        List<Account> accList = new List<Account>();
        Account acc1 = new Account(name = '株式会社テスト1', Shimebi__c = 20);
        Account acc2 = new Account(name = '株式会社仕入先1', Shimebi__c = 20, Type='仕入先');
        accList.add(acc1);
        accList.add(acc2);
        insert accList;
        
        // 発注データ作成
        List<HachuData__c> hachuList = new List<HachuData__c>();
        HachuData__c hachu1 = new HachuData__c(Shiiresaki__c = acc2.Id);
        hachuList.add(hachu1);
        insert hachuList;
        
        // 発注明細データ作成
        List<HachuMeisaiData__c> hachuMeisaiList = new List<HachuMeisaiData__c>();
        HachuMeisaiData__c hachuMeisai1 = new HachuMeisaiData__c(HachuData__c = hachu1.Id);
        hachuMeisaiList.add(hachuMeisai1);
        insert hachuMeisaiList;
        
        // 買掛データ作成
        List<KaikakeData__c> kaikakeList = new List<KaikakeData__c>();
        KaikakeData__c kaikake1 = new KaikakeData__c(name='買掛テスト1', Shiiresaki__c = acc2.Id);
        kaikakeList.add(kaikake1);
        insert kaikakeList;
        
        Test.startTest();
        
        ShiharaiMeisaiData__c shiiremeisai = new ShiharaiMeisaiData__c();
        shiiremeisai.KaikakeData__c = kaikake1.Id;
        shiiremeisai.HachuMeisaiData__c = hachuMeisai1.Id;
        insert shiiremeisai;
        update shiiremeisai;
        
        Test.stopTest();
    }
    
    
    //支払明細データ．発注明細データ．発注データ．都度支払フラグがTrueではない場合
    static testMethod void myUnitTest2() {
        // 取引先作成
        List<Account> accList = new List<Account>();
        Account acc1 = new Account(name = '株式会社テスト1', Shimebi__c = 20);
        Account acc2 = new Account(name = '株式会社仕入先1', Shimebi__c = 20, Type='仕入先');
        accList.add(acc1);
        accList.add(acc2);
        insert accList;
        
        // 発注データ作成
        List<HachuData__c> hachuList = new List<HachuData__c>();
        HachuData__c hachu1 = new HachuData__c(Shiiresaki__c = acc2.Id);
        hachuList.add(hachu1);
        insert hachuList;
        
        // 発注明細データ作成
        List<HachuMeisaiData__c> hachuMeisaiList = new List<HachuMeisaiData__c>();
        HachuMeisaiData__c hachuMeisai1 = new HachuMeisaiData__c(HachuData__c = hachu1.Id);
        hachuMeisaiList.add(hachuMeisai1);
        insert hachuMeisaiList;
        
        // 買掛データ作成
        List<KaikakeData__c> kaikakeList = new List<KaikakeData__c>();
        KaikakeData__c kaikake1 = new KaikakeData__c(name='買掛テスト1', Shiiresaki__c = acc2.Id, ShimeHizuke__c = Date.newInstance(2015, 2, 1));
        kaikakeList.add(kaikake1);
        insert kaikakeList;
        
        Test.startTest();
        
        ShiharaiMeisaiData__c shiharaiMeisai = new ShiharaiMeisaiData__c();
        shiharaiMeisai.KaikakeData__c = kaikake1.Id;
        shiharaiMeisai.HachuMeisaiData__c = hachuMeisai1.Id;
        shiharaiMeisai.Nohinbi__c = Date.newInstance(2015, 4, 1);
        insert shiharaiMeisai;
        update shiharaiMeisai;
        Test.stopTest();
    }
}