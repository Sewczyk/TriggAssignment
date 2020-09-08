/*
	This class runs the appropriate methods on the trigger handler based on the current trigger context.

	Author: Chris Aldridge, http://chrisaldridge.com
*/
public class TriggerDispatcher {
	/*
		Call this method from your trigger, passing in an instance of a trigger handler which implements ITriggerHandler.
		This method will fire the appropriate methods on the handler depending on the trigger context.
	*/
	public static void Run(ITriggerHandler handler) {
		
		if (handler.IsDisabled())
			return;


		if (Trigger.IsBefore ) {
			if (Trigger.IsInsert)
				handler.BeforeInsert(trigger.new);

			if (Trigger.IsUpdate)
				handler.BeforeUpdate(trigger.newMap, trigger.oldMap);

			if (Trigger.IsDelete)
				handler.BeforeDelete(trigger.oldMap);
		}
		
		
		if (Trigger.IsAfter) {
			if (Trigger.IsInsert)
				handler.AfterInsert(trigger.newMap);

			if (Trigger.IsUpdate)
				handler.AfterUpdate(trigger.newMap, trigger.oldMap);

			if (trigger.IsDelete)
				handler.AfterDelete(trigger.oldMap);

			if (trigger.IsUndelete)
				handler.AfterUndelete(trigger.oldMap);
		}
	}
}

