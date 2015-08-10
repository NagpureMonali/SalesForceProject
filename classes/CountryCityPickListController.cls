/************************************************************************************************
 *  This is the controller for Visual Force page. The page should display two picklists, one for 
 *  Country and another for City. Initially city picklist should not display any value; instead it 
 *  should be dependent upon Country picklist. So when user selects a particular country then City 
 *  picklist should load all the cities corresponding to the selected country.
 **********************************************************************************************/
public with sharing class CountryCityPickListController {
    public String selectCountryOption {get;set;}
    public String selectCityOption {get;set;}
    public List<SelectOption> cityList{get;set;}
    public List<SelectOption> countryList{get;set;}
    
    /**
     *  Here is a counstructor which calls method countryPicklist.
     *  that will Add the values Before the page is loaded.
     */
    public CountryCityPickListController() {
        countryListPicklist();
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
    public List<SelectOption> cityChange() { 
        cityList = new  List<SelectOption>();
        for (City__c cityListInstance :[SELECT Name
                                        FROM  City__c 
                                        WHERE Country__c= :selectCountryOption
                                        ]
            ) {
            cityList.add(new SelectOption(cityListInstance.Name,cityListInstance.Name));
        } // End of for Loop
        return cityList;
    } // End of Method
} // End of controller