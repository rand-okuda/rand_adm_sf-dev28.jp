@isTest
private class JuchuDataTriggerHandlerTest {
    
    // 都度請求でない、同じ売掛データに紐付く場合
    static testMethod void myUnitTest1() {

        // 取引先作成
        List<Account> accList = new List<Account>();
        accList.add(new Account(name = '株式会社テスト1', Shimebi__c = 20, Kijitsu__c = 15, AccountTankaMHuyouFlg__c = true));
        upsert accList;
        //Z99を考慮し優先引当先情報を持つ取引先マスタを作成
        accList.add(new Account(name = '標準引当先テスト2', Shimebi__c = 20, Kijitsu__c = 15, AccountTankaMHuyouFlg__c = true, YusenHikiateSakiFlg__c = true));
        upsert accList;
        accList.add(new Account(name = '株式会社テスト3', Shimebi__c = 20, Kijitsu__c = 15, AccountTankaMHuyouFlg__c = true, KobetsuHikiateSaki__c = accList[1].Id));
        upsert accList;
        
        // 売掛データ作成
        List<UrikakeData__c> UrikakeList = new List<UrikakeData__c>();
        urikakeList.add(new UrikakeData__c(name = accList[0].Name, SeikyuAccount__c = accList[0].Id, ShimeHizuke__c = Date.newInstance(2015, 1, 1)));
        insert urikakeList;

        // 受注データ作成
        JuchuData__c juchu = new JuchuData__c();
        juchu = new JuchuData__c(UrikakeData__c = urikakeList[0].id, name = urikakeList[0].Name, Juchubi__c = Date.newInstance(2015, 1, 1));
        insert juchu;
        
        Test.startTest();
        
        juchu.NohinYoteibi__c = Date.newInstance(2015, 1, 2);
        update juchu;
        
        Test.stopTest();

    }
    
    // 都度請求でない、同じ売掛データに紐付かない場合
    static testMethod void myUnitTest2() {
        // 取引先作成
        List<Account> accList = new List<Account>();
        accList.add(new Account(name = '株式会社テスト1', Shimebi__c = 20, Kijitsu__c = 15, AccountTankaMHuyouFlg__c = true));
        upsert accList;
        //Z99を考慮し優先引当先情報を持つ取引先マスタを作成
        accList.add(new Account(name = '標準引当先テスト2', Shimebi__c = 20, Kijitsu__c = 15, AccountTankaMHuyouFlg__c = true, YusenHikiateSakiFlg__c = true));
        upsert accList;
        accList.add(new Account(name = '株式会社テスト3', Shimebi__c = 20, Kijitsu__c = 15, AccountTankaMHuyouFlg__c = true, KobetsuHikiateSaki__c = accList[1].Id));
        upsert accList;
        
        // 売掛データ作成
        List<UrikakeData__c> UrikakeList = new List<UrikakeData__c>();
        urikakeList.add(new UrikakeData__c(name = accList[0].Name, SeikyuAccount__c = accList[0].Id));
        insert urikakeList;

        // 受注データ作成
        JuchuData__c juchu = new JuchuData__c();
        juchu = new JuchuData__c(UrikakeData__c = urikakeList[0].id, name = urikakeList[0].Name, Juchubi__c = Date.today());
        insert juchu;
        
        Test.startTest();
        
        juchu.NohinYoteibi__c = juchu.Juchubi__c.addYears(1);
        update juchu;
        
        Test.stopTest();
    }
    
    // 都度請求の場合
    static testMethod void myUnitTest3() {
        // 取引先作成
        List<Account> accList = new List<Account>();
        accList.add(new Account(name = '株式会社テスト1', Shimebi__c = 20, Kijitsu__c = 15, AccountTankaMHuyouFlg__c = true));
        upsert accList;
        //Z99を考慮し優先引当先情報を持つ取引先マスタを作成
        accList.add(new Account(name = '標準引当先テスト2', Shimebi__c = 20, Kijitsu__c = 15, AccountTankaMHuyouFlg__c = true, YusenHikiateSakiFlg__c = true));
        upsert accList;        
        accList.add(new Account(name = '株式会社テスト3', Shimebi__c = 20, Kijitsu__c = 15, AccountTankaMHuyouFlg__c = true, KobetsuHikiateSaki__c = accList[1].Id));
        upsert accList;

        // 売掛データ作成
        List<UrikakeData__c> UrikakeList = new List<UrikakeData__c>();
        urikakeList.add(new UrikakeData__c(name = accList[0].Name, SeikyuAccount__c = accList[0].Id));
        insert urikakeList;

        // 受注データ作成
        JuchuData__c juchu = new JuchuData__c();
        juchu = new JuchuData__c(UrikakeData__c = urikakeList[0].id, name = urikakeList[0].Name, Juchubi__c = Date.today());
        insert juchu;
        
        Test.startTest();
        
        juchu.TsudoSeikyuFlg__c = true;
        update juchu;
        
        Test.stopTest();
    }
}