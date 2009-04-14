/*
 * SWF加载
 */
package com{
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	/**
	 * SWF加载器
	 */
	public class SWFLoader extends EventDispatcher {
		private var __loadinfo:LoaderInfo;

		public function get loadinfo():LoaderInfo {
			return __loadinfo;
		}
		public function SWFLoader() {
		}
		/**
		 加载SWF
		 */
		public function load(_url:String):void {
			var _loader:Loader         = new Loader();
			var _context:LoaderContext = new LoaderContext();

			/** 加载到子域 */
			_context.applicationDomain = new ApplicationDomain(ApplicationDomain.currentDomain);

			initLoadEvent(_loader.contentLoaderInfo);
			_loader.load(new URLRequest(_url),_context);
		}
		/**
		 * 获取当前ApplicationDomain内的类定义
		 * 
		 * name类名称，必须包含完整的命名空间,如 Grave.Function.SWFLoader
		 * info加载swf的LoadInfo，不指定则从当前域获取
		 * return获取的类定义，如果不存在返回null
		 */
		public function getClass(_name:String, _info:LoaderInfo = null):Class {
			try {
				if (_info == null) {
					return ApplicationDomain.currentDomain.getDefinition(_name)  as  Class;
				}
				return _info.applicationDomain.getDefinition(_name)  as  Class;
			} catch (e:ReferenceError) {
				//trace("定义 " + name + " 不存在");
				return null;
			}
			return null;
		}
		/**
		 * @private
		 * 监听加载事件
		 * 
		 * @param info加载对象的LoaderInfo
		 */
		private function initLoadEvent(_info : LoaderInfo):void {
			_info.addEventListener(ProgressEvent.PROGRESS, this.onProgress);
			_info.addEventListener(Event.COMPLETE, this.onComplete);
			_info.addEventListener(IOErrorEvent.IO_ERROR, this.onError);
			_info.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onError);
		}
		/**
		 * @private
		 * 移除加载事件
		 * 
		 * @param inft加载对象的LoaderInfo
		 */
		private function removeLoadEvent(_info:LoaderInfo):void {
			_info.removeEventListener(Event.COMPLETE,onComplete);
			_info.removeEventListener(ProgressEvent.PROGRESS,onProgress);
			_info.removeEventListener(IOErrorEvent.IO_ERROR,onError);
			_info.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,onError);
		}
		/** 加载事件 */
		private function onComplete(e:Event):void {
			var _info:LoaderInfo = e.currentTarget as LoaderInfo;
			removeLoadEvent(_info);
			__loadinfo = _info;
			this.dispatchEvent(e);
		}
		/** 加载中 */
		private var __loadedPct:Number=0;
		public function get loadedPct():Number{
			return __loadedPct;
		}
		private function onProgress(e:ProgressEvent):void {
			__loadedPct=e.bytesLoaded/e.bytesTotal;
			this.dispatchEvent(e);
		}
		/** 出错事件 */
		private function onError(e:Event):void {
			this.dispatchEvent(e);
		}
	}
}