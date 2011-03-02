package akdcl.application.submit {
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.utils.ByteArray;
	
	import com.JPEGEncoder;

	import ui.manager.FLManager;
	import ui.Alert;
	
	import akdcl.utils.destroyObject;
	import akdcl.net.DataLoader;
	import akdcl.net.FormVariables;

	/**
	 * ...
	 * @author Akdcl
	 */
	public class Form {
		
		public var startX:uint = 0;
		public var startY:uint = 0;
		
		protected var data:Object;
		protected var fieldsData:Object;
		protected var fieldDic:Object;
		protected var submitXML:XML;
		protected var resultXML:XML;
		protected var alertXML:XML;
		protected var style:FormStyle;
		protected var alertSubmit:Alert;
		protected var jpegEncoder:JPEGEncoder;
		protected var formVars:FormVariables;

		public function setSource(_xml:XML, _container:DisplayObjectContainer = null, _views:Object = null):void {
			data = {};
			fieldsData = { };
			fieldDic = { };
			jpegEncoder = new JPEGEncoder();
			formVars = new FormVariables();
			
			submitXML = _xml.submit[0];
			resultXML = _xml.result[0];
			alertXML = _xml.alert[0];
			FLManager.setTextFormat(14, int(submitXML.style.@color));
			style = new FormStyle();
			style.startX = startX;
			style.startY = startY;
			if (submitXML.style.length() > 0){
				for each (var _styleParams:XML in submitXML.style.attributes()) {
					var _paramName:String = _styleParams.name();
					switch (_paramName){
						case "width":
						case "height":
						case "widthLabel":
						case "dxLF":
						case "dxRAC":
						case "dxFL":
						case "dyFF":
							style[_paramName] = int(submitXML.style.attribute(_paramName));
							break;
						case "colorLabel":
						case "colorNormal":
						case "colorHint":
						case "colorError":
						case "colorComplete":
							style[_paramName] = String(submitXML.style.attribute(_paramName));
							break;
					}
				}
			}

			var _offHeight:uint = 0;
			for (var _i:uint; _i < submitXML.children().length(); _i++){
				var _fieldXML:XML = submitXML.children()[_i];
				if (_fieldXML.attribute(Field.A_LABEL).length() == 0) {
					continue;
				}
				var _field:Field = new Field();
				_offHeight += _field.setSource(submitXML.children()[_i], _container, style, null, _offHeight);
				_offHeight += style.dyFF;
				fieldDic[_fieldXML.name()] = _field;
			}
			Alert.init(_container.stage);
		}

		public function add(_key:String, _value:*):void {
			if (_value.constructor === Object){
				for (var _i:String in _value){
					add(_i, _value[_i]);
				}
			} else {
				var _keyTo:String = submitXML.elements(_key)[0].attribute(Field.A_KEY).toString();
				data[_keyTo] = _value;
			}
		}

		//检查Field数据，规则正确则返回全部数据，data
		public function checkFieldsData():* {
			FLManager.setTextFormat(14, int(submitXML.style.@color));
			destroyObject(fieldsData);
			var _result:Boolean = true;
			for each (var _field:Field in fieldDic){
				var _data:* = _field.checkData();
				if (_data === false){
					//false（没有数据或数据非法）
					_result = false;
				} else if (_data === true){
					//true（字段为非必要且没有数据）
				} else {
					//data（数据）
					fieldsData[_field.name] = _data;
				}
			}
			if (_result){
				return fieldsData;
			} else {
				return null;
			}
		}
		
		public function upload():DataLoader {
			if (alertSubmit) {
				alertSubmit.remove();
			}
			alertSubmit = Alert.show(String(alertXML.submit).replace("${" + Field.A_VALUE + "}", 0), 0);
			//fieldData里是否包含BtyeArray，BitmapData
			var _isFormVar:Boolean;
			for (var _i:String in fieldsData) {
				var _data:*= fieldsData[_i];
				if (_data is ByteArray) {
					_isFormVar = true;
				}else if (_data is BitmapData) {
					_isFormVar = true;
					jpegEncoder.setQuality(int(submitXML.elements(_i)[0].attribute(Field.A_QUALITY)));
					fieldsData[_i] = jpegEncoder.encode(_data);
				}
			}
			var _submitType:String;
			if (_isFormVar) {
				_submitType = DataLoader.TYPE_FORM;
			}else if (submitXML.@dataType == "JSON") {
				_submitType = DataLoader.TYPE_JSON;
			}
			
			return DataLoader.load(submitXML.@url, onUploadingHandler, onUploadCompleteHandler, onUploadErrorHandler, fieldsData, _submitType);
		}
		
		protected function onUploadingHandler(_evt:ProgressEvent):void {
			var _progress:uint = Math.round(_evt.bytesLoaded / _evt.bytesTotal * 100);
			if (alertSubmit) {
				alertSubmit.text = String(alertXML.submit).replace("${" + Field.A_VALUE + "}", _progress);
			}
		}

		protected function onUploadCompleteHandler(_evt:Event):void {
			if (alertSubmit) {
				alertSubmit.remove();
			}
			var _dataLoader:DataLoader = _evt.currentTarget as DataLoader;
			trace(_dataLoader.data);
			
			var _data:*;
			if (resultXML.@dataType == "JSON"){
				_data = _dataLoader.dataJSON;
			} else {
				_data = _dataLoader.dataURLVariables;
			}
			
			if (_data) {
				var _xmlList:XMLList = resultXML.status.(attribute(Field.A_VALUE) == _data);
				var _str:String;
				switch (_xmlList.length()){
					case 0:
						//未知的结果
						_str = String(alertXML.unknownStatus).replace("${" + Field.A_VALUE + "}", _data);
						Alert.show(_str);
						break;
					case 1:
						if (_xmlList.@msg.length() > 0 || _xmlList.msg.length() > 0){
							Alert.show(_xmlList);
						} else {
							Common.getURLByXMLNode(_xmlList);
						}
						break;
					default:
						//重复的结果
						_str = String(alertXML.repeatStatus).replace("${" + Field.A_VALUE + "}", _data);
						Alert.show(_str);
						break;
				}
			}else {
				//错误的数据
				Alert.show(alertXML.resultError + "\n" + _dataLoader.data);
			}
		}

		protected function onUploadErrorHandler(_evt:Event):void {
			if (alertSubmit) {
				alertSubmit.remove();
			}
			//上传失败
			Alert.show(alertXML.subimtError);
		}
	}

}