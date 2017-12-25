@isTest
private class N01_SeikyushoControllerTest {
    static testMethod void myUnitTest1() {

        // 取引先作成
        List<Account> accList = new List<Account>();
        accList.add(new Account(name = '株式会社テスト１０２N01', AccountTankaMHuyouFlg__c = true));
        insert accList;
        
        // 売掛データ作成
        List<UrikakeData__c> urikakeList = new List<UrikakeData__c>();
        urikakeList.add(new UrikakeData__c(name = '売掛データテスト１０２N01', SeikyuAccount__c = accList[0].Id));
        insert urikakeList;
        
        // 受注データ作成
        List<JuchuData__c> juchuList = new List<JuchuData__c>();
        juchuList.add(new JuchuData__c(name = '受注データテスト１０２N01', UrikakeData__c = urikakeList[0].Id, JuchuUriageKakuteiFlg__c = false, JuchuUriageKakuteiBi__c = Date.today()));
        juchuList.add(new JuchuData__c(name = '受注データテスト１０２N01', UrikakeData__c = urikakeList[0].Id, JuchuUriageKakuteiFlg__c = false, JuchuUriageKakuteiBi__c = Date.today()));
        juchuList.add(new JuchuData__c(name = '受注データテスト１０２N01', UrikakeData__c = urikakeList[0].Id, JuchuUriageKakuteiFlg__c = false, JuchuUriageKakuteiBi__c = Date.today()));
        juchuList.add(new JuchuData__c(name = '受注データテスト１０２N01', UrikakeData__c = urikakeList[0].Id, JuchuUriageKakuteiFlg__c = false, JuchuUriageKakuteiBi__c = Date.today()));
        insert juchuList;
        
        // 商品資材マスタ作成
        List<ShohinShizaiM__c> shohinList = new List<ShohinShizaiM__c>();
        shohinList.add(new ShohinShizaiM__c(name = '商品資材名テストN011', HyojunBaika__c = 1));
        shohinList.add(new ShohinShizaiM__c(name = '商品資材名テストN012', HyojunBaika__c = 1));
        shohinList.add(new ShohinShizaiM__c(name = '商品資材名テストN013', HyojunBaika__c = 1));
        shohinList.add(new ShohinShizaiM__c(name = '商品資材名テストN014', HyojunBaika__c = 1));
        shohinList.add(new ShohinShizaiM__c(name = '商品資材名テストN015', HyojunBaika__c = 1));
        shohinList.add(new ShohinShizaiM__c(name = '商品資材名テストN016', HyojunBaika__c = 1));
        shohinList.add(new ShohinShizaiM__c(name = '商品資材名テストN017', HyojunBaika__c = 1));
        shohinList.add(new ShohinShizaiM__c(name = '商品資材名テストN018', HyojunBaika__c = 1));
        shohinList.add(new ShohinShizaiM__c(name = '商品資材名テストN019', HyojunBaika__c = 1));
        shohinList.add(new ShohinShizaiM__c(name = '商品資材名テストN01a', HyojunBaika__c = 1));
        shohinList.add(new ShohinShizaiM__c(name = '商品資材名テストN01b', HyojunBaika__c = 1));
        shohinList.add(new ShohinShizaiM__c(name = '商品資材名テストN01c', HyojunBaika__c = 1));
        insert shohinList;

        // 取引先単価マスタ
        List<AccountTankaM__c> tankMList = new List<AccountTankaM__c>();
        tankMList.add(new AccountTankaM__c(NohinKakaku__c = 123.00, Account__c = accList[0].Id, ShohinShizaiM__c = shohinList[0].Id));
        tankMList.add(new AccountTankaM__c(NohinKakaku__c = 123.00, Account__c = accList[0].Id, ShohinShizaiM__c = shohinList[1].Id));
        tankMList.add(new AccountTankaM__c(NohinKakaku__c = 123.00, Account__c = accList[0].Id, ShohinShizaiM__c = shohinList[2].Id));
        tankMList.add(new AccountTankaM__c(NohinKakaku__c = 123.00, Account__c = accList[0].Id, ShohinShizaiM__c = shohinList[3].Id));
        tankMList.add(new AccountTankaM__c(NohinKakaku__c = 123.00, Account__c = accList[0].Id, ShohinShizaiM__c = shohinList[4].Id));
        tankMList.add(new AccountTankaM__c(NohinKakaku__c = 123.00, Account__c = accList[0].Id, ShohinShizaiM__c = shohinList[5].Id));
        tankMList.add(new AccountTankaM__c(NohinKakaku__c = 123.00, Account__c = accList[0].Id, ShohinShizaiM__c = shohinList[6].Id));
        tankMList.add(new AccountTankaM__c(NohinKakaku__c = 123.00, Account__c = accList[0].Id, ShohinShizaiM__c = shohinList[7].Id));
        tankMList.add(new AccountTankaM__c(NohinKakaku__c = 123.00, Account__c = accList[0].Id, ShohinShizaiM__c = shohinList[8].Id));
        tankMList.add(new AccountTankaM__c(NohinKakaku__c = 123.00, Account__c = accList[0].Id, ShohinShizaiM__c = shohinList[9].Id));
        tankMList.add(new AccountTankaM__c(NohinKakaku__c = 123.00, Account__c = accList[0].Id, ShohinShizaiM__c = shohinList[10].Id));
        tankMList.add(new AccountTankaM__c(NohinKakaku__c = 123.00, Account__c = accList[0].Id, ShohinShizaiM__c = shohinList[11].Id));
        insert tankMList;

        
        // 受注明細データ作成
        List<JuchuMeisaiData__c> meisaiList = new List<JuchuMeisaiData__c>();
        meisaiList.add(new JuchuMeisaiData__c(name = '受注明細データテスト１０２N01', JuchuData__c = juchuList[0].Id, TorihikisakiTanka__c = tankMList[0].Id, MeisaiJyogai__c = False, JuchuSuryo__c  = 5, Shohizeiritsu__c = 0.08, ShohinShizaiM__c = shohinList[0].Id));
        meisaiList.add(new JuchuMeisaiData__c(name = '受注明細データテスト１０２N01', JuchuData__c = juchuList[0].Id, TorihikisakiTanka__c = tankMList[1].Id, MeisaiJyogai__c = False, JuchuSuryo__c  = 5, Shohizeiritsu__c = 0.08, ShohinShizaiM__c = shohinList[1].Id));
        meisaiList.add(new JuchuMeisaiData__c(name = '受注明細データテスト１０２N01', JuchuData__c = juchuList[0].Id, TorihikisakiTanka__c = tankMList[2].Id, MeisaiJyogai__c = False, JuchuSuryo__c  = 5, Shohizeiritsu__c = 0.08, ShohinShizaiM__c = shohinList[2].Id));
        meisaiList.add(new JuchuMeisaiData__c(name = '受注明細データテスト１０２N01', JuchuData__c = juchuList[0].Id, TorihikisakiTanka__c = tankMList[3].Id, MeisaiJyogai__c = False, JuchuSuryo__c  = 5, Shohizeiritsu__c = 0.08, ShohinShizaiM__c = shohinList[3].Id));
        meisaiList.add(new JuchuMeisaiData__c(name = '受注明細データテスト１０２N01', JuchuData__c = juchuList[0].Id, TorihikisakiTanka__c = tankMList[4].Id, MeisaiJyogai__c = False, JuchuSuryo__c  = 5, Shohizeiritsu__c = 0.08, ShohinShizaiM__c = shohinList[4].Id));
        meisaiList.add(new JuchuMeisaiData__c(name = '受注明細データテスト１０２N01', JuchuData__c = juchuList[0].Id, TorihikisakiTanka__c = tankMList[5].Id, MeisaiJyogai__c = False, JuchuSuryo__c  = 5, Shohizeiritsu__c = 0.08, ShohinShizaiM__c = shohinList[5].Id));
        meisaiList.add(new JuchuMeisaiData__c(name = '受注明細データテスト１０２N01', JuchuData__c = juchuList[0].Id, TorihikisakiTanka__c = tankMList[6].Id, MeisaiJyogai__c = False, JuchuSuryo__c  = 5, Shohizeiritsu__c = 0.08, ShohinShizaiM__c = shohinList[6].Id));
        meisaiList.add(new JuchuMeisaiData__c(name = '受注明細データテスト１０２N01', JuchuData__c = juchuList[0].Id, TorihikisakiTanka__c = tankMList[7].Id, MeisaiJyogai__c = False, JuchuSuryo__c  = 5, Shohizeiritsu__c = 0.08, ShohinShizaiM__c = shohinList[7].Id));
        meisaiList.add(new JuchuMeisaiData__c(name = '受注明細データテスト１０２N01', JuchuData__c = juchuList[0].Id, TorihikisakiTanka__c = tankMList[8].Id, MeisaiJyogai__c = False, JuchuSuryo__c  = 5, Shohizeiritsu__c = 0.08, ShohinShizaiM__c = shohinList[8].Id));
        meisaiList.add(new JuchuMeisaiData__c(name = '受注明細データテスト１０２N01', JuchuData__c = juchuList[0].Id, TorihikisakiTanka__c = tankMList[9].Id, MeisaiJyogai__c = False, JuchuSuryo__c  = 5, Shohizeiritsu__c = 0.08, ShohinShizaiM__c = shohinList[9].Id));
        meisaiList.add(new JuchuMeisaiData__c(name = '受注明細データテスト１０２N01', JuchuData__c = juchuList[0].Id, TorihikisakiTanka__c = tankMList[10].Id, MeisaiJyogai__c = False, JuchuSuryo__c  = 5, Shohizeiritsu__c = 0.08, ShohinShizaiM__c = shohinList[10].Id));
        meisaiList.add(new JuchuMeisaiData__c(name = '受注明細データテスト１０２N01', JuchuData__c = juchuList[0].Id, TorihikisakiTanka__c = tankMList[11].Id, MeisaiJyogai__c = False, JuchuSuryo__c  = 5, Shohizeiritsu__c = 0.08, ShohinShizaiM__c = shohinList[11].Id));
        meisaiList.add(new JuchuMeisaiData__c(name = '受注明細データテスト１０２N01', JuchuData__c = juchuList[1].Id, TorihikisakiTanka__c = tankMList[0].Id, MeisaiJyogai__c = False, JuchuSuryo__c  = 5, Shohizeiritsu__c = 0.08, ShohinShizaiM__c = shohinList[0].Id));
        meisaiList.add(new JuchuMeisaiData__c(name = '受注明細データテスト１０２N01', JuchuData__c = juchuList[1].Id, TorihikisakiTanka__c = tankMList[1].Id, MeisaiJyogai__c = False, JuchuSuryo__c  = 5, Shohizeiritsu__c = 0.08, ShohinShizaiM__c = shohinList[1].Id));
        meisaiList.add(new JuchuMeisaiData__c(name = '受注明細データテスト１０２N01', JuchuData__c = juchuList[1].Id, TorihikisakiTanka__c = tankMList[2].Id, MeisaiJyogai__c = False, JuchuSuryo__c  = 5, Shohizeiritsu__c = 0.08, ShohinShizaiM__c = shohinList[2].Id));
        meisaiList.add(new JuchuMeisaiData__c(name = '受注明細データテスト１０２N01', JuchuData__c = juchuList[1].Id, TorihikisakiTanka__c = tankMList[3].Id, MeisaiJyogai__c = False, JuchuSuryo__c  = 5, Shohizeiritsu__c = 0.08, ShohinShizaiM__c = shohinList[3].Id));
        meisaiList.add(new JuchuMeisaiData__c(name = '受注明細データテスト１０２N01', JuchuData__c = juchuList[1].Id, TorihikisakiTanka__c = tankMList[4].Id, MeisaiJyogai__c = False, JuchuSuryo__c  = 5, Shohizeiritsu__c = 0.08, ShohinShizaiM__c = shohinList[4].Id));
        meisaiList.add(new JuchuMeisaiData__c(name = '受注明細データテスト１０２N01', JuchuData__c = juchuList[1].Id, TorihikisakiTanka__c = tankMList[5].Id, MeisaiJyogai__c = False, JuchuSuryo__c  = 5, Shohizeiritsu__c = 0.08, ShohinShizaiM__c = shohinList[5].Id));
        meisaiList.add(new JuchuMeisaiData__c(name = '受注明細データテスト１０２N01', JuchuData__c = juchuList[1].Id, TorihikisakiTanka__c = tankMList[6].Id, MeisaiJyogai__c = False, JuchuSuryo__c  = 5, Shohizeiritsu__c = 0.08, ShohinShizaiM__c = shohinList[6].Id));
        meisaiList.add(new JuchuMeisaiData__c(name = '受注明細データテスト１０２N01', JuchuData__c = juchuList[1].Id, TorihikisakiTanka__c = tankMList[7].Id, MeisaiJyogai__c = False, JuchuSuryo__c  = 5, Shohizeiritsu__c = 0.08, ShohinShizaiM__c = shohinList[7].Id));
        meisaiList.add(new JuchuMeisaiData__c(name = '受注明細データテスト１０２N01', JuchuData__c = juchuList[1].Id, TorihikisakiTanka__c = tankMList[8].Id, MeisaiJyogai__c = False, JuchuSuryo__c  = 5, Shohizeiritsu__c = 0.08, ShohinShizaiM__c = shohinList[8].Id));
        meisaiList.add(new JuchuMeisaiData__c(name = '受注明細データテスト１０２N01', JuchuData__c = juchuList[1].Id, TorihikisakiTanka__c = tankMList[9].Id, MeisaiJyogai__c = False, JuchuSuryo__c  = 5, Shohizeiritsu__c = 0.08, ShohinShizaiM__c = shohinList[9].Id));
        meisaiList.add(new JuchuMeisaiData__c(name = '受注明細データテスト１０２N01', JuchuData__c = juchuList[1].Id, TorihikisakiTanka__c = tankMList[10].Id, MeisaiJyogai__c = False, JuchuSuryo__c  = 5, Shohizeiritsu__c = 0.08, ShohinShizaiM__c = shohinList[10].Id));
        meisaiList.add(new JuchuMeisaiData__c(name = '受注明細データテスト１０２N01', JuchuData__c = juchuList[1].Id, TorihikisakiTanka__c = tankMList[11].Id, MeisaiJyogai__c = False, JuchuSuryo__c  = 5, Shohizeiritsu__c = 0.08, ShohinShizaiM__c = shohinList[11].Id));
        meisaiList.add(new JuchuMeisaiData__c(name = '受注明細データテスト１０２N01', JuchuData__c = juchuList[2].Id, TorihikisakiTanka__c = tankMList[0].Id, MeisaiJyogai__c = False, JuchuSuryo__c  = 5, Shohizeiritsu__c = 0.08, ShohinShizaiM__c = shohinList[0].Id));
        meisaiList.add(new JuchuMeisaiData__c(name = '受注明細データテスト１０２N01', JuchuData__c = juchuList[2].Id, TorihikisakiTanka__c = tankMList[1].Id, MeisaiJyogai__c = False, JuchuSuryo__c  = 5, Shohizeiritsu__c = 0.08, ShohinShizaiM__c = shohinList[1].Id));
        meisaiList.add(new JuchuMeisaiData__c(name = '受注明細データテスト１０２N01', JuchuData__c = juchuList[2].Id, TorihikisakiTanka__c = tankMList[2].Id, MeisaiJyogai__c = False, JuchuSuryo__c  = 5, Shohizeiritsu__c = 0.08, ShohinShizaiM__c = shohinList[2].Id));
        meisaiList.add(new JuchuMeisaiData__c(name = '受注明細データテスト１０２N01', JuchuData__c = juchuList[2].Id, TorihikisakiTanka__c = tankMList[3].Id, MeisaiJyogai__c = False, JuchuSuryo__c  = 5, Shohizeiritsu__c = 0.08, ShohinShizaiM__c = shohinList[3].Id));
        meisaiList.add(new JuchuMeisaiData__c(name = '受注明細データテスト１０２N01', JuchuData__c = juchuList[2].Id, TorihikisakiTanka__c = tankMList[4].Id, MeisaiJyogai__c = False, JuchuSuryo__c  = 5, Shohizeiritsu__c = 0.08, ShohinShizaiM__c = shohinList[4].Id));
        meisaiList.add(new JuchuMeisaiData__c(name = '受注明細データテスト１０２N01', JuchuData__c = juchuList[2].Id, TorihikisakiTanka__c = tankMList[5].Id, MeisaiJyogai__c = False, JuchuSuryo__c  = 5, Shohizeiritsu__c = 0.08, ShohinShizaiM__c = shohinList[5].Id));
        meisaiList.add(new JuchuMeisaiData__c(name = '受注明細データテスト１０２N01', JuchuData__c = juchuList[2].Id, TorihikisakiTanka__c = tankMList[6].Id, MeisaiJyogai__c = False, JuchuSuryo__c  = 5, Shohizeiritsu__c = 0.08, ShohinShizaiM__c = shohinList[6].Id));
        meisaiList.add(new JuchuMeisaiData__c(name = '受注明細データテスト１０２N01', JuchuData__c = juchuList[2].Id, TorihikisakiTanka__c = tankMList[7].Id, MeisaiJyogai__c = False, JuchuSuryo__c  = 5, Shohizeiritsu__c = 0.08, ShohinShizaiM__c = shohinList[7].Id));
        meisaiList.add(new JuchuMeisaiData__c(name = '受注明細データテスト１０２N01', JuchuData__c = juchuList[2].Id, TorihikisakiTanka__c = tankMList[8].Id, MeisaiJyogai__c = False, JuchuSuryo__c  = 5, Shohizeiritsu__c = 0.08, ShohinShizaiM__c = shohinList[8].Id));
        meisaiList.add(new JuchuMeisaiData__c(name = '受注明細データテスト１０２N01', JuchuData__c = juchuList[2].Id, TorihikisakiTanka__c = tankMList[9].Id, MeisaiJyogai__c = False, JuchuSuryo__c  = 5, Shohizeiritsu__c = 0.08, ShohinShizaiM__c = shohinList[9].Id));
        meisaiList.add(new JuchuMeisaiData__c(name = '受注明細データテスト１０２N01', JuchuData__c = juchuList[2].Id, TorihikisakiTanka__c = tankMList[10].Id, MeisaiJyogai__c = False, JuchuSuryo__c  = 5, Shohizeiritsu__c = 0.08, ShohinShizaiM__c = shohinList[10].Id));
        meisaiList.add(new JuchuMeisaiData__c(name = '受注明細データテスト１０２N01', JuchuData__c = juchuList[2].Id, TorihikisakiTanka__c = tankMList[11].Id, MeisaiJyogai__c = False, JuchuSuryo__c  = 5, Shohizeiritsu__c = 0.08, ShohinShizaiM__c = shohinList[11].Id));
        meisaiList.add(new JuchuMeisaiData__c(name = '受注明細データテスト１０２N01', JuchuData__c = juchuList[3].Id, TorihikisakiTanka__c = tankMList[0].Id, MeisaiJyogai__c = False, JuchuSuryo__c  = 5, Shohizeiritsu__c = 0.08, ShohinShizaiM__c = shohinList[0].Id));
        meisaiList.add(new JuchuMeisaiData__c(name = '受注明細データテスト１０２N01', JuchuData__c = juchuList[3].Id, TorihikisakiTanka__c = tankMList[1].Id, MeisaiJyogai__c = False, JuchuSuryo__c  = 5, Shohizeiritsu__c = 0.08, ShohinShizaiM__c = shohinList[1].Id));
        meisaiList.add(new JuchuMeisaiData__c(name = '受注明細データテスト１０２N01', JuchuData__c = juchuList[3].Id, TorihikisakiTanka__c = tankMList[2].Id, MeisaiJyogai__c = False, JuchuSuryo__c  = 5, Shohizeiritsu__c = 0.08, ShohinShizaiM__c = shohinList[2].Id));
        meisaiList.add(new JuchuMeisaiData__c(name = '受注明細データテスト１０２N01', JuchuData__c = juchuList[3].Id, TorihikisakiTanka__c = tankMList[3].Id, MeisaiJyogai__c = False, JuchuSuryo__c  = 5, Shohizeiritsu__c = 0.08, ShohinShizaiM__c = shohinList[3].Id));
        meisaiList.add(new JuchuMeisaiData__c(name = '受注明細データテスト１０２N01', JuchuData__c = juchuList[3].Id, TorihikisakiTanka__c = tankMList[4].Id, MeisaiJyogai__c = False, JuchuSuryo__c  = 5, Shohizeiritsu__c = 0.08, ShohinShizaiM__c = shohinList[4].Id));
        meisaiList.add(new JuchuMeisaiData__c(name = '受注明細データテスト１０２N01', JuchuData__c = juchuList[3].Id, TorihikisakiTanka__c = tankMList[5].Id, MeisaiJyogai__c = False, JuchuSuryo__c  = 5, Shohizeiritsu__c = 0.08, ShohinShizaiM__c = shohinList[5].Id));
        meisaiList.add(new JuchuMeisaiData__c(name = '受注明細データテスト１０２N01', JuchuData__c = juchuList[3].Id, TorihikisakiTanka__c = tankMList[6].Id, MeisaiJyogai__c = False, JuchuSuryo__c  = 5, Shohizeiritsu__c = 0.08, ShohinShizaiM__c = shohinList[6].Id));
        meisaiList.add(new JuchuMeisaiData__c(name = '受注明細データテスト１０２N01', JuchuData__c = juchuList[3].Id, TorihikisakiTanka__c = tankMList[7].Id, MeisaiJyogai__c = False, JuchuSuryo__c  = 5, Shohizeiritsu__c = 0.08, ShohinShizaiM__c = shohinList[7].Id));
        meisaiList.add(new JuchuMeisaiData__c(name = '受注明細データテスト１０２N01', JuchuData__c = juchuList[3].Id, TorihikisakiTanka__c = tankMList[8].Id, MeisaiJyogai__c = False, JuchuSuryo__c  = 5, Shohizeiritsu__c = 0.08, ShohinShizaiM__c = shohinList[8].Id));
        meisaiList.add(new JuchuMeisaiData__c(name = '受注明細データテスト１０２N01', JuchuData__c = juchuList[3].Id, TorihikisakiTanka__c = tankMList[9].Id, MeisaiJyogai__c = False, JuchuSuryo__c  = 5, Shohizeiritsu__c = 0.08, ShohinShizaiM__c = shohinList[9].Id));
        meisaiList.add(new JuchuMeisaiData__c(name = '受注明細データテスト１０２N01', JuchuData__c = juchuList[3].Id, TorihikisakiTanka__c = tankMList[10].Id, MeisaiJyogai__c = False, JuchuSuryo__c  = 5, Shohizeiritsu__c = 0.08, ShohinShizaiM__c = shohinList[10].Id));
        meisaiList.add(new JuchuMeisaiData__c(name = '受注明細データテスト１０２N01', JuchuData__c = juchuList[3].Id, TorihikisakiTanka__c = tankMList[11].Id, MeisaiJyogai__c = False, JuchuSuryo__c  = 5, Shohizeiritsu__c = 0.08, ShohinShizaiM__c = shohinList[11].Id));
        
        insert meisaiList;
        
        // 消込データ作成
        List<KeshikomiData__c> keshikomiList = new List<KeshikomiData__c>();
        keshikomiList.add(new KeshikomiData__c(name = '入金データテスト１０２N01', UrikakeData__c = urikakeList[0].Id, KeshikomiKingaku__c = 1, KeshikomiKakuninbi__c = Date.today()));
        keshikomiList.add(new KeshikomiData__c(name = '入金データテスト１０２N01', UrikakeData__c = urikakeList[0].Id, KeshikomiKingaku__c = 1, KeshikomiKakuninbi__c = Date.today()));
        keshikomiList.add(new KeshikomiData__c(name = '入金データテスト１０２N01', UrikakeData__c = urikakeList[0].Id, KeshikomiKingaku__c = 1, KeshikomiKakuninbi__c = Date.today()));
        insert keshikomiList;

		// 受注データ　受注確定フラグTRUE
		juchuList[0].JuchuUriageKakuteiFlg__c = true;
        juchuList[1].JuchuUriageKakuteiFlg__c = true;
		juchuList[2].JuchuUriageKakuteiFlg__c = true;
		juchuList[3].JuchuUriageKakuteiFlg__c = true;
        update juchuList;

        Test.startTest();
        
        // 売掛データIDをURLに設定

        // カスタム設定取得
        SystemParam__c SysParam = SystemParam__c.getOrgDefaults();

        // 請求書明細最大行数2
        SysParam.SeikyushoMeisaiMaxNum__c = 2;
        insert SysParam;

        Test.setCurrentPage(Page.N01_Seikyusho);   
        ApexPages.currentPage().getParameters().put('UdId', urikakeList[0].Id);

        N01_SeikyushoController controller1 = new N01_SeikyushoController();
        controller1.doUpdate();

        Integer atesakiHidariChoseiMm = controller1.atesakiHidariChoseiMm;
        Integer atesakiUeChoseiMm = controller1.atesakiUeChoseiMm;
        Integer titleUeMm = controller1.titleUeMm;
        Integer titleShitaMm = controller1.titleShitaMm;

        // 請求書明細最大行数1
        SysParam.SeikyushoMeisaiMaxNum__c = 1;
        update SysParam;

        Test.setCurrentPage(Page.N01_Seikyusho);   
        ApexPages.currentPage().getParameters().put('UdId', urikakeList[0].Id);

        N01_SeikyushoController controller2 = new N01_SeikyushoController();
        controller2.doUpdate();

        // 請求書明細最大行数36
        SysParam.SeikyushoMeisaiMaxNum__c = 99;
        update SysParam;

        Test.setCurrentPage(Page.N01_Seikyusho);   
        ApexPages.currentPage().getParameters().put('UdId', urikakeList[0].Id);

        N01_SeikyushoController controller3 = new N01_SeikyushoController();
        controller3.doUpdate();

        Test.stopTest();

    }
}