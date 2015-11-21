/**
 *  Test class to test RemovalOfDuplicateLeadsBatchJob
 */
@isTest
private class TestRemovalOfDuplicateLeadsBatchJob {
    /**
     *  Method to test duplicate record is deleted 
     */
    static testMethod void testForDuplicateRecords() {
        Test.startTest();
        List<Lead> leadList = TestDataFactory.createTestRecordsForLead(2,'a@a.com');
        //RemovalOfDuplicateLeadsBatchJob objRemovalOfDuplicateLeadsBatchJob = 
        //                                new RemovalOfDuplicateLeadsBatchJob();
        Database.executeBatch(new RemovalOfDuplicateLeadsBatchJob());
        List<Lead> leadListnew = [SELECT LastName,
                                         Email,
                                         Company,
                                         Status
                                  FROM Lead 
                                  Where Email <> null 
                                  AND Email = 'a@a.com'
                                 ];
        Test.stopTest();
        System.assertEquals(1,leadListnew.size());
    }
    
    /**
     *  Method to test duplicate record not deleted 
     */
    static testMethod void testForDuplicateRecordsNotDeleted() {
        Test.startTest();
        List<Lead> leadList = TestDataFactory.createTestRecordsForLead(2,'a@a.com');
        //RemovalOfDuplicateLeadsBatchJob objRemovalOfDuplicateLeadsBatchJob = 
        //                                new RemovalOfDuplicateLeadsBatchJob();
        //Database.executeBatch(new RemovalOfDuplicateLeadsBatchJob());
        List<Lead> leadListnew = [SELECT LastName,
                                         Email,
                                         Company,
                                         Status
                                  FROM Lead 
                                  Where Email <> null 
                                  AND Email = 'a@a.com'
                                 ];
        Test.stopTest();
        System.assertEquals(4,leadListnew.size());
    }
}