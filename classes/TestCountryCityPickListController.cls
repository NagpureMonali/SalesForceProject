/**
 *  This is test class for testing CountryCityPickListController
 */
@isTest  // Annotation
private class TestCountryCityPickListController {
    public static List<City__c> testCityList = new List<City__c>();
    
    /**
     *  Factory method to insert country and city
     */
    static void insertCountryCity() {
        Country__c countryInstance = new Country__c(); 
        countryInstance.Name = 'India';
        City__c cityInstance = new City__c();
        cityInstance.Name = 'Kolkata';
        cityInstance.Country__c = 'India';
        testCityList.add(cityInstance);    
        insert countryInstance;
        insert testCityList;
    }
    
    /**
     *  Method to test City list is now displaying when page is on new loading
     */
    static testMethod void testCityList() {
        CountryCityPickListController objCountryCityPickListController = 
                                      new CountryCityPickListController();
        System.assertEquals(0,objCountryCityPickListController.cityList.size());
    } // End of method
    
    /**
     *  Method to test Country list is displaying all values which it holds
     */
    static testMethod void testCountryList() {
        Test.startTest(); // Start test
        insertCountryCity();
        CountryCityPickListController objCountryCityPickListController = 
                                      new CountryCityPickListController();
        Test.stopTest(); // Stop test
        System.assertEquals(1,objCountryCityPickListController.countryListPicklist().size());
    } // End of method
    
    /**
     *  Method to test displaying all related city
     */
    static testMethod void testDisplayingRelatedCityList() {
        Test.startTest(); // Start test
        insertCountryCity();
        CountryCityPickListController objCountryCityPickListController=
                                      new CountryCityPickListController();
        objCountryCityPickListController.selectCountryOption = 'India';
        Test.stopTest(); // Stop test
        System.assertEquals(testCityList.size(),objCountryCityPickListController.cityList.size());
    }
}