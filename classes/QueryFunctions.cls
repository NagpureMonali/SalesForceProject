/************************************************************************************
*  QueryFunctions class is to show Advanced concepts / Collections/
*  SOQL Queries/DML Operations 
*************************************************************************************/
public with sharing class QueryFunctions {
    /**
     *  Query on Account object /records and if the account is person 
     *  account print the ID of that record. 
     *  (Hint : You have to enable person account ) 
     *  a. Print the result using traditional for loop
     *  b. Print the result using advanced for loop
     */
    public List<Account> accountRecords() {
        List<Account> listAccount =  [SELECT Id 
                                      FROM Account 
                                      WHERE Type = 'Person Account'
                                     ]; // List of account
        for(Account accountInstance: listAccount) {
            // Print using advanced for loop
            System.debug('Advanced For Loop : ' +accountInstance);  
        } 
        for(integer i = 0;i<listAccount.size();i++) {
            // Print using traditional for loop
            System.debug('Traditional For loop : '+listAccount[i]); 
        }
        return listAccount;
     } // End of Method
     
     /**
      *  Query on all Opportunity records where its Account ! =  NULL and Status  =  Closed
      *  a. Add all Opportunity Id’s to the List and print the result
      *  b. Add all Account Id’s to the set and print the result
      *  c. Prepare the Map having Key as OpportunityId and Value as AccountId
      */
    public Map<ID,ID> oportunityRecords() {
        List<Opportunity> listOpportunity =  [SELECT Id,
                                                     AccountID
                                              FROM Opportunity 
                                              WHERE AccountID!= NULL 
                                              AND StageName like 'Closed%'
                                            ]; // List of opportunity
       System.debug('List of opporttunity'); // Print       									  
       for(Opportunity opportunityInstance:listOpportunity) {
       		System.debug(' '+opportunityInstance); // Print
       }
       Set<Opportunity> setOpportunity  =  new Set<Opportunity>([SELECT Id,
                                                                        AccountID
                                                                 FROM Opportunity 
                                                                 WHERE AccountID!= NULL 
                                                                 AND StageName like 'Closed%'
                                                                ]); // Set of opportunity
       System.debug('set of opportunity'); // Print       									  
       for(Opportunity oppo:setOpportunity) {
            System.debug(' '+oppo); // Print
       }
       Map<ID,ID> opportunityMap =  new Map<ID,ID>(); // Map of opportunity
       for(Integer i = 0;i<listOpportunity.size();i++) {
            opportunityMap.put(listOpportunity[i].ID,listOpportunity[i].AccountID); // Put value in map
       }
       System.debug('Map: '+opportunityMap); // Print
       return opportunityMap;  								   
   } // End of method oportunityRecords
   
   /**
    *  Find all the Account Names starting with ‘a’. 
    *  Print that count and update all those accounts with New Name as 
    *  ‘Updated via update DML operation’.
    */
   public List<Account> accountRecordsStartedWithA() {
        List<Account> listAccount  =  [SELECT Name
                                       FROM Account
                                       WHERE Name like 'a%'
                                      ]; // List of account
        System.debug(' Total account names starting with \'a\' is : '+ listAccount.size()); // Print
        for(Account accountInstance: listAccount) {
            accountInstance.Name  =  'Updated via update DML operation';
        }
        update listAccount; // Dml Operation update
        return listAccount;
    } // End of method
    
    /**
     *  Prepare the Map structure to show the Account (As key) and Its opportunities as
     *  List(Value) Hint : Query on Account and get the child opportunities or Query on 
     *  Opportunities and get the parent Account Id 
     *  Hint : Your map structure will be : Map<Id,List<Id>>
     */
    public Map<Id, List<Opportunity>> accountOpportunityMap() {
        List<Account> listAccount  =  [SELECT a.Name, 
                                              a.Id,
                                             (SELECT Id, 
                                                     Name 
                                              FROM Opportunities
                                              WHERE AccountID!= NULL
                                              ) 
                                       FROM Account a
                                       ]; // List of account
        Map<Id, List<Opportunity>> mapAccount =  new Map<Id, List<Opportunity>>(); // Map
        for(Account accountInstatnce : listAccount) {
            mapAccount.put(accountInstatnce.Id, accountInstatnce.Opportunities); // Put values in map
        }
        for(ID i : mapAccount.keySet()) {  
            System.debug(' =  =  = '+mapAccount); // Print map
        }
        return mapAccount;
    } // End of method accountOpportunityMap
    
    /**
     *  Write a SOQL Query on to retrieve/print 10 Campaign records and sort in ascending
     *  as well as descending order.
     */
    public List<Campaign> campaignRecords() {
        List<Campaign> listCampaign = new List<Campaign>([SELECT id,
                                                                 name 
                                                          FROM campaign 
                                                          ORDER BY name 
                                                          LIMIT 10
                                                         ]); // List of campaign records
        System.debug('Ascending order :'+listCampaign); // Print
        List<Campaign> listCampaigns = new List<Campaign>([SELECT id,
                                                                  name
                                                           FROM campaign 
                                                           ORDER BY name 
                                                           DESC LIMIT 10
                                                          ]); // List of campaign
        System.debug('Descending order :'+listCampaigns); // Print
        return listCampaigns;
    }  // End of method campaignRecords
    
    /**
     *  Write a SOQL query to retrieve/print the Contact records where 
     *  Last Modified Date  =  Today
     */
    public List<Contact> contactRecord() {
        List<Contact> contactList  = [SELECT c.Name, 
                                             c.Id 
                                      FROM Contact c 
                                      WHERE c.LastCUUpdateDate = today
                                     ]; // List of contact
       System.debug(' List of contacts : ' + contactList);
       return  contactList;
    } // End of method contactRecord
} // End of class QueryFunctions