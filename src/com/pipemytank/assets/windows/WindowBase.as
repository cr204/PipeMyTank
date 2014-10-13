package com.pipemytank.assets.windows
{
	import com.pipemytank.gamestates.GameState5;
	
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class WindowBase extends Sprite
	{
		protected var parentObj:GameState5;
		private static var _init:Boolean = false;
		
		public function WindowBase()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		public function init(pObj:GameState5):void {
			parentObj = pObj;
		}
		
		public function disposeTemporarily():void {
			if(this.hasEventListener(Event.TRIGGERED)) this.removeEventListener(Event.TRIGGERED, onTriggerHandler);
		}
		
		private function onAdded(e:Event):void {
			if(!_init) initAssets();
			this.addEventListener(Event.TRIGGERED, onTriggerHandler);
		}
		
		private function initAssets():void {
			var q:starling.display.Quad = new Quad(1024, 768); 
			q.setVertexColor(0, 0x000000);
			q.setVertexColor(1, 0x000000);
			q.setVertexColor(2, 0x000000);
			q.setVertexColor(3, 0x000000);
			q.alpha = .75;
			addChild (q);
			
			drawWindow();
			_init = true;
		}
		
		protected function drawWindow():void {
			// must be overriden by subclass!
		}
		
		
		protected function onTriggerHandler(e:Event):void {
			// must be overriden by subclass!
		}
		
	}
}