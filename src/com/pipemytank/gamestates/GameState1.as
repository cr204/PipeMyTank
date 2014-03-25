package com.pipemytank.gamestates
{
	import com.pipemytank.events.NavigationEvent;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class GameState1 extends Sprite
	{
		private var bgMenu:Image;
		private var tank:Image;
		private var btnPlay:Button;
		private var btnGames:Button;
		private var btnLeaderboard:Button;
		
		
		public function GameState1()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function disposeTemporarily():void {
			this.visible = false;
		}
		
		public function init():void {
			this.visible = true;
		}
		 
		private function onAddedToStage(e:Event):void {
			trace("gamestate1 screen initialized");
			drawScreen();
		}
		
		private function drawScreen():void 
		{
			tank = new Image(Assets.getAtlas().getTexture("tank"));
			tank.x = 2;
			tank.y = 119;
			tank.width = 465;
			tank.height = 589;
			this.addChild(tank);
			
			bgMenu = new Image(Assets.getAtlas().getTexture("btnBg"));
			bgMenu.x = 486;
			bgMenu.y = 12;
			bgMenu.width = 474;
			bgMenu.height = 762;
			this.addChild(bgMenu);
			
			btnPlay = new Button(Assets.getAtlas().getTexture("btnPlay"));
			btnPlay.x = 476;
			btnPlay.y = 181;
			btnPlay.width = 532;
			btnPlay.height = 155;
			this.addChild(btnPlay);
			
			btnGames = new Button(Assets.getAtlas().getTexture("btnGames"));
			btnGames.x = 477;
			btnGames.y = 340;
			btnGames.width = 486;
			btnGames.height = 137;
			this.addChild(btnGames);
			
			btnLeaderboard = new Button(Assets.getAtlas().getTexture("btnLeaderboard"));
			btnLeaderboard.x = 530;
			btnLeaderboard.y = 490;
			btnLeaderboard.width = 435;
			btnLeaderboard.height = 135;
			this.addChild(btnLeaderboard);
			
			
			this.addEventListener(Event.TRIGGERED, onButtonClicked);
			
		}
		
		private function onButtonClicked(e:Event):void
		{
			var bntClicked:Button = e.target as Button;
			if((e.target as Button) == btnPlay) {
				this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "play"}, true));
			}
			
		}
		
		
		
		
		
		
		
		
		
		
	}
}