package akdcl.application.submit {
	import flash.display.DisplayObjectContainer;
	import ui.manager.FLManager;

	/**
	 * ...
	 * @author Akdcl
	 */
	public class Form {
		protected var sourceXML:XML;
		protected var fieldList:Array;
		protected var checkResultList:Array;

		public function setSource(_xml:XML, _container:DisplayObjectContainer, _views:Object=null):void {
			fieldList = [];
			checkResultList = [];
			sourceXML = _xml;
			
			for (var _i:uint; _i < sourceXML.children().length(); _i++ ) {
				var _fieldXML:XML = sourceXML.children()[_i];
				if (_fieldXML.@label.length() == 0) {
					continue;
				}
				var _field:Field = new Field();
				_field.setSource(sourceXML.children()[_i], _container);
				fieldList[_i] = _field;
			}
			FLManager.setTextFormat(14);
		}
		public function checkData():void {
			FLManager.setTextFormat(14);
			for each(var _field:Field in fieldList) {
				if (_field) {
					_field.checkData(true);
				}
			}
		}
	}

}