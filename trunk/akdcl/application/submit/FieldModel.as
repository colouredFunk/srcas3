package akdcl.application.submit {
	import flash.display.DisplayObject;
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

	import akdcl.application.submit.ImageBrowse;

	import akdcl.utils.stringToBoolean;
	import akdcl.net.DataLoader;
	import akdcl.utils.replaceString;

	/**
	 * ...
	 * @author Akdcl
	 */
	public class FieldModel {
		public static const A_LABEL:String = "label";
		public static const A_KEY:String = "key";
		public static const A_VALUE:String = "value";
		public static const A_REQUIRED:String = "required";
		public static const A_LEAST:String = "least";
		public static const A_MOST:String = "most";
		public static const A_REG:String = "reg";
		public static const A_SOURCE:String = "source";
		public static const A_STYLE_TYPE:String = "styleType";
		public static const A_RESTRICT:String = "restrict";
		public static const A_ROW_COUNT:String = "rowCount";
		public static const A_PROMPT:String = "prompt";
		public static const A_HINT:String = "hint";
		public static const A_PASSWORD:String = "password";
		public static const A_SAME_AS:String = "sameAs";
		public static const A_QUALITY:String = "quality";


		public static const ST_TEXT_INPUT:String = "TextInput";
		public static const ST_TEXT_AREA:String = "TextArea";
		public static const ST_COMBO_BOX:String = "ComboBox";
		public static const ST_RADIO_BUTTON:String = "RadioButton";
		public static const ST_CHECK_BOX:String = "CheckBox";
		public static const ST_IMAGE_BROWSE:String = "ImageBrowse";
		public static const ST_LABEL:String = "Label";

		public static const E_ITEM:String = "item";

		public static const STRING_DEFAULT:String = "";

		public static const VALUE_UNSELECT:int = -1;
		public static const VALUE_UNINPUT:String = "";

		public static var ERROR_UNSELECTED:String = "errorUnselected";
		public static var ERROR_UNINPUT:String = "errorUninput";
		public static var ERROR_LEAST:String = "errorLeast";
		public static var ERROR_MOST:String = "errorMost";
		public static var ERROR_LEAST_CHAR:String = "errorLeastChar";
		public static var ERROR_MOST_CHAR:String = "errorLeastChar";
		public static var ERROR_REG:String = "errorREG";
		public static var ERROR_UNINPUT_CUSTOM:String = "errorUndataCustom";

		//√×✔✘☜☞
		public static var TIP_ERROR_UNSELECTED:String = "✘请选择${" + A_LABEL + "}";
		public static var TIP_ERROR_UNINPUT:String = "✘请输入${" + A_LABEL + "}";
		public static var TIP_ERROR_LEAST:String = "✘请至少选择${" + A_LEAST + "}项";
		public static var TIP_ERROR_MOST:String = "✘至多仅能选择${" + A_MOST + "}项";
		public static var TIP_ERROR_LEAST_CHAR:String = "✘请至少输入${" + A_LEAST + "}位字符";
		public static var TIP_ERROR_MOST_CHAR:String = "✘至多仅能输入${" + A_LEAST + "}位字符";
		public static var TIP_ERROR_REG:String = "✘${" + A_LABEL + "}输入不正确";
		public static var TIP_ERROR_UNINPUT_CUSTOM:String = "✘请输入${" + A_LABEL + "}的自定义项";

		public static var TIP_REQUIRED_COMPLETE:String = "✔";
		public static var TIP_REQUIRED:String = "☜";

		private static var OFFY_LABEL:uint = 2;
		private static var OFFY_INPUT:uint = 2;
		private static var OFFY_COMBOBOX:int = 2;
		private static var OFFY_TEXT_AREA:int = 2;

		protected static function testStringReg(_str:String, _regStr:String):Boolean {
			var _reg:RegExp = new RegExp(_regStr);
			return _reg.test(_str);
		}

		protected static function setHtmlColor(_str:String, _color:String):String {
			return "<font color='" + _color + "'>" + _str + "</font>";
		}

		private static function setTextInput(_field:*, _source:XML):* {
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
			//_field.displayAsPassword = stringToBoolean(_source.attribute(A_PASSWORD));
			return _field;
		}

		private static function setTextArea(_field:*, _source:XML):* {
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

		private static function setComboBox(_field:ComboBox, _source:XML):ComboBox {
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

		private static function setRadioBtns(_field:Array, _source:XML):Array {
			if (_field){

			} else {
				_field = new Array();
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
			}
			return _field;
		}

		private static function setCheckBoxes(_field:Array, _source:XML):Array {
			if (_field){

			} else {
				_field = new Array();
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
			}
			return _field;
		}

		private static function setImageBrowse(_field:ImageBrowse, _source:XML):ImageBrowse {
			if (_field){

			} else {
				_field = new ImageBrowse();
			}
			//
			return _field;
		}

		//String
		private static function getTextInputData(_field:TextInput):String {
			return stringToBoolean(_field.text) ? _field.text : VALUE_UNINPUT;
		}

		//String
		private static function getTextAreaData(_field:TextArea):String {
			return stringToBoolean(_field.text) ? _field.text : VALUE_UNINPUT;
		}

		//>=0(selectedIndex),String(custom)
		private static function getComboBoxData(_field:ComboBox):* {
			if (_field.selectedItem){
				return _field.selectedIndex;
			} else if (_field.editable){
				if (stringToBoolean(_field.text) && _field.text != _field.prompt){
					return _field.text;
				} else {
					return VALUE_UNINPUT;
				}
			} else {
				return VALUE_UNSELECT;
			}
		}

		//>=0(selectedIndex)
		private static function getRadioBtnsData(_field:Array):int {
			var _item:RadioButton;
			for (var _i:uint = 0; _i < _field.length; _i++){
				_item = _field[_i];
				if (_item.selected){
					return _i;
				}
			}
			return VALUE_UNSELECT;
		}

		//Array(uint or String)
		private static function getCheckBoxesData(_field:Array):* {
			var _item:CheckBox;
			var _list:Array = [];
			for (var _i:uint = 0; _i < _field.length; _i++){
				_item = _field[_i];
				if (_item.selected){
					//还要判断自定义字符串的情况
					_list.push(_i);
				}
			}
			return _list.length > 0 ? _list : VALUE_UNSELECT;
		}

		//ByteArray or Vector.<ByteArray>
		private static function getImageBrowseData(_field:*):* {
			return _field.data ? _field.data : VALUE_UNSELECT;
		}

		public var label:Label;
		public var followLabel:Label;
		public var view:*;


		protected var viewContainer:DisplayObjectContainer;
		protected var sourceXML:XML;
		protected var offY:uint;
		protected var formStyle:FormStyle;
		protected var height:uint;

		public var name:String;
		public var key:String;
		protected var styleType:String;
		protected var required:Boolean;
		protected var reg:String;
		protected var least:uint;
		protected var most:uint;

		public function setSource(_xml:XML, _container:DisplayObjectContainer, _style:FormStyle, _view:* = null, _offY:uint = 0):int {
			sourceXML = _xml;
			viewContainer = _container;
			offY = _offY;
			formStyle = _style;
			//
			height = formStyle.height;
			name = sourceXML.name();
			key = sourceXML.attribute(A_KEY);
			styleType = String(sourceXML.attribute(A_STYLE_TYPE));
			if (!styleType) {
				//没有指定styleType
				if (sourceXML.elements(E_ITEM).length() > 0 || sourceXML.attribute(A_SOURCE).length() > 0){
					//有item节点或source属性则默认为comboBox
					styleType = ST_COMBO_BOX;
				} else if (!key) {
					//没有key属性则默认为label
					styleType = ST_LABEL;
				} else {
					//其他默认为
					styleType = ST_TEXT_INPUT;
				}
			}
			required = stringToBoolean(sourceXML.attribute(A_REQUIRED));
			reg = String(sourceXML.attribute(A_REG));
			least = int(sourceXML.attribute(A_LEAST));
			most = int(sourceXML.attribute(A_MOST));
			setLabels();
			setView(_view);
			return height;
		}

		public function remove():void {
			sourceXML = null;
			name = null;
			viewContainer = null;
			//
			label = null;
			followLabel = null;
			view = null;
		}

		//返回true（字段为非必要且没有数据）,false（没有数据或数据非法）或data（数据）
		public function checkData(_checkUndata:Boolean = true):* {
			if (styleType == ST_LABEL){
				return true;
			}
			var _data:* = getData();
			if (_data === VALUE_UNSELECT){
				_data = ERROR_UNSELECTED;
			} else if (_data === VALUE_UNINPUT){
				_data = ERROR_UNINPUT;
			} else if (_data is String){
				if (least && _data.length < least){
					_data = ERROR_LEAST_CHAR;
				} else if (most && _data.length > most){
					_data = ERROR_MOST_CHAR;
				} else if (testStringReg(_data, reg)){
					//
				} else {
					_data = ERROR_REG;
				}
			} else if (_data is Number){
				//
			} else if (_data is Array){
				if (least && _data.length < least){
					_data = ERROR_LEAST;
				} else if (most && _data.length > most){
					_data = ERROR_MOST;
				} else if (_data[_data.length - 1] is String){
					var _customData:String = _data[_data.length - 1];
					if (_customData){
						if (testStringReg(_customData, reg)){
							//
						} else {
							_data = ERROR_REG;
						}
					} else {
						_data = ERROR_UNINPUT_CUSTOM;
					}
				} else {
					//
				}
			} else if (_data){
				//其他数据格式
			} else {
				_data = ERROR_UNSELECTED;
			}
			//
			var _result:Boolean;
			switch (_data){
				case ERROR_UNSELECTED:
					if (required && _checkUndata){
						followLabel.htmlText = setHtmlColor(formatString(TIP_ERROR_UNSELECTED), formStyle.colorError);
					} else {
						followLabel.htmlText = setHtmlColor(getNormalFollowText(), formStyle.colorNormal);
					}
					break;
				case ERROR_UNINPUT:
					if (required && _checkUndata){
						followLabel.htmlText = setHtmlColor(formatString(TIP_ERROR_UNINPUT), formStyle.colorError);
					} else {
						followLabel.htmlText = setHtmlColor(getNormalFollowText(), formStyle.colorNormal);
					}
					break;
				case ERROR_UNINPUT_CUSTOM:
					followLabel.htmlText = setHtmlColor(formatString(TIP_ERROR_UNINPUT_CUSTOM), formStyle.colorError);
					break;
				case ERROR_LEAST:
					followLabel.htmlText = setHtmlColor(formatString(TIP_ERROR_LEAST), formStyle.colorError);
					break;
				case ERROR_MOST:
					followLabel.htmlText = setHtmlColor(formatString(TIP_ERROR_MOST), formStyle.colorError);
					break;
				case ERROR_LEAST_CHAR:
					followLabel.htmlText = setHtmlColor(formatString(TIP_ERROR_LEAST_CHAR), formStyle.colorError);
					break;
				case ERROR_MOST_CHAR:
					followLabel.htmlText = setHtmlColor(formatString(TIP_ERROR_MOST_CHAR), formStyle.colorError);
					break;
				case ERROR_REG:
					followLabel.htmlText = setHtmlColor(formatString(TIP_ERROR_REG), formStyle.colorError);
					break;
				default:
					_result = true;
					if (required){
						followLabel.htmlText = setHtmlColor(formatString(TIP_REQUIRED_COMPLETE), formStyle.colorComplete);
					} else {
						followLabel.htmlText = setHtmlColor(getNormalFollowText(), formStyle.colorNormal);
					}
			}
			//
			setTimeout(fixComponentTextY, 45);
			//
			if (_result){
				//数据
				if (_data is Number){
					_data = sourceXML.elements(E_ITEM)[_data].attribute(A_VALUE);
				} else if (_data is Array){
					for (var _i:uint; _i < _data.length; _i++){
						var _eachData:* = _data[_i];
						if (_eachData is Number){
							_data[_i] = sourceXML.elements(E_ITEM)[_eachData].attribute(A_VALUE);
						}
					}
				}
				return _data;
			} else if (!required && (_data === ERROR_UNSELECTED || _data === ERROR_UNINPUT)){
				//字段为非必要且没有数据
				return true;
			} else {
				//没有数据或数据非法
				return false;
			}
		}

		protected function getData():* {
			var _data:*;
			switch (styleType){
				case ST_TEXT_INPUT:
					_data = getTextInputData(view);
					break;
				case ST_TEXT_AREA:
					_data = getTextAreaData(view);
					break;
				case ST_COMBO_BOX:
					_data = getComboBoxData(view);
					break;
				case ST_RADIO_BUTTON:
					_data = getRadioBtnsData(view);
					break;
				case ST_CHECK_BOX:
					_data = getCheckBoxesData(view);
					break;
				case ST_IMAGE_BROWSE:
					_data = getImageBrowseData(view);
					break;
			}
			return _data;
		}

		protected function setLabels():void {
			//
			if (label){
			} else {
				label = new Label();
			}
			label.enabled = false;
			label.mouseChildren = false;
			label.mouseEnabled = false;
			label.autoSize = TextFieldAutoSize.RIGHT;
			if (sourceXML.attribute(A_LABEL).length() > 0) {
				label.htmlText = setHtmlColor(sourceXML.attribute(A_LABEL), formStyle.colorLabel);
			}else {
				label.htmlText = replaceString(sourceXML.children().toXMLString());
			}
			//
			if (followLabel){
			} else {
				followLabel = new Label();
			}
			followLabel.enabled = false;
			followLabel.mouseChildren = false;
			followLabel.mouseEnabled = false;
			followLabel.autoSize = TextFieldAutoSize.LEFT;
			followLabel.htmlText = setHtmlColor(getNormalFollowText(), formStyle.colorNormal);
		}

		protected function setView(_view:* = null):void {
			if (_view is Event){
				//读取到item列表后再初始化view
				sourceXML.appendChild(XML(_view.currentTarget.data).elements(E_ITEM));
				_view = null;
			}
			if (sourceXML.attribute(A_SOURCE).length() > 0 && sourceXML.elements(E_ITEM).length() == 0){
				//读取item列表
				DataLoader.load(sourceXML.attribute(A_SOURCE), null, setView);
				return;
			} else {
				switch (styleType){
					case ST_TEXT_INPUT:
						view = setTextInput(_view, sourceXML);
						break;
					case ST_TEXT_AREA:
						view = setTextArea(_view, sourceXML);
						break;
					case ST_COMBO_BOX:
						view = setComboBox(_view, sourceXML);
						break;
					case ST_RADIO_BUTTON:
						view = setRadioBtns(_view, sourceXML);
						break;
					case ST_CHECK_BOX:
						view = setCheckBoxes(_view, sourceXML);
						break;
					case ST_IMAGE_BROWSE:
						view = setImageBrowse(_view, sourceXML);
						break;
					case ST_LABEL:
						label.autoSize = TextFieldAutoSize.LEFT;
						label.wordWrap = true;
						view = label;
						break;
					default:
						trace("unknown styleType!!!");
						return;
				}
			}
			//
			switch (styleType){
				case ST_LABEL:
					break;
				case ST_RADIO_BUTTON:
				case ST_CHECK_BOX:
					for each (var _viewItem:DisplayObject in view){
						_viewItem.addEventListener(FocusEvent.FOCUS_IN, onFocusInHandler);
						_viewItem.addEventListener(FocusEvent.FOCUS_OUT, onFocusOutHandler);
					}
					break;
				case STRING_DEFAULT:
				case ST_TEXT_INPUT:
				case ST_TEXT_AREA:
				case ST_COMBO_BOX:
				case ST_IMAGE_BROWSE:
				default:
					if (view && "addEventListener" in view){
						view.addEventListener(FocusEvent.FOCUS_IN, onFocusInHandler);
						view.addEventListener(FocusEvent.FOCUS_OUT, onFocusOutHandler);
					}
			}
			setViewStyle();
		}

		protected function setViewStyle():void {
			viewContainer.addChild(label);
			label.x = formStyle.startX;
			label.y = formStyle.startY + offY;
			label.width = formStyle.widthLabel;
			label.height = formStyle.height;
			//
			viewContainer.addChild(followLabel);
			followLabel.x = formStyle.startX + formStyle.widthLabel + formStyle.dxLF + formStyle.width + formStyle.dxFL;
			followLabel.y = label.y;
			followLabel.height = formStyle.height;
			//
			if (styleType == ST_RADIO_BUTTON || styleType == ST_CHECK_BOX){
				var _width:uint = int(sourceXML.style.@width);
				var _id:uint;
				for (var _i:uint = 0; _i < view.length; _i++){
					var _item:* = view[_i];
					viewContainer.addChild(_item);
					_item.drawNow();
					if (_i > 0){
						var _itemPrev:* = view[_i - 1];
						if (_width == 0){
							_item.x = _itemPrev.x + _itemPrev.getRect(_itemPrev).width + formStyle.dxRAC;
							_item.y = label.y;
						} else if (_width <= view.length){
							_id = _i % _width;
							if (_id == 0){
								_item.x = view[0].x;
							} else {
								_item.x = _itemPrev.x + _itemPrev.getRect(_itemPrev).width + formStyle.dxRAC;
							}
							_item.y = label.y + (formStyle.height + formStyle.dyFF) * int(_i / _width);
						} else {
							_width = Math.max(_width, formStyle.width);
							if (_itemPrev.x + _itemPrev.width - view[0].x > _width){
								_id++;
								_item.x = view[0].x;
							} else {
								_item.x = _itemPrev.x + _itemPrev.getRect(_itemPrev).width + formStyle.dxRAC;
							}
							_item.y = label.y + (formStyle.height + formStyle.dyFF) * _id;
						}
						followLabel.x = Math.max(followLabel.x, _item.x + _item.getRect(_itemPrev).width + formStyle.dxFL);
					} else {
						_item.x = formStyle.startX + formStyle.widthLabel + formStyle.dxLF;
						_item.y = label.y;
					}
					_item.height = formStyle.height;
				}
				height = _item.y + _item.height - view[0].y;
			} else {
				viewContainer.addChild(view);
				if (styleType == ST_LABEL){
					view.x = formStyle.startX;
					view.width = formStyle.widthLabel + formStyle.dxLF + formStyle.width;
				} else {
					view.x = formStyle.startX + formStyle.widthLabel + formStyle.dxLF;
					view.width = formStyle.width;
				}
				view.y = label.y;
				if (styleType == ST_TEXT_AREA){
					view.height = formStyle.height * 2;
				} else if (styleType == ST_IMAGE_BROWSE){
					view.height = int(view.width * 0.75);
				} else {
					view.height = formStyle.height;
				}
				height = view.height;
			}
			//delay
			//setTimeout(delaySetComponentXY, 0);
			setTimeout(fixComponentTextY, 0);
		}

		private function fixComponentTextY():void {
			label.textField.y = OFFY_LABEL;
			followLabel.textField.y = OFFY_LABEL;
			if (styleType == ST_RADIO_BUTTON || styleType == ST_CHECK_BOX){
				for (var _i:uint = 0; _i < view.length; _i++){
					var _item:* = view[_i];
				}
			} else if (styleType == ST_COMBO_BOX){
				view.textField.y = OFFY_COMBOBOX;
			} else if (styleType == ST_TEXT_INPUT){
				view.textField.y = OFFY_INPUT;
			} else if (styleType == ST_TEXT_AREA){
				view.textField.y = OFFY_TEXT_AREA;
			}
		}

		private function getNormalFollowText():String {
			if (required){
				return TIP_REQUIRED;
			} else {
				return STRING_DEFAULT;
			}
		}

		protected function onFocusInHandler(e:FocusEvent):void {
			//hint
			followLabel.htmlText = setHtmlColor(formatString(sourceXML.attribute(A_HINT)), formStyle.colorHint);
		}

		protected function onFocusOutHandler(e:FocusEvent):void {
			checkData(false);
		}

		protected function formatString(_str:String):String {
			var _label:String = String(sourceXML.attribute(A_LABEL)).replace("：", "");
			_str = _str.replace("${" + A_LABEL + "}", _label);
			_str = _str.replace("${" + A_LEAST + "}", sourceXML.attribute(A_LEAST));
			_str = _str.replace("${" + A_MOST + "}", sourceXML.attribute(A_MOST));
			return _str;
		}

	}
}