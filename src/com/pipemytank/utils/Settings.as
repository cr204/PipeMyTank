package com.pipemytank.utils {
	
	public class Settings {
		private static var instance:Settings;
		private static var allowInstance:Boolean;
		private static var _sound:Boolean = true;
		private static var _selectedFactionName:String;
		private static var _selectedLocationName:String;
		private static var _selectedLevelName:String;

		public function Settings() { 
			if(!allowInstance) {
				throw new Error("Error: use Settings.getInstance() instead of new keyword");
			}
		}
		
		public static function getInstance():Settings {
			if(instance == null) {
				allowInstance = true;
				instance = new Settings();
				allowInstance = false;
				return instance;
			} else {
				//trace("Settings instance already exists");
			}
			return instance;
		}
		
		
		public function set selectedLevelName(s:String):void {
			_selectedLevelName = s;
		}
		
		public function get selectedLevelName():String {
			return _selectedLevelName;
		}
		
		public function set selectedLocationName(s:String):void {
			_selectedLocationName = s;
		}
		
		public function get selectedLocationName():String {
			return _selectedLocationName;
		}
		
		public function set selectedFactionName(s:String):void {
			_selectedFactionName = s;
		}
		
		public function get selectedFactionName():String {
			return _selectedFactionName;
		}
		
		public function set sound(b:Boolean):void {
			trace("####################: " + b);
			_sound = b;
		}
		
		public function get sound():Boolean {
			return _sound;
		}
		
	}
}