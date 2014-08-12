package com.pipemytank.gamestates
{
	import com.pipemytank.assets.Block;
	import com.pipemytank.assets.WaitingTank;
	import com.pipemytank.events.FlowingBlockEvent;
	import com.pipemytank.events.NavigationEvent;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class GameState5 extends GameState
	{
		private var flowingSpeed:Number = 4;
		private var parentObj:GameScene;
		
		private var _init:Boolean = false;
		private var bgCell:Image;
		private var btnPause:Button;
		private var btnStart:Button;
		private var btnSkip:Button;
		private var fuelTank:Image;
		private var imgArrow:Image;
		private var imgTank:Image;
		private var tank1:WaitingTank;
		private var yellowRect:Image;
		
		private var blockHolder:Sprite;
		private var targetBlock:Block;
		private var currBlock:Block;
		private var flowingBlock:Block;
		private var flowingBlockName:String;
		
		public var _gameOver:Boolean = false;
		
		private var flowingBlocksArr:Array;
		private var tankPoints:Array = new Array('78');
		private var _filledPipes:int = 0;
		private var _unfilledPipes:int = 0;
		private var _fillingBlocks:int = 1;
		private var _tankMoved:Boolean = false;
		
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
		
		public function init(pObj:GameScene):void {
			parentObj = pObj;
			flowingBlocksArr = new Array();
			flowingBlockName="block00";
			_fillingBlocks = 1;
			
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
			
			tank1 = new WaitingTank();
			tank1.x = 865;
			tank1.y = 654;
			this.addChild(tank1);
			
			/*imgTank = new Image(Assets.getAtlas().getTexture("tank_allies"));
			imgTank.x = 880;
			imgTank.y = 654;
			this.addChild(imgTank);*/
			
			imgArrow = new Image(Assets.getAtlas().getTexture("arrow_bitmap"));
			imgArrow.x = 854;
			imgArrow.y = 675;
			this.addChild(imgArrow);

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
					var block:Block = new Block(int(Math.random()*5) + 1);
					//var block:Block = new Block(4);
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
					startFlowing("block00", 1); 
					break;
				default:
					//
					break;
			}
			
		}
		
		private function startFlowing(bName:String, bSide:int):void {
			//var currBlock:Block = blockHolder.getChildByName("block00") as Block;
			//currBlock.blockFuelInPosition(1);
			//currBlock.startFuelFlowing(2);
			flowingBlock =  blockHolder.getChildByName(bName) as Block;
			trace(bName + " - side: " + bSide);
			trace("PipeType:" + flowingBlock.pipe + "  pType:" + flowingBlock.pipeType + "  POS:" + flowingBlock.getPipePOS());
			var res:String = flowingBlock.blockAvailable(bSide);
			trace("res: " + res);
			//trace(bName + " - side: " + bSide + " -   res: " + res); // + "  _fillingBlocks: " + _fillingBlocks);
			
			if(res=="available" && !_gameOver) {
				flowingBlock.blockFuelInPosition(bSide);
				if(flowingBlock.hasEventListener(FlowingBlockEvent.COMPLETED)) {
					//
				} else {
					flowingBlock.addEventListener(FlowingBlockEvent.COMPLETED, flowCompleteHandler);
				}
				flowingBlock.startFuelFlowing(flowingSpeed);
				flowingBlocksArr.push(flowingBlock);
			} else if(res=="filled") {
				trace("FILLED!");
				--_fillingBlocks;
				if(_fillingBlocks<1 && _tankMoved) levelFinished();
				if(_fillingBlocks<1 && !_tankMoved) blocksRounded();
			} else if(res=="filling" && !_gameOver) {
				trace("FILLING!");
				--_fillingBlocks;
				flowingBlock.blockFuelInPosition(bSide);
				flowingBlock.addEventListener(FlowingBlockEvent.COMPLETED, flowCompleteHandler);
				flowingBlock.startFuelFlowing(flowingSpeed);
				flowingBlocksArr.push(flowingBlock);
			} else {
				trace("1. GAME OVER!");
				_gameOver = true;
/*				channel.stop();
				pauseGame();
				stopIngameMusic();
				screenAnimation.gotoAndPlay("animation3");
				windowFault.levelNumbers.setNumbers(levelNumbers.getNumbers);
				TweenLite.to(this, 0, {delay:1.5, overwrite:false, onComplete:function(){windowHolder.addChild(windowFault); }});*/
			}
			
		}
		
		private function flowCompleteHandler(e:FlowingBlockEvent):void {
			--_fillingBlocks;
			var target:Block = e.currentTarget  as Block;
			//trace(" ");
			//trace(target.name + " filled! ::  _fillingBlocks: " + _fillingBlocks);
			
			target.blockFilled = true;
			if(target.hasEventListener(FlowingBlockEvent.COMPLETED)) target.removeEventListener(FlowingBlockEvent.COMPLETED, flowCompleteHandler);
			
//			createScoreAnimation(target.x, target.y);
			
			var fuelOutPos:Array = target.cellFuelOutPositions;
			_fillingBlocks += fuelOutPos.length;
			for each(var n:int in fuelOutPos) {
				var nextCellObj = findNextCell(target.name, n);
				//trace(nextCellObj.cellName + "  - pos:" + nextCellObj.blockSide);
				nextCell1(nextCellObj.cellName, nextCellObj.blockSide);
				flowingBlockName = nextCellObj.cellName;
			}
			trace("---------");
		}
		
		
		
		
		private function levelFinished():void {
			trace("levelFinished!");
			tank1.fillTank(flowingSpeed);
/*			pauseGame();
			minusUnfilledPipes();
			channel.stop();*/
		}
		
		
		
		
		

		private function blocksRounded():void {
			
		}
		
		private function nextCell1(bName:String, bSide:int):void {
			//++_fillingBlocks;
			if(bName=="overflow") {
				trace("2. GAME OVER!");
				_gameOver = true;
/*				pauseGame();
				screenAnimation.gotoAndPlay("animation3");
				channel.stop();
				windowFault.levelNumbers.setNumbers(levelNumbers.getNumbers);
				TweenLite.to(this, 0, {delay:2, overwrite:false, onComplete:function(){windowHolder.addChild(windowFault); }});*/
			} else if(bName=="moveTank") {
				--_fillingBlocks;
				if(_fillingBlocks<1) levelFinished();
				_tankMoved = true;
			} else {
				startFlowing(bName, bSide);
				++_filledPipes;
			}
		}
		
		
		private function findNextCell(s:String, n:int):Object {
			trace("findNextCell: - s:" + s + "   - n:" + n);
			var retObject:Object = new Object();
			retObject.blockSide = findBlockSide(n);
			var bX:int = int(s.substr(5, 1));
			var bY:int = int(s.substr(6, 1));
			if(n==0) --bY;
			if(n==1) --bX;
			if(n==2) ++bY;
			if(n==3) ++bX;
				
			var tempString:String = "";
			if(bX>=0 && bX<8 && bY>=0 && bY<8) {
				tempString = "block" + String(bX) + String(bY);
			} else {
				if(checkFuelOutput(bX, bY)) 
					tempString="moveTank"
				else 
					tempString = "overflow";
			}
			
			retObject.cellName = tempString;
			return retObject;
		}
		
		private function findBlockSide(n:int):int {
			var ret:int = 0;
			if(n==0) ret = 3;
			if(n==1) ret = 4;
			if(n==2) ret = 1;
			if(n==3) ret = 2;
			return ret;
		}
		
		private function checkFuelOutput(bX:int, bY:int):Boolean {
			//trace("** bX: " + bX + "   bY: " + bY);
			var ret:Boolean = false;
			var temSt:String = bX.toString() + bY.toString();
			for(var i:int=0; i<tankPoints.length; ++i) {
				if(temSt==tankPoints[i]) ret=true;
			}
			return ret;
		}
		
		
		
		
		
		
		
		
	}
}