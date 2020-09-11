public with sharing class RequestHelper {
    public static void runRequest(Id OpportunityToDelete){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(Constants.OPPORTUNITY_ENDPOINT + OpportunityToDelete);
        request.setMethod('DELETE');
        HttpResponse response = http.send(request);
        if(response.getStatusCode() == 200){
            System.debug('Record deleted successfully');
        }else{
            System.debug('It shat where it slept');
        }
        
    }
}