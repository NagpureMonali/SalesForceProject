/*************************************************************************************************
 *  This is the test class for QueryBuilderController whihc tests different methods.
 *************************************************************************************************/
@isTest // Annotation
private class TestQueryBuilderController {
    
    /**
     *  Method to test displaying all objects from org.
     */
    static testMethod void testAllObject() {
        // Creating instance of class
        QueryBuilderController objQueryBuilderController = new QueryBuilderController();
        List<Schema.SObjectType> testListOfAllObjects = Schema.getGlobalDescribe().Values();
        Test.startTest(); // Start test
        List<SelectOption> testlistobject = objQueryBuilderController.getallObjectName();
        Test.stopTest(); // Stop test
        System.assertEquals(testListOfAllObjects.size(),testlistobject.size());
    } // End of method
     
    /**
     *  Method to test not displaying objects from org.
     */
    static testMethod void testNotAllObject() {
        // Creating instance of class
        QueryBuilderController objQueryBuilderController = new QueryBuilderController();
        Test.startTest(); // Start test
        List<SelectOption> testlistobject = objQueryBuilderController.getallObjectName();
        Test.stopTest(); // Stop test
        System.assertNotEquals(null,testlistobject.size());
    } // End of method
    
    /**
     *  Method to test displaying selected object fields from org. 
     */
    static testMethod void testFieldsOfObject() {
        // Creating instance of class
        Map<String, Schema.SObjectType> allObjectMap = Schema.getGlobalDescribe();
        QueryBuilderController objQueryBuilderController = new QueryBuilderController();
        Schema.SObjectType testObjectSchema = allObjectMap.get('Account');
        Map<String, Schema.SObjectField> fieldMap = testObjectSchema.getDescribe().fields.getMap();
        List<SelectOption> testSelectedObject = new List<SelectOption>();
        for (String fieldName : fieldMap.keySet()) {  
            testSelectedObject.add(new SelectOption(fieldName,fieldName));
        }
        objQueryBuilderController.objectName = 'Account';
        Test.startTest(); // Start test
        objQueryBuilderController.getobjectFields();
        Test.stopTest(); // Stop test
        System.assertEquals(testSelectedObject.size(),
                            objQueryBuilderController.selectedObject.size()
                           );
    } // End of method
    
    /**
     *  Method to test radio button showing both values or not
     */
    static testMethod void testRadioButton() {
        // Creating instance of class
        QueryBuilderController objQueryBuilderController = new QueryBuilderController();
        Test.startTest(); // Start test
        List<SelectOption> testlistobject = objQueryBuilderController.getradioOptions();
        Test.stopTest(); // Stop test
        System.assertEquals(2,testlistobject.size());
    } // End of method
    
    /**
     *  Method to test radio button selecting 1 option at a time or not
     */
    static testMethod void testRadioButtonSelection() {
        // Creating instance of class
        QueryBuilderController objQueryBuilderController = new QueryBuilderController();
        Test.startTest(); // Start test
        List<SelectOption> testlistobject = objQueryBuilderController.getradioOptions();
        Test.stopTest(); // Stop test
        // When page loads it sets default value as Ascending so checking with it
        System.assertEquals('Ascending',objQueryBuilderController.selectedRadio);
    } // End of method
    
    /**
     *  Method to test number of records that query will retrieve
     */
    static testMethod void testNoOfRecords() {
        // Creating instance of class
        QueryBuilderController objQueryBuilderController = new QueryBuilderController();
        Test.startTest(); // Start test
        List<SelectOption> testlistobject = objQueryBuilderController.getlistNumber();
        Test.stopTest(); // Stop test
        // When page loads it sets default value as 500 so checking with it
        System.assertEquals(500,objQueryBuilderController.selectedNumber);
    } // End of method
     
    /**
     *  Method to test if query gives an exception 
     *  (Here it will give error because i have not passed object fields)
     */
    static testMethod void testQuery() {
        // Creating instance of classs
        QueryBuilderController objQueryBuilderController = new QueryBuilderController();
        objQueryBuilderController.selectedRadio = 'Ascending';
        objQueryBuilderController.selectedNumber = 500;
        objQueryBuilderController.objectName = 'Account';
        Test.startTest(); // Start test
        objQueryBuilderController.displayQuery();
        List<Apexpages.Message> testMessage = Apexpages.getMessages();
        Test.stopTest(); // Stop test
        System.assertEquals(1,testMessage.size());
     } // End of method
     
     /**
     *  Method to test if required query is generated or not
     */
    static testMethod void testQueryGeneration() {
        // Creating instance of classs 
        QueryBuilderController objQueryBuilderController = new QueryBuilderController();
        String testQuery ='SELECT id, name FROM Account ORDER BY id DESC  LIMIT 500';
        objQueryBuilderController.selectedRadio = 'Descending';
        objQueryBuilderController.selectedNumber = 500;
        objQueryBuilderController.objectName = 'Account';
        objQueryBuilderController.objectFieldName.add('id');
        objQueryBuilderController.objectFieldName.add('name');
        Test.startTest(); // Start test
        objQueryBuilderController.displayQuery();
        Test.stopTest(); // Stop test
        System.assertEquals(testQuery,objQueryBuilderController.query);
        System.assertNotEquals(null,objQueryBuilderController.query);
     } // End of method
      
     /**
     *  Method to test if required query giving correct result or not
     */
    static testMethod void testQueryResult() {
        // Creating instance of classs  
        QueryBuilderController objQueryBuilderController = new QueryBuilderController();
        objQueryBuilderController.selectedRadio = 'Descending';
        objQueryBuilderController.selectedNumber = 500;
        objQueryBuilderController.objectName = 'Account';
        objQueryBuilderController.objectFieldName.add('id');
        objQueryBuilderController.objectFieldName.add('name');
        Test.startTest(); // Start test
        List<Account> testAccountList = [SELECT id, name FROM Account ORDER BY id DESC LIMIT 500];
        objQueryBuilderController.displayQuery();
        Test.stopTest(); // Stop test
        System.assertEquals(testAccountList.size(),objQueryBuilderController.queryResult.size());
     } // End of method
} // End of test class