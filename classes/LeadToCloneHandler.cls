/***************************************************************************
*  This is Handler class for clonelead 
****************************************************************************/
public with sharing class LeadToCloneHandler 
{
    public static boolean flag = true; 
    public static void cloningLead(List<Lead> LeadInstance) 
    {
        /**
        *  Method which will create the clone record.
        *  (Hint : Map trigger.new to clone record)done
        */
        List<Lead> ListLead =new list<Lead>(); // List of lead
        for(Lead LeadI:LeadInstance)
        {
            ListLead.add(LeadI.clone()); // Add values to lead
        }
        if(flag)
        {
            flag=false;
            Insert ListLead ; // Insert lead
            system.debug('-------- Insertion-------'+trigger.new); // Print
        } // End of if
    } // End of method
} // End of class