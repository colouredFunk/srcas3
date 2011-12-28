package akdcl.utils {
	import flash.xml.XMLDocument;
	import flash.xml.XMLNode;
	import flash.xml.XMLNodeType;

	public class XMLToObject {
		public var data:Object;
		private var doc:XMLDocument;

		public function XMLToObject(xml:XML = null){
			if (xml){
				this.doc = new XMLDocument(xml.toXMLString());
				data = decodeXML(this.doc.firstChild);
			}
		}

		public static function simpleType(val:Object):Object {
			var result:Object = val;
			if (val != null){
				if (val is String && String(val) == ""){
					result = val.toString();
				} else if (isNaN(Number(val)) || (val.charAt(0) == '0') || ((val.charAt(0) == '-') && (val.charAt(1) == '0')) || val.charAt(val.length - 1) == 'E'){
					var valStr:String = val.toString();
					var valStrLC:String = valStr.toLowerCase();
					if (valStrLC == "true"){
						result = true;
					} else if (valStrLC == "false"){
						result = false;
					} else {
						result = valStr;
					}
				} else {
					result = Number(val);
				}
			}
			return result;
		}

		public static function decodeXML(dataNode:XMLNode):Object {
			var result:Object;
			var isSimpleType:Boolean = false;
			if (dataNode == null){
				return null;
			}
			var children:Array = dataNode.childNodes;
			if (children.length == 1 && children[0].nodeType == XMLNodeType.TEXT_NODE){
				isSimpleType = true;
				result = XMLToObject.simpleType(children[0].nodeValue);
			} else if (children.length > 0){
				result = {};
				for (var i:uint = 0; i < children.length; i++){
					var partNode:XMLNode = children[i];
					if (partNode.nodeType != XMLNodeType.ELEMENT_NODE){
						continue;
					}
					var partName:String = getLocalName(partNode);
					var partObj:Object = decodeXML(partNode);
					var existing:Object = result[partName];
					if (existing != null){
						if (existing is Array){
							existing.push(partObj);
						} else {
							existing = [existing];
							existing.push(partObj);
							result[partName] = existing;
						}
					} else {
						result[partName] = partObj;
					}
				}
			}
			var attributes:Object = dataNode.attributes;
			for (var attribute:String in attributes){
				if (attribute == "xmlns" || attribute.indexOf("xmlns:") != -1){
					continue;
				}
				if (result == null){
					result = {};
				}
				if (isSimpleType && !(result is ComplexString)){
					result = new ComplexString(result.toString());
					isSimpleType = false;
				}
				result[attribute] = XMLToObject.simpleType(attributes[attribute]);
			}
			return result;
		}

		public static function getLocalName(xmlNode:XMLNode):String {
			var name:String = xmlNode.nodeName;
			var myPrefixIndex:int = name.indexOf(":");
			if (myPrefixIndex != -1){
				name = name.substring(myPrefixIndex + 1);
			}
			return name;
		}
	}
}
import akdcl.utils.XMLToObject

dynamic class ComplexString {
	public var value:String;

	public function ComplexString(val:String){
		super();
		value = val;
	}

	public function toString():String {
		return value;
	}

	public function valueOf():Object {
		return XMLToObject.simpleType(value);
	}
}