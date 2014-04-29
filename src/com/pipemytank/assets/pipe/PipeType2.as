package com.pipemytank.assets.pipe
{
	public class PipeType2 extends PipeBase
	{
		public function PipeType2()
		{
			super();
			pipeType = 2;
			POS1 = "1010";
			POS2 = "0101";
			POS3 = "1010";
			POS4 = "0101";
			
		}
		
		override public function checkPipeAvailibility(blockSide:int, pipePosition:int):String {
			var ret:String = "notAvailable";
			var res:Boolean = false;
			var num:int = 0;
			switch(pipePosition) {
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
				res = true;
				ret = "available";
			}
			if(_filled) ret="filled";
			if(_filling) ret="filling";
			
			return ret;
		}
		
		
		
		
		
	}
}