/************************************************************************
*  Class for relationship queries which contain
*  1. Child to parent Quesries
*  2. Parent To child Queries
***************************************************************************/
public with sharing class RelationshipQuery  
{
    /**
     *  Write a SOQL query on Contact to retrieve all active contacts belonging to 'media' 
     *  Industry. Also display the name of the account to which it is associated to.
     */
    public List<Contact> ContactRecords() {
        for(Contact contactInstance:[SELECT c.Id,
                                            c.Name, 
                                            c.Account.Name
                                     FROM Contact c 
                                     WHERE c.Account.Industry  =  'media' 
                                     AND c.Account.Active__c = 'Yes'
                                     ]) {
        System.debug(' ------ '+contactInstance.ID);
        System.debug(' ------ '+contactInstance.Name);
        System.debug(' ------ ' + contactInstance.Account.Name);
                }
        List<Contact> contactInstance = [SELECT c.Id,
                                                c.Name, 
                                                c.Account.Name
                                         FROM Contact c 
                                         WHERE c.Account.Industry  =  'media' 
                                         AND c.Account.Active__c = 'Yes'
                                         ]; // List of contact
        return contactInstance;
     } // End of method
     
     /**
      *  Write SOQL query on 'C'(created above) to retrieve all records of 'C' with name 'John' 
      *  along with parent details.
      */
     public List<C__c> ObjCRecords() {
        //System.debug('>>>>' +listC);
        List<C__c> listC =  [SELECT C__c.Id, 
                                    C__c.Name, 
                                    C__c.From_Object_A__r.Name, 
                                    C__c.From_Object_B__r.Name
                             FROM C__c 
                             WHERE C__c.Name  = 'John'
                             ]; // List of C object
         for(C__c cInstance: listC) {
             System.debug(' ------ '+cInstance.Id);
             System.debug(' ------ '+cInstance.Name);
             System.debug(' ------ '+cInstance.From_Object_A__r);
             System.debug(' ------ '+cInstance.From_Object_B__r);
         }
          return listC;
      } // End of method
      
      /**
       *  Write a SOQL query on Account and find all associated contact records of the Account
       *  which contains the word 'John'. Print all Account and Contact records retrieved above.
       */
      public list<Account> RecordOfContact() {
            List<Account> accountList  =  [SELECT a.Name,
                                                  a.Id,
                                                  (SELECT Name 
                                                   FROM Contacts 
                                                   WHERE Name Like '%John%') 
                                           FROM Account a 
                                           WHERE a.Id 
                                           IN (SELECT AccountId
                                           FROM Contact
                                           WHERE Name Like '%john%')
                                          ]; // List of contact 
            for(Account accountInstance:accountList) {
                System.debug(accountInstance); // Print
                for(contact contactInstance: accountInstance.contacts) {
                    System.debug(contactInstance); // Print
                } // End of inner for loop
            } // End of for loop
            return accountList;
         } // End of method
         /**
        *  Write a SOQL query to find all Account records which have at least an opportunity 
        *  record which is 'Closed Won'.
        */ 
    public list<Account> OpportinutyChild() {
        List<Account> accountList  =  [SELECT a.Name, 
                                              a.Id, 
                                              (SELECT Id, 
                                                      StageName 
                                               FROM Opportunities) 
                                       FROM Account a 
                                       WHERE  a.id 
                                       IN (SELECT AccountId  
                                           FROM Opportunity   
                                           WHERE StageName Like 'Closed Won')
                                       ]; // List of account
        for(Account accountInstance:accountList) {
            System.debug(accountInstance); // Print
            for(Opportunity OpportunityInstance: accountInstance.Opportunities) {
                System.debug(OpportunityInstance); // Print
            } // End of for loop
        } // End of Outer for loop
        return accountList;
    } // End of method opportinutyChild
    
    /**
     *  Write a SOQL query on 'A' and retrieve all parents with all their child records where
     *  in child name is 'John'.
     */
    public list<A__c> ChildJohn() {
        List<A__c> aList  =  [ SELECT a.Name, 
                                      a.Id,
                                      (SELECT Id, 
                                              Name 
                                       FROM C__r) 
                               FROM A__c a 
                               WHERE  a.id 
                               IN (SELECT From_Object_A__c 
                                   FROM C__c   
                                   WHERE Name  = 'John')
                              ]; // List of account
        for(A__C aInstance:aList) {
            System.debug(aInstance); // Print
            for(C__c cInstance: aInstance.C__r) {
                System.debug(cInstance); // Print
            } // End of for loops
        } // End of For loop
        return aList;						  
    } // End of method childJohn
} // End of class realtionQuery