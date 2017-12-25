public with sharing class J49_ZaikoIdouTorikesiLogic {

    // コンストラクタ
    public J49_ZaikoIdouTorikesiLogic(){
        // 何もしない。
    }
    
    /**
     * 在庫データの削除時に親在庫に数量を戻す処理
     */
    public void henkyakuZaikoSuryo(ZaikoData__c[] oldObjs){
        List<Id> zenZaikoIdList = new List<Id>();
        
        // 前在庫データのIdのリストを作成
        for(ZaikoData__c zaikoItem :oldObjs){
            // 移動取消フラグがtrue
            if(zaikoItem.IdouTorikesiFlg__c){
                zenZaikoIdList.add(zaikoItem.ZenZaikoData__c);
            }
        }
        
        // 親在庫データのリストを作成
        List<ZaikoData__c> zenZaikoList = new List<ZaikoData__c>();
        zenZaikoList = [SELECT Id, zaikoSuryo__c FROM ZaikoData__c WHERE Id IN :zenZaikoIdList];
        
    
        // アップデート対象リスト
        List<ZaikoData__c> updZaikoDataList = new List<ZaikoData__c>();
        
        // 在庫データ削除時に入庫数量を親在庫データの在庫数に足す処理開始
        for(ZaikoData__c zaikoItem :oldObjs){
            // 移動取消フラグが
            if(zaikoItem.IdouTorikesiFlg__c){
                // 親在庫データのリストを回して対象の物を探す
                for(ZaikoData__c zenItem :zenZaikoList){
                    if(zaikoItem.ZenZaikoData__c == zenItem.Id){
                        // 対象の親在庫データの在庫数量に前出庫数量を足し込む（値が格納されていた場合のみ）
                        if(zenItem.ZaikoSuryo__c >= 0 && zaikoItem.ZenShukkoSuryo__c >= 0){
                        zenItem.ZaikoSuryo__c = zenItem.ZaikoSuryo__c + zaikoItem.ZenShukkoSuryo__c;
                        updZaikoDataList.add(zenItem);                            
                        }
                    }
                }
            }
        }
        
        if(!updZaikoDataList.isEmpty()){
            update updZaikoDataList;
        }
    }
}