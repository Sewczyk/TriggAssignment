trigger ContactTrigger on Contact (before insert, before update, before delete, after insert, after update, after delete, after undelete){
    TriggerDispatcher.Run(new ContactTriggerHandler(), System.TriggerOperation.BEFORE_INSERT);
}