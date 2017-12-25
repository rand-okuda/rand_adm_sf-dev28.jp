public with sharing class J05_NohinKakakuRendoLogic {    

    // コンストラクタ
    public J05_NohinKakakuRendoLogic(){
        // 何もしない。
    }

    //受注明細登録前処理
    public void setTankaInsert(Map<Id,JuchuMeisaiData__c> newMap){
        // 全てが対象
        doSetContactId(newMap);
    }
    
    //受注明細更新前処理
    public void setTankaUpdate(Map<Id, JuchuMeisaiData__c>oldMap, Map<Id, JuchuMeisaiData__c>newMap){
        // 更新対象受注明細Map
        Map<Id, JuchuMeisaiData__c> targetMeisaiMap = new Map<Id,JuchuMeisaiData__c>();
        
        for(Id meisaiId :newMap.keySet()){
            // 商品資材が更新された場合のみ動作する。
            if(oldMap.get(meisaiId).ShohinShizaiM__c != newMap.get(meisaiId).ShohinShizaiM__c){
                // 更新対象受注明細リストに追加
                targetMeisaiMap.put(meisaiId, newMap.get(meisaiId));
            }
        }
        
        if(!targetMeisaiMap.isEmpty()){
            doSetContactId(targetMeisaiMap);
        }
    }
    
    //取引先単価マスタを紐付ける処理
    private void doSetContactId(Map<Id, JuchuMeisaiData__c> meisaiMap){
        // アップデート対象リスト
        List<JuchuMeisaiData__c> updMeisaiList = new List<JuchuMeisaiData__c>();
        
        // 単価マスタ不要フラグを取得
        List<JuchuMeisaiData__c> fullMeisaiDataList = new List<JuchuMeisaiData__c>();

        fullMeisaiDataList = [SELECT jm.Id, jm.ShohinShizaiM__c, ss.Name, jm.TorihikisakiTanka__c, jm.ShohinShizaiM__r.AccountTankaMHuyouFlg__c, jd.Juchusaki__c, jd.UrikakeDataShokaibi__c, sa.AccountTankaMHuyouFlg__c
                              FROM JuchuMeisaiData__c jm, JuchuMeisaiData__c.JuchuData__r jd,JuchuMeisaiData__c.JuchuData__r.UrikakeData__r.SeikyuAccount__r sa, JuchuMeisaiData__c.ShohinShizaiM__r ss
                              WHERE Id IN :meisaiMap.keySet()
                             ];
                       
        for(JuchuMeisaiData__c item :fullMeisaiDataList){

            // 取引先条件マスタ取得
            List<AccountTankaM__c> tanka = new List<AccountTankaM__c>();
            tanka = getTanka(item);

            // 取引先条件マスタを設定
            if(!tanka.isEmpty()){
                item.TorihikisakiTanka__c = tanka[0].Id;
            }else{
                item.TorihikisakiTanka__c = null;
            }
            updMeisaiList.add(item);
        }
        
        // 受注明細をアップデート
        if(!updMeisaiList.isEmpty()){
            update updMeisaiList;
        }
    }
    
    //該当する取引先単価マスタを取得する処理。該当なしの場合、空白のリストを返す。
    private List<AccountTankaM__c> getTanka(JuchuMeisaiData__c meisai){
        //返却用リスト
        List<AccountTankaM__c> tanka = new List<AccountTankaM__c>();

        // 商品資材 ＝ 受注明細データ．商品資材
        // かつ、取引先 ＝ 受注明細データ．受注データ．売掛データ．請求取引先
        // かつ、摘要期間から ≦ 受注明細データ．受注データ．売掛データ照会日
        // かつ、摘要期間まで ≧ 受注明細データ．受注データ．売掛データ照会日
        tanka = [SELECT Id FROM AccountTankaM__c
                 WHERE ShohinShizaiM__c = :meisai.ShohinShizaiM__c
                 AND Account__c = :meisai.JuchuData__r.UrikakeData__r.SeikyuAccount__c
                 AND TekiyoKikanKara__c <= :meisai.JuchuData__r.UrikakeDataShokaibi__c
                 AND TekiyoKikanMade__c >= :meisai.JuchuData__r.UrikakeDataShokaibi__c
                 LIMIT 1];
        return tanka;
    }
    
    //受注データの納品予定日を更新した時に取引先単価を更新する処理
    public void updateTorihikisakiTanka(JuchuData__c[] oldObjs, JuchuData__c[] newObjs){

        // アップデート対象リスト
        List<JuchuMeisaiData__c> updMeisaiList = new List<JuchuMeisaiData__c>();

        for(Integer i = 0; i < newObjs.size(); i++){
            // 保存前後のデータの売掛データ照会日が異なる場合のみ動作する。
            if(oldObjs[i].UrikakeDataShokaibi__c != newObjs[i].UrikakeDataShokaibi__c){
                // 請求先と取引先単価不要フラグを取得
                UrikakeData__c urikake = [SELECT ud.Id, ud.SeikyuAccount__c, sa.AccountTankaMHuyouFlg__c
                                          FROM UrikakeData__c ud, urikakeData__c.SeikyuAccount__r sa 
                                          WHERE Id = :newObjs[i].UrikakeData__c
                                          LIMIT 1
                                         ];
                                          
                // ぶら下がる受注明細データと参照する商品資材の取引先単価不要フラグを取得
                List<JuchuMeisaiData__c> juchuMeisaiList = [SELECT jm.Id, jm.ShohinShizaiM__c, jm.TorihikisakiTanka__c, ss.Name, ss.AccountTankaMHuyouFlg__c FROM JuchuMeisaiData__c jm, JuchuMeisaiData__c.ShohinShizaiM__r ss WHERE JuchuData__c = :newObjs[i].Id];

                // 請求先、適用期間と納品予定日が一致する単価マスタと商品資材を全て取得
                List<AccountTankaM__c> tankaList = [SELECT Id, ShohinShizaiM__c, Account__c, TekiyoKikanKara__c, TekiyoKikanMade__c
                                                    FROM AccountTankaM__c
                                                    WHERE Account__c = :urikake.SeikyuAccount__c
                                                        AND TekiyoKikanKara__c <= :newObjs[i].UrikakeDataShokaibi__c
                                                        AND TekiyoKikanMade__c >= :newObjs[i].UrikakeDataShokaibi__c
                                                   ];
                                                   
                // 受注明細のリストと取引先単価マスタのリストをまわし、商品資材が一致すれば紐付ける。
                
                // 取引先単価マスタが見つかったかどうか
                Boolean isFind;
                            
                for(JuchuMeisaiData__c meisaiItem :juchuMeisaiList){
                    isFind = false;
                    for(AccountTankaM__c tankaItem :tankaList){
                        // 見つかった場合は取引先単価マスタを紐付ける
                        if(meisaiItem.ShohinShizaiM__c.equals(tankaItem.ShohinShizaiM__c)){
                            meisaiItem.TorihikisakiTanka__c = tankaItem.Id;
                            isFind = true;
                            updMeisaiList.add(meisaiItem);
                        }
                    }
                
                    // 見つからない場合
                    if(!isFind){
                        // 取引先条件マスターを解除
                        meisaiItem.TorihikisakiTanka__c = null;
                        updMeisaiList.add(meisaiItem);
                    }
                }

            }

        }

        // 受注明細データをアップデートする。
        if(!updMeisaiList.isEmpty()){
            update updMeisaiList;
        }

    }
}