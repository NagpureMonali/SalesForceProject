public with sharing class RemovalOfDuplicateRecordsController {
    public String selectCriteria {get;set;}
    public String criteria;
    public String objectField {get;set;} 
    
    public RemovalOfDuplicateRecordsController() {
        //selectCriteria = 'Email';
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
        System.debug('=====on button click selectCriteria======' + selectCriteria);
        criteria = selectCriteria;
        System.debug('=====on button click Criteria======' + criteria);
        LeadName__c LeadNameInstance = new LeadName__c();
        LeadNameInstance = [SELECT Name FROM LeadName__c WHERE Name = 'Test'];
        LeadNameInstance.Criteria__c = selectCriteria;
        update LeadNameInstance;
        System.debug('=====on button click LeadName__cInstance.Criteria__c======' + LeadNameInstance.Criteria__c);
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,
                                 'Criteria field is set to ' + selectCriteria)
                                 );
        //RemovalOfDuplicateLeadsBatchJob obj=new RemovalOfDuplicateLeadsBatchJob(criteria); 
        //database.executeBatch(obj,8); 
    }
}