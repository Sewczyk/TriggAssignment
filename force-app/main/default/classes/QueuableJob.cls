public with sharing class QueuableJob implements Queueable, Database.AllowsCallouts {

    private Id varIdOpportunityToDelete;

    public QueuableJob(Id idOpportunityToDelete){
        varIdOpportunityToDelete = idOpportunityToDelete;
    }

    public void execute(QueueableContext qc){
        RequestHelper.runRequest(varIdOpportunityToDelete);
    }
}