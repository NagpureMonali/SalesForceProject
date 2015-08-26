/**
 *  This is test class for testing REST service 
 */
@isTest // Annotation
private class TestRESTService {
    /**
     *  Here is test method to test creation of lead
     */
    static testmethod void testLeadCreation(){
        Test.setMock(HttpCalloutMock.class, new HttpCalloutMockResponseForInsert());
        RESTService objRESTService = new RESTService();
        HttpResponse responceInstance = objRESTService.leadCreate();
        String contentType = responceInstance.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = responceInstance.getBody();
        String expectedValue = '{"status":"Success"}';
        System.assertEquals(actualValue, expectedValue);
        System.assertEquals(200, responceInstance.getStatusCode());
    } // End of method
    
    /**
     *  Here is test method to test deletion of lead
     */
    static testmethod void testLeadDelete(){
        Test.setMock(HttpCalloutMock.class, new HttpCalloutMockResponseForDelete());
        RESTService objRESTService = new RESTService();
        HttpResponse responceInstance = objRESTService.leadDelete();
        String contentType = responceInstance.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = responceInstance.getBody();
        String expectedValue = '{"status":"Success"}';
        System.assertEquals(actualValue, expectedValue);
        System.assertEquals(200, responceInstance.getStatusCode());
    } // End of method
    
    /**
     *  Here is test method to test update of lead
     */
    static testmethod void testLeadupdate(){
        Test.setMock(HttpCalloutMock.class, new HttpCalloutMockResponseForUpdate());
        RESTService objRESTService = new RESTService();
        HttpResponse responceInstance = objRESTService.leadUpdate();
        String contentType = responceInstance.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = responceInstance.getBody();
        String expectedValue = '{"status":"Success"}';
        System.assertEquals(actualValue, expectedValue);
        System.assertEquals(200, responceInstance.getStatusCode());
    } // End of method
} // End of class