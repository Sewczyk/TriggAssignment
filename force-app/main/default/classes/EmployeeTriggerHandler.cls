public class EmployeeTriggerHandler {
    public static Boolean IsDisabled = false;

    public void BeforeInsert(SObject[] newItems){}

    public void BeforeUpdate(Map<Id, SObject> newItems, Map<Id, SObject> oldItems){ }
  
    public void BeforeDelete(Map<Id, SObject> oldItems){}
  
    public void AfterInsert(Map<Id, SObject> newItems){}
  
    public void AfterUpdate(Map<Id, SObject> newItems, Map<Id, SObject> oldItems){}
  
    public void AfterDelete(Map<Id, SObject> oldItems){}
  
    public void AfterUndelete(Map<Id, SObject> oldItems){}

    public Boolean IsDisabled(){
        return IsDisabled;
    }
}