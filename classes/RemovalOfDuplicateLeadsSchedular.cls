/*global with sharing class RemovalOfDuplicateLeadsSchedular implements Schedulable {
    public static string cron = '0 0 /3  * ?'; //after every 3 hours in a day.
       public void execute(SchedulableContext sc)
       {
            Database.executeBatch(new RemovalOfDuplicateLeadsBatchJob());
           // Database.executeBatch(leadInstance,5);
       }
}
*/
global with sharing class RemovalOfDuplicateLeadsSchedular implements Schedulable{
   // public static string cron = '0 0 /3    ?'; //after every 3 hours in a day.
    global void  execute(SchedulableContext sc) {
       System.debug('Schedular started.........................');
       System.schedule('JobOfLead'+system.now(),' 0 0 /3     ? ',new RemovalOfDuplicateLeadsSchedular());
       Database.executebatch(new RemovalOfDuplicateLeadsBatchJob());
       System.debug('Schedular done.........................');
    }
}