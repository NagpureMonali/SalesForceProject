public with sharing class ScheduleClosedWonOpportunity  implements Database.Batchable<sObject> {
    public Database.QueryLocator start(Database.BatchableContext objBatchableContext) {
        return Database.getQueryLocator([SELECT Id, 
                                                Name, 
                                                Amount,
                                                AccountId,
                                                Account.Email_Address__c
                                                //AccountId.Email_Address__c 
                                         FROM Opportunity Instance 
                                         WHERE StageName='Closed Won']); 
    }
    public void execute(Database.BatchableContext objBatchableContext, List<Opportunity> listOpportunity ) {
       // List<Account> listAccount=[SELECT AccountId,Id,Email_Address__c];
        map<String,WrapperScheduleClosedWonOpportunity> mapOpportunity=new map<String,WrapperScheduleClosedWonOpportunity>();
        for(Opportunity instanceOpportinity : listOpportunity) {
            if(!mapOpportunity.containsKey(instanceOpportinity.AccountId)) {
                WrapperScheduleClosedWonOpportunity objWrapper=new WrapperScheduleClosedWonOpportunity();
                objWrapper.opportunityList.add(instanceOpportinity);
                objWrapper.amount=instanceOpportinity.Amount;
                objWrapper.Email=instanceOpportinity.Account.Email_Address__c;
                mapOpportunity.put(instanceOpportinity.AccountId,objWrapper);
            } else {
                WrapperScheduleClosedWonOpportunity objWrapper=new WrapperScheduleClosedWonOpportunity();
                objWrapper.amount += instanceOpportinity.amount;
                objWrapper.Email=instanceOpportinity.Account.Email_Address__c;
                mapOpportunity.put(instanceOpportinity.AccountId,objWrapper);
            }
        }
        System.debug('=====Map===' + mapOpportunity);
    }
    public void finish(Database.BatchableContext objBatchableContext) {
       // System.debug('=====Map===' + mapOpportunity);
        //System.debug('=====Map===' + mapOpportunity);
    }
    
    public class WrapperScheduleClosedWonOpportunity {
        List<Opportunity> opportunityList=new List<Opportunity>();
        Decimal amount;
        String Email;
    }
}