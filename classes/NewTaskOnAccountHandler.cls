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
        for (Account accountInstance : listAccount ) { 
            // Create task
            Task taskInstance = new Task(Subject = 'Meeting with ' + accountInstance.Name);
            listTask.add(taskInstance);  // Add task to record
        } 
        insert listTask; // Insert into task
        return listTask;
    } // End of method 
} // End of class