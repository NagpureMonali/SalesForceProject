/***********************************************************************************
 *  Class for aggregate funnctions which performs different aggregate functions as
 *  1. To find sum of all closed Opportunity amount for current fiscal year
 *  2. To get distinct Lead Records
 *  3. To get Lead records by LeadSorce by status
 **************************************************************************************/
public with sharing class AggregateFunctions { 
    /**
     *  Write a SOQL query to retrieve sum of all closed Opportunity amount for current fiscal year.
     *  Store this information in a map with key as year and value as sum of amount. Iterate this 
     *  map to display statistics.
     */
    public map<Integer,Double> opportunityRecords() { 
        List<AggregateResult> aggregateResult = [SELECT SUM(Amount), 
                                                        CloseDate
                                                 FROM Opportunity 
                                                 WHERE CloseDate = THIS_FISCAL_YEAR 
                                                 AND Status__c = 'Closed' 
                                                 GROUP BY CloseDate 
                                                ]; // Query to find sum of amount in opportunity
        //Map of opportunity
        Map<Integer,Double> mapOpportunity  =  new Map<Integer,Double>(); 
        for(AggregateResult aggregateResultInstance : aggregateResult) {
            // Get closedate and sum of amount and store it into a map
            Date d = Date.valueOf(aggregateResultInstance.get('CloseDate'));
            Integer year = d.year();
            Double amount = Double.valueOf(aggregateResultInstance.get('expr0'));
            mapOpportunity.put(year,amount); // Put values of year and amount into map
        } // End of for loop
        System.debug('>>>>' + mapOpportunity + '<<<<'); // Print the result  
        return mapOpportunity;
    } // End of method  opportunityRecords
     
    /**
     *  Find total number of distinct Lead records on basis of 'Lead Source'
     *  having greater than 10 leads. Print this information.
     */
    public List<AggregateResult> leadRecords() {
        List<AggregateResult> aggregateResult = [SELECT count_distinct(Name),
                                                        LeadSource 
                                                 FROM Lead 
                                                 GROUP BY LeadSource
                                                 HAVING count_distinct(Name)>10 
                                                 ]; // Query to find distinct leadsource
        for(AggregateResult aggregateResultInstance : aggregateResult) {
            System.debug(aggregateResultInstance); // Print the result
        }
        return aggregateResult;
    } // End of method leadRecords
    
    /**
     *  Write a SOQL query to find total number of Lead records by status by Lead Source. 
     *  Store this information in map and display the same. (Hint: map<string,map<string,integer>>)
     */ 
    public Map<String, Map<String, Integer>> leadRecordByStatus() {
        Integer count = 0;
        Map<string,integer> mapLead = new Map<string,integer>();
        Map<string, Map<string,integer>> mapLeadFull = new Map<string, Map<string,integer> >();
        List<AggregateResult> aggregateResult = [SELECT COUNT(Id), 
                                                        LeadSource,
                                                        Status 
                                                 FROM Lead
                                                 GROUP BY Status,LeadSource
                                                 ];
        for(AggregateResult leadResult : aggregateResult) {
            count++;
            //System.debug('>>>Instance of aggregateResult: ' + aggregateResultInstance);
            //System.debug('<<<count: ' + count);
            Integer i = Integer.valueof(leadResult.get('expr0'));
            //System.debug('>>>' + i + '<<<');
            String l = String.valueof(leadResult.get('LeadSource'));
            //System.debug('>>>' + l + '<<<');               
            mapLead.put(l,i);
            System.debug('>>>' + mapLead + '<<<');
            //for(AggregateResult statusResult : aggregateResult) {
                String s = String.valueof(leadResult.get('Status'));
                //System.debug('>>>' + s +'<<<');
                mapLeadFull.put(s,mapLead);
                System.debug('>>>final map in for loop: ' + mapLeadFull + '<<<');
            //} // End of for loop
         } // End of for loop
       System.debug('Final Map: ' + mapLeadFull + '<<<');
       return mapLeadFull;
    } // End of method  leadRecordByStatus
} // End of class AggregateFunctions