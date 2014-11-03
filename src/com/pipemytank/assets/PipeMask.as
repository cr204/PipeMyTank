package com.pipemytank.assets
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	import com.pipemytank.events.FlowingBlockEvent;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.extensions.pixelmask.PixelMaskDisplayObject;
	
	public class PipeMask extends Sprite
	{
		private var pipeType:int = 0;
		private var rotPosition:int = 0;
		private var pipeMaskImage:Image;
		private var initX:Number;
		private var initY:Number;
		
		public function PipeMask(_type:int, rotPos:int)
		{
			pipeType = _type;
			rotPosition = rotPos;
		}
		
		public function createMask(nX:Number, nY:Number):void {
			pipeMaskImage = new Image(GameScene.assets.getTexture("pipe_mask"));
			pipeMaskImage.x = initX = nX;
			pipeMaskImage.y = initY = nY;
			var blackPipeBitmap:Image = new Image(GameScene.assets.getTexture(getPipeType(pipeType, rotPosition)));
			
			// for masks with animation:
			var maskedDisplayObject:PixelMaskDisplayObject = new PixelMaskDisplayObject();
			maskedDisplayObject.addChild(blackPipeBitmap);
			maskedDisplayObject.mask = pipeMaskImage;
			maskedDisplayObject.x = pipeMaskImage.width * -.5;
			maskedDisplayObject.y = pipeMaskImage.height * -.5;
			this.addChild(maskedDisplayObject);
			
			
			
/*			var tempMask:MaskMC = new MaskMC();
			tempMask.x = posX;
			tempMask.y = posY;
			tempMask.name = "masker" + numbOfMask.toString();
			addChild(tempMask);
			maskArr.push(tempMask);
			++numbOfMask;*/
		}
		
		public function showMask(n:Number):void {
//			trace("pipeMaskImage.x: " + pipeMaskImage.x + "   - y: " + pipeMaskImage.y);
			
			TweenLite.to(pipeMaskImage, n, {x:0, y:0, ease:Linear.easeNone, onComplete:completed});
		}
		
		private function completed():void {
			this.dispatchEvent(new FlowingBlockEvent("completed"));
		}
		
		public function resetMask():void {
			pipeMaskImage.x = initX;
			pipeMaskImage.y = initY;
		}
		
		
		private function getPipeType(n:int, p:int=0):String {
			var ret:String = "pipe51_black";
			if(n==6) n=5;
			if(n==7){
				ret = "pipe7";
			} else {
				if(p>0) {
					ret = "pipe" + n.toString() + p.toString() + "_black";
				} else ret = "pipe" + n.toString() + "_black";
			}
			return ret;
		}
		
	}
}