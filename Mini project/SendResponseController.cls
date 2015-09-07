/***************************************************************************************************
 *  This is the controller class for EmailResponce component to display details of response object 
 **************************************************************************************************/
public class SendResponseController {
    public String queryId {get;set;} // To get query id 
    /**
     *  Method to get responses to send 
     */
    public List<Query_Response__c> getResponsesToSend() {
        return [Select q.Title__c, 
                       q.Link__c, 
                       q.Description__c 
                From Query_Response__c q 
                WHERE Query__c = :queryId
        ]; // Return query result
   } // End of method
} // End of class