/*********************************************************************************
 *  Test class for Handler of new task on account
 **********************************************************************************/
@isTest // Annotation
private class TestNewTaskOnAccountHandler {
    /**
     *  Method to test a task upon successful creation of a new Account.
     */
    static testMethod void testNewTask() {
        List<Account> listAccount = new List<Account>();
        Account accountInstance = new Account();
        accountInstance.Name = 'Test';
        listAccount.add(accountInstance);
        Test.startTest();  // Start test
        //NewTaskOnAccountHandler objNewTaskOnAccountHandler = new NewTaskOnAccountHandler();
        insert listAccount;
        List<Task> testListTask =NewTaskOnAccountHandler.accountRecord(listAccount);
        Test.stopTest();  // End test 
        System.assertEquals(1,testListTask.size()); // Check result 
    } // End of method
} // End of test class