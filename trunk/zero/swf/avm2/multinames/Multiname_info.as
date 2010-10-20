/***
Multiname_info 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月17日 15:02:23
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
//A multiname_info entry is a variable length item that is used to define multiname entities used by the
//bytecode. There are many kinds of multinames. The kind field acts as a tag: its value determines how the
//loader should see the variable-length data field. The layout of the contents of the data field under a particular
//kind is described below by the multiname_kind_ structures.

//			multiname_info
//			{
//				u8 kind
//				u8 data[]
//			}

//Multiname Kind 		Value
//CONSTANT_QName 		0x07
//CONSTANT_QNameA 		0x0D
//CONSTANT_RTQName 		0x0F
//CONSTANT_RTQNameA 	0x10
//CONSTANT_RTQNameL 	0x11
//CONSTANT_RTQNameLA 	0x12
//CONSTANT_Multiname 	0x09
//CONSTANT_MultinameA 	0x0E
//CONSTANT_MultinameL 	0x1B
//CONSTANT_MultinameLA 	0x1C
//Those constants ending in "A" (such as CONSTANT_QNameA) represent the names of attributes.
package zero.swf.avm2.multinames{
	import zero.swf.BaseDat;
	public class Multiname_info extends BaseDat{
		public var kind:int;
		public function Multiname_info(){
		}
	}
}
