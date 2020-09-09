// Use .apex files to store anonymous Apex.
// You can execute anonymous Apex in VS Code by selecting the
//     apex text and running the command:
//     SFDX: Execute Anonymous Apex with Currently Selected Text
// You can also execute the entire file by running the command:
//     SFDX: Execute Anonymous Apex with Editor Contents

Employee__c record = [SELECT Id, Name FROM Employee__c WHERE Id='a013V000003yj9jQAA' ALL ROWS];
undelete record;