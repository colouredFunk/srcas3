package com.soma.core {
	import com.soma.core.controller.SomaController;
	import com.soma.core.interfaces.IModel;
	import com.soma.core.interfaces.ISequenceCommand;
	import com.soma.core.interfaces.ISoma;
	import com.soma.core.interfaces.ISomaPlugin;
	import com.soma.core.interfaces.ISomaPluginVO;
	import com.soma.core.interfaces.IWire;
	import com.soma.core.model.SomaModels;
	import com.soma.core.view.SomaViews;
	import com.soma.core.wire.SomaWires;

	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;

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
	
	public class Soma extends EventDispatcher implements ISoma {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		private var _models:SomaModels;
		private var _views:SomaViews;
		private var _controller:SomaController;
		private var _wires:SomaWires;
		
		private var _stage:Stage;

		//------------------------------------
		// public properties
		//------------------------------------
		
		
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		public function Soma(stage:Stage) {
			initialize(stage);
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		private function initialize(stage:Stage):void {
			validateStage(stage);
			_stage = stage;
			_models = new SomaModels(this);
			_views = new SomaViews();
			_controller = new SomaController(this);
			_wires = new SomaWires(this);
			registerModels();
			registerViews();
			registerCommands();
			registerWires();
			registerPlugins();
		}
		
		private function validateStage(stage:Stage):void {
			if (stage == null) throw new Error("Error in " + this + " You can't instantiate Soma with a stage that has a value null. Start soma after a Event.ADDED_TO_STAGE.");
		}
		
		protected function registerModels():void {
			
		}

		protected function registerViews():void {
			
		}

		protected function registerCommands():void {
			
		}

		protected function registerWires():void {
			
		}

		protected function registerPlugins():void {
			
		}

		// PUBLIC
		//________________________________________________________________________________________________
		
		public final function get models():SomaModels {
			return _models;
		}

		public final function get views():SomaViews {
			return _views;
		}

		public final function get controller():SomaController {
			return _controller;
		}

		public final function get wires():SomaWires {
			return _wires;
		}

		public final function createPlugin(plugin:Class, pluginVO:ISomaPluginVO):ISomaPlugin {
			try {
				var pluginInstance:Object = new plugin();
				if (!(pluginInstance is ISomaPlugin)) throw new Error("Error in " + this + " The plugin class must implements ISomaPlugin");
				ISomaPlugin(pluginInstance).initialize(pluginVO);
				return pluginInstance as ISomaPlugin;
			} catch (e:Error) {
				trace(e);
			}
			return null;
		}

		public final function createPluginFromClassName(pluginClassName:String, pluginVO:ISomaPluginVO):ISomaPlugin {
			try {
				var PluginClass:Class = getDefinitionByName(pluginClassName) as Class;
				var pluginInstance:Object = new PluginClass();
				if (!(pluginInstance is ISomaPlugin)) throw new Error("Error in " + this + " The plugin class must implements ISomaPlugin");
				ISomaPlugin(pluginInstance).initialize(pluginVO);
				return pluginInstance as ISomaPlugin;
			} catch (e:Error) {
				if (e.errorID == 1065) trace("Error in " + this + " Plugin From ClassName not created (" + pluginClassName + "), you need to import your Class or use the createPlugin() method.");
				else throw trace(e.message);
			}
			return null;
		}

		public final function get stage():Stage {
			return _stage;
		}
		
		public final function hasCommand(commandName:String):Boolean {
			return controller.hasCommand(commandName);
		}
		
		public final function addCommand(commandName:String, command:Class):void {
			controller.addCommand(commandName, command);
		}
		
		public final function removeCommand(commandName:String):void {
			controller.removeCommand(commandName);
		}
		
		public final function getCommand(commandName:String):Class {
			return controller.getCommand(commandName);
		}
		
		public final function getCommands():Array {
			return controller.getCommands();
		}
		
		public final function getSequencer(event:Event):ISequenceCommand {
			return controller.getSequencer(event);
		}
		
		public final function stopSequencerWithEvent(event:Event):Boolean {
			return controller.stopSequencerWithEvent(event);
		}
		
		public final function stopSequencer(sequencer:ISequenceCommand):Boolean {
			return controller.stopSequencer(sequencer);
		}
		
		public final function getRunningSequencers():Array {
			return controller.getRunningSequencers();
		}
		
		public final function stopAllSequencers():void {
			controller.stopAllSequencers();
		}
		
		public final function isPartOfASequence(event:Event):Boolean {
			return controller.isPartOfASequence(event);
		}
		
		public final function getLastSequencer():ISequenceCommand {
			return controller.getLastSequencer();
		}
		
		public final function hasModel(modelName:String):Boolean {
			return models.hasModel(modelName);
		}
		
		public final function addModel(modelName:String, model:IModel):IModel {
			return models.addModel(modelName, model);
		}
		
		public final function removeModel(modelName:String):void {
			models.removeModel(modelName);
		}
		
		public final function getModel(modelName:String):IModel {
			return models.getModel(modelName);
		}
		
		public final function getModels():Dictionary {
			return models.getModels();
		}
		
		public final function hasView(viewName:String):Boolean {
			return views.hasView(viewName);
		}
		
		public final function addView(viewName:String, view:Object):Object {
			return views.addView(viewName, view);
		}
		
		public final function removeView(viewName:String):void {
			views.removeView(viewName);
		}
		
		public final function getView(viewName:String):Object {
			return views.getView(viewName);
		}
		
		public final function getViews():Dictionary {
			return views.getViews();
		}
		
		public final function hasWire(wireName:String):Boolean {
			return wires.hasWire(wireName);
		}
		
		public final function addWire(wireName:String, wire:IWire):IWire {
			return wires.addWire(wireName, wire);
		}
		
		public final function removeWire(wireName:String):void {
			wires.removeWire(wireName);
		}
		
		public final function getWire(wireName:String):IWire {
			return wires.getWire(wireName);
		}
		
		public final function getWires():Dictionary {
			return wires.getWires();
		}
		
	}
}