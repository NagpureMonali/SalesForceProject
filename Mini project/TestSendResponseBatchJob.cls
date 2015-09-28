/*************************************************************************************************
 *  This is the test class for testing sendResponseBatchJOb
 *************************************************************************************************/
@isTest // Annotation
private class TestSendResponseBatchJob {
    /**
     *  Method to test replay list contain related contact or not
     */
    static testMethod void testSendingReplyEmail() {
       Messaging.InboundEmail email = new Messaging.InboundEmail();
       Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
       
       email.fromAddress = 'test@test.com';
       email.Subject = 'Test Search';
       email.plainTextBody = 'Query[test]';
       email.fromName = 'Test';
       Test.setMock(HttpCalloutMock.class, new HttpCalloutMockResponseForGoogle());
       EmailReceived objEmailReceived = new EmailReceived();
       Messaging.InboundEmailResult result = objEmailReceived.handleInboundEmail(email, env);
       SendResponseBatchJob objSendResponseBatchJob = new SendResponseBatchJob();
       
       Test.startTest();
       Database.executeBatch(objSendResponseBatchJob);       
       Test.stopTest();
       
       List<ResponseToSend__c> testResponseToSend = [SELECT Query__c, Contact__c
                                                     FROM ResponseToSend__c
                                                     WHERE Contact__r.LastName = 'Test'
                                                    ];
       System.assertEquals(1,testResponseToSend.size());
    } // End of Method
} // End of test class