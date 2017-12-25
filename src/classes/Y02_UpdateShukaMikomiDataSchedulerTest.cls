@isTest
private class Y02_UpdateShukaMikomiDataSchedulerTest {

    static testMethod void myUnitTest1() {
        Test.StartTest();
        
        DateTime dt = DateTime.now().addMinutes(1);
        String sch = '0 '+ dt.minute() + ' * ' + dt.day() + ' ' + dt.month() + ' ' + ' ? ' + dt.year();

        Y02_UpdateShukaMikomiDataScheduler s = new Y02_UpdateShukaMikomiDataScheduler();
        System.schedule('isTestY02_UpdateShukaMikomiDataScheduler', sch, s);
        
        Test.stopTest();
    }
}