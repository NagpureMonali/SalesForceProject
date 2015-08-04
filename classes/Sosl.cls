/*******************************************************************************
*  It is class to Find the word 'test' in all name fields returning Contact, 
*  Account, Lead and User.
*********************************************************************************/
public with sharing class Sosl {
    /**
     *  Method to Find the word 'test' in all name fields returning Contact, 
     *  Account, Lead and User
     */
    public List<List<SObject>> allFields() {
        List<List<SObject>> searchList = [FIND 'test*' 
                                          IN Name 
                                          FIELDS RETURNING Contact(Id,Name), 
                                                           Account(Id,Name), 
                                                           Lead(Id,Name), 
                                                           User(Id,Name)
                                          ];
        System.debug('Records:'+searchList+'<<<<'); // Print
        return searchList;
    } // End of method
} // End of Class