@isTest
public class FutureImplTest {
    
    @isTest
    public static void testFutureImpl(){
        Id oppToDelete = createTestOpportunity();
        Id oppToPersist = createTestOpportunity();

        System.assertEquals(2, [SELECT COUNT() FROM Opportunity]);

        FutureImpl FutureImplInstance = new FutureImpl();
        Test.startTest();
        FutureImplInstance.callDelete(oppToDelete);
        Test.stopTest();

        System.assertEquals(1, [SELECT COUNT() FROM Opportunity]);
        System.assertEquals(null, [SELECT Id FROM Opportunity WHERE Id=:oppToDelete]);


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
