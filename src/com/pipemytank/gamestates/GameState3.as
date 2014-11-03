package com.pipemytank.gamestates
{
	import com.pipemytank.assets.MapIcon;
	import com.pipemytank.events.NavigationEvent;
	import com.pipemytank.utils.Settings;
	
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.events.Event;

	public class GameState3 extends GameState
	{
		private var _init:Boolean = false;
		private var mapBg:Image;
		private var path1:Image;
		private var selectedFlag:Image;
		private var path2:Image;
		private var path3:Image;
		
		private var location11:MapIcon;
		private var location12:MapIcon;
		private var location13:MapIcon;
		private var location14:MapIcon;
		private var location15:MapIcon;
		private var location16:MapIcon;
		
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
			trace("gamestate3 drawScreen()");
			
			mapBg = new Image(GameScene.assets.getTexture("BgMap"));
			mapBg.x = 22;
			mapBg.y = 13;
			this.addChild(mapBg);
			
			path1 = new Image(GameScene.assets.getTexture("path_allies"));
			path1.x = 30;
			path1.y = 14;
			this.addChild(path1);
			
			selectedFlag = new Image(GameScene.assets.getTexture("flag_allies"));
			selectedFlag.x = 770;
			selectedFlag.y = 65;
			this.addChild(selectedFlag);
			
			location11 = new MapIcon(GameScene.assets.getTexture("location11"));
			location11.name = "location1";
			location11.x = 126;
			location11.y = 110;
			this.addChild(location11);
			location11.locked = false;
			
			location12 = new MapIcon(GameScene.assets.getTexture("location12"));
			location12.name = "location2";
			location12.x = 172;
			location12.y = 406;
			this.addChild(location12);
			
			location13 = new MapIcon(GameScene.assets.getTexture("location13"));
			location13.name = "location3";
			location13.x = 342;
			location13.y = 220;
			this.addChild(location13);
			
			location14 = new MapIcon(GameScene.assets.getTexture("location14"));
			location14.name = "location4";
			location14.x = 557;
			location14.y = 130;
			this.addChild(location14);
			
			location15 = new MapIcon(GameScene.assets.getTexture("location15"));
			location15.name = "location5";
			location15.x = 490;
			location15.y = 442;
			this.addChild(location15);
			
			location16 = new MapIcon(GameScene.assets.getTexture("location16"));
			location16.name = "location6";
			location16.x = 712;
			location16.y = 334;
			this.addChild(location16);
			
			_init = true;
		}
		
		private function onTriggerHandler(e:Event):void {
			var target:MapIcon = e.target as MapIcon;
			if(!target.locked) {
				trace("target.name: " + target.name);
				Settings.getInstance().selectedLocationName = target.name;
				this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "mapSelected"}, true));
			}
		}
		
	}
}