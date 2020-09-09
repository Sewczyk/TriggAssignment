trigger OpportunityChangeTrigger on OpportunityChangeEvent (after insert) {
    List<Task> tasksToInsert = new List<Task>();
    for(OpportunityChangeEvent processedEvent : Trigger.new){
        Eventbus.ChangeEventHeader header = processedEvent.ChangeEventHeader;
        System.debug('Received change event for ' + header.entityname + ' for the ' + header.changeType + ' operation.');
        if(header.changetype == 'UPDATE' && processedEvent.isWon == true){
            Task tk = new Task();
            tk.Subject = 'Follow up on won opportunities: ' + header.recordids;
            tk.OwnerId = header.commituser;
            tasksToInsert.add(tk);
        }
        if(tasksToInsert.size()>0){
            insert tasksToInsert;
        }
    }
}