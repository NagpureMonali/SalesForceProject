/**
 *  Test class to test RemovalOfDuplicateLeadsBatchJob
 */ 
@isTest
private class TestRemovalOfDuplicateLeadsBatchJob {
    /**
     *  Method to test if criteria is email 
     */
    static testMethod void testForCriteria() {
        LeadName__c LeadNameInstance = new LeadName__c();
        LeadNameInstance.Criteria__c = 'Email';
        List<Lead> leadList = TestDataFactory.createTestRecordsForLead(1,'a@a.com','123','12345');
        Database.executeBatch(new RemovalOfDuplicateLeadsBatchJob());
        List<Lead> leadListnew = [SELECT Id, 
                                         Name, 
                                         Email 
                                  FROM Lead 
                                  WHERE Name <> NULL 
                                  AND Email <> NULL
                                 ];
        String testQuery = 'SELECT Id, Name, Email FROM Lead WHERE Name <> NULL AND Email <> NULL';
        Test.startTest();
        RemovalOfDuplicateLeadsBatchJob objRemovalOfDuplicateLeadsBatchJob = 
            new RemovalOfDuplicateLeadsBatchJob();
        Database.executeBatch( new RemovalOfDuplicateLeadsBatchJob());
        Test.stopTest();
        System.assertEquals(1,leadListnew.size());
        System.assertEquals(testQuery,objRemovalOfDuplicateLeadsBatchJob.query);
    } // End of method
    
    /**
     *  Method to test if criteria is Phone 
     */
    static testMethod void testForCriteriaPhone() {
        LeadName__c LeadNameInstance = new LeadName__c();
        LeadNameInstance.Criteria__c = 'Phone';
        String testQuery = 'SELECT Id, Name, Email FROM Lead WHERE Name <> NULL AND Phone <> NULL';
        List<Lead> leadList = TestDataFactory.createTestRecordsForLead(1,'a@a.com','123','12345');
        Database.executeBatch(new RemovalOfDuplicateLeadsBatchJob());
        List<Lead> leadListnew = [SELECT Id, 
                                         Name, 
                                         Email 
                                  FROM Lead 
                                  WHERE Name <> NULL 
                                  AND Phone <> NULL
                                 ];
        Test.startTest();
        RemovalOfDuplicateLeadsBatchJob objRemovalOfDuplicateLeadsBatchJob = 
            new RemovalOfDuplicateLeadsBatchJob();
        Database.executeBatch( new RemovalOfDuplicateLeadsBatchJob());
        Test.stopTest();
        System.assertEquals(1,leadListnew.size());
        System.assertEquals(testQuery,objRemovalOfDuplicateLeadsBatchJob.query);
    } // End of method
    
    /**
     *  Method to test if criteria is MobilePhone 
     */
    static testMethod void testForCriteriaMobilePhone() {
        LeadName__c LeadNameInstance = new LeadName__c();
        LeadNameInstance.Criteria__c = 'MobilePhone';
        String testQuery = 'SELECT Id, Name, Email FROM Lead WHERE Name <> NULL AND Phone <> NULL';
        List<Lead> leadList = TestDataFactory.createTestRecordsForLead(1,'a@a.com','123','12345');
        Database.executeBatch(new RemovalOfDuplicateLeadsBatchJob());
        List<Lead> leadListnew = [SELECT Id, 
                                         Name, 
                                         Email 
                                  FROM Lead 
                                  WHERE Name <> NULL 
                                  AND MobilePhone <> NULL
                                 ];
        Test.startTest();
        RemovalOfDuplicateLeadsBatchJob objRemovalOfDuplicateLeadsBatchJob = 
            new RemovalOfDuplicateLeadsBatchJob();
        Database.executeBatch( new RemovalOfDuplicateLeadsBatchJob());
        Test.stopTest();
        System.assertEquals(1,leadListnew.size());
        System.assertEquals(testQuery,objRemovalOfDuplicateLeadsBatchJob.query);
    } // End of method
} // End of test class