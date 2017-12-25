public with sharing class J47_JyutyuKakuteiTorikesiZaikoLogic {

    // コンストラクタ
    public J47_JyutyuKakuteiTorikesiZaikoLogic(){
        // 何もしない。
    }

    public void deleteZaiko(JuchuData__c oldObjs, JuchuData__c newObjs){

        // 引当完了フラグと受注確定フラグが変更された場合のみ実行
        if(oldObjs.HikiateKanryoFlg__c != newObjs.HikiateKanryoFlg__c && oldObjs.JuchuKakuteiFlg__c != newObjs.JuchuKakuteiFlg__c){

            // 引当完了フラグfalseかつ受注確定フラグfalseの場合のみ実行
            if(!newObjs.HikiateKanryoFlg__c && !newObjs.JuchuKakuteiFlg__c){

                // 配下の受注明細の配下の在庫データを取得
                List<ZaikoData__c> deleteZaikoList = new List<ZaikoData__c>();
                deleteZaikoList = [SELECT Id FROM ZaikoData__c WHERE JuchuMeisai__c IN (SELECT Id FROM JuchuMeisaiData__c WHERE JuchuData__c = :newObjs.Id)];

                //配列が空でなければ削除実行
                if(!deleteZaikoList.isEmpty()){
                    system.debug(deleteZaikoList);
                    delete deleteZaikoList;
                }

            }
            
        }

    }
}