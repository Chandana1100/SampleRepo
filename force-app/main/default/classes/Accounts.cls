/*Implement a basic Domain class and accompanying Apex trigger with default and update logic based upon domain conventions.
Create a basic Domain class named Accounts that extends fflib_SObjectDomain.
Create a trigger named AccountsTrigger for Account that calls the fflib_SObjectDomain triggerHandler method for all trigger methods.
Implement defaulting logic that executes when a record is inserted and sets the Description field to the value Domain classes rock!
Implement update logic that calculates the Levenshtein distance between the phrase Domain classes rock! and whatever the contents of the Description field is when an Account is updated. Use the Apex String method getLevenshteinDistance(stringToCompare) and store the result in the Annual Revenue field.
*/ 
public class Accounts extends fflib_SObjectDomain {
   public Accounts(List<Account> sObjectList)
   {
       super(sObjectList);
   }
    
     public class Constructor implements fflib_SObjectDomain.IConstructable {
        public fflib_SObjectDomain construct(List<sObject> sObjectList) {
            System.debug('hey');
            return new Accounts(sObjectList);
        }
     }
    
    public override void onApplyDefaults()
    {
        // Apply defaults to account
        for(Account acc: (List<Account>) Records)
        {
            if(acc.Description == null)
            {
            acc.Description = 'Domain classes rock!';
            }
        }
    }
    
    public override void handleBeforeInsert()
    {
        onApplyDefaults();
    }
    
    public override void onBeforeUpdate(Map<Id,sObject> existingRecords) {
        String rock = 'Domain classes rock!';
        List<Account> updatedAccounts = new List<Account>();
        for(Account acc : (List<Account>) Records) {                  
            acc.AnnualRevenue = rock.getLevenshteinDistance(acc.Description);
            updatedAccounts.add(acc);
        }
       
        fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(new Schema.SObjectType[] { Account.SObjectType });
        uow.registerDirty(updatedAccounts);
    }
    

}