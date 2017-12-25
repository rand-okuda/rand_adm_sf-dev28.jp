@isTest
private class J04_DempyoBangokKinyuLogicTest {

    static testMethod void myUnitTest1() {
        // カスタム設定
        SystemParam__c sysCon = SystemParam__c.getOrgDefaults();
        sysCon.JuchuMeisaiSaidaiTorokusu__c = 45;
        insert sysCon;
        
        // 商品資材作成
        ShohinShizaiM__c shohin1 = new ShohinShizaiM__c(name = 'テスト商品1', ShomiKigenNissu__c = 100);
        insert shohin1;
        
        // 取引先作成
        Account acc1 = new Account(name = '株式会社テスト1', Shimebi__c = 20, Kijitsu__c = 15, AccountTankaMHuyouFlg__c = true);
        Account acc2 = new Account(name = 'テスト倉庫', Shimebi__c = 20, Kijitsu__c = 15, AccountTankaMHuyouFlg__c = true);
        Account acc3 = new Account(name = '株式会社テスト2', Shimebi__c = 20, Kijitsu__c = 15, AccountTankaMHuyouFlg__c = true);
        insert acc1;
        insert acc2;
        insert acc3;
        
        // 取引先単価マスタ作成
        AccountTankaM__c tanka1 = new AccountTankaM__c(Account__c = acc1.Id, ShohinShizaiM__c = shohin1.Id, ShomiKigenKakuhoNissu__c = 10);
        AccountTankaM__c tanka2 = new AccountTankaM__c(Account__c = acc3.Id, ShohinShizaiM__c = shohin1.Id, ShomiKigenKakuhoNissu__c = 10);
        insert tanka1;
        insert tanka2;
        
        // 売掛データ作成
        UrikakeData__c Urikake1 = new UrikakeData__c(name = acc1.Name, SeikyuAccount__c = acc1.Id);
        UrikakeData__c Urikake2 = new UrikakeData__c(name = acc3.Name, SeikyuAccount__c = acc3.Id);
        insert urikake1;
        insert urikake2;
        
        // 受注データ作成
        JuchuData__c juchu1 = new JuchuData__c(UrikakeData__c = urikake1.id, name = urikake1.Name, zaikoHikiateSaki__c = acc2.Id);
        JuchuData__c juchu2 = new JuchuData__c(UrikakeData__c = urikake2.id, name = urikake2.Name, zaikoHikiateSaki__c = acc2.Id);
        insert juchu1;
        insert juchu2;
        
        // 受注明細データ作成
        JuchuMeisaiData__c meisai1 = new JuchuMeisaiData__c(JuchuSuryo__c = 3, name = juchu1.name, JuchuData__c = juchu1.Id, ShohinShizaiM__c = shohin1.Id, NohinSuryo__c = 0); 
        JuchuMeisaiData__c meisai2 = new JuchuMeisaiData__c(JuchuSuryo__c = 2, name = juchu2.name, JuchuData__c = juchu2.Id, ShohinShizaiM__c = shohin1.Id, NohinSuryo__c = 0); 
        insert meisai1;
        insert meisai2;
        
        // 在庫データ作成
        List<ZaikoData__c> zaikoList = new List<ZaikoData__c>();
        for(Integer i = 0; i < 10; i++){
            zaikoList.add(new ZaikoData__c(ZaikoSuryo__c = 1, name = 'a', ShohinShizaiM__c = shohin1.Id, Zaikobasho__c = acc2.Id, ShomiKigen__c = Date.newInstance(2016, 1, 2), NyukoFlg__c = true));
        }

        insert zaikoList;
      
        Test.startTest();
        
        List<JuchuData__c> updJuchuList = new List<JuchuData__c>();
        
        juchu1.NohinYoteibi__c = Date.today().addDays(1);
        juchu1.ShomiKigenKonzaiFlg__c = true;
        juchu1.LotKonzaiFlg__c = true;
        juchu1.JuchuKakuteiFlg__c = true;
        juchu1.ZaikoHikiateSaki__c = acc1.Id;
        
        updJuchuList.add(juchu1);
        
        juchu2.NohinYoteibi__c = Date.today().addDays(1);
        juchu2.ShomiKigenKonzaiFlg__c = true;
        juchu2.LotKonzaiFlg__c = true;
        juchu2.JuchuKakuteiFlg__c = true;
        juchu1.ZaikoHikiateSaki__c = acc3.Id;
        
        updJuchuList.add(juchu2);
        
        update updJuchuList;
        
        Test.stopTest();
    }
}