package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	import starling.core.Starling;
	
	[SWF(width="1024", height="768", frameRate="60", backgroundColor="#000000")]
	public class PipeMyTank extends Sprite
	{
		private var mStarling:Starling;
		
		public function PipeMyTank()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			// create out starling instace
			mStarling = new Starling(GameScene, stage);
			// emulate multitouch
			mStarling.simulateMultitouch = true;
			// set anti-aliasing
			mStarling.antiAliasing= 1;
			
			// start it!
			mStarling.start();
		}
	}
}