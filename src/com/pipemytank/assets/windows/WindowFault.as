package com.pipemytank.assets.windows
{
	import com.pipemytank.assets.CustomTextField;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Event;

	public class WindowFault extends WindowBase
	{
		private var levelNumberTxt:CustomTextField = new CustomTextField();
		private var btnExit:Button;
		private var btnReplay:Button;
		
		public function WindowFault()
		{
			super();
		}
		
		override protected function drawWindow():void {
			var bgWindow:Image = new Image(GameScene.assets.getTexture("fail_window"));
			bgWindow.x = 286;
			bgWindow.y = 250;
			this.addChild(bgWindow);
			
			levelNumberTxt.setFontSize(40);
			levelNumberTxt.setWidth(150);
			levelNumberTxt.setHeight(45);
			levelNumberTxt.x = 335;
			levelNumberTxt.y = 287;
			addChild(levelNumberTxt);
			levelNumberTxt.setText("1-1");
			
			btnExit = new Button(GameScene.assets.getTexture("wbtn_exit"));
			btnExit.name = "btnExit";
			btnExit.x = 349;
			btnExit.y = 394;
			this.addChild(btnExit);
			
			btnReplay = new Button(GameScene.assets.getTexture("wbtn_retry"));
			btnReplay.name = "btnReplay";
			btnReplay.x = 470;
			btnReplay.y = 390;
			this.addChild(btnReplay);
		}
		
		
		override protected function onTriggerHandler(e:Event):void {
			var targetBtn:Button = e.target as Button;
			trace(targetBtn.name);
			switch(targetBtn.name) {
				case "btnExit":
					break;
				case "btnReplay":
					break;
			}
		}
		
		
	}
}