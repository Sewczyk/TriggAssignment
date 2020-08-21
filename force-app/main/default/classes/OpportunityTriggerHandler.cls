public class OpportunityTriggerHandler implements ITriggerHandler {

    public static Boolean IsDisabled = false;

    public void BeforeInsert(SObject[] newItems){}

    public void BeforeUpdate(Map<Id, SObject> newItems, Map<Id, SObject> oldItems){
        opportunitiesStageNameUpdate(newItems, oldItems);
    }
  
    public void BeforeDelete(Map<Id, SObject> oldItems){}
  
    public void AfterInsert(Map<Id, SObject> newItems){}
  
    public void AfterUpdate(Map<Id, SObject> newItems, Map<Id, SObject> oldItems){}
  
    public void AfterDelete(Map<Id, SObject> oldItems){}
  
    public void AfterUndelete(Map<Id, SObject> oldItems){}

    public Boolean IsDisabled(){
        return IsDisabled;
    }



    private void opportunitiesStageNameUpdate(Map<Id,SObject> newOpptys, Map<Id,SObject> oldOpptys){
        List<Opportunity> allOpportunities = [SELECT Id, StageName, AccountId, CloseDate FROM Opportunity];
        List<Opportunity> opptysToUpdate = new List<Opportunity>();
        for(Id currentId : newOpptys.keySet()){
            Opportunity updatedOpportunity = (Opportunity)newOpptys.get(currentId);
            Opportunity oldOpportunity = (Opportunity)oldOpptys.get(currentId);
            if(updatedOpportunity.StageName == 'Closed Won' && oldOpportunity.StageName == 'Needs Analysis'){
                for(Opportunity currentToUpdate : allOpportunities){
                    if(currentToUpdate.AccountId == updatedOpportunity.AccountId && currentToUpdate.Id != updatedOpportunity.Id){
                        currentToUpdate.StageName = 'Closed Lost';
                        currentToUpdate.CloseDate = Date.today();
                        opptysToUpdate.add(currentToUpdate);
                    }
                }
            }
        }
        if(opptysToUpdate.size()>0){
            update opptysToUpdate;
        }
    }
}
