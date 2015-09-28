/*************************************************************************************************
 *  This is test class for SearchHistoryController
 **************************************************************************************************/
@isTest // Annotation
private class TestSearchHistoryController {
    /**
     *  Method to test query string giving result or not
     */
    static testMethod void testQueryList() {
        Query__c queryInsatnce = new Query__c(Search_String__c = 'test');
        insert queryInsatnce;
        Test.startTest();
        SearchHistoryController objSearchHistoryController = new SearchHistoryController();
        Test.stopTest();
        List<Query__c> testQuery = objSearchHistoryController.getqueryList();
        System.assertEquals(1,testQuery.size());
    } // End of method
    
    /**
     *  Method to test showing details of particular query 
     */
    static testMethod void testShowDetails() {
        Query__c queryInsatnce = new Query__c(Search_String__c = 'test');
        insert queryInsatnce;
        
        Query_Response__c listQueryResponse =  new Query_Response__c 
            (Description__c = 'TestDescription',
             Link__c = 'www.test.com',
             Title__c ='Test Title',
             Query__c = queryInsatnce.id
            );
        Test.startTest();
        SearchHistoryController objSearchHistoryController = new SearchHistoryController();
        PageReference  instancePageReference = Page.SearchHistory;
        Test.setCurrentPage(instancePageReference);
        String query = 'test';
        ApexPages.currentPage().getParameters().put('searchString',query);
        objSearchHistoryController.showDetails();
        Test.stopTest();
        System.assertEquals(true,objSearchHistoryController.flag);
        System.assertNotEquals(null,objSearchHistoryController.listQueryResponse);
    } // End of method
    
    /**
     *  Method to test showing all details of particular query or not
     */
    static testMethod void testShowDetailsOfQuery() {
        Query__c queryInsatnce = new Query__c(Search_String__c = 'test');
        insert queryInsatnce;
        
        Query_Response__c listQueryResponse =  new Query_Response__c 
            (Description__c = 'TestDescription',
             Link__c = 'www.test.com',
             Title__c ='Test Title',
             Query__c = queryInsatnce.id
            );
        
        Test.startTest();
        SearchHistoryController objSearchHistoryController = new SearchHistoryController();
        PageReference  instancePageReference = Page.SearchHistory;
        Test.setCurrentPage(instancePageReference);
        String query = 'test';
        ApexPages.currentPage().getParameters().put('searchString',query);
        List<Query_Response__c> testQueryResponse = objSearchHistoryController.getshowDetailsOfQuery();
        Test.stopTest();
        System.assertNotEquals(null,testQueryResponse.size());
    } // End of method
    
    /**
     *  Method to test standard set controller
     */
    static testMethod void testStandrdSetController() {
        //List<Query__c> opps = new List<Query__c>([SELECT Search_String__c FROM Query__c]);
        Test.startTest();
        SearchHistoryController objSearchHistoryController = new SearchHistoryController();
        ApexPages.StandardSetController objStandardSetController =  objSearchHistoryController.setCon;
        List<Query__c> testQuery = objSearchHistoryController.getQueries();
        Test.stopTest();
        System.assertNotEquals(null,testQuery.size());
    } // End of method
} // End of test class