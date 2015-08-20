/************************************************************************************************
 *  This is the controller for Visual Force page. The page should display two picklists, one for 
 *  Country and another for City. Initially city picklist should not display any value; instead it 
 *  should be dependent upon Country picklist. So when user selects a particular country then City 
 *  picklist should load all the cities corresponding to the selected country.
 **********************************************************************************************/
public with sharing class CountryCityPickListController {
    public String selectCountryOption {get;set;}
    public String selectCityOption {get;set;}
    public List<SelectOption> cityList {get;set;}
    public List<SelectOption> countryList {get;set;}
    Map<String,List<String>> mapCountryCity;
    /**
     *  Here is a counstructor which calls method countryPicklist. 
     *  that will Add the values Before the page is loaded.
     */
    public CountryCityPickListController() {
        countryListPicklist();
        cityList = new  List<SelectOption>();
        mapCountryCity = new Map<String,List<String>>();
        for (City__c cityInstance : City__c.getAll().values()) {
            if (!mapCountryCity.containsKey(cityInstance.Country__c)) {
                mapCountryCity.put(cityInstance.Country__c,new List<String>{cityInstance.Name});
            } else {
                List<String> testCityList = mapCountryCity.get(cityInstance.Country__c);
                testCityList.add(cityInstance.Name);
                mapCountryCity.put(cityInstance.Country__c,testCityList);
            }
        }
        System.debug('==mapCountryCity===' + mapCountryCity);
    }
    
    /**
     *  Here is a Method that will Add values of the picklist.
     */
    public List<SelectOption> countryListPicklist() {
        countryList = new List<selectOption>();
        for (Country__c countryListInstance : Country__c.getAll().values()) {
            countryList .add(new SelectOption(countryListInstance.Name,
                                              countryListInstance.Name));
        } // End of for Loop
        return countryList;
    }
    
    /**
     *  Here is a method that will show city list.
     */
    public void cityChange() { 
        cityList = new  List<SelectOption>();
        List<string> listOfCity = new List<string>(mapCountryCity.get(selectCountryOption)); 
        for(string cityInstance :listOfCity){     
            cityList.add(new SelectOption(cityInstance, cityInstance));
        } // End of for loop
    } // End of method
} // End of controller