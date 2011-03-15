package akdcl.application.submit{
	
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

	import akdcl.utils.stringToBoolean;
	import akdcl.net.DataLoader;
	import akdcl.utils.replaceString;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class FieldView {
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

	}
	
}