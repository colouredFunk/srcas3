package akdcl.application.submit {
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.utils.setTimeout;
	import flash.text.TextFieldAutoSize;

	import fl.controls.Label;
	import fl.controls.TextInput;
	import fl.controls.TextArea;
	import fl.controls.ComboBox;
	import fl.controls.RadioButton;
	import fl.controls.CheckBox;

	import fl.core.UIComponent;

	import akdcl.utils.stringToBoolean;
	import akdcl.net.DataLoader;

	/**
	 * ...
	 * @author Akdcl
	 */
	public class Field {
		public static const A_REQUIRED:String = "required";
		public static const A_RESTRICT:String = "restrict";
		public static const A_KEY:String = "key";
		public static const A_REG:String = "reg";
		public static const A_LEAST:String = "least";
		public static const A_MOST:String = "most";
		public static const A_PASSWORD:String = "password";
		public static const A_LABEL:String = "label";
		public static const A_HINT:String = "hint";
		public static const A_STYLE_TYPE:String = "styleType";
		public static const A_SOURCE:String = "source";
		public static const A_ROW_COUNT:String = "rowCount";
		public static const A_PROMPT:String = "prompt";
		public static const A_VALUE:String = "value";

		public static const A_TEXT_INPUT:String = "TextInput";
		public static const A_TEXT_AREA:String = "TextArea";
		public static const A_COMBO_BOX:String = "ComboBox";
		public static const A_RADIO_BUTTON:String = "RadioButton";
		public static const A_CHECK_BOX:String = "CheckBox";

		public static const E_ITEM:String = "item";

		public static const STRING_DEFAULT:String = "";


		public static var ERROR_UNDATA:String = "errorUndata";
		public static var ERROR_LEAST:String = "errorLeast";
		public static var ERROR_MOST:String = "errorMost";
		public static var ERROR_REG:String = "errorREG";
		public static var ERROR_UNDATA_CUSTOM:String = "errorUndataCustom";
		public static var UNKNOWN_DATA:String = "unknownData";

		//√×✔✘☜☞
		public static var TIP_ERROR_UNDATA:String = "✘尚未填写${" + A_LABEL + "}！";
		public static var TIP_ERROR_LEAST:String = "✘请至少选择${" + A_LEAST + "}项！";
		public static var TIP_ERROR_MOST:String = "✘至多仅能选择${" + A_MOST + "}项！";
		public static var TIP_ERROR_REG:String = "✘${" + A_LABEL + "}填写不正确！";
		public static var TIP_REQUIRED_COMPLETE:String = "✔";
		public static var TIP_REQUIRED:String = "☜";
		private static var OFFY_LABEL:uint = 2;
		private static var OFFY_INPUT:uint = 2;
		private static var OFFY_COMBOBOX:int = -1;
		

		protected static function setTextInput(_field:TextInput, _source:XML):TextInput {
			if (_field){

			} else {
				_field = new TextInput();
			}
			_field.maxChars = int(_source.attribute(A_MOST));
			if (stringToBoolean(_source.attribute(A_RESTRICT))){
				_field.restrict = String(_source.attribute(A_RESTRICT));
			} else {
				_field.restrict = null;
			}
			_field.displayAsPassword = stringToBoolean(_source.attribute(A_PASSWORD));
			return _field;
		}

		protected static function setTextArea(_field:TextArea, _source:XML):TextArea {
			if (_field){

			} else {
				_field = new TextArea();
			}
			_field.maxChars = int(_source.attribute(A_MOST));
			if (stringToBoolean(_source.attribute(A_RESTRICT))){
				_field.restrict = String(_source.attribute(A_RESTRICT));
			} else {
				_field.restrict = null;
			}
			return _field;
		}

		protected static function setComboBox(_field:ComboBox, _source:XML):ComboBox {
			if (_field){

			} else {
				_field = new ComboBox();
			}
			_field.removeAll();
			_field.rowCount = int(_source.attribute(A_ROW_COUNT)) || _field.rowCount;
			_field.prompt = _source.attribute(A_PROMPT) || "请选择";
			for each (var _eachXML:XML in _source.elements(E_ITEM)){
				_field.addItem({label: _eachXML.attribute(A_LABEL)});
			}
			return _field;
		}

		protected static function setRadioBtns(_field:Vector.<RadioButton>, _source:XML):Vector.<RadioButton> {
			if (_field){

			} else {
				_field = new Vector.<RadioButton>();
			}
			for each (var _eachXML:XML in _source.elements(E_ITEM)){
				var _id:uint = _eachXML.childIndex();
				var _radioBtn:RadioButton;
				try {
					_radioBtn = _field[_id];
				} catch (_ero:*){
					_radioBtn = new RadioButton();
					_field[_id] = _radioBtn;
				}
				_radioBtn.groupName = String(_source.name());
				_radioBtn.label = _eachXML.attribute(A_LABEL);
				_radioBtn.textField.autoSize = TextFieldAutoSize.RIGHT;
			}
			return _field;
		}

		protected static function setCheckBoxes(_field:Vector.<CheckBox>, _source:XML):Vector.<CheckBox> {
			if (_field){

			} else {
				_field = new Vector.<CheckBox>();
			}
			for each (var _eachXML:XML in _source.elements(E_ITEM)){
				var _id:uint = _eachXML.childIndex();
				var _checkBox:CheckBox;
				try {
					_checkBox = _field[_id];
				} catch (_ero:*){
					_checkBox = new CheckBox();
					_field[_id] = _checkBox;
				}
				_checkBox.label = _eachXML.attribute(A_LABEL);
				_checkBox.textField.autoSize = TextFieldAutoSize.RIGHT;
			}
			return _field;
		}

		//string
		protected static function getTextInputData(_field:TextInput):String {
			return _field.text;
		}

		//string
		protected static function getTextAreaData(_field:TextArea):String {
			return _field.text;
		}

		//>=0(selectedIndex),-1(unselected),string(custom)
		protected static function getComboBoxData(_field:ComboBox):* {
			if (_field.selectedItem){
				return _field.selectedIndex;
			} else if (_field.text && _field.text != _field.prompt){
				return _field.text;
			} else {
				return -1;
			}
		}

		//>=0(selectedIndex),-1(unselected)
		protected static function getRadioBtnsData(_field:Vector.<RadioButton>):int {
			var _item:RadioButton;
			for (var _i:uint = 0; _i < _field.length; _i++){
				_item = _field[_i];
				if (_item.selected){
					return _i;
				}
			}
			return -1;
		}

		//Array(uint or string)
		protected static function getCheckBoxesData(_field:Vector.<CheckBox>):Array {
			var _item:CheckBox;
			var _list:Array = [];
			for (var _i:uint = 0; _i < _field.length; _i++){
				_item = _field[_i];
				if (_item.selected){
					//还要判断自定义字符串的情况
					_list.push(_i);
				}
			}
			return _list;
		}

		private static function testStringReg(_str:String, _regStr:String):Boolean {
			var _reg:RegExp = new RegExp(_regStr);
			return _reg.test(_str);
		}

		private static function setHtmlColor(_str:String, _color:String):String {
			return "<font color='" + _color + "'>" + _str + "</font>";
		}

		public static var COLOR_TIP_ERROR:String = "#FF0000";
		public static var COLOR_TIP_COMPLETE:String = "#00FF00";
		public static var COLOR_TIP_NORMAL:String = "#000000";
		public static var COLOR_TIP_HINT:String = "#666666";
		public static var COLOR_LABEL:String = "#000000";

		public static var START_X:uint = 0;
		public static var WIDTH_LABEL:uint = 100;
		public static var WIDTH_FIELDS:uint = 150;
		public static var DX_LF:uint = 0;
		public static var DX_RAC:uint = 0;
		public static var DX_FRL:uint = 5;

		public static var START_Y:uint = 0;
		public static var DY_PER:uint = 30;

		public var label:Label;
		public var followLabel:Label;
		public var view:*;
		protected var viewContainer:DisplayObjectContainer;
		protected var sourceXML:XML;
		protected var required:Boolean;
		protected var reg:String;
		protected var least:uint;
		protected var most:uint;

		public function setSource(_xml:XML, _container:DisplayObjectContainer, _view:* = null):void {
			sourceXML = _xml;
			viewContainer = _container;

			required = stringToBoolean(sourceXML.attribute(A_REQUIRED));
			reg = String(sourceXML.attribute(A_REG));
			least = int(sourceXML.attribute(A_LEAST));
			most = int(sourceXML.attribute(A_MOST));

			setView(_view);
		}

		public function getData():* {
			if (view is TextInput){
				return getTextInputData(view);
			} else if (view is TextArea){
				return getTextAreaData(view);
			} else if (view is ComboBox){
				return getComboBoxData(view);
			} else if (view is Vector.<RadioButton>){
				return getRadioBtnsData(view);
			} else if (view is Vector.<CheckBox>){
				return getCheckBoxesData(view);
			} else {

			}
		}

		public function checkData(_checkUndata:Boolean = false):* {
			var _data:* = getData();
			var _result:*;
			if (_data is String){
				if (_data){
					if (testStringReg(_data, reg)){
						_result = true;
					} else {
						_result = ERROR_REG;
					}
				} else {
					if (required){
						_result = ERROR_UNDATA;
					} else {
						_result = true;
					}
				}
			} else if (_data is Number){
				if (_data < 0 && required){
					_result = ERROR_UNDATA;
				} else {
					_result = true;
				}
			} else if (_data is Array){
				if (_data.length == 0){
					if (required){
						_result = ERROR_UNDATA;
					} else {
						_result = true;
					}
				} else if (least && _data.length < least){
					_result = ERROR_LEAST;
				} else if (most && _data.length > most){
					_result = ERROR_MOST;
				} else if (_data[_data.length - 1] is String){
					var _customData:String = _data[_data.length - 1];
					if (_customData){
						if (testStringReg(_customData, reg)){
							_result = true;
						} else {
							_result = ERROR_REG;
						}
					} else {
						_result = ERROR_UNDATA_CUSTOM;
					}
				} else {
					_result = true;
				}
			} else {
				_result = UNKNOWN_DATA;
			}
			switch (_result){
				case true:
					if (required){
						followLabel.htmlText = setHtmlColor(TIP_REQUIRED_COMPLETE, COLOR_TIP_COMPLETE);
					} else {
						followLabel.htmlText = setHtmlColor(getNormalFollowText(), COLOR_TIP_NORMAL);
					}
					break;
				case UNKNOWN_DATA:
					break;
				case ERROR_UNDATA:
					if (_checkUndata){
						followLabel.htmlText = setHtmlColor(TIP_ERROR_UNDATA, COLOR_TIP_ERROR);
					} else {
						followLabel.htmlText = setHtmlColor(getNormalFollowText(), COLOR_TIP_NORMAL);
					}
					break;
				case ERROR_UNDATA_CUSTOM:
					followLabel.htmlText = setHtmlColor(TIP_ERROR_UNDATA, COLOR_TIP_ERROR);
					break;
				case ERROR_LEAST:
					followLabel.htmlText = setHtmlColor(TIP_ERROR_LEAST, COLOR_TIP_ERROR);
					break;
				case ERROR_MOST:
					followLabel.htmlText = setHtmlColor(TIP_ERROR_MOST, COLOR_TIP_ERROR);
					break;
				case ERROR_REG:
					followLabel.htmlText = setHtmlColor(TIP_ERROR_REG, COLOR_TIP_ERROR);
					break;
			}
			return _result;
		}

		protected function setView(_view:* = null):void {
			//
			var _styleType:String = sourceXML.attribute(A_STYLE_TYPE);
			if (sourceXML.elements(E_ITEM).length() > 0){
				switch (_styleType){
					case STRING_DEFAULT:
					case A_COMBO_BOX:
						view = setComboBox(_view, sourceXML);
						break;
					case A_RADIO_BUTTON:
						view = setRadioBtns(_view, sourceXML);
						break;
					case A_CHECK_BOX:
						view = setCheckBoxes(_view, sourceXML);
						break;
					default:
				}
			} else if (sourceXML.attribute(A_SOURCE).length() > 0){
				DataLoader.load(sourceXML.attribute(A_SOURCE), null, onItemListLoadedHandler);
				return;
			} else {
				switch (_styleType){
					case STRING_DEFAULT:
					case A_TEXT_INPUT:
						view = setTextInput(_view, sourceXML);
						break;
					case A_TEXT_AREA:
						view = setTextArea(_view, sourceXML);
						break;
					default:
				}
			}
			//
			if (label){
			} else {
				label = new Label();
			}
			label.autoSize = TextFieldAutoSize.RIGHT;
			label.htmlText = setHtmlColor(sourceXML.attribute(A_LABEL), COLOR_LABEL);
			//
			if (followLabel){
			} else {
				followLabel = new Label();
			}
			followLabel.autoSize = TextFieldAutoSize.LEFT;
			followLabel.htmlText = setHtmlColor(getNormalFollowText(), COLOR_TIP_NORMAL);
			//
			switch (_styleType){
				case STRING_DEFAULT:
				case A_TEXT_INPUT:
				case A_TEXT_AREA:
				case A_COMBO_BOX:
					(view as UIComponent).addEventListener(FocusEvent.FOCUS_IN, onFocusInHandler);
					(view as UIComponent).addEventListener(FocusEvent.FOCUS_OUT, onFocusOutHandler);
					break;
				case A_RADIO_BUTTON:
				case A_CHECK_BOX:
					for each (var _viewItem:UIComponent in view){
						_viewItem.addEventListener(FocusEvent.FOCUS_IN, onFocusInHandler);
						_viewItem.addEventListener(FocusEvent.FOCUS_OUT, onFocusOutHandler);
					}
					break;
				default:
			}
			viewContainer.addChild(label);
			viewContainer.addChild(followLabel);
			if (view is Vector.<RadioButton> || view is Vector.<CheckBox>){
				for each (var _item in view){
					viewContainer.addChild(_item);
				}
			} else {
				viewContainer.addChild(view);
			}
			//delay
			setTimeout(setViewStyle, 0);
		}

		protected function setViewStyle():void {
			//
			var _id:uint = sourceXML.childIndex();
			//
			label.x = START_X;
			label.y = START_Y + DY_PER * _id;
			label.width = WIDTH_LABEL;
			//
			var _followX:int = START_X + WIDTH_LABEL + DX_LF + WIDTH_FIELDS + DX_FRL;
			if (view is Vector.<RadioButton> || view is Vector.<CheckBox>){
				for (var _i:uint = 0; _i < view.length; _i++){
					var _item:* = view[_i];
					if (_i == 0){
						_item.x = START_X + WIDTH_LABEL + DX_LF;
					} else {
						var _itemPrev:* = view[_i - 1];
						_item.x = _itemPrev.x + _itemPrev.getRect(_itemPrev).width + DX_RAC;
					}
					_item.y = label.y;
				}
				followLabel.x = Math.max(_followX, _item.x + _item.getRect(_itemPrev).width + DX_FRL);
			} else {
				view.x = START_X + WIDTH_LABEL + DX_LF;
				view.y = START_Y + DY_PER * _id;
				view.width = WIDTH_FIELDS;
				followLabel.x = _followX;
			}
			//
			followLabel.y = label.y;
			setTimeout(offSetTextY, 0);
		}
		
		protected function offSetTextY():void {
			label.textField.y += OFFY_LABEL;
			followLabel.textField.y += OFFY_LABEL;
			if (view is Vector.<RadioButton> || view is Vector.<CheckBox>){
				for (var _i:uint = 0; _i < view.length; _i++){
					var _item:* = view[_i];
				}
			} else if (view is ComboBox) {
				view.textField.y += OFFY_COMBOBOX;
			} else if (view is TextInput){
				view.textField.y += OFFY_INPUT;
			} else if (view is TextArea){
				
			}
		}

		protected function onFocusInHandler(e:FocusEvent):void {
			//hint
			followLabel.htmlText = setHtmlColor(sourceXML.attribute(A_HINT), COLOR_TIP_HINT);
		}

		protected function onFocusOutHandler(e:FocusEvent):void {
			checkData();
		}

		protected function getNormalFollowText():String {
			if (required){
				return TIP_REQUIRED;
			} else {
				return STRING_DEFAULT;
			}
		}

		protected function onItemListLoadedHandler(_evt:Event):void {
			//delete sourceXML.@source;
			sourceXML.appendChild(XML(_evt.currentTarget.data).elements(E_ITEM));
			setView();
		}

	}
}