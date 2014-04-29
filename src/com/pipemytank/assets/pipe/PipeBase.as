package com.pipemytank.assets.pipe
{
	import com.greensock.TweenLite;
	import com.pipemytank.events.FlowingBlockEvent;
	
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class PipeBase extends Sprite
	{
		protected static const QUICK_SPEED:Number = .4;
		protected static var POS1:String;
		protected static var POS2:String;
		protected static var POS3:String;
		protected static var POS4:String;
		protected static var pipeType:int = 0;
		protected var rotatePos:int = 1;
		protected var _filling:Boolean = false;
		protected var _filled:Boolean = false;
		protected var maskerTween:TweenLite;
		
		public function PipeBase()
		{
			super();
		}
		
		public function get pipePosition():int {
			return rotatePos;
		}
		
		// This function must overrited bu each PipeType
		public function checkPipeAvailibility(blockSide:int, pipePosition:int):String {
			var ret:String = "notAvailable";
			if(_filled) ret="filled";
			if(_filling) ret="filling";
			return ret;
		}
		
		public function return_Pipe_fuelOut_Side(fuelIn_Side:int, pipePosition:int):Array {
			var retArr:Array = [];
			
			var num:int = 0;
			switch(pipePosition) {
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
		
		private function checkPipePosition(pos:String, m:int):Array {
			var retArr:Array = [];
			var n:int = 0;
			for(var i:int=0; i<pos.length; ++i) {
				n = int(pos.substr(i, 1));
				if(n==1) {
					if(i!=m-1) {
						retArr.push(i);
					}
				}
			}
			return retArr;
		}
		
/*		public function rotatePipe():void {
			if(!_filled) {
				var cf:int = rotatePos;
				cf++;
				if(cf>TOTAL_FRAMES) cf=1;
				//gotoAndStop(cf);
			}
		}*/
		
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
		
		private function updatePipeTexture():void{
			removeChild(pipe);
			pipe = new Image(Assets.getAtlas().getTexture("pipe" + pipeType.toString() + rotatePos.toString() + "_red"));
			this.addChild(pipe);
		}
		
		
		public function startFlowing(fuelIn_Side:int, flowingSpeed:Number):void {
			// This function must overrited bu each PipeType
		}
		
		public function pauseFlowing():void {
			if(maskerTween) maskerTween.pause();
		}
		
		public function quickFill():void {
			maskerTween.pause();
			maskerTween = new TweenLite(0, 0, {delay:QUICK_SPEED, overwrite:false, onComplete:flowCompleted});
			fuelMask.showMask(QUICK_SPEED);
		}
		
		public function resumeFlowing():void {
			if(maskerTween) maskerTween.play();
		}
		
		private function flowCompleted():void {
			_filling = false;
			dispatchEvent(new FlowingBlockEvent(FlowingBlockEvent.COMPLETED, true, true));
		}
		
		public function get filled():Boolean {
			return _filled;
		}
		
		public function set quickSpeed(n:Number):void {
			//QUICK_SPEED = n;
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
		
	}
}