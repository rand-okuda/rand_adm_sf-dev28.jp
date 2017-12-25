@isTest
private class ZaikoDataTriggerHandlerTest {

    static testMethod void myUnitTest1() {
        // 商品資材作成
        ShohinShizaiM__c shohin = new ShohinShizaiM__c(name = 'テスト商品1', HyojunBaika__c = 1);
        insert shohin;
        
        // 仕入先作成
        Account acc1 = new Account(Name = 'テスト取引先');
        insert acc1;
        
        // 納品先作成
        Account acc2 = new Account(Name = 'テスト納品先');
        insert acc2;

        // 発注データ作成
        HachuData__c hachu = new HachuData__c (Shiiresaki__c = acc1.Id, Hachubi__c = Date.today(), Nohinsaki__c = acc2.Id, NohinYoteibi__c = Date.today().addDays(10));
        insert hachu;
        
        // 発注明細データ作成
        HachuMeisaiData__c meisai = new HachuMeisaiData__c(HachuData__c = hachu.Id, ShohinShizaiM__c = shohin.Id, HachuSuryoPC__c = 1, KonyuKakaku__c = 123);
        insert meisai;
        update meisai;
        
        Test.startTest();
        // 発注データ更新
        hachu.HachuKakuteiFlg__c = true;
        update hachu;
        
        // 在庫データが作成されている
        ZaikoData__c zaiko = [SELECT Id, NyukoFlg__c FROM ZaikoData__c WHERE HachuMeisai__c = :meisai.Id];
        
        // 在庫データ更新
        zaiko.NyukoFlg__c = true;
        update zaiko;
        
        // 在庫データ更新
        zaiko.NyukoFlg__c = false;
        update zaiko;

        // 在庫データ削除
        delete zaiko;
        
        Test.stopTest();
    }
    
    static testMethod void myUnitTest2() {
        // 取引先作成
        List<Account> accList = new List<Account>();
        accList.add(new Account(name = '株式会社テスト'));
        insert accList;
        
        // 商品資材マスタ作成
        List<ShohinShizaiM__c> shohinList = new List<ShohinShizaiM__c>();
        shohinList.add(new ShohinShizaiM__c(
            name = '商品資材名テスト'
            ));
        insert shohinList;
        
        // 取引先単価マスタ作成
        List<AccountTankaM__c> tankaMs = new List<AccountTankaM__c>();
        tankaMs.add(new AccountTankaM__c(
            ShohinShizaiM__c = shohinList[0].Id,
            Account__c = accList[0].Id,
            TekiyoKikanKara__c = Date.today(),
            TekiyoKikanMade__c = Date.today().addDays(10)));
        insert tankaMs;
        
        Test.startTest();
        // 在庫データ作成
        List<ZaikoData__c> zaikoList = new List<ZaikoData__c>();
        zaikoList.add(new ZaikoData__c(
            name = '在庫データテスト', 
            ShohinShizaiM__c = shohinList[0].Id, 
            Zaikobasho__c = accList[0].Id,
            NyukoNichiji__c = Datetime.now()
            ));
        insert zaikoList;
        
        Test.stopTest();
    }
}