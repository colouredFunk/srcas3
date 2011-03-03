package akdcl.net {
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.net.URLRequestMethod;
	import flash.events.ProgressEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.utils.ByteArray;

	import com.adobe.serialization.json.JSON;
	
	import akdcl.utils.destroyObject;
	import akdcl.utils.objectToURLVariables;
	import zero.net.FormVars;

	import ui.manager.EventManager;

	/**
	 * ...
	 * @author Akdcl
	 */
	public class DataLoader extends URLLoader {
		public static const TYPE_URL:String = "URLVariables";
		public static const TYPE_FORM:String = "FormVariables";
		public static const TYPE_JSON:String = "JavaScriptObjectNotation";
		private static var request:URLRequest = new URLRequest();
		private static var listReady:Vector.<DataLoader> = new Vector.<DataLoader>();

		//private static var listLoading:Vector.<DataLoader> = new Vector.<DataLoader>();

		//返回DataLoader实例，DataLoader的原理类似工厂模式，会重复使用DataLoader，所以尽量不要保持对DataLoader实例的引用。
		public static function load(_url:*, _onProgressHandler:Function = null, _onCompleteHandler:Function = null, _onIOErrorHandler:Function = null, _data:Object = null, _dataType:String = null):DataLoader {
			//
			var _dataLoader:DataLoader;
			if (listReady.length > 0){
				_dataLoader = listReady.pop();
			} else {
				_dataLoader = new DataLoader();
			}
			//
			_dataLoader.onProgressHandler = _onProgressHandler;
			_dataLoader.onCompleteHandler = _onCompleteHandler;
			_dataLoader.onIOErrorHandler = _onIOErrorHandler;
			if (_onProgressHandler != null) {
				_dataLoader.addEventListener(ProgressEvent.PROGRESS, _onProgressHandler);
			}
			_dataLoader.addEventListener(Event.COMPLETE, onCompleteOrIOErrorHandler);
			_dataLoader.addEventListener(IOErrorEvent.IO_ERROR, onCompleteOrIOErrorHandler);
			//
			request.url = _url;
			request.contentType = null;
			if (_data){
				if (_data["constructor"] === Object) {
					if (_dataType == TYPE_FORM) {
						var _formVars:FormVariables = new FormVariables(_data);
						request.contentType = _formVars.contentType;
						request.data = _formVars.data;
					}else if (_dataType==TYPE_JSON) {
						request.data = JSON.encode(_data);
					}else {
						request.data = objectToURLVariables(_data);
					}
				} else {
					request.data = _data;
				}
				request.method = URLRequestMethod.POST;
			} else {
				request.data = null;
				request.method = URLRequestMethod.GET;
			}
			_dataLoader.clear();
			_dataLoader.load(request);
			return _dataLoader;
		}

		private static function onCompleteOrIOErrorHandler(_evt:Event):void {
			var _dataLoader:DataLoader = _evt.currentTarget as DataLoader;
			if (_evt is IOErrorEvent){
				if (_dataLoader.onIOErrorHandler != null){
					_dataLoader.onIOErrorHandler(_evt);
				}
			} else {
				if (_dataLoader.onProgressHandler != null){
					
				}
				if (_dataLoader.onCompleteHandler != null){
					_dataLoader.onCompleteHandler(_evt);
				}
			}
			_dataLoader.onProgressHandler = null;
			_dataLoader.onCompleteHandler = null;
			_dataLoader.onIOErrorHandler = null;
			EventManager.removeTargetAllEvent(_dataLoader);
			listReady.push(_dataLoader);
		}
		//
		public var userData:Object;

		public function get dataURLVariables():URLVariables {
			try {
				var _data:URLVariables = new URLVariables(data);
			} catch (_error:*){
			}
			return _data;
		}

		public function get dataJSON():Object {
			try {
				var _data:Object = JSON.decode(data);
			} catch (_error:*){
			}
			return _data;
		}
		private var onProgressHandler:Function;
		private var onCompleteHandler:Function;
		private var onIOErrorHandler:Function;

		override public function addEventListener(_type:String, _listener:Function, _useCapture:Boolean = false, _priority:int = 0, _useWeakReference:Boolean = false):void {
			super.addEventListener(_type, _listener, _useCapture, _priority, false);
			EventManager.addTargetEvent(_type, _listener, this);
		}

		override public function removeEventListener(_type:String, _listener:Function, _useCapture:Boolean = false):void {
			super.removeEventListener(_type, _listener, _useCapture);
			EventManager.removeTargetEvent(_type, _listener, this);
		}
		public function remove():void {
			clear();
			EventManager.removeTargetAllEvent(this);
			onProgressHandler = null;
			onCompleteHandler = null;
			onIOErrorHandler  = null;
			var _id:int = listReady.indexOf(this);
			if (_id >= 0) {
				listReady.splice(_id, 1);
			}
		}
		public function clear():void {
			data = null;
			destroyObject(userData);
			userData = null;
		}
	}
}
import flash.utils.ByteArray;
class FormVariables{
	private var datas:Object;
	
	public var contentType:String;
	public var boundary:String;
	public function FormVariables(_values:Object=null){
		datas=_values||new Object();
		boundary="-=-=-=-=-=-=-=-=-=-"+Math.random();
		contentType="multipart/form-data; boundary="+boundary;//只能用户点击时上传
		//contentType="application/octet-stream; boundary="+boundary;
	}
	public function add(name:String,value:*):void{
		datas[name]=value;
	}
	public function get data():ByteArray{
		var data:ByteArray=new ByteArray();
		for(var name:String in datas){
			var value:*=datas[name];
			data.writeUTFBytes("--" + boundary + "\r\n");
			if(value is ByteArray){
				data.writeUTFBytes(
					"Content-Disposition: form-data; name=\"" + name + 
					"\"; filename=\"\\" + name +
					"\"\r\nContent-Type: application/octet-stream\r\n\r\n"
				);
				data.writeBytes(datas[name]);
				data.writeUTFBytes("\r\n");
			}else{
				data.writeUTFBytes(
					"Content-Disposition: form-data; name=\"" + name + 
					"\"\r\n\r\n"+datas[name]+
					"\r\n"
				);
			}
		}
		data.writeUTFBytes("--" + this.boundary + "--\r\n");
		return data;
	}
}