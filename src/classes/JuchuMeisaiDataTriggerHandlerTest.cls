@isTest
private class JuchuMeisaiDataTriggerHandlerTest {
    
    static testMethod void myUnitTest1() {
        // 取引先作成
        List<Account> accList = new List<Account>();
        accList.add(new Account(name = '株式会社テスト20150216J05', Type = '納品先', AccountTankaMHuyouFlg__c = true));
        insert accList;
        
        // 売掛データ作成
        List<UrikakeData__c> urikakeList = new List<UrikakeData__c>();
        urikakeList.add(new UrikakeData__c(name = '売掛データテスト20150216J05', SeikyuAccount__c = accList[0].Id));
        insert urikakeList;
        
        // 受注データ作成
        List<JuchuData__c> juchuList = new List<JuchuData__c>();
        juchuList.add(new JuchuData__c(name = '受注データテスト20150216J05', UrikakeData__c = urikakeList[0].Id, 
            Juchusaki__c = accList[0].Id, NohinYoteibi__c = Date.newInstance(2015, 2, 15)) );
        insert juchuList;
        
        // 商品資材マスタ作成
        List<ShohinShizaiM__c> shohinList = new List<ShohinShizaiM__c>();
        shohinList.add(new ShohinShizaiM__c(name = '商品資材名テスト20150216J05_1', AccountTankaMHuyouFlg__c = true));
        shohinList.add(new ShohinShizaiM__c(name = '商品資材名テスト20150216J05_2'));
        shohinList.add(new ShohinShizaiM__c(name = '商品資材名テスト20150216J05_3'));
        insert shohinList;
        
        // 取引先単価マスタデータ作成
        List<AccountTankaM__c> accMList = new List<AccountTankaM__c>();
        accMList.add(new AccountTankaM__c(Account__c = accList[0].Id, ShohinShizaiM__c = shohinList[0].Id, 
            TekiyoKikanKara__c = Date.newInstance(2015, 2, 1), TekiyoKikanMade__c = Date.newInstance(2015, 2, 28)));
        insert accMList;

        Test.startTest();

        // 受注明細データ作成
        List<JuchuMeisaiData__c> meisaiList1 = new List<JuchuMeisaiData__c>();
        meisaiList1.add(new JuchuMeisaiData__c(
            name = '受注明細データテスト20150216J0501a', 
            JuchuData__c = juchuList[0].Id,
            ShohinShizaiM__c = shohinList[0].Id
            ));
        insert meisaiList1;
                
        JuchuMeisaiData__c meisai1 = new JuchuMeisaiData__c();
        meisai1.name = '受注明細データテスト20150216J0502';
        meisai1.JuchuData__c = juchuList[0].Id;
        meisai1.ShohinShizaiM__c = shohinList[1].Id;
        insert meisai1;
        meisai1.ShohinShizaiM__c = shohinList[2].Id;
        update meisai1;

        delete meisai1;

        Test.stopTest();
    }

    static testMethod void myUnitTest2() {
        // 取引先作成
        List<Account> accList = new List<Account>();
        accList.add(new Account(name = '株式会社テスト20150216J05', Type = '納品先', AccountTankaMHuyouFlg__c = true));
        insert accList;
        
        // 売掛データ作成
        List<UrikakeData__c> urikakeList = new List<UrikakeData__c>();
        urikakeList.add(new UrikakeData__c(name = '売掛データテスト20150216J05', SeikyuAccount__c = accList[0].Id));
        insert urikakeList;
        
        // 受注データ作成
        List<JuchuData__c> juchuList = new List<JuchuData__c>();
        juchuList.add(new JuchuData__c(name = '受注データテスト20150216J05', UrikakeData__c = urikakeList[0].Id, 
            Juchusaki__c = accList[0].Id, NohinYoteibi__c = Date.newInstance(2015, 2, 15)) );
        insert juchuList;
        
        // 商品資材マスタ作成
        List<ShohinShizaiM__c> shohinList = new List<ShohinShizaiM__c>();
        shohinList.add(new ShohinShizaiM__c(name = '商品資材名テスト20150216J05_1', AccountTankaMHuyouFlg__c = true));
        shohinList.add(new ShohinShizaiM__c(name = '商品資材名テスト20150216J05_2'));
        shohinList.add(new ShohinShizaiM__c(name = '商品資材名テスト20150216J05_3'));
        insert shohinList;
        
        // 取引先単価マスタデータ作成
        List<AccountTankaM__c> accMList = new List<AccountTankaM__c>();
        accMList.add(new AccountTankaM__c(Account__c = accList[0].Id, ShohinShizaiM__c = shohinList[0].Id, 
            TekiyoKikanKara__c = Date.newInstance(2015, 2, 1), TekiyoKikanMade__c = Date.newInstance(2015, 2, 28)));
        insert accMList;

        Test.startTest();

        // 受注明細データ作成
        List<JuchuMeisaiData__c> meisaiList1 = new List<JuchuMeisaiData__c>();
        meisaiList1.add(new JuchuMeisaiData__c(
            name = '受注明細データテスト20150216J0501a', 
            JuchuData__c = juchuList[0].Id,
            ShohinShizaiM__c = shohinList[0].Id
            ));
        meisaiList1.add(new JuchuMeisaiData__c(
            name = '受注明細データテスト20150216J0501b', 
            JuchuData__c = juchuList[0].Id,
            ShohinShizaiM__c = shohinList[1].Id
            ));
        meisaiList1.add(new JuchuMeisaiData__c(
            name = '受注明細データテスト20150216J0501c', 
            JuchuData__c = juchuList[0].Id,
            ShohinShizaiM__c = shohinList[2].Id
            ));
        insert meisaiList1;

        List<JuchuMeisaiData__c> meisaiList2 = new List<JuchuMeisaiData__c>();
        meisaiList2.add(new JuchuMeisaiData__c(
            name = '受注明細データテスト20150216J0501d', 
            JuchuData__c = juchuList[0].Id,
            ShohinShizaiM__c = shohinList[0].Id
            ));
        meisaiList2.add(new JuchuMeisaiData__c(
            name = '受注明細データテスト20150216J0501e', 
            JuchuData__c = juchuList[0].Id,
            ShohinShizaiM__c = shohinList[1].Id
            ));
        meisaiList2.add(new JuchuMeisaiData__c(
            name = '受注明細データテスト20150216J0501f', 
            JuchuData__c = juchuList[0].Id,
            ShohinShizaiM__c = shohinList[2].Id
            ));

        try{
            insert meisaiList2;
        }catch (DmlException e){
            System.debug('### ' + 'DmlException');
        }

        Test.stopTest();
    }

}