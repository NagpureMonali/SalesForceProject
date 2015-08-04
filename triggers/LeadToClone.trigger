trigger LeadToClone on Lead (after insert) 
{
    /*3.Write a Trigger on  Lead which will create the clone record.
(Hint : Map trigger.new to clone record)*/
    if(trigger.isafter && trigger.isinsert)
    {
        LeadToCloneHandler.cloningLead(trigger.new);
    }
}