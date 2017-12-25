@isTest
private class HachuDataTriggerHandlerTest {

    static testMethod void myUnitTest1() {
        // 取引先作成
        Account acc1 = new Account(name = '株式会社テスト1', Shimebi__c = 20, Kijitsu__c = 15, Type= '仕入先');
        Account acc3 = new Account(name = '株式会社テスト1', Shimebi__c = 20, Kijitsu__c = 15, Type= '仕入先');
        insert acc1;
        insert acc3;
        
        // 納品先作成
        Account acc2 = new Account(Name = 'テスト納品先', Shimebi__c = 20, Kijitsu__c = 15, Type= '納品先');
        insert acc2;
        
        // 商品資材作成
        ShohinShizaiM__c shohin = new ShohinShizaiM__c(name = 'テスト商品1', HatchuJidoNyuko__c = true, YukoZaikoYotei__c = true);
        insert shohin;

        // 発注データ作成
        HachuData__c hachu = new HachuData__c (shiiresaki__c = acc1.Id, Nohinsaki__c = acc2.Id );
        insert hachu;
        
        // 発注明細データ作成
        HachuMeisaiData__c meisai = new HachuMeisaiData__c(HachuData__c = hachu.Id, ShohinShizaiM__c = shohin.Id, HachuSuryoPC__c = 1, KonyuKakaku__c = 123);
        insert meisai;
        update meisai;
        
        
        Test.startTest();
        
        // 発注データ更新
        hachu.HachuKakuteiFlg__c = true;
        update hachu;
                
        // 発注データ作成
        HachuData__c hachu2 = new HachuData__c (shiiresaki__c = acc1.Id, Nohinsaki__c = acc2.Id );
        insert hachu2;
        
        // 発注明細データ作成
        HachuMeisaiData__c meisai2 = new HachuMeisaiData__c(HachuData__c = hachu2.Id, ShohinShizaiM__c = shohin.Id, HachuSuryoPC__c = 1, KonyuKakaku__c = 123);
        insert meisai2;
        update meisai2;
        
        // 発注データ更新
        hachu2.HachuKakuteiFlg__c = true;
        update hachu2;
                
        // 発注データ作成
        HachuData__c hachu3 = new HachuData__c (shiiresaki__c = acc3.Id, Nohinsaki__c = acc2.Id );
        insert hachu3;
        
        // 発注明細データ作成
        HachuMeisaiData__c meisai3 = new HachuMeisaiData__c(HachuData__c = hachu3.Id, ShohinShizaiM__c = shohin.Id, HachuSuryoPC__c = 1, KonyuKakaku__c = 123);
        insert meisai3;
        update meisai3;
        
        // 発注データ更新
        hachu3.HachuKakuteiFlg__c = true;
        update hachu3;

        // 発注データ削除
        delete hachu;
        delete hachu2;
        delete hachu3;
                
        Test.stopTest();

    }
}