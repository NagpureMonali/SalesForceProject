/***************************************************************************************************
 *  This is the trigger which will be fire after inserttion of email
 **************************************************************************************************/
/*trigger EmailTrigger on Email__c (after insert) {
    if (trigger.isafter && trigger.isinsert) {
        EmailTriggerHandler.queryResultRecords(trigger.new); // Call method
    } // End of if
} // End of trigger */

trigger EmailTrigger on Email__c (before insert) {
    if (trigger.isbefore && trigger.isinsert) {
        EmailTriggerHandler.queryResultRecords(trigger.new); // Call method
    } // End of if
} // End of trigger