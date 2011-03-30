package akdcl.application.submit {
	import akdcl.utils.traceObject;
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
	import akdcl.net.gotoURL;

	/**
	 * ...
	 * @author Akdcl
	 */
	public class Form {
		protected static const jpegEncoder:JPEGEncoder = new JPEGEncoder();

		public var uploadComplete:Function;
		public var uploadError:Function;
		public var startX:uint = 0;
		public var startY:uint = 0;

		protected var data:Object;
		protected var fieldsData:Object;
		protected var fields:Object;

		protected var submitXML:XML;
		protected var resultXML:XML;
		protected var alertXML:XML;

		protected var style:FormStyle;
		protected var alertSubmit:Alert;
		public function Form() {
			data = {};
		}
		public function remove():void {
			for each (var _field:Field in fields){
				_field.remove();
			}

			destroyObject(data);
			destroyObject(fieldsData);
			destroyObject(fields);

			uploadComplete = null;
			uploadError = null;

			data = null;
			fieldsData = null;
			fields = null;

			submitXML = null;
			resultXML = null;
			alertXML = null;

			style = null;
			if (alertSubmit){
				alertSubmit.remove();
			}
			alertSubmit = null;
		}

		public function setSource(_xml:XML, _container:DisplayObjectContainer = null, _views:Object = null):void {
			fieldsData = {};
			fields = {};

			submitXML = _xml.submit[0];
			resultXML = _xml.result[0];
			alertXML = _xml.alert[0];
			FLManager.setTextFormat(14, int(submitXML.style.@color));
			style = new FormStyle();
			style.startX = startX;
			style.startY = startY;
			if (submitXML.style.length() > 0){
				for each (var _styleParams:XML in submitXML.style.attributes()){
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
				if ((_fieldXML.attribute(Field.A_LABEL).length() > 0) || (_fieldXML.attribute(Field.A_STYLE_TYPE).length() > 0)){
					var _field:Field;
					if (_views) {
						if (_views[_fieldXML.name()]) {
							_field = new Field();
							_field.setSource(submitXML.children()[_i], _container, style, _views[_fieldXML.name()]);
						}else {
							//
							continue;
						}
					}else {
						_field = new Field();
						_offHeight += _field.setSource(submitXML.children()[_i], _container, style, null, _offHeight);
						_offHeight += style.dyFF;
					}
					fields[_fieldXML.name()] = _field;
				}
			}
		}

		public function add(_key:String, _value:*):void {
			if (_value.constructor === Object){
				for (var _i:String in _value){
					add(_i, _value[_i]);
				}
			} else {
				var _xmlList:XMLList = submitXML.elements(_key);
				if (_xmlList.length() > 0){
					var _keyTo:String = _xmlList[0].attribute(Field.A_KEY).toString();
					data[_keyTo] = _value;
				} else {
					data[_key] = _value;
					trace("添加的值并没有在配置的xml中\n", "key：" + _key, "value：" + _value);
				}
			}
		}

		//检查Field数据，规则正确则返回全部数据，data
		public function checkFieldsData():* {
			FLManager.setTextFormat(14, int(submitXML.style.@color));
			destroyObject(fieldsData);
			var _result:Boolean = true;
			for each (var _field:Field in fields){
				var _data:* = _field.checkData();
				if (_data === false){
					//false（没有数据或数据非法）
					_result = false;
				} else if (_data === true){
					//true（字段为非必要且没有数据）
				} else {
					//data（数据）
					fieldsData[_field.key] = _data;
				}
			}
			if (_result){
				return fieldsData;
			} else {
				return null;
			}
		}

		public function upload():DataLoader {
			if (alertSubmit){
				alertSubmit.remove();
			}
			alertSubmit = Alert.show(alertXML.submit, 0);
			//fieldData里是否包含BtyeArray，BitmapData
			var _isFormVar:Boolean;
			for (var _i:String in fieldsData){
				var _data:* = fieldsData[_i];
				if (_data is ByteArray){
					_isFormVar = true;
				} else if (_data is BitmapData){
					_isFormVar = true;
					jpegEncoder.setQuality(int(submitXML.elements(_i)[0].attribute(Field.A_QUALITY)));
					fieldsData[_i] = jpegEncoder.encode(_data);
				}
			}
			//
			for (_i in data){
				if (fieldsData[_i]){
					trace("覆盖了field原有数据：" + _i + "\n", "原有数据：" + fieldsData[_i], "添加数据：" + data[_i]);
				}
				fieldsData[_i] = data[_i];
			}
			//
			var _submitType:String = DataLoader.TYPE_URL;
			if (_isFormVar){
				_submitType = DataLoader.TYPE_FORM;
			} else if (submitXML.@dataStructure == "JSON"){
				_submitType = DataLoader.TYPE_JSON;
			}
			traceObject("提交数据格式:" + _submitType, fieldsData);
			return DataLoader.load(submitXML.@url, onUploadingHandler, onUploadCompleteHandler, onUploadErrorHandler, fieldsData, _submitType);
		}

		protected function onUploadingHandler(_evt:ProgressEvent):void {
			var _progress:uint = Math.round(_evt.bytesLoaded / _evt.bytesTotal * 100);
			if (alertSubmit){
				//alertSubmit.text = _progress;
			}
		}

		protected function onUploadCompleteHandler(_evt:Event):void {
			if (alertSubmit){
				alertSubmit.remove();
			}
			var _dataLoader:DataLoader = _evt.currentTarget as DataLoader;
			trace(_dataLoader.data);

			var _data:*;
			if (resultXML.@dataStructure == "JSON"){
				_data = _dataLoader.dataJSON;
			} else {
				_data = _dataLoader.dataURLVariables;
			}
			var _alert:Alert;
			if (_data){
				var _statusData:String = _data[resultXML.status.attribute(Field.A_KEY)];
				var _xmlList:XMLList = resultXML.status.elements(Field.E_ITEM).(attribute(Field.A_VALUE) == _statusData);
				var _str:String;
				var _xml:XML;
				switch (_xmlList.length()){
					case 0:
						//未知的结果
						_xml = XML(alertXML.unknownStatus);
						_xml.unknownStatus.@msg = String(alertXML.unknownStatus.@msg).replace("${" + Field.A_VALUE + "}", _data);
						_alert = Alert.show(_xml, 1, uploadError);
						break;
					case 1:
						if (_xmlList.@msg.length() > 0 || _xmlList.msg.length() > 0){
							_alert = Alert.show(_xmlList, 1, uploadComplete);
						} else {
							gotoURL(_xmlList);
						}
						break;
					default:
						//重复的结果
						_xml = XML(alertXML.repeatStatus[0]);
						_xml.repeatStatus.@msg = String(alertXML.repeatStatus.@msg).replace("${" + Field.A_VALUE + "}", _statusData);
						_alert = Alert.show(_xml, 1, uploadError);
						break;
				}
			} else {
				//错误的数据
				_alert = Alert.show(alertXML.resultError + "\n" + _dataLoader.data, 1, uploadError);
			}
			destroyObject(data);
		}

		protected function onUploadErrorHandler(_evt:Event):void {
			if (alertSubmit){
				alertSubmit.remove();
			}
			//上传失败
			var _alert:Alert = Alert.show(alertXML.subimtError, "重试|取消");
			_alert.callBack = function(_b:Boolean):void {
				if (_b){
					upload();
				}else {
					if (uploadError != null){
						uploadError();
					}
				}
			}
		}
	}

}