/**
 * Test class for AccountContactController
 */
@isTest // Annotation
private class TestAccountContactController {
    /**
     * Method to test page redirect from account page to contact page 
     */
    static testMethod void testAccountRedirectToContact() {
        PageReference instancePageReference = Page.AccountTable;
        Test.setCurrentPage(instancePageReference);
        Test.startTest(); // Start test
        AccountContactController objAccountContactController = new AccountContactController();
        String nextPage = objAccountContactController.redirectToContactPage().getUrl();
        Test.stopTest(); // End test
        System.assertEquals('/apex/ContactTable?mona=null', nextPage);
    } // End of method
     
    /**
     * Method to test page redirect from contact page to account page 
     */
    static testMethod void testContactRedirectToAccount() {
        PageReference  instancePageReference = Page.ContactTable;
        Test.setCurrentPage(instancePageReference);
        Test.startTest(); // Start test
        AccountContactController objAccountContactController = new AccountContactController();
        String nextPage = objAccountContactController.redirectToAccountPage().getUrl();
        Test.stopTest(); // End test
        System.assertEquals('/apex/accounttable', nextPage);
    } // End of method
    
    /**
     * Method to test page redirect from contact page to add new contact page 
     */
    static testMethod void testContactToNewContact() {
        PageReference  instancePageReference = Page.AddNewContact;
        Test.setCurrentPage(instancePageReference);
        Test.startTest(); // Start test
        AccountContactController objAccountContactController = new AccountContactController();
        String nextPage = objAccountContactController.newContact().getUrl();
        Test.stopTest(); // End test
        System.assertEquals('/apex/AddNewContact', nextPage);
    } // End of method
    
    /**
     * Method to test page getting all account records to display 
     */
    static testMethod void testAccountRecords() {
        TestDataFactory.createTestRecordsForAccount(5,'Test');
        Test.startTest(); // Start test
        AccountContactController objAccountContactController = new AccountContactController();
        objAccountContactController.listOfAllAccount();
        Test.stopTest(); // End test
        System.assertEquals(5,objAccountContactController.listAccount.size());
    } // End of method
    
    /**
     * Method to test page getting all contact records to display 
     */
    static testMethod void testContactRecords() {
        List<Account> accountList = TestDataFactory.createTestRecordsForAccount(5,'Test');
        List<Contact> contactList = new List<Contact>();
        for (Account accountInstance : accountList) {
            Contact contactInstance = new Contact(LastName = 'Test',
                                                  AccountId = accountInstance.id);
            contactList.add(contactInstance);
        } // End of for loop
        insert contactList;
        Test.startTest(); // Start test
        AccountContactController objAccountContactController = new AccountContactController();
        Test.stopTest(); // End test
        List<Contact> contactListInstance = [SELECT LastName,
                                                    AccountId
                                             FROM Contact
                                            ];
        for (Contact contactInstance : contactListInstance) {
            PageReference  instancePageReference = Page.AccountTable;
            Test.setCurrentPage(instancePageReference);
            ApexPages.currentPage().getParameters().put('Id',contactInstance.AccountId);
            String id = ApexPages.currentPage().getParameters().get('id');
            System.assertEquals(contactInstance.AccountId,id);
        } // End of for loop
    } // End of Method
    
    /**
     * Method to test search account name 
     */
    static testMethod void testSearchAccountName() {       
        List<Account> acccountList = TestDataFactory.createTestRecordsForAccount(5,'TestAccount');
        Test.startTest(); // Start test
        AccountContactController objAccountContactController = new AccountContactController();
        objAccountContactController.findName = 'TestAccount';
        objAccountContactController.getsearchAccount();
        Test.stopTest(); // End test
        System.assertEquals(acccountList.size(),objAccountContactController.listAccount.size());
    } // End of method 
    
    /**
     * Method to test search account name having length less than 3 
     */
    static testMethod void testAccountNameLessThan3Char() {       
        List<Account> acccountList = TestDataFactory.createTestRecordsForAccount(5,'Test Name');
        Test.startTest(); // Start test
        AccountContactController objAccountContactController = new AccountContactController();
        objAccountContactController.findName = 'Te';
        objAccountContactController.getsearchAccount();
        Test.stopTest(); // End test
        List<Apexpages.Message> testMessage = ApexPages.getMessages();
        System.assertEquals(1,testMessage.size());
    } // End of method 
    
