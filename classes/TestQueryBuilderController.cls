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
        List<SelectOption> testlistobject = new List<SelectOption>();
        test.startTest(); // Start test
        testlistobject = objQueryBuilderController.getallObjectName();
        test.stopTest(); // Stop test
        System.assertEquals(339,testlistobject.size());
    }
    
    /**
     *  Method to test not displaying all objects from org.(remian to test again)
     */
    static testMethod void testNotAllObject() {
        // Creating instance of class
        QueryBuilderController objQueryBuilderController = new QueryBuilderController();
        List<SelectOption> testlistobject = new List<SelectOption>();
        test.startTest(); // Start test
        testlistobject = objQueryBuilderController.getallObjectName();
        test.stopTest(); // Stop test
        System.assertEquals(339,testlistobject.size());
    }
    
    
    /**
     *  Method to test displaying selected object fields from org.
     */
    static testMethod void testFieldsOfObject() {
        // Creating instance of class
        QueryBuilderController objQueryBuilderController = new QueryBuilderController();
        test.startTest(); // Start test
        objQueryBuilderController.objectName = 'Account';
        //change this
        //List<SelectOption> testlistobject = objQueryBuilderController.getobjectFields();
        test.stopTest(); // Stop test
        //System.assertEquals(68,testlistobject.size());
    }
    
    /**
     *  Method to test radio button showing both values or not
     */
    static testMethod void testRadioButton() {
        // Creating instance of class
        QueryBuilderController objQueryBuilderController = new QueryBuilderController();
        test.startTest(); // Start test
        List<SelectOption> testlistobject = objQueryBuilderController.getradioOptions();
        test.stopTest(); // Stop test
        System.assertEquals(2,testlistobject.size());
    }
    
    /**
     *  Method to test radio button selecting 1 option at a time or not
     */
    static testMethod void testRadioButtonSelection() {
        // Creating instance of class
        QueryBuilderController objQueryBuilderController = new QueryBuilderController();
        test.startTest(); // Start test
        List<SelectOption> testlistobject = objQueryBuilderController.getradioOptions();
        test.stopTest(); // Stop test
        // When page loads it sets default value as Ascending so checking with it
        System.assertEquals('Ascending',objQueryBuilderController.selectedRadio);
    }
    
    /**
     *  Method to test radio button selecting descending opion
     */
    static testMethod void testRadioButtonDescending() {
        // Creating instance of class
        QueryBuilderController objQueryBuilderController = new QueryBuilderController();
        test.startTest(); // Start test
        objQueryBuilderController.selectedRadio='Descending';
        List<SelectOption> testlistobject = objQueryBuilderController.getradioOptions();
        test.stopTest(); // Stop test
        
        //System.assertEquals('Descending',testlistobject.getLabel());
    }
    
    /**
     *  Method to test number of records that query will retrieve
     */
    static testMethod void testNoOfRecords() {
        // Creating instance of class
        QueryBuilderController objQueryBuilderController = new QueryBuilderController();
        test.startTest(); // Start test
        List<SelectOption> testlistobject = objQueryBuilderController.getlistNumber();
        test.stopTest(); // Stop test
        // When page loads it sets default value as 500 so checking with it
        System.assertEquals(500,objQueryBuilderController.selectedNumber);
    }
     
    /**
     *  Method to test if query gives an exception
     */
    static testMethod void testQuery() {
        // Creating instance of classs
        QueryBuilderController objQueryBuilderController = new QueryBuilderController();
        test.startTest(); // Start test
        objQueryBuilderController.selectedRadio = 'Ascending';
        objQueryBuilderController.selectedNumber = 500;
        objQueryBuilderController.objectName = 'Account';
        objQueryBuilderController.displayQuery();
        List<Apexpages.Message> testMessage=Apexpages.getMessages();
        test.stopTest(); // Stop test
        System.assertEquals(1,testMessage.size());
     }
     
     /**
     *  Method to test if required query is generated or not(needs to test one more time)
     */
    static testMethod void testQueryGeneration() {
        // Creating instance of classs
        QueryBuilderController objQueryBuilderController = new QueryBuilderController();
        test.startTest(); // Start test
        objQueryBuilderController.selectedRadio = 'Ascending';
        objQueryBuilderController.selectedNumber = 500;
        objQueryBuilderController.objectName = 'Account';
        //change this also
        //List<SelectOption> testlistobject = objQueryBuilderController.getobjectFields();
        objQueryBuilderController.displayQuery();
        String testQuery='SELECT id,name FROM Account ORDER BY id LIMIT 500';
        test.stopTest(); // Stop test
        System.assertEquals(testQuery,objQueryBuilderController.query);
     }
}