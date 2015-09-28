/**************************************************************************************************
 *  Query Builder : Generate Dynamic SOQL Statement
 *  This is the controller for VF page 
***************************************************************************************************/
public class QueryBuilderController {
    public String objectName {get;set;}
    public List<String> objectFieldName {get;set;}
    public List<SelectOption> selectedObject {get;set;}
    public List<SelectOption> selectedField {get;set;}
    public List<SelectOption> selectedObjectFields {get;set;}
    public String selectedRadio {get;set;}
    public Integer selectedNumber {get;set;}
    public String query {get;set;}
    public String querynew;
    public List<SObject> queryResult {get;set;}
    public List<SelectOption> sortOptions; 
    public List<SelectOption> recordNoOptions;
    public Integer count = 0;     
    public Integer index = 0;
    public Integer blockSize = 100;
    
    /**
     *  This is the constructor for initializing values.
     */
    public QueryBuilderController() {
        selectedRadio = 'Ascending';
        selectedNumber = 500;
        query = '';
        objectFieldName = new List<String>();
    }
    
    /**
     *  This is the method which displays all objects from org.
     */
    public List<SelectOption> getallObjectName() {
        List<Schema.SObjectType> listAllObjects = Schema.getGlobalDescribe().Values();
        System.debug('===listAllObjects====' + listAllObjects);
        List<SelectOption> selectedObject = new List<SelectOption>();
        for (Schema.SObjectType selectedObjectInstance : listAllObjects) {
            selectedObject.add(new SelectOption(selectedObjectInstance.getDescribe().getName(),
                                                selectedObjectInstance.getDescribe().getLabel()
                               )
            );
        } // End of for loop
        selectedObject.sort();
        System.debug('===selectedObject====' + selectedObject);
        System.debug('===objectName====' + objectName);
        return selectedObject;
    }
    
    /**
     *  This is the method which displays the fields of selected object.
     */
    public void getobjectFieldsName() {
        Map<String, Schema.SObjectType> allObjectMap = Schema.getGlobalDescribe();
        System.debug('===objectName====' + objectName);
        Schema.SObjectType objectSchema = allObjectMap.get(objectName);
        Map<String, Schema.SObjectField> fieldMap = objectSchema.getDescribe().fields.getMap();
        selectedField = new List<SelectOption>();
        for (String fieldName : fieldMap.keySet()) {  
            selectedField.add(new SelectOption(fieldName,fieldName));
        }
        selectedField.sort();
        System.debug('===selectedField====' + selectedField);
        //return selectedField;
    }
    
    /**
     *  This is the method which displays radio buttons for type of sort should perform.
     */
    public List<SelectOption> getradioOptions() {
        sortOptions = new List<SelectOption>();
        sortOptions.add(new SelectOption('Ascending','Ascending'));
        sortOptions.add(new SelectOption('Descending','Descending'));
        return sortOptions;
    }
    
    /**
     *  This is the method which displays picklist for number of records to display.
     */
    public List<SelectOption> getlistNumber() {
        recordNoOptions = new List<SelectOption>();
        recordNoOptions.add(new SelectOption('500','500'));
        recordNoOptions.add(new SelectOption('1000','1000'));
        recordNoOptions.add(new SelectOption('5000','5000'));
        recordNoOptions.add(new SelectOption('50000','50000'));
        return recordNoOptions;
    } // End of method
    
    /**
     *  This is the method which displays resultant query and and query result as well.
     */
    public void displayQuery() {
        querynew = 'SELECT COUNT() FROM ' + objectName;
        count = database.countQuery(querynew);
        System.debug('========count of records============' + count);
        if (selectedRadio == 'Ascending') {
            selectedRadio =' ASC ';
        } else {
            selectedRadio = ' DESC ';
        } // End of else block
        try{
            query = 'SELECT' + objectFieldName + 'FROM ' + objectName + ' ORDER BY ' + 
                    objectFieldName[0] + selectedRadio + ' LIMIT ' + blockSize +' OFFSET '+ index;
            /* query = 'SELECT' + objectFieldName + 'FROM ' + objectName + ' ORDER BY ' + 
                               objectFieldName[0] + selectedRadio + ' LIMIT ' + selectedNumber;*/
            System.debug('queryold===============' + query);
            query = query.replace('(',' ');
            query = query.replace(')',' ');
            System.debug('queryfinal===============' + query);
            queryResult = Database.query(query);
            System.debug('queryResult ===============' + queryResult);
        } catch (Exception error) {
            System.debug('Error Message in query');
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,
                                 'Error occured, You should select 1 object and atleast 1 Field')
            );
        } // End of catch block
    } // End of method
    
    /**
     *  This is the method which displays records from begining
     */
    public void beginning() {
        index = 0;
        System.debug('========In Begining===========');
        displayQuery();
    } // End of method
    
    /**
     *  This is the method which displays previous records 
     */
    public void previous() {
        if ( blockSize < index) {
            index = index - blockSize;
            System.debug('========In previsous===========');
            displayQuery();
        } // End of if 
    } // End of method
    
    /**
     *  This is the method which displays next records 
     */
    public void next() {
        if ( index < selectedNumber) {
            index = index + blockSize;
            System.debug('========In next===========');
            displayQuery();
        } // End of if 
    } // End of method
    
    /**
     *  This is the method which displays records from ending
     */
    public void end() {
        index = selectedNumber - blockSize;
        System.debug('========In end===========');
        displayQuery();
    } // End of method           
} // End of class