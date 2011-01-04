/***
DoABCWithoutFlagsAndName 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年11月8日 14:48:24 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
//DoABCWithoutFlagsAndName
//Field 		Type 					Comment
//Header 		RECORDHEADER 			Tag type = 72
//ABCData 		BYTE[] 					A block of .abc bytecode to be parsed by the ActionScript 3.0 virtual machine, up to the end of the tag.
package zero.swf.tagBodys{
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import zero.swf.avm2.AVM2Obj;
	public class DoABCWithoutFlagsAndName{
		public static function setDecodeABC(_ABCClass:Class):void{
			//DoABCWithoutFlagsAndName.setDecodeABC(ABCFileWithSimpleConstant_pool)
			//DoABCWithoutFlagsAndName.setDecodeABC(ABCFile)
			//DoABCWithoutFlagsAndName.setDecodeABC(AdvanceABC)
			
			if(_ABCClass){
				switch(getQualifiedClassName(_ABCClass)){
					case "zero.swf.avm2::ABCFileWithSimpleConstant_pool":
					case "zero.swf.avm2::ABCFile":
					case "zero.swf.avm2.advances::AdvanceABC":
						ABCClass=_ABCClass;
					break;
					default:
						throw new Error("未知 ABCClass: "+ABCClass);
					break;
				}
			}else{
				ABCClass=null;
			}
		}
		
		private static var ABCClass:Class;
		
		public static function getDecodeABCLevel():int{
			switch(getQualifiedClassName(ABCClass)){
				case "zero.swf.avm2::ABCFileWithSimpleConstant_pool":
					return 0;
				break;
				case "zero.swf.avm2::ABCFile":
					return 1;
				break;
				case "zero.swf.avm2.advances::AdvanceABC":
					return 2;
				break;
			}
			return -1;
		}
		//
		
		public var abc:*;
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			abc=new ABCClass();
			return abc.initByData(data,offset,endOffset);
		}
		public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			data.writeBytes(abc.toData());
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		public function toXML(xmlName:String):XML{
			var xml:XML=<{xmlName} class="DoABCWithoutFlagsAndName"/>;
			xml.appendChild(abc.toXML("abc"));
			return xml;
		}
		public function initByXML(xml:XML):void{
			var abcXML:XML=xml.abc[0];
			var className:String=abcXML["@class"].toString();
			switch(className){
				case "ABCFileWithSimpleConstant_pool":
				case "ABCFile":
					abc=new (getDefinitionByName("zero.swf.avm2."+className))();
				break;
				case "AdvanceABC":
					abc=new (getDefinitionByName("zero.swf.avm2.advances."+className))();
				break;
				default:
					throw new Error("未知 className: "+className);
				break;
			}
			abc.initByXML(abcXML);
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
