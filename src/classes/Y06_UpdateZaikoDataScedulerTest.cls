@isTest
private class Y06_UpdateZaikoDataScedulerTest {

    static testMethod void myUnitTest() {
        Test.StartTest();
        
        DateTime dt = DateTime.now().addMinutes(1);
        String sch = '0 '+ dt.minute() + ' * ' + dt.day() + ' ' + dt.month() + ' ' + ' ? ' + dt.year();

        Y06_UpdateZaikoDataScheduler s = new Y06_UpdateZaikoDataScheduler();
        System.schedule('isTestY06_UpdateZaikoDataSceduler', sch, s);
        
        Test.stopTest();
    }
}