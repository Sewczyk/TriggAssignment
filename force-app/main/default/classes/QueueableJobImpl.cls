public class QueueableJobImpl implements IOppJobService {

    public void callDelete(Id idOpportunityToDelete){
        System.enqueueJob(new QueuableJob(idOpportunityToDelete));
    }
}
