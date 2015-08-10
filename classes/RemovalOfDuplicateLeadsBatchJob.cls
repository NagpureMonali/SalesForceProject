/**
 *  Class for Removal of duplicate Leads 
 *  1. During the Campaigning, It might happen that representative creates duplicate 
 *  leads in an org.
 *  2. So admin want to build a process which will run every 3 hours/day &  remove the duplicate 
 *  leads from the org. 
 *  3. The criteria to find the duplicate records should be configurable. 
 */
public with sharing class RemovalOfDuplicateLeadsBatchJob implements Database.Batchable <sObject>{
  map<String, Lead> mapUniqueNameToLead = new map<String, Lead>();
  List<Lead> leadList = new List<Lead>();
  public Database.QueryLocator start(Database.BatchableContext batchCon) {
      return Database.getQueryLocator([SELECT Id, 
                                              Name, 
                                              Email,
                                              Name__c
                                       FROM Lead 
                                       WHERE Email <> NULL
                                       ]);
    }
    public void execute(Database.BatchableContext batchCon, List<Lead> queryLeadList) {
      for(Lead leadInstance : queryLeadList) {
          if(!mapUniqueNameToLead.containsKey(leadInstance.Email)) {
          leadList.add(leadInstance);
          System.debug('---List----' + leadList);
          }
          else {
            mapUniqueNameToLead.put(leadInstance.Name__c, leadInstance);
            System.debug('----Map---' + mapUniqueNameToLead);
          }
      }  
      delete leadList;
    }
    
    public void finish(Database.BatchableContext batchCon) {
      Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
      List<String> sendTo = new List<String>();
            sendTo.add('monali.nagpure@eternussolutions.com');
            mail.setToAddresses(sendTo);
            mail.setSenderDisplayName('SalesForce.com');
            mail.setSubject('RemovalOfDuplicateLeadsBatchJob run succesfully');
            String body = 'Dear ';
            body += '\n RemovalOfDuplicateLeadsBatchJob run succesfully';
            mail.setHtmlBody(body);
            System.debug('------Body of mail------ ' + body);
           // mailList.add(mail); 
           // Messaging.sendEmail(new Messaging.SingleEmailMessage()); 
           Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});
    }
}