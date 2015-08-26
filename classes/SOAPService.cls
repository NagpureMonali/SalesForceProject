/**************************************************************************************************
 *  Here is class to call webserive from another org using SOAP Callouts.
 **************************************************************************************************/
public with sharing class SOAPService {
    public partnerSoapSforceCom.LoginResult loginDetails;
    /**
     *  Here is method which calls login method to use webservice method 
     */    
    public void getLoginDetails() {   
        String username = 'monali.nagpure@eternussolutions.com';
        String password = 'test123@';
        partnerSoapSforceCom.Soap soapInstance = new partnerSoapSforceCom.Soap();
        loginDetails = soapInstance.login(username,password); 
        // Call login method to get access to org
        System.debug('---------Session URL:------------ ' + loginDetails.serverUrl);
        System.debug('---------Session ID:------------- ' + loginDetails.sessionId); 
        // Print login details
        
        // Create insnatnce of webservice 
        soapSforceComSchemasClassSoapleadwe.SOAPLeadWebservice leadInstance = 
            new soapSforceComSchemasClassSoapleadwe.SOAPLeadWebservice();
            
        // Call Session method to get Session Id
        leadInstance.SessionHeader = 
            new soapSforceComSchemasClassSoapleadwe.SessionHeader_element(); 
        leadInstance.SessionHeader.sessionId = loginDetails.sessionId;     
        
        // Call create Lead method to insert new Lead
        soapSforceComSchemasClassSoapleadwe.ResponseHandler leadCreationMessage = 
            leadInstance.createNewLead('TestSoap', 'TestWebservice', 'TestSoap@webservice.com', 
                                       '1234567890', 'SOAP', 'Closed Won'
                                       );
        System.debug('---------New Lead Insert Message------------ ' + leadCreationMessage );
        
        // Call create Lead method to update Lead
        soapSforceComSchemasClassSoapleadwe.ResponseHandler leadUpdationMessage = 
            leadInstance.updateLead('TestSoap', 'TestWebservice', 
                                    'soap@webservice.com', '1234567890'
                                    );    
        System.debug('---------Update Lead Message------------ ' + leadCreationMessage ); 
        
        // Call create Lead method to delete Lead
        soapSforceComSchemasClassSoapleadwe.ResponseHandler leadDeleteMessage = 
            leadInstance.deleteLead('TestSoap', 'TestWebservice', 
                                    'soap@webservice.com', '1234567890'
                                    );    
        System.debug('---------Delete Lead Message------------ ' + leadDeleteMessage ); 
    } // End of method
} // End of class 