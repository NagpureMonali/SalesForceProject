/***************************************************************************************************
 *  This is the schedular class for SendResponseBatchJob to send emails  
 **************************************************************************************************/
public with sharing class SendResponseSchedular implements Schedulable {
    /**
     *  Method to execute batch job
     */
    public void  execute(SchedulableContext objSchedulableContext) {
       System.debug('Schedular started.........................');
       System.schedule('Job of email sending' + system.now(),' 0 0 /12 * * ? ',
           new SendResponseSchedular());
       Database.executebatch(new SendResponseBatchJob());
       System.debug('Schedular done.........................');
    } // End of method
} // End of class