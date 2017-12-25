@isTest
private class J05_NohinKakakuRendoLogicTest {
    // 正常：受注明細更新時、取引先マスタが存在する。
    static testMethod void myUnitTest1() {
        // カスタム設定
        SystemParam__c sysCon = SystemParam__c.getOrgDefaults();
        sysCon.JuchuMeisaiSaidaiTorokusu__c = 45;
        insert sysCon;
        
        // 商品資材作成
        ShohinShizaiM__c shohin1 = new ShohinShizaiM__c(name = 'テスト商品1', ShomiKigenNissu__c = 100, AccountTankaMHuyouFlg__c = false);
        ShohinShizaiM__c shohin2 = new ShohinShizaiM__c(name = 'テスト商品2', ShomiKigenNissu__c = 100, AccountTankaMHuyouFlg__c = false);
        insert shohin1;
        insert shohin2;
        
        // 取引先作成
        Account acc1 = new Account(name = '株式会社テスト1', Shimebi__c = 20, Kijitsu__c = 99, AccountTankaMHuyouFlg__c = false);
        insert acc1;
        
        // 取引先単価マスタ作成
        AccountTankaM__c tanka1 = new AccountTankaM__c(Account__c = acc1.Id, ShohinShizaiM__c = shohin1.Id, ShomiKigenKakuhoNissu__c = 10, TekiyoKikanKara__c = Date.newInstance(1900, 1, 1), TekiyoKikanMade__c = Date.newInstance(2900, 1, 1));
        AccountTankaM__c tanka2 = new AccountTankaM__c(Account__c = acc1.Id, ShohinShizaiM__c = shohin2.Id, ShomiKigenKakuhoNissu__c = 10, TekiyoKikanKara__c = Date.newInstance(1900, 1, 1), TekiyoKikanMade__c = Date.newInstance(2900, 1, 1));
        insert tanka1;
        insert tanka2;
        
        // 売掛データ作成
        UrikakeData__c Urikake1 = new UrikakeData__c(name = acc1.Name, SeikyuAccount__c = acc1.Id);
        insert urikake1;
        
        // 受注データ作成
        JuchuData__c juchu1 = new JuchuData__c(UrikakeData__c = urikake1.id, name = urikake1.Name, Juchusaki__c = acc1.Id);
        insert juchu1;
        
        // 受注明細データ作成
        JuchuMeisaiData__c meisai1 = new JuchuMeisaiData__c(JuchuSuryo__c = 15, name = juchu1.name, JuchuData__c = juchu1.Id, ShohinShizaiM__c = shohin1.Id, NohinSuryo__c = 0); 
        insert meisai1;
        
        Test.startTest();
        
        meisai1.ShohinShizaiM__c = shohin2.Id;
        update meisai1;
        
        Test.stopTest();
    }
        
