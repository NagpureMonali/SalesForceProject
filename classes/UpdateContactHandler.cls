/*************************************************************************************************
 *  This is handler class for updateContact Trigger
 *  It has ability to automatically associate a Contact created in their 
 *  Salesforce Instance with the respective Account based on the email domain specified in the 
 *  primary email address of the Contact. The association should happen real time as soon as a 
 *  Contact record is created within the System. Here is class for same 
 **************************************************************************************************/
public with sharing class UpdateContactHandler {
    /*************************************************************************************************
     *  ABC Containers require the ability to automatically associate a Contact created in their 
     *  Salesforce Instance with the respective Account based on the email domain specified in the 
     *  primary email address of the Contact. The association should happen real time as soon as a 
     *  Contact record is created within the System. Here is metjod for same
     *************************************************************************************************/
    public static void  contactToUpdate(List<Contact> contactList) {
        String accountDomain,contactDomain;
        List<Account> accountList = [SELECT Id, 
                                            Website 
                                     FROM Account 
                                     WHERE Website 
                                     LIKE 'www.%'
                                     ]; // Get account list having website
        Map<String,Id> accountMap = new Map<String,Id>(); // Map for website name and account ID
        System.debug('---account list--' + accountList);
        for(Account accountInstance : accountList ) {
            accountDomain = accountInstance.Website.substringAfter('www.'); // Get domain
            System.debug('-------account domain---' + accountDomain);
            accountMap.put(accountDomain,accountInstance.Id); // Store domain and ID into map
            System.debug('---acount map--' + accountMap);
        } // End of for loop
       for(Contact contactInstance : contactList ) {
           if(contactInstance.AccountId == null && contactInstance.Email != null) {
               // Take mail domain from contact email
               contactDomain = contactInstance.Email.substringAfter('@'); 
               System.debug('---conntact domain---' + contactDomain);
               if(accountMap.containsKey(contactDomain)) {
                   for(string contactHasDomain : accountMap.Keyset()) {
                       if(contactHasDomain.equalsIgnoreCase(contactDomain)) {
                           System.debug('---trimed domain---' + contactHasDomain);
                           // Get id of account and store in contact object as accoint
                           contactInstance.AccountId = accountMap.get(contactDomain); 
                           System.debug('-----' + contactInstance.AccountId);
                       } // End of innner if
                   } //End of for
               } // End of outer if
           } // End of outermost if
       } // End of for
    } // End of method contactToUpdate
} // End of handler class