    /**
     * Method to test delete contact records related to perticular account 
     */
    static testMethod void testDeleteContactRecord() {       
        List<Account> acccountList = TestDataFactory.createTestRecordsForAccount(5,'Test Name');
        List<Contact> contactList = new List<Contact>();         
        for (Account accountInstance : acccountList) {
            Contact contactInstance = new Contact(LastName = 'TestContact',
                                                  AccountId = accountInstance.Id
                                                  );
            contactList.add(contactInstance );
        }
        insert contactList;
        Test.startTest(); // Start test
        AccountContactController objAccountContactController = new AccountContactController();
        Test.stopTest(); // End test
        for (Contact contactInstance : contactList) {
            AccountContactController.contactToDelete(contactInstance.Id);
        } // End of for loop
        List<Contact> contactListNew = [SELECT LastName 
                                        FROM Contact 
                                        WHERE LastName = 'TestContact'
                                       ];
        System.assertEquals(0,contactListNew.size());
    } // End of method 
    
    /**
     * Method to test findname field gets clear
     */
    static testMethod void testClearField() {
        Test.startTest(); // Start test
        AccountContactController objAccountContactController = new AccountContactController();
        objAccountContactController.findname = 'Test';  
        Test.stopTest(); // End test 
        System.assertEquals(null,objAccountContactController.getclearInputText());
    } // End of method
    
    /**
     * Method to test contact get saved or not
     */
    static testMethod void testContactSaved() {
        Test.startTest(); // Start test
        AccountContactController objAccountContactController = new AccountContactController();
        List<Account> acccountList = TestDataFactory.createTestRecordsForAccount(1,'TestName');         
        for (Account accountInstance : acccountList) {
            objAccountContactController.idOfAccount = accountInstance.Id;
        } // End of for loop
        PageReference instancePageReference = Page.ContactTable;
        Test.setCurrentPage(instancePageReference);
        instancePageReference.getparameters().put('accountId',objAccountContactController.idOfAccount);
        objAccountContactController.contactName = 'TestContact';
        objAccountContactController.contactPhone = '1234567';
        String testPage = objAccountContactController.getsaveContact().getUrl();
        Test.stopTest(); // End test
        System.assertNotEquals('/apex/ContactTable?mona=',testPage);
    } // End of method
    
    /**
     * Method to test displaying alphabet list
     */
    static testMethod void testAlphabetList() {
        Test.startTest(); // Start test
        AccountContactController objAccountContactController = new AccountContactController();
        List<String> sampleListOfAlphabet = objAccountContactController.getalphabetList();
        Test.stopTest(); // End test
        System.assertNotEquals(null,sampleListOfAlphabet.size());
    } // End of method
    
    /**
     * Method to test display contacts as specified alphabet
     */
    static testMethod void testAlphaSearch() {
        AccountContactController objAccountContactController = new AccountContactController();
        List<Account> acccountList = TestDataFactory.createTestRecordsForAccount(1,'TestName');
        List<Contact> contactList = new List<Contact>();         
        for (Account accountInstance : acccountList) {
            Contact contactInstance = new Contact(LastName = 'TestContact',
                                                  AccountId = accountInstance.Id
                                                  );
            contactList.add(contactInstance ); 
            objAccountContactController.idOfAccount = accountInstance.Id;
        } // End of for loop
        insert contactList;
        String alphabetToSearch = 'T';
        Test.startTest(); // Start test
        PageReference instancePageReference = Page.ContactTable;
        Test.setCurrentPage(instancePageReference);
        instancePageReference.getparameters().put('alphabet',alphabetToSearch);
        objAccountContactController.searchAlphabet();
        Test.stopTest(); // End test      
        System.assertEquals(1,objAccountContactController.listContact.size());
    } // End of method
    
    /**
     *  Method to test fetching account related contact records 
     */
     static testMethod void testAccountRelatedContact() {
        AccountContactController objAccountContactController = new AccountContactController();
        List<Account> acccountList = TestDataFactory.createTestRecordsForAccount(1,'TestName');
        List<Contact> contactList = new List<Contact>();         
        for (Account accountInstance : acccountList) {
            Contact contactInstance = new Contact(LastName = 'TestContact',
                                                  AccountId = accountInstance.Id
                                                  );
            contactList.add(contactInstance ); 
            objAccountContactController.idOfAccount = accountInstance.Id;
        }
        insert contactList;
        Test.startTest(); // Start test
        PageReference instancePageReference = Page.ContactTable;
        Test.setCurrentPage(instancePageReference);
        instancePageReference.getparameters().put('mona',objAccountContactController.idOfAccount);
        objAccountContactController.listOfAllAccountRelatedContact();
        Test.stopTest(); // End test  
        System.assertEquals(1,objAccountContactController.counter);
     } // End of method
} // End of test class