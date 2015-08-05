/*************************************************************************************************
 * Here is test class for UpdateHandler.
 *************************************************************************************************/
@isTest // Annotation
private class TestUpdateContactHandler {
    /**
     * Method to test account field is null and email field is not null.
     */
    static testMethod void testEmailAccount() {
        Account testAccount = new Account();
        testAccount.Website = 'www.test.com';
        testAccount.Name = 'TestAccount';
        Contact testContact = new Contact();
        testContact.LastName = 'test';
        testContact.Email = 'test@test.com';
        Test.startTest(); // Start test
        insert testAccount; // Insert account
        insert testContact; // Insertt Contact
        Test.stopTest(); // End test
        Contact contactInstance = [SELECT AccountID,
                                          LastName,
                                          Email 
                                   FROM Contact
                                   ]; // List of contact
        System.assertequals(testAccount.Id,contactInstance.AccountId,
                            'Matching account ID and Contact Lookup Id'
                            ); // Check for result
    } // End of method
    
    /**
     * Method to test both account and email fields are null.
     */
    static testMethod void testEmailAndAccountNull() {
        Account testAccount = new Account();
        testAccount.Website = 'www.test.com';
        testAccount.Name = 'TestAccount';
        Contact testContact = new Contact();
        testContact.LastName = 'test';
        Test.startTest(); // Start test
        insert testAccount;
        insert testContact;
        Test.stopTest(); // End test
        Contact contactInstance = [SELECT AccountID,
                                          LastName,
                                          Email 
                                   FROM Contact
                                   ];
        // Check for result
        System.assertequals(null,contactInstance.AccountId,'AccountID will be null'); 
    } // End of Method
    
    /**
     * Method to test email is null and account field is not null
     */
    static testMethod void testEmailAndAccountNotNull() {
        Account testAccount = new Account();
        testAccount.Website = 'www.test.com';
        testAccount.Name = 'TestAccount';
        Contact testContact = new Contact();
        testContact.LastName = 'test';
        testContact.AccountId = testAccount.Id;
        Test.startTest(); // Start test
        insert testAccount;
        insert testContact;
        Test.stopTest(); // End test
        Contact contactInstance = [SELECT AccountID,
                                          LastName,
                                          Email 
                                   FROM Contact
                                   ];
        System.assertequals(testContact.AccountId,contactInstance.AccountId,
                            'AccountID will be same as provided'
                            ); // Check for result
    }
    
    /**
     * Method to test if website(domainn) is not exist
     */
    static testMethod void testDomainNotExist() {
        Contact testContact=new Contact();
        testContact.LastName='test';
        testContact.Email='test@test.com';
        Test.startTest(); // Start Test
        insert testContact;
        Test.stopTest(); // End test
        Contact contactInstance=[SELECT AccountID,LastName,Email FROM Contact];
        System.assertequals(null,contactInstance.AccountId,
                            'Domain not exist so null'
                            ); // Check for result
    } // End of method
    
    /**
     * Method to test for account is not null and  email is not null
     */
    static testMethod void testEmailAccountNotNull() {
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
        System.assertequals(testContact.AccountId,contactInstance.AccountId,
                            'Already Given Account ID'
                            ); // Check for result
    } // End of method
} // End of test class