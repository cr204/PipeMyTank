package
{
	import flash.display.Bitmap;
//	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.utils.getDefinitionByName;
	
	[SWF(width="1024", height="768", frameRate="60", backgroundColor="#000000")]
	public class PipeMyTank extends MovieClip
	{
		private static const PROGRESS_BAR_HEIGHT:Number = 20;
		private var _starling:Object;
		//private var loader:Loader;
		
		[Embed(source="../assets/graphics/preloader.png", mimeType="image/png")]
		private var MyImage:Class;
		
		var preloader:Bitmap;
		
		public function PipeMyTank()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			preloader = new MyImage();
			preloader.x = 465;
			preloader.y = 345;
			this.addChild(preloader);
			
			this.stop();
			

/*			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onCompleteHandler);
			loader.load(new URLRequest("preloader.swf"));*/
			
			//the two most important events for preloading
			this.loaderInfo.addEventListener(ProgressEvent.PROGRESS, loaderInfo_progressHandler);
			this.loaderInfo.addEventListener(Event.COMPLETE, loaderInfo_completeHandler);
		}
		
/*		private function onCompleteHandler(e:Event):void {
			trace("onCompleteHandler");
			loader.x = 380;
			loader.y = 250;
			this.addChild(loader);
		}*/
		
		private function loaderInfo_progressHandler(event:ProgressEvent):void
		{
			//this example draws a basic progress bar
			this.graphics.clear();
			this.graphics.beginFill(0xcccccc);
			this.graphics.drawRect(0, (this.stage.stageHeight - PROGRESS_BAR_HEIGHT) / 2,
				this.stage.stageWidth * event.bytesLoaded / event.bytesTotal, PROGRESS_BAR_HEIGHT);
			this.graphics.endFill();
		}
		
		private function loaderInfo_completeHandler(event:Event):void
		{
			//get rid of the progress bar
			this.graphics.clear();
			
			this.removeChild(preloader);
			//loader = null;
			
			//go to frame two because that's where the classes we need are located
			this.gotoAndStop("two");
			
			//getDefinitionByName() will let us access the classes without importing
			const StarlingType:Class = getDefinitionByName("starling.core.Starling") as Class;
			const MainType:Class = getDefinitionByName("GameScene") as Class;
			this._starling = new StarlingType(MainType, this.stage);
			this._starling.start();
			
			//that's it!
		}
		
	}
}