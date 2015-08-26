/**************************************************************************************************
 *  Here is the test class which validates apex class performing certain operation correctly 
 *  The operations are Insertion of Lead, Updation of Lead and Deletion of Lead
 **************************************************************************************************/
@isTest // Annotation
public class TestSOAPService { 
    /**
     *  Here is test method to test lead creation
     */
    public static testMethod void MockTestSoapCreateLead() {
        // Call the mock test class for lead creation
        Test.setMock(WebServiceMock.class, new SOAPWebServiceMockForInsert());
         
        // Create an instance for the class
        soapSforceComSchemasClassSoapleadwe.SOAPLeadWebservice soapServiceInstance = 
            new soapSforceComSchemasClassSoapleadwe.SOAPLeadWebservice  ();
        
        // Call method to insert lead
        soapSforceComSchemasClassSoapleadwe.ResponseHandler resultForInsert =
            soapServiceInstance.createNewLead('Testname','Testname','Test@email.com',
                                              '7653490987','TEST','Closed Won'
            );
        
        System.assertEquals('Mock response', resultForInsert.status);
    } // End of method
    
    /**
     *  Here is test method to test lead updation
     */
    public static testMethod void MockTestSoapUpdateLead() {
        // Call the mock test class for lead updation
       Test.setMock(WebServiceMock.class, new SOAPWebServiceMockForUpdate());
       
       soapSforceComSchemasClassSoapleadwe.SOAPLeadWebservice soapServiceInstance = 
           new soapSforceComSchemasClassSoapleadwe.SOAPLeadWebservice  ();
        
        // Call method to update lead
        soapSforceComSchemasClassSoapleadwe.ResponseHandler resultForUpdate =
            soapServiceInstance.updateLead('Testname','Testname','Testing@email.com','7653490987');
       
        // Assert for the result
        System.assertEquals('Mock response', resultForUpdate.status);
    } // End of method 
        
    /**
     *  Here is test method to test lead updation
     */
    public static testMethod void MockTestSoapDeleteLead() {
        // Call the mock test class for lead deletion
        Test.setMock(WebServiceMock.class, new SOAPWebServiceMockForDelete());
        
        soapSforceComSchemasClassSoapleadwe.SOAPLeadWebservice soapServiceInstance = 
            new soapSforceComSchemasClassSoapleadwe.SOAPLeadWebservice  ();
            
        // Call method to update lead
        soapSforceComSchemasClassSoapleadwe.ResponseHandler resultForDelete =
            soapServiceInstance.deleteLead('Testname','Testname','Testing@email.com','7653490987');
        
        // Assert for the result
        System.assertEquals('Mock response', resultForDelete.status);
    } // End of method
} // End of test class