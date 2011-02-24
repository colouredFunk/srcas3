package akdcl.application {
	import flash.events.Event;

	import fl.controls.Label;
	import fl.controls.TextInput;
	import fl.controls.TextArea;
	import fl.controls.RadioButton;
	import fl.controls.CheckBox;
	import fl.controls.ComboBox;

	import ui.UISprite;

	import akdcl.net.DataLoader;
	import akdcl.net.SubmitFields;
	import akdcl.utils.stringToBoolean;

	/**
	 * ...
	 * @author Akdcl
	 */
	public class SubmitForm extends UISprite {
		protected var labelList:Array;
		protected var fieldList:Array;
		protected var followLabelList:Array;
		protected var prevDataList:Array;
		protected var checkResultList:Array;

		protected var sourceXML:XML;
		protected var submitFields:SubmitFields;

		protected var START_X:uint = 0;
		protected var WIDTH_LABEL:uint = 100;
		protected var DX_LF:uint = 0;
		protected var DX_RR:uint = 0;

		protected var WIDTH_FIELDS:uint = 120;
		protected var DX_FRL:uint = 0;

		protected var START_Y:uint = 0;
		protected var DY_PER:uint = 30;

		public function get data():Object {
			return submitFields.data;
		}

		override protected function init():void {
			super.init();
			submitFields = new SubmitFields();
		}

		override protected function onRemoveToStageHandler():void {
			submitFields.remove();
			submitFields = null;
			sourceXML = null;
			labelList = null;
			fieldList = null;
			followLabelList = null;
			prevDataList = null;
			checkResultList = null;
			super.onRemoveToStageHandler();
		}

		public function setSource(_xml:XML):void {
			sourceXML = _xml;
			submitFields.setSource(sourceXML);
			setStyle();
		}

		public function isAllComplete():* {
			var _field:*;
			//submitFields.clear();
			var _xml:XML;

			for (var _id:uint; _id < fieldList.length; _id++){
				_xml = sourceXML.children()[_id];
				_field = fieldList[_id];
				if (_field is ComboBox){

				} else if (_field is Vector.<RadioButton>){

				} else if (_field is Vector.<CheckBox>){

				} else if (_field is TextInput || _field is TextArea){

				} else {

				}
			}
			return submitFields.isAllComplete();
		}

		protected function setStyle():void {
			//
			labelList = [];
			fieldList = [];
			followLabelList = [];
			prevDataList = [];
			checkResultList = [];
			var _xml:XML;
			for (var _id:uint; _id < sourceXML.children().length(); _id++){
				_xml = sourceXML.children()[_id];
				if (_xml.@label.length() == 0){
					continue;
				}
				//
				labelList[_id] = setLabel(null, _id);
				//
				var _styleType:String = _xml.@styleType;
				var _isStyleType:Boolean = stringToBoolean(_styleType);
				if (_xml.item.length() > 0 || _xml.@source.length() > 0){
					switch (_isStyleType ? _styleType : false){
						case false:
						case "ComboBox":
							fieldList[_id] = setComboBox(null, _id);
							break;
						case "RadioButton":
							fieldList[_id] = setRadioBtns(null, _id);
							break;
						case "CheckBox":
							fieldList[_id] = setCheckBoxes(null, _id);
							break;
						default:
					}
				} else {
					switch (_isStyleType ? _styleType : false){
						case false:
						case "TextInput":
							fieldList[_id] = setTextInput(null, _id);
							break;
						case "TextArea":
							fieldList[_id] = setTextArea(null, _id);
							break;
						default:
					}
				}
				//
				followLabelList.push(setFollowLabel(null, _id));
				//
				setFieldStyle(_id);
			}
		}

		protected function setFieldStyle(_id:uint):void {
			var _label:Label;
			var _field:*;
			var _followLabel:Label
			//
			_label = labelList[_id];
			_label.x = START_X;
			_label.y = START_Y + DY_PER * _id;
			_label.width = WIDTH_LABEL;
			addChild(_label);
			//
			_field = fieldList[_id];
			if (_field is Vector.<RadioButton> || _field is Vector.<CheckBox>){
				for (var _i:uint = 0; _i < _field.length; _i++){
					var _item:* = _field[_i];
					if (_i == 0){
						_item.x = START_X + WIDTH_LABEL + DX_LF;
					} else {
						var _itemPrev:* = _field[_i - 1];
						_item.x = _itemPrev.x + _itemPrev.textField.width + 45 + DX_RR;
					}
					_item.y = START_Y + DY_PER * _id;
					addChild(_item);
				}
			} else {
				_field.x = START_X + WIDTH_LABEL + DX_LF;
				_field.y = START_Y + DY_PER * _id;
				_field.width = WIDTH_FIELDS;
				addChild(_field);
			}
			//
			_followLabel = followLabelList[_id];
			_followLabel.x = START_X + WIDTH_LABEL + DX_LF + WIDTH_FIELDS + DX_FRL;
			_followLabel.y = START_Y + DY_PER * _id;
			addChild(_followLabel);
		}
		protected function checkFieldData(_id:uint, _checkUndata:Boolean = false):void {
			var _xml:XML = sourceXML.children()[_id];
			var _field:* = fieldList[_id];
			var _data:*;
			if (_field is TextInput) {
				_data = getTextInputData(_field);
				if (_data) {
					//已填写,判断字符串
				}else {
					if (_checkUndata) {
						//没填
					}
					checkResultList[_id] = false;
				}
			}else if(_field is TextArea){
				_data = getTextAreaData(_field);
				if (_data) {
					//已填写,判断字符串
				}else {
					if (_checkUndata) {
						//没填
					}
					checkResultList[_id] = false;
				}
			}else if(_field is ComboBox){
				_data = getComboBoxData(_field);
				if (_data is String) {
					//已填写,判断字符串
				}else if (_data < 0) {
					if (_checkUndata) {
						//没填
					}
					checkResultList[_id] = false;
				}else {
					checkResultList[_id] = true;
				}
			}else if (_field is Vector.<RadioButton>) {
				_data = getRadioButtonData(_field);
				if (_data < 0) {
					if (_checkUndata) {
						//没填
					}
					checkResultList[_id] = false;
				}else {
					checkResultList[_id] = true;
				}
			}else if (_field is Vector.<CheckBox>) {
				_data = getCheckBoxData(_field);
				if (_data.length == 0) {
					if (_checkUndata) {
						//没填
					}
					checkResultList[_id] = false;
				}else if (stringToBoolean(_xml.@lease) && _data.length < int(_xml.@least)) {
					//least
					checkResultList[_id] = false;
				}else if (stringToBoolean(_xml.@most) && _data.length > int(_xml.@most)) {
					//most
					checkResultList[_id] = false;
				}else if (_data[_data.length - 1] is String) {
					//已填写,判断字符串
				}else if (_data[_data.length - 1] < 0) {
					//没填custom
					checkResultList[_id] = false;
				}else {
					checkResultList[_id] = true;
				}
			}else {
				//
			}
			
		}
		//string
		protected function getTextInputData(_field:TextInput):String {
			return _field.text;
		}

		//string
		protected function getTextAreaData(_field:TextArea):String {
			return _field.text;
		}

		//>=0(selectedIndex),-1(unselected),string(custom)
		protected function getComboBoxData(_field:ComboBox):* {
			if (_field.selectedItem){
				return _field.selectedIndex;
			} else if (_field.text && _field.text != _field.prompt){
				return _field.text;
			} else {
				return -1;
			}
		}

		//>=0(selectedIndex),-1(unselected)
		protected function getRadioButtonData(_field:Vector.<RadioButton>):int {
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
		protected function getCheckBoxData(_field:Vector.<CheckBox>):Array {
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

		protected function setLabel(_label:Label, _id:uint, ... args):Label {
			if (!_label){
				_label = new Label();
			}
			var _xml:XML = sourceXML.children()[_id];
			_label.autoSize = "right";
			_label.text = _xml.@label;
			return _label;
		}

		protected function setTextInput(_field:TextInput, _id:uint, ... args):TextInput {
			if (!_field){
				_field = new TextInput();
			}
			var _xml:XML = sourceXML.children()[_id];
			_field.maxChars = int(_xml.@maxChars);
			if (stringToBoolean(_xml.@restrict)){
				_field.restrict = String(_xml.@restrict);
			}
			return _field;
		}

		protected function setTextArea(_field:TextArea, _id:uint, ... args):TextArea {
			if (!_field){
				_field = new TextArea();
			}
			var _xml:XML = sourceXML.children()[_id];
			_field.maxChars = int(_xml.@maxChars);
			if (stringToBoolean(_xml.@restrict)){
				_field.restrict = String(_xml.@restrict);
			}
			return _field;
		}

		protected function setComboBox(_field:ComboBox, _id:uint, ... args):ComboBox {
			if (!_field){
				_field = new ComboBox();
			}
			var _xml:XML = sourceXML.children()[_id];
			if (_xml.item.length() > 0){
				_field.removeAll();
				_field.rowCount = int(_field.rowCount);
				_field.prompt = _xml.@prompt || "请选择";
				_field.selectedItem = null;
				for each (var _eachXML:XML in _xml.item){
					_field.addItem({label: _eachXML.@label});
				}
			} else if (_xml.@source.length() > 0){
				DataLoader.load(_xml.@source, null, onItemListLoadedHandler).userData = {field: _field, xml: _xml, id: _id};
			}
			return _field;
		}

		protected function setRadioBtns(_field:Vector.<RadioButton>, _id:uint, ... args):Vector.<RadioButton> {
			if (!_field){
				_field = new Vector.<RadioButton>();
			}
			var _xml:XML = sourceXML.children()[_id];
			if (_xml.item.length() > 0){
				for each (var _eachXML:XML in _xml.item){
					var _radioBtn:RadioButton = new RadioButton();
					_radioBtn.groupName = String(_xml.name());
					_radioBtn.label = _eachXML.@label;
					_radioBtn.textField.autoSize = "right";
					_field.push(_radioBtn);
				}
			} else if (_xml.@source.length() > 0){
				DataLoader.load(_xml.@source, null, onItemListLoadedHandler).userData = {field: _field, xml: _xml, id: _id};
			}
			return _field;
		}

		protected function setCheckBoxes(_field:Vector.<CheckBox>, _id:uint, ... args):Vector.<CheckBox> {
			if (!_field){
				_field = new Vector.<CheckBox>();
			}
			var _xml:XML = sourceXML.children()[_id];
			if (_xml.item.length() > 0){
				for each (var _eachXML:XML in _xml.item){
					var _checkBox:CheckBox = new CheckBox();
					_checkBox.label = _eachXML.@label;
					_checkBox.textField.autoSize = "right";
					_field.push(_checkBox);
				}
			} else if (_xml.@source.length() > 0){
				DataLoader.load(_xml.@source, null, onItemListLoadedHandler).userData = {field: _field, xml: _xml, id: _id};
			}
			return _field;
		}

		protected function setFollowLabel(_label:Label, _id:uint, ... args):Label {
			if (!_label){
				_label = new Label();
			}

			var _xml:XML = sourceXML.children()[_id];
			if (stringToBoolean(_xml.@required)){
				_label.htmlText = "*";
			} else {
				_label.htmlText = "";
			}
			_label.autoSize = "left";
			return _label;
		}

		protected function onItemListLoadedHandler(_evt:Event):void {
			var _dataLoader:DataLoader = _evt.currentTarget as DataLoader;
			_dataLoader.userData.xml.appendChild(XML(_dataLoader.data).item);
			var _field:* = _dataLoader.userData.field;
			var _id:uint = _dataLoader.userData.id;
			if (_field is ComboBox){
				setComboBox(_field, _id);
			} else if (_field is Vector.<RadioButton>){
				setRadioBtns(_field, _id);
			} else if (_field is Vector.<CheckBox>){
				setCheckBoxes(_field, _id);
			}
			setFieldStyle(_id);
		}
	}

}