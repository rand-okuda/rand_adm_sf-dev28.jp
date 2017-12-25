public with sharing class J07_JuchuYosokuRendoLogic {

    // コンストラクタ
    public J07_JuchuYosokuRendoLogic(){
        // 何もしない。
    }

    /**
     * 登録後処理
     */
    public void onAfterInsert(JuchuMeisaiData__c[] newObjs, Set<Id> juchuMeisaiDataIds){
        List<ShukaMikomiData__c> shukaMikomiDatas = [SELECT Id FROM ShukaMikomiData__c WHERE JuchuMeisaiData__c IN :juchuMeisaiDataIds];
        
        if(shukaMikomiDatas == null || shukaMikomiDatas.size() == 0) {
            List<ShukaMikomiData__c> insetDatas = new List<ShukaMikomiData__c>();
            
            // 受注明細データを参照する、出荷見込データが存在しない場合
            for(JuchuMeisaiData__c newObj: newObjs) {
                // 出荷見込データ：新規作成レコード
                ShukaMikomiData__c shukaMikomiData = new ShukaMikomiData__c();
            
                shukaMikomiData.JuchuMeisaiData__c = newObj.Id;
                shukaMikomiData.ShohinShizaiM__c = newObj.ShohinShizaiM__c;
                
                insetDatas.add(shukaMikomiData);
            }
            
            insert insetDatas;
        }
    }
    
    
    /**
     * 更新後処理
     */
    public void onAfterUpdate(JuchuMeisaiData__c[] oldObjs, JuchuMeisaiData__c[] newObjs, Set<Id> juchuMeisaiDataIds){
        List<ShukaMikomiData__c> shukaMikomiDatas = [
            SELECT Id,JuchuMeisaiData__c,ShohinShizaiM__c FROM ShukaMikomiData__c WHERE JuchuMeisaiData__c IN :juchuMeisaiDataIds];

        // 受注明細データを参照する、出荷見込データが存在する場合
        if(shukaMikomiDatas != null && shukaMikomiDatas.size() > 0) {
            // 出荷見込データ：更新
            for(ShukaMikomiData__c shukaMikomi: shukaMikomiDatas) {
                
                for(JuchuMeisaiData__c newObj: newObjs) {
                    if(shukaMikomi.JuchuMeisaiData__c == newObj.Id) {
                        shukaMikomi.ShohinShizaiM__c = newObj.ShohinShizaiM__c;
                        break;
                    }
                }
            }
            update shukaMikomiDatas;
        }
    }
    
    
    /**
     * 削除前処理
     */
    public void onBeforeDelete(Set<Id> juchuMeisaiDataIds){
        List<ShukaMikomiData__c> shukaMikomiDatas = [SELECT Id FROM ShukaMikomiData__c WHERE JuchuMeisaiData__c IN :juchuMeisaiDataIds];
        delete shukaMikomiDatas;
    }
}