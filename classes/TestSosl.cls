/*********************************************************************************************
*  This is test class to test SoslClass
***********************************************************************************************/
@isTest // Annotation
public with sharing class TestSosl {
    /**
     *  Method to test the word 'test' in all name fields returning Contact, 
     *  Account, Lead and User
     */
    static testMethod void TestAllFields() {
        Integer i = 0;
        List<Account> testListAccount = new List<Account>();
        for(i=0;i <= 5; i++) {
            Account testAccount = new Account(Name = 'Test'+i);
            testListAccount.add(testAccount);    
        }
        List<Lead> testListLead = new List<Lead>();
        for(i=0;i <= 50; i++) {
            Lead leadInstance = new Lead(LastName = 'Test'+i, 
                                         Company = 'ESPL', 
                                         LeadSource='Web', 
                                         Status='Closed');
            testListLead.add(leadInstance);    
        }
        List<Contact> testListContact = new List<Contact>();
        for(i=0;i <= 50; i++) {
            Contact contactInstance = new Contact(LastName = 'Test'+i);
            testListContact.add(contactInstance);    
        }
        List<User> testListUser = new List<User>();
        Test.startTest(); // Start Test
        insert testListAccount;
        insert testListLead;
        insert testListContact;
        List<List<SObject>> testSearchList = [FIND 'test*' 
                                              IN Name 
                                              FIELDS RETURNING Contact(Id,Name), 
                                                               Account(Id,Name), 
                                                               Lead(Id,Name), 
                                                               User(Id,Name)
                                          ]; // List of search result
        Sosl objSosl=new Sosl();
        Test.stopTest(); // End test
        system.assertEquals(testSearchList,objSosl.allFields()); // Check for result
    } // End of method
} // End of testclass