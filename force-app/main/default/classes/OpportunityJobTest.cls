@isTest
public with sharing class OpportunityJobTest {
    @TestSetup
    static void makeData(){
       Opportunity newOpp1 = new Opportunity(Name = 'Test Opp1', StageName = 'Prospecting', CloseDate = Date.today().addDays(5));
       Opportunity newOpp2 = new Opportunity(Name = 'Test Opp2', StageName = 'Prospecting', CloseDate = Date.today().addDays(5));
       insert newOpp1;
       insert newOpp2;

        Id Opp1Id = newOpp1.Id;
        Id Opp2Id = newOpp2.Id;
       
       Quote quoteToOpp1 = new Quote(Name = 'Quote to Opp1', OpportunityId = Opp1Id);
       Quote quoteToOpp2 = new Quote(Name = 'Quote to Opp2', OpportunityId = Opp2Id);
       insert quoteToOpp1;
       insert quoteToOpp2;

       System.assertEquals(2, [SELECT Id FROM Opportunity]);
       System.assertEquals(2, [SELECT Id FROM Quote]);
       
    }

    @isTest
    static void testOpportunityDeletionOnQuoteTrigger(){
        
    }
}
