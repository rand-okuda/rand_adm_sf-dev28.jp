public with sharing class N13_JuchuUrikakeRendoLogic {
    
    // コンストラクタ
    public N13_JuchuUrikakeRendoLogic(){
        // 何もしない。
    }
    
    //更新時に受注データを売掛データに紐付けし直す処理
    public void UpdateJuchuData(JuchuData__c oldObj, JuchuData__c newObj){

        // 新旧の受注確定フラグ、売掛データ照会日、都度請求フラグ、債権無フラグが異なる場合のみ処理実行
        if(oldObj.JuchuUriageKakuteiFlg__c != newObj.JuchuUriageKakuteiFlg__c || oldObj.SaikenMihasseiFlg__c != newObj.SaikenMihasseiFlg__c || oldObj.UrikakeDataShokaibi__c != newObj.UrikakeDataShokaibi__c || oldObj.TsudoSeikyuFlg__c != newObj.TsudoSeikyuFlg__c){

            // 更新した受注データが現在紐付いている売掛データ
            UrikakeData__c nowUrikake = [SELECT id, SeikyuAccount__c, TsudoSeikyuFlg__c, SaikenMihasseiFlg__c FROM UrikakeData__c WHERE id = :newObj.UrikakeData__c LIMIT 1];

            // 更新した受注データが紐付くべき売掛データ
            List<UrikakeData__c> parentUrikake = new List<UrikakeData__c>();
            
            // 受注データの関連先の売掛データを売掛データ照会日、都度請求フラグ、債権無フラグを元に検索
            parentUrikake = [SELECT Id FROM UrikakeData__c WHERE SeikyuAccount__c = :nowUrikake.SeikyuAccount__c AND ShimeKikanKara__c <= :newObj.UrikakeDataShokaibi__c AND ShimeKikanMade__c >= :newObj.UrikakeDataShokaibi__c AND TsudoSeikyuFlg__c = :newObj.TsudoSeikyuFlg__c AND SaikenMihasseiFlg__c = :newObj.SaikenMihasseiFlg__c LIMIT 1];

            // 売掛データが見つからなければ作成
            if(parentUrikake.isEmpty()){
                parentUrikake.add(new UrikakeData__c(name = 'XXXX', SeikyuAccount__c = nowUrikake.SeikyuAccount__c, ShimeHizuke__c = newObj.UrikakeDataShokaibi__c, TsudoSeikyuFlg__c = newObj.TsudoSeikyuFlg__c, SaikenMihasseiFlg__c = newObj.SaikenMihasseiFlg__c ));
                insert parentUrikake;
            }
 
            // 売掛データに受注データを紐付け
            newObj.UrikakeData__c = parentUrikake[0].id;

        }
    }

}