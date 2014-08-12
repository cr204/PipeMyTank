package com.pipemytank.assets.windows
{
	import starling.events.Event;

	public class WindowFail extends WindowBase
	{
		public function WindowFail()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		
		private function onAddedToStage(e:Event):void {
			
		}
	}
}