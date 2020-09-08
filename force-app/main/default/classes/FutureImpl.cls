public class FutureImpl implements IOppJobService {
    
    public void callDelete(Id oppToDelete){
        futureMethod(oppToDelete);
    }

    @Future
    public static void futureMethod(Id idOpportunityToDelete){
        RequestHelper.runRequest(idOpportunityToDelete);
    }
}
