package com.pipemytank.gamestates
{
	import com.pipemytank.assets.LevelIcon;
	import com.pipemytank.assets.MapIcon;
	
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.events.Event;
	
	public class GameState4 extends GameState
	{
		private var _init:Boolean = false;
		private var mapBg:Image;
		private var selectedMapIcon:MapIcon;
		private var selectedFlag:Image;
		private var levelIcon:LevelIcon;
		
		public function GameState4()
		{
			super();
			this.stateID = 4;
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
			trace("gamestate4 drawScreen()");
			
			mapBg = new Image(Assets.getTexture("BgMap"));
			mapBg.x = 22;
			mapBg.y = 13;
			this.addChild(mapBg);
			
			selectedFlag = new Image(Assets.getAtlas().getTexture("flag_allies"));
			selectedFlag.x = 770;
			selectedFlag.y = 65;
			this.addChild(selectedFlag);
			
			selectedMapIcon = new MapIcon("location11");
			selectedMapIcon.x = 400;
			selectedMapIcon.y = 117;
			this.addChild(selectedMapIcon);
			selectedMapIcon.useAsImage();
			
			levelIcon = new LevelIcon(1);
			levelIcon.x = 188;
			levelIcon.y = 344;
			this.addChild(levelIcon);
			levelIcon.unlock();
			
			
			
			
			
			_init = true;
		}
		
		private function onTriggerHandler(e:Event):void {
			var target:DisplayObject = e.target as DisplayObject;
			//
		}
	}
}