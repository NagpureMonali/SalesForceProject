@isTest // Annotation
/************************************************************************************
*  QueryFunctions Test class is to test Advanced concepts / Collections/
*  SOQL Queries/DML Operations 
*************************************************************************************/
private class TestQueryFunctions 
{
    /**
     *  Method to test query on Account object /records and if the account is person account 
     *  fetch them.
     */
    static testMethod void testAccountRecords() {
         List<Account> listAccount  = new List<Account>(); 
         for(Integer i = 0;i<5;i++) {
              Account testAccount = new Account(Name = 'Test'+i, Type = 'Person Account');
              listAccount.add(testAccount);
         }
         Test.startTest(); // Start test
         insert listAccount;
         Test.stopTest(); // End test
         QueryFunctions objQueryFunctions = new QueryFunctions(); // Instance of class                                    
         List<Account> listAccountInstance = new List<Account>();
         listAccountInstance = objQueryFunctions.accountRecords(); // Assign list to new list
         Integer count = listAccountInstance.size(); // Count size of list
         System.debug('size----'+count);
         System.assertEquals(5,count,'Total 5 records'); // Check for result
    } // End of method
    
     /**
      *  Method to test query on Account object /records and if the account is not person account 
      *  then it should return 0 records
      */
    static testMethod void testAccountPerson() {
         Test.startTest(); // Start test
         List<Account> listAccount  = new List<Account>(); 
         for(Integer i = 0; i<10; i++) {
              Account testAccount = new Account(Name = 'ABC'+i,Type = 'Person Account');
              listAccount.add(testAccount);
         }
         insert listAccount;
         Test.stopTest(); // End test
         List<Account> listAccountInstance = [SELECT Id 
                                              FROM Account 
                                              WHERE Type <> 'Person Account'
                                              ]; // List of account
         Integer count = listAccountInstance.size(); // Find size of list 
         System.debug('size----'+count);
         System.assertEquals(0,count,'Total 0 records'); // Check for result
    } // End of method
    
    /**
     *  Method to test Opportunity records where its Account ! =  NULL and Status  =  Closed
     *  & Prepare the Map having Key as OpportunityId and Value as AccountId
     */
    static testMethod void testOportunityRecords() {
        Test.startTest(); // Start test
        List<Opportunity> testListOpportunity =  new List<Opportunity>();
        for(Integer i = 0;i<10;i++) {
              Opportunity testOpportunity = new Opportunity(AccountId = '00128000004JV49',
                                                            Name = 'ABC'+i, 
                                                            StageName = 'Closed Won', 
                                                            CloseDate = System.TODAY()
                                                            );
              testListOpportunity.add(testOpportunity);
        }
        QueryFunctions objQueryFunctions = new QueryFunctions();
        Map<ID,ID> testOpportunityMap =  new Map<ID,ID>();
        insert testListOpportunity;
        for(Integer i = 0;i<testListOpportunity.size();i++) {
            // Put value in map
            testOpportunityMap.put(testListOpportunity[i].ID,testListOpportunity[i].AccountID);
        }
        Test.stopTest();// End test
        System.assertEquals(testOpportunityMap,objQueryFunctions.oportunityRecords());
    } // End of method
    
    /**
     *  Method to test Opportunity records where its Account  =  =  NULL and Status  =  Closed
     */
    static testMethod void testOportunityAccountNull() {
        Test.startTest(); // Start test
        List<Opportunity> testListOpportunity =  new List<Opportunity>();
        for(Integer i = 0;i<10;i++) {
              Opportunity testOpportunity = new Opportunity(Name = 'ABC'+i, 
                                                            StageName = 'Closed Won', 
                                                            CloseDate = System.TODAY()
                                                            );
              testListOpportunity.add(testOpportunity);
        }
        insert testListOpportunity;
        List<Opportunity> testOpportunityRecords = [SELECT Id,
                                                           AccountID
                                                    FROM Opportunity 
                                                    WHERE AccountID <> NULL 
                                                    AND StageName like 'Closed%'
                                                   ];
        Test.stopTest();// End test
        System.assertEquals(0,testOpportunityRecords.size());
    } // End of method
    
    /**
     *  Method to test Opportunity records where its Account ! =  NULL and Status ! =  Closed
     */
    static testMethod void testOportunityStatus() {
        Test.startTest(); // Start test
        List<Opportunity> testListOpportunity =  new List<Opportunity>();
        for(Integer i = 0;i<10;i++) {
              Opportunity testOpportunity = new Opportunity(AccountId = '00128000004JV49',
                                                            Name = 'ABC'+i, 
                                                            StageName = 'Prospecting', 
                                                            CloseDate = System.TODAY()
                                                            );
              testListOpportunity.add(testOpportunity);
        }
        insert testListOpportunity;
        List<Opportunity> testOpportunityRecords = [SELECT Id,
                                                           AccountID
                                                    FROM Opportunity 
                                                    WHERE AccountID <> NULL 
                                                    AND StageName like 'Closed%'
                                                  ];
        Test.stopTest();// End Tests
        System.assertEquals(0,testOpportunityRecords.size());
    } // End of method
    
