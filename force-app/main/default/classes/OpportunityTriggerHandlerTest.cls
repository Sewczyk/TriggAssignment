@IsTest
public class OpportunityTriggerHandlerTest {
    @TestSetup
    static void makeData(){
        Account testAccountOne = new Account(Name = 'TestAccount1');
        Account testAccountTwo = new Account(Name = 'TestAccount2');
        insert testAccountOne;
        insert testAccountTwo;

        List<Opportunity> opptysList = new List<Opportunity>();


        List<Account> accountsList = [SELECT ID, Name FROM Account];
        System.assertEquals(2, accountsList.size());

        for(Integer i=0; i<5; i++){
            Opportunity oppAcc1 = new Opportunity(Name = 'TestOpp '+i, StageName = 'Needs Analysis', AccountId = testAccountOne.Id, CloseDate = Date.today().addDays(-5));
            Opportunity oppAcc2 = new Opportunity(Name = 'TestOpp '+(i+5), StageName = 'Needs Analysis', AccountId = testAccountTwo.Id, CloseDate = Date.today().addDays(-5));
            opptysList.add(oppAcc1);
            opptysList.add(oppAcc2);
        }
        System.debug(JSON.serializePretty(opptysList));
        insert opptysList;
        System.debug('Dupa');

        List<Opportunity> fetchedOpportunities = [SELECT ID, StageName, Name, AccountId FROM Opportunity];
        System.assertEquals(10, fetchedOpportunities.size());
    }

    @IsTest
    static void testUpdateOpportunitiesStatus(){
        List<Opportunity> fetchedOpportunities = [SELECT ID, StageName, Name, AccountId FROM Opportunity];
        Opportunity toBeUpdatedOpp = fetchedOpportunities[0];
        toBeUpdatedOpp.StageName = 'Closed Won';
        Test.startTest();
        update toBeUpdatedOpp;
        Test.stopTest();
        System.assertEquals(1, [SELECT COUNT() FROM Opportunity WHERE StageName = 'Closed Won']);
        System.assertEquals(4, [SELECT COUNT() FROM Opportunity WHERE StageName = 'Closed Lost']);
        System.assertEquals(5, [SELECT COUNT() FROM Opportunity WHERE StageName = 'Needs Analysis']);
    }
}