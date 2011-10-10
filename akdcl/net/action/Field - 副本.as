package akdcl.net.action{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.geom.Point;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	import flash.text.TextFieldAutoSize;

	import fl.controls.Label;
	import fl.controls.TextInput;
	import fl.controls.TextArea;
	import fl.controls.ComboBox;
	import fl.controls.RadioButton;
	import fl.controls.CheckBox;

	import akdcl.manager.RequestManager;
	import akdcl.utils.stringToBoolean;
	import akdcl.utils.replaceString;

	/**
	 * ...
	 * @author Akdcl
	 */
	public class Field {
		public static const A_REQUIRED:String = "required";
		public static const A_LEAST:String = "least";
		public static const A_MOST:String = "most";
		public static const A_REG:String = "reg";
		public static const A_STYLE_TYPE:String = "styleType";
		public static const A_RESTRICT:String = "restrict";
		public static const A_ROW_COUNT:String = "rowCount";
		public static const A_PROMPT:String = "prompt";
		public static const A_HINT:String = "hint";
		
		public static const A_PASSWORD:String = "password";

		public static const ST_TEXT_INPUT:String = "TextInput";
		public static const ST_TEXT_AREA:String = "TextArea";
		public static const ST_COMBO_BOX:String = "ComboBox";
		public static const ST_RADIO_BUTTON:String = "RadioButton";
		public static const ST_CHECK_BOX:String = "CheckBox";
		public static const ST_CHECK:String = "Check";
		
		public static const ST_LABEL:String = "Label";

		public static const STRING_DEFAULT:String = "";

		public static const VALUE_UNSELECT:int = -1;
		public static const VALUE_UNINPUT:String = "";

		public static const ERROR_UNSELECTED:String = "errorUnselected";
		public static const ERROR_UNINPUT:String = "errorUninput";
		public static const ERROR_LEAST:String = "errorLeast";
		public static const ERROR_MOST:String = "errorMost";
		public static const ERROR_LEAST_CHAR:String = "errorLeastChar";
		public static const ERROR_MOST_CHAR:String = "errorLeastChar";
		public static const ERROR_REG:String = "errorREG";
		public static const ERROR_UNINPUT_CUSTOM:String = "errorUndataCustom";

		private static const OFFY_LABEL:uint = 2;
		private static const OFFY_INPUT:uint = 2;
		private static const OFFY_COMBOBOX:int = 2;
		private static const OFFY_TEXT_AREA:int = 2;
		

		//√×✔✘☜☞
		public static var TIP_ERROR_UNSELECTED:String = "×请选择${" + RemoteAction.A_LABEL + "}";
		public static var TIP_ERROR_UNINPUT:String = "×请输入${" + RemoteAction.A_LABEL + "}";
		public static var TIP_ERROR_REG:String = "×${" + RemoteAction.A_LABEL + "}输入不正确";
		public static var TIP_ERROR_UNINPUT_CUSTOM:String = "×请输入${" + RemoteAction.A_LABEL + "}的自定义项";
		
		public static var TIP_ERROR_LEAST:String = "×请至少选择${" + A_LEAST + "}项";
		public static var TIP_ERROR_MOST:String = "×至多仅能选择${" + A_MOST + "}项";
		public static var TIP_ERROR_LEAST_CHAR:String = "×请至少输入${" + A_LEAST + "}位字符";
		public static var TIP_ERROR_MOST_CHAR:String = "×至多仅能输入${" + A_LEAST + "}位字符";

		public static var TIP_REQUIRED_COMPLETE:String = "√";
		public static var TIP_REQUIRED:String = "☜";
		
		public static var followLabelToBottom:Boolean = false;
		protected static var rM:RequestManager = RequestManager.getInstance();

		private static function testStringReg(_str:String, _regStr:String):Boolean {
			if (_regStr) {
				var _reg:RegExp = new RegExp(_regStr);
				return _reg.test(_str);
			}else {
				return true;
			}
		}

		private static function setHtmlColor(_str:String, _color:String):String {
			return "<font color='" + _color + "'>" + _str + "</font>";
		}

		private static function setTextInput(_field:TextInput, _options:XML):TextInput {
			if (_field){

			} else {
				_field = new TextInput();
			}
			_field.maxChars = int(_options.attribute(A_MOST));
			if (stringToBoolean(_options.attribute(A_RESTRICT))){
				_field.restrict = String(_options.attribute(A_RESTRICT));
			} else {
				_field.restrict = null;
			}
			_field.displayAsPassword = stringToBoolean(_options.attribute(A_PASSWORD));
			return _field;
		}

		private static function setTextArea(_field:TextArea, _options:XML):TextArea {
			if (_field){

			} else {
				_field = new TextArea();
			}
			_field.maxChars = int(_options.attribute(A_MOST));
			if (stringToBoolean(_options.attribute(A_RESTRICT))){
				_field.restrict = String(_options.attribute(A_RESTRICT));
			} else {
				_field.restrict = null;
			}
			return _field;
		}

		private static function setComboBox(_field:ComboBox, _options:XML):ComboBox {
			if (_field){

			} else {
				_field = new ComboBox();
			}
			_field.removeAll();
			_field.rowCount = int(_options.attribute(A_ROW_COUNT)) || _field.rowCount;
			_field.prompt = _options.attribute(A_PROMPT) || "请选择";
			for each (var _eachXML:XML in _options.elements(RemoteAction.E_CASE)) {
				_field.addItem( { label: _eachXML.attribute(RemoteAction.A_LABEL) } );
			}
			return _field;
		}

		private static function setRadioBtns(_field:Array, _options:XML):Array {
			if (_field){

			} else {
				_field = new Array();
			}
			for each (var _eachXML:XML in _options.elements(RemoteAction.E_CASE)){
				var _id:uint = _eachXML.childIndex();
				var _radioBtn:RadioButton;

				if (_field[_id]){
					_radioBtn = _field[_id];
				} else {
					_radioBtn = new RadioButton();
					_field[_id] = _radioBtn;
				}
				_radioBtn.groupName = String(_options.attribute(RemoteAction.A_NAME));
				_radioBtn.label = String(_eachXML.attribute(RemoteAction.A_LABEL));
				_radioBtn.textField.autoSize = TextFieldAutoSize.LEFT;
			}
			return _field;
		}

		private static function setCheckBoxes(_field:Array, _options:XML):Array {
			if (_field){

			} else {
				_field = new Array();
			}
			for each (var _eachXML:XML in _options.elements(RemoteAction.E_CASE)){
				var _id:uint = _eachXML.childIndex();
				var _checkBox:CheckBox;
				if (_field[_id]){
					_checkBox = _field[_id];
				} else {
					_checkBox = new CheckBox();
					_field[_id] = _checkBox;
				}
				_checkBox.label = _eachXML.attribute(RemoteAction.A_LABEL);
				_checkBox.textField.autoSize = TextFieldAutoSize.LEFT;
			}
			return _field;
		}

		private static function setCheckBox(_field:CheckBox, _options:XML):CheckBox {
			if (_field){

			} else {
				_field = new CheckBox();
			}
			if (_options.attribute(RemoteAction.A_CONTENT).length() > 0) {
				_field.label = _options.attribute(RemoteAction.A_CONTENT);
			}else if (_options.elements(RemoteAction.A_CONTENT).length() > 0) {
				_field.label = _options.elements(RemoteAction.A_CONTENT);
			}else {
				_field.label = _options.attribute(RemoteAction.A_LABEL);
			}
			
			_field.textField.autoSize = TextFieldAutoSize.LEFT;
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

		//Boolean
		private static function getCheckBoxData(_field:CheckBox):Boolean {
			return _field.selected;
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

		public var label:Label;
		public var followLabel:Label;
		public var view:*;

		private var formAction:FormAction;
		private var options:XML;
		private var viewContainer:DisplayObjectContainer;
		private var offY:uint;
		private var formStyle:FormStyle;
		private var height:uint;
		private var autoCreateView:Boolean = true;

		public var styleType:String;
		public var name:String;
		public var required:Boolean;

		private var reg:String;
		private var least:uint;
		private var most:uint;
		private var pointFollow:Point = new Point();
		private var pointBottom:Point = new Point();
		private var timeOutID:uint;
		
		public function Field(_formAction:FormAction) {
			formAction = _formAction;
		}

		public function setOptions(_xml:XML, _container:DisplayObjectContainer, _style:FormStyle, _view:* = null, _offY:uint = 0):int {
			options = _xml;
			viewContainer = _container;
			offY = _offY;
			formStyle = _style;
			height = formStyle.height;

			name = options.attribute(RemoteAction.A_NAME)[0];
			styleType = options.attribute(A_STYLE_TYPE)[0];
			
			required = stringToBoolean(options.attribute(A_REQUIRED)[0]);

			reg = options.attribute(A_REG)[0];
			least = int(options.attribute(A_LEAST)[0]);
			most = int(options.attribute(A_MOST)[0]);

			if (styleType){
			}else {
				
				//没有指定styleType
				if (options.elements(RemoteAction.E_CASE).length() > 0 || options.attribute(RemoteAction.A_SOURCE).length() > 0) {
					//有case节点则默认为comboBox
					styleType = ST_COMBO_BOX;
				} else if (!name) {
					//没有key属性则默认为label
					styleType = ST_LABEL;
				} else {
					//其他默认为input
					styleType = ST_TEXT_INPUT;
				}
			}

			if (_view){
				autoCreateView = false;
			} else {
				setLabels();
			}
			setView(_view);
			return height;
		}

		public function remove():void {
			options = null;
			name = null;
			viewContainer = null;
			//
			label = null;
			followLabel = null;
			view = null;
			formStyle = null;
			
			pointFollow = null;
			pointBottom = null;
		}
		
		public function clear():void {
			switch (styleType){
				case ST_TEXT_INPUT:
					view.text = "";
					break;
				case ST_TEXT_AREA:
					view.text = "";
					break;
				case ST_COMBO_BOX:
					break;
				case ST_RADIO_BUTTON:
					break;
				case ST_CHECK_BOX:
					break;
				case ST_CHECK:
					break;
			}
			isInputComplete(false);
		}

		//返回true（字段为非必要且没有数据）,false（没有数据或数据非法）或data（数据）
		public function isInputComplete(_checkUndata:Boolean = true):* {
			if (styleType == ST_LABEL){
				return true;
			}
			var _data:* = getData();
			//
			var _result:Boolean;
			var _hintString:String = "";
			var _isBottom:Boolean;
			switch (_data){
				case ERROR_UNSELECTED:
					if (required && _checkUndata){
						_hintString = setHtmlColor(formatString(TIP_ERROR_UNSELECTED), formStyle.colorError);
						_isBottom = true;
					} else {
						_hintString = setHtmlColor(getNormalFollowText(), formStyle.colorNormal);
					}
					break;
				case ERROR_UNINPUT:
					if (required && _checkUndata){
						_hintString = setHtmlColor(formatString(TIP_ERROR_UNINPUT), formStyle.colorError);
						_isBottom = true;
					} else {
						_hintString = setHtmlColor(getNormalFollowText(), formStyle.colorNormal);
					}
					break;
				case ERROR_UNINPUT_CUSTOM:
					_hintString = setHtmlColor(formatString(TIP_ERROR_UNINPUT_CUSTOM), formStyle.colorError);
					_isBottom = true;
					break;
				case ERROR_LEAST:
					_hintString = setHtmlColor(formatString(TIP_ERROR_LEAST), formStyle.colorError);
					_isBottom = true;
					break;
				case ERROR_MOST:
					_hintString = setHtmlColor(formatString(TIP_ERROR_MOST), formStyle.colorError);
					_isBottom = true;
					break;
				case ERROR_LEAST_CHAR:
					_hintString = setHtmlColor(formatString(TIP_ERROR_LEAST_CHAR), formStyle.colorError);
					_isBottom = true;
					break;
				case ERROR_MOST_CHAR:
					_hintString = setHtmlColor(formatString(TIP_ERROR_MOST_CHAR), formStyle.colorError);
					_isBottom = true;
					break;
				case ERROR_REG:
					_hintString = setHtmlColor(formatString(TIP_ERROR_REG), formStyle.colorError);
					_isBottom = true;
					break;
				default:
					_result = true;
					if (required){
						_hintString = setHtmlColor(formatString(TIP_REQUIRED_COMPLETE), formStyle.colorComplete);
					} else {
						_hintString = setHtmlColor(getNormalFollowText(), formStyle.colorNormal);
					}
			}
			hint(_hintString,_isBottom);

			//if (autoCreateView){
				clearTimeout(timeOutID);
				timeOutID=setTimeout(fixComponentTextY, 45);
			//}

			if (_result){
				//需要format数据
				return _data;
			} else if (!required && (_data === ERROR_UNSELECTED || _data === ERROR_UNINPUT)){
				//字段为非必要且没有数据
				return true;
			} else {
				//没有数据或数据非法
				return false;
			}
		}

		public function getData():* {
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
				case ST_CHECK:
					_data = getCheckBoxData(view);
					break;
			}
			
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
					//通过
				} else {
					_data = ERROR_REG;
				}
			} else if (_data is Number){
				//通过
			} else if (_data is Array){
				if (least && _data.length < least){
					_data = ERROR_LEAST;
				} else if (most && _data.length > most){
					_data = ERROR_MOST;
				} else if (_data[_data.length - 1] is String){
					var _customData:String = _data[_data.length - 1];
					if (_customData){
						if (testStringReg(_customData, reg)){
							//通过
						} else {
							_data = ERROR_REG;
						}
					} else {
						_data = ERROR_UNINPUT_CUSTOM;
					}
				} else {
					//通过
				}
			} else if (_data){
				//通过（其他数据格式）
			} else {
				_data = ERROR_UNSELECTED;
			}
			return _data;
		}
		
		public function getOrgData():*{
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
					_data = options.elements(RemoteAction.E_CASE).(attribute(RemoteAction.A_LABEL) == _data)[0];
					break;
				case ST_RADIO_BUTTON:
					_data = getRadioBtnsData(view);
					_data = options.elements(RemoteAction.E_CASE).(attribute(RemoteAction.A_LABEL) == _data)[0];
					break;
				case ST_CHECK_BOX:
					_data = getCheckBoxesData(view);
					_data = options.elements(RemoteAction.E_CASE).(attribute(RemoteAction.A_LABEL) == _data)[0];
					break;
				case ST_CHECK:
					_data = getCheckBoxData(view);
					_data = options.elements(RemoteAction.E_CASE).(attribute(RemoteAction.A_VALUE) == _data)[0];
					break;
			}
		}

		private function setLabels():void {
			//
			if (label){
			} else {
				label = new Label();
			}
			label.enabled = false;
			label.mouseChildren = false;
			label.mouseEnabled = false;
			label.autoSize = TextFieldAutoSize.RIGHT;
			
			if (options.elements(RemoteAction.A_LABEL).length() > 0) {
				label.htmlText = replaceString(options.elements(RemoteAction.A_LABEL).text().toXMLString());
			}else if (options.attribute(RemoteAction.A_LABEL).length() > 0) {
				label.htmlText = setHtmlColor(options.attribute(RemoteAction.A_LABEL), formStyle.colorLabel);
			}else {
				label.htmlText = replaceString(options.text().toXMLString());
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

		private function setView(_view:* = null):void {
			var _remoteAction:RemoteAction;
			if (_view is Event){
				//读取到item列表后再初始化view
				if (_view.currentTarget is RemoteAction) {
					//RemoteAction节点
					_remoteAction = _view.currentTarget as RemoteAction;
					if (_remoteAction.data is Array) {
						//暂支持第一层数组，后续支持自动解析对象
						for each(var _item:Object in _remoteAction.data) {
							options.appendChild(<{RemoteAction.E_CASE} {RemoteAction.A_LABEL}={_item[RemoteAction.A_LABEL]} {RemoteAction.A_VALUE}={_item[RemoteAction.A_VALUE]}/>);
						}
					}
					_remoteAction.remove();
				}else {
					//xml远程列表
					options.appendChild(XML(_view).elements(RemoteAction.E_CASE));
				}
				_view = null;
			}
			var _source:String = options.attribute(RemoteAction.A_SOURCE)[0];
			if (_source && options.elements(RemoteAction.E_CASE).length() <= 0) {
				//读取item列表
				view = _view;
				if (RemoteAction.isRemoteNode(options)) {
					//RemoteAction节点
					_remoteAction = new RemoteAction(options);
					_remoteAction.addEventListener(Event.COMPLETE, setView);
					_remoteAction.sendAndLoad();
					return;
				}else {
					var _otherFieldName:String = RemoteAction.getValue(_source, 0);
					var _field:Field = formAction.getField(_otherFieldName);
					if (_field) {
						//绑定其他Field的数据
					}else {
						//xml远程列表
						rM.load(_source,setView);
						return;
					}
				}
			}
			switch (styleType){
				case ST_TEXT_INPUT:
					view = setTextInput(_view || view, options);
					break;
				case ST_TEXT_AREA:
					view = setTextArea(_view || view, options);
					break;
				case ST_COMBO_BOX:
					view = setComboBox(_view || view, options);
					(view as ComboBox).addEventListener(Event.CHANGE, onComboBoxChangeHandler);
					break;
				case ST_RADIO_BUTTON:
					view = setRadioBtns(_view || view, options);
					break;
				case ST_CHECK_BOX:
					view = setCheckBoxes(_view || view, options);
					break;
				case ST_CHECK:
					view = setCheckBox(_view || view, options);
					break;
				case ST_LABEL:
					view = _view || label;
					view.autoSize = TextFieldAutoSize.LEFT;
					view.wordWrap = true;
					break;
				default:
					trace(styleType, "unknown styleType!!!");
					return;
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
				case ST_CHECK:
				default:
					if (view && "addEventListener" in view){
						view.addEventListener(FocusEvent.FOCUS_IN, onFocusInHandler);
						view.addEventListener(FocusEvent.FOCUS_OUT, onFocusOutHandler);
					}
			}
			if (autoCreateView){
				setViewStyle();
			}
		}
		
		private function onComboBoxChangeHandler(_e:Event):void {
			
		}

		private function setViewStyle():void {
			viewContainer.addChild(label);
			label.x = formStyle.startX;
			label.y = formStyle.startY + offY;
			label.width = formStyle.widthLabel;
			//label.height = formStyle.height;
			//
			pointFollow.x = formStyle.startX + formStyle.widthLabel + formStyle.dxLF + formStyle.width + formStyle.dxFL;
			pointFollow.y = label.y;
			//
			if (styleType == ST_RADIO_BUTTON || styleType == ST_CHECK_BOX){
				var _width:uint = int(options.style.@width);
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
						pointFollow.x = Math.max(pointFollow.x, _item.x + _item.getRect(_itemPrev).width + formStyle.dxFL);
					} else {
						_item.x = formStyle.startX + formStyle.widthLabel + formStyle.dxLF;
						_item.y = label.y;
					}
					_item.height = formStyle.height;
				}
				height = _item.y + _item.height - view[0].y;
			} else {
				viewContainer.addChild(view);
				if (styleType == ST_CHECK) {
					label.visible = false;
					view.x = formStyle.startX;
				}else if (styleType == ST_LABEL){
					view.x = formStyle.startX;
					view.width = formStyle.widthLabel + formStyle.dxLF;
					if (options.style.length() > 0 && int(options.style.@width) > 0) {
						view.width += int(options.style.@width);
					}else {
						view.width += formStyle.width;
					}
				} else {
					view.x = formStyle.startX + formStyle.widthLabel + formStyle.dxLF;
					view.width = formStyle.width;
				}
				view.y = label.y;
				if (styleType == ST_TEXT_AREA){
					view.height = formStyle.height * 2;
				} else {
					view.height = formStyle.height;
				}
				height = view.height;
			}
			//
			viewContainer.addChild(followLabel);
			followLabel.x = pointFollow.x;
			followLabel.y = pointFollow.y;
			//followLabel.height = formStyle.height;
			pointBottom.x = view.x;
			pointBottom.y = int(view.y + view.height) + 1;
			//delay
			//setTimeout(, 0);
			fixComponentTextY();
		}

		private function fixComponentTextY():void {
			clearTimeout(timeOutID);
			label.textField.y = OFFY_LABEL;
			followLabel.textField.y = OFFY_LABEL;
			if (styleType == ST_RADIO_BUTTON || styleType == ST_CHECK_BOX || styleType == ST_CHECK){
				
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

		private function onFocusInHandler(e:FocusEvent):void {
			//hint
			hint(setHtmlColor(formatString(options.attribute(A_HINT)), formStyle.colorHint),true);

		}

		private function onFocusOutHandler(e:FocusEvent):void {
			isInputComplete(false);
		}

		private function hint(_htmlString:String, _isBottom:Boolean = false):void {
			if (followLabel){
				followLabel.htmlText = _htmlString;
				if (_isBottom && followLabelToBottom) {
					followLabel.x = pointBottom.x;
					followLabel.y = pointBottom.y;
				}else {
					followLabel.x = pointFollow.x;
					followLabel.y = pointFollow.y;
				}
			}
		}

		private function formatString(_str:String):String {
			for each(var _eachAtt:XML in options.attributes()) {
				_str = RemoteAction.replaceValue(_str,_eachAtt.name(),_eachAtt);
			}
			return _str;
		}

	}
}