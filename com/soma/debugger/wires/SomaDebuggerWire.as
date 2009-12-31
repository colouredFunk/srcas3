package com.soma.debugger.wires {
	import com.soma.core.interfaces.IWire;
	import com.soma.core.wire.Wire;
	import com.soma.debugger.commands.SomaDebuggerCommand;
	import com.soma.debugger.events.SomaDebuggerEvent;
	import com.soma.debugger.views.SomaDebuggerView;
	import com.soma.debugger.vo.SomaDebuggerVO;

	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.utils.Dictionary;

	/**
	 * <b>Author:</b> Romuald Quantin - <a href="http://www.soundstep.com/" target="_blank">www.soundstep.com</a><br />* <b>Class version:</b> 1.0<br />
	 * <b>Actionscript version:</b> 3.0<br />
	 * <b>Copyright:</b> 
	 * <br />
	 * <b>Date:</b> Sep 18, 2009<br />
	 * <b>Usage:</b>
	 * @example
	 * <listing version="3.0"></listing>
	 */
	
	public class SomaDebuggerWire extends Wire implements IWire {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		private var _debuggerName:String;
		private var _keyArray:Array;

		//------------------------------------
		// public properties
		//------------------------------------
		
		private var _pluginVO:SomaDebuggerVO;
		private var _enableLog:Boolean;
		private var _enableTrace:Boolean;
		private var _view:SomaDebuggerView;
		private var _watchers:Dictionary;
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		public function SomaDebuggerWire(debuggerName:String, pluginVO:SomaDebuggerVO) {
			super(debuggerName + "Wire");
			_debuggerName = debuggerName;
			_pluginVO = pluginVO;
			_enableLog = pluginVO.enableLog;
			_enableTrace = pluginVO.enableTrace;
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		override protected function initialize():void {
			if (stage == null) {
				trace("Error in ", this, " The stage is null.");
				return;
			}
			_watchers = new Dictionary();
			_keyArray = [];
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyboardHandler);
			// watchers
			for (var i:int=0; i<_pluginVO.commands.length; i++) {
				addWatcher(_pluginVO.commands[i]);
			}
			// commands
			if (!hasCommand(SomaDebuggerEvent.SHOW_DEBUGGER)) addCommand(SomaDebuggerEvent.SHOW_DEBUGGER, SomaDebuggerCommand);
			if (!hasCommand(SomaDebuggerEvent.HIDE_DEBUGGER)) addCommand(SomaDebuggerEvent.HIDE_DEBUGGER, SomaDebuggerCommand);
			if (!hasCommand(SomaDebuggerEvent.MOVE_TO_TOP)) addCommand(SomaDebuggerEvent.MOVE_TO_TOP, SomaDebuggerCommand);
			if (!hasCommand(SomaDebuggerEvent.PRINT)) addCommand(SomaDebuggerEvent.PRINT, SomaDebuggerCommand);
			if (!hasCommand(SomaDebuggerEvent.CLEAR)) addCommand(SomaDebuggerEvent.CLEAR, SomaDebuggerCommand);
			// view
			_view = addView(_debuggerName + "View", new SomaDebuggerView(_debuggerName)) as SomaDebuggerView;
			enableLog = _enableLog;
			enableTrace = _enableTrace;
			stage.addChild(debugger);
		}
		
		private function eventsHandler(event:Event):void {
			debugger.printCommand(event.type, event);
		}

		private function keyboardHandler(event:KeyboardEvent):void {
			_keyArray.push(event.keyCode);
			if (_keyArray.length > 5) _keyArray.shift();
			if (_keyArray.join(",") == "68,69,66,85,71") show();
		}
		
		override protected function dispose():void {
			// dispose objects, graphics and events listeners
			try {
				if (hasCommand(SomaDebuggerEvent.SHOW_DEBUGGER)) removeCommand(SomaDebuggerEvent.SHOW_DEBUGGER);
				if (hasCommand(SomaDebuggerEvent.HIDE_DEBUGGER)) removeCommand(SomaDebuggerEvent.HIDE_DEBUGGER);
				if (hasCommand(SomaDebuggerEvent.MOVE_TO_TOP)) removeCommand(SomaDebuggerEvent.MOVE_TO_TOP);
				if (hasCommand(SomaDebuggerEvent.PRINT)) removeCommand(SomaDebuggerEvent.PRINT);
				if (hasCommand(SomaDebuggerEvent.CLEAR)) removeCommand(SomaDebuggerEvent.CLEAR);
				removeAllWatchers();
				removeView(_debuggerName + "View");
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyboardHandler);
				stage.removeChild(debugger);
				_watchers = null;
				_keyArray = null;
				_view = null;
			} catch(e:Error) {
				trace("Error in", this, "(dispose method):", e.message);
			}
		}
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		public function get debugger():SomaDebuggerView {
			return _view as SomaDebuggerView;
		}
		
		public function get debuggerName():String {
			return _debuggerName;
		}
		
		public function print(value:Object):void {
			debugger.print(value);
		}

		public function moveToTop():void {
			var parent:DisplayObjectContainer = debugger.parent;
			if (parent != null) parent.setChildIndex(debugger, parent.numChildren- 1);
		}
		
		public function clear():void {
			debugger.clear();
		}
		
		public function addWatcher(commandName:String):void {
			_watchers[commandName] = commandName;
			addEventListener(commandName, eventsHandler);
		}

		public function removeWatcher(commandName:String):void {
			delete _watchers[commandName];
			removeEventListener(commandName, eventsHandler);
		}
		
		public function removeAllWatchers():void {
			for each (var watcher:String in _watchers) {
				delete _watchers[watcher];
				removeEventListener(watcher, eventsHandler);
			}
		}

		public function get enableLog():Boolean {
			return _enableLog;
		}
		
		public function set enableLog(value:Boolean):void {
			_enableLog = value;
			debugger.enableLog = _enableLog;
		}

		public function get enableTrace():Boolean {
			return _enableTrace;
		}
		
		public function set enableTrace(value:Boolean):void {
			_enableTrace = value;
			debugger.enableTrace = _enableTrace;
		}
		
		public function show():void {
			debugger.visible = true;
		}
		
		public function hide():void {
			debugger.visible = false;
		}
		
	}
}