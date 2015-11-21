/**
 *  Here is schedular for closed won opportunity records 
 */
global without sharing class ClosedWonOpportunitySchedular implements Schedulable {
    
    global void  execute(SchedulableContext sc) {
       System.debug('Schedular started.........................');
       System.schedule('Job'+system.now(),' 0 0 /24 * * ? ',new ClosedWonOpportunitySchedular());
       Database.executebatch(new RemovalOfDuplicateLeadsBatchJob());
       System.debug('Schedular done.........................');
    } // End of method 
} // End of class