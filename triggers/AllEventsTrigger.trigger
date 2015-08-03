trigger AllEventsTrigger on Account (after delete, after insert, after undelete, 
after update, before delete, before insert, before update) 
{
/*2.System.debug the following statements for all events (Before & After)
a)Trigger.New b) Trigger.Old c)Trigger.NewMap d)Trigger.oldMap*/
	if(trigger.isUpdate)//before update record
	{
		if(trigger.isBefore)
		{
			system.debug('----(update before)This is trigger.newmap----'+trigger.newmap);
			system.debug('----(update before)This is trigger.oldmap----'+trigger.oldmap);
		}
		else if(trigger.isafter)
		{
			system.debug('----(update after)This is trigger.newmap----'+trigger.newmap);
			system.debug('----(update after)This is trigger.oldmap----'+trigger.oldmap);
		}
	}
	if(trigger.isInsert)//before Insert record
	{
		if(trigger.isBefore)
		{
			system.debug('----(Insert before)This is trigger.newmap----'+trigger.newmap);
			system.debug('----(Insert before)This is trigger.oldmap----'+trigger.oldmap);
		}
		else if(trigger.isafter)
		{
			system.debug('----(Insert after)This is trigger.newmap----'+trigger.newmap);
			system.debug('----(Insert after)This is trigger.oldmap----'+trigger.oldmap);
		}
	}
	if(trigger.isDelete)//before Delete record
	{
		if(trigger.isBefore)
		{
			system.debug('----(Delete before)This is trigger.newmap----'+trigger.newmap);
			system.debug('----(Delete before)This is trigger.oldmap----'+trigger.oldmap);
		}
		else if(trigger.isafter)
		{
			system.debug('----(Delete after)This is trigger.newmap----'+trigger.newmap);
			system.debug('----(Delete after)This is trigger.oldmap----'+trigger.oldmap);
		}
	}
	if(trigger.isUnDelete)//before undelete record
	{
		if(trigger.isBefore)
		{
			system.debug('----(UnDelete before)This is trigger.newmap----'+trigger.newmap);
			system.debug('----(UnDelete before)This is trigger.oldmap----'+trigger.oldmap);
		}
		else if(trigger.isafter)
		{
			system.debug('----(UnDelete after)This is trigger.newmap----'+trigger.newmap);
			system.debug('----(UnDelete after)This is trigger.oldmap----'+trigger.oldmap);
		}
	}
}