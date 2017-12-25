public with sharing class J41_DenpyoShutsuryokuShienLogic {

    // コンストラクタ
    public J41_DenpyoShutsuryokuShienLogic(){
        // 何もしない。
    }
    
    public void setJuchuId(ZaikoData__c[] newObjs){
        Set<Id> meisaiIdSet = new Set<Id>();
        
        // 登場する受注明細データのIdのsetを作成する
        for(ZaikoData__c item :newObjs){
            if(item.JuchuMeisai__c != null){
                meisaiIdSet.add(item.JuchuMeisai__c);
            }
        }

        
        // 取得した受注明細に対応する受注データを取得
        List<JuchuMeisaiData__c> meisaiList = new List<JuchuMeisaiData__c>();
        meisaiList = [SELECT Id, JuchuData__c FROM JuchuMeisaiData__c WHERE Id IN :meisaiIdSet];
        
        // key:受注明細のId,value:受注データのIdのMapを作成する。
        Map<Id, Id> meisaiJuchuMap = new Map<Id, Id>();
        for(JuchuMeisaiData__c item :meisaiList){
            meisaiJuchuMap.put(item.Id, item.JuchuData__c);
        }

        // 在庫データに受注Idを設定する
        for(ZaikoData__c item :newObjs){
            if(item.JuchuMeisai__c != null){
                item.JuchuData__c = meisaiJuchuMap.get(item.JuchuMeisai__c);
            }
        }
    }
}