package com.pipemytank.assets
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Expo;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.textures.Texture;
	
	public class Block extends Button
	{
		private var cover:Image;
		private var clicked:int = 0;
		private var _type:int = 0;
		private var rotatePos:int = 1;
		
		public function Block(upState:Texture, text:String="", downState:Texture=null)
		{
			super(upState, text, downState);
			this.scaleWhenDown = 1;
			init();
		}
		
		private function init():void {
			cover = new Image(Assets.getAtlas().getTexture("block_allies"));
			cover.x = 39;
			cover.y = 39;
			cover.pivotX = cover.width * .5;
			cover.pivotY = cover.height * .5;
			cover.name = "Block";
			this.addChild(cover);
		}
		
		public function blockTriggered():void {
			++clicked;
			if(clicked<2) hideCover() else rotateBlock();
		}
		
		public function set type(n:int):void {
			_type = n;
		}
		
		private function hideCover():void {
			//if(parentObj.channel2_started) sound_uncover.play();
			TweenLite.to(cover, .3,{alpha:0, scaleX:.7, scaleY:.7, overwrite:false, ease:Expo.easeOut, 
				onComplete:function(){ /* hasCover=false; */ removeChild(cover);} });
		}
		
		private function rotateBlock():void {
			++rotatePos;
			switch(_type) {
				case 2:
				case 4:
					if(rotatePos>2) rotatePos=1;
					break;
				case 3:
				case 5:
					if(rotatePos>4) rotatePos=1;
					break;
				default:
					break;
			}
			trace(_type + ".rotateBlock: " + rotatePos);
		}
		
		
	}
}