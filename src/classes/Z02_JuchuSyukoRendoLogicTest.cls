@isTest
private class Z02_JuchuSyukoRendoLogicTest {

    // パターンA 在庫有り
    static testMethod void myUnitTest1() {
        // カスタム設定
        SystemParam__c sysCon = SystemParam__c.getOrgDefaults();
        sysCon.JuchuMeisaiSaidaiTorokusu__c = 45;
        insert sysCon;
        
        // 商品資材作成
        ShohinShizaiM__c shohin1 = new ShohinShizaiM__c(name = 'テスト商品1', ShomiKigenNissu__c = 100);
        insert shohin1;
        
        // 取引先作成
        Account acc1 = new Account(name = '株式会社テスト1',AccountTankaMHuyouFlg__c = true);
        insert acc1;
        Account acc2 = new Account(name = 'テスト倉庫A');
        insert acc2;
        Account acc3 = new Account(name = 'テスト倉庫B', YusenHikiateSakiFlg__c = true);
        insert acc3;

        // 在庫データ作成
        ZaikoData__c zaiko1 = new ZaikoData__c(ZaikoSuryo__c = 10, name = 'a', ShohinShizaiM__c = shohin1.Id, Zaikobasho__c = acc2.Id, ShomiKigen__c = Date.today().addDays(120), NyukoFlg__c = true);
        ZaikoData__c zaiko2 = new ZaikoData__c(ZaikoSuryo__c = 10, name = 'a', ShohinShizaiM__c = shohin1.Id, Zaikobasho__c = acc2.Id, ShomiKigen__c = Date.today().addDays(120), NyukoFlg__c = true);
        ZaikoData__c zaiko3 = new ZaikoData__c(ZaikoSuryo__c = 10, name = 'a', ShohinShizaiM__c = shohin1.Id, Zaikobasho__c = acc3.Id, ShomiKigen__c = Date.today().addDays(120), NyukoFlg__c = true);
        ZaikoData__c zaiko4 = new ZaikoData__c(ZaikoSuryo__c = 10, name = 'a', ShohinShizaiM__c = shohin1.Id, Zaikobasho__c = acc3.Id, ShomiKigen__c = Date.today().addDays(120), NyukoFlg__c = true);
        insert zaiko1;
        insert zaiko2;
        insert zaiko3;
        insert zaiko4;

        // 取引先単価マスタ作成
        AccountTankaM__c tanka1 = new AccountTankaM__c(Account__c = acc1.Id, ShohinShizaiM__c = shohin1.Id, ShomiKigenKakuhoNissu__c = 10);
        insert tanka1;
        
        // 売掛データ作成
        UrikakeData__c Urikake1 = new UrikakeData__c(name = acc1.Name, SeikyuAccount__c = acc1.Id);
        insert urikake1;
        
        // 受注データ作成
        JuchuData__c juchu1 = new JuchuData__c(UrikakeData__c = urikake1.id, name = urikake1.Name);
        insert juchu1;
        
        // 受注明細データ作成
        JuchuMeisaiData__c meisai1 = new JuchuMeisaiData__c(JuchuSuryoPC__c = 15, name = juchu1.name, JuchuData__c = juchu1.Id, ShohinShizaiM__c = shohin1.Id, NohinSuryo__c = 0); 
        insert meisai1;
        

        Test.startTest();
        
        juchu1.NohinYoteibi__c = Date.today().addDays(1);

        //パターンA
        juchu1.ShomiKigenKonzaiFlg__c = true;
        juchu1.LotKonzaiFlg__c = true;
        juchu1.SuryoYusenFlg__c  = false;
        juchu1.JuchuKakuteiFlg__c = true;
        update juchu1;

        //個別引当先を設定
        acc1.KobetsuHikiateSaki__c = acc2.Id;
        update acc1;

        juchu1.HikiateKanryoFlg__c = false;
        update juchu1;

        //パターンB
        juchu1.ShomiKigenKonzaiFlg__c = true;
        juchu1.LotKonzaiFlg__c = false;
        juchu1.SuryoYusenFlg__c  = false;
        juchu1.JuchuKakuteiFlg__c = true;
        update juchu1;

        //個別引当先を解除
        acc1.KobetsuHikiateSaki__c = null;
        update acc1;

        juchu1.HikiateKanryoFlg__c = false;
        update juchu1;

        //パターンC
        juchu1.ShomiKigenKonzaiFlg__c = false;
        juchu1.LotKonzaiFlg__c = true;
        juchu1.SuryoYusenFlg__c  = true;
        juchu1.JuchuKakuteiFlg__c = true;        
        update juchu1;
        
        juchu1.HikiateKanryoFlg__c = false;
        update juchu1;


        Test.stopTest();
    }
    
