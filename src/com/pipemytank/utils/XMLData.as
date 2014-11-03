package com.pipemytank.utils {
	
	import com.pipemytank.abstract.LevelDataObject;
	
	public class XMLData {
		public var mainXMLData:XML;
		private var facXML:XML;
		
		public function XMLData(xml:XML) {
			mainXMLData = xml;
			trace(xml);
		}
		
		public function getLevelData():LevelDataObject {
			var retObj:LevelDataObject = new LevelDataObject();
			
			facXML = getXMLByFactionName(Settings.getInstance().selectedFactionName);
			var locXML:Object = getLocationData(getLocationName(Settings.getInstance().selectedLocationName));
			
			retObj.levelName = locXML.lname;
			retObj.time = convertToSeconds(locXML.ltime);
			retObj.pipe1 = getPipeNumber("fourway");
			retObj.pipe2 = getPipeNumber("strightline");
			retObj.pipe3 = getPipeNumber("threeway");
			retObj.pipe4 = getPipeNumber("slowdown");
			retObj.pipe5 = getPipeNumber("curve");
			retObj.pipe6 = getPipeNumber("twoover");
			retObj.pipe7 = locXML.xblocks;
			return retObj;
		}
		
		public function getXBugData():Array {
			var retArr:Array = [];
			for each(var bXML:XML in mainXMLData.xbugs.elements()) {
				var st:String = bXML.@blocks.toString()
				retArr.push(st);
			}
			return retArr;
		}
		
		public function getBottomText():String {
			var ret:String = new String();
			ret = mainXMLData.settings.bottomText;
			return ret;
		}
		
		private function getPipeNumber(s:String):Number {
			var ret:Number = 0;
				for each(var lXML:XML in facXML.elements()) {
					if(lXML.localName()=="pipe") {
						if(s==lXML.@name.toString()) {
							ret = Number(lXML.@number);
						}
					}
				}
			return ret;
		}
		
		private function getLocationData(s2:String):Object {
			
			var retObj:Object = new Object();
				for each(var lXML:XML in facXML.elements()) {
					if(lXML.localName()=="location") {
						if(s2==lXML.@name.toString()) {
							retObj.lname = lXML.@name.toString();
							retObj.ltime = lXML.@time.toString();
							retObj.xblocks = lXML.@xblocks.toString();
						}
					}
				}
			
			return retObj;
		}
		
		private function getXMLByFactionName(s1:String):XML {
			var retXML:XML;
			for each(var fXML:XML in mainXMLData.factions.elements()) {
				if(s1==fXML.@name.toString()) retXML=fXML
			}
			return retXML;
		}
		
		private function convertToSeconds(s:String):Number {
			trace("convertToSeconds: " + s);
			
			var ret:Number = 0;
			var tm:Array = s.split(":");
			ret = Number(tm[0]) * 60 + Number(tm[1]);
			return ret;
		}
		
		private function getLocationName(s:String):String {
			var ret:String = "";
				switch(s) {
					case "location1":
						ret = "dday";
						break;
					case "location2":
						ret = "tunisia";
						break;
					case "location3":
						ret = "egypt";
						break;
					case "location4":
						ret = "ardennes";
						break;
					case "location5":
						ret = "berlin";
						break;
					case "location6":
						ret = "wolfenstein";
						break;
						
					case "rlocation1":
						ret = "moscow";
						break;
					case "rlocation2":
						ret = "stalingrad";
						break;
					case "rlocation3":
						ret = "leningrad";
						break;
					case "rlocation4":
						ret = "kursk";
						break;
					case "rlocation5":
						ret = "berlin";
						break;
					case "rlocation6":
						ret = "wolfenstein";
						break;
					
					case "wlocation1":
						ret = "berlin";
						break;
					case "wlocation2":
						ret = "tunisia";
						break;
					case "wlocation3":
						ret = "kursk";
						break;
					case "wlocation4":
						ret = "ardennes";
						break;
					case "wlocation5":
						ret = "moscow";
						break;
					case "wlocation6":
						ret = "dday";
						break;
				}
			
			return ret;
		}
		
	}
}