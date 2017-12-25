@isTest
private class J02_ShohinShizaiMControllerExtensionTest {

    // 受注データボタンから遷移するパターン
    static testMethod void myUnitTest1() {

        // 請求書明細最大行数
        SystemParam__c SysParam = SystemParam__c.getOrgDefaults();
        SysParam.JuchuMeisaiIkkatsuTsuikaJogen__c = 35;
        insert SysParam;

        // 商品資材作成
        List<ShohinShizaiM__c> shohinList = new List<ShohinShizaiM__c>();
        shohinList.add(new ShohinShizaiM__c(name = 'テスト商品1'));
        insert shohinList;
        
        // 取引先作成
        List<Account> accList = new List<Account>();
        accList.add(new Account(name = '株式会社テスト1', Shimebi__c = 20, Kijitsu__c = 15, AccountTankaMHuyouFlg__c = true, JuchusakiChofukuJogaiFlg__c = true));
        insert accList;
        
        // 売掛データ作成
        List<UrikakeData__c> UrikakeList = new List<UrikakeData__c>();
        urikakeList.add(new UrikakeData__c(name = accList[0].Name, SeikyuAccount__c = accList[0].Id));
        insert urikakeList;
        
        // 受注データ作成
        List<JuchuData__c> juchuList = new List<JuchuData__c>();
        juchuList.add(new JuchuData__c(UrikakeData__c = urikakeList[0].id, name = urikakeList[0].Name));
        insert juchuList;
        
        Test.startTest();
        
        ApexPages.StandardSetController ssc = new ApexPages.StandardSetController(DataBase.query('select id from ShohinShizaiM__c'));
        // 選択するレコードを設定
        ssc.setSelected(shohinList);
        ApexPages.currentPage().getParameters().put('accountId', 'null');
        ApexPages.currentPage().getParameters().put('juchuId', juchuList[0].id);
        J02_ShohinShizaiMControllerExtension extension = new J02_ShohinShizaiMControllerExtension(ssc);
        
        extension.init();
        extension.init();
        ApexPages.currentPage().getParameters().put('retUrl', 'hogeaccountIdhoge');
        extension.ikkatsuHensyuButton();
        
        Test.stopTest();
    }
    
    // 取引先データボタンから遷移するパターン（売掛データなし）
    static testMethod void myUnitTest2() {

        // 請求書明細最大行数
        SystemParam__c SysParam = SystemParam__c.getOrgDefaults();
        SysParam.JuchuMeisaiIkkatsuTsuikaJogen__c = 35;
        insert SysParam;

        // 商品資材作成
        List<ShohinShizaiM__c> shohinList = new List<ShohinShizaiM__c>();
        shohinList.add(new ShohinShizaiM__c(name = 'テスト商品1'));
        insert shohinList;
        
        // 取引先作成
        List<Account> accList = new List<Account>();
        accList.add(new Account(name = '株式会社テスト1', Shimebi__c = 20, Kijitsu__c = 15, AccountTankaMHuyouFlg__c = true));
        insert accList;
        
        Test.startTest();
        
        ApexPages.StandardSetController ssc = new ApexPages.StandardSetController(DataBase.query('select id from ShohinShizaiM__c'));
        // 選択するレコードを設定
        ssc.setSelected(shohinList);
        ApexPages.currentPage().getParameters().put('accountId', accList[0].Id);
        ApexPages.currentPage().getParameters().put('juchuId', 'null');
        J02_ShohinShizaiMControllerExtension extension = new J02_ShohinShizaiMControllerExtension(ssc);
        
        extension.init();
        ApexPages.currentPage().getParameters().put('retUrl', 'hogeaccountIdhoge');
        extension.ikkatsuHensyuButton();
        
        Test.stopTest();
    }

    
    // 取引先データボタンから遷移するパターン（売掛データあり）
    static testMethod void myUnitTest3() {

        // 請求書明細最大行数
        SystemParam__c SysParam = SystemParam__c.getOrgDefaults();
        SysParam.JuchuMeisaiIkkatsuTsuikaJogen__c = 35;
        insert SysParam;

        // 商品資材作成
        List<ShohinShizaiM__c> shohinList = new List<ShohinShizaiM__c>();
        shohinList.add(new ShohinShizaiM__c(name = 'テスト商品1'));
        insert shohinList;
        
        // 取引先作成
        List<Account> accList = new List<Account>();
        accList.add(new Account(name = '株式会社テスト1', Shimebi__c = 20, Kijitsu__c = 15, AccountTankaMHuyouFlg__c = true));
        insert accList;
        
        // 売掛データ作成
        List<UrikakeData__c> UrikakeList = new List<UrikakeData__c>();
        urikakeList.add(new UrikakeData__c(name = accList[0].Name, SeikyuAccount__c = accList[0].Id, ShimeHizuke__c = Date.today()));
        insert urikakeList;
        
        Test.startTest();
        
        ApexPages.StandardSetController ssc = new ApexPages.StandardSetController(DataBase.query('select id from ShohinShizaiM__c'));
        // 選択するレコードを設定
        ssc.setSelected(shohinList);
        ApexPages.currentPage().getParameters().put('accountId', accList[0].Id);
        ApexPages.currentPage().getParameters().put('juchuId', 'null');
        J02_ShohinShizaiMControllerExtension extension = new J02_ShohinShizaiMControllerExtension(ssc);
        
        extension.init();
        ApexPages.currentPage().getParameters().put('retUrl', 'hogeaccountIdhoge');
        extension.ikkatsuHensyuButton();
        
        Test.stopTest();
    }
    
