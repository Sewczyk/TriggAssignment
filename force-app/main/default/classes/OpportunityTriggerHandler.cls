public class OpportunityTriggerHandler implements ITriggerHandler {

    public static Boolean IsDisabled = false;

    public void BeforeInsert(SObject[] newItems){}

    public void BeforeUpdate(Map<Id, SObject> newItems, Map<Id, SObject> oldItems){
        Map<Id, Opportunity> oldOppMap = (Map<Id, Opportunity>) oldItems;
        Map<Id, Opportunity> newOppMap = (Map<Id, Opportunity>) newItems;
        Map<Id, Opportunity> filteredClosedWonMap = new Map<Id,Opportunity>();
        filteredClosedWonMap = filterClosedWonOpps(newOppMap, oldOppMap);
        opportunitiesStageNameUpdate(filteredClosedWonMap);


        //Map<Id, Opportunity> oldOppMap = (Map<Id, Opportunity>) oldItems;
    }
  
    public void BeforeDelete(Map<Id, SObject> oldItems){}
  
    public void AfterInsert(Map<Id, SObject> newItems){}
  
    public void AfterUpdate(Map<Id, SObject> newItems, Map<Id, SObject> oldItems){}
  
    public void AfterDelete(Map<Id, SObject> oldItems){}
  
    public void AfterUndelete(Map<Id, SObject> oldItems){}

    public Boolean IsDisabled(){
        return IsDisabled;
    }

    private Map<Id, Opportunity> filterClosedWonOpps(Map<Id, Opportunity> newOppMap, Map<Id, Opportunity> oldOppMap) {
        // List<Opportunity> allNotOpportunities = [SELECT Id, StageName, AccountId, CloseDate FROM Opportunity WHERE Id NOT IN :newOpptys.keySet()];
        Map<Id, Opportunity> filteredMap = new Map<Id, Opportunity>();
        for(Opportunity currentOpp : newOppMap.values()) {
            Opportunity oldOpp = oldOppMap.get(currentOpp.Id);
            if(currentOpp.StageName == 'Closed Won' && oldOpp.StageName == 'Needs Analysis') {
                filteredMap.put(currentOpp.id, currentOpp);
            }
        }
        return filteredMap;
    }



    private void opportunitiesStageNameUpdate(Map<Id, Opportunity> closedWonOpps){
        Set<Id> accIdsSet = new Set<Id>(); 
        List<Opportunity> lostOpportunities = new List<Opportunity>();
        for(Opportunity opp : closedWonOpps.values()) {
            accIdsSet.add(opp.AccountId);
        }

        List<Opportunity> allLostOpportunities = [SELECT Id, StageName, AccountId, CloseDate 
            FROM Opportunity 
            WHERE AccountId IN :accIdsSet AND Id NOT IN :closedWonOpps.keySet()];

        //poprawiłem
        for(Opportunity opp :allLostOpportunities) {
            System.debug(opp.Id + opp.StageName);
            opp.StageName = 'Closed Lost';
            opp.CloseDate = Date.today();
            System.debug(opp.Id + opp.StageName);
            lostOpportunities.add(opp);
        }
        System.debug('All lost Opportunities size ' + allLostOpportunities.size());
        if(lostOpportunities.size() > 0){
            update lostOpportunities;
        }
    }
}
