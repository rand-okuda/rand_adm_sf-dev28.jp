@isTest
private class Z04_ZaikoidouTourokuControllerExtensTest {

    static testMethod void myUnitTest1() {

        // 商品資材作成
        ShohinShizaiM__c shohin1 = new ShohinShizaiM__c(name = 'テスト商品1', ShomiKigenNissu__c = 100);
        insert shohin1;
        
        // 取引先作成
        Account acc1 = new Account(name = 'テスト倉庫');
        Account acc2 = new Account(name = 'テスト移動先');
        insert acc1;
        insert acc2;

        // 在庫データ作成
        List<ZaikoData__c> zaikoList = new List<ZaikoData__c>();
        ZaikoData__c zaiko1 = new ZaikoData__c(ZaikoSuryo__c = 10, name = 'a', ShohinShizaiM__c = shohin1.Id, Zaikobasho__c = acc1.Id, ShomiKigen__c = Date.newInstance(2016, 1, 1), NyukoFlg__c = true);
        zaikoList.add(zaiko1);
        insert zaikoList;

        // 空在庫データ作成
        List<ZaikoData__c> nullZaikoList = new List<ZaikoData__c>();


        Test.startTest();

        ApexPages.StandardSetController ssc = new ApexPages.StandardSetController(DataBase.query('select id from ZaikoData__c'));
        Z04_ZaikoidouTourokuControllerExtension extension = new Z04_ZaikoidouTourokuControllerExtension(ssc);
        ApexPages.currentPage().getParameters().put('retUrl', 'XXX');

        // 選択するレコード無
        ssc.setSelected(nullZaikoList);
        extension = new Z04_ZaikoidouTourokuControllerExtension(ssc);
        extension.init();

        // 選択するレコードを設定
        ssc.setSelected(zaikoList);
        extension = new Z04_ZaikoidouTourokuControllerExtension(ssc);
        extension.init();

        // 正常：クリアボタン押下
        extension.clearButton();

        // エラー：各種値が未入力
        extension.jikkouButton();
        
        // エラー：在庫数量 < 移動数量
        extension.targetDispZaikoList[0].idouSuryo = 100;
        extension.jikkouButton();

        // 正常：キャンセルボタン押下
        extension.cancelButton();
        
        // 正常：移動が実行される
        extension.targetDispZaikoList[0].idouSuryo = 1;
        extension.targetDispZaikoList[0].newZaiko.ZenShukkoNichiji__c = date.today();
        extension.targetDispZaikoList[0].newZaiko.Zaikobasho__c = acc2.Id;
        extension.jikkouButton();
        
        Test.stopTest();
       
    }
    
    // 移動場所（一括）を使用したパターン
    static testMethod void myUnitTest2() {
        
        // 商品資材作成
        ShohinShizaiM__c shohin1 = new ShohinShizaiM__c(name = 'テスト商品1', ShomiKigenNissu__c = 100);
        insert shohin1;
        
        // 取引先作成
        Account acc1 = new Account(name = 'テスト倉庫');
        Account acc2 = new Account(name = 'テスト移動先');
        insert acc1;
        insert acc2;

        // 在庫データ作成
        List<ZaikoData__c> zaikoList = new List<ZaikoData__c>();
        ZaikoData__c zaiko1 = new ZaikoData__c(ZaikoSuryo__c = 10, name = 'a', ShohinShizaiM__c = shohin1.Id, Zaikobasho__c = acc1.Id, ShomiKigen__c = Date.newInstance(2016, 1, 1), NyukoFlg__c = true);
        zaikoList.add(zaiko1);
        insert zaikoList;
                

        Test.startTest();

        // 画面起動
        ApexPages.StandardSetController ssc = new ApexPages.StandardSetController(DataBase.query('select id from ZaikoData__c'));
        Z04_ZaikoidouTourokuControllerExtension extension = new Z04_ZaikoidouTourokuControllerExtension(ssc);

        // 選択するレコードを設定
        ssc.setSelected(zaikoList);
        extension = new Z04_ZaikoidouTourokuControllerExtension(ssc);
        extension.init();

        // 正常：クリアボタン押下
        extension.clearButton();
        
        // 正常：移動が実行される
        extension.allMove = TRUE;
        extension.allSelect.ZenShukkoNichiji__c = date.today();
        extension.allSelect.Zaikobasho__c = acc2.Id;
        extension.jikkouButton();
        
        Test.stopTest();
       
    }
}