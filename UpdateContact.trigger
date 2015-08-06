/*************************************************************************************************
 *  ABC Containers require the ability to automatically associate a Contact created in their 
 *  Salesforce Instance with the respective Account based on the email domain specified in the 
 *  primary email address of the Contact. The association should happen real time as soon as a 
 *  Contact record is created within the system. Here is trigger for same
 *************************************************************************************************/
trigger UpdateContact on Contact (before insert) {
    if(trigger.isbefore && trigger.isinsert) {
        System.debug('------trigger fired----');
        UpdateContactHandler.contactToUpdate(trigger.new);
    } // End of if
} // End of class