/*********************************************************************************
*  Handler class of new task on account
**********************************************************************************/
public with sharing class NewTaskOnAccountHandler 
{
    public static void accountRecord(List<Account> listAccount) 
    {
        /**
        *  Create a task upon successful creation of a new Account.
        *  The task subject should be set as –Meeting with <specific Account’s name>.
        */
        List<Task> listTask = new List<Task>(); // List of task
        for (Account a :listAccount )
        { 
            Task tsk = new Task(Subject='Meeting with '+a.Name); // Create task
            listTask.add(tsk);  // Add task to record
        } 
        insert listTask; // Insert into task
    } // End of method accountRecord
} // End of class