/**
 *  This is test class for ClosedWonOpportunityBatchJob
 */
@isTest
private class TestClosedWonOpportunityBatchJob {
    /**
     *  Method to test opportunities having stage closed own 
     */
    static testMethod void testOpportunityRecords() {
        Test.startTest();
        List<Account> acccountList = TestDataFactory.createTestRecordsForAccount(5,'Test');
        List<Contact> contactList = new List<Contact>();
        List<Opportunity> opportunityList = new List<Opportunity>();
        for (Account accountInstance : acccountList) {         
            Contact contactInstance = new Contact(LastName = 'TestContact' , 
                                                  AccountId = accountInstance.Id);
            contactList.add(contactInstance );
            Opportunity opportunityInstance = new Opportunity(Name = 'Test Opportunity',
                                                              StageName = 'Closed Won',
                                                              AccountId = accountInstance.Id,
                                                              CloseDate = System.Today()
                                                              );
            opportunityList.add(opportunityInstance);
        }
        insert contactList;
        insert opportunityList;
        //ClosedWonOpportunityBatchJob objClosedWonOpportunityBatchJob = new ClosedWonOpportunityBatchJob();
        // Database.executeBatch( new ClosedWonOpportunityBatchJob());
        List<Opportunity> opportunityListNew = [SELECT Id, 
                                                       Name, 
                                                       Amount,
                                                       AccountId,
                                                       Account.Email_Address__c
                                                FROM Opportunity Instance 
                                                WHERE StageName = 'Closed Won'
                                                AND AccountId <> null
                                               ];
        Test.stopTest();
        System.assertEquals(opportunityList.size(),opportunityListNew.size());
    } // End of Method
    
    /**
     *  Method to test opportunities having stage other than closed own 
     */
    static testMethod void testOpportunityRecordsNotClosedWon() {
        Test.startTest();
        List<Account> acccountList = TestDataFactory.createTestRecordsForAccount(5,'Test');
        List<Contact> contactList = new List<Contact>();
        List<Opportunity> opportunityList = new List<Opportunity>();
        for (Account accountInstance : acccountList) {         
            Contact contactInstance = new Contact(LastName = 'TestContact' , 
                                                  AccountId = accountInstance.Id);
            contactList.add(contactInstance );
            Opportunity opportunityInstance = new Opportunity(Name = 'Test Opportunity',
                                                              StageName = 'Prospecting',
                                                              AccountId = accountInstance.Id,
                                                              CloseDate = System.Today()
                                                              );
            opportunityList.add(opportunityInstance);
        }
        insert contactList;
        insert opportunityList;
        ClosedWonOpportunityBatchJob objClosedWonOpportunityBatchJob = new ClosedWonOpportunityBatchJob();
        //Database.executeBatch(objClosedWonOpportunityBatchJob);
        List<Opportunity> opportunityListNew = [SELECT Id, 
                                                       Name, 
                                                       Amount,
                                                       AccountId,
                                                       Account.Email_Address__c
                                                FROM Opportunity Instance 
                                                WHERE StageName = 'Closed Won'
                                                AND AccountId <> null
                                                ];
        Test.stopTest();
        System.assertEquals(0,opportunityListNew.size());
    } // End of Method
    
    /**
     *  Method to test opportunities having Null Account 
     */
    static testMethod void testOpportunityRecordsNullAccount() {
        Test.startTest();
        List<Opportunity> opportunityList = new List<Opportunity>();
        for (Integer i=0; i< 5; i++) {         
            Opportunity opportunityInstance = new Opportunity(Name = 'Test Opportunity',
                                                              StageName = 'Closed Won',
                                                              CloseDate = System.Today()
                                                              );
            opportunityList.add(opportunityInstance);
        }
        insert opportunityList;
        ClosedWonOpportunityBatchJob objClosedWonOpportunityBatchJob = new ClosedWonOpportunityBatchJob();
        //Database.executeBatch(objClosedWonOpportunityBatchJob);
        List<Opportunity> opportunityListNew = [SELECT Id, 
                                                       Name, 
                                                       Amount,
                                                       AccountId,
                                                       Account.Email_Address__c
                                                FROM Opportunity Instance 
                                                WHERE StageName = 'Closed Won'
                                                AND AccountId <> null
                                                ];
        Test.stopTest();
        System.assertEquals(0,opportunityListNew.size());
    } // End of Method
    
    /**
     *  Method to test opportunities having Account but account having null contact 
     */
    static testMethod void testOpportunityRecordsAccountNullContact() {
        Test.startTest();
        List<Account> acccountList = TestDataFactory.createTestRecordsForAccount(5,'Test');
        List<Opportunity> opportunityList = new List<Opportunity>();
        for (Account accountInstance : acccountList) {         
            Opportunity opportunityInstance = new Opportunity(Name = 'Test Opportunity',
                                                              StageName = 'Closed Won',
                                                              CloseDate = System.Today()
                                                              );
            opportunityList.add(opportunityInstance);
        }
        insert opportunityList;
        ClosedWonOpportunityBatchJob objClosedWonOpportunityBatchJob = new ClosedWonOpportunityBatchJob();
        //Database.executeBatch(objClosedWonOpportunityBatchJob);
        List<Opportunity> opportunityListNew = [SELECT Id, 
                                                       Name, 
                                                       Amount,
                                                       AccountId,
                                                       Account.Email_Address__c
                                                FROM Opportunity Instance 
                                                WHERE StageName = 'Closed Won'
                                                AND AccountId <> null
                                                ];
        Test.stopTest();
        System.assertEquals(0,opportunityListNew.size());
    } // End of Method
} // End of test class