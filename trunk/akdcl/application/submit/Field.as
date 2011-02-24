package akdcl.application.submit {
	import flash.events.Event;

	import fl.controls.Label;
	import fl.controls.TextInput;
	import fl.controls.TextArea;
	import fl.controls.RadioButton;
	import fl.controls.CheckBox;
	import fl.controls.ComboBox;

	import akdcl.utils.stringToBoolean;
	/**
	 * ...
	 * @author Akdcl
	 */
	public class Field {
		public static var REQUIRED:String = "required";
		public static var KEY:String = "key";
		public static var REG:String = "reg";

		protected static function createTextInput(_source:XML):TextInput {
			var _field:TextInput = new TextInput();
			_field.maxChars = int(_source.@maxChars);
			if (stringToBoolean(_source.@restrict)){
				_field.restrict = String(_source.@restrict);
			}
			return _field;
		}

		protected static function createTextArea(_source:XML):TextArea {
			var _field:TextArea = new TextArea();
			_field.maxChars = int(_source.@maxChars);
			if (stringToBoolean(_source.@restrict)){
				_field.restrict = String(_source.@restrict);
			}
			return _field;
		}
		
		protected static function createComboBox(_source:XML):ComboBox {
			var _field:ComboBox = new ComboBox();
			_field.removeAll();
			_field.rowCount = int(_source.@rowCount) || _field.rowCount;
			_field.prompt = _source.@prompt || "请选择";
			for each (var _eachXML:XML in _source.item) {
				_field.addItem( { label: _eachXML.@label } );
			}
			return _field;
		}

		protected static function createRadioBtns(_source:XML):Vector.<RadioButton> {
			var _field:Vector.<RadioButton> = new Vector.<RadioButton>();
			for each (var _eachXML:XML in _source.item){
				var _radioBtn:RadioButton = new RadioButton();
				_radioBtn.groupName = String(_source.name());
				_radioBtn.label = _eachXML.@label;
				_radioBtn.textField.autoSize = "right";
				_field.push(_radioBtn);
			}
			return _field;
		}

		protected static function createCheckBoxes(_source:XML):Vector.<CheckBox> {
			var _field:Vector.<CheckBox> = new Vector.<CheckBox>();
			for each (var _eachXML:XML in _source.item){
				var _checkBox:CheckBox = new CheckBox();
				_checkBox.label = _eachXML.@label;
				_checkBox.textField.autoSize = "right";
				_field.push(_checkBox);
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

		//Array(int or string)
		protected static function getCheckBoxesData(_field:Vector.<CheckBox>):Array {
			var _item:CheckBox;
			var _list:Array = [];
			for (var _i:uint = 0; _i < _field.length; _i++){
				_item = _field[_i];
				if (_item.selected){
					//还要判断自定义的情况-1或字符串
					_list.push(_i);
				}
			}
			return _list;
		}
		private static function testStringReg(_str:String, _regStr:String):Boolean {
			var _reg:RegExp = new RegExp(_regStr);
			return !_reg.test(_str);
		}
		
		protected var view:*;
		protected var sourceXML:XML;
		public function Field(_xml:XML = null) {
			if (_xml) {
				setSource(_xml);
			}
		}
		public function setSource(_xml:XML):void {
			sourceXML = _xml
			setView();
		}
		public function getData():* {
			if (view is TextInput) {
				return getTextInputData(view);
			}else if (view is TextArea) {
				return getTextAreaData(view);
			}else if (view is ComboBox) {
				return getComboBoxData(view);
			}else if (view is Vector.<RadioButton>) {
				return getRadioBtnsData(view);
			}else if (view is Vector.<CheckBox>) {
				return getCheckBoxesData(view);
			}else {
				
			}
		}
		public function checkData(_checkUndata:Boolean = false):void {
			var _data:*= getData();
			if (_data is String) {
				if (testStringReg(_data, String(sourceXML.@reg))) {
					
				}
			}else if (_data is Number) {
				if (_data < 0) {
					//没填
				}else {
					
				}
			}else if (_data is Array) {
				if (_data.length == 0) {
					//没填
				}else if (stringToBoolean(sourceXML.@lease) && _data.length < int(sourceXML.@least)) {
					//least
				}else if (stringToBoolean(sourceXML.@most) && _data.length > int(sourceXML.@most)) {
					//most
				}else if (_data[_data.length - 1] is String) {
					//已填写,判断字符串
				}else if (_data[_data.length - 1] < 0) {
					//没填custom
				}else {
					
				}
			}else {
				
			}
		}
		protected function setView():void {
			var _styleType:String = sourceXML.@styleType;
			var _isStyleType:Boolean = stringToBoolean(_styleType);
			if (sourceXML.item.length() > 0) {
				switch (_isStyleType ? _styleType : false){
					case false:
					case "ComboBox":
						view = createComboBox(sourceXML);
						break;
					case "RadioButton":
						view = createRadioBtns(sourceXML);
						break;
					case "CheckBox":
						view = createCheckBoxes(sourceXML);
						break;
					default:
				}
			}else if (sourceXML.@source.length() > 0) {
				DataLoader.load(sourceXML.@source, null, onItemListLoadedHandler);
			} else {
				switch (_isStyleType ? _styleType : false){
					case false:
					case "TextInput":
						view = createTextInput(sourceXML);
						break;
					case "TextArea":
						view = createTextArea(sourceXML);
						break;
					default:
				}
			}
		}
		protected function onItemListLoadedHandler(_evt:Event):void {
			sourceXML.appendChild(XML(_evt.currentTarget.data).item);
			setView();
		}
	}

}