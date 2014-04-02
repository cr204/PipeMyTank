package
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Expo;
	import com.pipemytank.events.NavigationEvent;
	import com.pipemytank.gamestates.GameState;
	import com.pipemytank.gamestates.GameState1;
	import com.pipemytank.gamestates.GameState2;
	import com.pipemytank.gamestates.GameState3;
	import com.pipemytank.gamestates.GameState4;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
    import fr.kouma.starling.utils.Stats;
	
	public class GameScene extends Sprite
	{
		private var bg:Image;
		private var splashScreen:Image;
		private var btnBack:Button;
		private var stateHolder:Sprite;
		private var gameState1:GameState1
		private var gameState2:GameState2;
		private var gameState3:GameState3;
		private var gameState4:GameState4;
		
		private var prevStateID:int = 0;
		
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
			
			stateHolder = new Sprite();
			this.addChild(stateHolder);
			
			gameState1 = new GameState1();
			gameState2 = new GameState2();
			gameState3 = new GameState3();
			gameState4 = new GameState4();
			 
			switchGameState(gameState1);
			 
			btnBack = new Button(Assets.getAtlas().getTexture("btn_back"));
			btnBack.x = 30;
			btnBack.y = 707;
			btnBack.width = 150;
			btnBack.height = 47;
			btnBack.visible = false;
			btnBack.addEventListener(Event.TRIGGERED, onBackButtonClicked);
			this.addChild(btnBack);
			
			this.addChild(new Stats());
		}
		
		private function onChangeScreen(e:NavigationEvent):void 
		{
			switch(e.params.id) {
				case "play":
					switchGameState(gameState2);
					btnBack.visible = true;
					break;
				case "factionSelected":
					switchGameState(gameState3);
					break;
				case "mapSelected":
					switchGameState(gameState4);
					break;
				case "back":
					switchGameStateBack();
					break;
				default:
					trace("GS.onChangeScreen: default");
					break;
			}
		}
		
		private function switchGameStateBack():void {
			trace("switchGameStateBack.prevStateID: " + prevStateID);
			switch(prevStateID) {
				case 1:
					trace("1");
					break;
				case 2:
					switchGameState(gameState1);
					btnBack.visible = false;
					break;
				case 3:
					switchGameState(gameState2);
					break;
				case 4:
					switchGameState(gameState3);
					break;
			}
				
		}
		
		
		private function switchGameState(gs:GameState) {
			trace("switchGameState - prevStateID: " + prevStateID + "   gs.stateID: " + gs.stateID);
			// STATE 1
			if(gs.stateID==1) {
				//btnBack.y = 610;
				//				btnLeaderboard.y = 3;
				
				// FROM STATE 0 to STATE 1
				if(prevStateID==0) {
					stateHolder.addChild(gs);
					
				}
				// FROM STATE 2 to STATE 1
				if(prevStateID==2) {
					TweenLite.to(gameState2, .3, {x:400, alpha:0, overwrite:false, ease:Expo.easeOut});
					//bottomLine.startSliding();
					//TweenLite.to(bottomLine, .3, {y:565, overwrite:false});
					gameState2.disposeTemporarily();
					TweenLite.to(this, 0, {delay:.3, overwrite:false, onComplete:function(){ stateHolder.removeChild(gameState2);} });
					stateHolder.addChild(gameState1);
					gameState1.alpha = 0;
					gameState1.x = -400;
					TweenLite.to(gameState1, .6, {x:0, alpha:1, overwrite:false, ease:Expo.easeOut});
				}
			}
			
			// STATE 2
			if(gs.stateID==2) {
				// FROM STATE 1 to STATE 2
				if(prevStateID==1) {
					//btnBack.y = 563;
					//					btnLeaderboard.y = -50;
					gameState1.disposeTemporarily();
					TweenLite.to(gameState1, .3, {x:-300, alpha:0, overwrite:false, ease:Expo.easeOut, onComplete:function(){ stateHolder.removeChild(gameState1);} });
					//bottomLine.stopSliding();
					//TweenLite.to(bottomLine, .3, {y:600, overwrite:false});
					stateHolder.addChild(gameState2);
					gameState2.alpha = 0;
					gameState2.x = 400;
					TweenLite.to(gameState2, .6, {x:0, alpha:1, overwrite:false, ease:Expo.easeOut});
				}
				// FROM STATE 3 to STATE 2
				if(prevStateID==3) {
					TweenLite.to(gameState3, .3, {y:-400, alpha:0, overwrite:false, ease:Expo.easeOut, 
						onComplete:function(){ stateHolder.removeChild(gameState3); }});
					
					stateHolder.addChild(gameState2);
					gameState2.alpha = 0;
					gameState2.y = 400;
					TweenLite.to(gameState2, .6, {y:0, alpha:1, overwrite:false, ease:Expo.easeOut});
				}
				// FROM STATE 5 to STATE 2
/*				if(prevStateID==5) {
					trace("switchGameState FROM STATE 5 to STATE 2")
					TweenLite.to(gameState5, .5, {y:-400, alpha:0, overwrite:false, ease:Exponential.easeOut, 
						onComplete:function(){ startMenuMusic(); stateHolder.removeChild(gameState5); }});
					
					stateHolder.addChild(gameState2);
					gameState2.alpha = 0;
					gameState2.y = 400;
					TweenLite.to(gameState2, .8, {y:0, alpha:1, overwrite:false, ease:Exponential.easeOut, onComplete:unlockNextFaction });
					btnBack.visible = true;
					btnBack.y = 563;
					backgrounds.gotoAndStop(1);
				}*/
				
			}
			
			// STATE 3
			if(gs.stateID==3) {
				// FROM STATE 2 to STATE 3 
				if(prevStateID==2) {
					TweenLite.to(gameState2, .3, {y:400, alpha:0, overwrite:false, ease:Expo.easeOut, 
						onComplete:function(){ stateHolder.removeChild(gameState2); }});
					//gameState3.openGameState();
					stateHolder.addChild(gameState3);
					gameState3.alpha = 0;
					gameState3.y = -400;
					//gameState3.playIfMapAnimation();
					TweenLite.to(gameState3, .6, {y:0, alpha:1, overwrite:false, ease:Expo.easeOut});
				}
				// FROM STATE 4 to STATE 3
				if(prevStateID==4) {
					TweenLite.to(gameState4, .3, {y:-400, alpha:0, overwrite:false, ease:Expo.easeOut, 
						onComplete:function(){stateHolder.removeChild(gameState4); }});
					//gameState3.openGameState();
					stateHolder.addChild(gameState3);
					gameState3.alpha = 0;
					gameState3.y = 400;
					//gameState3.playIfMapAnimation();
					TweenLite.to(gameState3, .6, {y:0, alpha:1, overwrite:false, ease:Expo.easeOut});
					//backgrounds.gotoAndStop(1);
				}
				/*				if(prevStateID==5) {
					trace("switchGameState FROM STATE 5 to STATE 3")
					TweenLite.to(gameState5, .5, {y:-400, alpha:0, overwrite:false, ease:Exponential.easeOut, 
						onComplete:function(){ startMenuMusic(); stateHolder.removeChild(gameState5); }});
					gameState3.openGameState();
					stateHolder.addChild(gameState3);
					btnBack.visible = true;
					btnBack.y = 563;
					gameState3.alpha = 0;
					gameState3.y = 400;
					gameState3.playIfMapAnimation();
					TweenLite.to(gameState3, .8, {y:0, alpha:1, overwrite:false, ease:Exponential.easeOut});
					backgrounds.gotoAndStop(1);
				}*/
			}
			
			//STATE 4
			if(gs.stateID==4) {
				// FROM STATE 3 to STATE 4
				if(prevStateID==3) {
					//USER_SCORE = 0;
					TweenLite.to(gameState3, .3, {y:400, alpha:0, overwrite:false, ease:Expo.easeOut, 
						onComplete:function(){stateHolder.removeChild(gameState3); }});
					//gameState4.openGameState();
					gameState4.scaleX = gameState4.scaleY = 1;
					gameState4.x = gameState4.y = 0;
					stateHolder.addChild(gameState4);
					gameState4.alpha = 0;
					gameState4.y = -400;
					TweenLite.to(gameState4, .6, {y:0, alpha:1, overwrite:false, ease:Expo.easeOut});
				}
/*				// FROM STATE 5 to STATE 4
				if(prevStateID==5) {
					stateHolder.addChild(gameState4);
					gameState4.openGameState();
					gameState4.alpha = 0;
					gameState4.x = gameState4.y = -75;
					gameState4.scaleX = gameState4.scaleY = 1.2;
					gameState4.cacheAsBitmap = true;
					TweenLite.to(gameState4, .5, {x:0, y:0, scaleX:1, scaleY:1, alpha:1, overwrite:false, ease:Expo.easeOut,
						onComplete:function(){gameState4.cacheAsBitmap=false; startMenuMusic(); }});
					gameState5.stopIngameMusic();
					stateHolder.removeChild(gameState5);
				}*/
			}
			
			
			prevStateID = gs.stateID;
			
		}
		
		private function onBackButtonClicked(e:Event):void {
			this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "back"}, true));
		}
		
	}
}