package com.soma.debugger.views {
	import com.soma.debugger.SomaDebugger;
	import com.soma.debugger.events.SomaDebuggerEvent;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TextEvent;
	import flash.geom.Point;
	import flash.utils.describeType;
	import flash.utils.getQualifiedClassName;

	/**
	 * <b>Author:</b> Romuald Quantin - <a href="http://www.soundstep.com/" target="_blank">www.soundstep.com</a><br />* <b>Class version:</b> 1.0<br />
	 * <b>Actionscript version:</b> 3.0<br />
	 * <b>Copyright:</b> 
	 * <br />
	 * <b>Date:</b> Sep 10, 2009<br />
	 * <b>Usage:</b>
	 * @example
	 * <listing version="3.0"></listing>
	 */
	
	public class SomaDebuggerView extends Sprite {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		private var _debuggerName:String;
		private var _mainWindow:SomaDebuggerMainWindow;
		private var _subWindowContainer:Sprite;
		
		private var _count:int;
		
		private var _widthWindow:Number;
		private var _heightWindow:Number;
		
		private var _objects:Array;
		private var _countObjects:int;
		
		//------------------------------------
		// public properties
		//------------------------------------
		
		public var enableLog:Boolean = true;
		public var enableTrace:Boolean = false;
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		public function SomaDebuggerView(debuggerName:String) {
			_debuggerName = debuggerName;
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
			_objects = [];
			_countObjects = 0;
			_count = 1;
			_widthWindow = SomaDebugger.DEFAULT_WINDOW_WIDTH;
			_heightWindow = SomaDebugger.DEFAULT_WINDOW_HEIGHT;
			createMainWindow();
			createSubWindowContainer();
		}
		
		private function createMainWindow():void {
			_mainWindow = addChild(new SomaDebuggerMainWindow(_debuggerName, _widthWindow, _heightWindow)) as SomaDebuggerMainWindow;
			_mainWindow.addEventListener(Event.CLOSE, closeHandler);
			_mainWindow.textfield.addEventListener(TextEvent.LINK, openObject);
		}
		
		private function createSubWindowContainer():void {
			_subWindowContainer = addChild(new Sprite) as Sprite;
		}
		
		private function closeHandler(event:Event):void {
			dispatchEvent(new SomaDebuggerEvent(SomaDebuggerEvent.HIDE_DEBUGGER, null, _debuggerName));
		}

		private function formatTrace(value:String):String {
			var str:String = value;
			str = str.replace(new RegExp("<br/>", "g"), "\n");
			str = str.replace(new RegExp("<([^>\\s]+)(\\s[^>]+)*>", "g"), "");
			return str;
		}
		
		private function openObject(e:TextEvent):void {
			createInspectWindow(_objects[int(e.text)]);
		}
		
		private function createInspectWindow(obj:Object):void {
			var window:SomaDebuggerWindow = new SomaDebuggerWindow(getType(getQualifiedClassName(obj)), SomaDebugger.DEFAULT_WINDOW_INSPECTOR_WIDTH, SomaDebugger.DEFAULT_WINDOW_INSPECTOR_HEIGHT);
			var point:Point = new Point(stage.stageWidth * .5 - SomaDebugger.DEFAULT_WINDOW_INSPECTOR_WIDTH * .5, stage.stageHeight * .5 - SomaDebugger.DEFAULT_WINDOW_INSPECTOR_HEIGHT * .5);
			window.x = globalToLocal(point).x;			window.y = globalToLocal(point).y;
			window.addEventListener(Event.CLOSE, closeWindowHandler);
			window.textfield.addEventListener(TextEvent.LINK, openObject);
			_subWindowContainer.addChild(window);
			setWindowInspectorText(window, obj);
			dispatchEvent(new SomaDebuggerEvent(SomaDebuggerEvent.MOVE_TO_TOP));
		}

		private function closeWindowHandler(e:Event):void {
			var window:SomaDebuggerWindow = e.currentTarget as SomaDebuggerWindow;
			window.removeEventListener(Event.CLOSE, closeWindowHandler);
			window.textfield.removeEventListener(TextEvent.LINK, openObject);
			window.dispose();
			_subWindowContainer.removeChild(window);
			window = null;
		}
		
		private function getInspectorFormattedProperty(key:Object, obj:Object, isMethod:Boolean = false, classTypeDescribed:String = null):String {
			var val:Object = (isMethod) ? obj[key]() : obj[key];
			var type:String = (classTypeDescribed != null) ? getType(classTypeDescribed) : getType(getQualifiedClassName(val));
			var str:String = "";
		 	_objects[_countObjects] = val;
			if (isCustomClass(val)) str += '<br/>      <a href="event:' + _countObjects + '"><font color="#00009B">' + key + ":</font> ";
			else str += '<br/>      <a href="event:' + _countObjects + '"><font color="#00009B">' + key + ":</font> ";
			str += getValue(val);
			str += ' <font color="#997E17">(' + type + ")</font>";
			if (classTypeDescribed != null && classTypeDescribed == "uint") str += " - " + "0x" + int(val).toString(16).toUpperCase();
			str += '</a>';
			_countObjects++;
			return str;
		}
		
		private function setWindowInspectorText(window:SomaDebuggerWindow, obj:Object):void {
			var str:String = '<font color="#881260">TYPE: </font><font color="#997E17">' + getQualifiedClassName(obj) + '</font>';
			if (getQualifiedClassName(obj) == "Object") {
				// dynamic object
				 for (var s:String in obj) {
				 	str += getInspectorFormattedProperty(s, obj);
				 }
			}
			else if (getQualifiedClassName(obj) == "flash.utils::Dictionary") {
				// dictionary
				 for (var o:Object in obj) {
				 	str += getInspectorFormattedProperty(o, obj);
				 }
			}
			else if (getQualifiedClassName(obj) == "Array") {
				// array
				var j:int = 0;
				var al:int = obj.length;
				for (j=0; j<al; ++j) {
				 	str += getInspectorFormattedProperty(j, obj);
				 }
			}
			else {
				// custom
				try {
					var variables:XMLList = getVariables(obj);
					var i:int = 0;
					var vl:int = variables.length();
					if (vl > 0) str += '<br/><br/><font color="#881260">VARIABLES: </font>';
					var name:String;					var type:String;
					// variables
					for (i=0; i<vl; ++i) {
						name = variables[i].@name;
						type = variables[i].@type;
						str += getInspectorFormattedProperty(name, obj, false, type);
					}
					if (isCustomClass(obj)) {
						var accessors:XMLList = getAccessors(obj);
						i = 0;
						vl = accessors.length();
						if (vl > 0) str += '<br/><br/><font color="#881260">ACCESSORS: </font>';
						for (i=0; i<vl; ++i) {
							name = accessors[i].@name;
							type = accessors[i].@type;
							if (obj.hasOwnProperty(name) && name != "textSnapshot") {
								str += getInspectorFormattedProperty(name, obj, false, type);
							}
						}
						var methods:XMLList = getMethods(obj);
						i = 0;
						vl = methods.length();
						if (vl > 0) str += '<br/><br/><font color="#881260">METHODS: </font>'; 
						for (i=0; i<vl; ++i) {
							name = methods[i].@name;
							type = methods[i].@type;
							if (obj.hasOwnProperty(name) && !methods[i].hasOwnProperty("parameter")) {
								str += getInspectorFormattedProperty(name, obj, true, type);
							}
						}
					}
				} catch (err:Error) {trace(err);}
			}
			str += '<br/><br/><font color="#881260">VALUE: </font>';
			if (obj is XML || obj is XMLList) {
				var strXML:String = obj.toXMLString();
				strXML = strXML.replace(new RegExp("(<.*?)", "gm"), "&lt;");
				str += strXML;
			}
			else {
				str += String(obj);
				if (obj is uint) str += " - " + "0x" + int(obj).toString(16).toUpperCase();
			}
			window.textfield.htmlText = str;
		}

		private function getType(className:String):String {
			if (className.search("::") == -1) return className;
			else return className.substr(className.lastIndexOf("::")+ 2);
		}
		
		private function isCustomClass(obj:Object):Boolean {
			return !(obj is Number || obj is Boolean || obj is String || obj == null || getQualifiedClassName(obj) == "Object" || getQualifiedClassName(obj) == "Array");
		}
		
		private function getValue(value:Object):String {
			var type:String = getQualifiedClassName(value);
			if (value is Boolean) {
				return Boolean(value).toString();
			}
			else if (value is String) {
				return (String(value).length > SomaDebugger.DEFAULT_LOG_MAX_STRING_LENGTH ? String(value).substr(0, SomaDebugger.DEFAULT_LOG_MAX_STRING_LENGTH)+"..." : String(value));
			}
			else if (getQualifiedClassName(value) == "Object") {
				return "Object";
			}
			else if (getQualifiedClassName(value) == "Array") {
				return "Array (" + value.length + ")";
			}
			else if (isCustomClass(value)) {
				return getType(type);
			}
			return String(value);
		}
		
		private function getPrintString(value:Object):String {
			var type:String = getQualifiedClassName(value);
			_objects[_countObjects] = value;
			var str:String = '<a href="event:' + _countObjects + '">';
			str += '<font color="#881260">PRINT ></font> ' + getValue(value);
			str += ' <font color="#997E17">(' + getType(type) + ')</font></a>';
			_countObjects++;
			return str;
		}
		
		private function getVariables(obj:Object):XMLList {
			return describeType(obj)..*.(name() == "variable");
		}

		private function getAccessors(obj:Object):XMLList {
			return describeType(obj)..*.(name() == "accessor" && String(@access) != "writeonly");
		}

		private function getMethods(obj:Object):XMLList {
			return describeType(obj)..*.(name() == "method" && String(@returnType) != "void");
		}

		// PUBLIC
		//________________________________________________________________________________________________
		
		public function printCommand(type:String, event:Event):void {
			var str:String = "";
			if (event) {
				_objects[_countObjects] = event;
				str = '<font color="#4E7B8B">EVENT > <a href="event:' + _countObjects + '">' + type + '</a></font>';
				_countObjects++;
				if (SomaDebugger.DEFAULT_DISPLAY_COMMANDS_PROPERTIES) {
					var variables:XMLList = getVariables(event);
					var i:int = 0;
					var vl:int = variables.length();
					for (i=0; i<vl; ++i) {
						var name:String = variables[i].@name;
						var type:String = variables[i].@type;
						if (event[name] != null) {
							_objects[_countObjects] = event[name];
							str += '<br/>      <a href="event:' + _countObjects + '"><font color="#00009B">' + name  + ":</font> " + getValue(event[name]) + ' <font color="#997E17">(' + getType(type) + ")</font></a>";
							if (variables[i].@type == "uint") str += " - " + "0x" + int(event[name]).toString(16).toUpperCase();
							_countObjects++;
						}
					}
				}
			}
			if (enableTrace) trace(_count + ". " + formatTrace(str));
			if (enableLog) _mainWindow.textfield.htmlText = _count + ". " + str + "<br/>" + _mainWindow.textfield.htmlText;
			_count++;
		}
		
		public function print(value:Object):void {
			var str:String = getPrintString(value);
			if (enableTrace) trace(_count + ". " + formatTrace(str));
			if (enableLog) _mainWindow.textfield.htmlText = _count + ". " + str + "<br/>" + _mainWindow.textfield.htmlText;
			_count++;
		}
		
		public function clear():void {
			_mainWindow.textfield.htmlText = "";
			_count = 1;
			_objects = [];
			_countObjects = 0;
		}
		
		public function dispose() : void {
			// dispose objects, graphics and events listeners
			try {
				_mainWindow.dispose();
				while (_subWindowContainer.numChildren > 0) {
					if (_subWindowContainer.getChildAt(0).hasOwnProperty("dispose")) {
						_subWindowContainer.getChildAt(0)["dispose"]();
					}
					_subWindowContainer.removeChildAt(0);
				}
				while (numChildren > 0) removeChildAt(0);
				_mainWindow = null;
				_subWindowContainer = null;
				_objects = null;
			} catch(e:Error) {
				trace("Error in", this, "(dispose method):", e.message);
			}
		}
		
		public function get debuggerName():String {
			return _debuggerName;
		}
		
		public function get mainWindow():SomaDebuggerMainWindow {
			return _mainWindow;
		}
	}
}
