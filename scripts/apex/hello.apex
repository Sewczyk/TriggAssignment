// Use .apex files to store anonymous Apex.
// You can execute anonymous Apex in VS Code by selecting the
//     apex text and running the command:
//     SFDX: Execute Anonymous Apex with Currently Selected Text
// You can also execute the entire file by running the command:
//     SFDX: Execute Anonymous Apex with Editor Contents

        Account testAccountOne = new Account(Name = 'TestAccount1');
        Account testAccountTwo = new Account(Name = 'TestAccount2');
        insert testAccountOne;
        insert testAccountTwo;

        List<Opportunity> opptysList = new List<Opportunity>();


        List<Account> accountsList = [SELECT ID, Name FROM Account];
        for(Integer i=0; i<5; i++){
            Opportunity oppAcc1 = new Opportunity(Name = 'TestOpp '+i, StageName = 'Needs Analysis', AccountId = testAccountOne.Id, CloseDate = Date.today().addDays(-5));
            Opportunity oppAcc2 = new Opportunity(Name = 'TestOpp '+(i+5), StageName = 'Needs Analysis', AccountId = testAccountTwo.Id, CloseDate = Date.today().addDays(-5));
            opptysList.add(oppAcc1);
            opptysList.add(oppAcc2);
        }
        insert opptysList;