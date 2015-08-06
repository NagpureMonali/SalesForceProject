/*****************************************************************************************
 *  class for Trigger to Updating Cases that come in from the Web, Email or Chat
 *  Use Case – we would like to use the email address of the incoming case to see if we can 
 *  associate the correct person account to populate the Account. When a new case is created 
 *  and the Case.Origin field is set to “Chat” or “Email” or “Web” take 
 *  the Case.SuppliedEmail field and look up to find a match in the following account fields 
 *  Account.PersonEmail, Account.Email_Address__c
 ****************************************************************************************/
trigger UpdateCase on Case (before insert) {
    if(trigger.isbefore && trigger.isinsert) {
        UpdateCaseHandler.caseToUpdate(trigger.new); // Call method
    } // End of if
} // End of trigger