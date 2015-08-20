public with sharing class RemovalOfDuplicateRecordsController {
    public String selectCriteria {get;set;}
    public String criteria;
    public String objectField {get;set;} 
    
    public RemovalOfDuplicateRecordsController() {
        criteria = 'Email';
        System.debug('=====on page load Criteria======' + criteria);
        System.debug('=====on page load selectCriteria======' + selectCriteria);
    }
    /**
     *  This is the method which displays fields for selecting criteria
     */
    public List<SelectOption> getfieldSelectionCriteria() {
        List<SelectOption> selectionCriteria = new List<SelectOption>();
        selectionCriteria.add(new SelectOption('Email','Email'));
        selectionCriteria.add(new SelectOption('MobilePhone','MobilePhone'));
        selectionCriteria.add(new SelectOption('Phone','Phone'));
        System.debug('=====selectCriteria======' + selectCriteria);
        return selectionCriteria;
    }
    
    public void objectField() {
        System.debug('=====in other method selectCriteria======' + selectCriteria);
        criteria = selectCriteria;
        System.debug('=====in other methods Criteria======' + criteria);
        RemovalOfDuplicateLeadsBatchJob obj=new RemovalOfDuplicateLeadsBatchJob(criteria); 
        database.executeBatch(obj,8); 
    }
}