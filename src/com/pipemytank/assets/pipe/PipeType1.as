package com.pipemytank.assets.pipe
{
	import com.greensock.TweenLite;

	public class PipeType1 extends PipeBase
	{
		
		public function PipeType1(n:int, p:int)
		{
			super(n, p);
			
			POS1 = "1111";
			POS2 = "1111";
			POS3 = "1111";
			POS4 = "1111";
		}
		
		override public function startFlowing(fuelIn_Side:int, flowingSpeed:Number):void {
			super.initPipeMask();
			
			_filling = true;
			var _doIt:Boolean = false;
			

		
//			switch(rotatePos) {
//				case 1:
					if(fuelIn_Side==1) {
						pipeMask.createMask(-80, 0);
						_doIt = true;
					}
					if(fuelIn_Side==2) {
						pipeMask.createMask(0, -80);
						_doIt = true;
					}
					if(fuelIn_Side==3) {
						pipeMask.createMask(80, 0);
						_doIt = true;
					}
					if(fuelIn_Side==4) {
						pipeMask.createMask(0, 80);
						_doIt = true;
					}
					
//					break;
//			}
			
			super.startMasking(_doIt);
			
			
		}
		
		
	}
}