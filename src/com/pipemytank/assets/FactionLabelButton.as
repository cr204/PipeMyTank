package com.pipemytank.assets
{
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;
	
	public class FactionLabelButton extends Button
	{
		private var captBg:Image;
		private var caption1:Image;
		private var caption2:Image;
		private var caption3:Image;

		
		public function FactionLabelButton(upState:Texture, text:String="", downState:Texture=null)
		{
			super(upState, text, downState);
			this.scaleWhenDown = 1;
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void {
			if(this.hasEventListener(Event.ADDED_TO_STAGE)) this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			caption1 = new Image(GameScene.assets.getTexture("allies_text"));
			caption1.x = 105;
			caption1.y = 20;
			
			caption2 = new Image(GameScene.assets.getTexture("red_text"));
			caption2.x = 105;
			caption2.y = 20;
			
			caption3 = new Image(GameScene.assets.getTexture("wider_text"));
			caption3.x = 105;
			caption3.y = 20;
		}
		
		public function setLabel(n:int):void {
			if(this.numChildren==2) this.removeChildAt(1);
			switch(n) {
				case 1:
					this.addChild(caption1);
					break;
				case 2:
					this.addChild(caption2);
					break;
				case 3:
					this.addChild(caption3);
					break;
			}
		}
		
	}
}