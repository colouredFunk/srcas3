package akdcl.application.submit {
	import akdcl.net.DataLoader;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	
	import ui.manager.FLManager;
	import akdcl.utils.destroyObject;

	/**
	 * ...
	 * @author Akdcl
	 */
	public class Form {
		protected var submitXML:XML;
		protected var resultXML:XML;
		protected var fieldList:Array;
		protected var fieldData:Object;
		protected var data:Object;

		public function setSource(_xml:XML, _container:DisplayObjectContainer = null, _views:Object = null):void {
			FLManager.setTextFormat(14);
			fieldData = { };
			data = { };
			fieldList = [];
			submitXML = _xml.submit[0];
			resultXML = _xml.result[0];
			var _offHeight:uint = 0;
			for (var _i:uint; _i < submitXML.children().length(); _i++ ) {
				var _fieldXML:XML = submitXML.children()[_i];
				if (_fieldXML.@label.length() == 0) {
					continue;
				}
				var _field:Field = new Field();
				_offHeight += _field.setSource(submitXML.children()[_i], _container, null, _offHeight);
				fieldList[_i] = _field;
			}
		}
		public function add(_key:String, _value:*):void {
			if (_value.constructor === Object) {
				for (var _i:String in _value) {
					add(_i, _value[_i]);
				}
			}else {
				var _keyTo:String = submitXML.elements(_key)[0].attribute(Field.A_KEY).toString();
				data[_keyTo] = _value;
			}
		}
		//检查Field数据，规则正确则返回全部数据，data/false
		public function checkFieldsData():* {
			FLManager.setTextFormat(14);
			destroyObject(fieldData);
			var _result:Boolean = true;
			for each(var _field:Field  in fieldList) {
				if (_field) {
					var _data:*= _field.checkData();
					if (_data === false) {
						//返回false，field的data非法
						_result = false;
					}else if (_data === null) {
						//不是required的field返回null
					}else {
						fieldData[_field.name] = _data;
					}
				}
			}
			if (_result) {
				return fieldData;
			}else {
				return false;
			}
		}
		public function upload():DataLoader {
			//fieldData里包含btyeArray
			//submitXML.@dataType == "JSON"
			return DataLoader.load(submitXML.@url, null, onUploadCompleteHandler, onUploadErrorHandler, fieldData);
		}
		
		protected function onUploadCompleteHandler(_evt:Event):void {
			var _dataLoader:DataLoader = _evt.currentTarget as DataLoader;
			if (resultXML.@dataType == "JSON") {
				_dataLoader.dataJSON
			}else {
				_dataLoader.dataURLVariables;
				//_dataLoader.data
			}
			
		}
		
		protected function onUploadErrorHandler(_evt:Event):void {
			
		}
	}

}