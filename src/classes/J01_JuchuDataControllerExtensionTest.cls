@isTest
public class J01_JuchuDataControllerExtensionTest {

    static testMethod void myUnitTest() {

        // カスタム設定
        SystemParam__c SystemParam = SystemParam__c.getOrgDefaults();
        SystemParam.JuchuMeisaiSaidaiTorokusu__c = 45;
        insert SystemParam;

        // 商品資材作成
        List<ShohinShizaiM__c> shohinList = new List<ShohinShizaiM__c>();
        shohinList.add(new ShohinShizaiM__c(name = 'テスト商品1'));
        shohinList.add(new ShohinShizaiM__c(name = 'テスト商品2'));
        shohinList.add(new ShohinShizaiM__c(name = 'テスト商品3'));
        shohinList.add(new ShohinShizaiM__c(name = 'テスト商品4'));
        shohinList.add(new ShohinShizaiM__c(name = 'テスト商品5'));
        shohinList.add(new ShohinShizaiM__c(name = 'テスト商品6'));
        shohinList.add(new ShohinShizaiM__c(name = 'テスト商品7'));
        shohinList.add(new ShohinShizaiM__c(name = 'テスト商品8'));
        shohinList.add(new ShohinShizaiM__c(name = 'テスト商品9'));
        shohinList.add(new ShohinShizaiM__c(name = 'テスト商品10'));
        shohinList.add(new ShohinShizaiM__c(name = 'テスト商品11'));
        insert shohinList;

        // 取引先作成
        Account acc = new Account();
        acc = new Account(name = 'XXX', AccountTankaMHuyouFlg__c = true);
        insert acc;

        // 売掛データ作成
        UrikakeData__c Urikake = new UrikakeData__c();
        urikake = new UrikakeData__c(name = 'XXX', SeikyuAccount__c = acc.Id);
        insert urikake;

        // 受注データ作成
        JuchuData__c juchu = new JuchuData__c();
        juchu = new JuchuData__c(name = 'XXX', UrikakeData__c = urikake.id );
        insert juchu;

        // 受注明細データ作成
        List<JuchuMeisaiData__c> juchuMeisaiDataList = new List<JuchuMeisaiData__c>();
        juchuMeisaiDataList.add(new JuchuMeisaiData__c(name = 'XXXXX', ShohinShizaiM__c = shohinList[0].Id, Biko__c = '', JuchuData__c = juchu.Id));
        juchuMeisaiDataList.add(new JuchuMeisaiData__c(name = 'XXXXX', ShohinShizaiM__c = shohinList[1].Id, Biko__c = '', JuchuData__c = juchu.Id));
        juchuMeisaiDataList.add(new JuchuMeisaiData__c(name = 'XXXXX', ShohinShizaiM__c = shohinList[2].Id, Biko__c = '', JuchuData__c = juchu.Id));
        juchuMeisaiDataList.add(new JuchuMeisaiData__c(name = 'XXXXX', ShohinShizaiM__c = shohinList[3].Id, Biko__c = '', JuchuData__c = juchu.Id));
        juchuMeisaiDataList.add(new JuchuMeisaiData__c(name = 'XXXXX', ShohinShizaiM__c = shohinList[4].Id, Biko__c = '', JuchuData__c = juchu.Id));
        juchuMeisaiDataList.add(new JuchuMeisaiData__c(name = 'XXXXX', ShohinShizaiM__c = shohinList[5].Id, Biko__c = '', JuchuData__c = juchu.Id));
        juchuMeisaiDataList.add(new JuchuMeisaiData__c(name = 'XXXXX', ShohinShizaiM__c = shohinList[6].Id, Biko__c = '', JuchuData__c = juchu.Id));
        juchuMeisaiDataList.add(new JuchuMeisaiData__c(name = 'XXXXX', ShohinShizaiM__c = shohinList[7].Id, Biko__c = '', JuchuData__c = juchu.Id));
        juchuMeisaiDataList.add(new JuchuMeisaiData__c(name = 'XXXXX', ShohinShizaiM__c = shohinList[8].Id, Biko__c = '', JuchuData__c = juchu.Id));
        juchuMeisaiDataList.add(new JuchuMeisaiData__c(name = 'XXXXX', ShohinShizaiM__c = shohinList[9].Id, Biko__c = '', JuchuData__c = juchu.Id));
        juchuMeisaiDataList.add(new JuchuMeisaiData__c(name = 'XXXXX', ShohinShizaiM__c = shohinList[10].Id, Biko__c = '', JuchuData__c = juchu.Id));
        insert juchuMeisaiDataList;

        // テスト実行時の画面を設定
        PageReference pageRef = new PageReference('/' + juchu.Id);
        Test.setCurrentPage(pageRef);

        // コントローラー起動
        ApexPages.Standardcontroller stdController =  new ApexPages.Standardcontroller(juchu);
        J01_JuchuDataControllerExtension extController = new J01_JuchuDataControllerExtension(stdController);
        
        // テスト実行開始
        Test.startTest();

        // 保存ボタン
        extController.saveButton();

        //再表示ボタン
        extController.reDisplay();

        // ページ次ページ
        extController.next();

        // ページ前ページ
        extController.previous();

        // DmlException発生
        extController.targetMeisaiList[0].Biko__c = 'ｱ';
        extController.saveButton();
        
        // テスト実行終了
        Test.stopTest();
        
    }

}