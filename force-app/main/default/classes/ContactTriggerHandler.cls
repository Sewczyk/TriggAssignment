public class ContactTriggerHandler implements ITriggerHandler {

    public static Boolean TriggerDisabled = false;

    public Boolean isDisabled(){
        return TriggerDisabled;
    }

    


    public void BeforeInsert(SObject[] newItems) {
        LevenshteinDistanceProbability((List<Contact>)newItems);
    }

    public void BeforeUpdate(Map<Id, SObject> newItems, Map<Id, SObject> oldItems) {}

    public void BeforeDelete(Map<Id, SObject> oldItems) {}

    public void AfterInsert(Map<Id, SObject> newItems) {}
  
    public void AfterUpdate(Map<Id, SObject> newItems, Map<Id, SObject> oldItems) {}
  
    public void AfterDelete(Map<Id, SObject> oldItems) {}
  
    public void AfterUndelete(Map<Id, SObject> oldItems) {}


    private void LevenshteinDistanceProbability(List<Contact> contacts){
        //Prepare variables for calculation
        List<String> validatedCities = new List<String>{'Gdańsk','Szczecin','Lublin','Białystok', 'Katowice'};
        Map<Id,Account> accountsMap = generateAccountsMapFromContacts(contacts);
        List<Account> accountsToUpdate = new List<Account>();
        String cityName;
        Double highestSimilarityPercentage, currentSimilarityPercentage;

        for(Contact currentContact : contacts){
            System.debug('Current contact ' + currentContact.LastName);
            highestSimilarityPercentage = 0;
            Account acc = accountsMap.get(currentContact.AccountId);
            System.debug('Current Account ' + acc.Name);
            System.debug('Billing City Account ' + acc.BillingCity);
            for(Integer i=0; i<validatedCities.size(); i++){
                currentSimilarityPercentage = calculateSimilarityInPercents(currentContact, validatedCities[i], acc);
                System.debug('Current Sim Percentage ' + currentSimilarityPercentage);
                System.debug('Highest Sim Percentage ' + highestSimilarityPercentage);
                System.debug('Validated City ' + validatedCities[i]);
                if(currentSimilarityPercentage>highestSimilarityPercentage){
                    highestSimilarityPercentage = currentSimilarityPercentage;
                    cityName = validatedCities[i];
                }
            }
            System.debug('Wartosc zmiennej podobienstwa ' + highestSimilarityPercentage);
            if(highestSimilarityPercentage>80){
                acc.BillingCity = cityName;
                accountsToUpdate.add(acc);
            }else{
                currentContact.addError('Billing City is a lie');
            }
        }
        if(accountsToUpdate.size()>0)
            update accountsToUpdate;
    }

    //Calculates similarity percentage based on Levenshtein Distance
    private double calculateSimilarityInPercents(Contact con, String validatedCityName, Account account){
        Double levenshteinDistance, divider;
        levenshteinDistance = account.BillingCity.getLevenshteinDistance(validatedCityName);
        divider = Math.max(account.BillingCity.length(), validatedCityName.length());
        Double result = ((divider - levenshteinDistance)/divider)*100;
        System.debug('Similarity is ' + result);
        return result;
    }

    private Map<Id,Account> generateAccountsMapFromContacts(List<Contact> contactsList){
        Set<Id> accountsIDs = new Set<Id>();
        for(Contact current : contactsList){
            accountsIDs.add(current.AccountId);
        }
        List<Account> retrievedAccountsList = [SELECT Id, BillingCity, Name FROM Account WHERE Id IN: accountsIDs];
        Map<Id,Account> resultMap = new Map<Id,Account>();
        for(Account acc : retrievedAccountsList){
            resultMap.put(acc.ID, acc);
        }
        return resultMap;
    }

}