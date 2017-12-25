@isTest
private class UrikakeDataTriggerHandlerTest {
    
    static testMethod void myUnitTest1() {
        // 取引先作成
        List<Account> accList = new List<Account>();
        accList.add(new Account(name = '株式会社テスト20150217N08', Type = '請求先'));
        insert accList;

        // 入金調整マスタ作成
        List<NyukinChoseiM__c> nyukinMSTList = new List<NyukinChoseiM__c>();
        nyukinMSTList.add(new NyukinChoseiM__c(Account__c = accList[0].Id));
        insert nyukinMSTList;
        
        Test.startTest();
        // 売掛データ作成
        List<UrikakeData__c> urikakeList = new List<UrikakeData__c>();
        urikakeList.add(new UrikakeData__c(name = '売掛データテスト20150217N08', SeikyuAccount__c = accList[0].Id));
        insert urikakeList;
        
        Test.stopTest();
    }
}