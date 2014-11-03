package com.pipemytank.assets
{
	import starling.display.Button;
	import starling.textures.Texture;
	
	public class FactionIcon extends Button
	{
		private var _locked:Boolean;
		
		public function FactionIcon(upState:Texture, text:String="", downState:Texture=null)
		{
			super(upState, text, downState);
			this.scaleWhenDown = 1;
		}
		
		public function set locked(b:Boolean):void {
			_locked = b;
		}
		
		public function get locked():Boolean {
			return _locked;
		}		
	}
}