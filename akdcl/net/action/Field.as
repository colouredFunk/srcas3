package akdcl.net.action{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.geom.Point;
	import flash.text.TextFieldAutoSize;

	import fl.controls.Label;

	import akdcl.manager.RequestManager;
	import akdcl.utils.stringToBoolean;
	import akdcl.utils.replaceString;
	
	import ui.UIEventDispatcher;

	/**
	 * ...
	 * @author Akdcl
	 */
	public class Field extends UIEventDispatcher {
		protected static var rM:RequestManager = RequestManager.getInstance();
		
		protected var options:XML;
		protected var formAction:FormAction;
		protected var container:DisplayObjectContainer;
		protected var style:FormStyle;
		protected var view:*;
		
		private var __x:int;
		public function get x():int {
			return __x;
		}
		public function set x(_x:int):void {
			__x = _x;
		}
		
		private var __y:int;
		public function get y():int {
			return __y;
		}
		public function set y(_y:int):void {
			__y = _y;
		}
		
		protected var __data:*;
		public function get data():*{
			return __data;
		}
		
		override protected function init():void 
		{
			super.init();
		}

		public function setOptions(_xml:XML, _formAction:FormAction, _x:int = 0, _y:int = 0):void {
			options = _xml;
			formAction = _formAction;
			__x = _x;
			__y = _y;
			container = formAction.container;
			style = formAction.style;
			
			required = stringToBoolean(options.attribute(A_REQUIRED)[0]);
			reg = options.attribute(A_REG)[0];
			least = int(options.attribute(A_LEAST)[0]);
			most = int(options.attribute(A_MOST)[0]);
			
			setLabels();
			
			var _source:String = options.attribute(RemoteAction.A_SOURCE)[0];
			if (_source && options.elements(RemoteAction.E_CASE).length() <= 0) {
				if (RemoteAction.isRemoteNode(options)) {
					//RemoteAction节点
					_remoteAction = new RemoteAction(options);
					_remoteAction.addEventListener(Event.COMPLETE, onOptionsCompleteHandler);
					_remoteAction.sendAndLoad();
				}else {
					var _otherFieldName:String = RemoteAction.getValue(_source, 0);
					var _field:Field = formAction.getField(_otherFieldName);
					if (_field) {
						//绑定其他Field的数据
						setView();
					}else {
						//xml远程列表
						rM.load(_source, onOptionsCompleteHandler);
					}
				}
			}else {
				setView();
			}
		}
		
		public function clear():void {
			
		}
		
		protected function setLabels():void {
			if (label){
			} else {
				label = new Label();
			}
			label.enabled = false;
			label.mouseChildren = false;
			label.mouseEnabled = false;
			label.autoSize = TextFieldAutoSize.RIGHT;
			//
			var _eLabel:XML = options.elements(RemoteAction.A_LABEL)[0];
			var _aLabel:XML = options.attribute(RemoteAction.A_LABEL)[0];
			if (_xmlLabel) {
				label.htmlText = replaceString(_xmlLabel.text().toXMLString());
			}else if (_aLabel) {
				label.htmlText = setHtmlColor(_aLabel, style.colorLabel);
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
			followLabel.htmlText = setHtmlColor(getNormalFollowText(), style.colorNormal);
		}
		
		protected function setView():void {
			
		}
		
		protected function setViewStyle():void {
			container.addChild(label);
			label.x = x;
			label.y = y;
			label.width = style.widthLabel;
			//label.height = style.height;
			//
			//pointFollow.x = x + style.widthLabel + style.dxLF + style.width + style.dxFL;
			//pointFollow.y = label.y;
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
		
		protected function onOptionsCompleteHandler(_evtOrData:*):void {
			if (_evtOrData is Event) {
				var _remoteAction:RemoteAction = _evtOrData.currentTarget;
				if (_remoteAction.data is Array) {
					//暂支持第一层数组，后续支持自动解析对象
					for each(var _item:Object in _remoteAction.data) {
						options.appendChild(<{RemoteAction.E_CASE} {RemoteAction.A_LABEL}={_item[RemoteAction.A_LABEL]} {RemoteAction.A_VALUE}={_item[RemoteAction.A_VALUE]}/>);
					}
				}
				_remoteAction.remove();
			}else {
				options.appendChild(XML(_evtOrData).elements(RemoteAction.E_CASE));
			}
			setView();
		}
		
		protected function fixComponentTextY():void {
			clearTimeout(timeOutID);
			label.textField.y = OFFY_LABEL;
			followLabel.textField.y = OFFY_LABEL;
			
			//view.textField.y = OFFY_VIEW;
		}
		
		protected function getNormalFollowText():String {
			if (required){
				return TIP_REQUIRED;
			} else {
				return STRING_DEFAULT;
			}
		}

		protected function onFocusInHandler(e:FocusEvent):void {
			hint(setHtmlColor(formatString(options.attribute(A_HINT)), formStyle.colorHint),true);

		}

		protected function onFocusOutHandler(e:FocusEvent):void {
			isInputComplete(false);
		}

		protected function hint(_htmlString:String, _isBottom:Boolean = false):void {
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

		protected function formatString(_str:String):String {
			for each(var _eachAtt:XML in options.attributes()) {
				_str = RemoteAction.replaceValue(_str,_eachAtt.name(),_eachAtt);
			}
			return _str;
		}
	}
}