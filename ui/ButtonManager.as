package ui {
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class ButtonManager {
		private static const INITIALIZE:Boolean = initializeManager();
		private static const ROLL_OVER = "rollOver";
		private static const ROLL_OUT = "rollOut";
		private static const PRESS = "press";
		private static const RELEASE = "release";
		private static var buttonInDic:Dictionary;
		private static var buttonDownDic:Dictionary;
		private static function initializeManager():* {
			buttonInDic = new Dictionary();
			buttonDownDic = new Dictionary();
		}
		public static function addButton(_button:*, _buttonMode:Boolean = true):void {
			if (!_button.stage) {
				return;
			}
			_button.buttonMode = _buttonMode;
			_button.addEventListener(MouseEvent.ROLL_OVER, onButtonRollOverHandler);
			_button.stage.addEventListener(MouseEvent.MOUSE_DOWN, onButtonPressHandler);
			_button.stage.addEventListener(MouseEvent.MOUSE_UP, onButtonReleaseHandler);
			setButtonStyle(_button);
		}
		public static function removeButton(_button:*):void {
			_button.buttonMode = false;
			_button.removeEventListener(MouseEvent.ROLL_OVER, onButtonRollOverHandler);
			_button.removeEventListener(MouseEvent.ROLL_OUT, onButtonRollOutHandler);
			delete buttonInDic[_button];
			delete buttonDownDic[_button];
		}
		private static var buttonTarget:*;
		private static function onButtonRollOverHandler(_evt:MouseEvent):void {
			buttonTarget = _evt.currentTarget;
			if (buttonInDic[buttonTarget]) {
				return;
			}
			buttonInDic[buttonTarget] = buttonTarget;
			buttonTarget.addEventListener(MouseEvent.ROLL_OUT, onButtonRollOutHandler);
			//if (buttonDownDic[buttonTarget]) {
				
			//}else {
				buttonCallBack(buttonTarget, "$" + ROLL_OVER);
				buttonCallBack(buttonTarget, ROLL_OVER);
			//}
			setButtonStyle(buttonTarget);
		}
		private static function onButtonRollOutHandler(_evt:MouseEvent):void {
			buttonTarget = _evt.currentTarget;
			if (!buttonInDic[buttonTarget]) {
				return;
			}
			buttonInDic[buttonTarget] = null;
			buttonTarget.removeEventListener(MouseEvent.ROLL_OUT, onButtonRollOutHandler);
			//if (buttonDownDic[buttonTarget]) {
				
			//}else {
				buttonCallBack(buttonTarget, "$" + ROLL_OUT);
				buttonCallBack(buttonTarget, ROLL_OUT);
			//}
			setButtonStyle(buttonTarget);
		}
		private static function onButtonPressHandler(_evt:MouseEvent):void {
			//_evt.target;
			for each(buttonTarget in buttonInDic) {
				if (!buttonTarget || buttonDownDic[buttonTarget]) {
					continue;
				}
				buttonDownDic[buttonTarget] = buttonTarget;
				buttonCallBack(buttonTarget, "$" + PRESS);
				buttonCallBack(buttonTarget, PRESS);
				setButtonStyle(buttonTarget);
			}
		}
		private static function onButtonReleaseHandler(_evt:MouseEvent):void {
			//_evt.target;
			for each(buttonTarget in buttonDownDic) {
				if (!buttonDownDic[buttonTarget]) {
					continue;
				}
				buttonDownDic[buttonTarget] = null;
				buttonCallBack(buttonTarget, "$" + RELEASE);
				buttonCallBack(buttonTarget, RELEASE);
				setButtonStyle(buttonTarget);
			}
		}
		private static function buttonCallBack(_button:*, _method:*, ...args):void {
			try {
				if (_method is String && _button[_method] != null) {
					_method = _button[_method];
				}
			}catch (_ero:*) {
				
			}
			if (_method is Function) {
				_method.apply(ButtonManager, args);
			}
		}
		private static var frameTo:uint;
		public static function setButtonStyle(_button:*):void {
			if (_button is MovieClip) {
				if (_button.totalFrames > 8) {
					setButtonPlay(_button);
				}else {
					if (buttonInDic[_button]) {
						frameTo = buttonDownDic[_button]?4:2;
					}else {
						frameTo = buttonDownDic[_button]?3:1;
					}
					frameTo += _button.select?4:0;
					_button.gotoAndStop(frameTo);
				}
			}
			if (_button.hasOwnProperty("aniClip")) {
				setButtonPlay(_button.aniClip);
			}
		}
		private static function onEnterFrameHandler(_evt:Event):void {
			buttonTarget = _evt.target;
			if (!(buttonTarget is MovieClip) || buttonTarget.totalFrames < 2) {
				buttonTarget.removeEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
				return;
			}
			if (buttonInDic[buttonTarget] || buttonDownDic[buttonTarget] || buttonTarget.select) {
				if (buttonTarget.currentFrame == buttonTarget.totalFrames) {
					buttonTarget.removeEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
				} else {
					buttonTarget.nextFrame();
				}
			}else {
				if (buttonTarget.currentFrame == 1) {
					buttonTarget.removeEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
				} else {
					buttonTarget.prevFrame();
				}
			}
		}
		public static function setButtonPlay(_button:*):void {
			if (! _button) {
				return;
			}
			/*if (_clip != this) {
				_clip.buttonMode = false;
			}*/
			_button.addEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
		}
		//
		private static var groupItemDic:Object = { };
		private static var groupSelectDic:Object = { };
		private static var groupParamsDic:Object = { };
		private static const KEY_LIMIT:String = "limit";
		private static const KEY_RADIO_UNSELECT_FUN:String = "radioUnselectFun";
		public static function addToGroup(_groupName:String, _item:*):void {
			if (!groupItemDic[_groupName]) {
				groupItemDic[_groupName] = new Array();
				groupSelectDic[_groupName] = new Array();
				setLimit(_groupName, 0);
			}
			/*if (_n != 0 && obGroup[_s+"_limit"]<_n) {
				obGroup[_s+"_limit"] = _n;
			}*/
			groupItemDic[_groupName].push(_item);
		}
		public static function removeFromGroup(_groupName:String, _item:*):void {
			Common.removeFromArray(groupItemDic[_groupName], _item);
			Common.removeFromArray(groupSelectDic[_groupName], _item);
		}
		public static function selectItem(_groupName:String, _item:*):Boolean {
			var _limit:uint = getLimit(_groupName);
			var _groupSelect:Array = groupSelectDic[_groupName];
			if (_limit == 0) {
				if (_groupSelect[0]) {
					getRadioUnselectFun(_groupName)(_groupSelect[0]);
					unselectItem(_groupName, _groupSelect[0]);
				}
				_groupSelect.push(_item);
				return true;
			}else if (_limit > _groupSelect.length) {
				_groupSelect.push(_item);
				return true;
			} else {
				return false;
			}
		}
		public static function unselectItem(_groupName:String, _item:*):void {
			Common.removeFromArray(groupSelectDic[_groupName], _item);
		}
		public static function getRadioUnselectFun(_groupName:String):Function {
			return groupParamsDic[_groupName + KEY_RADIO_UNSELECT_FUN];
		}
		public static function setRadioUnselectFun(_groupName:String, _fun:Function):void {
			groupParamsDic[_groupName + KEY_RADIO_UNSELECT_FUN] = _fun;
		}
		public static function getLimit(_groupName:String):uint {
			return int(groupParamsDic[_groupName + KEY_LIMIT]);
		}
		public static function setLimit(_groupName:String, _limit:uint, _auto:Boolean = true):void {
			if (_auto?(getLimit(_groupName)< _limit):true) {
				groupParamsDic[_groupName + KEY_LIMIT] = _limit;
			}else {
				
			}
			if (_limit==0) {
				setRadioUnselectFun(_groupName,unSelectItemFun);
			}
		}
		private static function unSelectItemFun(_item:*):void {
			_item.select = false;
		}
	}
}