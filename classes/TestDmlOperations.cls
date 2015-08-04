/*******************************************************************************
*  This is test class which performs different Dml operations to test
*  1. Insertion of records
*  2. Upsertion of records
*  3. Deletion of records
**********************************************************************************/
@isTest // Annotation
private class TestDmlOperations 
{
    /**
     * test to Delete all inactive Account records created in last 90 days.
     */
    static testMethod void testAccountRecords() {
        List<Account> listAccount  = new List<Account>(); 
         for(Integer i = 0;i<5;i++) {
              Account testAccount = new Account(Name = 'Test'+i, Type = 'Person Account');
              listAccount.add(testAccount);
         }
        Test.startTest(); // Start test
        DmlOperations objDmlOperations=new DmlOperations();
        insert listAccount;
        DELETE listAccount;
        Test.stopTest(); // End test
        System.assertEquals(0,objDmlOperations.accountRecords().size()); // Check for result
    } // End of method accountRecords
    
    /**
     *  Test to upsert Asset records on basis of this field.
     */
    static testMethod void testUpsertAssetRecords() {
        List<Asset> listAsset =  new List<Asset>();
        for(integer i=0;i<11;i++) {
           listAsset.add(new Asset(Name='ABCd'+i,Line_Item_Id__c='DEF'+i,AccountId='00128000004JLpt'));
        }
        Test.startTest(); // Start test
        upsert listAsset Line_Item_Id__c; // Try to insert
        List<Asset> testListAsset = [SELECT Name FROM Asset WHERE Name like 'ABCd%'];
        Test.stopTest(); // End test
        System.assertEquals(11,testListAsset.size()); // Check for result
    } // End of method
    
    /**
     *  Test for all records which were not inserted into Lead object, insert a record in 
     *  Log object along with the reason why a record was not inserted
     */     
    static testMethod void testLogsRecord() {
        List<Lead> listLead = new List<Lead>(); //list of Lead
       // List<Logs__c> testListLog =new List<Logs__c>();
         for(Integer i=0;i<100;i++) { 
             //insert 100 lead records 
             Lead leadInstance = new Lead(LastName='Test'+i, 
                                          Company='Test Cmp.',
                                          Status='Status changed', 
                                          Name__c= 'Test');
             listLead.add(leadInstance);
             System.debug('---listLog==='+listLead);
          }//end of for loop
        Test.startTest(); // Start test
        DmlOperations objDmlOperations=new DmlOperations();
        // Insert into database
        Database.SaveResult[] saveResultList = Database.insert(listLead, false); 
        List<Logs__c> listLog =new List<Logs__c>();
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
        List<Logs__c> listTestLog =objDmlOperations.logsRecord();
        Test.stopTest(); // Stop test
        System.assertEquals(0,listTestLog.size());
       // System.assertEquals(100,listTestLog.size());
     } // End of method
} // End of test class