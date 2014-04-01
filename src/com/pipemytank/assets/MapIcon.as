package com.pipemytank.assets
{
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class MapIcon extends Sprite
	{
		private var spriteName:String;
		private var mapButton:Button;
		private var lockIcon:Image;
		
		public function MapIcon(_spriteName:String)
		{
			super();
			spriteName = _spriteName;
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void {
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			mapButton = new Button(Assets.getAtlas().getTexture(spriteName));
			//mapButton.scaleWhenDown = 1;
			this.addChild(mapButton);
			
			lockIcon = new Image(Assets.getAtlas().getTexture("lock_icon"));
			this.addChild(lockIcon);
		}
		
		public function useAsImage():void {
			this.removeChild(lockIcon);
			mapButton.scaleWhenDown = 1;
		}
		
		public function unlock():void {
			this.removeChild(lockIcon);
		}
		
		public function setStars(n:int):void {
			trace("setStars: " + n);
		}
		
		
	}
}