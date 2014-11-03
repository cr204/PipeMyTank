package com.pipemytank.assets
{
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class FactionIconsManager extends Sprite {
		
		private var faction1:FactionIcon;
		private var faction2:FactionIcon;
		private var faction3:FactionIcon;
		
		public function FactionIconsManager()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void {
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			faction1 = new FactionIcon(GameScene.assets.getTexture("faction_allies"));
			faction1.name = "faction1";
			faction1.locked = false;
			this.addChild(faction1);
			
			faction2 = new FactionIcon(GameScene.assets.getTexture("faction_red_locked"));
			faction2.name = "faction2";
			faction2.locked = true;
			faction2.x = 620;
			this.addChild(faction2);
			
			faction3 = new FactionIcon(GameScene.assets.getTexture("faction_wider_locked"));
			faction3.name = "faction3";
			faction3.locked = true;
			faction3.x = 1240;
			this.addChild(faction3);			
		}
		
		public function factionLocked(s:String):Boolean {
			var ret:Boolean = false;
			if(s=="faction2") ret=faction2.locked;
			if(s=="faction3") ret=faction3.locked;
			return ret;
		}
		
	}
}