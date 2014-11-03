package com.pipemytank.assets
{
	import starling.display.Button;
	import starling.display.Image;

	import starling.events.Event;
	import starling.textures.Texture;
	
	public class MapIcon extends Button
	{
		private var spriteName:String;
		private var lockIcon:Image;
		private var _locked:Boolean = true;
		
		public function MapIcon(upState:Texture, text:String="", downState:Texture=null)
		{
			super(upState, text, downState);
			this.scaleWhenDown = 1;
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void {
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			lockIcon = new Image(GameScene.assets.getTexture("lock_icon"));
			this.addChild(lockIcon);
		}
		
		public function useAsImage():void {
			this.removeChild(lockIcon);
		}
				
		public function setStars(n:int):void {
			trace("setStars: " + n);
		}
		
		public function set locked(b:Boolean):void {
			_locked = b;
			if(b) {
				this.addChild(lockIcon);
			} else {
				this.removeChild(lockIcon);
			}
		}
		
		public function get locked():Boolean {
			return _locked;
		}
		
		
	}
}