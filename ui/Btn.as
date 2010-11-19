package ui{
	import flash.events.Event;
	import flash.external.ExternalInterface;
	import flash.system.ApplicationDomain;
	
	import ui.UIMovieClip;
	import ui.manager.ButtonManager;
	
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
			hrefTarget = String(_hrefXML.@target) || hrefTarget;
			eEval = String(_hrefXML.@js);
		}
		override public function set enabled(_enabled:Boolean):void{
			super.enabled = _enabled;
			if (_enabled) {
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
			if (__group && _group == __group) {
				return;
			}
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
			}
			ButtonManager.setButtonStyle(this);
		}
		public function $release():void {
			if (href) {
				if (ApplicationDomain.currentDomain.hasDefinition("Common")) {
					ApplicationDomain.currentDomain.getDefinition("Common").getURL(href, hrefTarget);
				}
			}else if(eEval) {
				ExternalInterface.call("eval", eEval);
			}
		}
		override protected function init():void {
			super.init();
			enabled = true;
			if (area) {
				var _length:uint = area.numChildren;
				for (var _i:uint; _i < _length; _i++ ) {
					area.getChildAt(_i).visible = false;
				}
				mouseChildren = false;
				hitArea = area;
			}
			stop();
		}
		override protected function onRemoveToStageHandler():void {
			rollOver = null;
			rollOut = null;
			press = null;
			release = null;
			
			eEval = null;
			href = null;
			hrefTarget = null;
			area = null;
			group = null;
			enabled = false;
			super.onRemoveToStageHandler();
		}
	}
	
}