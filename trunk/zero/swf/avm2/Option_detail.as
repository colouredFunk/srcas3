/***
Option_detail 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月23日 15:15:48 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
//option_detail
//{
//	u30 val
//	u8 kind
//}

//Each optional value consists of a kind field that denotes the type of value represented, and a val field that is an
//index into one of the array entries of the constant pool. The correct array is selected based on the kind.
//Constant Kind 				Value 	Entry
//CONSTANT_Int 					0x03 	integer
//CONSTANT_UInt 				0x04 	uinteger
//CONSTANT_Double 				0x06 	double
//CONSTANT_Utf8 				0x01 	string
//CONSTANT_True 				0x0B 	-
//CONSTANT_False 				0x0A 	-
//CONSTANT_Null 				0x0C 	-
//CONSTANT_Undefined 			0x00 	-
//CONSTANT_Namespace 			0x08 	namespace
//CONSTANT_PackageNamespace 	0x16 	namespace
//CONSTANT_PackageInternalNs 	0x17 	Namespace
//CONSTANT_ProtectedNamespace 	0x18 	Namespace
//CONSTANT_ExplicitNamespace 	0x19 	Namespace
//CONSTANT_StaticProtectedNs 	0x1A 	Namespace
//CONSTANT_PrivateNs 			0x05 	namespace

//很像 Trait_slot 的 vindex 和 vkind 合起来
package zero.swf.avm2{
	import zero.swf.vmarks.ConstantKind;
	import flash.utils.ByteArray;
	public class Option_detail extends AVM2Obj{
		public var val:int;								//u30
		public var kind:int;							//u8
		//
		override public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){val=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{val=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{val=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{val=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{val=data[offset++];}
			//val
			kind=data[offset++];
			return offset;
		}
		override public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			var offset:int=0;
			if(val>>>7){if(val>>>14){if(val>>>21){if(val>>>28){data[offset++]=(val&0x7f)|0x80;data[offset++]=((val>>>7)&0x7f)|0x80;data[offset++]=((val>>>14)&0x7f)|0x80;data[offset++]=((val>>>21)&0x7f)|0x80;data[offset++]=val>>>28;}else{data[offset++]=(val&0x7f)|0x80;data[offset++]=((val>>>7)&0x7f)|0x80;data[offset++]=((val>>>14)&0x7f)|0x80;data[offset++]=val>>>21;}}else{data[offset++]=(val&0x7f)|0x80;data[offset++]=((val>>>7)&0x7f)|0x80;data[offset++]=val>>>14;}}else{data[offset++]=(val&0x7f)|0x80;data[offset++]=val>>>7;}}else{data[offset++]=val;}
			//val
			data[offset++]=kind;
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		override public function toXML():XML{
			return <Option_detail
				val={val}
				kind={ConstantKind.kindV[kind]}
			/>;
		}
		override public function initByXML(xml:XML):void{
			val=int(xml.@val.toString());
			kind=ConstantKind[xml.@kind.toString()];
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
