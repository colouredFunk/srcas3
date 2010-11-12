package {
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class PWRDJS {
		public static const INIT:XML =<script><![CDATA[
			if(!pwrd){
				var pwrd={};
			}
			pwrd.getBrowserName=function(){
				var _browserAgent=window.navigator.userAgent;
				var _browserName;
				if(_browserAgent){
					if(_browserAgent.indexOf("Firefox")>=0){
						_browserName="Firefox";
					}else if(_browserAgent.indexOf("Safari")>=0){
						_browserName="Safari";
					}else if(_browserAgent.indexOf("MSIE")>=0){
						_browserName="IE";
					}else if(_browserAgent.indexOf("Opera")>=0){
						_browserName="Opera";
					}else{
						_browserName="Unknown";
					}
				}else{
					_browserName="Unknown";
				}
				return _browserName;
			}
			pwrd.getSWFByID=function(_swfID){
				var _swf;
				if(navigator.appName.indexOf("Microsoft")!=-1){
					_swf=window[_swfID];
				}else{
					_swf=document[_swfID];
				}
				return _swf;
			}
			pwrd.createItem=function(_itemName,_object,_type){
				if(_type==undefined){
					_type=typeof(_object);
				}
				switch(_type){
					case "object":
						var _attStr="";
						var _childXMLList="";
						for(var _subVarName in _object){
							var subObj=_object[_subVarName];
							if(subObj instanceof Array){
								var subType="array";
							}else{
								var subType=typeof(subObj);
							}
							var subXML=pwrd.createItem(_subVarName,subObj,subType);
							switch(subType){
								case "object":
								case "array":
									_childXMLList+=subXML;
								break;
								default:
									_attStr+=subXML;
								break;
							}
						}
						if(_childXMLList){
							return "<"+_itemName+_attStr+">"+_childXMLList+"</"+_itemName+">";
						}
						return "<"+_itemName+_attStr+"/>";
					break;
					case "array":
						var _xmlStr="";
						for(var _i in _object){
							_xmlStr+=pwrd.createItem(_itemName,_object[_i]);
						}
						return _xmlStr;
					break;
					default:
						return " "+_itemName+"='"+_object.toString()+"'";
					break;
				}
				return null;
			}
		]]></script>
	}
	
}