/**
 *  This is test class for testing CountryCityPickListController
 */
@isTest  // Annotation
private class TestCountryCityPickListController {
    /**
     *  Method to test City list is now displaying when page is on new loading
     */
    static testMethod void testCityList() {
        CountryCityPickListController objCountryCityPickListController = 
                                      new CountryCityPickListController();
        System.assertEquals(0,objCountryCityPickListController.cityChange().size());
    }
    
    /**
     *  Method to test Country list is displaying all values which it holds
     */
    static testMethod void testCountryList() {
        Country__c countryInstance = new Country__c(); 
        countryInstance.Name = 'India';
        Test.startTest();
        insert countryInstance;
        CountryCityPickListController objCountryCityPickListController = 
                                      new CountryCityPickListController();
        Test.stopTest();
        System.assertEquals(1,objCountryCityPickListController.countryListPicklist().size());
    }
    
    /**
     *  Method to test displaying all related city
     */
    static testMethod void testDisplayingRelatedCityList() {
        Country__c countryInstance = new Country__c(); 
        countryInstance.Name = 'India';
        List<City__c> cityList = new List<City__c>();
        City__c cityInstance = new City__c();
        cityInstance.Name = 'Kolkata';
        cityInstance.Country__c = 'India';
        cityList.add(cityInstance);    
        Test.startTest();
        insert countryInstance;
        insert cityList;
        CountryCityPickListController objCountryCityPickListController=
                                      new CountryCityPickListController();
        objCountryCityPickListController.selectCountryOption = 'India';
        Test.stopTest();
        System.assertEquals(cityList.size(),objCountryCityPickListController.cityChange().size());
    }
}