    // エラー：受注明細更新時、取引先単価マスタが存在しない
    static testMethod void myUnitTest2() {
        // カスタム設定
        SystemParam__c sysCon = SystemParam__c.getOrgDefaults();
        sysCon.JuchuMeisaiSaidaiTorokusu__c = 45;
        insert sysCon;
        
        // 商品資材作成
        ShohinShizaiM__c shohin1 = new ShohinShizaiM__c(name = 'テスト商品1', ShomiKigenNissu__c = 100, AccountTankaMHuyouFlg__c = false);
        ShohinShizaiM__c shohin2 = new ShohinShizaiM__c(name = 'テスト商品2', ShomiKigenNissu__c = 100, AccountTankaMHuyouFlg__c = false);
        insert shohin1;
        insert shohin2;
        
        // 取引先作成
        Account acc1 = new Account(name = '株式会社テスト1', Shimebi__c = 20, Kijitsu__c = 99, AccountTankaMHuyouFlg__c = false);
        insert acc1;
        
        // 取引先単価マスタ作成
        AccountTankaM__c tanka1 = new AccountTankaM__c(Account__c = acc1.Id, ShohinShizaiM__c = shohin1.Id, ShomiKigenKakuhoNissu__c = 10, TekiyoKikanKara__c = Date.newInstance(1900, 1, 1), TekiyoKikanMade__c = Date.newInstance(2900, 1, 1));
        //AccountTankaM__c tanka2 = new AccountTankaM__c(Account__c = acc1.Id, ShohinShizaiM__c = shohin2.Id, ShomiKigenKakuhoNissu__c = 10, TekiyoKikanKara__c = Date.newInstance(1900, 1, 1), TekiyoKikanMade__c = Date.newInstance(2900, 1, 1));
        insert tanka1;
        //insert tanka2;
        
        // 売掛データ作成
        UrikakeData__c Urikake1 = new UrikakeData__c(name = acc1.Name, SeikyuAccount__c = acc1.Id);
        insert urikake1;
        
        // 受注データ作成
        JuchuData__c juchu1 = new JuchuData__c(UrikakeData__c = urikake1.id, name = urikake1.Name, Juchusaki__c = acc1.Id);
        insert juchu1;
        
        // 受注明細データ作成
        JuchuMeisaiData__c meisai1 = new JuchuMeisaiData__c(JuchuSuryo__c = 15, name = juchu1.name, JuchuData__c = juchu1.Id, ShohinShizaiM__c = shohin1.Id, NohinSuryo__c = 0); 
        insert meisai1;
        
        Test.startTest();
        
        meisai1.ShohinShizaiM__c = shohin2.Id;

        try{
            update meisai1;
        }catch(Exception e){
            system.debug('エラーが発生してますよ。正しい動作ですよ。');
        }
        
        Test.stopTest();
    }
    
    // エラー：受注明細新規作成時、取引先単価マスタが存在しない
    static testMethod void myUnitTest3() {
        // カスタム設定
        SystemParam__c sysCon = SystemParam__c.getOrgDefaults();
        sysCon.JuchuMeisaiSaidaiTorokusu__c = 45;
        insert sysCon;
        
        // 商品資材作成
        ShohinShizaiM__c shohin1 = new ShohinShizaiM__c(name = 'テスト商品1', ShomiKigenNissu__c = 100, AccountTankaMHuyouFlg__c = false);
        ShohinShizaiM__c shohin2 = new ShohinShizaiM__c(name = 'テスト商品2', ShomiKigenNissu__c = 100, AccountTankaMHuyouFlg__c = false);
        insert shohin1;
        insert shohin2;
        
        // 取引先作成
        Account acc1 = new Account(name = '株式会社テスト1', Shimebi__c = 20, Kijitsu__c = 99, AccountTankaMHuyouFlg__c = false);
        insert acc1;
        
        // 取引先単価マスタ作成
        AccountTankaM__c tanka1 = new AccountTankaM__c(Account__c = acc1.Id, ShohinShizaiM__c = shohin1.Id, ShomiKigenKakuhoNissu__c = 10, TekiyoKikanKara__c = Date.newInstance(1900, 1, 1), TekiyoKikanMade__c = Date.newInstance(2900, 1, 1));
        AccountTankaM__c tanka2 = new AccountTankaM__c(Account__c = acc1.Id, ShohinShizaiM__c = shohin2.Id, ShomiKigenKakuhoNissu__c = 10, TekiyoKikanKara__c = Date.newInstance(1900, 1, 1), TekiyoKikanMade__c = Date.newInstance(2900, 1, 1));
        insert tanka1;
        insert tanka2;
        
        // 売掛データ作成
        UrikakeData__c Urikake1 = new UrikakeData__c(name = acc1.Name, SeikyuAccount__c = acc1.Id);
        insert urikake1;
        
        // 受注データ作成
        JuchuData__c juchu1 = new JuchuData__c(UrikakeData__c = urikake1.id, name = urikake1.Name, Juchusaki__c = acc1.Id);
        insert juchu1;
        
        Test.startTest();
        
        try{
            // 受注明細データ作成
            JuchuMeisaiData__c meisai1 = new JuchuMeisaiData__c(JuchuSuryo__c = 15, name = juchu1.name, JuchuData__c = juchu1.Id, ShohinShizaiM__c = shohin1.Id, NohinSuryo__c = 0); 
            insert meisai1;
        }catch(Exception e){
            system.debug('エラーが発生してますよ。正しい動作ですよ。');
        }
        
        Test.stopTest();
    }
    
