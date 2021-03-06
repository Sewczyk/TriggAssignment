@RestResource(urlMapping='/Opportunity/*')
global with sharing class OpportunityManagementService {
    @HttpDelete
    global static void deleteOpportunity(){
        RestRequest request = RestContext.request;
        RestResponse response = RestContext.response;
        String opportunityId = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
        Opportunity opp = [SELECT Id FROM Opportunity WHERE Id =: opportunityId];
        delete opp;
    }
}