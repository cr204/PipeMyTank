package com.pipemytank.events
{
	import starling.events.Event;
	
	public class FlowingBlockEvent extends Event
	{
		public static const COMPLETED:String = "completed";
		
		public function FlowingBlockEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(COMPLETED, bubbles, cancelable);
		}
	}
}