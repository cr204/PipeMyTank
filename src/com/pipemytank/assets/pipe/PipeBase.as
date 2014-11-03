package com.pipemytank.assets.pipe
{
	import com.greensock.TweenLite;
	import com.pipemytank.assets.PipeMask;
	import com.pipemytank.events.FlowingBlockEvent;
	
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class PipeBase extends Sprite
	{
		protected static const QUICK_SPEED:Number = .4;
		protected var POS1:String;
		protected var POS2:String;
		protected var POS3:String;
		protected var POS4:String;
		protected var _filling:Boolean = false;
		protected var _filled:Boolean = false;
		protected var pipeMask:PipeMask;
		protected var maskerTween:TweenLite;
		
		public var pipeType:int;
		public var rotatePos:int = 1;
		private var pipeBitmap:Image;
		
		public function PipeBase(_pipeType:int, _rotPos:int=0)
		{
			super();
			pipeType = _pipeType;
			rotatePos = _rotPos;
			
			pipeBitmap = new Image(GameScene.assets.getTexture(getPipeType(pipeType, _rotPos)));
			pipeBitmap.pivotX = pipeBitmap.width * .5;
			pipeBitmap.pivotY = pipeBitmap.height * .5;
			this.addChild(pipeBitmap);
			
		}
		
		public function returnPipePOS():Array {
			var retArr:Array = [];
			retArr.push(POS1);
			retArr.push(POS2);
			retArr.push(POS3);
			retArr.push(POS4);
			return retArr;	
		}
		
		public function checkPipeAvailibility(blockSide:int):String {
			var ret:String = "notAvailable";
			var num:int = 0;
			switch(rotatePos) {
				case 1:
					num = int(POS1.substr(blockSide-1, 1));
					break;
				case 2:
					num = int(POS2.substr(blockSide-1, 1));
					break;
				case 3:
					num = int(POS3.substr(blockSide-1, 1));
					break;
				case 4:
					num = int(POS4.substr(blockSide-1, 1));
					break;
			}
			if(num==1) {
				ret = "available";
			}
			if(_filled) ret="filled";
			if(_filling) ret="filling";
			
			return ret;
		}
		
		public function updatePipe(pType:int, rotPos:int=0):void {
			removeChild(pipeBitmap);
			pipeBitmap = new Image(GameScene.assets.getTexture(getPipeType(pType, rotPos)));
			pipeBitmap.pivotX = pipeBitmap.width * .5;
			pipeBitmap.pivotY = pipeBitmap.height * .5;
			this.addChild(pipeBitmap);
			rotatePos = rotPos;
		}
		
		public function rotatePipe():void {
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
		
		public function return_Pipe_fuelOut_Side(fuelIn_Side:int):Array {
			var retArr:Array = [];
			
			var num:int = 0;
			switch(rotatePos) {
				case 1:
					retArr = checkPipePosition(POS1, fuelIn_Side);
					break;
				case 2:
					retArr = checkPipePosition(POS2, fuelIn_Side);
					break;
				case 3:
					retArr = checkPipePosition(POS3, fuelIn_Side);
					break;
				case 4:
					retArr = checkPipePosition(POS4, fuelIn_Side);
					break;
			}
			return retArr;
		}
		
		// Must be overridden by PipeTypeN class!
		public function startFlowing(fuelIn_Side:int, flowingSpeed:Number):void {
			//
			trace("PipeBase.startFlowing().fuelIn_Side: " + fuelIn_Side);
		}
		
		protected function startMasking(_doIt:Boolean, flowingSpeed:Number):void {
			if(_doIt) {
				_filled = true;
				maskerTween = new TweenLite(0, 0, {delay:flowingSpeed, overwrite:false, onComplete:flowCompleted});
				pipeMask.showMask(flowingSpeed);
			}
		}

		
		protected function flowCompleted():void {
			trace("flowCompleted!");
			_filling = false;
			dispatchEvent(new FlowingBlockEvent(FlowingBlockEvent.COMPLETED, true, true));
		}
		
		private function checkPipePosition(pos:String, m:int):Array {
			var retArr:Array = [];
			var n:int = 0;
			for(var i:int=0; i<pos.length; ++i) {
				n = int(pos.substr(i, 1));
				if(n==1) {
					if(i!=m-1) retArr.push(i);
				}
			}
			return retArr;
		}	
		
		private function getPipeType(n:int, p:int=0):String {
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
		
		
		private function updatePipeTexture():void{
			removeChild(pipeBitmap);
			pipeBitmap = new Image(GameScene.assets.getTexture("pipe" + pipeType.toString() + rotatePos.toString() + "_red"));
			pipeBitmap.pivotX = pipeBitmap.width * .5;
			pipeBitmap.pivotY = pipeBitmap.height * .5;
			this.addChild(pipeBitmap);
		}
		
		
		protected function initPipeMask():void {
			pipeMask = new PipeMask(pipeType, rotatePos);
			this.addChild(pipeMask);
		}
		
		
		public function get filled():Boolean {
			return _filled;
		}
		
		public function pauseFlowing():void {
			if(maskerTween) maskerTween.pause();
		}
		
		public function quickFill():void {
			maskerTween.pause();
			maskerTween = new TweenLite(0, 0, {delay:1, overwrite:false, onComplete:flowCompleted});
			pipeMask.showMask(QUICK_SPEED);
		}
		
		public function resumeFlowing():void {
			if(maskerTween) maskerTween.play();
		}
		
		
	}
}