﻿/***
AdvanceNamespace_info 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月24日 15:05:08 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
//A namespace_info entry defines a namespace. Namespaces have string names, represented by indices into the
//string array, and kinds. User-defined namespaces have kind CONSTANT_Namespace or
//CONSTANT_ExplicitNamespace and a non-empty name. System namespaces have empty names and one of the
//other kinds, and provides a means for the loader to map references to these namespaces onto internal entities.

//A single byte defines the type of entry that follows, thus identifying how the name field should be interpreted by the loader. 
//The name field is an index into the string section of the constant pool.
//name是在 constant_pool.string_v 中的id
//A value of zero denotes an empty string.
//0 表示 ""
//The table below lists the legal values for kind.
//Namespace Kind 				Value
//CONSTANT_Namespace 			0x08
//CONSTANT_PackageNamespace 	0x16
//CONSTANT_PackageInternalNs 	0x17
//CONSTANT_ProtectedNamespace 	0x18
//CONSTANT_ExplicitNamespace 	0x19
//CONSTANT_StaticProtectedNs 	0x1A
//CONSTANT_PrivateNs 			0x05

//			namespace_info
//			{
//				u8 kind
//				u30 name
//			}
package zero.swf.avm2.advances{
	import zero.swf.avm2.Namespace_info;
	import zero.swf.vmarks.NamespaceKind;
	public class AdvanceNamespace_info extends Advance{
		
		public static const memberV:Vector.<Member>=Vector.<Member>([
			new Member("kind",null,{kindClass:NamespaceKind}),
			new Member("name",Member.STRING)
		]);
		
		public var kind:int;
		public var name:String;
		//
		public function AdvanceNamespace_info(){
		}
		
		public function initByInfo(advanceABC:AdvanceABC,namespace_info:Namespace_info):void{
			if(namespace_info){
				initByInfo_fun(advanceABC,namespace_info,memberV);
			}else{
				trace("namespace_info="+namespace_info);
			}
		}
		public function toInfoId(advanceABC:AdvanceABC):int{
			if(kind){
				var namespace_info:Namespace_info=new Namespace_info();
				toInfo_fun(advanceABC,namespace_info,memberV);
				
				//--
				advanceABC.abcFile.namespace_infoV.push(namespace_info);
				return advanceABC.abcFile.namespace_infoV.length-1;
			}
			trace("namespace_info toInfoId: 0");
			return 0;
		}
	}
}