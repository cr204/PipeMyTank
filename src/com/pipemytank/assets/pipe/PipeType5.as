package com.pipemytank.assets.pipe
{
	import com.greensock.TweenLite;

	public class PipeType5 extends PipeBase
	{
		private var maskerTween:TweenLite;
		
		public function PipeType5(n:int, p:int)
		{
			super(n, p);
			
			POS1 = "1001";
			POS2 = "1100";
			POS3 = "0110";
			POS4 = "0011";
		}
		
		override public function startFlowing(fuelIn_Side:int, flowingSpeed:Number):void {
			super.initPipeMask();
			
			_filling = true;
			var _doIt:Boolean = false;
			
			switch(rotatePos) {
				case 1:
					if(fuelIn_Side==1) {
						pipeMask.createMask(-80, 0);
						_doIt = true;
					}
					if(fuelIn_Side==4) {
						pipeMask.createMask(0, 80);
						_doIt = true;
					}
					break;
				case 2:
					if(fuelIn_Side==1) {
						pipeMask.createMask(-80, 0);
						_doIt = true;
					}
					if(fuelIn_Side==2) {
						pipeMask.createMask(0, -80);
						_doIt = true;
					}
					break;
				case 3:
					if(fuelIn_Side==2) {
						pipeMask.createMask(0, -80);
						_doIt = true;
					}
					if(fuelIn_Side==3) {
						pipeMask.createMask(80, 0);
						_doIt = true;
					}
					break;
				case 4:
					if(fuelIn_Side==3) {
						pipeMask.createMask(80, 0);
						_doIt = true;
					}
					if(fuelIn_Side==4) {
						pipeMask.createMask(0, 80);
						_doIt = true;
					}
					break;
			}
			if(_doIt) {
				_filled = true;
				maskerTween = new TweenLite(0, 0, {delay:flowingSpeed, overwrite:false, onComplete:flowCompleted});
				pipeMask.showMask(flowingSpeed);
			}
			
			
		}
		
	}
}