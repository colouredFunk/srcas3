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
		public static function setDecodeABC(_ABCFileClass:Class,_AdvanceABCClass:Class=null):void{
			//DoABCWithoutFlagsAndName.setDecodeABC(ABCFileWithSimpleConstant_pool)
			//DoABCWithoutFlagsAndName.setDecodeABC(ABCFile)
			//DoABCWithoutFlagsAndName.setDecodeABC(ABCFile,AdvanceABC)
			
			ABCFileClass=_ABCFileClass;
			if(ABCFileClass){
				switch(getQualifiedClassName(ABCFileClass)){
					case "zero.swf.avm2::ABCFileWithSimpleConstant_pool":
						AdvanceABCClass=null;
					break;
					case "zero.swf.avm2::ABCFile":
						AdvanceABCClass=_AdvanceABCClass;
						if(AdvanceABCClass){
							if(getQualifiedClassName(AdvanceABCClass)=="zero.swf.avm2.advances::AdvanceABC"){
							}else{
								throw new Error("AdvanceABCClass 只允许是 zero.swf.avm2.advances::AdvanceABC，而不能是: "+ABCFileClass);
							}
						}
					break;
					default:
						throw new Error("未知 ABCFileClass: "+ABCFileClass);
					break;
				}
			}else{
				ABCFileClass=null;
				AdvanceABCClass=null;
			}
		}
		public static function getDecodeABCLevel():int{
			switch(getQualifiedClassName(ABCFileClass)){
				case "zero.swf.avm2::ABCFileWithSimpleConstant_pool":
					return 0;
				break;
				case "zero.swf.avm2::ABCFile":
					if(AdvanceABCClass){
						return 2;
					}
					return 1;
				break;
			}
			return -1;
		}
		private static var ABCFileClass:Class;
		private static var AdvanceABCClass:Class;
		
		public var ABCData:*;
		public var advanceABC:*;
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			ABCData=new ABCFileClass();
			var offset:int=ABCData.initByData(data,offset,endOffset);
			if(AdvanceABCClass){
				advanceABC=new AdvanceABCClass();
				advanceABC.initByABCFile(ABCData);
			}
			return offset;
		}
		public function toData():ByteArray{
			if(advanceABC){
				ABCData=new (getDefinitionByName("zero.swf.avm2.ABCFile"))();
				advanceABC.getABCFile(ABCData);
			}
			var data:ByteArray=new ByteArray();
			data.writeBytes(ABCData.toData());
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		public function toXML(xmlName:String):XML{
			var xml:XML=<{xmlName} class="DoABCWithoutFlagsAndName"/>;
			if(advanceABC){
				xml.appendChild(advanceABC.toXML("advanceABC"));
			}else{
				xml.appendChild(ABCData.toXML("ABCData"));
			}
			return xml;
		}
		public function initByXML(xml:XML):void{
			if(xml.advanceABC[0]){
				advanceABC=new (getDefinitionByName("zero.swf.avm2.advances.AdvanceABC"))();
				advanceABC.initByXML(xml.advanceABC[0]);
			}else{
				var ABCDataXML:XML=xml.ABCData[0];
				ABCData=new (getDefinitionByName("zero.swf.avm2."+ABCDataXML["@class"].toString()))();
				ABCData.initByXML(ABCDataXML);
			}
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
