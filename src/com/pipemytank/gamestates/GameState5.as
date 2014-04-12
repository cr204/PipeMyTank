package com.pipemytank.gamestates
{
	import com.pipemytank.assets.Block;
	import com.pipemytank.events.NavigationEvent;
	
	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class GameState5 extends GameState
	{
		private var _init:Boolean = false;
		private var bgCell:Image;
		private var btnPause:Button;
		private var btnStart:Button;
		private var btnSkip:Button;
		private var fuelTank:Image;
		private var imgArrow:Image;
		private var imgTank:Image;
		
		private var blockHolder:Sprite;
		
		public function GameState5()
		{
			super();
			this.stateID = 5;
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
			
			bgCell = new Image(Assets.getTexture("BgCell"));
			bgCell.x = 27;
			bgCell.y = 15;
			this.addChild(bgCell);
			
			btnPause = new Button(Assets.getAtlas().getTexture("btn_pause"));
			btnPause.x = 942;
			btnPause.y = 17;
			this.addChild(btnPause);
			
			btnStart = new Button(Assets.getAtlas().getTexture("btn_start"));
			btnStart.x = 30;
			btnStart.y = 17;
			this.addChild(btnStart);
			
			btnSkip = new Button(Assets.getAtlas().getTexture("btn_skip"));
			btnSkip.x = 931;
			btnSkip.y = 23;
			btnSkip.visible = false;
			this.addChild(btnSkip);
			
			fuelTank = new Image(Assets.getAtlas().getTexture("fuel_tank"));
			fuelTank.x = 29;
			fuelTank.y = 69;
			this.addChild(fuelTank);
			
			imgArrow = new Image(Assets.getAtlas().getTexture("arrow_bitmap"));
			imgArrow.x = 854;
			imgArrow.y = 675;
			this.addChild(imgArrow);
			
			imgTank = new Image(Assets.getAtlas().getTexture("tank_allies"));
			imgTank.x = 880;
			imgTank.y = 654;
			this.addChild(imgTank);

			blockHolder = new Sprite();
			blockHolder.x = 179;
			blockHolder.y = 68;
			this.addChild(blockHolder);
			
			createBlocks();
			
			_init = true;
		}
		
		private function createBlocks():void {

			
			for(var i:int=0; i<8; ++i) {
				for(var j:int=0; j<8; ++j) {
					var block:Block = new Block();
					block.name = "block" + i.toString() + j.toString();
					block.x = j * 84;
					block.y = i * 84;
					blockHolder.addChild(block);
					
				}
			}
		}
		
		
		private function onTriggerHandler(e:Event):void {
			var target:DisplayObject = e.target as DisplayObject;
			this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "back"}, true));
		}
		
	}
}