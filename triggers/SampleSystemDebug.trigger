trigger SampleSystemDebug on Account (after insert) {
	/*1.System.debug the following statements for any object
a)Trigger.New b) Trigger.Old c)Trigger.NewMap d)Trigger.oldMap*/
	if(trigger.isInsert)
	{
		if(trigger.isAfter)
		{
			system.debug('----This is trigger.new----'+trigger.new);
			system.debug('----This is trigger.newmap----'+trigger.newmap);
			system.debug('----This is trigger.old----'+trigger.old);
			system.debug('----This is trigger.oldmap----'+trigger.oldmap);
		}
	}
}