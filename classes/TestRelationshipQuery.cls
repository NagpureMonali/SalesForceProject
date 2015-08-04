/************************************************************************
 *  This is test lass for relationship queries which contain
 *  1. Child to parent Queries
 *  2. Parent To child Queries
 ***************************************************************************/
@isTest // Annotation
private class TestRelationshipQuery  
{
    /**
     *  Method to test SOQL query on Contact to retrieve all active contacts belonging to 'media' 
     *  Industry. Also display the name of the account to which it is associated to.
     */
    static testMethod void testContactRecords() {
        Integer i = 0;
        List<Account> testListAccount = new List<Account>();
        List<Contact> testListContact = new List<Contact>();
        Test.startTest(); //Start test 
        Account testAccount = new Account(Name ='Test',Industry ='Media',Active__c = 'Yes');
        testListAccount.add(testAccount);
        insert testListAccount;    
        Contact testContact = new Contact(LastName ='Test', AccountId = testAccount.Id);
        testListContact.add(testContact);   
        insert testListContact; 
        RelationshipQuery objRelationshipQuery = new RelationshipQuery(); 
        Test.stopTest(); // End test
        // Check for result
        System.assertEquals(1, objRelationshipQuery.contactRecords().size());
    } // End of method
    
    /**
     *  Method to test SOQL query on Contact to retrieve all inactive contacts belonging to 'media' 
     *  Industry. Also display the name of the account to which it is associated to.
     */
    static testMethod void testContactRecordsNotActive() {
        Integer i = 0;
        List<Account> testListAccount = new List<Account>();
        List<Contact> testListContact = new List<Contact>();
        Test.startTest(); //Start test 
        Account testAccount = new Account(Name ='Test',Industry ='Media');
        testListAccount.add(testAccount);
        insert testListAccount;    
        Contact testContact = new Contact(LastName ='Test', AccountId = testAccount.Id);
        testListContact.add(testContact);   
        insert testListContact;
        //Test.startTest(); //Start test 
        RelationshipQuery objRelationshipQuery = new RelationshipQuery(); 
        Test.stopTest(); // End test
        // Check for result
        System.assertEquals(0, objRelationshipQuery.contactRecords().size());
    } // End of method
    
    /**
     *  Method to test to retrieve all inactive contacts not belonging to 'media' 
     *  Industry. Also display the name of the account to which it is associated to.
     */
    static testMethod void testContactRecordsNotMedia() {
        Integer i = 0;
        List<Account> testListAccount = new List<Account>();
        List<Contact> testListContact = new List<Contact>();
        Test.startTest(); //Start test 
        Account testAccount = new Account(Name = 'Test',Industry = 'Banking');
        testListAccount.add(testAccount);
        insert testListAccount;    
        Contact testContact = new Contact(LastName = 'Test', AccountId = testAccount.Id);
        testListContact.add(testContact);   
        insert testListContact;
        //Test.startTest(); //Start test 
        RelationshipQuery objRelationshipQuery = new RelationshipQuery(); 
        Test.stopTest(); // End test
        // Check for result
        System.assertEquals(0, objRelationshipQuery.contactRecords().size());
    } // End of method
    
     /**
      *  Method to test SOQL query on Account and find all associated contact records of the Account
      *  which contains the word 'John'. Print all Account and Contact records retrieved above.
      */
     static testmethod void testRecordOfContact() {
        List<Account> testAccountList = new List<Account>();
        List<Contact> testListContact = new List<Contact>();
        Test.startTest(); //Start test
        Account testAccount = new Account(Name = 'Test');
        testAccountList.add(testAccount);
        insert testAccountList;
        Contact testContact = new Contact(LastName = 'john', AccountId = testAccount.Id);
        testListContact.add(testContact);   
        insert testListContact; 
        RelationshipQuery objRelationshipQuery = new RelationshipQuery();
        Test.stopTest(); // End test
        System.assertEquals(1,objRelationshipQuery.RecordOfContact().size()); // Check for result
    } // End of method
     
    /**
     *  Method to test SOQL query on Account and find all associated contact records of the Account
     *  which contains the word 'John'. Print all Account and Contact records retrieved above.
     */
    static testmethod void testRecordOfContactNOtJohn() {
        List<Account> testAccountList = new List<Account>();
        List<Contact> testListContact = new List<Contact>();
        Test.startTest(); //Start test
        Account testAccount = new Account(Name = 'Test');
        testAccountList.add(testAccount);
        insert testAccountList;
        Contact testContact = new Contact(LastName = 'Test', AccountId = testAccount.Id);
        testListContact.add(testContact);   
        insert testListContact; 
        RelationshipQuery objRelationshipQuery = new RelationshipQuery();
        Test.stopTest(); // End test
        System.assertEquals(0, objRelationshipQuery.RecordOfContact().size()); // Check for result
    } // End of method
     
