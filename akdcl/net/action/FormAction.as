package akdcl.net.action {
	import flash.display.DisplayObjectContainer;
	import ui.manager.FLManager;

	/**
	 * ...
	 * @author Akdcl
	 */
	public class FormAction extends RemoteAction {
		public static const E_INPUT:String = "input";

		public static const ST_TEXT_INPUT:String = "TextInput";
		public static const ST_TEXT_AREA:String = "TextArea";
		public static const ST_COMBO_BOX:String = "ComboBox";
		public static const ST_RADIO_BUTTON:String = "RadioButton";
		public static const ST_CHECK_BOX:String = "CheckBox";
		public static const ST_CHECK:String = "Check";

		public static const ST_LABEL:String = "Label";

		public var container:DisplayObjectContainer;
		public var style:FormStyle;

		public var x:int;
		public var y:int;
		public var width:uint;
		public var height:uint;

		protected var fields:Object;

		public function FormAction(_optionsXML:XML = null, _container:DisplayObjectContainer = null, _x:int = 0, _y:int = 0){
			container = _container;
			x = _x;
			y = _y;
			super(_optionsXML);
		}

		override public function clear():void {
			for each (var _field:Field in fields){
				_field.clear();
			}
			super.clear();
		}

		override public function sendAndLoad():Boolean {
			if (isInputComplete()){
				return super.sendAndLoad();
			} else {
				return false;
			}
		}

		//检查Field数据，并将数据填充到dataSend
		public function isInputComplete():Boolean {
			flStyleSet();
			var _result:Boolean = true;
			for each (var _field:Field in fields){
				var _data:* = _field.isInputComplete();
				if (_data === false){
					//false（没有数据或数据非法）
					_result = false;
				} else if (_data === true){
					//true（字段为非必要且没有数据）
				} else {
					//data（数据）
					dataSend[_field.name] = _data;
				}
			}
			return _result;
		}

		public function getField(_fieldName:String):Field {
			return fields[_fieldName];
		}

		override protected function resolveLoad(_resultXML:XML):void {
			super.resolveLoad(_resultXML);
			fields = {};
			style = new FormStyle();
			if (optionsSend.style.length() > 0){
				for each (var _styleParams:XML in optionsSend.style.attributes()){
					var _paramName:String = _styleParams.name();
					switch (_paramName){
						case "width":
						case "height":
						case "widthLabel":
						case "dyFF":
							style[_paramName] = int(optionsSend.style.attribute(_paramName));
							break;
						case "colorLabel":
						case "colorNormal":
						case "colorHint":
						case "colorError":
						case "colorComplete":
							style[_paramName] = String(optionsSend.style.attribute(_paramName));
							break;
					}
				}
			}
			flStyleSet();

			width = 0;
			height = 0;
			for (var _i:uint = 0; _i < optionsSend.elements(E_INPUT).length(); _i++){
				var _fieldXML:XML = optionsSend.elements(E_INPUT)[_i];
				var _fieldName:String = _fieldXML.attribute(A_NAME);

				var _field:Field = createField(_fieldXML);
				if (_field){
					_field.setOptions(_fieldXML, this, x, y + height);
					width = Math.max(width, _field.width);
					height += _field.height + style.dyFF;
					fields[_fieldName] = _field;
				}
			}
		}

		override protected function getVariableList(_xml:XML):XMLList {
			return _xml.elements().(name() == E_VARIABLE || name() == E_INPUT);
		}

		private function createField(_fieldXML:XML):Field {
			var _styleType:String = _fieldXML.attribute(Field.A_STYLE_TYPE)[0];
			if (_styleType){
			} else {
				//没有指定styleType
				if (_fieldXML.elements(RemoteAction.E_CASE).length() > 0 || _fieldXML.attribute(RemoteAction.A_SOURCE).length() > 0){
					//有case节点则默认为comboBox
					_styleType = ST_COMBO_BOX;
				} else if (!_fieldXML.attribute(RemoteAction.A_NAME)[0]){
					//没有key属性则默认为label
					_styleType = ST_LABEL;
				} else {
					//其他默认为input
					_styleType = ST_TEXT_INPUT;
				}
			}
			switch (_styleType){
				case ST_TEXT_INPUT:
					return new TextInputField();
				case ST_TEXT_AREA:
					return new TextAreaField();
				case ST_COMBO_BOX:
					return new ComboxField();
				case ST_RADIO_BUTTON:
					return new RadioButtonField();
				case ST_CHECK_BOX:
					return new CheckBoxField();
				case ST_CHECK:
					return new CheckField();
				default:
					trace(_styleType, "unknown styleType!!!");
			}
			return null;
		}

		private function flStyleSet():void {
			FLManager.setTextFormat(style.fontSize, style.color, style.font);
		}
	}
}