/**************************************************************************************************
 *  Here is class which implements HttpCalloutMock class to get responce from delete method
 *  of REST Service.
 **************************************************************************************************/
global class HttpCalloutMockResponseForDelete implements HttpCalloutMock {
    /**
     *  Here is method to show responce of callout delete method
     */
    global HTTPResponse respond(HTTPRequest req) {
        HttpResponse httpResponse = new HttpResponse();
        httpResponse .setHeader('Content-Type', 'application/json');
        httpResponse.setStatusCode(200);
        httpResponse.setBody('{"status":"Success"}');
        return httpResponse;
    } // End of method
} // End of class