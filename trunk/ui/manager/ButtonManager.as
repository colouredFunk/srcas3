package ui.manager {
	import akdcl.events.InteractionEvent;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import flash.utils.setInterval;
	import flash.utils.clearInterval;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	final public class ButtonManager {
		private static var instance:ButtonManager;

		public static function getInstance():ButtonManager {
			if (instance){
			} else {
				instance = new ButtonManager();
			}
			return instance;
		}

		public function ButtonManager(){
			if (instance){
				throw new Error("ERROR:ButtonManager Singleton already constructed!");
			}
			instance = this;
			buttonDic = new Dictionary();
			buttonInDic = new Dictionary();
			buttonDownDic = new Dictionary();
			
			intervalID = setInterval(checkStage, 300);
		}
		private function checkStage():void {
			for each(var _button:* in buttonDic) {
				if (_button.stage) {
					stage = _button.stage;
					stage.addEventListener(MouseEvent.MOUSE_UP, onStageMouseUpHandler);
					if (mobileMode) {
						stage.addEventListener(MouseEvent.MOUSE_DOWN, onStageMouseDownHandler);
					}
					clearInterval(intervalID);
					break;
				}
			}
		}
		private static const ROLL_OVER:String = "rollOver";
		private static const ROLL_OUT:String = "rollOut";
		private static const PRESS:String = "press";
		private static const RELEASE:String = "release";
		private static const RELEASE_OUTSIDE:String = "releaseOutside";
		private static const DRAG_OVER:String = "dragOver";
		private static const DRAG_OUT:String = "dragOut";
		
		public static var mobileMode:Boolean;
		
		private var stage:Stage;
		private var buttonDic:Dictionary;
		private var buttonInDic:Dictionary;
		private var buttonDownDic:Dictionary;
		
		private var intervalID:uint;
		private var buttonTarget:*;
		public var startX:int;
		public var startY:int;
		public var lastX:int;
		public var lastY:int;
		public var speedX:int;
		public var speedY:int;
		
		public function addButton(_button:*):void {
			if (_button is MovieClip) {
				_button.mouseChildren = false;
			}
			_button.addEventListener(MouseEvent.ROLL_OVER, onRollOverHandler);
			_button.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDownHandler);
			buttonDic[_button] = _button;
			setButtonStyle(_button);
		}
		public function removeButton(_button:*):void {
			_button.removeEventListener(MouseEvent.ROLL_OVER, onRollOverHandler);
			_button.removeEventListener(MouseEvent.ROLL_OUT, onRollOutHandler);
			_button.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDownHandler);
			_button.removeEventListener(MouseEvent.MOUSE_UP, onMouseUpHandler);
			_button.removeEventListener(Event.ENTER_FRAME, onMouseMoveHandler);
			delete buttonDic[_button];
			delete buttonInDic[_button];
			delete buttonDownDic[_button];
		}
		
		private function onStageMouseUpHandler(_e:Event):void {
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onStageMouseMoveHandler);
			for each(buttonTarget in buttonDownDic) {
				buttonTarget.removeEventListener(MouseEvent.MOUSE_UP, onMouseUpHandler);
				buttonTarget.removeEventListener(Event.ENTER_FRAME, onMouseMoveHandler);
				delete buttonDownDic[buttonTarget];
				if (buttonTarget.hasEventListener(InteractionEvent.RELEASE_OUTSIDE)) {
					buttonTarget.dispatchEvent(new InteractionEvent(InteractionEvent.RELEASE_OUTSIDE));
				}else if (buttonTarget.hasEventListener(InteractionEvent.RELEASE)) {
					buttonTarget.dispatchEvent(new InteractionEvent(InteractionEvent.RELEASE));
				}
				setButtonStyle(buttonTarget);
			}
			if (_e) {
				buttonTarget = _e.target;
				if (buttonInDic[buttonTarget]) {
					//trace("releaseInOtherButton");
				}
			}
		}
		private function onStageMouseDownHandler(_e:Event):void {
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onStageMouseMoveHandler);
		}
		private function onStageMouseMoveHandler(_e:MouseEvent):void {
			if (_e.stageX > stage.stageWidth || _e.stageX < 0 || _e.stageY > stage.stageHeight || _e.stageY < 0) {
				onStageMouseUpHandler(null);
			}
		}
		
		
		private function onRollOverHandler(_e:MouseEvent):void {
			buttonTarget = _e.currentTarget;
			if (buttonInDic[buttonTarget]) {
				
			}else {
				buttonInDic[buttonTarget] = buttonTarget;
				buttonTarget.addEventListener(MouseEvent.ROLL_OUT, onRollOutHandler);
				if (_e.buttonDown) {
					if (buttonTarget.hasEventListener(InteractionEvent.DRAG_OVER)) {
						buttonTarget.dispatchEvent(new InteractionEvent(InteractionEvent.DRAG_OVER));
					}
				}else if (buttonTarget.hasEventListener(InteractionEvent.ROLL_OVER)) {
					buttonTarget.dispatchEvent(new InteractionEvent(InteractionEvent.ROLL_OVER));
				}
				
				buttonCallBack(buttonTarget, ROLL_OVER);
				
				setButtonStyle(buttonTarget);
			}
		}
		private function onRollOutHandler(_e:MouseEvent):void {
			buttonTarget = _e.currentTarget;
			if (buttonInDic[buttonTarget]) {
				delete buttonInDic[buttonTarget];
				buttonTarget.removeEventListener(MouseEvent.ROLL_OUT, onRollOutHandler);
				//buttonTarget.removeEventListener(Event.ENTER_FRAME, onMouseMoveHandler);
				if (_e.buttonDown) {
					if (buttonTarget.hasEventListener(InteractionEvent.DRAG_OUT)) {
						buttonTarget.dispatchEvent(new InteractionEvent(InteractionEvent.DRAG_OUT));
					}
				}else if (buttonTarget.hasEventListener(InteractionEvent.ROLL_OUT)) {
					buttonTarget.dispatchEvent(new InteractionEvent(InteractionEvent.ROLL_OUT));
				}

				buttonCallBack(buttonTarget, ROLL_OUT);
				
				setButtonStyle(buttonTarget);
			}
		}
		private function onMouseDownHandler(_e:MouseEvent):void {
			buttonTarget = _e.currentTarget;
			if (buttonDownDic[buttonTarget]) {
				
			}else {
				buttonDownDic[buttonTarget] = buttonTarget;
				buttonTarget.addEventListener(MouseEvent.MOUSE_UP, onMouseUpHandler);
				if (buttonTarget.hasEventListener(InteractionEvent.DRAG_MOVE)) {
					buttonTarget.addEventListener(Event.ENTER_FRAME, onMouseMoveHandler);
					lastX = startX = stage.mouseX;
					lastY = startY = stage.mouseY;
				}
				
				if (buttonTarget.hasEventListener(InteractionEvent.PRESS)) {
					buttonTarget.dispatchEvent(new InteractionEvent(InteractionEvent.PRESS));
				}
				
				buttonCallBack(buttonTarget, PRESS);
				
				setButtonStyle(buttonTarget);
			}
		}
		private function onMouseUpHandler(_e:MouseEvent):void {
			buttonTarget = _e.currentTarget;
			if (buttonDownDic[buttonTarget]) {
				delete buttonDownDic[buttonTarget];
				buttonTarget.removeEventListener(MouseEvent.MOUSE_UP, onMouseUpHandler);
				buttonTarget.removeEventListener(Event.ENTER_FRAME, onMouseMoveHandler);
				
				if (buttonTarget.hasEventListener(InteractionEvent.RELEASE)) {
					buttonTarget.dispatchEvent(new InteractionEvent(InteractionEvent.RELEASE));
				}

				buttonCallBack(buttonTarget, RELEASE);
				
				setButtonStyle(buttonTarget);
			}
		}
		private function onMouseMoveHandler(_e:Event):void {
			speedX = stage.mouseX - lastX;
			speedY = stage.mouseY - lastY;
			lastX = stage.mouseX;
			lastY = stage.mouseY;
			if (speedX != 0 || speedY != 0) {
				var _iEvt:InteractionEvent = new InteractionEvent(InteractionEvent.DRAG_MOVE);
				_e.currentTarget.dispatchEvent(_iEvt);
			}
		}
		private function buttonCallBack(_button:*, _method:*, ...args):void {
			try {
				if (_method is String && (_method in _button)) {
					_method = _button[_method];
				}
			}catch (_ero:*) {
				
			}
			if (_method is Function) {
				if (args && args.length > 0) {
					_method.apply(_button, args);
				}else {
					switch(_method.length) {
						case 1:
							_method.apply(_button,[_button]);
							break;
						case 0:
						default:
							_method.call(_button);
							break;
					}
				}
				
			}
		}
		
		private var frameTo:uint;
		public function setButtonStyle(_button:*):void {
			var _isDown:Boolean = buttonDownDic[_button]!=null;
			var _isIn:Boolean = buttonInDic[_button] != null;
			var _isSelected:Boolean = _button.hasOwnProperty("selected") && _button.selected;
			var _isActive:Boolean = _isDown || _isIn || _isSelected;
			
			if (_button is MovieClip) {
				if (_button.totalFrames > 8) {
					setButtonClipPlay(_button, _isActive);
				}else {
					if (_isIn) {
						frameTo = _isDown?4:2;
					}else {
						frameTo = _isDown?3:1;
					}
					frameTo += _isSelected?4:0;
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
			if (_button.hasEventListener(InteractionEvent.UPDATE_STYLE)) {
				_button.dispatchEvent(new InteractionEvent(InteractionEvent.UPDATE_STYLE, _isActive));
			}
		}
		public function setButtonClipPlay(_buttonClip:*, _nextFrame:Boolean):void {
			if (! _buttonClip) {
				return;
			}
			if (_nextFrame) {
				_buttonClip.removeEventListener(Event.ENTER_FRAME, onEnterFramePrevHandler);
				_buttonClip.addEventListener(Event.ENTER_FRAME, onEnterFrameNextHandler);
			}else {
				_buttonClip.removeEventListener(Event.ENTER_FRAME, onEnterFrameNextHandler);
				_buttonClip.addEventListener(Event.ENTER_FRAME, onEnterFramePrevHandler);
			}
		}
		private function onEnterFrameNextHandler(_e:Event):void {
			var _target:* = _e.target;
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
		private function onEnterFramePrevHandler(_e:Event):void {
			var _target:* = _e.target;
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
		private var groupItemDic:Object = { };
		private var groupSelectedDic:Object = { };
		private var groupParamsDic:Object = { };
		private static const KEY_LIMIT:String = "limit";
		private static const KEY_RADIO_UNSELECT_FUN:String = "radioUnselectFun";
		public function addToGroup(_groupName:String, _item:*):void {
			if (!groupItemDic[_groupName]) {
				groupItemDic[_groupName] = new Array();
				groupSelectedDic[_groupName] = new Array();
				setLimit(_groupName, 0);
			}
			/*if (_n != 0 && obGroup[_s+"_limit"]<_n) {
				obGroup[_s+"_limit"] = _n;
			}*/
			groupItemDic[_groupName].push(_item);
		}
		public function removeFromGroup(_groupName:String, _item:*):void {
			removeFromArray(groupItemDic[_groupName], _item);
			removeFromArray(groupSelectedDic[_groupName], _item);
		}
		public function selectItem(_groupName:String, _item:*):Boolean {
			var _limit:uint = getLimit(_groupName);
			var _groupSelected:Array = groupSelectedDic[_groupName];
			if (_limit == 0) {
				if (_groupSelected[0]) {
					getRadioUnselectFun(_groupName)(_groupSelected[0]);
					unselectItem(_groupName, _groupSelected[0]);
				}
				_groupSelected.push(_item);
				return true;
			}else if (_limit > _groupSelected.length) {
				_groupSelected.push(_item);
				return true;
			} else {
				return false;
			}
		}
		public function unselectItem(_groupName:String, _item:*):void {
			removeFromArray(groupSelectedDic[_groupName], _item);
		}
		public function unselectGroup(_groupName:String):void {
			var _groupSelected:Array = groupSelectedDic[_groupName];
			for each(var _selected:* in _groupSelected) {
				getRadioUnselectFun(_groupName)(_selected);
				unselectItem(_groupName, _selected);
			}
		}
		public function getRadioUnselectFun(_groupName:String):Function {
			return groupParamsDic[_groupName + KEY_RADIO_UNSELECT_FUN];
		}
		public function setRadioUnselectFun(_groupName:String, _fun:Function):void {
			groupParamsDic[_groupName + KEY_RADIO_UNSELECT_FUN] = _fun;
		}
		public function getLimit(_groupName:String):uint {
			return int(groupParamsDic[_groupName + KEY_LIMIT]);
		}
		public function setLimit(_groupName:String, _limit:uint, _auto:Boolean = true):void {
			if (_auto?(getLimit(_groupName)< _limit):true) {
				groupParamsDic[_groupName + KEY_LIMIT] = _limit;
			}else {
				
			}
			if (_limit==0) {
				setRadioUnselectFun(_groupName,unSelectItemFun);
			}
		}
		private function unSelectItemFun(_item:*):void {
			_item.selected = false;
		}
		private function removeFromArray(_a:Array,_ai:*):* {
			var _i:int=_a.indexOf(_ai);
			if (_i>=0) {
				return _a.splice(_i,1);
			}
		}
	}
}