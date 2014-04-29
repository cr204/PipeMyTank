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
		private var yellowRect:Image;
		
		private var blockHolder:Sprite;
		private var targetBlock:Block;
		private var currBlock:Block;
		
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
			
			yellowRect = new Image(Assets.getAtlas().getTexture("yellow_rect"));
			
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
		
		// Creating each block and adding to blockHolder. 
		// We need to use it only for 1st time, for next usage we use resetBlocks()
		private function createBlocks():void {
			
			for(var i:int=0; i<8; ++i) {
				for(var j:int=0; j<8; ++j) {
					var block:Block = new Block(int(Math.random()*7) + 1);
					block.name = "block" + i.toString() + j.toString();
					block.x = j * 84;
					block.y = i * 84;
					block.init(this);
					blockHolder.addChild(block);
					
				}
			}
		}
		
		public function dragBlock(block:Block):void {
			positionYellowBox(block);
			blockHolder.addChild(yellowRect);
			blockHolder.addChild(block);
			targetBlock = block;
		}
		
		public function positionYellowBox(block:Block):void {
			var currBlockX:int = Math.floor((block.x - 38) / 84) + 1;
			if(currBlockX<0) currBlockX=0;
			if(currBlockX>7) currBlockX=7;
			
			var currBlockY:int = Math.floor((block.y - 38) / 84) + 1;
			if(currBlockY<0) currBlockY=0;
			if(currBlockY>7) currBlockY=7;
			
			
			yellowRect.x = 84 * currBlockX - 2;
			yellowRect.y = 84 * currBlockY - 2;
				
			currBlock = blockHolder.getChildByName("block" + String(currBlockY) + String(currBlockX)) as Block;
			
			if(currBlock.hasCover) {
				yellowRect.visible=false;
			} else if(currBlock.filled) {
				yellowRect.visible=false;
			} else if(currBlock.pipeType==7) {
				yellowRect.visible=false
			} else yellowRect.visible=true;
			
			
		}
		
		public function dropBlock():void {
			if(yellowRect.visible) {
				swapPipes();
			}
			blockHolder.removeChild(yellowRect);
		}
		
		private function swapPipes():void {
			var n1:int = currBlock.pipeType;
			var r1:Number = currBlock.pipeRotationDegree;
			var n2:int = targetBlock.pipeType;
			
			currBlock.swapPipe(n2, targetBlock.pipeRotationDegree);
			targetBlock.swapPipe(n1, r1);
			//if(channel2_started) pipeswap_sound.play();
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
					//
					break;
			}
			
		}
		

		
	}
}