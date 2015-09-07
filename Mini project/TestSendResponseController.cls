/*************************************************************************************************
 *  This is test class for SendResponse handler.
 *************************************************************************************************/
@isTest // Annotation
private class TestSendResponseController {
    /**
     *  Methdo to test getting all specified data from object Query_Response__c
     */
    static testMethod void testForResponse() {
        Query__c queryInstance = new Query__c(Search_String__c = 'test');
        insert queryInstance;
        
        Query_Response__c instanceQueryResponse = 
            new Query_Response__c(Title__c = 'test', 
                                  Link__c = 'www.test.com', 
                                  Description__c = 'It is test description',
                                  Query__c = queryInstance.id
            );
        insert instanceQueryResponse;
        Test.startTest();
        SendResponseController objSendResponseController = new SendResponseController();
        objSendResponseController.queryId = queryInstance.id;
        List<Query_Response__c> testQueryResponse = objSendResponseController.getResponsesToSend();
        Test.stopTest();
        System.assertEquals(1,testQueryResponse.size());
    } // End of method
} // End of class