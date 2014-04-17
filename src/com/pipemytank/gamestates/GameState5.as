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
			
			var txtBattleOf:Image = new Image(Assets.getAtlas().getTexture("text_battle"));
			txtBattleOf.x = 260;
			txtBattleOf.y = 31;
			this.addChild(txtBattleOf);
			
			var txtLocationName:Image = new Image(Assets.getAtlas().getTexture("text_normandy"));
			txtLocationName.x = 350;
			txtLocationName.y = 31;
			this.addChild(txtLocationName);
			
			var txtScore:Image = new Image(Assets.getAtlas().getTexture("text_score"));
			txtScore.x = 526;
			txtScore.y = 31;
			this.addChild(txtScore);
			
			var txtHScore:Image = new Image(Assets.getAtlas().getTexture("text_highscore"));
			txtHScore.x = 670;
			txtHScore.y = 31;
			this.addChild(txtHScore);
			
			createBlocks();
			
			_init = true;
		}
		
		private function createBlocks():void {

			
			for(var i:int=0; i<8; ++i) {
				for(var j:int=0; j<8; ++j) {
					var bTypeName:String = getNextBlockType();
					var block:Block = new Block(Assets.getAtlas().getTexture(bTypeName));
					block.name = "block" + i.toString() + j.toString();
					block.type = int(bTypeName.substr(4,1));
					block.x = j * 84;
					block.y = i * 84;
					blockHolder.addChild(block);
					
				}
			}
		}
		
		private function getNextBlockType():String {
			var ret:String = "pipe51_red";
			
			var rnd:int = int(Math.random() * 7) + 1;
			if(rnd==6) rnd=5;
			if(rnd==7){
				ret = "pipe7";
			} else {
				ret = "pipe" + rnd.toString() + getPipeRandomPosition(rnd) + "_red";
			}
			return ret;
		}
		
		private function getPipeRandomPosition(n:int):String {
			var ret:String = "";
			var t:int = 0;
			switch(n) {
				case 2:
				case 4:
					t = int(Math.random() * 2) + 1;
					break;
				case 3:
				case 5:
					t = int(Math.random() * 4) + 1;
					break;
			}
			if(t>0) ret = t.toString();
			return ret;
		}
		
		
		private function onTriggerHandler(e:Event):void {
			var target:Button = e.target as Button;
			//trace("GS5.onTriggarHandler: " + target);
			
			switch(target) {
				case btnPause:
					this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "back"}, true));		
					break;
				case btnSkip:
					break;
				case btnStart:
					break;
				default:
					var tt:Block = target as Block;
					tt.blockTriggered();
					break;
			}
			
		}
		
	}
}