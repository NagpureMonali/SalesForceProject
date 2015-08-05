/************************************************************************************
 *  It is class for assignement no 10 to perform diff operations of SOQL query
 *************************************************************************************/
public with sharing class Assignment10 {
    /**
     *  Query on all Contact records and add them to the list. Print that contents of this list.
     */
    public List<Contact> contactRecord() {
        List<Contact> listContact = [SELECT Id, 
                                            Name 
                                     FROM Contact 
                                    ]; // List of contacts
        System.debug('>>>>>>' + listContact + '>>>>>>'); // Print the list of contact
        return listContact;
    } // End of method contactRecord
    
    /**
     *  Write a SOQL query to retrieve/print all active Users. 
     *  Prepare a Map having User Id as key and User record as value.(Hint : Map<Id,User>)
     */
    public Map<Id, User> userRecord() {
        // Direct query on map to get user's information
        Map<Id, User> mapUser  =  new Map<Id, User>([SELECT Id, 
                                                            Name, 
                                                            Address, 
                                                            Alias 
                                                     FROM User 
                                                     WHERE IsActive = TRUE
                                                     ]); 
        Set<Id> IdSet  =  mapUser.keySet(); // Set of id's
        for(Id UserIds : IdSet) {
            System.debug('---' + mapUser.get(UserIds)); // Print map
        }
         return mapUser;
        // System.debug('>>>>' + mapUser + '<<<<');
    } // End of method userRecord
    
    /**
     *  Prepare the following map structures :
     *  a. Account Name as key and AccountId as value.
     *  b. Account Id as key and entire Account object as value.
     */
    public Map<Id, Account> accountRecords() { 
        Integer i = 0;
        List<Account> listAccount = [SELECT Id,
                                            Name 
                                     FROM Account
                                    ]; // List of account records
        Map<String, Id> mapAccount = new Map<String, Id>(); // Map of string and id
        for (i = 0; i<listAccount.size(); i++) {
            mapAccount.put(listAccount[i].Name, listAccount[i].Id); // Put values in map
        }
        System.debug('>>>>MAP1>>>>' + mapAccount + '<<<<'); // Print full map
        // Account Id as key and entire Account object as value.
        Map<Id,Account> mapOfAccount = new Map<Id,Account>(); // Map
        for (Account accountInstance : listAccount ) {
            mapOfAccount.put(accountInstance.Id, accountInstance); // Put valus in mapOfAccount
        }  
        System.debug('>>>>MAP2>>>' + mapOfAccount + '<<<<'); // Print map mapOfAccount
        return mapOfAccount;
    } // End of method accountRecords
    
    /**
     *  Create a multi-select picklist on Account object called as 'Enrollment Year' 
     *  with values - 2010, 2011, 2012, 2013, 2014, 2015 and 2016. Get all account records
     *  where in selected 'Enrollment Year' is:
     *  a. 2010
     *  b. 2013 and 2014
     */
    public List<Account> accountRecordsPicklist() {
        List<Account> listAccount = [SELECT Id,
                                            Name,
                                            Enrollment_Year__c 
                                     FROM Account 
                                     WHERE Enrollment_Year__c = '2010'
                                    ]; // List of account for Enrollment_Year__c = '2010'
         // Print result
        System.debug('account records selected \'Enrollment Year\' is:2010' + listAccount + '<<<<'); 
        // Get all account records where in selected 'Enrollment Year' is: 2013 and 2014
        List<Account> listOfAccount = [SELECT Id,
                                              Name,
                                              Enrollment_Year__c 
                                       FROM Account 
                                       WHERE Enrollment_Year__c = '2013;2014'
                                      ]; // List of account for Enrollment_Year__c = '2013;2014'
        System.debug('account records selected Enrollment Year is:2013 and 2014' + listOfAccount); 
        return listOfAccount;
    } // End of accountRecordsPicklist
    
    /**
     *  Write a SOQL query to find all Account records where 'Billing State' is not 'Maharashtra' 
     *  and 'Kerala'. Order the results by Billing State in descending order with null values at 
     *  the end. Display first 10,000 records only. NOTE: do not use AND operator.
     */
    public List<Account> accountRecordsBillingState() {
        List<Account> listAccount = [SELECT Id,
                                            Name,
                                            Billing_State__c 
                                     FROM Account 
                                     WHERE Billing_State__c 
                                     NOT IN ('Maharashtra','Kerala') 
                                     ORDER BY Billing_State__c DESC 
                                     NULLS LAST 
                                     LIMIT 10000 
                                     ]; // List of account
        System.debug('account records:' + listAccount + '<<<<'); // Print list of account
        return listAccount;
    } // End of accountRecordsBillingState
    
    /**
     *  Write a SOQL query to display 100 opportunity records with amount greater than 10,000 
     *  order by created date. Skip first 50 records and include records from recycle bin. 
     */
    public List<Opportunity> opportunityRecords() {
        List<Opportunity> listOpportunity = [SELECT Id,
                                                    Name 
                                             FROM Opportunity 
                                             WHERE Amount > 10000 
                                             ORDER BY  CreatedDate 
                                             LIMIT 100 
                                             OFFSET 50 ALL ROWS
                                             ]; // List of opportunity
        System.debug('Opportunity records Using List' + listOpportunity); // Print result
        return listOpportunity;
    } // End of opportunityRecords
} // End of class Assignment10