package com.pipemytank.gamestates
{
	import com.pipemytank.assets.LevelIcon;
	import com.pipemytank.assets.MapIcon;
	import com.pipemytank.events.NavigationEvent;
	
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.events.Event;
	
	public class GameState4 extends GameState
	{
		private var _init:Boolean = false;
		private var mapBg:Image;
		private var selectedMapIcon:MapIcon;
		private var selectedFlag:Image;
		
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
			
			mapBg = new Image(GameScene.assets.getTexture("BgMap"));
			mapBg.x = 22;
			mapBg.y = 13;
			this.addChild(mapBg);
			
			selectedFlag = new Image(GameScene.assets.getTexture("flag_allies"));
			selectedFlag.x = 770;
			selectedFlag.y = 65;
			this.addChild(selectedFlag);
			
			selectedMapIcon = new MapIcon(GameScene.assets.getTexture("location11"));
			selectedMapIcon.x = 400;
			selectedMapIcon.y = 117;
			this.addChild(selectedMapIcon);
			selectedMapIcon.useAsImage();
			
			var posX:Number = 90;
			var posY:Number = 344;
			for(var i:int=1; i<22; ++i) {
				if(i==8 || i==15) {
					posX = 90;
					posY += 98;
				}
				var levelIcon:LevelIcon;
				levelIcon = new LevelIcon(GameScene.assets.getTexture("level_icon"));
				
				levelIcon.setLevelNumber(i);
				posX += 98;
				levelIcon.x = posX;
				levelIcon.y = posY;
				this.addChild(levelIcon);
				if(i==1) levelIcon.unlock();
			}
			
			
			
			
			
			
			
			_init = true;
		}
		
		private function onTriggerHandler(e:Event):void {
			var target:DisplayObject = e.target as DisplayObject;
			this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "levelSelected"}, true));
		}
	}
}