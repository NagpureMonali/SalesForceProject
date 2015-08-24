/**************************************************************************************************
 *  This is Apex REST Service that will help external systems to manipulate Leads within Salesforce
 *  The REST Service should provide the following capabilities
 *  1. Insert Lead
 *  2. Delete Lead
 *  3. Update Lead
 *  Depending on operations it will send a reponse 
***************************************************************************************************/
@RestResource(urlMapping='/Lead/*') // Annotation  
global class RESTLead { 
    /**
     *  Service method to create a new Lead in Salesforce on basis of First Name, Last Name, Email 
     *  and Phone values. This service should return a response specifying the following :
     *  1. isSuccess : True only if Lead creation is successful
     *  2. lead : Record Id of the newly created Lead Blank in case of lead creation failure
     *  3. status : “Success” if lead creation is successful. Should return an error message in 
     *     case of failure
     */
    @HttpPost  // Annotation
    global static ResponseHandler createNewLead(String firstName, String lastName, String email, 
                                                String phone, String company, String status
                                               ) {
        ResponseHandler response = new ResponseHandler();
        try {
            Lead leadInstance = new Lead();
            leadInstance.FirstName = firstName;
            leadInstance.LastName = lastName;
            leadInstance.Email = email;
            leadInstance.Phone = phone;
            leadInstance.Company = company;
            leadInstance.Status = status;
            insert leadInstance;
            response.id = leadInstance.id;
            response.isSuccess = true;
            response.status = 'Success';
        } catch (Exception e) {
            response.id = '';
            response.isSuccess = false;
            response.status = e.getMessage();
        } // End of catch block
        return response;
    } // End of method
    
    /**
     *  Delete the Lead record in Salesforce basis the FirstName, LastName, Email and Phone exact 
     *  match combination. The above attributes will be posted to the REST Service as input params 
     *  and the service should return a response specifying the following:
     *  1. isSuccess : True only if Lead creation is successful
     *  2. lead : Full Name of the deleted Lead. Blank in case of lead deletion failure
     *  3. status : “Success” if lead creation is successful. Should return an error message in 
     *     case of failure
     */
    @HttpDelete // Annotation 
    global static ResponseHandler deleteLead() {
    	RestContext.request = new RestRequest();
        String firstName = RestContext.request.params.get('firstName');
        String lastName = RestContext.request.params.get('lastName');
        String email = RestContext.request.params.get('email');
        String phone = RestContext.request.params.get('phone');
        ResponseHandler response = new ResponseHandler();
        try {
            Lead leadInstance= [SELECT Id, 
                                       FirstName, 
                                       LastName,
                                       Name, 
                                       Email, 
                                       Phone 
                                FROM Lead 
                                WHERE FirstName = :firstName
                                AND LastName = :lastName
                                AND Email = :email
                                AND Phone = :phone
                                ];
            response.id = leadInstance.Name;
            response.isSuccess = true;
            response.status = 'Success';
            delete leadInstance;
        } catch (Exception e) {
            response.id = '';
            response.isSuccess = false;
            response.status = e.getMessage();
        } // End of catch block
        return response;
    } // End of method
    
    /**
     *  Update the Email and Phone fields of Lead record in Salesforce basis the First Name and Last
     *  Name exact match combination. The following attributes will be posted to the REST Service –
     *  First Name, Last Name, New Email and New Phone. The service should return a response 
     *  specifying the following:
     *  1. isSuccess : True only if Lead creation is successful
     *  2. lead : Record Id of the newly created Lead Blank in case of lead creation failure
     *  3. status : “Success” if lead creation is successful. Should return an error message in 
     *     case of failure
     */
    @HttpPatch // Annotation
    global static ResponseHandler updateLead(String firstName, String lastName, 
                                             String email, String phone
                                            ) {
        ResponseHandler response = new ResponseHandler();
        try {
            Lead leadInstance = [SELECT Id, 
                                        FirstName, 
                                        LastName, 
                                        Email, 
                                        Phone 
                                 FROM Lead 
                                 WHERE FirstName = :firstName
                                 AND LastName = :lastName
                                ];
            leadInstance.Email = email;
            leadInstance.Phone = phone;
            update leadInstance;
            response.id = leadInstance.id;
            response.isSuccess = true;
            response.status = 'Success';
        } catch(Exception e) {
            response.id = '';
            response.isSuccess = false;
            response.status = e.getMessage();
        } // End of catch block
        return response;
    } // End of method
    
    /**
     *  This is the global class which holds responce for every method
     */
    global class ResponseHandler {
        public String status;
        public String id;
        public Boolean isSuccess;
    } // End of wrapper class
} // End of class