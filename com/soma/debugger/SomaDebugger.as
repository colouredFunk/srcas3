package com.soma.debugger {
	import com.soma.core.interfaces.ISoma;
	import com.soma.core.interfaces.ISomaPlugin;
	import com.soma.core.interfaces.ISomaPluginVO;
	import com.soma.debugger.views.SomaDebuggerView;
	import com.soma.debugger.vo.SomaDebuggerVO;
	import com.soma.debugger.wires.SomaDebuggerWire;

	import flash.events.Event;

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
	
	public class SomaDebugger implements ISomaPlugin {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		private var _instance:ISoma;
		private var _wire:SomaDebuggerWire;
		private var _view:SomaDebuggerView;
		private var _name:String;

		//------------------------------------
		// public properties
		//------------------------------------
		
		public var NAME:String = "Soma::SomaDebugger";
		public static const NAME_DEFAULT:String = "Soma::SomaDebugger";
		
		public static var DEFAULT_WINDOW_WIDTH:Number = 450;
		public static var DEFAULT_WINDOW_HEIGHT:Number = 180;
		public static var DEFAULT_WINDOW_INSPECTOR_WIDTH:Number = 450;
		public static var DEFAULT_WINDOW_INSPECTOR_HEIGHT:Number = 250;		public static var DEFAULT_DISPLAY_COMMANDS_PROPERTIES:Boolean = true;
		public static var DEFAULT_LOG_MAX_STRING_LENGTH:int = 170;
		
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		public function SomaDebugger() {
			
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		public function initialize(pluginVO:ISomaPluginVO):void {
			if (!(pluginVO is SomaDebuggerVO) || pluginVO == null) throw new Error("Error in " + this + " The pluginVO is null or is not an instance of SomaDebuggerPluginVO");
			try {
				var vo:SomaDebuggerVO = pluginVO as SomaDebuggerVO;
				if (vo == null || vo.instance == null || vo.instance.wires == null) throw new Error("Soma is not initialized properly.");
				NAME = vo.debuggerName;
				_instance = vo.instance;
				_wire = _instance.wires.addWire(NAME, new SomaDebuggerWire(NAME, vo)) as SomaDebuggerWire;
				_view = _wire.debugger;
			} catch (e:Error) {
				trace("Error in " + this + " " + e);
			}
		}
		
		public function printCommand(type:String = "message", event:Event = null):void {
			if (_view != null) _view.printCommand(type, event);
		}
		
		public function print(value:Object):void {
			if (_view != null) _view.print(value);
		}
		
		public function clear():void {
			if (_view != null) _view.clear();
		}

		public function addWatcher(commandName:String):void {
			if (_wire != null) _wire.addWatcher(commandName);
		}

		public function removeWatcher(commandName:String):void {
			if (_wire != null) _wire.removeWatcher(commandName);
		}
		
		public function removeAllWatchers():void {
			if (_wire != null) _wire.removeAllWatchers();
		}
		
		public function get wire():SomaDebuggerWire {
			return _wire;
		}
		
		public function get view():SomaDebuggerView {
			return _view;
		}
		
		public function get name():String {
			return _name;
		}
		
		public function dispose() : void {
			// dispose objects, graphics and events listeners
			try {
				_instance.removeWire(NAME);
			} catch(e:Error) {
				trace("Error in", this, "(dispose method):", e.message);
			}
		}

	}
}