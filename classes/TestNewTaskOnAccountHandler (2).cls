/*********************************************************************************
 *  Test class for Handler of new task on account
 **********************************************************************************/
@isTest // Annotation
private class TestNewTaskOnAccountHandler {
    /**
     *  Method to test a task upon successful creation of a new Account.
     */
    static testMethod void testNewTask() {
        Task newTask = new Task();
        Account accountInstance = new Account();
        accountInstance.Name = 'Test Account';
        Test.startTest();  // Start test
        insert accountInstance;
        Test.stopTest();  // End test
        List<Task> TestListTask = [SELECT subject 
                                   FROM Task 
                                   WHERE subject = 'Meeting with Test Account'];
        System.assertEquals(1,TestListTask.size()); // Check for result				
    } // End of method
} // End of test class