    // 正常：受注データ更新時、取引先単価マスタが存在する
    static testMethod void myUnitTest4() {
        // カスタム設定
        SystemParam__c sysCon = SystemParam__c.getOrgDefaults();
        sysCon.JuchuMeisaiSaidaiTorokusu__c = 45;
        insert sysCon;
        
        // 商品資材作成
        ShohinShizaiM__c shohin1 = new ShohinShizaiM__c(name = 'テスト商品1', ShomiKigenNissu__c = 100, AccountTankaMHuyouFlg__c = false);
        //ShohinShizaiM__c shohin2 = new ShohinShizaiM__c(name = 'テスト商品2', ShomiKigenNissu__c = 100, AccountTankaMHuyouFlg__c = false);
        insert shohin1;
        //insert shohin2;
        
        // 取引先作成
        Account acc1 = new Account(name = '株式会社テスト1', Shimebi__c = 20, Kijitsu__c = 99, AccountTankaMHuyouFlg__c = false);
        insert acc1;
        
        // 取引先単価マスタ作成
        AccountTankaM__c tanka1 = new AccountTankaM__c(Account__c = acc1.Id, ShohinShizaiM__c = shohin1.Id, ShomiKigenKakuhoNissu__c = 10, TekiyoKikanKara__c = Date.newInstance(1900, 1, 1), TekiyoKikanMade__c = Date.newInstance(2115, 12, 31));
        AccountTankaM__c tanka2 = new AccountTankaM__c(Account__c = acc1.Id, ShohinShizaiM__c = shohin1.Id, ShomiKigenKakuhoNissu__c = 10, TekiyoKikanKara__c = Date.newInstance(2116, 1, 1), TekiyoKikanMade__c = Date.newInstance(2900, 1, 1));
        insert tanka1;
        insert tanka2;
        
        // 売掛データ作成
        UrikakeData__c Urikake1 = new UrikakeData__c(name = acc1.Name, SeikyuAccount__c = acc1.Id);
        insert urikake1;
        
        // 受注データ作成
        JuchuData__c juchu1 = new JuchuData__c(UrikakeData__c = urikake1.id, name = urikake1.Name, Juchusaki__c = acc1.Id);
        insert juchu1;
        
        // 受注明細データ作成
        JuchuMeisaiData__c meisai1 = new JuchuMeisaiData__c(JuchuSuryo__c = 15, name = juchu1.name, JuchuData__c = juchu1.Id, ShohinShizaiM__c = shohin1.Id, NohinSuryo__c = 0); 
        insert meisai1;
        
        Test.startTest();
        
        juchu1.JuchuUriageKakuteiBi__c = date.newInstance(2116, 1, 1);
        update juchu1;
        
        Test.stopTest();
    }
    
    // エラー：受注データ更新時、取引先単価マスタが存在しない
    static testMethod void myUnitTest5() {
        // カスタム設定
        SystemParam__c sysCon = SystemParam__c.getOrgDefaults();
        sysCon.JuchuMeisaiSaidaiTorokusu__c = 45;
        insert sysCon;
        
        // 商品資材作成
        ShohinShizaiM__c shohin1 = new ShohinShizaiM__c(name = 'テスト商品1', ShomiKigenNissu__c = 100, AccountTankaMHuyouFlg__c = false);
        //ShohinShizaiM__c shohin2 = new ShohinShizaiM__c(name = 'テスト商品2', ShomiKigenNissu__c = 100, AccountTankaMHuyouFlg__c = false);
        insert shohin1;
        //insert shohin2;
        
        // 取引先作成
        Account acc1 = new Account(name = '株式会社テスト1', Shimebi__c = 20, Kijitsu__c = 99, AccountTankaMHuyouFlg__c = false);
        insert acc1;
        
        // 取引先単価マスタ作成
        AccountTankaM__c tanka1 = new AccountTankaM__c(Account__c = acc1.Id, ShohinShizaiM__c = shohin1.Id, ShomiKigenKakuhoNissu__c = 10, TekiyoKikanKara__c = Date.newInstance(1900, 1, 1), TekiyoKikanMade__c = Date.newInstance(2115, 12, 31));
        //AccountTankaM__c tanka2 = new AccountTankaM__c(Account__c = acc1.Id, ShohinShizaiM__c = shohin1.Id, ShomiKigenKakuhoNissu__c = 10, TekiyoKikanKara__c = Date.newInstance(2116, 1, 1), TekiyoKikanMade__c = Date.newInstance(2900, 1, 1));
        insert tanka1;
        //insert tanka2;
        
        // 売掛データ作成
        UrikakeData__c Urikake1 = new UrikakeData__c(name = acc1.Name, SeikyuAccount__c = acc1.Id);
        insert urikake1;
        
        // 受注データ作成
        JuchuData__c juchu1 = new JuchuData__c(UrikakeData__c = urikake1.id, name = urikake1.Name, Juchusaki__c = acc1.Id);
        insert juchu1;
        
        // 受注明細データ作成
        JuchuMeisaiData__c meisai1 = new JuchuMeisaiData__c(JuchuSuryo__c = 15, name = juchu1.name, JuchuData__c = juchu1.Id, ShohinShizaiM__c = shohin1.Id, NohinSuryo__c = 0); 
        insert meisai1;
        
        Test.startTest();
        
        try{
            juchu1.JuchuUriageKakuteiBi__c = date.newInstance(2116, 1, 1);
            update juchu1;
        }catch(Exception e){
            system.debug('エラーが発生してますよ。正しい動作ですよ。');
        }
        
        Test.stopTest();
    }
    
