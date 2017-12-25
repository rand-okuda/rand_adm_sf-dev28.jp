@isTest
private class N07_NyukinIkkatsuTourokuControllerTest {

    static testMethod void myUnitTest1() {

        // 商品資材作成
        List<ShohinShizaiM__c> shohinList = new List<ShohinShizaiM__c>();
        ShohinShizaiM__c shohin1 = new ShohinShizaiM__c(name = 'テスト商品1', HyojunBaika__c = 1000);
        shohinList.add(shohin1);
        insert shohinList;
        
        // 取引先作成
        List<Account> accList = new List<Account>();
        Account acc1 = new Account(name = '株式会社テスト1',SeishikiMeisho__c = '１', AccountTankaMHuyouFlg__c = true, JuchuSokuKakuteiFlg__c = true, HikiateNashiFlg__c = true);
        Account acc2 = new Account(name = '株式会社テスト2',SeishikiMeisho__c = '２', AccountTankaMHuyouFlg__c = true, JuchuSokuKakuteiFlg__c = true, HikiateNashiFlg__c = true);
        Account acc3 = new Account(name = '株式会社テスト3',SeishikiMeisho__c = '３', AccountTankaMHuyouFlg__c = true, JuchuSokuKakuteiFlg__c = true, HikiateNashiFlg__c = true);
        Account acc4 = new Account(name = '株式会社テスト4',SeishikiMeisho__c = '４', AccountTankaMHuyouFlg__c = true, JuchuSokuKakuteiFlg__c = true, HikiateNashiFlg__c = true);
        accList.add(acc1);
        accList.add(acc2);
        accList.add(acc3);
        accList.add(acc4);
        insert accList;
        
        //不明入金データ作成
        List<NyukinData__c> nkdList = new List<NyukinData__c>();
        NyukinData__c nkd1 = new NyukinData__c(SeikyuAccount__c = acc1.Id, NyukinGaku__c = 10000, NyukinBi__c = Date.today());
        NyukinData__c nkd2 = new NyukinData__c(SeikyuAccount__c = acc2.Id, NyukinGaku__c = 10000, NyukinBi__c = Date.today());
        NyukinData__c nkd3 = new NyukinData__c(SeikyuAccount__c = acc3.Id, NyukinGaku__c = 10, NyukinBi__c = Date.today());
        NyukinData__c nkd4 = new NyukinData__c(SeikyuAccount__c = acc4.Id, NyukinGaku__c = 10, NyukinBi__c = Date.today());
        nkdList.add(nkd1);
        nkdList.add(nkd2);
        nkdList.add(nkd3);
        nkdList.add(nkd4);
        insert nkdList;

        // 売掛データ作成
        List<UrikakeData__c> urikakeList = new List<UrikakeData__c>();
        UrikakeData__c urikake1 = new UrikakeData__c(name = acc1.Name, SeikyuAccount__c = acc1.Id, ShimeHizuke__c = Date.today(), SaikenMihasseiFlg__c = true, TsudoSeikyuFlg__c = true);
        UrikakeData__c urikake2 = new UrikakeData__c(name = acc2.Name, SeikyuAccount__c = acc2.Id, ShimeHizuke__c = Date.today(), SaikenMihasseiFlg__c = true);
        UrikakeData__c urikake3 = new UrikakeData__c(name = acc3.Name, SeikyuAccount__c = acc3.Id, ShimeHizuke__c = Date.today(), TsudoSeikyuFlg__c = false);
        UrikakeData__c urikake4 = new UrikakeData__c(name = acc4.Name, SeikyuAccount__c = acc4.Id, ShimeHizuke__c = Date.today().addMonths (-2) );
        urikakeList.add(urikake1);
        urikakeList.add(urikake2);
        urikakeList.add(urikake3);
        urikakeList.add(urikake4);
        insert urikakeList;

        // 受注データ作成
        List<JuchuData__c> juchuList = new List<JuchuData__c>();
        JuchuData__c juchu1 = new JuchuData__c(UrikakeData__c = urikake1.id, name = urikake1.Name, NohinYoteibi__c = Date.today(), SaikenMihasseiFlg__c = true, TsudoSeikyuFlg__c = true);
        JuchuData__c juchu2 = new JuchuData__c(UrikakeData__c = urikake2.id, name = urikake2.Name, NohinYoteibi__c = Date.today(), SaikenMihasseiFlg__c = true);
        JuchuData__c juchu3 = new JuchuData__c(UrikakeData__c = urikake3.id, name = urikake3.Name, NohinYoteibi__c = Date.today(), TsudoSeikyuFlg__c = true);
        JuchuData__c juchu4 = new JuchuData__c(UrikakeData__c = urikake4.id, name = urikake4.Name, NohinYoteibi__c = Date.today());
        juchuList.add(juchu1);
        juchuList.add(juchu2);
        juchuList.add(juchu3);
        juchuList.add(juchu4);
        insert juchuList;

        // 受注明細作成
        List<JuchuMeisaiData__c> meisaiList = new List<JuchuMeisaiData__c>();
        JuchuMeisaiData__c meisai1 = new JuchuMeisaiData__c(name = 'XXX', JuchuData__c = juchu1.Id, ShohinShizaiM__c = shohin1.Id, JuchuSuryoPC__c = 10);
        JuchuMeisaiData__c meisai2 = new JuchuMeisaiData__c(name = 'XXX', JuchuData__c = juchu2.Id, ShohinShizaiM__c = shohin1.Id, JuchuSuryoPC__c = 10);
        JuchuMeisaiData__c meisai3 = new JuchuMeisaiData__c(name = 'XXX', JuchuData__c = juchu3.Id, ShohinShizaiM__c = shohin1.Id, JuchuSuryoPC__c = 10);
        JuchuMeisaiData__c meisai4 = new JuchuMeisaiData__c(name = 'XXX', JuchuData__c = juchu4.Id, ShohinShizaiM__c = shohin1.Id, JuchuSuryoPC__c = 10);
        meisaiList.add(meisai1);
        meisaiList.add(meisai2);
        meisaiList.add(meisai3);
        meisaiList.add(meisai4);
        insert meisaiList;

        // 受注確定
        juchuList[0].JuchuUriageKakuteiFlg__c = TRUE;
        juchuList[1].JuchuUriageKakuteiFlg__c = TRUE;
        juchuList[2].JuchuUriageKakuteiFlg__c = TRUE;
        juchuList[3].JuchuUriageKakuteiFlg__c = TRUE;
        update juchuList;

        // 請求確定
        urikakeList[0].SeikyuKakuteiFlg__c = TRUE;
        urikakeList[1].SeikyuKakuteiFlg__c = TRUE;
        urikakeList[2].SeikyuKakuteiFlg__c = TRUE;
        urikakeList[3].SeikyuKakuteiFlg__c = TRUE;
        update urikakeList;

        // 消込データ作成
        List<KeshikomiData__c> keshikomiListExist = new List<KeshikomiData__c>();
        KeshikomiData__c keshikomiE1 = new KeshikomiData__c(UrikakeData__c = urikake1.id, KeshikomiKingaku__c = 1, KeshikomiKakuninbi__c = Date.today().addDays(-1));
        KeshikomiData__c keshikomiE2 = new KeshikomiData__c(UrikakeData__c = urikake2.id, KeshikomiKingaku__c = 1, KeshikomiKakuninbi__c = Date.today().addDays(-1));
        KeshikomiData__c keshikomiE3 = new KeshikomiData__c(UrikakeData__c = urikake3.id, KeshikomiKingaku__c = 1, KeshikomiKakuninbi__c = Date.today().addDays(-1));
        KeshikomiData__c keshikomiE4 = new KeshikomiData__c(UrikakeData__c = urikake4.id, KeshikomiKingaku__c = 1, KeshikomiKakuninbi__c = Date.today().addDays(-1));
        keshikomiListExist.add(keshikomiE1);
        keshikomiListExist.add(keshikomiE2);
        keshikomiListExist.add(keshikomiE3);
        keshikomiListExist.add(keshikomiE4);
        insert keshikomiListExist;
        
        Test.startTest();
        
        N07_NyukinIkkatsuTourokuController controller = new N07_NyukinIkkatsuTourokuController();

        // 絞込無全件ボタン押下
        controller.initButtonFull();

        // 締払絞込ボタン押下
        controller.initButtonShimeBarai();
        controller.initButtonFull();

        // 取引先名絞込ボタン押下
        controller.RefineString = '１';
        controller.initButton();

        // 取引先名絞込ボタン押下
        controller.RefineString = NULL;
        controller.initButton();

        // 近似期日絞込ボタン押下
        controller.RefineDate = '1231';
        controller.initButton();

        // 近似期日絞込ボタン押下
        controller.RefineDate = '';
        controller.initButton();

        // 近似金額絞込ボタン押下
        controller.RefineValue = '1000';
        controller.initButton();

        // 近似金額絞込ボタン押下
        controller.RefineValue = '';
        controller.initButton();

        // 近似金額と期日絞込ボタン押下
        controller.RefineValue = '1000';
        controller.RefineDate = '1231';
        controller.initButton();
        controller.initButtonFull();

        // 都度払絞込ボタン押下
        controller.initButtonTsudoBarai();

        // 先払絞込ボタン押下
        controller.initButtonSakiBarai();
        
        // 都度と先払絞込ボタン押下
        controller.initButtonSakiBarai();
        controller.initButtonTsudoBarai();

        // 督促絞込ボタン押下
        controller.initButtonTokusokuTaisho();

        // 充当絞込ボタン押下
        controller.initButtonJutoTaisho();

        // 督促と充当絞込ボタン押下
        controller.initButtonTokusokuTaisho();
        controller.initButtonJutoTaisho();

        // 絞込無
        controller.initButtonFull();

        // 全件ボタン押下
        controller.saveButtonAll();

        // 新規追加された行の入金額を入力
        controller.accUrikakeList[0].urikakeKeshikomi[0].keshikomi[1].SokuKeshikomi__c = true;
        controller.accUrikakeList[1].urikakeKeshikomi[0].keshikomi[1].SokuKeshikomi__c = true;
        controller.saveButtonAll();        
        
        Test.stopTest();

    }

    // データが全くない状態でもエラーにならないかのテスト
    static testMethod void myUnitTest2() {
        
        // 取引先作成
        List<Account> accList = new List<Account>();
        Account acc1 = new Account(name = '株式会社テスト1', SeishikiMeisho__c = '正式名称１', Shimebi__c = 20, Kijitsu__c = 15,  AccountTankaMHuyouFlg__c = true);
        accList.add(acc1);
        insert accList;
        
        Test.startTest();
        
        N07_NyukinIkkatsuTourokuController controller = new N07_NyukinIkkatsuTourokuController();
        // 画面表示時
        controller.initButtonFull();

        Test.stopTest();
    }

}