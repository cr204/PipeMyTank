package com.pipemytank.assets.windows
{
	
	import com.pipemytank.assets.CustomTextField;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.events.Event;

	public class WindowVictory extends WindowBase
	{
		private var scoreTxt:CustomTextField = new CustomTextField();
		private var highScoreTxt:CustomTextField = new CustomTextField();
		private var refuelTanksTxt:CustomTextField = new CustomTextField();
		private var levelNumberTxt:CustomTextField = new CustomTextField();
		
		private var btnExit:Button;
		private var btnReplay:Button;
		private var btnNextLevel:Button;
		private var _stars:int = 0;
		
		public function WindowVictory()
		{
			super();
		}
		
		override protected function drawWindow():void {
			var bgWindow:Image = new Image(GameScene.assets.getTexture("victory_window"));
			bgWindow.x = 286;
			bgWindow.y = 103;
			this.addChild(bgWindow);
			
			scoreTxt.setFontSize(40);
			scoreTxt.setWidth(150);
			scoreTxt.setHeight(45);
			scoreTxt.x = 534;
			scoreTxt.y = 233;
			addChild(scoreTxt);
			
			highScoreTxt.setFontSize(40);
			highScoreTxt.setWidth(150);
			highScoreTxt.setHeight(45);
			highScoreTxt.x = 534;
			highScoreTxt.y = 280;
			addChild(highScoreTxt);
			
			refuelTanksTxt.setFontSize(40);
			refuelTanksTxt.setWidth(150);
			refuelTanksTxt.setHeight(45);
			refuelTanksTxt.setColor(0xE43E0E);
			refuelTanksTxt.x = 570;
			refuelTanksTxt.y = 499;
			addChild(refuelTanksTxt);
			refuelTanksTxt.setText("1");
			
			levelNumberTxt.setFontSize(40);
			levelNumberTxt.setWidth(150);
			levelNumberTxt.setHeight(45);
			levelNumberTxt.x = 335;
			levelNumberTxt.y = 140;
			addChild(levelNumberTxt);
			levelNumberTxt.setText("1-1");
			
			
			btnExit = new Button(GameScene.assets.getTexture("wbtn_exit"));
			btnExit.name = "btnExit";
			btnExit.x = 348;
			btnExit.y = 566;
			this.addChild(btnExit);
			
			btnReplay = new Button(GameScene.assets.getTexture("wbtn_retry"));
			btnReplay.name = "btnReplay";
			btnReplay.x = 472;
			btnReplay.y = 562;
			this.addChild(btnReplay);
			
			btnNextLevel = new Button(GameScene.assets.getTexture("wbtn_next_level"));
			btnNextLevel.name = "btnNextLevel";
			btnNextLevel.x = 601;
			btnNextLevel.y = 566;
			this.addChild(btnNextLevel);
			
			//setMedals(3);
		}
		
		override protected function onTriggerHandler(e:Event):void {
			var targetBtn:Button = e.target as Button;
			trace(targetBtn.name);
			switch(targetBtn.name) {
				case "btnExit":
					parentObj.removeCurrentWindow();
					parentObj.returnPrevGameState();
					break;
				case "btnReplay":
					break;
				case "btnNextLevel":
					break;
			}
		}
		
		
		
		
		private function setMedals(n:int):void {
			var medalIcon:Image = new Image(GameScene.assets.getTexture("wmedal"));
			medalIcon.x = 347;
			medalIcon.y = 337;
			this.addChild(medalIcon);
			
			var medalIcon1:Image = new Image(GameScene.assets.getTexture("wmedal"));
			medalIcon1.x = 463;
			medalIcon1.y = 337;
			this.addChild(medalIcon1);
			
			var medalIcon2:Image = new Image(GameScene.assets.getTexture("wmedal"));
			medalIcon2.x = 580;
			medalIcon2.y = 337;
			this.addChild(medalIcon2);
		}
		
		public function setOldScore(n:Number):void {
			
		}
		
		public function setScore(n:Number):void {
			scoreTxt.setText(n.toString());
		}
		
		public function tanksRefuelled(n:int):void {
			
		}
		
		public function showStars(n:int):void {
			_stars = n;
			setMedals(_stars); // temp oct20,2014
		}
		
//		windowVictory.levelNumbers.setNumbers(levelNumbers.getNumbers);
//		windowVictory.setOldScore(mainStage.USER_SCORE);
//		windowVictory.setScore(USER_SCORE);
//		windowVictory.tanksRefuelled(1);
//		windowVictory.showStars(countStars());
		
		private function getFrameNumber(s1:String, s2:String):String {
			var ret:String = "";
			ret = s1.substr((s1.length-1), 1) + "-";
			if(s2.length>6)	ret += s2.substr(5,2); 
			else 
				ret += s2.substr(5,1);
			return ret;
		}
		
		
	}
}