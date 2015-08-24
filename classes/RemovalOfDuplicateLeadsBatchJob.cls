/*************************************************************************************************
 *  Removal of duplicate Leads 
 *  1. During the Campaigning, It might happen that representative creates duplicate leads 
 *     in an org. 
 *  2. So admin want to build a process which will run every 3 hours/day &  remove the 
 *     duplicate leads from the org. 
 *  3. The criteria to find the duplicate records should be configurable. 
*************************************************************************************************/
public with sharing class RemovalOfDuplicateLeadsBatchJob implements Database.Batchable <sObject>{
    Map<String, Lead> mapUniqueToLead = new Map<String, Lead>();
    List<Lead> leadList = new List<Lead>(); 
    String criteria; 
    String query='SELECT Id, Name, Email FROM Lead WHERE Name <> NULL AND Email <> NULL';
    public RemovalOfDuplicateLeadsBatchJob() {
        for (LeadName__c LeadNameInstance : LeadName__c.getAll().values()) {
            criteria = LeadNameInstance.Criteria__c;
        }
        System.debug('<<<<<<<----On page load criteria is :--->>>>>>>>>' + criteria);
    }
    RemovalOfDuplicateRecordsController obj = new RemovalOfDuplicateRecordsController();
    /**  
     *  This is the method which will define scope for the batch processing.
     *  here it will return a records of Lead object whose email is not null.
     */ 
    public Database.QueryLocator start(Database.BatchableContext batchCon) {
        //obj.objectField();
        System.debug('<<<<<<<----RemovalOfDuplicateRecordsController.criteria--->>>>>>>>>' + criteria);
        if (criteria == 'Email') {
            query = 'SELECT Id, Name, Email FROM Lead WHERE Name <> NULL AND Email <> NULL';
        } else if (criteria == 'Phone') {
            query = 'SELECT Id, Name, Phone FROM Lead WHERE Name <> NULL AND Phone <> NULL';
        } else if (criteria == 'MobilePhone') {
            query = 'SELECT Id, Name, MobilePhone FROM Lead WHERE Name <> NULL AND MobilePhone <> NULL';
        }                                 
        return Database.getQueryLocator(query);
       /* return Database.getQueryLocator([SELECT Id, 
                                                Name, 
                                                Email,
                                                Name__c
                                         FROM Lead 
                                         WHERE Email <> NULL
                                         AND Name <> NULL
                                        ]);*/
    } // End of method
    
    /**
     *  This is the method which will execute batch.
     *  here it will check if lead is already present in org then remove it .
     */
    public void execute(Database.BatchableContext batchCon, List<Lead> queryLeadList) {
        if (criteria == 'Email') {
            for (Lead leadInstance : queryLeadList) {
                if (mapUniqueToLead.containsKey(leadInstance.Email)) {
                    leadList.add(leadInstance);
                } else {
                    mapUniqueToLead.put(leadInstance.Email, leadInstance);
                } // End of else
            } // End of for loop  
            System.debug('----Map for email as key---' + mapUniqueToLead);
            System.debug('---List lead contain in map----' + leadList);
            delete leadList; // Delete list of duplicate records
        } else if (criteria == 'Phone') {
            for (Lead leadInstance : queryLeadList) {
                if (mapUniqueToLead.containsKey(leadInstance.Phone)) {
                    leadList.add(leadInstance);
                } else {
                    mapUniqueToLead.put(leadInstance.Phone, leadInstance);
                } // End of else
            } // End of for loop  
            System.debug('----Map---' + mapUniqueToLead);
            System.debug('---List lead contain in map----' + leadList);
            delete leadList; // Delete list of duplicate records
        } else if (criteria == 'MobilePhone') {
            for (Lead leadInstance : queryLeadList) {
                if (mapUniqueToLead.containsKey(leadInstance.MobilePhone)) {
                    leadList.add(leadInstance);
                } else {
                    mapUniqueToLead.put(leadInstance.MobilePhone, leadInstance);
                } // End of else
            } // End of for loop    
            System.debug('----Map---' + mapUniqueToLead);
            System.debug('---List lead contain in map----' + leadList);
            delete leadList; // Delete list of duplicate records
        } // End of else 
    } // End of method 
    
    /**
     *  This is the method which will finish batch job.
     */
    public void finish(Database.BatchableContext batchCon) {
      
    } // End of method
} // End of class