package com.pipemytank.assets
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class LevelIcon extends Sprite
	{
		private var levelNumber:int = 1;
		private var iconBg:Image;
		private var numberBitmap:Image;
		private var lockBitmap:Image;
		
		public function LevelIcon(_levelNumber:int)
		{
			super();
			levelNumber = _levelNumber;
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void {
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			iconBg = new Image(Assets.getAtlas().getTexture("level_icon"));
			this.addChild(iconBg);
			
			numberBitmap = new Image(Assets.getAtlas().getTexture("level_number" + levelNumber.toString()));
			numberBitmap.x = 18;
			numberBitmap.y = 12;
			this.addChild(numberBitmap);
			
			lockBitmap = new Image(Assets.getAtlas().getTexture("level_lock"));
			lockBitmap.x = 20;
			lockBitmap.y = 14;
			this.addChild(lockBitmap);
			
			
		}
		
		public function unlock():void {
			removeChild(lockBitmap);
		}
		
		public function setStars(n:int):void {
			var star:Image = new Image(Assets.getAtlas().getTexture("level_medal"));
			star.x = 24;
			star.y = 21;
			this.addChild(star);
		}
		
	}
}