package com.pipemytank.assets
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	import com.pipemytank.gamestates.GameState5;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.extensions.pixelmask.PixelMaskDisplayObject;
	
	public class FuelTank extends Sprite
	{
		private var fuelTank:Image;
		private var fuelTankBlack:Image;
		private var tankMasker:Quad;
		private var timeTxt:CustomTextField = new CustomTextField();
		private var _animationTime:Number;
		
		
		private var parentObj:GameState5;
		private var maskerTween:TweenLite;
		private var _soundPlaying:Boolean = false;
//		private var timedecreasing:Sound = new Timedecreasingloop();
//		private var channel:SoundChannel = new SoundChannel();
//		private var alarmBeforeStart:Sound = new Alarmbeforeflowstart();
//		private var channel2:SoundChannel = new SoundChannel();
		private var _countdownStarted:Boolean = false;
		private var countTimer:Timer = new Timer(1000);
		private var quickCountdownTimer:Timer = new Timer(30);
		
		
		public function FuelTank()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function init(pObj:GameState5):void {
			parentObj = pObj;
		}
		
		private function onAddedToStage(e:Event):void {
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			fuelTank = new Image(GameScene.assets.getTexture("fuel_tank"));
			this.addChild(fuelTank);
			
			//fuelTankBlack = new Image(GameScene.assets.getTexture("fuel_tank_black"));
			//this.addChild(fuelTankBlack);
			
			createMasker();
			
			timeTxt.setFontSize(32);
			timeTxt.setWidth(90);
			timeTxt.setHeight(45);
			timeTxt.x = 25;
			timeTxt.y = 30;
			addChild(timeTxt);
			timeTxt.setText("00:00");
			
			countTimer.addEventListener("timer", timerHandler);
			quickCountdownTimer.addEventListener("timer", timerHandler1);
			
		}
		
		private function createMasker():void {

			//tankMasker = new Image(Assets.getAtlas().getTexture("pipe_mask"));
			tankMasker = new Quad(140, 80);
			tankMasker.x = 0;
			tankMasker.y = 81;
			var blackPipeBitmap:Image = new Image(GameScene.assets.getTexture("fuel_tank_black"));
			
			// for masks with animation:
			var maskedDisplayObject:PixelMaskDisplayObject = new PixelMaskDisplayObject();
			maskedDisplayObject.addChild(blackPipeBitmap);
			maskedDisplayObject.mask = tankMasker;
			maskedDisplayObject.x = 0;
			maskedDisplayObject.y = 0;
			this.addChild(maskedDisplayObject);  
		}
		
		
		
		public function set animationTime(n:Number):void {
			_animationTime = n;
			timeTxt.setText(convertToHHMMSS(_animationTime));
		}
		
		public function reset():void {
			countTimer.stop();
			quickCountdownTimer.stop();
			
			tankMasker.y = 81;
			timeTxt.visible = true;
			TweenLite.killTweensOf(tankMasker);
			_countdownStarted = false;
		}
		
		public function startAnimation():void {
			_soundPlaying = false;
			//	channel = timedecreasing.play(1,99);
			maskerTween = new TweenLite(tankMasker, _animationTime, {y:7, overwrite:false, ease:Linear.easeNone});
			_countdownStarted = true;
			startCountdown();
		}
		
		
		public function pauseGame():void {
			countTimer.stop();
			if(maskerTween) maskerTween.pause();
		}
		
		private function resumeGame():void {
			if(_countdownStarted) countTimer.start();
			if(maskerTween) maskerTween.play();
		}
		
		private function startCountdown():void {
			countTimer.start();
		}
		
		public	function quickFill():void {
//		    channel.stop();
			countTimer.stop();
			maskerTween.pause();
			maskerTween = new TweenLite(tankMasker, .2, {y:7, ease:Linear.easeNone, onComplete:fuelFilled});
		}
		
		private function quickTimeCountForScore():Number {
			quickCountdownTimer.start();
			return _animationTime;
		}
		
		private function fuelFilled():void {
		parentObj.startFlowing0();
		stopSound();
		}
		
		private function stopSound():void {
		//channel.stop();
		_soundPlaying = false;
		}
		
		
		private function timerHandler(e:TimerEvent):void {
			decreaseTimer();
		}
		
		private function decreaseTimer():void {
			--_animationTime;
			
			timeTxt.setText(convertToHHMMSS(_animationTime));
			
			/*if(_animationTime==16 && !_soundPlaying) {
				pObj.musicVolumeDown(5);
			} 
			
			if(_animationTime<11 && !_soundPlaying) {
				pObj.stopIngameMusic();
				if(pObj.channel2_started) channel = timedecreasing.play(1,99);
				_soundPlaying = true;
			} */
			
			if(_animationTime==0) {
				countTimer.stop();
				fuelFilled();
				TweenLite.to(timeTxt, 0, {delay:1, onComplete:function(){timeTxt.visible=false} });
				_soundPlaying = false;
				
/*				if(pObj.channel2_started) {
					if(!pObj._gameOver) {
						channel2 = alarmBeforeStart.play(1, 3);
						var transform:SoundTransform = channel2.soundTransform;
						transform.volume = .4;
						channel2.soundTransform = transform;
					}
				}  */
			}
		}
		
		private function timerHandler1(e:TimerEvent):void {
			decreaseTimer1();
		}
		
		private function decreaseTimer1():void {
			_animationTime -=10;
			if(_animationTime<=0) {
				_animationTime = 0;
				quickCountdownTimer.stop();
			}
			timeTxt.setText(convertToHHMMSS(_animationTime));
		}
		
		private function convertToHHMMSS(seconds:Number):String	{
			var s:Number = seconds % 60;
			var m:Number = Math.floor((seconds % 3600 ) / 60);
			var minuteStr:String = doubleDigitFormat(m) + ":";
			var secondsStr:String = doubleDigitFormat(s);
			
			return minuteStr + secondsStr;
		}
		
		private function doubleDigitFormat($num:uint):String {
			if ($num < 10)
			{
				return ("0" + $num);
			}
			return String($num);
		}
		
		
		
		
		
	}
}