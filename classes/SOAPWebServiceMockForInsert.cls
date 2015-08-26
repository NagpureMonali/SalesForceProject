/**************************************************************************************************
 *  Mock test class for lead creation
 **************************************************************************************************/
@isTest // Annotation
global class SOAPWebServiceMockForInsert implements WebServiceMock {
    global void doInvoke(Object stub,
                         Object request,
                         Map<String, Object> response,
                         String endpoint,
                         String soapAction,
                         String requestName,
                         String responseNS,
                         String responseName,
                         String responseType
    ) {
        // Create response element from the autogenerated class.
        soapSforceComSchemasClassSoapleadwe.createNewLeadResponse_element responseElement = 
            new soapSforceComSchemasClassSoapleadwe.createNewLeadResponse_element();
        responseElement.result = new soapSforceComSchemasClassSoapleadwe.ResponseHandler();
        responseElement.result.isSuccess = true;
        responseElement.result.status = 'Mock response';
        // Add response element to the response parameter, as follows:
        response.put('response_x', responseElement);
    } // End of method
} // End of class