    // パターンA 在庫なし
    static testMethod void myUnitTest2() {
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
        JuchuMeisaiData__c meisai1 = new JuchuMeisaiData__c(JuchuSuryoPC__c = 15, name = juchu1.name, JuchuData__c = juchu1.Id, ShohinShizaiM__c = shohin1.Id, NohinSuryo__c = 0); 
        insert meisai1;
        
        // 在庫データ作成
        ZaikoData__c zaiko1 = new ZaikoData__c(ZaikoSuryo__c = 5, name = 'a', ShohinShizaiM__c = shohin1.Id, Zaikobasho__c = acc2.Id, ShomiKigen__c = Date.today().addDays(120), NyukoFlg__c = true);
        ZaikoData__c zaiko2 = new ZaikoData__c(ZaikoSuryo__c = 5, name = 'a', ShohinShizaiM__c = shohin1.Id, Zaikobasho__c = acc2.Id, ShomiKigen__c = Date.today().addDays(120), NyukoFlg__c = true);
        insert zaiko1;
        insert zaiko2;
        
        Test.startTest();
        
        juchu1.NohinYoteibi__c = Date.today().addDays(1);
        juchu1.ShomiKigenKonzaiFlg__c = true;
        juchu1.LotKonzaiFlg__c = true;
        juchu1.JuchuKakuteiFlg__c = true;
        
        try{
            update juchu1;
        }catch(exception e){
            
        }

        juchu1.HikiateKanryoFlg__c = false;
        update juchu1;

        juchu1.NohinYoteibi__c = Date.today().addDays(1);
        juchu1.ShomiKigenKonzaiFlg__c = true;
        juchu1.LotKonzaiFlg__c = false;
        juchu1.JuchuKakuteiFlg__c = true;
        
        try{
            update juchu1;
        }catch(exception e){
            
        }

        juchu1.HikiateKanryoFlg__c = false;
        update juchu1;        

        juchu1.NohinYoteibi__c = Date.today().addDays(1);
        juchu1.ShomiKigenKonzaiFlg__c = true;
        juchu1.LotKonzaiFlg__c = false;
        juchu1.JuchuKakuteiFlg__c = true;
        juchu1.SuryoYusenFlg__c  = true;
        
        try{
            update juchu1;
        }catch(exception e){
            
        }
        
        Test.stopTest();
    }
    
    // パターンB 在庫有り
    static testMethod void myUnitTest3() {
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
        JuchuMeisaiData__c meisai1 = new JuchuMeisaiData__c(JuchuSuryoPC__c = 15, name = juchu1.name, JuchuData__c = juchu1.Id, ShohinShizaiM__c = shohin1.Id, NohinSuryo__c = 0); 
        insert meisai1;
        
        // 在庫データ作成
        ZaikoData__c zaiko1 = new ZaikoData__c(ZaikoSuryo__c = 1, name = 'a', ShohinShizaiM__c = shohin1.Id, Zaikobasho__c = acc2.Id, ShomiKigen__c = Date.today().addDays(120), NyukoFlg__c = true);
        ZaikoData__c zaiko2 = new ZaikoData__c(ZaikoSuryo__c = 10, name = 'a', ShohinShizaiM__c = shohin1.Id, Zaikobasho__c = acc2.Id, ShomiKigen__c = Date.today().addDays(121), NyukoFlg__c = true);
        ZaikoData__c zaiko3 = new ZaikoData__c(ZaikoSuryo__c = 10, name = 'a', ShohinShizaiM__c = shohin1.Id, Zaikobasho__c = acc2.Id, ShomiKigen__c = Date.today().addDays(121), NyukoFlg__c = true);
        insert zaiko1;
        insert zaiko2;
        insert zaiko3;
        
        Test.startTest();
        
        juchu1.NohinYoteibi__c = Date.today().addDays(1);
        juchu1.ShomiKigenKonzaiFlg__c = false;
        juchu1.LotKonzaiFlg__c = true;
        juchu1.JuchuKakuteiFlg__c = true;
        
        update juchu1;
                
        juchu1.HikiateKanryoFlg__c = false;
        update juchu1;

        juchu1.NohinYoteibi__c = Date.today().addDays(1);
        juchu1.ShomiKigenKonzaiFlg__c = false;
        juchu1.LotKonzaiFlg__c = true;
        juchu1.JuchuKakuteiFlg__c = true;
        juchu1.SuryoYusenFlg__c  = true;

        update juchu1;

        Test.stopTest();
    }
    
