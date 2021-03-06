package
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Expo;
	import com.pipemytank.abstract.LevelDataObject;
	import com.pipemytank.events.NavigationEvent;
	import com.pipemytank.gamestates.GameState;
	import com.pipemytank.gamestates.GameState1;
	import com.pipemytank.gamestates.GameState2;
	import com.pipemytank.gamestates.GameState3;
	import com.pipemytank.gamestates.GameState4;
	import com.pipemytank.gamestates.GameState5;
	import com.pipemytank.utils.ProgressBar;
	import com.pipemytank.utils.Settings;
	import com.pipemytank.utils.XMLData;
	
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import fr.kouma.starling.utils.Stats;
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.AssetManager;
	
	public class GameScene extends Sprite
	{
		private static const LEVELS_XML_PATH:String = "/assets/xml/game_levels.xml";
		
		private var bg:Image;
		private var splashScreen:Image;
		private var btnBack:Button;
		private var stateHolder:Sprite;
		private var gameState1:GameState1
		private var gameState2:GameState2;
		private var gameState3:GameState3;
		private var gameState4:GameState4;
		private var gameState5:GameState5;
		
		public var xmlData:XMLData;
/*		public var selectedFaction:Sprite;
		public var selectedFactionName:String;
		public var selectedLocationName:String;
		public var selectedLocationStars:int = 0;
		public var selectedLevelName:String;  */
		
		private var prevStateID:int = 0;
		private var _levelsXMLLoaded:Boolean = false;
		
		private var mLoadingProgress:ProgressBar;
		private static var sAssets:AssetManager;
		private var appDir:File;
		
		public function GameScene()
		{
			// nothing to do here -- Startup will call "start" immediately.
		}
		
		//public function start(background:Texture, assets:AssetManager):void
		public function start(assets:AssetManager):void
		{
			sAssets = assets;
			
			// The background is passed into this method for two reasons:
			// 
			// 1) we need it right away, otherwise we have an empty frame
			// 2) the Startup class can decide on the right image, depending on the device.
			
			//addChild(new Image(background));
			
			// The AssetManager contains all the raw asset data, but has not created the textures
			// yet. This takes some time (the assets might be loaded from disk or even via the
			// network), during which we display a progress indicator. 
			
			mLoadingProgress = new ProgressBar(175, 20);
			mLoadingProgress.x = 200; //(background.width  - mLoadingProgress.width) / 2;
			mLoadingProgress.y = 200; //background.height * 0.7;
			addChild(mLoadingProgress);
			
			assets.loadQueue(function(ratio:Number):void
			{
				mLoadingProgress.ratio = ratio;
				// a progress bar should always show the 100% for a while,
				// so we show the main menu only after a short delay. 
				
				if (ratio == 1)
					Starling.juggler.delayCall(function():void
					{
						mLoadingProgress.removeFromParent(true);
						mLoadingProgress = null;
						init();
					}, 0.15);
			});
			assets.enqueue(EmbeddedAssets);
			
		}
		
		public function setPath(_appDir:File):void {
			appDir = _appDir;
			loadGameXML();
		}
		
		private function loadGameXML():void {
			var xmlLoader:URLLoader = new URLLoader();
			xmlLoader.addEventListener(flash.events.Event.COMPLETE, onLevelsXMLLoaded);
			xmlLoader.load(new URLRequest(appDir.url + LEVELS_XML_PATH));
		}
		
		private function onLevelsXMLLoaded(e:flash.events.Event):void {
			try {
			trace("Levels XML loaded succesfully!");
				var mainData:XML = new XML( e.target.data );
				xmlData = new XMLData(mainData);
				_levelsXMLLoaded = true;
			} catch(err:Error) {
				trace(LEVELS_XML_PATH + " file loading Error:" + err.message);
				_levelsXMLLoaded = true;
			return;
			}
		}
		
		public function getXMLData():LevelDataObject {
			var ret:LevelDataObject = xmlData.getLevelData();
			return ret;
		}
		
		
		
		private function init():void {
			trace("starling framework initialized!");
			
			bg = new Image(assets.getTexture("BgWelcome"));
			this.addChild(bg);
						
			this.addEventListener(NavigationEvent.CHANGE_SCREEN, onChangeScreen);
			
			stateHolder = new Sprite();
			this.addChild(stateHolder);
			
/*			selectedFactionName = new String();
			selectedLocationName = new String();
			selectedLevelName = new String(); */
			
			gameState1 = new GameState1();
			gameState2 = new GameState2();
			gameState3 = new GameState3();
			gameState4 = new GameState4();
			gameState5 = new GameState5();
			gameState5.init(this);
			
			
			switchGameState(gameState1);
			 
			btnBack = new Button(assets.getTexture("btn_back"));
			btnBack.x = 30;
			btnBack.y = 707;
			btnBack.width = 150;
			btnBack.height = 47;
			btnBack.visible = false;
			btnBack.addEventListener(starling.events.Event.TRIGGERED, onBackButtonClicked);
			this.addChild(btnBack);
			
			//this.addChild(new Stats());
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
				case "levelSelected":
					btnBack.visible = false;
					switchGameState(gameState5);
					break;
				case "back":
					switchGameStateBack();
					break;
				default:
					trace("GS.onChangeScreen: default");
					break;
			}
		}
		
		
		private function switchGameState(gs:GameState) {
			//trace("switchGameState - prevStateID: " + prevStateID + "   gs.stateID: " + gs.stateID);
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
				// FROM STATE 5 to STATE 4
				if(prevStateID==5) {
					stateHolder.addChild(gameState4);
					//gameState4.openGameState();
					gameState4.alpha = 0;
					gameState4.x = gameState4.y = -75;
					gameState4.scaleX = gameState4.scaleY = 1.2;
					//gameState4.cacheAsBitmap = true;
					TweenLite.to(gameState4, .5, {x:0, y:0, scaleX:1, scaleY:1, alpha:1, overwrite:false, ease:Expo.easeOut,
						onComplete:function(){ /* startMenuMusic();  */ }});
					//gameState5.stopIngameMusic();
					stateHolder.removeChild(gameState5);
				}
			}
			
			//STATE 5
			if(gs.stateID==5) {
				// FROM STATE 4 to STATE 5
				if(prevStateID==4) {
					//btnBack.y = 610;
					TweenLite.to(gameState4, .7, {x:-75, y:-75, scaleX:1.2, scaleY:1.2, alpha:0, overwrite:false, ease:Expo.easeOut, 
						onComplete:function(){stateHolder.removeChild(gameState4); }});
					gameState5.x = gameState5.y = 0;
					gameState5.alpha=1;
					//gameState5.init(this);
					stateHolder.addChildAt(gameState5, 0);
					//stopMenuMusic();
				}
			}
			
			prevStateID = gs.stateID;
			
		}
		
		private function switchGameStateBack():void {
			//trace("switchGameStateBack.prevStateID: " + prevStateID);
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
				case 5:
					switchGameState(gameState4);
					btnBack.visible = true;
					break;
			}
			
		}
		
		private function onBackButtonClicked(e:starling.events.Event):void {
			this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "back"}, true));
		}
		
		public function unlockNextMap():void {
			if(Settings.getInstance().selectedLocationName.slice(8)=="6") {
				trace("unlockNextMap()"); //.selectedLocationName: " + selectedLocationName.slice(8));
				switchGameState(gameState2);
			} else switchGameState(gameState3);
		}
		
		
		
		
		
		
		
		public static function get assets():AssetManager { return sAssets; }
		
		
	}
}