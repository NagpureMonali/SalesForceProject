/*******************************************************************************
 *  It is controller class for Account And Contact Object
 ********************************************************************************/
public with sharing class AccountContactController {
    public List<Contact> listContact {get; set;}
    public List<Account> listAccount {get; set;}
    public List<String> alphabetList;
    public Account accountName {get; set;}
    public Id idOfAccount {get; set;} // Account Id using get set method
    public Integer counter {get; set;} // To count no of records
    public String findName {get; set;} // To find account name from search field
    public String alphabet {get; set;} 
    public String contactPhone {get; set;}
    public String contactName {get; set;}
    public String option {get; set;}
    public List<WrapperForCheckbox> wrapperListOfContact {get; set;} 
    public List<Contact> contactToDeleteList;
    
    /**
     * Here is constructor to initialize all data 
     */
    public AccountContactController() {
        listContact = new List<Contact>(); 
        alphabetList = new List<String>(); 
        wrapperListOfContact = new List<WrapperForCheckbox>(); 
        contactToDeleteList = new List<Contact>();
    } // End of method
    
    /**
     *  It is a wrapper class to delete multiple contacts
     */
    public class WrapperForCheckbox {
        public Contact contactInstance {get; set;}
        public Boolean selectedCheckBox {get; set;}
        public WrapperForCheckbox(Contact contactInstance) {
            System.debug('====In Wrapper class===');
            this.selectedCheckBox = false;
            this.contactInstance = contactInstance;
        } // End of constructor
    } // End of class
    
    /**
     *  Here is method to delete multiple contact. So iterated over wrapper list and contact for 
     *  which checkbox is checked add them to new list which we will delete
     */
    public void multipleDeleteContact() {
        for (WrapperForCheckbox wrapperForCheckboxInstance : wrapperListOfContact) {
            if (wrapperForCheckboxInstance.selectedCheckBox == true) {
                contactToDeleteList.add(wrapperForCheckboxInstance.contactInstance);
            } // End of if
        } // End of for loop
        System.debug('---Delete list : ---' + contactToDeleteList);
        delete contactToDeleteList;  // Delete list
        wrapperListOfContact.Clear(); // clear that wrapper list
        listOfAllAccountRelatedContact(); // Call method to display remaining contacts
    } // End of method
    
    /**
     *  This method will fetch account related contact records 
     */
    public void listOfAllAccountRelatedContact() { 
        // Here will get Id of current page
        idOfAccount = apexpages.currentpage().getparameters().get('mona');
        System.debug('-----In method Contact List Account ID :-----' + idOfAccount);
        accountName = [SELECT Name 
                       FROM Account 
                       WHERE Id = :idOfAccount
                      ];
        System.debug('----Account Name -----' + accountName);
        listContact = [SELECT c.Id,
                              c.Name,
                              c.Account.Name,
                              c.Department,
                              c.Email 
                       FROM Contact c 
                       WHERE c.Account.Id = :idOfAccount
                      ]; // Query to fetch contact records
        counter = listContact.size();
        for (Contact contactInstance : listContact) {
            wrapperListOfContact.add(new WrapperForCheckbox(contactInstance));
        }  // End of for loop
        System.debug('-----wrapperListOfContact List-----' + wrapperListOfContact);
        System.debug('-----Contact List-----' + listContact);
    } // End of method
      
    /**
     *  Method to redirect page from Contact to Account Page
     */
    public PageReference redirectToAccountPage() {
        PageReference accountPage = Page.AccountTable;
        accountPage.setRedirect(True);
        return accountPage;
    } // End of method

    /**
     *  Merthod to get list of Account Object
     */
    public void listOfAllAccount() { 
        listAccount = [SELECT Id,
                              Name,
                              Email_Address__c,
                              Phone,
                              Website
                       FROM Account
                      ]; // Query to fetch account records
        counter = listAccount.size();
        System.debug('-----In all account method Account List   -----' + listAccount);
    } // End of method
    
    /*
     *  Method to search for account name from search text box
     */
    public void getsearchAccount() {
        System.debug('-- in method--' + findName);
        if (findName.Length()<3) {
            //if word length is less than 3 then show error msg and set flag to false
            System.debug('--- in if block=> null text--');
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,
                                'Input at least 3 characters to perform search'
                                )
            );
        } else {
            // Else display list of account having name similar to account name provided in search 
            listAccount = [SELECT Id,
                                  Name,
                                  Email_Address__c,
                                  Phone,
                                  Website
                           FROM Account 
                           WHERE Name 
                           LIKE  : '%' + findName + '%'
                          ]; // Query to fetch account records
            System.debug('--- searchAccount list : -->>>' + listAccount );
            counter = listAccount.size();
            System.debug('--- in else block--');
        } // End of else 
    } // End of Method
    
    /**
     * Method to clear text field
     */
    public String getclearInputText() {
        System.debug('----- in clear block---');
        findname = '';
        return null;
    } // End of method
    
    /**
     * Method to display list of alphabet
     */
    public List<String> getalphabetList() {
        alphabetList = new List<String> {'A','B','D','E','F','G','H','I','J','K','L','M',
                                         'N','O','P','Q','R','S','T','U','V','W','X','Y','Z'
                                         };
        return alphabetList;
    } // End of method
    
    /**
     * Method to search alphabet as provided
     */
    public void searchAlphabet() {
        alphabet = apexpages.currentpage().getparameters().get('alphabet');
        System.debug('=======alpha in searchaplhabet ========' + alphabet);
        accountName = [SELECT Name 
                       FROM Account 
                       WHERE Id = :idOfAccount
                      ];
        System.debug('-=====account name=====' + accountName);
        listContact = [SELECT c.Id,
                              c.Name,
                              c.Account.Name,
                              c.Department,
                              c.Email 
                       FROM Contact c 
                       WHERE c.Account.Id = :idOfAccount 
                       AND c.Name LIKE : alphabet + '%'
                       ];//query to fetch contact records
        counter = listContact.size();
        System.debug('-----Contact List in else-----' + idOfAccount);
    } // End of method
    
    /**
     *  Method to redirect from contact page to new contactpage which will show contact to add
     */
    public PageReference newContact() {
        idOfAccount = apexpages.currentpage().getparameters().get('accountId');
        System.debug('------------newContact AccountidOfAccount id :-----------' + idOfAccount);
        PageReference newcontactPage = new PageReference('/apex/AddNewContact');
        newcontactPage.getparameters().put('accountId',idOfAccount);
        newcontactPage.setRedirect(True);
        return newcontactPage;
    } // End of method
    
    /*
     *  Method to redirect from Account to Contact Page
     */
    public PageReference redirectToContactPage() {
        //get acount id using getparameters
        idOfAccount = apexpages.currentpage().getparameters().get('accountId');
        PageReference contactPage = new PageReference('/apex/ContactTable?mona=' + idOfAccount);
        contactPage.getparameters().put('accountId',idOfAccount);
        contactPage.setRedirect(True);
        return contactPage;
    } // End of method
    
    /**
     *  Here is the method which will save contact which is newly created
     */
    public PageReference getsaveContact() {
        idOfAccount = apexpages.currentpage().getparameters().get('accountId');
        System.debug('---------in save contact Accountid idofaccount :-----------' + idOfAccount);
        contactName = contactName;
        contactPhone = contactPhone ;
        System.debug('------------contactName :-----------' + contactName);
        System.debug('-----------contactPhone :-----------' + contactPhone);
        Contact contactInstance = new Contact();
        contactInstance.AccountId = idOfAccount;
        contactInstance.LastName = contactName;
        contactInstance.Phone = contactPhone;
        insert contactInstance;
        System.debug('------Contact inserted successfully-----');
        PageReference contactPage = new PageReference('/apex/ContactTable?mona=' + idOfAccount);
        contactPage.getparameters().put('accountId',idOfAccount);
        contactPage.setRedirect(True);
        return contactPage;
    } // End of method
    
    /**
     * Remote method to delete contact records
     */
    @RemoteAction // Annotation
    public static List<Contact> contactToDelete(Id idForContact) {
        System.debug('====contact id======' + idForContact);
        List<Contact> listContact = [SELECT ID 
                                     FROM Contact 
                                     WHERE Id = :idForContact
                                    ];
        delete listContact;
        List<Contact> newListContact = [SELECT ID 
                                        FROM Contact
                                        WHERE Id = :idForContact
                                       ];
        return newListContact; 
    } // End of remote method
} // End of class