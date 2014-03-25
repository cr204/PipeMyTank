package
{
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class Assets
	{
		[Embed(source="../assets/graphics/splash_screen.png")]
		public static const splashScreen:Class;
		
		[Embed(source="../assets/graphics/bgWelcome.jpg")]
		public static const BgWelcome:Class;
		
		private static var gameTextures:Dictionary = new Dictionary();
		private static var gameTextureAtlas:TextureAtlas;
		
		[Embed(source="../assets/graphics/Spritesheet.png")]
		public static const AtlasTexureGame:Class;
		
		[Embed(source="../assets/graphics/Spritesheet.xml", mimeType="application/octet-stream")]
		public static const AtlasXmlGame:Class;
		
		public static function getAtlas():TextureAtlas 
		{
			if(gameTextureAtlas == null)
			{
				var texture:Texture = getTexture("AtlasTexureGame");
				var xml:XML = XML(new AtlasXmlGame());
				gameTextureAtlas = new TextureAtlas(texture, xml);
			}
			return gameTextureAtlas;
		}
		
		public static function getTexture(name:String):Texture 
		{
			if(gameTextures[name] == undefined) 
			{
				var bitmap:Bitmap = new Assets[name]();
				gameTextures[name] = Texture.fromBitmap(bitmap);
			}
			return gameTextures[name];	
		}
			
	}
}