    /**
     *  Method to test SOQL query to find all Account records which have at least an opportunity 
     *  record which is 'Closed Won'.
     */
    static testmethod void testOpportinutyChild() {
        Test.startTest(); //Start test
        List<Account> testAccountList = new  List<Account>();
        Account testAccount = new Account(Name = 'Test');
        testAccountList.add(testAccount);
        insert testAccountList;
        List<Opportunity> testOpportunityList = new  List<Opportunity>();
        Opportunity testOpportunity = new Opportunity(Name ='Test',
                                                      AccountId = testAccount.Id,
                                                      CloseDate = System.today(),
                                                      StageName = 'Closed Won');
        testOpportunityList.add(testOpportunity);
        insert testOpportunityList;
        RelationshipQuery objRelationshipQuery = new RelationshipQuery();
        Test.stopTest(); // End test
        System.assertEquals(1, objRelationshipQuery.opportinutyChild().size()); // Check for result
    } // End of method 
      
    /**
     *  Method to test SOQL query to find all Account records which have at least an opportunity 
     *  record which is not 'Closed Won'.
     */
    static testmethod void testOpportinutyChildNotClosed() {
        Test.startTest(); //Start test
        List<Account> testAccountList = new  List<Account>();
        Account testAccount = new Account(Name ='Test');
        testAccountList.add(testAccount);
        insert testAccountList;
        List<Opportunity> testOpportunityList = new List<Opportunity>();
        Opportunity testOpportunity = new Opportunity(Name ='Test',
                                                      AccountId = testAccount.Id,
                                                      CloseDate = System.today(),
                                                      StageName = 'Prospecting');
        testOpportunityList.add(testOpportunity);
        insert testOpportunityList;
        RelationshipQuery objRelationshipQuery = new RelationshipQuery();
        Test.stopTest(); // End test
        System.assertEquals(0, objRelationshipQuery.opportinutyChild().size()); // Check for result
    } // End of method 
      
    /**
     *  Method to test SOQL query to find all Account records which dont have an opportunity 
     *  record
     */
    static testmethod void testOpportinutyChildNotOpportunity() {
        Test.startTest(); //Start test
        List<Account> testAccountList = new List<Account>();
        Account testAccount = new Account(Name ='Test');
        testAccountList.add(testAccount);
        insert testAccountList;
        RelationshipQuery objRelationshipQuery = new RelationshipQuery();
        Test.stopTest(); // End test
        System.assertEquals(0, objRelationshipQuery.opportinutyChild().size()); // Check for result
    } // End of method 

    /**
     *  Method to retrieve all records of 'C' with name other than'John' 
     *  along with parent details.
     */
    static testmethod  void testObjCOtherThanJohn() {
        Test.startTest(); // Start test
        RelationshipQuery objRelationshipQuery = new RelationshipQuery();
        A__c testA = new A__c(Name = 'Test');
        insert testA;
        B__c testB = new B__c(Name = 'Test');
        insert testB;
        C__c testC = new C__c(Name = 'Test', From_Object_A__c = testA.Id, From_Object_B__c = testB.Id);
        insert testC;
        Test.stopTest(); // End test                      
        System.assertEquals(0,objRelationshipQuery.ObjCRecords().size()); // Check for result
    } // End of method  
     
    /**
     *  Method to retrieve all records of 'C' with name 'John' 
     *  along with parent details.
     */
    static testmethod  void testObjCRecords() {
        Test.startTest(); // Start test
        RelationshipQuery objRelationshipQuery = new RelationshipQuery();
        A__c testA = new A__c(Name = 'Test');
        insert testA;
        B__c testB = new B__c(Name = 'Test');
        insert testB;
        C__c testC = new C__c(Name = 'John', From_Object_A__c = testA.Id, From_Object_B__c = testB.Id);
        insert testC;
        Test.stopTest(); // End test                      
        System.assertEquals(1, objRelationshipQuery.ObjCRecords().size()); // Check for result
    } // End of method  
     
     /**
      *  Method to test SOQL query on 'A' and retrieve parent with all their child records where
      *  in child name is 'John'.
      */ 
    static testmethod  void testChildJohn() {
        Integer i = 0;
        Test.startTest(); // Start test
        RelationshipQuery objRelationshipQuery = new RelationshipQuery();
        A__c testA = new A__c(Name = 'Test'+i);
        insert testA;
        B__c testB = new B__c(Name = 'Test'+i);
        insert testB;
        C__c testC = new C__c(Name = 'John', From_Object_A__c = testA.Id, From_Object_B__c = testB.Id);
        insert testC;
        Test.stopTest(); // End test                      
        System.assertEquals(1, objRelationshipQuery.ChildJohn().size()); // Check for result
    } // End of method 
      
    /**
     *  Method to test SOQL query on 'A' and retrieve parent with all their child records where
     *  in child name is 'John'.
     */ 
    static testmethod  void testChildNotJohn() {
        Integer i = 0;
        Test.startTest(); // Start test
        RelationshipQuery objRelationshipQuery = new RelationshipQuery();
        A__c testA = new A__c(Name = 'Test'+i);
        insert testA;
        B__c testB = new B__c(Name = 'Test'+i);
        insert testB;
        C__c testC = new C__c(Name = 'John'+i, From_Object_A__c = testA.Id, From_Object_B__c = testB.Id);
        insert testC;
        Test.stopTest(); // End test                      
        System.assertEquals(0,objRelationshipQuery.ChildJohn().size()); // Check for result
    } // End of method 
} // End of test class