package com.pipemytank.assets
{
	import com.greensock.TweenLite;
	import com.pipemytank.gamestates.GameState5;
	
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class ScreenCountdown extends Sprite
	{
		private var _init:Boolean = false;
		private var countInt:int;
		private var countTxt:CustomTextField;
		private var goTxt:Image;
		private var animTween:TweenLite;
		private var parentObj:GameState5; 
		
		public function ScreenCountdown()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		public function init(pObj:GameState5):void {
			parentObj = pObj;
		}
		
		private function onAdded(e:Event):void {
			if(!_init) initAssets();
		}
		
		private function initAssets():void {
			var q:starling.display.Quad = new Quad(1024, 768); 
			q.setVertexColor(0, 0x000000);
			q.setVertexColor(1, 0x000000);
			q.setVertexColor(2, 0x000000);
			q.setVertexColor(3, 0x000000);
			q.alpha = .75;
			addChild (q);
			
			countTxt = new CustomTextField();
			countTxt.setFontSize(40);
			countTxt.setWidth(40);
			countTxt.setHeight(45);
			countTxt.setColor(0xFF0000);
			countTxt.x = 512;
			countTxt.y = 407;
			addChild(countTxt);
			countTxt.setText("3");
			countTxt.pivotX = countTxt.width * .5;
			countTxt.pivotY = countTxt.height * .5;
			countTxt.textAlign("center");
			
			goTxt = new Image(GameScene.assets.getTexture("go"));
			goTxt.pivotX = goTxt.width * .5;
			goTxt.pivotY = goTxt.height * .5;
			goTxt.scaleX = goTxt.scaleY = 1.5;
			goTxt.x = 512;
			goTxt.y = 407;
			goTxt.alpha = 0;
			this.addChild(goTxt);
				
			_init = true;
		}
		
		public function startCoundown():void {
			countInt = 3;
			countTxt.visible = true;
			countTxt.setText(countInt.toString());
			showAnimation(countTxt);
		}
		
		public function pauseCountdown():void {

		}
		
		public function resumeCountdown():void {

		}
		
		private function showAnimation(dispObj:DisplayObject):void {
			dispObj.scaleX = dispObj.scaleY = 2;
			dispObj.alpha = 0;
			animTween = new TweenLite(dispObj, .5, {scaleX:1, scaleY:1, alpha:1, onComplete:cFunction});
		}
		
		private function cFunction():void {
			TweenLite.to(this, 0, {delay:.5, 
				onComplete:function(){
					--countInt;
					if(countInt<0) {
						goTxt.visible = false;
						parentObj.startCountdown();
					} else if(countInt<1) {
						countTxt.visible = false;
						showAnimation(goTxt);
					} else {
						countTxt.setText(countInt.toString());
						showAnimation(countTxt);
					}				
				}
			});

		}
		
	}
}