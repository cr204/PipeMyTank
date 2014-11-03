package com.pipemytank.assets
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	import com.pipemytank.assets.PipeMask;
	import com.pipemytank.events.FlowingBlockEvent;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class WaitingTank extends Sprite
	{
		private var arrTanks:Array = ["tank_allies", "tank_redarmy", "tank_wider"];
		private var orangePipeImg:Image;
		private var tankImg:Image;
		private var pipeMask:PipeMask;
		
		public function WaitingTank()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void {
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			orangePipeImg = new Image(GameScene.assets.getTexture("pipe21_red"));
			this.addChild(orangePipeImg);
			
			pipeMask = new PipeMask(2, 1);
			pipeMask.x = 40;
			pipeMask.y = 41;
			this.addChild(pipeMask);
			pipeMask.createMask(-80, 0);
			
			tankImg = new Image(GameScene.assets.getTexture(arrTanks[0]));
			tankImg.x = 20;
			this.addChild(tankImg);
		}
		
		public function fillTank(fTime:Number):void {
			pipeMask.showMask(fTime);
			pipeMask.addEventListener(FlowingBlockEvent.COMPLETED, moveTank);
		}
		
		private function moveTank(e:FlowingBlockEvent):void {
			pipeMask.removeEventListener(FlowingBlockEvent.COMPLETED, moveTank);
			//if(pObj.channel2_started) tankSound.play();
			orangePipeImg.visible = false;
			pipeMask.visible = false;
			TweenLite.to(tankImg, 2, {x:200, ease:Linear.easeNone});
		}
		
		public function reset():void {
			orangePipeImg.visible = true;
			pipeMask.visible = true;
			pipeMask.resetMask();
			tankImg.x = 20;
		}
		
		
	}
}