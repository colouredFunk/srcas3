package ui {
	import flash.events.Event;
	import flash.external.ExternalInterface;
	
	import akdcl.net.gotoURL;

	import ui.UIMovieClip;
	import ui.manager.ButtonManager;

	/**
	 * ...
	 * @author Akdcl
	 */
	public class Btn extends UIMovieClip {
		private static const bM:ButtonManager = ButtonManager.getInstance();
		public var rollOver:Function;
		public var rollOut:Function;
		public var press:Function;
		public var release:Function;
		public var select:Function;

		public var area:*;
		public var href:*;
		public var hrefTarget:String = "_blank";
		public var eEval:String;
		public var isDown:Boolean;

		public function set hrefXML(_hrefXML:XML):void {
			href = _hrefXML;
		}
		
		private var __group:String;
		public function get group():String {
			return __group;
		}
		public function set group(_group:String):void {
			if (__group && _group == __group){
				return;
			}
			if (__group){
				bM.removeFromGroup(__group, this);
			}
			__group = _group;
			if (__group){
				bM.addToGroup(__group, this);
			}
		}
		
		private var __selected:Boolean;
		public function get selected():Boolean {
			return __selected;
		}
		public function set selected(_selected:Boolean):void {
			if (__selected == _selected){
				return;
			}
			__selected = _selected;
			if (__group){
				if (__selected){
					if (bM.selectItem(__group, this)){
					} else {
						return;
					}
				} else {
					bM.unselectItem(__group, this);
				}
			}
			bM.setButtonStyle(this);
			if (select != null) {
				select();
			}
		}
		override public function set enabled(_enabled:Boolean):void {
			super.enabled = _enabled;
			if (_enabled) {
				bM.addButton(this);
			}else {
				bM.removeButton(this);
			}
		}

		override protected function init():void {
			super.init();
			enabled = true;
			if (area){
				var _length:uint = area.numChildren;
				for (var _i:uint; _i < _length; _i++){
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
		
		public function $press():void {
			isDown = true;
		}
		
		public function $release():void {
			isDown = false;
			if (href) {
				gotoURL(href, hrefTarget);
			}else if (eEval && ExternalInterface.available) {
				ExternalInterface.call("eval", eEval);
			}
		}
	}

}