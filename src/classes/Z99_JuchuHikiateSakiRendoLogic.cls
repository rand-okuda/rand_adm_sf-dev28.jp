public with sharing class Z99_JuchuHikiateSakiRendoLogic {

	public void ZaikoHikiateSakiUpdate(List<JuchuData__c> newObjs){

        //優先引当先フラグONの既存の取引先マスタを取得する。
        List<Account> YusenHikiateSaki = new List<Account>();
        YusenHikiateSaki = [SELECT Id, Name, YusenHikiateSakiFlg__c FROM Account WHERE YusenHikiateSakiFlg__c = TRUE LIMIT 1];

        system.debug('*** YusenHikiateSaki: ' + YusenHikiateSaki);

		//受注データ一覧を順に処理する。
		for(JuchuData__c jd : newObjs){

			if(jd.KobetsuHikiateJikkoFlg__c){
				jd.ZaikoHikiateSaki__c = jd.KobetsuHikiateSakiShokai__c;
			}else{
                if(jd.HyojunHikiateJikkoFlg__c){
					//優先引当先フラグONの取引先が無かった場合を考慮。
					if(!YusenHikiateSaki.isEmpty()){
						jd.ZaikoHikiateSaki__c = YusenHikiateSaki[0].Id;

                        system.debug('*** YusenHikiateSaki[0]: ' + YusenHikiateSaki[0]);

                    }
				}
			}

		}

	}

}