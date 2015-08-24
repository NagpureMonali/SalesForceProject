/**************************************************************************************************
 *  This is test class for Apex SOAP Service that will help external systems to manipulate Leads 
 *  within Salesforce that provide the following capabilities
 *  1. Insert Lead
 *  2. Delete Lead
 *  3. Update Lead
 *  Depending on operations it will send a reponse 
***************************************************************************************************/
@isTest // Annotation
private class TestSOAPLeadWebservice {
    
    static testMethod void testInsertLead() {
        SOAPLeadWebservice.ResponseHandler objResponseHandler = new SOAPLeadWebservice.ResponseHandler();
        objResponseHandler = SOAPLeadWebservice.createNewLead('Test', 
                                                    'TestSoap', 
                                                    'test@test.com',
                                                    '0987654321',
                                                    'SOAP',
                                                    'Closed Won'
                                                    );
        Test.startTest();
        List<Lead> leadList= [SELECT Id, 
                                       FirstName, 
                                       LastName,
                                       Name, 
                                       Email, 
                                       Phone 
                                FROM Lead 
                                WHERE FirstName = 'Test'
                                AND LastName = 'TestSoap'
                                AND Email = 'test@test.com'
                                AND Phone = '0987654321'
                                AND Company = 'SOAP'
                                AND Status = 'Closed Won'
                                ];
        Test.stopTest();
        System.assertEquals(1,leadList.size()); // Check for result
        //System.assertNotEquals(0,leadList.size()); // Check for result
    } 
    
    static testMethod void testLeadNotInsterted() {
        SOAPLeadWebservice.ResponseHandler objResponseHandler = new SOAPLeadWebservice.ResponseHandler();
        objResponseHandler = SOAPLeadWebservice.createNewLead('Test', 
                                                    'TestSoap', 
                                                    'testtest.com',
                                                    '0987654321',
                                                    'SOAP',
                                                    'open'
                                                    );
        Test.startTest();
        List<Lead> leadList= [SELECT Id, 
                                       FirstName, 
                                       LastName,
                                       Name, 
                                       Email, 
                                       Phone 
                                FROM Lead 
                                WHERE FirstName = 'Test'
                                AND LastName = 'TestSoap'
                                AND Email = 'testtest.com'
                                AND Phone = '0987654321'
                                AND Company = 'SOAP'
                                AND Status = 'open'
                                ];
        Test.stopTest();
        System.assertEquals(0,leadList.size()); // Check for result
        //System.assertNotEquals(0,leadList.size()); // Check for result
    }
    
    static testMethod void testUpdateLead() {
        SOAPLeadWebservice.ResponseHandler objResponseHandler = new SOAPLeadWebservice.ResponseHandler();
        objResponseHandler = SOAPLeadWebservice.createNewLead('Test', 
                                                    'TestSoap', 
                                                    'test@test.com',
                                                    '0987654321',
                                                    'SOAP',
                                                    'Closed Won'
                                                   );
        objResponseHandler = SOAPLeadWebservice.updateLead('Test', 
                                                 'TestSoap', 
                                                 'testing@test.com',
                                                 '54321'
                                                );
        Test.startTest();
        List<Lead> leadList= [SELECT Id, 
                                       FirstName, 
                                       LastName,
                                       Name, 
                                       Email, 
                                       Phone 
                                FROM Lead 
                                WHERE FirstName = 'Test'
                                AND LastName = 'TestSoap'
                                AND Email = 'testing@test.com'
                                AND Phone = '54321'
                                AND Company = 'SOAP'
                                AND Status = 'Closed Won'
                                ];
        Test.stopTest();
        System.assertEquals(1,leadList.size()); // Check for result
        //System.assertNotEquals(0,leadList.size()); // Check for result
    }
    
    static testMethod void testUpdateLeadFails() {
        SOAPLeadWebservice.ResponseHandler objResponseHandler = new SOAPLeadWebservice.ResponseHandler();
        objResponseHandler = SOAPLeadWebservice.createNewLead('Test', 
                                                    'TestSoap', 
                                                    'test@test.com',
                                                    '0987654321',
                                                    'SOAP',
                                                    'Closed Won'
                                                   );
        objResponseHandler = SOAPLeadWebservice.updateLead('Testing', 
                                                 'TestSoap', 
                                                 'testing@test.com',
                                                 '54321'
                                                );
        Test.startTest();
        List<Lead> leadList= [SELECT Id, 
                                       FirstName, 
                                       LastName,
                                       Name, 
                                       Email, 
                                       Phone 
                                FROM Lead 
                                WHERE FirstName = 'Test'
                                AND LastName = 'TestSoap'
                                AND Email = 'testing@test.com'
                                AND Phone = '54321'
                                AND Company = 'SOAP'
                                AND Status = 'Closed Won'
                                ];
        Test.stopTest();
        System.assertEquals(0,leadList.size()); // Check for result
        //System.assertNotEquals(0,leadList.size()); // Check for result
    }
    
    static testMethod void testDeleteLead() {
        SOAPLeadWebservice.ResponseHandler objResponseHandler = new SOAPLeadWebservice.ResponseHandler();
        objResponseHandler = SOAPLeadWebservice.createNewLead('Test', 
                                                    'TestSoap', 
                                                    'test@test.com',
                                                    '0987654321',
                                                    'SOAP',
                                                    'Closed Won'
                                                   );
        objResponseHandler = SOAPLeadWebservice.deleteLead('Test', 
                                                           'TestSoap', 
                                                           'test@test.com',
                                                           '0987654321'
                                                           );
        Test.startTest();
        List<Lead> leadList= [SELECT Id, 
                                       FirstName, 
                                       LastName,
                                       Name, 
                                       Email, 
                                       Phone 
                                FROM Lead 
                                WHERE FirstName = 'Test'
                                AND LastName = 'TestSoap'
                                AND Email = 'test@test.com'
                                AND Phone = '0987654321'
                                ];
        delete leadList;
        Test.stopTest();
        System.assertEquals(0,leadList.size()); // Check for result
        //System.assertNotEquals(1,leadList.size()); // Check for result
    }
    
    static testMethod void testDeleteLeadFails() {
        SOAPLeadWebservice.ResponseHandler objResponseHandler = new SOAPLeadWebservice.ResponseHandler();
        /*objResponseHandler = SOAPLeadWebservice.createNewLead('Test', 
                                                    'TestSoap', 
                                                    'test@test.com',
                                                    '0987654321',
                                                    'SOAP',
                                                    'Closed Won'
                                                   );*/
        objResponseHandler = SOAPLeadWebservice.deleteLead('Test', 
                                                           'TestSoap', 
                                                           'test@test.com',
                                                           '0987654321'
                                                           );
        Test.startTest();
        List<Lead> leadList= [SELECT Id, 
                                       FirstName, 
                                       LastName,
                                       Name, 
                                       Email, 
                                       Phone 
                                FROM Lead 
                                WHERE FirstName = 'Test'
                                AND LastName = 'TestSoap'
                                AND Email = 'test@test.com'
                                AND Phone = '0987654321'
                                ];
        delete leadList;
        Test.stopTest();
        //System.assertEquals(0,leadList.size()); // Check for result
        System.assertNotEquals(1,leadList.size()); // Check for result
    }
}