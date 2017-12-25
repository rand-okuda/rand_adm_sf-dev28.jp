@isTest
private class J47_JyutyuKakuteiTorikesiZaikoLogicTest {

    static testMethod void myUnitTest1() {
        // カスタム設定
        SystemParam__c sysCon = SystemParam__c.getOrgDefaults();
        sysCon.JuchuMeisaiSaidaiTorokusu__c = 45;
        insert sysCon;
        
        // 商品資材作成
        ShohinShizaiM__c shohin1 = new ShohinShizaiM__c(name = 'テスト商品1', ShomiKigenNissu__c = 100);
        insert shohin1;
        
        // 取引先作成
        Account acc1 = new Account(name = '株式会社テスト1', Shimebi__c = 20, Kijitsu__c = 99, AccountTankaMHuyouFlg__c = true);
        Account acc2 = new Account(name = 'テスト倉庫', Shimebi__c = 20, Kijitsu__c = 99, AccountTankaMHuyouFlg__c = true);
        insert acc1;
        insert acc2;

        // 取引先単価マスタ作成
        AccountTankaM__c tanka1 = new AccountTankaM__c(Account__c = acc1.Id, ShohinShizaiM__c = shohin1.Id, ShomiKigenKakuhoNissu__c = 10);
        insert tanka1;
        
        // 売掛データ作成
        UrikakeData__c Urikake1 = new UrikakeData__c(name = acc1.Name, SeikyuAccount__c = acc1.Id);
        insert urikake1;
        
        // 受注データ作成
        JuchuData__c juchu1 = new JuchuData__c(UrikakeData__c = urikake1.id, name = urikake1.Name, zaikoHikiateSaki__c = acc2.Id);
        insert juchu1;
        
        // 受注明細データ作成
        JuchuMeisaiData__c meisai1 = new JuchuMeisaiData__c(JuchuSuryo__c = 15, name = juchu1.name, JuchuData__c = juchu1.Id, ShohinShizaiM__c = shohin1.Id, NohinSuryo__c = 0); 
        insert meisai1;
        
        // 在庫データ作成
        ZaikoData__c zaiko1 = new ZaikoData__c(ZaikoSuryo__c = 10, name = 'a', ShohinShizaiM__c = shohin1.Id, Zaikobasho__c = acc2.Id, ShomiKigen__c = Date.newInstance(2016, 1, 1), NyukoFlg__c = true);
        ZaikoData__c zaiko2 = new ZaikoData__c(ZaikoSuryo__c = 10, name = 'a', ShohinShizaiM__c = shohin1.Id, Zaikobasho__c = acc2.Id, ShomiKigen__c = Date.newInstance(2016, 1, 1), NyukoFlg__c = true);
        insert zaiko1;
        insert zaiko2;

        // 在庫引当処理
        juchu1.NohinYoteibi__c = Date.today().addDays(1);
        juchu1.ShomiKigenKonzaiFlg__c = true;
        juchu1.LotKonzaiFlg__c = true;
        juchu1.JuchuKakuteiFlg__c = true;
        
        update juchu1;
        
        Test.startTest();
        
        // 受注取消処理
        juchu1.JuchuKakuteiFlg__c = false;
        juchu1.HikiateKanryoFlg__c = false;
        
        update juchu1;
        
        Test.stopTest();
    }
}