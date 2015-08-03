@isTest // Annotation
public class TestLeadToCloneHandler // test class to test clone record
{
	static testMethod void testLeadClone() //Test if clone record is created or not
	 {
        Lead leadObj = new Lead();
        leadObj.LastName = 'Test Name';
        leadObj.Company = 'Test Company';
        leadObj.Status = 'Open - Not Contacted';     
        Test.startTest(); // Start Test
        insert leadObj;
        Test.stopTest(); // End Tests
        List<Lead> listOfLead = [SELECT ID FROM Lead WHERE LastName = 'Test Name'];
        System.assertEquals(2,listOfLead.size()); // Check for result
    } // End of method
} // End of test class