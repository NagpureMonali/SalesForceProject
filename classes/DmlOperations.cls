/*******************************************************************************
*  This is class which performs different Dml operations like
*  1. Insert records
*  2. Upsert records
*  3. Delete Records
**********************************************************************************/
public with sharing class DmlOperations  
{
    /**
     *  Delete all inactive Account records created in last 90 days.
     */
    public List <Account> accountRecords() {
        List <Account> listAccount = [SELECT Id, 
                                             Name 
                                      FROM Account 
                                      WHERE Active__c='No' 
                                      AND CreatedDate= LAST_90_DAYS
                                     ]; // List of accounts
        Account[] objAccount = [SELECT Id,
                                       Name 
                                FROM Account 
                                WHERE Active__c='No' 
                                AND CreatedDate= LAST_90_DAYS
                               ]; // Instance of account 
        DELETE objAccount; // Delete account records
        System.debug('Number of records deleted are : '+listAccount.size()); // Print  
        return listAccount;
    } // End of method accountRecords
    
    /**
     *  Create a custom object called as 'Logs'. Create a long text area field called as 'Error'.
     *  Create 100 Lead records using DML operations having a unique name. For all records which
     *  were not inserted into Lead object, insert a record in Log object along with the reason 
     *  why a record was not inserted. Also, execute assignment rules to auto allocate Lead 
     *  records to correct owner.
     */
    public List<Logs__c> logsRecord()  {
        List<Lead> listLead = new List<Lead>(); // List of Lead
        for(Integer i=0;i<100;i++) { 
           // Insert 100 lead records 
            Lead leadInstance = new Lead(LastName='Abc'+i, 
                                         Company='Abc Inc.',
                                         Status='Status changed',
                                         Name__c= 'Test'+i);
            listLead.add(leadInstance);
        } // End of for loop
        // Insert into database
        Database.SaveResult[] saveResultList = Database.insert(listLead, false); 
        List<Logs__c> listLog = new List<Logs__c>();
        for (Database.SaveResult savaResult : saveResultList) {
            if (savaResult.isSuccess()) {
                // Operation was successful
                System.debug('Successfully inserted Lead.' );
            } else {
                // Operation failed, so get all errors               
                for(Database.Error err : savaResult.getErrors()) {
                    Logs__c error =new Logs__c( Error__c = err.getMessage()); // Log instance
                    insert error; //insert error into log
                    System.debug('The following exception has occurred: ' + err.getMessage()); // Print
                    listLog.add(error);
                } // End of inner for loop
             } // End of else
        } // End of for loop
        return listLog;
    } // End of method logsRecord
    
    /**
     *  Create a custom text field on the Asset object named 'Line Item Id' and mark it as an
     *  external id. Upsert Asset records on basis of this field.
     */
    public void upsertAssetRecords() {
        List<Asset> listAsset =  new List<Asset>();
        for(Integer i=0;i<11;i++) {
            listAsset.add(new Asset(Name='ABCd'+i,
                                    Line_Item_Id__c='DEF'+i,
                                    AccountId='00128000004JLpt'));
        } // End of for loop
        try {
            upsert listAsset Line_Item_Id__c; // Try to insert
        }
        catch(Exception error) {
            system.debug('Exception Occured:'+error); // Catch error
        }
      } // End of method
} // End of dmloperations class