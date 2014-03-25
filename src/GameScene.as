package
{
	import com.pipemytank.events.NavigationEvent;
	import com.pipemytank.gamestates.GameState1;
	import com.pipemytank.gamestates.GameState2;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class GameScene extends Sprite
	{
		private var bg:Image;
		private var splashScreen:Image;
		private var btnBack:Button;
		private var gameState1:GameState1
		private var gameState2:GameState2;
		
		public function GameScene()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void {
			trace("starling framework initialized!");
			
/*			splashScreen = new Image(Assets.getTexture("splashScreen"));
			splashScreen.x = Math.ceil((stage.stageWidth - splashScreen.width) / 2);
			splashScreen.y = Math.ceil((stage.stageHeight - splashScreen.height) / 2);
			this.addChild(splashScreen);*/
			
			bg = new Image(Assets.getTexture("BgWelcome"));
			this.addChild(bg);
			
			this.addEventListener(NavigationEvent.CHANGE_SCREEN, onChangeScreen);
			
			gameState1 = new GameState1()
			this.addChild(gameState1);
			
			 gameState2 = new GameState2();
			 gameState2.disposeTemporarily();
			 this.addChild(gameState2);
			 
			 
			 
			 
			 btnBack = new Button(Assets.getAtlas().getTexture("btn_back"));
			 btnBack.x = 30;
			 btnBack.y = 707;
			 btnBack.width = 150;
			 btnBack.height = 47;
			 btnBack.visible = false;
			 btnBack.addEventListener(Event.TRIGGERED, onBackButtonClicked);
			 this.addChild(btnBack);
		}
		
		private function onChangeScreen(e:NavigationEvent):void 
		{
			switch(e.params.id) {
				case "play":
					gameState1.disposeTemporarily();
					//this.addChild(gameState2);
					gameState2.init();
					btnBack.visible = true;
					break;
				case "back":
					gameState2.disposeTemporarily();
					gameState1.init();
					btnBack.visible = false;
					break;
				default:
					trace("GS.onChangeScreen: default");
					break;
			}
		}
			
		private function onBackButtonClicked(e:Event):void {
			this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "back"}, true));
		}
		
	}
}