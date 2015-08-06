/*********************************************************************************
 *  Handler class of new task on account
 **********************************************************************************/
public with sharing class NewTaskOnAccountHandler {
    /**
     *  Create a task upon successful creation of a new Account.
     *  The task subject should be set as –Meeting with <specific Account’s name>.
     */
    public static List<Task> accountRecord(List<Account> listAccount) {
        List<Task> listTask = new List<Task>(); // List of task
        Map<Id,String> mapAccount = new Map<Id,String>();  
        for (Account accountInstance : listAccount ) {
             mapAccount.put(accountInstance.Id,accountInstance.Name);
             System.debug('===id===' + mapAccount);
            // Create task
            Task taskInstance = new Task(Subject = 'Meeting with ' + accountInstance.Name);
            listTask.add(taskInstance);  // Add task to record
        } 
        insert listTask; // Insert into task
        List<Task> taskList = [SELECT Account.Name, 
                                      AccountId, 
                                      Subject 
                               FROM Task 
                               WHERE Subject LIKE 'Meeting with %'
                               ];
        System.debug('list of tsk ====>: ' + taskList );
        return taskList;
    } // End of method 
} // End of class