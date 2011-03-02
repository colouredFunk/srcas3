package akdcl.net {
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.navigateToURL;
	import flash.external.ExternalInterface;
	import akdcl.utils.objectToURLVariables;
	/**
	 * ...
	 * @author Akdcl
	 */

	public function getURL(_urlOrXML:*, _target:String = "_blank", _data:Object = null):void {
		if (_urlOrXML is XMLList) {
			_urlOrXML = _urlOrXML[0];
		}
		if (_urlOrXML is XML) {
			var _js:String = String(_urlOrXML.attribute("js"));
			_target = String(_urlOrXML.attribute("target")) || _target;
			_urlOrXML = String(_urlOrXML.attribute("href"));
			if (!_urlOrXML && _js && ExternalInterface.available) {
				ExternalInterface.call("eval", _js);
				return;
			}
		}
		
		var _request:URLRequest = new URLRequest(_urlOrXML);
		if (_data) {
			if (_data["constructor"]===Object) {
				_request.data = objectToURLVariables(_data);
			}else {
				_request.data = _data;
			}
			_request.method = URLRequestMethod.POST;
			navigateToURL(_request, _target);
			return;
		}
		
		var _browserAgent:String;
		if (ExternalInterface.available){
			_browserAgent = ExternalInterface.call("function getBrowser(){return navigator.userAgent;}");
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
					ExternalInterface.call("window.open", _urlOrXML, _target, "");
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