trigger AccountChangeEventTrigger on AccountChangeEvent (after insert) {
    private final String STATUS = 'Working';
    private final String ORIGIN = 'Phone';
    System.debug('ACCOUNT CHANGEDATA TRIGGER FIRED');

    List<Case> casesToInsert = new List<Case>();
    List<CaseEvent__e> caseEventsList = new List<CaseEvent__e>();
    for(AccountChangeEvent processedAccount : Trigger.new){
        EventBus.ChangeEventHeader header = processedAccount.ChangeEventHeader;
        String accId = processedAccount.ChangeEventHeader.getRecordIds()[0];
        System.debug('Change event for ' + header.entityName + ' for the ' + header.changeType + ' operation');
        if((header.changetype == 'UPDATE' || header.changetype == 'CREATE') && processedAccount.BillingCity == 'New York'){
            Case newCase = new Case();
            CaseEvent__e newCaseEvent = new CaseEvent__e();
            //case
            newCase.AccountId = accId;
            newCase.Status = STATUS;
            newCase.Origin = ORIGIN;

            //case Event
            newCaseEvent.Origin__c = ORIGIN;
            newCaseEvent.Status__c = STATUS;
            newCaseEvent.AccountId__c = processedAccount.ID;

            casesToInsert.add(newCase);
            caseEventsList.add(newCaseEvent);
        }
    }
    if(casesToInsert.size() > 0){
        insert casesToInsert;
        Eventbus.publish(caseEventsList);
        System.debug('CASE EVENTS LIST TO DEBUG USER: ' + caseEventsList);
    }
}