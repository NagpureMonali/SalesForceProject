/**************************************************************************************
*  test class for TriggerHandler to Updating Cases that come in from the Web, Email or Chat
*  Use Case – we would like to use the email address of the incoming case to see if we can 
*  associate the correct person account to populate the Account. When a new case is created 
*  and the Case.Origin field is set to “Chat” or “Email” or “Web” take 
*  the Case.SuppliedEmail field and look up to find a match in the following account fields 
*  Account.PersonEmail, Account.Email_Address__c
****************************************************************************************/
@isTest // Annotation
private class TestUpdateCaseHandler {
    /**
    *  Method to test when a new case is created and the Case.Origin field is set to “Chat” 
    *  or “Email” or “Web” take the Case.SuppliedEmail field and look up to find a match in 
    *  the following account fields Account.PersonEmail, Account.Email_Address__c
    */
    static testMethod void testUpdateCase() {
        Account testAccount=new Account();
        testAccount.Name='Test Name';
        testAccount.PersonEmail__c='test@test.com';
        testAccount.Email_Address__c='test@test.com';
        Test.StartTest(); //Start test
        insert testAccount;
        List<Case> listCase = new List<Case>();
        Case newCase=new Case();
        for(Integer i=0;i<5;i++)
        {
        newCase.Origin='Web';
        newCase.Status='Working';
        newCase.SuppliedEmail__c='test@test.com';
        newCase.AccountId=testAccount.Id;
        listCase.add(newCase);
        }
        insert listCase;
        UpdateCaseHandler objUpdateCaseHandler=new UpdateCaseHandler();
        List<Case> listCaseInstance = new List<Case>();
        listCaseInstance=objUpdateCaseHandler.caseToUpdate(listCase);
        Test.stopTest(); // End test
       // for(Case caseInstance : listCase) {
       // system.assertequals(caseInstance.AccountId,listCaseInstance.AccountId);
       // }
       // list<Case> listCase=[SELECT AccountId FROM Case WHERE SuppliedEmail__c='test@test.com'];
       // for(Case caseInstance :listCase) {
       // system.assertequals(testAccount.Id,caseInstance.AccountId,'Matching account ID and Contact Lookup Id');
      //  } // End of for loop
    } // End of method
} // End of test class