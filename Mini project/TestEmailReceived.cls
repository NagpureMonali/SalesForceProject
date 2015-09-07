/*************************************************************************************************
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *************************************************************************************************/
@isTest // Annotation
private class TestEmailReceived {
    /**
     *  Method to test email body(search string) is not blank
     */
    static testMethod void emailBodyNotBlank() {
        // Create a new email and envelope object
        Messaging.InboundEmail email  = new Messaging.InboundEmail();
        Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
        
        // Create the email body
        email.plainTextBody = 'Query[test]';
        email.fromAddress ='test@test.com';
        email.subject = 'Search String';
        
        EmailReceived objEmailReceived = new EmailReceived();
        
        Test.startTest();
        Messaging.InboundEmailResult result = objEmailReceived.handleInboundEmail(email, env);
        Test.stopTest();
        System.assertEquals(true,result.success);
    } // End of method
    
    /**
     *  Method to test email body(search string) is blank
     */
    static testMethod void emailBodyBlank() {
        // Create a new email and envelope object
        Messaging.InboundEmail email  = new Messaging.InboundEmail();
        Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
        
        // Create the email body
        email.plainTextBody = '';
        email.fromAddress ='test@test.com';
        email.subject = 'Search String';
        
        EmailReceived objEmailReceived = new EmailReceived();
        
        Test.startTest();
        Messaging.InboundEmailResult result = objEmailReceived.handleInboundEmail(email, env);
        Test.stopTest();
        System.assertEquals(false,result.success);
    } // End of method
    
    /**
     *  Method to test email body(search string) is not blank but not in proper formate
     */
    static testMethod void emailBodyNotBlankAndNotInProperFormate() {
        // Create a new email and envelope object
        Messaging.InboundEmail email  = new Messaging.InboundEmail();
        Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
        
        // Create the email body
        email.plainTextBody = 'test';
        email.fromAddress ='test@test.com';
        email.subject = 'Search String';
        
        EmailReceived objEmailReceived = new EmailReceived();
        
        Test.startTest();
        Messaging.InboundEmailResult result = objEmailReceived.handleInboundEmail(email, env);
        Test.stopTest();
        System.assertEquals(false,result.success);
    } // End of method
    
    /**
     *  Method to test if same query string is already present then it should not insert query 
     *  again
     */
    static testMethod void queryStringAlreadyExist() {
        Query__c queryInsatnce = new Query__c(Search_String__c = 'test');
        insert queryInsatnce;
        
        // Create a new email and envelope object
        Messaging.InboundEmail email  = new Messaging.InboundEmail();
        Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
        
        // Create the email body
        email.plainTextBody = 'Query[test]';
        email.fromAddress ='test@test.com';
        email.subject = 'Search String';
        email.fromName = 'Sender';
        EmailReceived objEmailReceived = new EmailReceived();
        Test.setMock(HttpCalloutMock.class, new HttpCalloutMockResponseForGoogle());
        Test.startTest();
        Messaging.InboundEmailResult result = objEmailReceived.handleInboundEmail(email, env);
        Test.stopTest(); 
        List<Query__c> queryList = [SELECT Search_String__c
                                    FROM Query__c 
                                    WHERE Search_String__c like 'test'
                                   ];
        System.assertEquals(1,queryList.size());
    } // End of method
    
    /**
     *  Method to test if query string is not present then insert it
     */
    static testMethod void queryStringAlreadyNotExist() {
        
        // Create a new email and envelope object
        Messaging.InboundEmail email  = new Messaging.InboundEmail();
        Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
        
        // Create the email body
        email.plainTextBody = 'Query[test]';
        email.fromAddress ='test@test.com';
        email.subject = 'Search String';
        email.fromName = 'Sender';
        EmailReceived objEmailReceived = new EmailReceived();
        Test.setMock(HttpCalloutMock.class, new HttpCalloutMockResponseForGoogle());
        Test.startTest();
        Messaging.InboundEmailResult result = objEmailReceived.handleInboundEmail(email, env);
        Test.stopTest(); 
        List<Query__c> queryList = [SELECT Search_String__c
                                    FROM Query__c 
                                    WHERE Search_String__c like 'test'
                                   ];
        System.assertEquals(1,queryList.size());
    } // End of method
    
    /**
     *  Method to test contact is already present then dont insert it again just create entry 
     *  in email object
     */
    static testMethod void contactAlreadyExistAndQueryNotExistInSet() {
        // Create a new email and envelope object
        Messaging.InboundEmail email  = new Messaging.InboundEmail();
        Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
        
        // Create the email body
        email.plainTextBody = 'Query[Test]';
        email.fromAddress ='test@test.com';
        email.subject = 'Search String';
        email.fromName = 'Sender';
        
        Contact contactInstance = new Contact(LastName = email.fromName,Email = email.fromAddress);
        insert contactInstance;
        
        EmailReceived objEmailReceived = new EmailReceived();
        
        Test.setMock(HttpCalloutMock.class, new HttpCalloutMockResponseForGoogle());
        Test.startTest();
        Messaging.InboundEmailResult result = objEmailReceived.handleInboundEmail(email, env);
        Test.stopTest();
        List<ResponseToSend__c> queryResponseList = [SELECT id 
                                                     FROM ResponseToSend__c
                                                    ];
        System.assertEquals(1,queryResponseList.size());
    } // End of method
    
    /**
     *  Method to test contact is already present then dont insert it again just create entry 
     *  in email object id query string is not present then only
     */
    static testMethod void contactAlreadyExistAndQueryExistInSet() {
        // Create a new email and envelope object
        Messaging.InboundEmail email  = new Messaging.InboundEmail();
        Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
        
        // Create the email body
        email.plainTextBody = 'Query[Test]';
        email.fromAddress ='test@test.com';
        email.subject = 'Search String';
        email.fromName = 'Sender';
        
        Query__c queryInsatnce = new Query__c(Search_String__c = 'test');
        insert queryInsatnce;
        
        Contact contactInstance = new Contact(LastName = email.fromName,Email = email.fromAddress);
        insert contactInstance;
        
        EmailReceived objEmailReceived = new EmailReceived();
        
        Test.setMock(HttpCalloutMock.class, new HttpCalloutMockResponseForGoogle());
        Test.startTest();
        Messaging.InboundEmailResult result = objEmailReceived.handleInboundEmail(email, env);
        Test.stopTest();
        List<ResponseToSend__c> queryResponseList = [SELECT id 
                                                     FROM ResponseToSend__c
                                                    ];
        System.assertEquals(1,queryResponseList.size());
    } // End of method
} // End of test class