    // 取引先データボタンから遷移するパターン（都度請求の顧客）
    static testMethod void myUnitTest4() {

        // 請求書明細最大行数
        SystemParam__c SysParam = SystemParam__c.getOrgDefaults();
        SysParam.JuchuMeisaiIkkatsuTsuikaJogen__c = 35;
        insert SysParam;

        // 商品資材作成
        List<ShohinShizaiM__c> shohinList = new List<ShohinShizaiM__c>();
        shohinList.add(new ShohinShizaiM__c(name = 'テスト商品1'));
        insert shohinList;
        
        // 取引先作成
        List<Account> accList = new List<Account>();
        accList.add(new Account(name = '株式会社テスト1', Shimebi__c = 20, Kijitsu__c = 15, AccountTankaMHuyouFlg__c = true));
        insert accList;
        
        Test.startTest();
        
        ApexPages.StandardSetController ssc = new ApexPages.StandardSetController(DataBase.query('select id from ShohinShizaiM__c'));
        // 選択するレコードを設定
        ssc.setSelected(shohinList);
        ApexPages.currentPage().getParameters().put('accountId', accList[0].Id);
        ApexPages.currentPage().getParameters().put('juchuId', 'null');
        J02_ShohinShizaiMControllerExtension extension = new J02_ShohinShizaiMControllerExtension(ssc);
        
        extension.init();
        ApexPages.currentPage().getParameters().put('retUrl', 'hogeaccountIdhoge');
        extension.ikkatsuHensyuButton();
        
        Test.stopTest();
    }
    
    // 取引先単価マスタが存在しないパターンと選択した商品が既に登録されている場合
    static testMethod void myUnitTest5() {

        // 請求書明細最大行数
        SystemParam__c SysParam = SystemParam__c.getOrgDefaults();
        SysParam.JuchuMeisaiIkkatsuTsuikaJogen__c = 35;
        SysParam.JuchuMeisaiSaidaiTorokusu__c = 45;
        insert SysParam;
        
        // 商品資材作成
        ShohinShizaiM__c shohin1 = new ShohinShizaiM__c(name = 'テスト商品1', ShomiKigenNissu__c = 100, AccountTankaMHuyouFlg__c = false);
        ShohinShizaiM__c shohin2 = new ShohinShizaiM__c(name = 'テスト商品2', ShomiKigenNissu__c = 100, AccountTankaMHuyouFlg__c = false);
        insert shohin1;
        insert shohin2;
        
        List<ShohinShizaiM__c> shohinList1 = new List<ShohinShizaiM__c>();
        shohinList1.add(shohin1);
        List<ShohinShizaiM__c> shohinList2 = new List<ShohinShizaiM__c>();
        shohinList2.add(shohin1);
        shohinList2.add(shohin2);
        
        // 取引先作成
        Account acc1 = new Account(name = '株式会社テスト1', Shimebi__c = 20, Kijitsu__c = 15, AccountTankaMHuyouFlg__c = false, JuchusakiChofukuJogaiFlg__c = true);
        insert acc1;

        
        // 取引先単価マスタ作成
        AccountTankaM__c tanka1 = new AccountTankaM__c(Account__c = acc1.Id, ShohinShizaiM__c = shohin1.Id, ShomiKigenKakuhoNissu__c = 10);
        insert tanka1;

        Test.startTest();

        ApexPages.StandardSetController ssc = new ApexPages.StandardSetController(DataBase.query('select id from ShohinShizaiM__c'));
        // 選択するレコードを設定
        ssc.setSelected(shohinList1);
        ApexPages.currentPage().getParameters().put('accountId', acc1.Id);
        ApexPages.currentPage().getParameters().put('juchuId', 'null');
        J02_ShohinShizaiMControllerExtension extension = new J02_ShohinShizaiMControllerExtension(ssc);
        
        extension.init();
        ApexPages.currentPage().getParameters().put('retUrl', 'hogeaccountIdhoge');
        extension.ikkatsuHensyuButton();
        
        // 選択するレコードを設定
        ssc.setSelected(shohinList2);
        ApexPages.currentPage().getParameters().put('accountId', acc1.Id);
        ApexPages.currentPage().getParameters().put('juchuId', 'null');
        extension = new J02_ShohinShizaiMControllerExtension(ssc);
        
        extension.init();
        ApexPages.currentPage().getParameters().put('retUrl', 'hogeaccountIdhoge');
        extension.ikkatsuHensyuButton();

        // 選択するレコードを設定
        ssc.setSelected(shohinList2);
        ApexPages.currentPage().getParameters().put('accountId', 'null');
        JuchuData__c juchu = [SELECT ID FROM JuchuData__c LIMIT 1];
        ApexPages.currentPage().getParameters().put('juchuId', juchu.Id);
        extension = new J02_ShohinShizaiMControllerExtension(ssc);
        
        extension.init();
        ApexPages.currentPage().getParameters().put('retUrl', 'hogeaccountIdhoge');
        extension.ikkatsuHensyuButton();
        
        Test.stopTest();

    }
}