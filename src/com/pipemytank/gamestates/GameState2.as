package com.pipemytank.gamestates
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Expo;
	import com.pipemytank.assets.FactionIcons;
	import com.pipemytank.assets.FactionLabelButton;
	
	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class GameState2 extends Sprite
	{
		private static var _init:Boolean = false;
		private var graphItem1:Image;
		private var factionIcons:FactionIcons;
		private var factionLabel:FactionLabelButton;
		private var leftArrow:Button;
		private var rightArrow:Button;
		private var currPos:Number = 271;
		
		public function GameState2()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void {
			trace("gamestate2 screen initialized");
			if(!_init) drawScreen();
		}
		
		private function drawScreen():void {
			
			graphItem1 = new Image(Assets.getAtlas().getTexture("choose_your_faction"));
			graphItem1.x = 202;
			graphItem1.y = 23;
			this.addChild(graphItem1);
			
			factionIcons = new FactionIcons();
			factionIcons.x = 271;
			factionIcons.y = 111;
			this.addChild(factionIcons);
			
			factionLabel = new FactionLabelButton(Assets.getAtlas().getTexture("faction_title_bg"));
			factionLabel.name = "fLabel";
			factionLabel.x = 270;
			factionLabel.y = 606;
			this.addChild(factionLabel);
			
			leftArrow = new Button(Assets.getAtlas().getTexture("left_arrow"));
			leftArrow.name = "leftArr";
			leftArrow.x = 208;
			leftArrow.y = 625;
			this.addChild(leftArrow);
			
			rightArrow = new Button(Assets.getAtlas().getTexture("right_arrow"));
			rightArrow.name = "rightArr";
			rightArrow.x = 764;
			rightArrow.y = 625;
			this.addChild(rightArrow);
			
			this.addEventListener(Event.TRIGGERED, onTriggerHandler);
			checkButtons();
			_init = true;
		}
				
		public function disposeTemporarily():void {
			this.visible = false;
			//if(this.hasEventListener(Event.TRIGGERED)) this.removeEventListener(Event.TRIGGERED, onTriggerHandler);
		}
		
		public function init():void {
			this.visible = true;
		}
		
		private function onTriggerHandler(e:Event):void {
			var target:DisplayObject = e.target as DisplayObject;
			switch(target.name) {
				case "fLabel":
					factionSelected();
					break;
				case "leftArr":
					slideToRight();
					break;
				case "rightArr":
					slideToLeft();
					break;
				default:
					iconsTriggered(target.name);
					break;
			}
			
		}
		
		
		private function iconsTriggered(iconName:String):void {
			switch(currPos) {
				case 271:
					if(iconName=="faction1") factionSelected() else slideToLeft();
					break;
				case -348:
					if(iconName=="faction1") slideToRight();
					if(iconName=="faction2") factionSelected();
					if(iconName=="faction3") slideToLeft();
					break;
				case -967:
					if(iconName=="faction3") factionSelected() else slideToRight();
					break;
			}
		}
		
		private function slideToLeft():void {
			var nextXPos:Number = currPos - 619;
			if(nextXPos<=271) {
				factionIcons.x = currPos;
				currPos -= 619;
				TweenLite.to(factionIcons, .5, {x:nextXPos, overwrite:false, ease:Expo.easeOut});
				//captions.prevFrame();
			}
			checkButtons();
		}
		
		private function slideToRight():void {
			var nextXPos:Number = currPos + 619;
			if(nextXPos<=271) {
				factionIcons.x = currPos;
				currPos += 619;
				TweenLite.to(factionIcons, .5, {x:nextXPos, overwrite:false, ease:Expo.easeOut});
				//captions.prevFrame();
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

		
		
		private function factionSelected():void {
			trace("Faction selected!");
		}
		
	}
}