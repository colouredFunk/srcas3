package akdcl.net.action{
	import flash.display.DisplayObjectContainer;
	import ui.manager.FLManager;

	/**
	 * ...
	 * @author Akdcl
	 */
	public class FormAction extends RemoteAction {
		public static const E_INPUT:String = "input";

		protected var fields:Object;
		protected var startX:int;
		protected var startY:int;

		public var container:DisplayObjectContainer;
		public var style:FormStyle;
		public var height:uint;

		public function FormAction(_optionsXML:XML = null, _container:DisplayObjectContainer = null, _startX:int = 0, _startY:int = 0){
			container = _container;
			startX = _startX;
			startY = _startY;
			super(_optionsXML);
		}

		override protected function resolveLoad(_resultXML:XML):void {
			super.resolveLoad(_resultXML);
			fields = {};
			style = new FormStyle();
			style.startX = startX;
			style.startY = startY;
			if (optionsSend.style.length() > 0){
				for each (var _styleParams:XML in optionsSend.style.attributes()){
					var _paramName:String = _styleParams.name();
					switch (_paramName){
						case "width":
						case "height":
						case "widthLabel":
						case "dxLF":
						case "dxRAC":
						case "dxFL":
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
			FLStyleSet();

			var _offHeight:uint = 0;
			for (var _i:uint = 0; _i < optionsSend.elements(E_INPUT).length(); _i++){
				var _fieldXML:XML = optionsSend.elements(E_INPUT)[_i];
				var _fieldName:String = _fieldXML.attribute(A_NAME);
				var _field:Field;
				/*if (_views) {
				   if (_views[_fieldName]) {
				   _field = new Field();
				   _field.setOptions(_fieldXML, container, style, _views[_fieldName]);
				   }else {
				   //
				   continue;
				 }*/
				//}else {
				_field = new Field(this);
				_offHeight += _field.setOptions(_fieldXML, container, style, null, _offHeight);
				_offHeight += style.dyFF;
				//}
				fields[_fieldName] = _field;
			}
			height = _offHeight;
		}
		
		private function FLStyleSet():void {
			FLManager.setTextFormat(12, style.color, "微软雅黑");
			FLManager.setTextFormatTo("CheckBox",12, 0xD8BA8C, "微软雅黑");
			FLManager.setTextFormatTo("RadioButton",12, 0xD8BA8C, "微软雅黑");
		}

		override public function sendAndLoad():Boolean {
			if (isInputComplete()){
				return super.sendAndLoad();
			} else {
				return false;
			}
		}

		override protected function getVariableList(_xml:XML):XMLList {
			return _xml.elements().(name() == E_VARIABLE || name() == E_INPUT);
		}

		//检查Field数据，并将数据填充到dataSend
		public function isInputComplete():Boolean {
			FLStyleSet();
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

		override public function clear():void {
			for each (var _field:Field in fields){
				_field.clear();
			}
			super.clear();
		}
	}
}