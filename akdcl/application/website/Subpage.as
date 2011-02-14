package akdcl.application.website{
	import flash.events.Event;
	import ui.UIMovieClip;
	import akdcl.application.IDPart;
	import akdcl.net.DataLoader;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class Subpage extends UIMovieClip {
		public var optionsXML:XML;
		public var sourceXML:XML;
		public var idPart:IDPart;
		protected var testSourceXMLPath:String;
		override protected function init():void {
			super.init();
			idPart = new IDPart();
			var _name:String = String(this).split(" ").pop().split("]").join("").toLowerCase();
			testSourceXMLPath = "xml/" + _name + ".xml";
		}
		override protected function onAddedToStageHandler(_evt:Event):void {
			super.onAddedToStageHandler(_evt);
			checkSourceXML();
		}
		private function checkSourceXML(_evt:Event = null):void {
			if (sourceXML) {
				sourceXMLReady();
			}else if (_evt) {
				if (_evt.currentTarget.data) {
					sourceXML = XML(_evt.currentTarget.data);
				}
				sourceXMLReady();
			}else if (optionsXML && optionsXML.@xml.length() > 0) {
				DataLoader.load(String(optionsXML.@xml), null, checkSourceXML, checkSourceXML);
			}else if (testSourceXMLPath) {
				DataLoader.load(testSourceXMLPath, null, checkSourceXML, checkSourceXML);
			}else {
				sourceXMLReady();
			}
		}
		protected function sourceXMLReady():void {
			visible = true;
		}
	}
}