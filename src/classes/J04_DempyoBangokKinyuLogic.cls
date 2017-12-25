public with sharing class J04_DempyoBangokKinyuLogic {

    // コンストラクタ
    public J04_DempyoBangokKinyuLogic(){
        // 何もしない。
    }

    /**
     * 在庫データの伝票行番号に受注データ内の連番を書込む
     */
    public void onAfterUpdate(JuchuData__c[] oldObjs, JuchuData__c[] newObjs, Map<ID, JuchuData__c> juchuMap){
        // 受注データ配下の受注明細データ配下の「在庫データ」を取得する
        List<ZaikoData__c> zaikoList = new List<ZaikoData__c>();
        zaikoList = [SELECT Id, DenpyoGyoBango__c, JuchuData__c, ShohinShizaiM__c FROM ZaikoData__c WHERE JuchuData__c IN :juchuMap.keySet() ORDER BY JuchuData__c ASC, NarabiJun__c ASC];
        
        // 連番設定用カウンタ
        Integer counter = 1;
        if(!zaikoList.isEmpty()){
            for(Integer i = 0; i < zaikoList.size(); i++){
                // 連番を書き込む
                zaikoList[i].DenpyoGyoBango__c = counter;
                
                // 現在の在庫データは最後の物である、または次の在庫データの参照する受注データは別の物である
                if(i == zaikoList.size() - 1 || zaikoList[i].JuchuData__c != zaikoList[i + 1].JuchuData__c){
                    // カウンタをリセット
                    counter = 1;
                }else{
                    // カウンタをインクリメント
                    counter = counter + 1;
                }
            }
            update zaikoList;
        }
    }
}