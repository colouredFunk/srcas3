package akdcl.application {
	import flash.events.Event;

	import fl.controls.ComboBox;
	import fl.controls.TextInput;
	import fl.controls.Label;

	import ui.UISprite;
	import ui.manager.FLManager;

	import akdcl.net.DataLoader;
	import akdcl.net.SubmitFields;

	/**
	 * ...
	 * @author Akdcl
	 */
	public class SubmitForm extends UISprite {
		protected var labelList:Array;
		protected var fieldList:Array;
		protected var sourceXML:XML;
		protected var submitFields:SubmitFields;

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
			labelList = null;
			fieldList = null;
			sourceXML = null;
			super.onRemoveToStageHandler();
		}

		public function setSource(_xml:XML):void {
			sourceXML = _xml;
			submitFields.setSource(sourceXML);
			setStyle();
		}

		public function isAllComplete():* {
			var _fieldData:*;
			submitFields.clear();
			for (var _i:uint; _i < fieldList.length; _i++){
				_fieldData = fieldList[_i];
				if (_fieldData is ComboBox){
					submitFields.add(sourceXML.children()[_i].@key, _fieldData.selectedItem.data);
				} else {
					submitFields.add(sourceXML.children()[_i].@key, _fieldData.text);
				}
			}
			return submitFields.isAllComplete();
		}

		protected function setStyle():void {
			//
			labelList = [];
			fieldList = [];
			var _xml:XML;
			var _label:Label;
			var _input:TextInput;
			var _comboBox:ComboBox;
			for (var _i:uint; _i < sourceXML.children().length(); _i++){
				_xml = sourceXML.children()[_i];
				if (_xml.@label.length() == 0){
					continue;
				}
				//
				_label = setLabel(null, _i);
				addChild(_label);
				labelList.push(_label);
				//
				if (_xml.item.length() > 0 || _xml.@source.length() > 0){
					_comboBox = setComboBox(null, _i);
					addChild(_comboBox);
					fieldList.push(_comboBox);
				} else {
					_input = setTextInput(null, _i);
					addChild(_input);
					fieldList.push(_input);
				}
			}
		}

		protected function setLabel(_label:*, _id:uint, ... args):* {
			if (!_label){
				_label = new Label();
			}
			_label.autoSize = "right";
			_label.x = 0;
			_label.y = 30 * _id;
			var _xml:XML = sourceXML.children()[_id];
			_label.text = _xml.@label;
			return _label;
		}

		protected function setTextInput(_textInput:*, _id:uint, ... args):* {
			if (!_textInput){
				_textInput = new TextInput();
			}
			_textInput.x = 100;
			_textInput.y = 30 * _id;
			var _xml:XML = sourceXML.children()[_id];
			_textInput.maxChars = int(_xml.@maxChars);
			if (_xml.@maxChars.length() > 0){
				_textInput.maxChars = int(_xml.@maxChars);
			}
			if (_xml.@restrict.length() > 0){
				_textInput.restrict = String(_xml.@restrict);
			}
			return _textInput;
		}

		protected function setComboBox(_comboBox:*, _id:uint, ... args):* {
			if (!_comboBox){
				_comboBox = new ComboBox();
			}
			_comboBox.x = 100;
			_comboBox.y = 30 * _id;
			var _xml:XML = sourceXML.children()[_id];
			if (_xml.item.length() > 0){
				_comboBox.removeAll();
				_comboBox.addItem({label: "请选择", data: ""});
				for each (var _eachXML:XML in _xml.item){
					_comboBox.addItem({label: _eachXML.@label, data: _eachXML.@value});
				}
				_comboBox.selectedIndex = 0;
			} else if (_xml.@source.length() > 0){
				var _dataLoader:DataLoader = DataLoader.load(_xml.@source, null, onItemListLoadedHandler);
				_dataLoader.userData = {comboBox: _comboBox, xml: _xml, id: _id};
			}
			return _comboBox;
		}

		protected function onItemListLoadedHandler(_evt:Event):void {
			var _dataLoader:DataLoader = _evt.currentTarget as DataLoader;
			var _xml:XML = _dataLoader.userData.xml;
			_xml.appendChild(XML(_dataLoader.data).item);
			setComboBox(_dataLoader.userData.comboBox, _dataLoader.userData.id);
		}
	}

}