    // パターンB 在庫なし
    static testMethod void myUnitTest4() {
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
        JuchuMeisaiData__c meisai1 = new JuchuMeisaiData__c(JuchuSuryoPC__c = 15, name = juchu1.name, JuchuData__c = juchu1.Id, ShohinShizaiM__c = shohin1.Id, NohinSuryo__c = 0); 
        insert meisai1;
        
        // 在庫データ作成
        ZaikoData__c zaiko1 = new ZaikoData__c(ZaikoSuryo__c = 14, name = 'a', ShohinShizaiM__c = shohin1.Id, Zaikobasho__c = acc2.Id, ShomiKigen__c = Date.today().addDays(120), NyukoFlg__c = true);
        ZaikoData__c zaiko2 = new ZaikoData__c(ZaikoSuryo__c = 2, name = 'a', ShohinShizaiM__c = shohin1.Id, Zaikobasho__c = acc2.Id, ShomiKigen__c = Date.today().addDays(121), NyukoFlg__c = true);
        ZaikoData__c zaiko3 = new ZaikoData__c(ZaikoSuryo__c = 12, name = 'a', ShohinShizaiM__c = shohin1.Id, Zaikobasho__c = acc2.Id, ShomiKigen__c = Date.today().addDays(121), NyukoFlg__c = true);
        insert zaiko1;
        insert zaiko2;
        insert zaiko3;
        
        Test.startTest();
        
        juchu1.NohinYoteibi__c = Date.today().addDays(1);
        juchu1.ShomiKigenKonzaiFlg__c = false;
        juchu1.LotKonzaiFlg__c = true;
        juchu1.JuchuKakuteiFlg__c = true;
        
        try{
            update juchu1;
        }catch(Exception e){
            
        }

        juchu1.HikiateKanryoFlg__c = false;
        update juchu1;
                
        juchu1.NohinYoteibi__c = Date.today().addDays(1);
        juchu1.ShomiKigenKonzaiFlg__c = false;
        juchu1.LotKonzaiFlg__c = true;
        juchu1.JuchuKakuteiFlg__c = true;
        juchu1.SuryoYusenFlg__c  = true;
        
        try{
            update juchu1;
        }catch(Exception e){
            
        }

        Test.stopTest();
    }
    
    // パターンC 在庫あり
    static testMethod void myUnitTest5() {
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
        JuchuMeisaiData__c meisai1 = new JuchuMeisaiData__c(JuchuSuryoPC__c = 15, name = juchu1.name, JuchuData__c = juchu1.Id, ShohinShizaiM__c = shohin1.Id, NohinSuryo__c = 0); 
        insert meisai1;
        
        // 在庫データ作成
        ZaikoData__c zaiko1 = new ZaikoData__c(ZaikoSuryo__c = 5, name = 'a', ShohinShizaiM__c = shohin1.Id, Zaikobasho__c = acc2.Id, ShomiKigen__c = Date.today().addDays(120), NyukoFlg__c = true);
        ZaikoData__c zaiko2 = new ZaikoData__c(ZaikoSuryo__c = 5, name = 'a', ShohinShizaiM__c = shohin1.Id, Zaikobasho__c = acc2.Id, ShomiKigen__c = Date.today().addDays(121), NyukoFlg__c = true);
        ZaikoData__c zaiko3 = new ZaikoData__c(ZaikoSuryo__c = 15, name = 'a', ShohinShizaiM__c = shohin1.Id, Zaikobasho__c = acc2.Id, ShomiKigen__c = Date.today().addDays(121), NyukoFlg__c = true);
        insert zaiko1;
        insert zaiko2;
        insert zaiko3;
        
        Test.startTest();
        
        juchu1.NohinYoteibi__c = Date.today().addDays(1);
        juchu1.ShomiKigenKonzaiFlg__c = false;
        juchu1.LotKonzaiFlg__c = false;
        juchu1.JuchuKakuteiFlg__c = true;
        
        update juchu1;

        juchu1.HikiateKanryoFlg__c = false;
        update juchu1;

        juchu1.NohinYoteibi__c = Date.today().addDays(1);
        juchu1.ShomiKigenKonzaiFlg__c = false;
        juchu1.LotKonzaiFlg__c = false;
        juchu1.JuchuKakuteiFlg__c = true;
        juchu1.SuryoYusenFlg__c  = true;
        
        update juchu1;        
        
        Test.stopTest();
    }

