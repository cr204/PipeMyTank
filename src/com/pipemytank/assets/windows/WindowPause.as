package com.pipemytank.assets.windows
{
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Event;

	public class WindowPause extends WindowBase
	{
		private var btnContinue:Button;
		private var btnRestart:Button;
		private var btnMute:Button;
		private var btnExit:Button;
		
		public function WindowPause()
		{
			super();
		}
				
		override protected function drawWindow():void {
			var bgWindow:Image = new Image(GameScene.assets.getTexture("pause_window"));
			bgWindow.x = 370;
			bgWindow.y = 175;
			this.addChild(bgWindow);
			
			btnContinue = new Button(GameScene.assets.getTexture("wbtn_continue"));
			btnContinue.name = "btnContinue";
			btnContinue.x = 405;
			btnContinue.y = 295;
			this.addChild(btnContinue);
			
			btnRestart = new Button(GameScene.assets.getTexture("wbtn_restart"));
			btnRestart.name = "btnRestart";
			btnRestart.x = 405;
			btnRestart.y = 350;
			this.addChild(btnRestart);
			
			btnMute = new Button(GameScene.assets.getTexture("wbtn_mute"));
			btnMute.name = "btnMute";
			btnMute.x = 405;
			btnMute.y = 405;
			this.addChild(btnMute);
			
			btnExit = new Button(GameScene.assets.getTexture("wbtn_exit1"));
			btnExit.name = "btnExit";
			btnExit.x = 405;
			btnExit.y = 461;
			this.addChild(btnExit);
		}
		
		override protected function onTriggerHandler(e:Event):void {
			var targetBtn:Button = e.target as Button;
			trace(targetBtn.name);
			switch(targetBtn.name) {
				case "btnContinue":
					parentObj.removeCurrentWindow();
					break;
				case "btnRestart":
					break;
				case "btnMute":
					break;
				case "btnExit":
					parentObj.removeCurrentWindow();
					parentObj.returnPrevGameState();
					break;		
			}
		}
		
	}
}