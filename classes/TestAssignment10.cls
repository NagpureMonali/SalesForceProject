/************************************************************************************
 *  It is test class for assignement no 10 to perform diff operations of SOQL query
 *************************************************************************************/
@isTest // Annotation
private class TestAssignment10 {
    /**
     *  Method to test query on all Contact records and add them to the list. 
     */
    static testMethod void testContactRecord() {
        Test.startTest(); // Start test
        List<Contact> testListContact = [SELECT Id, 
                                                Name 
                                         FROM Contact 
                                         ]; // List of contact
        Assignment10 objAssignment10 = new Assignment10();
        Test.stopTest(); // End Test 
        System.assertEquals(testListContact, objAssignment10.contactRecord()); // Check result                          
    } // End of method
    
    /**
     *  Method to test Account id as key and entire object as value
     */
    static testMethod void testAccountRecords() {
        Integer i = 0;
        List<Account> testListAccount = new List<Account>();
        for(i = 0; i <= 5; i++) {
            Account testAccount = new Account(Name = 'Test' + i);
            testListAccount.add(testAccount);    
        }
        Test.startTest(); // Start test
        insert testListAccount;
        Map<String, Id> testMapAccount = new Map<String, Id>(); // Map of string and Id
        for (i = 0; i<testListAccount.size(); i++) {
            testMapAccount.put(testListAccount[i].Name, testListAccount[i].Id); // Put values in map
        }
        // Account id as key and entire Account object as value.
        Map<Id, Account> testMapOfAccount = new Map<Id, Account>(); // Map
        for (Account accountInstance : testListAccount ) {
            testMapOfAccount.put(accountInstance.Id, accountInstance); // Put valus in mapOfAccount
        }  
        Assignment10 objAssignment10 = new Assignment10();
        Test.stopTest(); // End test
        System.assertEquals(testMapOfAccount, objAssignment10.accountRecords()); // Check result
    }// End of method
    
    /**
     *  Test to get all account records where in selected 'Enrollment Year' is:
     *  a. 2010
     *  b. 2013 and 2014
     */
    static testMethod void testAccountRecordsPicklist() {
        Integer i = 0;
        List<Account> testListAccount = new List<Account>();
        for(i = 0; i <= 5; i++) {
            Account testAccount = new Account(Name = 'Test' + i,
                                              Enrollment_Year__c = '2013;2014');
            testListAccount.add(testAccount);    
        }
        Test.startTest(); // Start test
        insert testListAccount;
        Assignment10 objAssignment10 = new Assignment10();
        Test.stopTest(); // End test                       
        // Check result
        System.assertEquals(testListAccount, objAssignment10.accountRecordsPicklist());              
    } // End of method
    
    /**
     *  Method to test SOQL query to find all Account records where 'Billing State' is not 'Maharashtra' 
     *  and 'Kerala'.
     */
    static testMethod void testAccountRecordsBillingState() {
        Integer i = 0;
        List<Account> testListAccount = new List<Account>();
        for(i = 0; i <= 10; i++) {
            Account testAccount = new Account(Name = 'Test'+i, 
                                              Billing_State__c = 'UP');
            testListAccount.add(testAccount);    
        }
        Test.startTest(); // Start test
        Assignment10 objAssignment10 = new Assignment10();
        insert testListAccount;
        Test.stopTest();// End test
        // Check result
        System.assertEquals(testListAccount, objAssignment10.accountRecordsBillingState()); 
    } // End of method
    
    /**
     *  Method to test SOQL query to display 100 opportunity records with amount greater than 10,000 
     *  order by created date. Skip first 50 records and include records from recycle bin. 
     */
    static testMethod void testOportunityRecords() {
        Integer i = 0;
        List<Opportunity> testListOpportunity = new List<Opportunity>();
        for(i = 0; i <= 50; i++) {
            Opportunity testOpportunity = new Opportunity(Name = 'Test' + i,
                                                          CloseDate = System.Today(),
                                                          StageName = 'Closed Won',
                                                          Amount  =  11000);
            testListOpportunity.add(testOpportunity);    
        }
        Test.startTest(); // Start test
        Assignment10 objAssignment10 = new Assignment10();
        insert testListOpportunity;
        Test.stopTest(); // End test
        Integer count = objAssignment10.opportunityRecords().size();
        //for(i = 51;i < =  100; i++) {
            System.assertEquals(0, count); // Check result
        //}
    } // End of method
} // End of test class