    // 一度に複数の受注データを更新するパターン
    static testMethod void myUnitTest6() {
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
        JuchuMeisaiData__c meisai1 = new JuchuMeisaiData__c(JuchuSuryoPC__c = 15, name = juchu1.name, JuchuData__c = juchu1.Id, ShohinShizaiM__c = shohin1.Id, NohinSuryo__c = 0); 
        JuchuMeisaiData__c meisai2 = new JuchuMeisaiData__c(JuchuSuryoPC__c = 15, name = juchu2.name, JuchuData__c = juchu2.Id, ShohinShizaiM__c = shohin1.Id, NohinSuryo__c = 0); 
        insert meisai1;
        insert meisai2;
        
        // 在庫データ作成
        ZaikoData__c zaiko1 = new ZaikoData__c(ZaikoSuryo__c = 5, name = 'a', ShohinShizaiM__c = shohin1.Id, Zaikobasho__c = acc2.Id, ShomiKigen__c = Date.today().addDays(120), NyukoFlg__c = true);
        ZaikoData__c zaiko2 = new ZaikoData__c(ZaikoSuryo__c = 5, name = 'a', ShohinShizaiM__c = shohin1.Id, Zaikobasho__c = acc2.Id, ShomiKigen__c = Date.today().addDays(121), NyukoFlg__c = true);
        ZaikoData__c zaiko3 = new ZaikoData__c(ZaikoSuryo__c = 150, name = 'a', ShohinShizaiM__c = shohin1.Id, Zaikobasho__c = acc2.Id, ShomiKigen__c = Date.today().addDays(121), NyukoFlg__c = true);
        insert zaiko1;
        insert zaiko2;
        insert zaiko3;
        
        Test.startTest();
        
        List<JuchuData__c> updJuchuList = new List<JuchuData__c>();
        
        juchu1.NohinYoteibi__c = Date.today().addDays(1);
        juchu1.ShomiKigenKonzaiFlg__c = false;
        juchu1.LotKonzaiFlg__c = false;
        juchu1.JuchuKakuteiFlg__c = true;
        updJuchuList.add(juchu1);
        
        juchu2.NohinYoteibi__c = Date.today().addDays(1);
        juchu2.ShomiKigenKonzaiFlg__c = false;
        juchu2.LotKonzaiFlg__c = false;
        juchu2.JuchuKakuteiFlg__c = true;
        updJuchuList.add(juchu2);
        
        update updJuchuList;
        
        Test.stopTest();
    }
    
    // パターンB 在庫有り （数量が近い在庫を優先）
    static testMethod void myUnitTest7() {
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
        JuchuMeisaiData__c meisai1 = new JuchuMeisaiData__c(JuchuSuryoPC__c = 15, name = juchu1.name, JuchuData__c = juchu1.Id, ShohinShizaiM__c = shohin1.Id, NohinSuryo__c = 0); 
        insert meisai1;
        
        // 在庫データ作成
        ZaikoData__c zaiko1 = new ZaikoData__c(ZaikoSuryo__c = 1, name = 'a', ShohinShizaiM__c = shohin1.Id, Zaikobasho__c = acc2.Id, ShomiKigen__c = Date.today().addDays(120), NyukoFlg__c = true);
        ZaikoData__c zaiko2 = new ZaikoData__c(ZaikoSuryo__c = 10, name = 'a', ShohinShizaiM__c = shohin1.Id, Zaikobasho__c = acc2.Id, ShomiKigen__c = Date.today().addDays(121), NyukoFlg__c = true);
        ZaikoData__c zaiko3 = new ZaikoData__c(ZaikoSuryo__c = 10, name = 'a', ShohinShizaiM__c = shohin1.Id, Zaikobasho__c = acc2.Id, ShomiKigen__c = Date.today().addDays(121), NyukoFlg__c = true);
        insert zaiko1;
        insert zaiko2;
        insert zaiko3;
        
        Test.startTest();
        
        juchu1.NohinYoteibi__c = Date.today().addDays(1);
        juchu1.ShomiKigenKonzaiFlg__c = false;
        juchu1.LotKonzaiFlg__c = true;
        juchu1.JuchuKakuteiFlg__c = true;
        
        update juchu1;
                
        juchu1.HikiateKanryoFlg__c = false;
        update juchu1;

        juchu1.NohinYoteibi__c = Date.today().addDays(1);
        juchu1.ShomiKigenKonzaiFlg__c = false;
        juchu1.LotKonzaiFlg__c = true;
        juchu1.JuchuKakuteiFlg__c = true;
        juchu1.SuryoYusenFlg__c  = true;
        
        update juchu1;

        Test.stopTest();
    }
    
}