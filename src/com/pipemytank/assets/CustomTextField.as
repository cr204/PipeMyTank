package com.pipemytank.assets
{
	import flash.text.TextFormat;
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.utils.Color;
	
	public class CustomTextField extends Sprite
	{
		private var bmpFontTF:TextField;
		private var _fontName:String = "CCBattleCry";
		private var _txt:String = "00000";
		private var _color:uint = 0xFFFFFF;
		private var _size:int = 20;
		private var _width:Number = 70;
		private var _height:Number = 25;
		private var _textValue:String = "";
		
		public function CustomTextField()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		private function onAdded(e:Event):void {
			this.removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			var tFormat:TextFormat = new TextFormat();
			tFormat.letterSpacing = 2;
			
			bmpFontTF = new TextField(_width, _height, _txt, _fontName);
			bmpFontTF.fontSize = BitmapFont.NATIVE_SIZE; // the native bitmap font size, no scaling
			bmpFontTF.color = _color; // use white to use the texture as it is (no tinting)
			//bmpFontTF.border = true;
			bmpFontTF.hAlign = "left";
			//bmpFontTF.vAlign = "top";
			bmpFontTF.x = 0;
			bmpFontTF.y = 0;
			if(_textValue.length>0) bmpFontTF.text = _textValue;
			this.addChild(bmpFontTF);
		}
		
		public function setFontSize(n:int):void {
			var fFace:String = "CCBattleCry";
			switch(n) {
				case 32:
					fFace += n.toString();
					break;
				case 40:
					fFace += n.toString();
					break;
				case 48:
					fFace += n.toString();
					break;
				default:
					//
					break;
			}
			_fontName = fFace;
		}
		
		public function setColor(c:uint):void {
			_color = c;
		}
		
		public function setText(s:String):void {
			if(bmpFontTF) {
				bmpFontTF.text = s;
			}
			_textValue = s;
		}
		
		public function setWidth(n:Number):void {
			_width = n;
		}
		
		public function setHeight(n:Number):void {
			_height = n;
		}
		
		
	}
}