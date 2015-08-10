/**
 * Test class for AccountContactController
 */
@isTest // Annotation
private class TestAccountContactController {
    /**
     * Method to test page redirect from account page to contact page 
     */
    static testMethod void testAccountRedirectToContact() {
        PageReference  instancePageReference = Page.AccountTable;
        Test.setCurrentPage(instancePageReference);
        AccountContactController objAccountContactController = new AccountContactController();
        String nextPage = objAccountContactController.redirectToContactPage().getUrl();
        System.assertEquals('/apex/ContactTable?mona=null', nextPage);
    } // End of method
    
    /**
     * Method to test page redirect from contact page to account page 
     */
    static testMethod void testContactRedirectToAccount() {
        PageReference  instancePageReference = Page.ContactTable;
        Test.setCurrentPage(instancePageReference);
        AccountContactController objAccountContactController = new AccountContactController();
        String nextPage = objAccountContactController.redirectToAccountPage().getUrl();
        System.assertEquals('/apex/accounttable', nextPage);
    } // End of method
    
    /**
     * Method to test page getting all account records to display 
     */
    static testMethod void testAccountRecords() {       
        AccountContactController objAccountContactController = new AccountContactController();
        System.assertEquals(TestDataFactory.createTestRecordsForAccount(5,'Test').size(),
                            objAccountContactController.getlistAccount().size());
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
        }
        insert contactList;
        AccountContactController objAccountContactController = new AccountContactController();
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
        List<Account> acccountList = TestDataFactory.createTestRecordsForAccount(5,'Test Name');
        AccountContactController objAccountContactController = new AccountContactController();
        objAccountContactController.findName = 'Test Name';
        System.assertEquals(true,objAccountContactController.searchAccount());
    } // End of method 
    
    /**
     * Method to test search account name having length less than 3 
     */
    static testMethod void testAccountNameLessThan3Char() {       
        List<Account> acccountList = TestDataFactory.createTestRecordsForAccount(5,'Test Name');
        AccountContactController objAccountContactController = new AccountContactController();
        objAccountContactController.findName = 'Te';
        System.assertEquals(false,objAccountContactController.searchAccount());
        List<Apexpages.Message> msgs = ApexPages.getMessages();
        boolean newFlag = false;
        for(Apexpages.Message msg : msgs){
            if (msg.getDetail().contains('Input at least 3 characters to perform search')) {
                newFlag = true;
            } // End of if loop
        } // End of for loop
        System.assertEquals(true,newFlag);
    } // End of method 
    
    /**
     * Method to test delete contact records related to perticular account 
     */
    static testMethod void testDeleteContactRecord() {       
        List<Account> acccountList = TestDataFactory.createTestRecordsForAccount(5,'Test Name');
        List<Contact> contactList = new List<Contact>();         
        for(Account accountInstance : acccountList) {
            Contact contactInstance = new Contact(LastName = 'TestContact',
                                                  AccountId = accountInstance.Id
                                                  );
            contactList.add(contactInstance );
        }
        insert contactList;
        AccountContactController objAccountContactController = new AccountContactController();
        for(Contact contactInstance : contactList) {
            AccountContactController.contactToDelete(contactInstance.Id);
        }
        List<Contact> contactListNew = [SELECT LastName 
                                        FROM Contact 
                                        WHERE LastName = 'TestContact'];
        System.assertEquals(0,contactListNew.size());
    } // End of method 
    
    /**
     * Method to test findname field gets clear
     */
    static testMethod void testClearField() {
        AccountContactController objAccountContactController = new AccountContactController();
        objAccountContactController.findname= 'Test';   
        System.assertEquals(null,objAccountContactController.getclearInputText());
    } // End of method
    
    /**
     * Method to test display contacts as specified alphabet
     */
    static testMethod void testAlphaSearch() {
        List<Account> acccountList = TestDataFactory.createTestRecordsForAccount(5,'Test Name');
        List<Contact> contactList = new List<Contact>();         
        for(Account accountInstance : acccountList) {
            Contact contactInstance = new Contact(LastName = 'TestContact',
                                                  AccountId = accountInstance.Id
                                                  );
            contactList.add(contactInstance );
        }
        insert contactList;
        AccountContactController objAccountContactController = new AccountContactController();
        PageReference  instancePageReference = Page.ContactTable;
        Test.setCurrentPage(instancePageReference);
        objAccountContactController.alphabet='T';        
        //ApexPages.currentPage().getParameters().put('alphabet','T');
        System.assertEquals(5,objAccountContactController.getlistContact().size());
       // System.assertEquals(contactList.size(),objAccountContactController.searchAlphabet().size());
    } // End of method
} // End of test class