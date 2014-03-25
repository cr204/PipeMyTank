package com.pipemytank.assets
{
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class FactionIcons extends Sprite {
		
		private var faction1:Button;
		private var faction2:Button;
		private var faction3:Button;
		
		public function FactionIcons()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void {
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			faction1 = new Button(Assets.getAtlas().getTexture("faction_allies"));
			faction1.name = "faction1";
			faction1.scaleWhenDown = 1;
			this.addChild(faction1);
			
			faction2 = new Button(Assets.getAtlas().getTexture("faction_red_locked"));
			faction2.name = "faction2";
			faction2.scaleWhenDown = 1;
			faction2.x = 620;
			this.addChild(faction2);
			
			faction3 = new Button(Assets.getAtlas().getTexture("faction_wider_locked"));
			faction3.name = "faction3";
			faction3.scaleWhenDown = 1;
			faction3.x = 1240;
			this.addChild(faction3);
			
		}
		
	}
}