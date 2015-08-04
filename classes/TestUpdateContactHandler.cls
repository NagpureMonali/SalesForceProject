@isTest // Annotation
public with sharing class TestUpdateContactHandler // class to test updateContactHandler
{
	static testMethod void testEmailAccount() // Test for account is null and  email is not null
	{
			Account testAccount=new Account();
			testAccount.Website='www.test.com';
            testAccount.Name='TestAccount';
            Contact testContact=new Contact();
			testContact.LastName='test';
			testContact.Email='test@test.com';
            Test.startTest(); // Start Test
			insert testAccount; // Insert account
			insert testContact; // Insertt Contact
			Test.stopTest(); // End test
			Contact contactInstance=[SELECT AccountID,LastName,Email FROM Contact]; // List of contact
			system.assertequals(testAccount.Id,contactInstance.AccountId,'Matching account ID and Contact Lookup Id'); // Check for result
	}
	static testMethod void testEmailAndAccountNull()//test for both email and account fields are null
	{
			Account testAccount=new Account();
			testAccount.Website='www.test.com';
            testAccount.Name='TestAccount';
            Contact testContact=new Contact();
			testContact.LastName='test';
            Test.startTest(); // Start Test
			insert testAccount;
			insert testContact;
			Test.stopTest(); // End test
			Contact contactInstance=[SELECT AccountID,LastName,Email FROM Contact];
			system.assertequals(null,contactInstance.AccountId,'AccountID will be null'); // Check for result
	}
	static testMethod void testEmailAndAccountNotNull()//test for email is null and account field is not null
	{
			Account testAccount=new Account();
			testAccount.Website='www.test.com';
            testAccount.Name='TestAccount';
            Contact testContact=new Contact();
			testContact.LastName='test';
			testContact.AccountId=testAccount.Id;
            Test.startTest(); // Start Test
			insert testAccount;
			insert testContact;
			Test.stopTest(); // End test
			Contact contactInstance=[SELECT AccountID,LastName,Email FROM Contact];
			system.assertequals(testContact.AccountId,contactInstance.AccountId,'AccountID will be same as provided'); // Check for result
	}
	static testMethod void testDomainNotExist() //test if website(domainn) is not exist
	{
			Contact testContact=new Contact();
			testContact.LastName='test';
			testContact.Email='test@test.com';
            Test.startTest(); // Start Test
			insert testContact;
			Test.stopTest(); // End test
			Contact contactInstance=[SELECT AccountID,LastName,Email FROM Contact];
			system.assertequals(null,contactInstance.AccountId,'Domain not exist so null'); // Check for result
	}
	static testMethod void testEmailAccountNotNull() //test for account is not null and  email is not null
	{
			Account testAccount=new Account();
			testAccount.Website='www.test.com';
            testAccount.Name='TestAccount';
            Contact testContact=new Contact();
			testContact.LastName='test';
			testContact.Email='test@test.com';
			testContact.AccountId='00128000004I8Ue';//already lookup with anyother account
            Test.startTest(); // Start Test
			insert testAccount;
			insert testContact;
			Test.stopTest(); // End test
			Contact contactInstance=[SELECT AccountID,LastName,Email FROM Contact];
			system.assertequals(testContact.AccountId,contactInstance.AccountId,'Already Given Account ID'); // Check for result
	}
}