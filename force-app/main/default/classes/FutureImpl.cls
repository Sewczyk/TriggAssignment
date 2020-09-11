public class FutureImpl implements IOppJobService {
    
    public void callDelete(Id oppToDelete){
        futureMethod(oppToDelete);
    }

    @Future(callout=true)
    public static void futureMethod(Id idOpportunityToDelete){
        RequestHelper.runRequest(idOpportunityToDelete);
    }
}