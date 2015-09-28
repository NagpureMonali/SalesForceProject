/***************************************************************************************************
 *  This is the Batch class to send responses to email senders  
 **************************************************************************************************/
public with sharing class SendResponseBatchJob  implements Database.Batchable<sObject> {
    /**
     *  This is method to define scope of batch for execution
     */
    public Database.QueryLocator start(Database.BatchableContext objBatchableContext) {
        return Database.getQueryLocator([Select id,
                                                r.Query__c, 
                                                r.Contact__c 
                                         From ResponseToSend__c r 
                                         WHERE Response_Sent__c = false
                                        ]
        );
    } // End of method 
    
    /**
     *  This is method to send responses to email sender
     */
    public void execute(Database.BatchableContext objBatchableContext, 
        List<ResponseToSend__c > listResponseToSend ) {
        // Get id for template which you designed
        EmailTemplate instanceEmailTemplate = [SELECT Id 
                                               FROM EmailTemplate 
                                               WHERE Name = 'Response To Send'
                                              ]; 
        List<Messaging.SingleEmailMessage> mailList = new List<Messaging.SingleEmailMessage>();
        for (ResponseToSend__c instanceResponseToSend : listResponseToSend) {
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            // Set target object id to which you want to send mail
            mail.setTargetObjectId(instanceResponseToSend.Contact__c);
            // Set template id to follow template formate
            mail.setTemplateId(instanceEmailTemplate.id);
            // Set what id to specify which query response want to send
            mail.setWhatId(instanceResponseToSend.Query__c);
            mail.setSaveAsActivity(false);
            // Add mail to list
            mailList.add(mail); 
            instanceResponseToSend.Response_Sent__c = true ;
            upsert instanceResponseToSend;
        } // End of for loop
        Messaging.sendEmail(mailList); // Send mail to list of email senders
    } // End of method
    
    /**
     *  This is method to finish batch execution
     */
    public void finish(Database.BatchableContext objBatchableContext) {
        
    } // End of method
} // End of batch class