@isTest
public class TestOpportunityChangeTrigger {
    @isTest
    static void testCreateAndUpdateOpportunity(){
        Test.enableChangeDataCapture();

        insert new Opportunity(Name = 'Sell 100 Widgets', StageName = 'Prospecting', CloseDate = Date.today().addMonths(3));
        Test.getEventBus().deliver();
        
        List<Opportunity> oppRecords = [SELECT Id, StageName FROM Opportunity];
        Opportunity opp = oppRecords[0];
        opp.StageName = 'Closed Won';
        update opp;

        Test.getEventBus().deliver();
        List<Task> taskList = [SELECT Id, Subject FROM Task];
        System.assertEquals(1, taskList.size(), 'The change event trigger did not create the expected task.');
    }
}