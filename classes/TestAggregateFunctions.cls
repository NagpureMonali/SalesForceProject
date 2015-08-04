/**************************************************************************************************
*  This is test class to test aggregate funnctions class which performs diffreent oprations
*  1. To test sum of all closed Opportunity amount for current fiscal year
*  2. To testt distinct Lead Records
*  3. To test Lead records by LeadSorce by status 
***************************************************************************************************/
@isTest // Annotation
private class TestAggregateFunctions  
{
    /**
     *  Test to retrieve sum of all closed Opportunity amount for current fiscal year.
     *  Store this information in a map with key as year and value as sum of amount. Iterate this 
     *  map to display statistics.
     */
    static testMethod void TestOpportunityRecords() {
        Integer i=0;
        List<Opportunity> testListOpportunity = new List<Opportunity>();
        for(i=0;i <= 50; i++) {
            Opportunity testOpportunity = new Opportunity(Name = 'Test'+i,
                                                          CloseDate=System.Today(),
                                                          StageName='Closed Won',
                                                          Amount = 11000);
            testListOpportunity.add(testOpportunity);    
        }
        Test.startTest(); // Start test
        insert testListOpportunity;
        List<AggregateResult> aggregateResult = [SELECT SUM(Amount), 
                                                        CloseDate
                                                 FROM Opportunity 
                                                 WHERE CloseDate  =  THIS_FISCAL_YEAR 
                                                 AND Status__c = 'Closed' 
                                                 GROUP BY CloseDate 
                                                ]; // Query to find sum of amount in opportunity
        Map<Integer,Double> testMapOpportunity  =  new Map <Integer,Double>();
         // Iterate over aggregate result to get values
        for(AggregateResult aggregateResultInstance : aggregateResult)
        {
            // Get closedate and sum of amount and store it into a map
            Date d = Date.valueOf(aggregateResultInstance.get('CloseDate'));
            Integer year = d.year();
            Double amount  =  Double.valueOf(aggregateResultInstance.get('expr0'));
            testMapOpportunity.put(year,amount); // Put values of year and amount into map
        }
        AggregateFunctions objAggregateFunctions = new AggregateFunctions();
        Test.stopTest(); // End test
        System.assertEquals(testMapOpportunity,objAggregateFunctions.opportunityRecords()); 
   } // End Of method
   
   /**
    *  Test to get distinct Lead records on basis of 'Lead Source'
    *  having greater than 10 leads. Print this information.
    */
    static testMethod void TestleadRecords() {
        Integer i=0;
        List<Lead> testListLead = new List<Lead>();
        for(i=0;i <= 50; i++) {
            Lead leadInstance = new Lead(LastName = 'Test'+i, 
                                         Company = 'ESPL', 
                                         LeadSource='Web', 
                                         Status='Closed');
            testListLead.add(leadInstance);    
        }
        Test.startTest(); // Start test
        insert testListLead;
        List<AggregateResult> testResult  =  [SELECT count_distinct(Name),
                                                     LeadSource 
                                              FROM Lead 
                                              GROUP BY LeadSource
                                              HAVING count_distinct(Name)>10 
                                             ]; // List of aggregate result
        AggregateFunctions objAggregateFunctions = new AggregateFunctions();
        Test.stopTest(); // End test
        System.assertEquals(testResult,objAggregateFunctions.leadRecords()); // Check result
    } // End Of method
   
   /**
    *  Test to find total number of Lead records by status by Lead Source. 
    */
    static testMethod void testleadRecordByStatus() {
        Integer i=0;
        List<Lead> testListLead = new List<Lead>();
        for(i=0;i <= 50; i++) {
            Lead leadInstance = new Lead(LastName = 'Test'+i, 
                                         Company = 'ESPL', 
                                         LeadSource='Web', 
                                         Status='Closed');
            testListLead.add(leadInstance);    
        }
        Test.startTest(); // Start test
        insert testListLead;
        Map<String, Map<String, Integer>> testLeadStatusMap  =  new Map<String, Map<String, Integer>>(); 
        for(AggregateResult resultAggregate : [ SELECT COUNT(Name) leadCount,
                                                       Status, 
                                                       LeadSource
                                                FROM Lead
                                                GROUP BY LeadSource, Status
                                               ]) // For loop
            {
                //check if exist status
                if(!testLeadStatusMap.containsKey(String.valueOf(resultAggregate.get('status')))) 
                 {
                    testLeadStatusMap.put(String.valueOf(resultAggregate.get('Status')),
                                          new Map<String, Integer> { 
                    String.valueOf(resultAggregate.get('LeadSource')) => Integer.valueOf(resultAggregate.get('leadCount'))
                             }
                                    );                                   
                                     // Add existing
                 } else {
                    testLeadStatusMap.get(String.valueOf(resultAggregate.get('Status'))).put(
                    String.valueOf(resultAggregate.get('LeadSource')), 
                                   Integer.valueOf(resultAggregate.get('leadCount'))
                    );
                } // End of else
             } // End of for loop
        AggregateFunctions objAggregateFunctions = new AggregateFunctions();
        Test.stopTest(); // End test
        System.assertEquals(testLeadStatusMap,objAggregateFunctions.leadRecordByStatus()); 
    } // End Of method
} // End of test class