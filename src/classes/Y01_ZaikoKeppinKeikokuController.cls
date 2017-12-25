public with sharing class Y01_ZaikoKeppinKeikokuController {
    public Y01_ZaikoKeppinKeikokuController(){
    }
    
    public Y01_ZaikoKeppinKeikokuController(ApexPages.StandardController controller){
    }
    
    public pageReference init(){
        // URLより商品資材のID取得
        String shohinId = ApexPages.CurrentPage().getParameters().get('ShohinId');
        
        // SOQLの制限を設定。念の為半分の数よりマイナス1しておく
        Integer limitNum = (Limits.getLimitQueryRows() / 2) -1;

        // 出荷見込更新
        List<ShukaMikomiData__c> shukaList = new List<ShukaMikomiData__c>();
        shukaList = [SELECT Id FROM ShukaMikomiData__c WHERE ShohinShizaiM__c = :shohinId ORDER BY Hizuke__c LIMIT :limitNum];
        update shukaList;
        
        // 在庫データ更新
        List<ZaikoData__c> zaikoList = new List<ZaikoData__c>();
        zaikoList = [SELECT Id FROM ZaikoData__c WHERE ShohinShizaiM__c = :shohinId ORDER BY YosokuTaishoSuryo__c DESC  LIMIT :limitNum];
        update zaikoList;
        
        return new PageReference('/' + shohinId);
    }
}