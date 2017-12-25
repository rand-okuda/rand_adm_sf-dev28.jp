@isTest
private class J22_NohinshoControllerTest {
    // 在庫データが存在する場合
    static testMethod void myUnitTest1() {

        // 明細最大表示件数
        insert new SystemParam__c(NohinshoMeisaiMaxNum__c = 6);
        
        // 取引先作成
        List<Account> accList = new List<Account>();
        accList.add(new Account(name = '株式会社テスト20150213J22', Type = '納品先', AccountTankaMHuyouFlg__c = true));
        insert accList;
        
        // 売掛データ作成
        List<UrikakeData__c> urikakeList = new List<UrikakeData__c>();
        urikakeList.add(new UrikakeData__c(name = '売掛データテスト20150213J22', SeikyuAccount__c = accList[0].Id));
        insert urikakeList;
        
        // 受注データ作成
        List<JuchuData__c> juchuList = new List<JuchuData__c>();
        juchuList.add(new JuchuData__c(name = '受注データテスト20150213J22', UrikakeData__c = urikakeList[0].Id));
        insert juchuList;
        
        // 商品資材マスタ作成
        List<ShohinShizaiM__c> shohinList = new List<ShohinShizaiM__c>();
        shohinList.add(new ShohinShizaiM__c(name = '商品資材名テスト20150213J221'));
        shohinList.add(new ShohinShizaiM__c(name = '商品資材名テスト20150213J222'));
        shohinList.add(new ShohinShizaiM__c(name = '商品資材名テスト20150213J223'));
        shohinList.add(new ShohinShizaiM__c(name = '商品資材名テスト20150213J224'));
        shohinList.add(new ShohinShizaiM__c(name = '商品資材名テスト20150213J225'));
        shohinList.add(new ShohinShizaiM__c(name = '商品資材名テスト20150213J226'));
        shohinList.add(new ShohinShizaiM__c(name = '商品資材名テスト20150213J227'));
        shohinList.add(new ShohinShizaiM__c(name = '商品資材名テスト20150213J228'));
        insert shohinList;
        
        // 受注明細データ作成
        List<JuchuMeisaiData__c> meisaiList = new List<JuchuMeisaiData__c>();
        meisaiList.add(new JuchuMeisaiData__c(
            name = '受注明細データテスト20150213J2201', 
            JuchuData__c = juchuList[0].Id,
            ShohinShizaiM__c = shohinList[0].Id,
            MeisaiJyogai__c = False,
            NohinJogai__c = FALSE
            ));
        meisaiList.add(new JuchuMeisaiData__c(
            name = '受注明細データテスト20150213J2202', 
            JuchuData__c = juchuList[0].Id,
            ShohinShizaiM__c = shohinList[1].Id,
            MeisaiJyogai__c = False,
            NohinJogai__c = FALSE
            ));
        meisaiList.add(new JuchuMeisaiData__c(
            name = '受注明細データテスト20150213J2203', 
            JuchuData__c = juchuList[0].Id,
            ShohinShizaiM__c = shohinList[2].Id,
            MeisaiJyogai__c = False,
            NohinJogai__c = FALSE
            ));
        meisaiList.add(new JuchuMeisaiData__c(
            name = '受注明細データテスト20150213J2204', 
            JuchuData__c = juchuList[0].Id,
            ShohinShizaiM__c = shohinList[3].Id,
            MeisaiJyogai__c = False,
            NohinJogai__c = FALSE
            ));
        meisaiList.add(new JuchuMeisaiData__c(
            name = '受注明細データテスト20150213J2205', 
            JuchuData__c = juchuList[0].Id,
            ShohinShizaiM__c = shohinList[4].Id,
            MeisaiJyogai__c = False,
            NohinJogai__c = FALSE
            ));
        meisaiList.add(new JuchuMeisaiData__c(
            name = '受注明細データテスト20150213J2206', 
            JuchuData__c = juchuList[0].Id,
            ShohinShizaiM__c = shohinList[5].Id,
            MeisaiJyogai__c = False,
            NohinJogai__c = FALSE
            ));
        meisaiList.add(new JuchuMeisaiData__c(
            name = '受注明細データテスト20150213J2207', 
            JuchuData__c = juchuList[0].Id,
            ShohinShizaiM__c = shohinList[6].Id,
            MeisaiJyogai__c = False,
            NohinJogai__c = FALSE
            ));
        meisaiList.add(new JuchuMeisaiData__c(
            name = '受注明細データテスト20150213J2208', 
            JuchuData__c = juchuList[0].Id,
            ShohinShizaiM__c = shohinList[7].Id,
            MeisaiJyogai__c = False,
            NohinJogai__c = FALSE
            ));

        insert meisaiList;
        
        // 在庫データ作成
        List<ZaikoData__c> zaikoList = new List<ZaikoData__c>();
        zaikoList.add(new ZaikoData__c(name = '在庫データテスト20150213J2201', ShohinShizaiM__c = shohinList[0].Id, JuchuMeisai__c = meisaiList[0].Id));
        zaikoList.add(new ZaikoData__c(name = '在庫データテスト20150213J2202', ShohinShizaiM__c = shohinList[1].Id, JuchuMeisai__c = meisaiList[1].Id));
        zaikoList.add(new ZaikoData__c(name = '在庫データテスト20150213J2203', ShohinShizaiM__c = shohinList[2].Id, JuchuMeisai__c = meisaiList[2].Id));
        zaikoList.add(new ZaikoData__c(name = '在庫データテスト20150213J2204', ShohinShizaiM__c = shohinList[3].Id, JuchuMeisai__c = meisaiList[3].Id));
        zaikoList.add(new ZaikoData__c(name = '在庫データテスト20150213J2205', ShohinShizaiM__c = shohinList[4].Id, JuchuMeisai__c = meisaiList[4].Id));
        zaikoList.add(new ZaikoData__c(name = '在庫データテスト20150213J2206', ShohinShizaiM__c = shohinList[5].Id, JuchuMeisai__c = meisaiList[5].Id));
        zaikoList.add(new ZaikoData__c(name = '在庫データテスト20150213J2207', ShohinShizaiM__c = shohinList[6].Id, JuchuMeisai__c = meisaiList[6].Id));
        zaikoList.add(new ZaikoData__c(name = '在庫データテスト20150213J2208', ShohinShizaiM__c = shohinList[7].Id, JuchuMeisai__c = meisaiList[7].Id));
        zaikoList.add(new ZaikoData__c(name = '在庫データテスト20150213J2209', ShohinShizaiM__c = shohinList[7].Id, JuchuMeisai__c = meisaiList[7].Id));
        zaikoList.add(new ZaikoData__c(name = '在庫データテスト20150213J220a', ShohinShizaiM__c = shohinList[7].Id, JuchuMeisai__c = meisaiList[7].Id));
        zaikoList.add(new ZaikoData__c(name = '在庫データテスト20150213J220b', ShohinShizaiM__c = shohinList[7].Id, JuchuMeisai__c = meisaiList[7].Id));
        zaikoList.add(new ZaikoData__c(name = '在庫データテスト20150213J220c', ShohinShizaiM__c = shohinList[7].Id, JuchuMeisai__c = meisaiList[7].Id));
        zaikoList.add(new ZaikoData__c(name = '在庫データテスト20150213J220d', ShohinShizaiM__c = shohinList[7].Id, JuchuMeisai__c = meisaiList[7].Id));
        zaikoList.add(new ZaikoData__c(name = '在庫データテスト20150213J220e', ShohinShizaiM__c = shohinList[7].Id, JuchuMeisai__c = meisaiList[7].Id));
        zaikoList.add(new ZaikoData__c(name = '在庫データテスト20150213J220f', ShohinShizaiM__c = shohinList[7].Id, JuchuMeisai__c = meisaiList[7].Id));
        zaikoList.add(new ZaikoData__c(name = '在庫データテスト20150213J220g', ShohinShizaiM__c = shohinList[7].Id, JuchuMeisai__c = meisaiList[7].Id));
        zaikoList.add(new ZaikoData__c(name = '在庫データテスト20150213J220h', ShohinShizaiM__c = shohinList[7].Id, JuchuMeisai__c = meisaiList[7].Id));
        zaikoList.add(new ZaikoData__c(name = '在庫データテスト20150213J220i', ShohinShizaiM__c = shohinList[7].Id, JuchuMeisai__c = meisaiList[7].Id));
        zaikoList.add(new ZaikoData__c(name = '在庫データテスト20150213J220j', ShohinShizaiM__c = shohinList[7].Id, JuchuMeisai__c = meisaiList[7].Id));
        insert zaikoList;
        
        Test.startTest();

        // 受注データIDをURLに設定
        Test.setCurrentPage(Page.J22_Nohinsho);   
        ApexPages.currentPage().getParameters().put('JdId', juchuList[0].Id);

        J22_NohinshoController controller = new J22_NohinshoController();
        controller.doUpdate();
        
        Test.stopTest();
    }
    
    
    // 在庫データが存在しない場合
    static testMethod void myUnitTest2() {

        // 明細最大表示件数
        insert new SystemParam__c(NohinshoMeisaiMaxNum__c = 2);
        
        // 取引先作成
        List<Account> accList = new List<Account>();
        accList.add(new Account(name = '株式会社テスト20150213J2202', Type = '納品先', AccountTankaMHuyouFlg__c = true));
        insert accList;
        
        // 売掛データ作成
        List<UrikakeData__c> urikakeList = new List<UrikakeData__c>();
        urikakeList.add(new UrikakeData__c(name = '売掛データテスト20150213J2202', SeikyuAccount__c = accList[0].Id));
        insert urikakeList;
        
        // 受注データ作成
        List<JuchuData__c> juchuList = new List<JuchuData__c>();
        juchuList.add(new JuchuData__c(name = '受注データテスト20150213J2202', UrikakeData__c = urikakeList[0].Id));
        insert juchuList;
        
        Test.startTest();

        // 受注データIDをURLに設定
        Test.setCurrentPage(Page.J22_Nohinsho);   
        ApexPages.currentPage().getParameters().put('JdId', juchuList[0].Id);

        J22_NohinshoController controller = new J22_NohinshoController();
        controller.doUpdate();

        Integer nohinshoFontSize = controller.nohinshoFontSize;
        
        Test.stopTest();
    }
}