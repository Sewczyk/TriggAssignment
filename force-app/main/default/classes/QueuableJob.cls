public with sharing class QueuableJob implements Queueable {

    private Id varIdOpportunityToDelete;

    public QueuableJob(Id idOpportunityToDelete){
        varIdOpportunityToDelete = idOpportunityToDelete;
    }

    public void execute(QueueableContext qc){
        RequestHelper.runRequest(varIdOpportunityToDelete);
    }
}
