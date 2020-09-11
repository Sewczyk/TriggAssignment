@isTest
public class TestEmployeeChangeTrigger {
    @isTest
    static void testCreateAndUpdateEmployee(){
        Test.enableChangeDataCapture();

        insert new Employee__c(Name = 'e-101', First_Name__c = 'Astro', Last_Name__c = 'Test', Tenure__c = 1);
        Test.getEventBus().deliver();

        List<Task> taskList = [SELECT Id, Subject FROM Task];
        System.assertEquals(1, taskList.size(), 'The change event trigger did not create the expected task.');

        List<Employee__c> empRecords = [SELECT Id, OwnerId, First_Name__c, Tenure__c FROM Employee__c];
        Employee__c emp = empRecords[0];

        System.debug('Retrieved employee record: ' + emp);
        emp.First_Name__c = 'Codey';
        emp.Tenure__c = null;
        update emp;

        Test.getEventBus().deliver();

        List<Task> taskList2 = [SELECT Id, Subject FROM Task];
        System.assertEquals(2, taskList2.size(), 'The change event trigger did not create the expected task.');
    }
}