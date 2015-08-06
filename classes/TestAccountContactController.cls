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
        System.assertEquals('/apex/AccountTable', nextPage);
    } // End of method
    
    /**
     * Method to test page getting all account records to display 
     */
    static testMethod void testAccountRecords() {
        List<Account> accountList = new List<Account>();
        for (Integer i = 0; i <5 ; i++) {
            Account accountInstance = new Account(Name = 'Test' + i);
            accountList.add(accountInstance);
        }
        insert accountList;
        AccountContactController objAccountContactController = new AccountContactController();
        System.assertEquals(accountList.size(),objAccountContactController.getlistAccount().size());
    } // End of method
    
    /**
     * Method to test page getting all contact records to display 
     */
    static testMethod void testContactRecords() {
        List<Account> accountList = new List<Account>();
        List<Contact> contactList = new List<Contact>();
        for (Integer i = 0; i <5 ; i++) {
            Account accountInstance = new Account(Name = 'Test' + i);
            accountList.add(accountInstance);
            Contact contactInstance = new Contact(LastName = 'Test' + i,
                                                  AccountId = accountInstance.id);
            contactList.add(contactInstance);
        }
        insert accountList;
        insert contactList;
        AccountContactController objAccountContactController = new AccountContactController();
        //PageReference  instancePageReference= Page.AccountTable;
        //Test.setCurrentPage(instancePageReference);
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
} // End of test class