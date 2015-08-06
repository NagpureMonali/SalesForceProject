/******************************************************************************
 *  It is controller class for Account And Contact Object
 ********************************************************************************/
global with sharing class AccountContactController {
    public boolean flag=false;
    public boolean alphaFlag=false;
    List<Contact> listContact;
    List<Account> listAccount;
    List<Account> searchedAccount;
    public List<String> alphabetList;
    public Account NameOfAccount{get;set;}
    public Id Account_Id{get; set;}//Account Id using get set method
    public String Name{get; set;}//string using get set method
    public Integer Count{get;set;}//to count no of records
    public String findName{get;set;}//to find account name from search field
    public String alphabet{get;set;}
    public List<Contact> getlistContact() {
         /**
         *  This method will fetch account records and contact records 
         */ 
         // here will get Id of currentt page
         Account_Id=apexpages.currentpage().getparameters().get('mona');
         System.debug('-----method Contact List -----' + Account_Id);
         if(alphaFlag == false){
            NameOfAccount = [SELECT Name 
                             FROM Account 
                             WHERE Id = :Account_Id
                             ];
            listContact = [SELECT c.Id,
                                  c.Name,
                                  c.Account.Name,
                                  c.Department,
                                  c.Email 
                           FROM Contact c 
                           WHERE c.Account.Id = :Account_Id
                          ];//query to fetch contact records
            Count = listContact.size();
            System.debug('-----Contact List in if -----' + Account_Id);
            //return the list of contact which are fetched in query
            return listContact;
         } else {
             NameOfAccount = [SELECT Name 
                              FROM Account 
                              WHERE Id = :Account_Id
                             ];
             listContact = [SELECT c.Id,
                                   c.Name,
                                   c.Account.Name,
                                   c.Department,
                                   c.Email 
                            FROM Contact c 
                            WHERE c.Account.Id = :Account_Id 
                            AND c.Name LIKE : alphabet+'%'
                           ];//query to fetch contact records
            Count=listContact.size();
            System.debug('-----Contact List in else-----' + Account_Id);
            //return the list of contact which are fetched in query
            //alphaFlag =false;
            return listContact;
         } // End of else
    } // End of method
      
    /**
     *  Method to redirect page from Contact to Account Page
     */
    public PageReference redirectToAccountPage() {
        PageReference accountPage= new PageReference('/apex/AccountTable');
       // accountPage.setRedirect(True);
        return accountPage;
    } // End of method

    public List<Account> getlistAccount() { 
        /**
        *  Merthod to get list of Account Object
        */
        if(flag==false)
        {
            listAccount=[SELECT Id,
                                Name,
                                Email_Address__c,
                                Phone,
                                Website
                        FROM Account
                        ];//query to fetch account records
            Count=listAccount.size();
            return listAccount;
        } // End of if block
        else
        {
            listAccount=[SELECT Id,
                                Name,
                                Email_Address__c,
                                Phone,
                                Website
                         FROM Account 
                         WHERE Name 
                         like  : '%'+findName+'%'
                     ];//query to fetch account records
        Count=listAccount.size();
        return listAccount;
        } // End of else
    } // End of method

    public PageReference redirectToContactPage() {
        /*
        *  Method to redirect From Account to Contact Page
        */
        //get acount id using getparameters
        Account_Id= apexpages.currentpage().getparameters().get('AccountName');
        System.debug('-----redirect page-----'+Account_Id);
        PageReference contactPage= new PageReference('/apex/ContactTable?mona='+Account_Id);
        contactPage.setRedirect(True);
        return contactPage;
    } // End of method
    
    public void searchAccount() {
        /*
        *  Method to search for account name from search text box
        */
        System.debug('-- in method--'+findName);
        if(findName.Length()<3) {
            //if word length is less than 3 then show error msg and set flag to false
           System.debug('--- in if block=> null text--');
           flag=false;
           ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,
                                                       'Input at least 3 characters to perform search'));
          // System.alert('Input at least 3 characters to perform search');
        } else {
            // else display list of account having name similar to account name provided in search text box
            flag=true; //set flage true
            System.debug('--- in else block--');
         }
    } // End of Method
    
    public void getclearInputText() {
        System.debug('----- in clear block---');
        findname=' ';
    } // End of method

    public List<String> getalphabetList() {
        alphabetList = new List<String> {'A','B','D','E','F','G','H','I','J','K','L','M','N','O','P',
                                      'Q','R','S','T','U','V','W','X','Y','Z'};
        return alphabetList;
    }
    
    /**
     * Method to search alphabet as provided
     */
    public void searchAlphabet() {
        alphabet = apexpages.currentpage().getparameters().get('searchAlphabet');
        System.debug('=======alpha========' + alphabet);
        alphaFlag = true;
        getlistContact();
       // searchAplha = get listContact;
       // return searchAplha;
    }
    
    /**
     * Remote method to delete contact records
     */
    @RemoteAction // Annotation
    global static void contactToDelete(Id Contact_Id) {
        System.debug('====contact id======' + Contact_Id);
        //Contact contactInstance = new Contact();
        List<Contact> listContact = [SELECT ID 
                                     FROM Contact 
                                     WHERE Id = :Contact_Id
                                    ];
        delete listContact;
        List<Contact> newListContact = [SELECT ID 
                                     FROM Contact
                                     ];
       // return contactToDelete;
    } // End of remote method
} // End of class