package com.soma.debugger.views {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.text.TextField;

	/**
	 * <b>Author:</b> Romuald Quantin - <a href="http://www.soundstep.com/" target="_blank">www.soundstep.com</a><br />* <b>Class version:</b> 1.0<br />
	 * <b>Actionscript version:</b> 3.0<br />
	 * <b>Copyright:</b> 
	 * <br />
	 * <b>Date:</b> Sep 21, 2009<br />
	 * <b>Usage:</b>
	 * @example
	 * <listing version="3.0"></listing>
	 */
	
	public class SomaDebuggerScrollbar extends Sprite {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		private var _textfield:TextField;
		
		private var _track:Sprite;
		private var _grip:Sprite;
		private var _dragBounds:Rectangle;
		private var _isDragging:Boolean;
		
		//------------------------------------
		// public properties
		//------------------------------------
		
		

		//------------------------------------
		// constructor
		//------------------------------------
		
		public function SomaDebuggerScrollbar(textfield:TextField) {
			_textfield = textfield;
			addEventListener(Event.ADDED_TO_STAGE, added, false, 0, true);
		}

		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		private function added(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, added, false);
			initialize();
		}
		
		private function initialize():void {
			_isDragging = false;
			createTrack();
			createScrollbar();
			updateLayout();
		}
		
		private function createTrack():void {
			_track = addChild(new Sprite) as Sprite;
			_track.graphics.beginFill(0x9B9B9B); 
			_track.graphics.drawRect(0, 0, 5, 130);
			_track.graphics.endFill();
			addChild(_track);
		}
		
		private function createScrollbar():void {
			_grip = new Sprite();
			_grip.graphics.beginFill(0xFF0000, 0); 
			_grip.graphics.drawRect(0, 0, 3, 30);
			_grip.graphics.beginFill(0x363636); 
			_grip.graphics.drawRect(3, 0, 5, 30);
			_grip.graphics.beginFill(0xFF0000, 0); 
			_grip.graphics.drawRect(8, 0, 3, 30);
			_grip.graphics.endFill();
			addChild(_grip);
			_grip.buttonMode = true;
			_grip.mouseChildren = false;
			_grip.addEventListener(MouseEvent.MOUSE_DOWN, gripMouseDownHandler);
		}
		
		private function updateLayout():void {
			x = _textfield.x + _textfield.width;
			y = _textfield.y;
			_track.height = _textfield.height;
			_grip.x = _track.x - 3;
			_grip.y = _track.y;
			_dragBounds = new Rectangle(_grip.x, _grip.y, 0, _track.height - _grip.height);
		}

		private function gripMouseDownHandler(e:MouseEvent):void {
			stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			stage.addEventListener(Event.MOUSE_LEAVE, stageLeavehandler);
			addEventListener(Event.ENTER_FRAME, moveHandler);
			_isDragging = true;
			_grip.startDrag(false, _dragBounds);
		}
		
		private function mouseUpHandler(e:MouseEvent):void {
			stopDragAndClean();
		}

		private function stageLeavehandler(e:Event):void {
			stopDragAndClean();
		}

		private function stopDragAndClean():void {
			_isDragging = false;
			_grip.stopDrag();
			stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			stage.removeEventListener(Event.MOUSE_LEAVE, stageLeavehandler);
			removeEventListener(Event.ENTER_FRAME, moveHandler);
		}
		
		private function moveHandler(e:Event):void {
			_textfield.scrollV = _textfield.maxScrollV * _grip.y / 100;
		}
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		public function get isDragging():Boolean {
			return _isDragging;
		}
		
		public function dispose() : void {
			// dispose objects, graphics and events listeners
			try {
				_grip.removeEventListener(MouseEvent.MOUSE_DOWN, gripMouseDownHandler);
				while (numChildren > 0) removeChildAt(0);
				_track = null;
				_grip = null;
				
			} catch(e:Error) {
				trace("Error in", this, "(dispose method):", e.message);
			}
		}
		
	}
}