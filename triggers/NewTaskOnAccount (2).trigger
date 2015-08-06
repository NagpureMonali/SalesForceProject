/********************************************************************************************
 *  Task Creation Trigger
 *  Create a task upon successful creation of a new Account.
 *  The task subject should be set as –Meeting with <specific Account’s name>.
 *  Should be bulk safe in nature and must be capable of handling at least 200 records at a time.
 */
trigger NewTaskOnAccount on Account (before insert) {
    if(trigger.isbefore && trigger.isinsert) {
        NewTaskOnAccountHandler.accountRecord(trigger.new); // Call method
    } // End of if
} // End of for loop