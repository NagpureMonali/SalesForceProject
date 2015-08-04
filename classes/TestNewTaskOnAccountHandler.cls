@isTest // Annotation
public with sharing class TestNewTaskOnAccountHandler // Test class to test new ttask on account 
{
	static testMethod void testNewTask() // Method to test new task 
	{
		Task newTask=new Task();
		Account accountInstance=new Account();
		accountInstance.Name='Test Account';
        Test.startTest();  // Start Test
		insert accountInstance;
        Test.stopTest();  // End Test
        List<Task> TestListTask = [SELECT subject FROM Task WHERE subject='Meeting with Test Account'];
        System.assertEquals(1,TestListTask.size()); // Check for result				
	} // End of method
} // End of test class