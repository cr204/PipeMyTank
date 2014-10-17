package com.pipemytank.assets.pipe
{
	import com.greensock.TweenLite;

	public class PipeType6 extends PipeBase
	{
		private var maskerTween:TweenLite;
		
		public function PipeType6(n:int, p:int)
		{
			super(n, p);
			
			POS1 = "1010";
			POS2 = "0101";
			POS3 = "1010";
			POS4 = "0101";
		}
		
		override public function startFlowing(fuelIn_Side:int, flowingSpeed:Number):void {
			super.initPipeMask();
			
			_filling = true;
			var _doIt:Boolean = false;
			
/*			switch(rotatePos) {
				case 1:
					if(fuelIn_Side==1) {
						fuelMask.x = -67;
						fuelMask.y = 0;
						tempMask = fuelMask;
						_doIt = true;
					}
					if(fuelIn_Side==2) {
						fuelMask1.x = 0;
						fuelMask1.y = -65;
						tempMask = fuelMask1;
						_doIt = true;
					}
					if(fuelIn_Side==3) {
						fuelMask.x = 67;
						fuelMask.y = 0;
						tempMask = fuelMask;
						_doIt = true;
					}
					if(fuelIn_Side==4) {
						fuelMask1.x = 0;
						fuelMask1.y = 65;
						tempMask = fuelMask1;
						_doIt = true;
					}
					break;
				case 2:
					if(fuelIn_Side==1) {
						fuelMask1.x = -67;
						fuelMask1.y = 0;
						tempMask = fuelMask1;
						_doIt = true;
					}
					if(fuelIn_Side==2) {
						fuelMask.x = 0;
						fuelMask.y = -65;
						tempMask = fuelMask;
						_doIt = true;
					}
					if(fuelIn_Side==3) {
						fuelMask1.x = 67;
						fuelMask1.y = 0;
						tempMask = fuelMask1;
						_doIt = true;
					}
					if(fuelIn_Side==4) {
						fuelMask.x = 0;
						fuelMask.y = 65;
						tempMask = fuelMask;
						_doIt = true;
					}
					break;
			}
			super.startMasking(_doIt, flowingSpeed);
			
			*/
		
		}
		
	}
}