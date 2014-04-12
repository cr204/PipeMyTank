package com.pipemytank.assets
{
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class Block extends Sprite
	{
		private var imgBlock:Image;
		
		public function Block()
		{
			super();
			init();
		}
		
		private function init():void {
			imgBlock = new Image(Assets.getAtlas().getTexture("block_allies"));
			this.addChild(imgBlock);
		}
		
	}
}