    // 正常：取引先単価マスタ不要フラグtrue
    static testMethod void myUnitTest6() {
        // カスタム設定
        SystemParam__c sysCon = SystemParam__c.getOrgDefaults();
        sysCon.JuchuMeisaiSaidaiTorokusu__c = 45;
        insert sysCon;
        
        // 商品資材作成
        ShohinShizaiM__c shohin1 = new ShohinShizaiM__c(name = 'テスト商品1', ShomiKigenNissu__c = 100, AccountTankaMHuyouFlg__c = true);
        ShohinShizaiM__c shohin2 = new ShohinShizaiM__c(name = 'テスト商品2', ShomiKigenNissu__c = 100, AccountTankaMHuyouFlg__c = true);
        insert shohin1;
        insert shohin2;
        
        // 取引先作成
        Account acc1 = new Account(name = '株式会社テスト1', Shimebi__c = 20, Kijitsu__c = 99, AccountTankaMHuyouFlg__c = true);
        insert acc1;
        
        // 取引先単価マスタ作成
        AccountTankaM__c tanka1 = new AccountTankaM__c(Account__c = acc1.Id, ShohinShizaiM__c = shohin1.Id, ShomiKigenKakuhoNissu__c = 10, TekiyoKikanKara__c = Date.newInstance(1900, 1, 1), TekiyoKikanMade__c = Date.newInstance(2115, 12, 31));
        AccountTankaM__c tanka2 = new AccountTankaM__c(Account__c = acc1.Id, ShohinShizaiM__c = shohin1.Id, ShomiKigenKakuhoNissu__c = 10, TekiyoKikanKara__c = Date.newInstance(2116, 1, 1), TekiyoKikanMade__c = Date.newInstance(2900, 1, 1));
        insert tanka1;
        insert tanka2;
        
        // 売掛データ作成
        UrikakeData__c Urikake1 = new UrikakeData__c(name = acc1.Name, SeikyuAccount__c = acc1.Id);
        insert urikake1;
        
        // 受注データ作成
        JuchuData__c juchu1 = new JuchuData__c(UrikakeData__c = urikake1.id, name = urikake1.Name, Juchusaki__c = acc1.Id);
        insert juchu1;
        
        // 受注明細データ作成
        JuchuMeisaiData__c meisai1 = new JuchuMeisaiData__c(JuchuSuryo__c = 15, name = juchu1.name, JuchuData__c = juchu1.Id, ShohinShizaiM__c = shohin1.Id, NohinSuryo__c = 0); 
        insert meisai1;
        
        Test.startTest();
        
        meisai1.ShohinShizaiM__c = shohin2.Id;
        update meisai1;
        
        juchu1.JuchuUriageKakuteiBi__c = date.newInstance(2116, 1, 1);
        update juchu1;
                
        Test.stopTest();
    }
}