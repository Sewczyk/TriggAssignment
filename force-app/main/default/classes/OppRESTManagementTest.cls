@isTest
public class OppRESTManagementTest {
    @isTest
    public static void testDeleteOpportunity(){
        Id idOppToDelete = createTestOpportunity();
        Id OppNotToBeDeleted = createTestOpportunity();
        System.assertEquals(2, [SELECT COUNT() FROM Opportunity]);
        RestRequest request = new RestRequest();
        request.requestURI = Constants.OPPORTUNITY_ENDPOINT + idOppToDelete;
        request.httpMethod = 'GET';
        RestContext.request = request;
        Test.startTest();
        OppRESTManagement.deleteOpportunity();
        Test.stopTest();
        List<Opportunity> opptysList = [SELECT Id FROM Opportunity WHERE Id =: idOppToDelete];
        System.assertEquals(1, [SELECT COUNT() FROM Opportunity]);
        System.assertEquals(0, opptysList.size());

    }




    //Helper
    private static Id createTestOpportunity(){
        Opportunity testOpp = new Opportunity();
        testOpp.Name = 'Test Opp';
        testOpp.CloseDate = Date.today().addDays(-3);
        testOpp.StageName = 'Prospecting';

        insert testOpp;
        return testOpp.id;
    }
}