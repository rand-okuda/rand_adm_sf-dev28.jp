public class N17_FumeiNyukinJutoLogic {

    // コンストラクタ
    public N17_FumeiNyukinJutoLogic(){
        // 何もしない。
    }

    public void fumeiNyukinJuto(List<KeshikomiData__c> kekoList){

        //現在のガバナリミットSystem.limits.getLimitQueryRowsを取得する。
	    Integer limitQueryRows = System.limits.getLimitQueryRows();

        //不明入金データの検出結果用フラグ。
        Boolean foundNyukinData;

        //インサート用の入金消込リンク一覧を作成する。
		List<NyukinKeshikomiLink__c> insertNyKeLinkList = new List<NyukinKeshikomiLink__c>();

        //消込データの請求先IDの一覧を作成する。
		Set<ID> kekoAccIDSet = new Set<ID>();
		for(KeshikomiData__c keko : kekoList) {
			kekoAccIDSet.add(keko.SeikyuSakiID__c);
		}

        //取得した請求先に関連する不明入金データ(消込充当済フラグOFFで、入金額が少額で入金日が古いから）を取得する。
        List<NyukinData__c> nyukinDataList = new List<NyukinData__c>();
        nyukinDataList = [SELECT Id, ZanKingaku__c, KeshikomiJutoZumiFlg__c, SeikyuAccount__c, NyukinGaku__c, NyukinBi__c FROM NyukinData__c WHERE SeikyuAccount__c = :kekoAccIDSet AND KeshikomiJutoZumiFlg__c = FALSE ORDER BY NyukinGaku__c ASC, NyukinBi__c ASC LIMIT :limitQueryRows ];

        system.debug('*** nyukinDataList: ' + nyukinDataList);

        //消込データを順に処理する。
        for(KeshikomiData__c keko :kekoList){

            //不明入金データの検出結果の判定OFFにリセット。
            foundNyukinData = false;

            //入金消込リンク判定がONかつ入金充当フラグOFFの消込データのみ処理する。
            if(keko.NyukinKeshikomiHantei__c && !keko.NyukinJutoFlg__c){
                                
                //不明入金データを順に処理する。
                for(NyukinData__c nyukinData :nyukinDataList){

                    //消込データの消込入金額と請求先IDが一致する不明入金データの場合。
                    if(!foundNyukinData && nyukinData.SeikyuAccount__c == keko.SeikyuSakiID__c && nyukinData.ZanKingaku__c == keko.KeshikomiKingaku__c){
                        NyukinKeshikomiLink__c insertNyKeLink = new NyukinKeshikomiLink__c();
                        insertNyKeLink.KeshikomiData__c = keko.Id;
                        insertNyKeLink.NyukinData__c = nyukinData.Id;
                        insertNyKeLinkList.add(insertNyKeLink);
                        foundNyukinData = true;
                    }
                    //消込データの消込入金額以上で請求先IDが一致する不明入金データの場合。
                    if(!foundNyukinData && nyukinData.SeikyuAccount__c == keko.SeikyuSakiID__c && nyukinData.ZanKingaku__c >= keko.KeshikomiKingaku__c){
                        NyukinKeshikomiLink__c insertNyKeLink = new NyukinKeshikomiLink__c();
                        insertNyKeLink.KeshikomiData__c = keko.Id;
                        insertNyKeLink.NyukinData__c = nyukinData.Id;
                        insertNyKeLinkList.add(insertNyKeLink);
                        foundNyukinData = true;
                    }
                    
                }
                
            }
            
        }

        //検出された不明入金データに対応した入金消込リンクを作成する。
        insert insertNyKeLinkList;

    }

}