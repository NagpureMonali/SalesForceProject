/************************************************************************
 *  Class for relationship queries which contain
 *  1. Child to parent Quesries
 *  2. Parent To child Queries
 ***************************************************************************/
public with sharing class RelationshipQuery {
    /**
     *  Write a SOQL query on Contact to retrieve all active contacts belonging to 'media' 
     *  Industry. Also display the name of the account to which it is associated to.
     */
    public List<Contact> contactRecords() {
        List<Contact> contactList = [SELECT c.Id,
                                            c.Name, 
                                            c.Account.Name
                                     FROM Contact c 
                                     WHERE c.Account.Industry = 'media' 
                                     AND c.Account.Active__c = 'Yes'
                                    ]; // List of contact
        for(Contact contactInstance : contactList) {
            System.debug(' ------ ' + contactInstance.Id);
            System.debug(' ------ ' + contactInstance.Name);
            System.debug(' ------ ' + contactInstance.Account.Name);
        }
        return contactList;
    } // End of method
     
    /**
     *  Write SOQL query on 'C' object to retrieve all records of 'C' with name 'John' 
     *  along with parent details.
     */
    public List<C__c> objCRecords() {
        //System.debug('>>>>' +listC);
        List<C__c> listC = [SELECT C__c.Id, 
                                   C__c.Name, 
                                   C__c.From_Object_A__r.Name, 
                                   C__c.From_Object_B__r.Name
                            FROM C__c 
                            WHERE C__c.Name  = 'John'
                            ]; // List of C object
        for(C__c cInstance: listC) {
            System.debug(' ------ ' + cInstance.Id);
            System.debug(' ------ ' + cInstance.Name);
            System.debug(' ------ ' + cInstance.From_Object_A__r);
            System.debug(' ------ ' + cInstance.From_Object_B__r);
        } // End of for loop
          return listC;
    } // End of method
      
    /**
     *  Write a SOQL query on Account and find all associated contact records of the Account
     *  which contains the word 'John'. Print all Account and Contact records retrieved above.
     */
    public List<Account> recordOfContact() {
        List<Account> accountList  =  [SELECT a.Name,  a.Id,
                                              (SELECT Name, Id
                                               FROM Contacts  
                                               WHERE Name Like '%john%'
                                               ) 
                                       FROM Account a 
                                       WHERE a.Name Like '%john%' 
                                       ]; // List of contact 
        for(Account accountInstance : accountList) {
            System.debug(accountInstance); // Print
            for(contact contactInstance : accountInstance.contacts) {
                System.debug(contactInstance); // Print
            } // End of inner for loop
        } // End of for loop
        return accountList;
    } // End of method
    
    /**
     *  Write a SOQL query to find all Account records which have at least an opportunity 
     *  record which is 'Closed Won'.
     */ 
    public List<Account> opportinutyChild() {
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
        for(Account accountInstance : accountList) {
            System.debug(accountInstance); // Print
            for(Opportunity OpportunityInstance : accountInstance.Opportunities) {
                System.debug(OpportunityInstance); // Print
            } // End of for loop
        } // End of Outer for loop
        return accountList;
    } // End of method opportinutyChild
    
    /**
     *  Write a SOQL query on 'A' and retrieve all parents with all their child records where
     *  in child name is 'John'.
     */
    public List<A__c> childJohn() {
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
        for(A__C aInstance : aList) {
            System.debug(aInstance); // Print
            for(C__c cInstance : aInstance.C__r) {
                System.debug(cInstance); // Print
            } // End of for loops
        } // End of For loop
        return aList;
    } // End of method childJohn
} // End of class realtionQuery