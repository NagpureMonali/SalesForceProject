/*******************************************************************************
 *  It is controller class for Account And Contact Object
 ********************************************************************************/
global with sharing class AccountContactController {
    public boolean flag = false;
    public boolean alphaFlag = false;
    List<Contact> listContact;
    List<Account> listAccount;
    List<Account> searchedAccount;
    public List<String> alphabetList;
    public Account accountName {get;set;}
    public Id idOfAccount {get; set;} // Account Id using get set method
    public String name {get; set;} // String using get set method
    public Integer counter {get;set;} // To count no of records
    public String findName {get;set;} // To find account name from search field
    public String alphabet {get;set;} 
    
    /**
     *  This method will fetch account records and contact records 
     */
    public List<Contact> getlistContact() { 
        // Here will get Id of current page
        idOfAccount = apexpages.currentpage().getparameters().get('mona');
        System.debug('-----method Contact List -----' + idOfAccount);
        if (!alphaFlag) {
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
                          ];//query to fetch contact records
            counter = listContact.size();
            System.debug('-----Contact List in if -----' + idOfAccount);
            //return the list of contact which are fetched in query
            return listContact;
        } else {
            accountName = [SELECT Name 
                           FROM Account 
                           WHERE Id = :idOfAccount
                          ];
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
            //return the list of contact which are fetched in query
            //alphaFlag =false;
            return listContact;
         } // End of else
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
    public List<Account> getlistAccount() { 
        if (!flag) {
            listAccount = [SELECT Id,
                                  Name,
                                  Email_Address__c,
                                  Phone,
                                  Website
                           FROM Account
                          ];//query to fetch account records
            counter = listAccount.size();
            return listAccount;
        } else {
            listAccount = [SELECT Id,
                                  Name,
                                  Email_Address__c,
                                  Phone,
                                  Website
                           FROM Account 
                           WHERE Name 
                           like  : '%' + findName + '%'
                          ];//query to fetch account records
        counter = listAccount.size();
        return listAccount;
        } // End of else
    } // End of method

    /*
     *  Method to redirect from Account to Contact Page
     */
    public PageReference redirectToContactPage() {
        //get acount id using getparameters
        idOfAccount = apexpages.currentpage().getparameters().get('accountId');
        System.debug('-----redirect page account id-----' + idOfAccount);
        PageReference contactPage = new PageReference('/apex/ContactTable?mona=' + idOfAccount);
        contactPage.setRedirect(True);
        return contactPage;
    } // End of method
    
    /*
     *  Method to search for account name from search text box
     */
    public void searchAccount() {
        System.debug('-- in method--' + findName);
        if(findName.Length()<3) {
           //if word length is less than 3 then show error msg and set flag to false
           System.debug('--- in if block=> null text--');
           flag = false;
           ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,
                                'Input at least 3 characters to perform search')
                                );
           // System.alert('Input at least 3 characters to perform search');
        } else {
            // Else display list of account having name similar to account name provided in search 
            flag = true; //set flage true
            System.debug('--- in else block--');
        }
    } // End of Method
    
    /**
     * Method to clear text field
     */
    public void getclearInputText() {
        System.debug('----- in clear block---');
        findname = ' ';
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
        System.debug('=======alpha========' + alphabet);
        alphaFlag = true;
        getlistContact();
       // return searchAplha;
    } // End of method
    
    /**
     * Remote method to delete contact records
     */
    @RemoteAction // Annotation
    global static void contactToDelete(Id idForContact) {
        System.debug('====contact id======' + idForContact);
        //Contact contactInstance = new Contact();
        List<Contact> listContact = [SELECT ID 
                                     FROM Contact 
                                     WHERE Id = :idForContact
                                    ];
        delete listContact;
        List<Contact> newListContact = [SELECT ID 
                                        FROM Contact
                                       ];
       // return contactToDelete;
    } // End of remote method
} // End of class