public with sharing class ControllerAccountContact {
    public List<Account> listAccount {get; set;}
    public Id idOfAccount {get; set;}
    public String contactPhone {get; set;}
    public String contactName {get; set;}
    /**
     *  Method to get list of Accounts
     */
    public List<Account> getListOfAllAccount() { 
        listAccount = [SELECT Id,
                              Name,
                              Phone,
                              Website
                       FROM Account
                      ]; // Query to fetch account records
        System.debug('-----Account List   -----' + listAccount);
        return listAccount;
    } // End of method 
     
    /*
     *  Method to redirect from Account page to Contact page
     */
    public PageReference getredirectToContactPage() {
        idOfAccount = apexpages.currentpage().getparameters().get('accountId');
        System.debug('--------Accountid :-----------' + idOfAccount);
        PageReference contactPage = Page.AddNewContact; 
        contactPage.getparameters().put('accountId',idOfAccount);
        contactPage.setRedirect(false);
        System.debug('--------Accountid 0000000:-----------' + idOfAccount);
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
        
        PageReference contactPage = getredirectToContactPage();
        contactPage.getparameters().put('accountId',idOfAccount);
        return contactPage;
    } // End of method
} // End of class