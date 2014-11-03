package com.pipemytank.assets
{
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;
	
	public class LevelIcon extends Button
	{
		private var levelNumber:int = 1;
//		private var iconBg:Image;
		private var numberBitmap:Image;
		private var lockBitmap:Image;
		
		public function LevelIcon(upState:Texture, text:String="", downState:Texture=null)
		{
			super(upState, text, downState);
			this.scaleWhenDown = 1;
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function setLevelNumber(_levelNumber:int):void {
			levelNumber = _levelNumber;
		}
		
		private function onAddedToStage(e:Event):void {
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
/*			iconBg = new Image(Assets.getAtlas().getTexture("level_icon"));
			this.addChild(iconBg);*/
			
			numberBitmap = new Image(GameScene.assets.getTexture("level_number" + levelNumber.toString()));
			numberBitmap.x = 18;
			numberBitmap.y = 12;
			this.addChild(numberBitmap);
			
			lockBitmap = new Image(GameScene.assets.getTexture("level_lock"));
			lockBitmap.x = 20;
			lockBitmap.y = 14;
			this.addChild(lockBitmap);
			
			
		}
		
		public function unlock():void {
			removeChild(lockBitmap);
		}
		
		public function setStars(n:int):void {
			var star:Image = new Image(GameScene.assets.getTexture("level_medal"));
			star.x = 24;
			star.y = 21;
			this.addChild(star);
		}
		
	}
}