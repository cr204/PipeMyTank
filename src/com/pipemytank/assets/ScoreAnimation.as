package com.pipemytank.assets
{
	import com.greensock.TweenLite;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	public class ScoreAnimation extends Sprite
	{
		private var imgScore:Image;
		private var animTime:Number = 1;
		private var mMovie:MovieClip;
		public function ScoreAnimation(n:int)
		{
			super();
			var imgName:String;
			switch(n) {
				case -10:
					imgName = "score_-10";
					animTime = .5;
					createBgAnimAtion();
					break;
				case 100:
					imgName = "score_100";
					break;
			}
			imgScore = new Image(GameScene.assets.getTexture(imgName));
			imgScore.x = 4
			imgScore.y = 10;
			this.addChild(imgScore);
		}
		
		public function set animationTime(n:Number):void {
			animTime = n;
		}
		
		public function playAnimation():void {
			TweenLite.to(imgScore, animTime, {y:-40, alpha:0, delay:.1, onComplete:onCompleted });
		}
		
		private function onCompleted():void {
			this.removeChild(imgScore);
			if(mMovie) {
				mMovie.stop();
				this.removeChild(mMovie);
			}
		}
		
		private function createBgAnimAtion():void {
			// retrieve the frames the running boy frames
			var frames:Vector.<Texture> = GameScene.assets.getTextures("dust_effect");
			// creates a MovieClip playing at 40fps 
			mMovie = new MovieClip(frames, 10);
			
			// centers 
			mMovie.x = -40; //stage.stageWidth - mMovie.width >> 1;
			mMovie.y = -40; //stage.stageHeight - mMovie.height >> 1;
			// show it 
			addChild (mMovie);
			
			// animate them
			Starling.juggler.add(mMovie); 
			 
						
		}
		
	}
}