trigger SampleTriggerForOld on A__c (before update) {
	if(trigger.isUpdate)
	{
		if(trigger.isBefore)
		{
			system.debug('----This is trigger.new----'+trigger.new);
			system.debug('----This is trigger.newmap----'+trigger.newmap);
			system.debug('----This is trigger.old----'+trigger.old);
			system.debug('----This is trigger.oldmap----'+trigger.oldmap);
		}
	}
}