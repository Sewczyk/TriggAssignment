@isTest
private class ContactTriggerHandlerTest {
    
    @TestSetup
    static void makeData(){
        List<Account> insertAccountsList = new List<Account>();
        Account testPositiveAccount = new Account(Name = 'Positive account', BillingCity = 'Szcaecin');
        Account testErrorAcount = new Account(Name= 'Error account', BillingCity = 'Gfbbsk');
        insertAccountsList.add(testPositiveAccount);
        insertAccountsList.add(testErrorAcount);
        AccountTriggerHandler.TriggerDisabled = true;
        insert insertAccountsList;
    }

    @isTest
    static void testLevenshteinProbabilityPositive(){

        //(Name = 'PositiveResultExpected', AccountId = [SELECT Id FROM Account WHERE Name='Positive account']);

        List<Account> accList = [SELECT Id, BillingCity FROM Account WHERE Name = 'Positive Account' LIMIT 1];
        Account acc = accList[0];
        Contact positiveExpectedResult = new Contact();
        positiveExpectedResult.AccountId = acc.Id;
        positiveExpectedResult.LastName = 'PositiveResultExpected';
        Test.startTest();
        insert positiveExpectedResult;
        Test.stopTest();
        List<Account> resultList = [SELECT BillingCity FROM Account WHERE Name = 'Positive Account' LIMIT 1];
        //Account acc = [SELECT BillingCity FROM Account WHERE Name = 'Positive Account' LIMIT 1];
        Account resultAccount = resultList[0];
        System.assertEquals('Szczecin', resultAccount.BillingCity);

        

    }

    @isTest
    static void testLevenshteinProbabilityNegative(){
        
        List<Account> accList = [SELECT Id FROM Account WHERE Name = 'Error Account' LIMIT 1];
        Account acc = accList[0];
        Contact con = new Contact(LastName = 'NegativeResultExpected', AccountId = acc.Id);
        Boolean expectedException = false;
        Test.startTest();
        try {
            insert con;    
        } catch (Exception e) {
            expectedException = e.getMessage().contains('Billing City is a lie') ? true : false;    
        }
        Test.stopTest();    
        System.assertEquals(true, expectedException);
        
        
    }
}