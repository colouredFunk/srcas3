package {
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	
	import flash.external.ExternalInterface;
	
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.net.URLRequestMethod;
	//import akdcl.net.FormVariables;
	//import com.adobe.crypto.HMAC;
	//import com.adobe.crypto.MD5;
	//import ui.Alert;
	
	final public class PWRD {
		public static var callBack:Function;
		private static var isRequesting:Boolean;
		private static var loadedHandlerLast:Function;
		private static const URL_ISLOGIN:String = "wmpassport2/jsp/islogin.jsp";
		private static const URL_LOGIN:String = "wmpassport2/jsp/ssologin.jsp";
		private static const URL_LOGIN_SUBMIT:String = "accounts/serviceLogin/";
		private static const JS_LOGIN:String = "wanmei.passport.login";
		private static var urlLoader:URLLoader = new URLLoader();
		private static var urlRequest:URLRequest = new URLRequest();
		private static var urlVariables:URLVariables = new URLVariables();
		private static function sendAndLoad(_url:String, _data:* = null, _method:String = "GET", _loaded:Function = null):void {
			urlRequest.method = _method;
			urlRequest.data = null;
			if (_data) {
				for (var _i:String in urlVariables) {
					delete urlVariables[_i];
				}
				for (_i in _data) {
					urlVariables[_i]=_data[_i];
				}
				urlRequest.data = urlVariables;
				urlRequest.contentType = null;
			}
			urlRequest.url = _url;
			if (_loaded!=null) {
				urlLoader.addEventListener(Event.COMPLETE, _loaded);
				loadedHandlerLast = _loaded;
			}
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onRequestErrorHandler);
			urlLoader.load(urlRequest);
		}
		public static function isLogin(_session:String = "USER", _path:String = "/extend/", _otherParams:Object = null):void {
			if (isRequesting) {
				return;
			}
			isRequesting = true;
			var _url:String = _path + URL_ISLOGIN;
			if (!_otherParams) {
				_otherParams = { };
			}
			_otherParams.sessionName = _session;
			_otherParams.rand = Math.random();
			sendAndLoad(_url, _otherParams, "GET", onIsLoginRequestCompleteHandler );
		}
		public static function loginWebMode(_session:String = "USER", _path:String = "/extend/", _otherParams:Object = null):* {
			if (ExternalInterface.available) {
				if (!_otherParams) {
					_otherParams = { };
				}
				_otherParams.session = _session;
				_otherParams.path = _path;
				return ExternalInterface.call(JS_LOGIN, _otherParams );
			}
			return false;
		}
		private static function onRequestErrorHandler(_evt:IOErrorEvent):void {
			urlLoader.removeEventListener(IOErrorEvent.IO_ERROR, onRequestErrorHandler);
			urlLoader.removeEventListener(Event.COMPLETE, loadedHandlerLast);
			isRequesting = false;
		}
		private static function onIsLoginRequestCompleteHandler(_evt:Event):void {
			urlLoader.removeEventListener(IOErrorEvent.IO_ERROR, onRequestErrorHandler);
			urlLoader.removeEventListener(Event.COMPLETE, onIsLoginRequestCompleteHandler);
			isRequesting = false;
			if (callBack!=null) {
				callBack(String(urlLoader.data).replace(/\D/g, ""));
				callBack = null;
			}
		}
		/*public static function login(_session:String = "USER", _path:String = "/extend/", _otherParams:Object = null):void {
			if (isRequesting) {
				return;
			}
			isRequesting = true;
			var _url:String = _path + URL_LOGIN;
			var _data:Object = new Object();
			_data.sessionName = _session;
			_data.filepath = _path;
			_data.redirectURL = _otherParams?_otherParams.url:ExternalInterface.call("eval", "window.top.location.href");;
			if (_otherParams) {
				if (_otherParams.hdid) {
					_data.hdid = _otherParams.hdid;
				}
				//if (options.target) {window.top.document._target = window.top.frames[options.target];}
			}
			sendAndLoad(_url, _data, "GET", onLoginRequestCompleteHandler);
			
		}
		private static function onLoginRequestCompleteHandler(_evt:Event):void {
			//registerVBScript(VB_SCRIPT_LOGIN_KEY);
						
			//wanmei.passport.showMessageBox(messContent,"http://172.16.3.116:22888/extend/");
			
			//redirectURL//window.top.location.href
			
			//form1 username passwd rand
			//var macval = hex_hmac_md5(mackey.toLowerCase(), str_md5((username + password)));
			//document.forms["form1"].iskey.value = "0";
			//document.forms["form1"].passwd.value = '';
			//document.forms["form1"].macval.value = macval;
			//document.forms["form1"].submit();
			
			
			//HMAC.hash(mackey.toLowerCase(), MD5.hashStr(username + password));
			
			var _str:String=_evt.currentTarget.data;
			_str = _str.split("<form").join("</form>");
			_str = _str.split("</form>")[1];
			_str = "<form" + _str + "</form>";
			XML.ignoreWhitespace = true;
			XML.prettyIndent = -1;
			XML.prettyPrinting = true;
			var _xml:XML = XML(_str);
			var _obj:Object = formatXML(_xml);
			//trace(Common.objToString(_obj));
			var _form:FormVariables = new FormVariables();
			for (var _i:String in _obj) {
				_form.add(_i,_obj[_i]);
			}
			isRequesting = false;
			if (callBack!=null) {
				callBack(_xml);
				callBack = null;
			}
			sendAndLoad(URL_LOGIN_SUBMIT,_form,"POST",onLoginSubmitCompleteHandler);
		}
		private static function onLoginSubmitCompleteHandler(_evt:Event):void{
			trace(123+"______"+_evt.currentTarget.data);
		}
		private static function formatXML(_xml:XML, _obj:Object = null):Object {
			if (!_obj) {
				_obj = { };
			}
			for each(var _child:* in _xml.children()) {
				if (_child.name() == "input") {
					_obj[_child.@name] = _child.@value;
				}
				if (_child.children().length()>0) {
					formatXML(_child, _obj);
				}
			}
			return _obj;
		}*/
		/*
		private static const VB_SCRIPT_LOGIN_KEY:XML = 
			<vbscript>
				<![CDATA[
					Function loginkey(passwd, account, rand)
						Dim obj
						On Error Resume Next
						Set obj = CreateObject("Pwusbkey.UsbKey.1")
						If Err.Number <> 0 Then
							//'MsgBox "你没有安装usbkey控件,如果你的IE禁止安装请手动下载控件安装程序,地址:http://passport.wanmei.com/usbkey/pwusbkey.zip"
							//'window.location="http://passport.wanmei.com/usbkey/pwusbkey.zip"
							MsgBox "你没有安装usbkey控件,不能使用该功能"
							loginkey = 4
						End If
						IF passwd = "" Then
							MsgBox "key密码不能为空"
							loginkey = 1
						ElseIf account = "" Then
							MsgBox "账号不能为空"
							loginkey = 2
						ElseIf rand = "" Then
							MsgBox "验证码不能为空"
							loginkey = 3
						End If
						
						Dim ret
						Dim ret4
						ret = obj.HMAC_MD5(passwd, rand, Len(rand), ret4)
						IF ret = -1 Then
							MsgBox "必要的DLL不存在，系统问题"
							loginkey = -1
						ElseIF ret = -2 Then
							MsgBox "没有Key存在,请插入一个usbkey"
							loginkey = -2
						ElseIF ret = -3 Then
							MsgBox "您插入了多个usbkey，请确认只有只有一个usbkey"
							loginkey = -3
						ElseIF ret = -4 Then
							MsgBox "打开key失败，key损坏"
							loginkey = -4
						ElseIF ret = -5 Then
							MsgBox "验证key密码错误"
							loginkey = -5
						ElseIF ret = -6 Then
							MsgBox "进行计算错误"
							loginkey = -6
						ElseIF ret = 0 Then
							//document.all.macval.value = ret4
							//document.form1.method = "post"
							//document.form1.submit()
							loginkey = 0
						End If
					End Function
				]]>
			</vbscript>;
		private static const CRLF:String = String.fromCharCode(13) + String.fromCharCode(10);
		public static function registerVBScript(_xml:XML):void {
			if (!ExternalInterface.available) {
				return;
			}
			var _strVBScript:String=_xml.toString();
			var _arrVBScript:Array = _strVBScript.split(CRLF);
			_strVBScript = "";
			for (var _i:uint; _i < _arrVBScript.length; _i++) {
				_strVBScript += _arrVBScript[_i] + String.fromCharCode(13);
			}
			//trace(_strVBScript);
			ExternalInterface.call("window.execScript", _strVBScript, "vbscript");
		}*/
	}
	
}