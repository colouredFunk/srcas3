/**
 * 
 * QQ微博:http://t.qq.com/maoyexing
 * e-mail:maoyexing@gmail.com
 * 
 * */
package com.core.microBlogs.standard
{
	import com.util.http.HttpConnection;
	import com.util.http.HttpEvent;
	
	import com.adobe.serialization.json.JSON;

	/**
	 * Microblogs api - DoAPI
	 * ---
	 * 微博API实现类的基类。by 毛业兴 
	 * 
	 * @since 2011-4-10
	 * @author 毛业兴
	 * 
	 */
	public class DoAPI
	{
		public function DoAPI(dataHandler:Function, errorHandler:Function)
		{
			this._dataHandler = dataHandler;
			this._errorHandler = errorHandler;
			_httpConn = new HttpConnection();
			initEvents();
		}
		
		/**
		 * 
		 * HTTP链接对象
		 * 
		 * */
		protected var _httpConn:HttpConnection;
		/**
		 * 
		 * 正确数据回调函数
		 * 
		 * */
		protected var _dataHandler:Function;
		/**
		 * 
		 * 发生错误回调函数
		 * 
		 * */
		protected var _errorHandler:Function;
		
		private function onHttpErrorHandler(evt:HttpEvent):void{
			_errorHandler(evt.params);
		}
		private function initEvents():void{
			_httpConn.addEventListener(HttpEvent.onHttpError, onHttpErrorHandler);
		}
		
		protected function executeResponse(format:String, data:String):Object{
			//json
			var params:Object;
			if(format == "json")
				params = com.adobe.serialization.json.JSON.decode(data);
				//xml
			else if(format == "xml")
				params = new XML(data);
			return params;
		}
	}
}