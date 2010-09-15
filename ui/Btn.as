package ui{
	import flash.events.Event;
	import flash.external.ExternalInterface;
	
	import ui.UIMovieClip;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class Btn extends UIMovieClip {
		public var rollOver:Function;
		public var rollOut:Function;
		public var press:Function;
		public var release:Function;
		
		public var area:*;
		public var href:String;
		public var hrefTarget:String = "_blank";
		public var eEval:String;
		public function set hrefXML(_hrefXML:XML):void{
			if (!_hrefXML) {
				return;
			}
			href = String(_hrefXML.@href);
			hrefTarget = String(_hrefXML.@target);
			eEval = String(_hrefXML.@js);
		}
		private var __buttonEnabled:Boolean;
		public function get buttonEnabled():Boolean{
			return __buttonEnabled;
		}
		public function set buttonEnabled(_buttonEnabled:Boolean):void{
			__buttonEnabled = _buttonEnabled;
			if (__buttonEnabled) {
				ButtonManager.addButton(this);
			}else {
				ButtonManager.removeButton(this);
			}
		}
		private var __group:String;
		public function get group():String {
			return __group;
		}
		public function set group(_group:String):void {
			if (__group) {
				ButtonManager.removeFromGroup(__group, this);
			}
			__group = _group;
			if (__group) {
				ButtonManager.addToGroup(__group, this);
			}
		}
		private var __select:Boolean;
		public function get select():Boolean{
			return __select;
		}
		public function set select(_select:Boolean):void{
			if (__select==_select) {
				return;
			}
			__select = _select;
			if (__group) {
				if (__select) {
					if (ButtonManager.selectItem(__group, this)) {
					}else {
						return;
					}
				}else {
					ButtonManager.unselectItem(__group, this);
				}
			}else {
				
			}
			ButtonManager.setButtonStyle(this);
		}
		internal function $release():void {
			if (href) {
				Common.getURL(href, hrefTarget);
			}else if(eEval) {
				ExternalInterface.call("eval", eEval);
			}
		}
		override protected function onAddedToStageHandler(_evt:Event):void {
			super.onAddedToStageHandler(_evt);
			buttonEnabled = true;
			if (area) {
				var _length:uint = area.numChildren;
				for (var _i:uint; _i < _length; _i++ ) {
					area.getChildAt(_i).visible = false;
				}
				mouseChildren = false;
				hitArea = area;
			}
		}
		override protected function onRemoveToStageHandler():void {
			eEval = null;
			href = null;
			hrefTarget = null;
			area = null;
			hitArea = null;
			buttonEnabled = false;
			group = null;
			rollOver = null;
			rollOut = null;
			press = null;
			release = null;
			super.onRemoveToStageHandler();
		}
	}
	
}