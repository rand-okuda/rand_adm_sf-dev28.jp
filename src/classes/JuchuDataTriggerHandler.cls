public with sharing class JuchuDataTriggerHandler {

    /**
     * コンストラクタ
     */
    public JuchuDataTriggerHandler(){
        // 何もしない。
    }

    public void onBeforeUpdate(JuchuData__c[] oldObjs, JuchuData__c[] newObjs, Map<Id, JuchuData__c> oldMap, Map<Id, JuchuData__c> newMap){
        
        N13_JuchuUrikakeRendoLogic logic_N13 = new N13_JuchuUrikakeRendoLogic();
        for(Integer i = 0; i < newObjs.size(); i++){
            logic_N13.UpdateJuchuData(oldObjs[i], newObjs[i]);
        }
        
        Z02_JuchuSyukoRendoLogic logic_Z02 = NEW Z02_JuchuSyukoRendoLogic();
        logic_Z02.zaikohikiate(newMap);
        
        J47_JyutyuKakuteiTorikesiZaikoLogic logic_J47 = new J47_JyutyuKakuteiTorikesiZaikoLogic();
        for(Integer i = 0; i < newObjs.size(); i++){
            logic_J47.deleteZaiko(oldObjs[i], newObjs[i]);
        }
        
        Z99_JuchuHikiateSakiRendoLogic logic_Z99 = new Z99_JuchuHikiateSakiRendoLogic();
        logic_Z99.ZaikoHikiateSakiUpdate(newObjs);
        
    }
    
    public void onAfterUpdate(JuchuData__c[] oldObjs, JuchuData__c[] newObjs, Map<ID, JuchuData__c> juchuMap){

        J05_NohinKakakuRendoLogic logic_J05 = new J05_NohinKakakuRendoLogic();
        logic_J05.updateTorihikisakiTanka(oldObjs, newObjs);
        
        J04_DempyoBangokKinyuLogic logic_J04 = new J04_DempyoBangokKinyuLogic();
        logic_J04.onAfterUpdate(oldObjs, newObjs, juchuMap);

    }

    public void onBeforeDelete(Map<Id, JuchuData__c> oldMap){

        J46_JyutyuSakujyoZaikoLogic logic_J46 = new J46_JyutyuSakujyoZaikoLogic();
        logic_J46.deleteJuchuMeisai(oldMap.keySet());

    }

}