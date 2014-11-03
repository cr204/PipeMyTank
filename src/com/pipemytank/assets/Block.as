package com.pipemytank.assets
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Expo;
	import com.pipemytank.assets.pipe.PipeBase;
	import com.pipemytank.assets.pipe.PipeType1;
	import com.pipemytank.assets.pipe.PipeType2;
	import com.pipemytank.assets.pipe.PipeType3;
	import com.pipemytank.assets.pipe.PipeType4;
	import com.pipemytank.assets.pipe.PipeType5;
	import com.pipemytank.assets.pipe.PipeType6;
	import com.pipemytank.assets.pipe.PipeType7;
	import com.pipemytank.gamestates.GameState5;
	
	import flash.geom.Point;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class Block extends Sprite
	{
		private const DRAG_TICK_VALUE:Number = 20;
		public var hasCover:Boolean = true;
		public var blockFilled:Boolean = false;
		private var _isDragging:Boolean = false;
		
		private var parentObj:GameState5;
		private var dragging:Boolean = false;
		private var cover:Image;
		public var pipe:PipeBase;
		private var initPosX:int = 0;
		private var initPosY:int = 0;
		private var clicked:int = 0;
//		private var pipePosition:int = 1;
		private var tick:int = 0;
		private var _fuelEnteredPosition:int = 0;
		private var _cellFuelOutPositions:Array = [];
		
		public function Block(n:int)
		{
			super();
			
			blockFilled = false;
			createPipe(n);
			this.addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		private function createPipe(type:int, pos:int=0):void {
			
			switch(type) {
				case 1:
					pipe = new PipeType1(type, pos);
					break;
				case 2:
					pipe = new PipeType2(type, pos);
					break;
				case 3:
					pipe = new PipeType3(type, pos);
					break;
				case 4:
					pipe = new PipeType4(type, pos);
					break;
				case 5:
					pipe = new PipeType5(type, pos);
					break;
				case 6:
					pipe = new PipeType6(type, pos);
					break;
				case 7:
					pipe = new PipeType7(type, pos);
					break;
			}
			
		}
		
		public function getPipePOS():Array {
			return pipe.returnPipePOS();
		}
		
		public function init(gs5:GameState5):void {
			initPosX = this.x;
			initPosY = this.y;
			parentObj = gs5;

			pipe.x = 39;
			pipe.y = 39;			
			this.addChild(pipe);
			
			cover = new Image(GameScene.assets.getTexture("block_allies"));
			cover.x = 39;
			cover.y = 39;
			cover.pivotX = cover.width * .5;
			cover.pivotY = cover.height * .5;
			cover.name = "Block";
			this.addChild(cover);
		}
		
		public function swapPipe(n1:int, n2:int):void {
			//pipe.updatePipe(n1, n2);
			this.removeChild(pipe);
			pipe = null;
			createPipe(n1, n2);
			
			pipe.x = 39;
			pipe.y = 39;			
			this.addChild(pipe);
		}
		
		public function get pipeType():int {
			return pipe.pipeType;
		}
		
		public function blockAvailable(blockSide:int):String {
			var ret:String = "notAvailable";
			if(!hasCover) {
				if(pipeType<6) {
					ret = pipe.checkPipeAvailibility(blockSide);
				}
				if(_isDragging) {
					ret = "dragging";
				}
				
			}
			return ret;
		}
		
		public function blockFuelInPosition(fuelIn_Side:int):void {
			_fuelEnteredPosition = fuelIn_Side;
			_cellFuelOutPositions = pipe.return_Pipe_fuelOut_Side(fuelIn_Side);
		}
		
		public function startFuelFlowing(flowingSpeed:Number):void {
			if(_fuelEnteredPosition>0) {
				pipe.startFlowing(_fuelEnteredPosition, flowingSpeed);
			} else {
				trace("Error! blockFuelInPosition not set yet!");
				trace("_fuelEnteredPosition=" + _fuelEnteredPosition);
			}
		}
		
		public function pauseGame():void {
			pipe.pauseFlowing();
		}
		
		public function resumeGame():void {
			pipe.resumeFlowing();
		}
		
		public function quickFill():void {
			if(!blockFilled) pipe.quickFill();
		}
		
		
		
		private function onTouch(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(stage); //event.getTouch(this, TouchPhase.BEGAN);
			//var touchEnded:Touch = event.getTouch(this, TouchPhase.ENDED);
			if (touch) {
				if(touch.phase==TouchPhase.BEGAN)
				{			
					++clicked;
					if(clicked<2) hideCover() else {
						if(pipe.pipeType<7) this.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
					}
					//if(clicked<2) hideCover() else rotateBlock();
					//var localPos:Point = touch.getLocation(this);
					//trace("Touched object at position: " + localPos);
				}
				//if(touchEnded && clicked>1) {
				if(touch.phase==TouchPhase.ENDED && clicked>1 && pipe.pipeType<7) 
				{
					this.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
					if(tick<DRAG_TICK_VALUE) pipe.rotatePipe() else dropBlock();
					tick = 0;
				}
				
				if(touch.phase==TouchPhase.MOVED && dragging) {
					var position:Point = touch.getLocation(stage);
					var posX:int = position.x;
					var posY:int = position.y;
					if(position.x<205) posX = 205;
					if(position.x>810) posX = 810;
					if(position.y<100) posY = 100;
					if(position.y>700) posY = 700;
					this.x = posX - 220;
					this.y = posY - 110;
					parentObj.positionYellowBox(this);
				}
			}
		}
		
		private function hideCover():void {
			//if(parentObj.channel2_started) sound_uncover.play();
			TweenLite.to(cover, .3,{alpha:0, scaleX:.7, scaleY:.7, overwrite:false, ease:Expo.easeOut, 
				onComplete:function(){ hasCover=false; removeChild(cover); } });
		}
		
		private function dragBlock():void {
			if(pipe.pipeType<7)	{
				parentObj.dragBlock(this);
				this.scaleX = this.scaleY = 1.15;
				this.x -= 4;
				this.y -= 4;
				dragging = true;
			}
		}
		
		private function dropBlock():void {
			this.scaleX = this.scaleY = 1;
			this.x +=4;
			this.y +=4;
			dragging = false;
			this.x = initPosX;
			this.y = initPosY;
			parentObj.dropBlock();
		}
		
		public function get pipeRotationDegree():Number {
			return pipe.rotatePos;
		}
		
		private function enterFrameHandler(e:Event):void {
			++tick;
			if(tick>DRAG_TICK_VALUE) {
				this.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
				dragBlock();
			}
		}
		
		public function get cellFuelOutPositions():Array {
			return _cellFuelOutPositions;
		}
		
		public function get filled():Boolean {
			return pipe.filled;
		}
		
	}
}