@isTest
public class QueueableJobTest {
    @TestSetup
    public static void makeData(){
        Id opp1 = createTestOpportunity();
        Id opp2 = createTestOpportunity();
        
        System.assertEquals(2, [SELECT COUNT() FROM Opportunity]);
    }

    @isTest
    public static void testQueueableJob(){
        Opportunity oppToDelete = [SELECT Id FROM Opportunity LIMIT 1];
        QueuableJob qj = new QueuableJob(oppToDelete.Id);

        Test.startTest();
        System.enqueueJob(qj);
        Test.stopTest();

        System.assertEquals(1, [SELECT COUNT() FROM Opportunity]);
    }



    private static Id createTestOpportunity(){
        Opportunity testOpp = new Opportunity();
        testOpp.Name = 'Test Opp';
        testOpp.CloseDate = Date.today().addDays(-3);
        testOpp.StageName = 'Prospecting';

        insert testOpp;
        return testOpp.id;
    }
}
