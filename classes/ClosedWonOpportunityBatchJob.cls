/**************************************************************************************************
 *  Collection of Closed Won Opportunities 
 *  1. The Primary contact associated with an account needs to know which all are the closed won 
 *     opportunities for his account per day. 
 *  2. Create a process which will run everyday in the midnight & collect all the Closed won 
 *     opportunities of that account in a day & send an email to Primary Contact. 
 *  3. The email body should contain the Opportunity Name & it's respective amount with the 
 *     aggregated amount in the end. 
 **************************************************************************************************/
public with sharing class ClosedWonOpportunityBatchJob  implements Database.Batchable<sObject>,
                                                                   Database.Stateful {
    // Map of email adress and whole opportunity instance declartion
    Map<String,WrapperScheduleClosedWonOpportunity> mapOpportunity = 
                                            new Map<String,WrapperScheduleClosedWonOpportunity>();
    /**
     *  This is the method which will define scope for the batch processing.
     *  here it will return a query of opportunities whose stage is closed won.
     */
    public Database.QueryLocator start(Database.BatchableContext objBatchableContext) {
        return Database.getQueryLocator([SELECT Id, 
                                                Name, 
                                                Amount,
                                                AccountId,
                                                Account.Email_Address__c
                                         FROM Opportunity Instance 
                                         WHERE StageName = 'Closed Won'
                                         AND AccountId <> null
                                         ]); // List of all opportunities having stage closed won 
    } // End of method
    
    /**
     *  This is the method which will execute batch.
     *  here it will store all the values of opportunity into map
     */
    public void execute(Database.BatchableContext objBatchableContext, 
                        List<Opportunity> listOpportunity 
                        ) {
        for (Opportunity instanceOpportinity : listOpportunity) {
            if (mapOpportunity.containsKey(instanceOpportinity.Account.Email_Address__c)) {
                WrapperScheduleClosedWonOpportunity wrapperInstance = 
                                mapOpportunity.get(instanceOpportinity.Account.Email_Address__c);
                wrapperInstance.opportunityList.add(instanceOpportinity);
                wrapperInstance.amount += instanceOpportinity.Amount;
                mapOpportunity.put(instanceOpportinity.Account.Email_Address__c,wrapperInstance);
            } else {
                WrapperScheduleClosedWonOpportunity wrapperInstance = 
                                                         new WrapperScheduleClosedWonOpportunity();
                wrapperInstance.opportunityList.add(instanceOpportinity);
                wrapperInstance.amount += instanceOpportinity.amount;
                mapOpportunity.put(instanceOpportinity.Account.Email_Address__c,wrapperInstance);
            }
        }
        System.debug('=====Map===' + mapOpportunity);
    } // End of method
    
    /**
     *  This is the method which will finish batch processing jobs by sending mails to perticular 
     *  opportunity owner.
     */
    public void finish(Database.BatchableContext objBatchableContext) {
        List<Messaging.SingleEmailMessage> mailList = new List<Messaging.SingleEmailMessage>();
        for (String emailInstance : mapOpportunity.keySet()) {
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            WrapperScheduleClosedWonOpportunity wrapperInstance = mapOpportunity.get(emailInstance);
            System.debug('=====Map===' + wrapperInstance);
            List<String> sendTo = new List<String>();
            sendTo.add('monali.nagpure@eternussolutions.com');
            mail.setToAddresses(sendTo);
            mail.setSenderDisplayName('SalesForce.com');
            mail.setSubject('List Of Opportunities and Amount');
            String body = 'Dear ' + emailInstance;
            body += '\n The Opportunities associated to your'; 
            body += '\n account and the aggregate amount is';
            body += '\n ' + wrapperInstance.opportunityList + ' ' + wrapperInstance.amount;
            for (Opportunity opportunityInstance : wrapperInstance.opportunityList){
                body += '\n ' + opportunityInstance.Name + ' ' + opportunityInstance.Amount;
            } // End of innerfor loop
            body += '\n ' + wrapperInstance.Amount;
            mail.setHtmlBody(body);
            System.debug('------Body of mail------ ' + body);
            mailList.add(mail); 
            Messaging.sendEmail(mailList);
            System.debug('------Success-----');
        } // End of outer for loop
    } // End of method
    
    /**
     *  This is wrapper class for opportunity which will hold values for opportunity.
     */
    public class WrapperScheduleClosedWonOpportunity {
        List<Opportunity> opportunityList = new List<Opportunity>();
        Decimal amount = 0;
        String Email = '';
    } // End of method
} // End of class