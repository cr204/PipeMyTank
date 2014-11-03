package com.pipemytank.gamestates
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Expo;
	import com.pipemytank.assets.FactionIcon;
	import com.pipemytank.assets.FactionIconsManager;
	import com.pipemytank.assets.FactionLabelButton;
	import com.pipemytank.events.NavigationEvent;
	import com.pipemytank.utils.Settings;
	
	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.events.Event;
	
	public class GameState2 extends GameState
	{
		private static var _init:Boolean = false;
		private var graphItem1:Image;
		private var factionIcons:FactionIconsManager;
		private var factionLabel:FactionLabelButton;
		private var leftArrow:Button;
		private var rightArrow:Button;
		private var currPos:Number = 271;
		
		public function GameState2()
		{
			super();
			this.stateID = 2;
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function disposeTemporarily():void {
			//this.visible = false;
			if(this.hasEventListener(Event.TRIGGERED)) this.removeEventListener(Event.TRIGGERED, onTriggerHandler);
		}
		
		public function init():void {
			//this.visible = true;
		}

		
		private function onAddedToStage(e:Event):void {
			if(!_init) drawScreen();
			
			this.addEventListener(Event.TRIGGERED, onTriggerHandler);
		}
		
		private function drawScreen():void {
			trace("gamestate2 drawScreen()");
			
			graphItem1 = new Image(GameScene.assets.getTexture("choose_your_faction"));
			graphItem1.x = 202;
			graphItem1.y = 23;
			this.addChild(graphItem1);
			
			factionIcons = new FactionIconsManager();
			factionIcons.x = 271;
			factionIcons.y = 111;
			this.addChild(factionIcons);
			
			factionLabel = new FactionLabelButton(GameScene.assets.getTexture("faction_title_bg"));
			factionLabel.name = "fLabel";
			factionLabel.x = 270;
			factionLabel.y = 606;
			this.addChild(factionLabel);
			
			leftArrow = new Button(GameScene.assets.getTexture("left_arrow"));
			leftArrow.name = "leftArr";
			leftArrow.x = 208;
			leftArrow.y = 625;
			this.addChild(leftArrow);
			
			rightArrow = new Button(GameScene.assets.getTexture("right_arrow"));
			rightArrow.name = "rightArr";
			rightArrow.x = 764;
			rightArrow.y = 625;
			this.addChild(rightArrow);
			
			
			checkButtons();
			_init = true;
		}
				
		
		private function onTriggerHandler(e:Event):void {
			var target:DisplayObject = e.target as DisplayObject;
			switch(target.name) {
				case "fLabel":
					factionLabelSelected();
					break;
				case "leftArr":
					slideToRight();
					break;
				case "rightArr":
					slideToLeft();
					break;
				default:
					iconsTriggered(e.target as FactionIcon);
					break;
			}
			
		}
		
		
		private function iconsTriggered(icon:FactionIcon):void {
			trace("GS2.iconsTriggered: " + icon);
			switch(currPos) {
				case 271:
					if(icon.name=="faction1") factionSelected("ALLIES") else slideToLeft();
					break;
				case -348:
					if(icon.name=="faction1") slideToRight();
					if(icon.name=="faction2" && !icon.locked) factionSelected("RED ARMY");
					if(icon.name=="faction3") slideToLeft();
					break;
				case -967:
					if(icon.name=="faction2") slideToRight();
					if(icon.name=="faction3" && !icon.locked) factionSelected("WIDERSTAND");
					break;
			}
		}
		
		private function slideToLeft():void {
			var nextXPos:Number = currPos - 619;
			if(nextXPos<=271) {
				factionIcons.x = currPos;
				currPos -= 619;
				TweenLite.to(factionIcons, .5, {x:nextXPos, overwrite:false, ease:Expo.easeOut});
			}
			checkButtons();
		}
		
		private function slideToRight():void {
			var nextXPos:Number = currPos + 619;
			if(nextXPos<=271) {
				factionIcons.x = currPos;
				currPos += 619;
				TweenLite.to(factionIcons, .5, {x:nextXPos, overwrite:false, ease:Expo.easeOut});
			}
			checkButtons();
		}
		
		private function checkButtons():void {
			if(currPos==271) {
				rightArrow.visible = true;
				leftArrow.visible = false;
				factionLabel.setLabel(1);
			} else if(currPos==-967) {
				rightArrow.visible = false;
				leftArrow.visible = true;
				factionLabel.setLabel(3);
			} else {
				leftArrow.visible = true;
				rightArrow.visible = true;
				factionLabel.setLabel(2);
			}
		}

		private function factionLabelSelected():void {
			switch(currPos) {
				case 271:
					factionSelected("ALLIES");
					break;
				case -348:
					if(!factionIcons.factionLocked("faction2")) factionSelected("RED ARMY");
					break;
				case -967:
					if(!factionIcons.factionLocked("faction3")) factionSelected("WIDERSTAND");
					break;
			}
		}
		
		private function factionSelected(s:String):void {
			trace("Faction selected!");
			Settings.getInstance().selectedFactionName = s
			this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "factionSelected"}, true));
		}
		
	}
}