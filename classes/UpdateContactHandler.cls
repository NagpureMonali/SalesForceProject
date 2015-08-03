/*************************************************************************************************
*  This is handler class for updateContact Trigger
*  It has ability to automatically associate a Contact created in their 
*  Salesforce Instance with the respective Account based on the email domain specified in the 
*  primary email address of the Contact. The association should happen real time as soon as a 
*  Contact record is created within the system. Here is trigger for same 
**************************************************************************************************/
public with sharing class UpdateContactHandler // Handler for update contact
{	
	 public static void  contactToUpdate(List<Contact> contactList) // To update contact
     {
        String accountDomain,contactDomain;
        List<Account> accountList = [SELECT Id, 
                                            Website 
                                     FROM Account 
                                     WHERE Website 
                                     LIKE 'www.%'
                                     ]; // Get account list having website
        map<String,Id> accountMap = new map<String,Id>(); // Map for website name and account ID
        system.debug('---account list--'+accountList);
        for(Account accountInstance : accountList ) // To get account domain exactly after www.---
        {
          accountDomain = accountInstance.Website.substringAfter('www.'); // Get domain
          system.debug('-------account domain---'+accountDomain);
          accountMap.put(accountDomain,accountInstance.Id); // Store domain and ID into map
          system.debug('---acount map--'+accountMap);
        } // End of for loop
 
       for(Contact contactInstance : contactList ) // To check with contact email
       {
           if(contactInstance.AccountId == null && contactInstance.Email != null) // If email not numm and account is null
           {
              contactDomain = contactInstance.Email.substringAfter('@'); // Take mail domain from contact email
              system.debug('---conntact domain---'+contactDomain);
              if(accountMap.containsKey(contactDomain)) // Now check in map if domain present 
              {
                 for(string contactHasDomain : accountMap.Keyset()) // Iterate over map
                 {
                    if(contactHasDomain.equalsIgnoreCase(contactDomain)) // If domain present
                    {
                        system.debug('---trimed domain---'+contactHasDomain);
                        contactInstance.AccountId = accountMap.get(contactDomain); // Get id of account and store in contact object as accoint
                        system.debug('-----'+contactInstance.AccountId);
                     } // End of innner if
                  } //End of for
               } // End of outer if
            } // End of outermost if
         } // End of for
    } // End of method contactToUpdate
} // End of handler class