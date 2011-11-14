package akdcl.net {
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.external.ExternalInterface;
	import akdcl.utils.objectToURLVariables;
	/**
	 * ...
	 * @author Akdcl
	 */

	public function gotoURL(_urlOrXML:*, _target:String = "_blank", _data:Object = null, _method:String = "GET"):void {
		if (_urlOrXML is XMLList) {
			_urlOrXML = _urlOrXML[0];
		}
		var _href:String;
		var _js:String;
		if (_urlOrXML is XML) {
			_target = String(_urlOrXML.attribute("target")) || _target;
			_href = String(_urlOrXML.attribute("href"));
			_js = _urlOrXML.attribute("js");
		}else {
			_href = _urlOrXML;
		}
		
		if (_js && ExternalInterface.available) {
			ExternalInterface.call("eval", _js);
		}
		
		var _request:URLRequest = new URLRequest(_href);
		if (_data) {
			if (_data["constructor"] === Object) {
				_request.data = objectToURLVariables(_data);
			}else {
				_request.data = _data;
			}
			_request.method = _method;
			navigateToURL(_request, _target);
			return;
		}
		
		var _browserAgent:String;
		if (ExternalInterface.available){
			_browserAgent = ExternalInterface.call("eval", "navigator.userAgent;");
		}
		if (_browserAgent){
			var _browserName:String;
			if (_browserAgent.indexOf("Firefox") >= 0){
				_browserName = "Firefox";
			} else if (_browserAgent.indexOf("Safari") >= 0){
				_browserName = "Safari";
			} else if (_browserAgent.indexOf("MSIE") >= 0){
				_browserName = "IE";
			} else if (_browserAgent.indexOf("Opera") >= 0){
				_browserName = "Opera";
			} else {
				_browserName = "Unknown";
			}
		}
		var _features:String = "";
		switch (_browserName){
			case "Firefox":
			case "IE":
				if (ExternalInterface.available){
					ExternalInterface.call("window.open", _href, _target, "");
				} else {
					navigateToURL(_request, _target);
				}
				break;
			case "Safari":
			case "Opera":
				navigateToURL(_request, _target);
				break;
			default:
				navigateToURL(_request, _target);
				break;
		}
	}
}