    /**
     *  Method to get the child opportunities of Account 
     */
    
    static testMethod void testAccountOpportunity() {
        List<Account> listAccount  = new List<Account>();
        List<Opportunity> testListOpportunity =  new List<Opportunity>(); 
        for(Integer i = 0;i<2;i++) {
              Account testAccount = new Account(Name = 'Test'+i, Type = 'Person Account');
              listAccount.add(testAccount);
              for(Integer j = 0;j<3;j++) {
              Opportunity testOpportunity = new Opportunity(AccountId = listAccount[i].Id,
                                                            Name = 'ABC'+i, 
                                                            StageName = 'Prospecting', 
                                                            CloseDate = System.TODAY());
              testListOpportunity.add(testOpportunity);
              }
         }
       Test.startTest(); // Start test
       insert listAccount;
       insert testListOpportunity;
       List<Account> testListAccount  =  [SELECT a.Name, 
                                                 a.Id,
                                                (SELECT Id, 
                                                        Name 
                                                 FROM Opportunities
                                                 WHERE AccountID!= NULL
                                                ) 
                                          FROM Account a
                                          ]; // List of account
        Map<Id, List<Opportunity>> testMapAccount =  new Map<Id, List<Opportunity>>(); // Map
        for(Account accountInstatnce : testListAccount) {
            testMapAccount.put(accountInstatnce.Id, accountInstatnce.Opportunities); // Put values in map
        }
         QueryFunctions objQueryFunctions = new QueryFunctions();
         System.assertEquals(testMapAccount,objQueryFunctions.accountOpportunityMap()); // Check for result
         Test.stopTest(); // End test
    } // End of method
    
    /**
     *  Method to retrieve/print 10 Campaign records 
     */
    static testMethod void testCampaignRecords() {
        List<Campaign> listCampaign  = new List<Campaign>(); 
        for(Integer i = 0;i<10;i++) {
             Campaign testCampaign = new Campaign(Name = 'Test'+i);
             listCampaign.add(testCampaign);
        }                                                  
        QueryFunctions objQueryFunctions = new QueryFunctions();
        Test.startTest(); // Start test
        insert listCampaign;
        Test.stopTest(); // End test
        System.assertEquals(listCampaign.size(),objQueryFunctions.campaignRecords().size()); // Check for result
    } // End of method
    
    /**
     *  Method to test if 10 records are not available then should retrive all available records
     */
    static testMethod void testCampaignRecordsLessThan10() {
        List<Campaign> listCampaign  = new List<Campaign>(); 
        for(Integer i = 0;i<5;i++) {
             Campaign testCampaign = new Campaign(Name = 'Test'+i);
             listCampaign.add(testCampaign);
        }                                                  
        QueryFunctions objQueryFunctions = new QueryFunctions();
        Test.startTest(); // Start test
        insert listCampaign;
        Test.stopTest(); // End test
        System.assertEquals(5,listCampaign.size()); // Check for result
    } // End of method
    
    /**
     *  Method to test Order Of Records are in Decsending order
     */
    static testMethod void testCampaignRecordsDescendingOrder() {
        List<Campaign> listCampaign  = new List<Campaign>(); 
        for(Integer i = 10;i<20;i++) {
             Campaign testCampaign = new Campaign(Name = 'Test'+i);
             listCampaign.add(testCampaign);
        }                                                  
        QueryFunctions objQueryFunctions = new QueryFunctions();
        Test.startTest(); // Start test
        insert listCampaign;
        listCampaign = objQueryFunctions.campaignRecords();
        Test.stopTest(); // End test
        System.assertEquals('Test19',listCampaign[0].Name); // Check for result
    } // End of method
    
    /**
     *  Method to test Contact records where Last Modified Date  =  Today
     */
    static testMethod void testContactRecord() {
         List<Contact> testContactlist = new list<Contact>(); 
         for(Integer i = 0;i<5;i++) {
             Contact testContact = new Contact(LastName = 'Test'+i);
             testContactlist.add(testContact);
         }                               
         QueryFunctions objQueryFunctions = new QueryFunctions();
         Test.startTest(); // Start test
         insert testContactlist;
         System.assertEquals(5,testContactlist.size()); // Check for result
         Test.stopTest(); // End test
    } // End of method
    
    /**
     *  Method to test Contact records where Last Modified Date is not Today
     */
    static testMethod void testContactRecordNotModifiedToday() {
         List<Contact> testContactlist = new list<Contact>(); 
         for(Integer i = 0;i<5;i++) {
             Contact testContact = new Contact(LastName = 'Test'+i);
             testContactlist.add(testContact);
         }                               
         QueryFunctions objQueryFunctions = new QueryFunctions();
         Test.startTest(); // Start test
         insert testContactlist;
         Test.stopTest(); // End test
         System.assertEquals(0,objQueryFunctions.contactRecord().size()); // Check for result
    } // End of method
}// End of Test Class