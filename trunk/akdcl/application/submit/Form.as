package akdcl.application.submit {
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
	public class Form {
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
			fieldList = [];
			checkResultList = [];
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

		protected function setLabel(_label:Label, _id:uint, ... args):Label {
			if (!_label){
				_label = new Label();
			}
			var _xml:XML = sourceXML.children()[_id];
			_label.autoSize = "right";
			_label.text = _xml.@label;
			return _label;
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
	}

}