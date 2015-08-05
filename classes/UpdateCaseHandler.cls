/******************************************************************************************
 *  class for TriggerHandler to Updating Cases that come in from the Web, Email or Chat
 *  Use Case – we would like to use the email address of the incoming case to see if we can 
 *  associate the correct person account to populate the Account. When a new case is created 
 *   and the Case.Origin field is set to “Chat” or “Email” or “Web” take 
 *  the Case.SuppliedEmail field and look up to find a match in the following account fields 
 *  Account.PersonEmail, Account.Email_Address__c
 ******************************************************************************************/
public with sharing class UpdateCaseHandler {
    /**
     *  Method to Update Cases that come in from the Web, Email or Chat
     *  Use Case – we would like to use the email address of the incoming case to see if we can 
     *  associate the correct person account to populate the Account 
     */
    public static List<Case> caseToUpdate(List<Case> listCase) {
        Set<Id> idCase = new Set<Id>();
        Set<String> supliedEmailCase = new Set<String>();
        for (Case caseInstance : listCase) {
            idCase.add(caseInstance.Id);
            supliedEmailCase.add(caseInstance.SuppliedEmail__c);
        }
        List<Account> accountList = [Select a.PersonEmail__c, 
                                            a.Id, 
                                            a.Email_Address__c
                                     From Account a 
                                     WHERE a.PersonEmail__c = :supliedEmailCase
                                     OR a.Email_Address__c = :supliedEmailCase
                                    ];
        for(Case caseInstance : listCase) {
            if(caseInstance.Origin =='Phone' ||
               caseInstance.Origin =='Email' || 
               caseInstance.Origin =='Web' 
               ) {
                 for(Account accountInstance : accountList) {
                     caseInstance.AccountId = accountInstance.Id;
                     System.debug('---- this is trigger' + trigger.new);
                 } // End of for loop
            } // End of if 
        } // End of for loop
        return listCase;
     } // End of method
} // End of class