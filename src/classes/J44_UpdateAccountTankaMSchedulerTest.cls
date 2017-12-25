@isTest
private class J44_UpdateAccountTankaMSchedulerTest {

    static testMethod void myUnitTest1() {
        Test.StartTest();
        
        DateTime dt = DateTime.now().addMinutes(1);
        String sch = '0 '+ dt.minute() + ' * ' + dt.day() + ' ' + dt.month() + ' ' + ' ? ' + dt.year();

        J44_UpdateAccountTankaMScheduler s = new J44_UpdateAccountTankaMScheduler();
        System.schedule('isTestJ44_UpdateAccountTankaMScheduler', sch, s);
        
        Test.stopTest();
    }
}