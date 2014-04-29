package com.pipemytank.assets
{
	import com.greensock.TweenLite;
	import com.pipemytank.events.FlowingBlockEvent;
	
	import starling.display.Sprite;
	
	public class PipeType1 extends Sprite
	{
		private static const POS1:String = "1111";
		private static const POS2:String = "1111";
		private static const POS3:String = "1111";
		private static const POS4:String = "1111";
		private var currPosition:int = 1;
		private var res:Boolean = false;
		private var _filling:Boolean = false;
		private var _filled:Boolean = false;
		private var maskerTween:TweenLite;
		private var QUICK_SPEED:Number = .4;
		
		public function PipeType1()
		{
			super();
		}
		
		public function get pipePosition():int {
			return currPosition;
		}
		
		public function checkPipeAvailibility(blockSide:int, pipePosition:int):String {
			var ret:String = "available";
			if(_filled) ret="filled";
			if(_filling) ret="filling";
			return ret;
		}
		
		public function return_Pipe_fuelOut_Side(fuelIn_Side:int, pipePosition:int):Array {
			var retArr:Array = [];
			
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
		
		public function rotatePipe():void {
			//
		}
		
		public function startFlowing(fuelIn_Side:int, flowingSpeed:Number):void {
			_filling = true;
			var _doIt:Boolean = false;
			
			/*switch(currPosition) {
				case 1:
					if(fuelIn_Side==1) {
						fuelMask.createMask(-125, 0);
						_doIt = true;
					}
					if(fuelIn_Side==2) {
						fuelMask.createMask(0, -125);
						_doIt = true;
					}
					if(fuelIn_Side==3) {
						fuelMask.createMask(125, 0);
						_doIt = true;
					}
					if(fuelIn_Side==4) {
						fuelMask.createMask(0, 125);
						_doIt = true;
					}
					
					break;
			}
			if(_doIt) {
				_filled = true;
				maskerTween = new TweenLite(0, 0, {delay:flowingSpeed, overwrite:false, onComplete:flowCompleted});
				fuelMask.showMask(flowingSpeed);
			}*/
			
		}
		
		public function pauseFlowing():void {
			if(maskerTween) maskerTween.pause();
		}
		
		public function quickFill():void {
			maskerTween.pause();
			maskerTween = new TweenLite(0, 0, {delay:QUICK_SPEED, overwrite:false, onComplete:flowCompleted});
			//fuelMask.showMask(QUICK_SPEED);
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
			QUICK_SPEED = n;
		}
		
		
	}
}