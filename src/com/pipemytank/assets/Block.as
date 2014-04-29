package com.pipemytank.assets
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Expo;
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
		public var filled:Boolean = false;
		public var pipeType:int = 0;		
		
		private var parentObj:GameState5;
		private var dragging:Boolean = false;
		private var cover:Image;
		private var pipe:Image;
		private var initPosX:int = 0;
		private var initPosY:int = 0;
		private var clicked:int = 0;
		private var rotatePos:int = 1;
		private var tick:int = 0;

		
		public function Block(n:int)
		{
			super();
			pipeType = n;
			this.addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		public function init(gs5:GameState5):void {
			initPosX = this.x;
			initPosY = this.y;
			parentObj = gs5;
			
			pipe = new Image(Assets.getAtlas().getTexture(getBlockType(pipeType)));
			pipe.x = 39;
			pipe.y = 39;
			pipe.pivotX = pipe.width * .5;
			pipe.pivotY = pipe.height * .5;
			this.addChild(pipe);
			
			cover = new Image(Assets.getAtlas().getTexture("block_allies"));
			cover.x = 39;
			cover.y = 39;
			cover.pivotX = cover.width * .5;
			cover.pivotY = cover.height * .5;
			cover.name = "Block";
			this.addChild(cover);
		}
		
		public function swapPipe(n1:int, n2:int):void {
			removeChild(pipe);
			pipe = new Image(Assets.getAtlas().getTexture(getBlockType(n1, n2)));
			pipe.x = 39;
			pipe.y = 39;
			pipe.pivotX = pipe.width * .5;
			pipe.pivotY = pipe.height * .5;
			this.addChild(pipe);
			rotatePos = n2;
		}
		
		private function getBlockType(n:int, p:int=0):String {
			var ret:String = "pipe51_red";
			if(n==6) n=5;
			if(n==7){
				ret = "pipe7";
			} else {
				if(p>0) {
					ret = "pipe" + n.toString() + p.toString() + "_red";
				} else {
					ret = "pipe" + n.toString() + getPipeRandomPosition(n) + "_red";	
				}
			}
			pipeType = n;
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
			rotatePos = t;
			if(t>0) ret = t.toString();
			return ret;
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
						if(this.pipeType<7) this.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
					}
					//if(clicked<2) hideCover() else rotateBlock();
					//var localPos:Point = touch.getLocation(this);
					//trace("Touched object at position: " + localPos);
				}
				//if(touchEnded && clicked>1) {
				if(touch.phase==TouchPhase.ENDED && clicked>1 && this.pipeType<7) 
				{
					this.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
					if(tick<DRAG_TICK_VALUE) rotatePipe() else dropBlock();
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
			if(this.pipeType<7)	{
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
		
		private function rotatePipe():void {
			++rotatePos;
			switch(pipeType) {
				case 2:
				case 4:
					if(rotatePos>2) rotatePos=1;
					updatePipeTexture();
					break;
				case 3:
				case 5:
					if(rotatePos>4) rotatePos=1;
					updatePipeTexture();
					break;
				default:
					break;
			}
		}
		
		public function get pipeRotationDegree():Number {
			return rotatePos
		}
		
		private function updatePipeTexture():void{
			removeChild(pipe);
			pipe = new Image(Assets.getAtlas().getTexture("pipe" + pipeType.toString() + rotatePos.toString() + "_red"));
			this.addChild(pipe);
		}
		
		private function enterFrameHandler(e:Event):void {
			++tick;
			if(tick>DRAG_TICK_VALUE) {
				this.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
				dragBlock();
			}
		}
		
	}
}