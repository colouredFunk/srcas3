package ui.manager {
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	final public class ButtonManager {
		public static var stage:Stage;
		private static const INITIALIZE:Boolean = initializeManager();
		private static const ROLL_OVER = "rollOver";
		private static const ROLL_OUT = "rollOut";
		private static const PRESS = "press";
		private static const RELEASE = "release";
		private static const MOUSE_WHEEL = "wheel";
		private static var buttonDic:Dictionary;
		private static var buttonInDic:Dictionary;
		private static var buttonDownDic:Dictionary;
		private static var tempSprite:Sprite;
		private static function initializeManager():* {
			buttonDic = new Dictionary();
			buttonInDic = new Dictionary();
			buttonDownDic = new Dictionary();
			tempSprite = new Sprite();
			tempSprite.addEventListener(Event.ENTER_FRAME, checkStage);
		}
		private static function checkStage(_evt:Event):void {
			for each(var _button:* in buttonDic) {
				if (_button.stage) {
					stage = _button.stage;
					stage.addEventListener(MouseEvent.MOUSE_DOWN, onStageMouseDownHandler);
					stage.addEventListener(MouseEvent.MOUSE_UP, onStageMouseUpHandler);
					stage.addEventListener(MouseEvent.MOUSE_WHEEL, onStageMouseWheelHandler);
					tempSprite.removeEventListener(Event.ENTER_FRAME, checkStage);
					tempSprite = null;
					return;
				}
			}
		}
		public static function addButton(_button:*, _buttonMode:Boolean = true):void {
			_button.buttonMode = _buttonMode;
			_button.addEventListener(MouseEvent.ROLL_OVER, onButtonRollOverHandler);
			buttonDic[_button] = _button;
			setButtonStyle(_button);
		}
		public static function removeButton(_button:*):void {
			_button.buttonMode = false;
			_button.removeEventListener(MouseEvent.ROLL_OVER, onButtonRollOverHandler);
			_button.removeEventListener(MouseEvent.ROLL_OUT, onButtonRollOutHandler);
			delete buttonDic[_button];
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
		private static function onStageMouseDownHandler(_evt:MouseEvent):void {
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
		private static function onStageMouseUpHandler(_evt:MouseEvent):void {
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
		private static function onStageMouseWheelHandler(_evt:MouseEvent):void {
			for each(buttonTarget in buttonInDic) {
				if (!buttonTarget) {
					continue;
				}
				buttonCallBack(buttonTarget, "$" + MOUSE_WHEEL, _evt.delta);
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
				_method.apply(_button, args);
			}
		}
		private static var frameTo:uint;
		public static function setButtonStyle(_button:*):void {
			var _isActive:Boolean = buttonInDic[_button] || buttonDownDic[_button] || (_button.hasOwnProperty("select") && _button.select);
			if (_button is MovieClip) {
				if (_button.totalFrames > 8) {
					setButtonClipPlay(_button, _isActive);
				}else {
					if (buttonInDic[_button]) {
						frameTo = buttonDownDic[_button]?4:2;
					}else {
						frameTo = buttonDownDic[_button]?3:1;
					}
					frameTo += _button.select?4:0;
					if (_button.currentFrame == frameTo) {
						_button.stop();
					}else {
						_button.gotoAndStop(frameTo);
					}
				}
			}
			if (_button.hasOwnProperty("aniClip")) {
				setButtonClipPlay(_button.aniClip, _isActive);
			}
			buttonCallBack(_button, "$setStyle", _isActive);
		}
		public static function setButtonClipPlay(_buttonClip:*, _nextFrame:Boolean):void {
			if (! _buttonClip) {
				return;
			}
			/*if (_clip != this) {
				_clip.buttonMode = false;
			}*/
			if (_nextFrame) {
				_buttonClip.removeEventListener(Event.ENTER_FRAME, onEnterFramePrevHandler);
				_buttonClip.addEventListener(Event.ENTER_FRAME, onEnterFrameNextHandler);
			}else {
				_buttonClip.removeEventListener(Event.ENTER_FRAME, onEnterFrameNextHandler);
				_buttonClip.addEventListener(Event.ENTER_FRAME, onEnterFramePrevHandler);
			}
		}
		private static function onEnterFrameNextHandler(_evt:Event):void {
			var _target:* = _evt.target;
			if (!(_target is MovieClip) || _target.totalFrames < 2) {
				_target.removeEventListener(Event.ENTER_FRAME, onEnterFrameNextHandler);
				return;
			}
			if (_target.currentFrame == _target.totalFrames) {
				_target.removeEventListener(Event.ENTER_FRAME, onEnterFrameNextHandler);
			} else {
				_target.nextFrame();
			}
		}
		private static function onEnterFramePrevHandler(_evt:Event):void {
			var _target:* = _evt.target;
			if (!(_target is MovieClip) || _target.totalFrames < 2) {
				_target.removeEventListener(Event.ENTER_FRAME, onEnterFramePrevHandler);
				return;
			}
			if (_target.currentFrame == 1) {
				_target.stop();
				_target.removeEventListener(Event.ENTER_FRAME, onEnterFramePrevHandler);
			} else {
				_target.prevFrame();
			}
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
			removeFromArray(groupItemDic[_groupName], _item);
			removeFromArray(groupSelectDic[_groupName], _item);
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
			removeFromArray(groupSelectDic[_groupName], _item);
		}
		public static function unselectGroup(_groupName:String):void {
			var _groupSelect:Array = groupSelectDic[_groupName];
			for each(var _select:* in _groupSelect) {
				getRadioUnselectFun(_groupName)(_select);
				unselectItem(_groupName, _select);
			}
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
		//
		public static function removeFromArray(_a:Array,_ai:*):* {
			var _i:int=_a.indexOf(_ai);
			if (_i>=0) {
				return _a.splice(_i,1);
			}
		}
	}
}