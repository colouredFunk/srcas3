package com.soma.core.controller {
	import com.soma.core.interfaces.ICommand;
	import com.soma.core.interfaces.ISequenceCommand;
	import com.soma.core.interfaces.ISoma;

	import flash.events.Event;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	/**
	 * <b>Author:</b> Romuald Quantin - <a href="http://www.soundstep.com/" target="_blank">www.soundstep.com</a><br />* <b>Class version:</b> 1.0<br />
	 * <b>Actionscript version:</b> 3.0<br />
	 * <b>Copyright:</b> 
	 * <br />
	 * <b>Date:</b> Sep 17, 2009<br />
	 * <b>Usage:</b>
	 * @example
	 * <listing version="3.0"></listing>
	 */
	
	public class SomaController {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		namespace somans = "http://www.soundstep.com/soma";
		
		private var _instance:ISoma;
		
		private var _commands:Dictionary;
		private var _sequencers:Dictionary;
		private var _lastEvent:Event;
		private var _lastSequencer:ISequenceCommand;

		//------------------------------------
		// public properties
		//------------------------------------
		
		
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		public function SomaController(instance:ISoma) {
			_instance = instance;
			initialize();
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		private function initialize():void {
			_commands = new Dictionary();
			_sequencers = new Dictionary();
		}
		
		private function addInterceptor(commandName:String):void {
			if (_instance.stage == null) return;
			_instance.stage.addEventListener(commandName, eventsHandler, true, -100);
			_instance.addEventListener(commandName, somaEventsHandler, false, -100);
		}
		
		private function removeInterceptor(commandName:String):void {
			if (_instance.stage == null) return;
			_instance.stage.removeEventListener(commandName, eventsHandler, true);
			_instance.removeEventListener(commandName, somaEventsHandler, false);
		}
		
		private function eventsHandler(event:Event):void {
			if (event.bubbles && hasCommand(event.type)) {
				event.stopPropagation();
				var clonedEvent:Event = event.clone();
				var eventClass:Class = getDefinitionByName(getQualifiedClassName(event)) as Class;
				if (!(clonedEvent is eventClass)) {
					// send warning in case the event subclass is not overriding the clone method
					trace("Warning in SomaController: your event class [", getQualifiedClassName(event), "] is not overriding the clone method, you might lose some custom event properties.");
				}
				// store a reference of the events not to dispatch it twice
				_lastEvent = clonedEvent;
				_instance.dispatchEvent(clonedEvent);
				if (!clonedEvent.isDefaultPrevented()) {
					executeCommand(event);
				}
				_lastEvent = null;
			}
		}
		
		private function somaEventsHandler(event:Event):void {
			// if the event is equal to the lastEvent, this has already been dispatched for execution
			if (_lastEvent != event) {
				if (!event.isDefaultPrevented()) {
					executeCommand(event);
				}
			}
		}

		internal function executeCommand(event:Event):void {
			if (hasCommand(event.type)) {
				var CommandClass:Class = _commands[event.type];
				var command:ICommand = new CommandClass();
				Command(command).somans::registerInstance(_instance);
				command.execute(event);
			}
		}
		
		internal function registerSequencedCommand(sequencer:ISequenceCommand, event:Event):void {
			if (event == null) return;
			if (_sequencers[sequencer] == null || _sequencers[sequencer] == undefined) {
				_lastSequencer = sequencer;
				_sequencers[sequencer] = [];
			}
			_sequencers[sequencer].push(event);
		}

		internal function unregisterSequencedCommand(sequencer:ISequenceCommand, event:Event):void {
			if (event == null) return;
			if (_sequencers[sequencer] != null && _sequencers[sequencer] != undefined) {
				var len:int = _sequencers[sequencer].length;
				for (var i:int=0; i<len; i++) {
					if (_sequencers[sequencer][i] == event) {
						_sequencers[sequencer].splice(i, 1);
						if (_sequencers[sequencer].length == 0) {
							_sequencers[sequencer] = null;
							delete _sequencers[sequencer];
						}
						break;
					}
				}
			}
		}
		
		internal function unregisterSequencer(sequencer:ISequenceCommand):void {
			if (_sequencers[sequencer] != null && _sequencers[sequencer] != undefined) {
				_sequencers[sequencer] = null;
				delete _sequencers[sequencer];
			}
		}

		// PUBLIC
		//________________________________________________________________________________________________
		
		public function hasCommand(commandName:String):Boolean {
			return !(_commands[commandName] == null || _commands[commandName] == undefined);
		}
		
		public function addCommand(commandName:String, command:Class):void {
			if (hasCommand(commandName)) {
				throw new Error("Error in " + this + " Command \"" + commandName + "\" already registered.");
			}
			_commands[commandName] = command;
			addInterceptor(commandName);
		}
		
		public function removeCommand(commandName:String):void {
			if (!hasCommand(commandName)) {
				throw new Error("Error in " + this + " Command \"" + commandName + "\" not registered.");
			}
			_commands[commandName] = null;
			delete _commands[commandName];
			removeInterceptor(commandName);
		}
		
		public function getCommand(commandName:String):Class {
			if (!hasCommand(commandName)) return null;
			return _commands[commandName];
		}
		
		public function getCommands():Array {
			var array:Array = [];
			for (var command:String in _commands) {
				array.push(command);
			}
			return array;
		}
		
		public function getSequencer(event:Event):ISequenceCommand {
			for (var sequencer:Object in _sequencers) {
				var len:int = _sequencers[sequencer].length;
				for (var i:int=0; i<len; i++) {
					if (_sequencers[sequencer][i] == event) {
						return sequencer as ISequenceCommand;
					}
				}
			}
			return null;
		}
		
		public function stopSequencerWithEvent(event:Event):Boolean {
			for (var sequencer:Object in _sequencers) {
				var len:int = _sequencers[sequencer].length;
				for (var i:int=0; i<len; i++) {
					if (_sequencers[sequencer][i] == event) {
						ISequenceCommand(sequencer).stop();
						return true;
					}
				}
			}
			return false;
		}
		
		public function stopSequencer(sequencer:ISequenceCommand):Boolean {
			if (sequencer == null) return false;
			sequencer.stop();
			return true;
		}
		
		public function getRunningSequencers():Array {
			var array:Array = [];
			for (var sequencer:Object in _sequencers) {
				array.push(sequencer);
			}
			return array;
		}
		
		public function stopAllSequencers():void {
			for (var sequencer:Object in _sequencers) {
				ISequenceCommand(sequencer).stop();
			}
		}
		
		public function isPartOfASequence(event:Event):Boolean {
			return (getSequencer(event) != null);
		}
		
		public function getLastSequencer():ISequenceCommand {
			return _lastSequencer;
		}
		
	}
}