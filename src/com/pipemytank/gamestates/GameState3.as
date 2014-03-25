package com.pipemytank.gamestates
{
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.events.Event;

	public class GameState3 extends GameState
	{
		private var _init:Boolean = false;
		private var mapBg:Image;
		private var path1:Image;
		private var path2:Image;
		private var path3:Image;
		
		
		
		public function GameState3()
		{
			super();
			this.stateID = 3;
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function disposeTemporarily():void {
			//this.visible = false;
			if(this.hasEventListener(Event.TRIGGERED)) this.removeEventListener(Event.TRIGGERED, onTriggerHandler);
		}
		
		public function init():void {
			//this.visible = true;
		}
		
		
		private function onAddedToStage(e:Event):void {
			if(!_init) drawScreen();
			
			this.addEventListener(Event.TRIGGERED, onTriggerHandler);
		}
		
		private function drawScreen():void {
			trace("gamestate2 drawScreen()");
			
			mapBg = new Image(Assets.getTexture("BgMap"));
			mapBg.x = 22;
			mapBg.y = 13;
			this.addChild(mapBg);
			
			path1 = new Image(Assets.getAtlas().getTexture("path_allies"));
			path1.x = 30;
			path1.y = 14;
			this.addChild(path1);
			
			
			
			
		}
		
		private function onTriggerHandler(e:Event):void {
			var target:DisplayObject = e.target as DisplayObject;
			//
		}
		
	}
}