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
                                                 WHERE CloseDate  =  THIS_FISCAL_YEAR 
                                                 AND Status__c = 'Closed' 
                                                 GROUP BY CloseDate 
                                                ]; // Query to find sum of amount in opportunity
        //Map of opportunity
        Map<Integer,Double> mapOpportunity  =  new Map<Integer,Double>(); 
        for(AggregateResult aggregateResultInstance : aggregateResult) {
            // Get closedate and sum of amount and store it into a map
            Date d = Date.valueOf(aggregateResultInstance.get('CloseDate'));
            Integer year = d.year();
            Double amount  =  Double.valueOf(aggregateResultInstance.get('expr0'));
            mapOpportunity.put(year,amount); // Put values of year and amount into map
        } // End of for loop
        System.debug('>>>>'+mapOpportunity+'<<<<'); // Print the result  
        return mapOpportunity;
     } // End of method  opportunityRecords
     
    /**
     *  Find total number of distinct Lead records on basis of 'Lead Source'
     *  having greater than 10 leads. Print this information.
     */
    public List<AggregateResult> leadRecords() {
        List<AggregateResult> aggregateResult  =  [SELECT count_distinct(Name),
                                                          LeadSource 
                                                   FROM Lead 
                                                   GROUP BY LeadSource
                                                   HAVING count_distinct(Name)>10 
                                                  ]; // Query to find distinct leadsource
        for(AggregateResult aggregateResultInstance:aggregateResult) {
            System.debug(aggregateResultInstance); // Print the result
        }
        return aggregateResult;
    } // End of method leadRecords
    
    /**
     *  Write a SOQL query to find total number of Lead records by status by Lead Source. 
     *  Store this information in map and display the same. (Hint: map<string,map<string,integer>>)
     */ 
    public Map<String, Map<String, Integer>> leadRecordByStatus() {
        Map<String, Map<String, Integer>> leadStatusMap  =  new Map<String, Map<String, Integer>>();//map of map
        for(AggregateResult resultAggregate : [SELECT COUNT(Name) leadCount,
                                                      Status, 
                                                      LeadSource
                                               FROM Lead
                                               GROUP BY LeadSource, Status
                                               ]) {
            if(!leadStatusMap.containsKey(String.valueOf(resultAggregate.get('status')))) {
                  leadStatusMap.put(String.valueOf(resultAggregate.get('Status')),new Map<String, Integer> {
                        String.valueOf(resultAggregate.get('LeadSource'))  => Integer.valueOf(resultAggregate.get('leadCount'))
                        }
                                    ); // Add existing
             } else {
                    leadStatusMap.get(String.valueOf(resultAggregate.get('Status'))).put(
                    String.valueOf(resultAggregate.get('LeadSource')), Integer.valueOf(resultAggregate.get('leadCount'))
                    );
                    }
                System.debug('--- In for loop : ' + leadStatusMap); //Print the result
            } // End od outter for loop
        System.debug('--- leadStatusMap : ' + leadStatusMap); //Print the result
        return leadStatusMap;
     } // End of method  leadRecordByStatus
} // End of class AggregateFunctions