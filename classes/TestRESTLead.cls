/**************************************************************************************************
 *  This is test class for Apex REST Service that will help external systems to manipulate Leads 
 *  within Salesforce that provide the following capabilities
 *  1. Insert Lead
 *  2. Delete Lead
 *  3. Update Lead
 *  Depending on operations it will send a reponse 
***************************************************************************************************/
@isTest // Annotation
private class TestRESTLead {
    
    static testMethod void testInsertLead() {
        RESTLead.ResponseHandler objResponseHandler = new RESTLead.ResponseHandler();
        objResponseHandler = RESTLead.createNewLead('Test', 
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
    
    static testMethod void testInsertLeadFails() {
        RESTLead.ResponseHandler objResponseHandler = new RESTLead.ResponseHandler();
        objResponseHandler = RESTLead.createNewLead('Test', 
                                                    'TestSoap', 
                                                    'testtest.com',
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
                                AND Email = 'testtest.com'
                                AND Phone = '0987654321'
                                AND Company = 'SOAP'
                                AND Status = 'Closed Won'
                                ];
        Test.stopTest();
        System.assertEquals(0,leadList.size()); // Check for result
        //System.assertNotEquals(0,leadList.size()); // Check for result
    } 
    
    static testMethod void testUpdateLead() {
        RESTLead.ResponseHandler objResponseHandler = new RESTLead.ResponseHandler();
        objResponseHandler = RESTLead.createNewLead('Test', 
                                                    'TestSoap', 
                                                    'test@test.com',
                                                    '0987654321',
                                                    'SOAP',
                                                    'Closed Won'
                                                   );
        objResponseHandler = RESTLead.updateLead('Test', 
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
        RESTLead.ResponseHandler objResponseHandler = new RESTLead.ResponseHandler();
        /*objResponseHandler = RESTLead.createNewLead('Test', 
                                                    'TestSoap', 
                                                    'test@test.com',
                                                    '0987654321',
                                                    'SOAP',
                                                    'Closed Won'
                                                   );*/
        objResponseHandler = RESTLead.updateLead('Test', 
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
        RESTLead.ResponseHandler objResponseHandler = new RESTLead.ResponseHandler();
        /*objResponseHandler = RESTLead.createNewLead('Test', 
                                                    'TestSoap', 
                                                    'test@test.com',
                                                    '0987654321',
                                                    'SOAP',
                                                    'Closed Won'
                                                   );*/
        RestContext.request = new RestRequest();
        String firstName = RestContext.request.params.put('firstName','Test');
        String lastName = RestContext.request.params.put('lastName','TestSoap');
        String email = RestContext.request.params.put('email','test@test.com');
        String phone = RestContext.request.params.put('phone','0987654321');
        objResponseHandler = RESTLead.deleteLead();
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
        //delete leadList;
        Test.stopTest();
        System.assertEquals(0,leadList.size()); // Check for result
        //System.assertNotEquals(1,leadList.size()); // Check for result
    }
    
    static testMethod void testDeleteLeadFails() {
        RESTLead.ResponseHandler objResponseHandler = new RESTLead.ResponseHandler();
        objResponseHandler = RESTLead.createNewLead('Test', 
                                                    'TestSoap', 
                                                    'test@test.com',
                                                    '0987654321',
                                                    'SOAP',
                                                    'Closed Won'
                                                   );
        RestContext.request = new RestRequest();
        String firstName = RestContext.request.params.put('firstName','Testing');
        String lastName = RestContext.request.params.put('lastName','TestSoap');
        String email = RestContext.request.params.put('email','test@test.com');
        String phone = RestContext.request.params.put('phone','0987654321');
        objResponseHandler = RESTLead.deleteLead();
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
        //delete leadList;
        Test.stopTest();
        System.assertEquals(1,leadList.size()); // Check for result
        //System.assertNotEquals(1,leadList.size()); // Check for result
    }
}