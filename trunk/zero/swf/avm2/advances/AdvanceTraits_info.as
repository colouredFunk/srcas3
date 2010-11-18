/***
AdvanceTraits_info 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月25日 21:00:19
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

//A trait is a fixed property of an object or class; it has a name, a type, and some associated data. The
//traits_info structure bundles these data.

//traits_info
//{
//	u30 name
//	u8 kind
//	u8 data[]
//	u30 metadata_count
//	u30 metadata[metadata_count]
//}

//The name field is an index into the multiname array of the constant pool; it provides a name for the trait.
//The value can not be zero, and the multiname entry specified must be a QName.

//The kind field contains two four-bit fields. The lower four bits determine the kind of this trait. The
//upper four bits comprise a bit vector providing attributes of the trait. See the following tables and
//sections for full descriptions.

//The interpretation of the data field depends on the type of the trait, which is provided by the low four
//bits of the kind field. See below for a full description.

//The following table summarizes the trait types.
//Type 				Value
//Trait_Slot 		0
//Trait_Method 		1
//Trait_Getter 		2
//Trait_Setter 		3
//Trait_Class 		4
//Trait_Function 	5
//Trait_Const 		6

//These fields are present only if ATTR_Metadata is present in the upper four bits of the kind field.
//The value of the metadata_count field is the number of entries in the metadata array. That array
//contains indices into the metadata array of the abcFile.

//As previously mentioned the upper nibble of the kind field is used to encode attributes. A description of how
//the attributes are interpreted for each kind is outlined below. Any other combination of attribute with kind
//is ignored.
//Attributes 		Value
//ATTR_Final 		0x1 	Is used with Trait_Method, Trait_Getter and Trait_Setter. It marks a method that cannot be overridden by a sub-class
//ATTR_Override 	0x2 	Is used with Trait_Method, Trait_Getter and Trait_Setter. It marks a method that has been overridden in this class
//ATTR_Metadata 	0x4 	Is used to signal that the fields metadata_count and metadata follow the data field in the traits_info entry

package zero.swf.avm2.advances{
	import zero.swf.avm2.AVM2Obj;
	import zero.swf.avm2.Metadata_info;
	import zero.swf.avm2.Traits_info;
	import zero.swf.vmarks.ConstantKind;
	import zero.swf.vmarks.TraitAttributes;
	import zero.swf.vmarks.TraitTypes;

	public class AdvanceTraits_info extends Advance{
		
		public var name:AdvanceMultiname_info;
		public var kind_attributes:int;
		public var kind_trait_type:int;
		public var metadataV:Vector.<AdvanceMetadata_info>;
		
		private static const memberV:Vector.<Member>=Vector.<Member>([
			new Member("name",Member.MULTINAME_INFO),
			new Member("kind_attributes",null,{flagClass:TraitAttributes}),
			new Member("kind_trait_type",null,{kindClass:TraitTypes,kindVName:"typeV"}),
			new Member("metadata",Member.METADATA_INFO,{isList:true,curr:Member.CURR_CASE}),
		]);
		
		private static const trait_slot_memberV:Vector.<Member>=Vector.<Member>([
			new Member("slot_id"),
			new Member("type_name",Member.MULTINAME_INFO),
			new Member("vkind",null,{kindClass:ConstantKind}),
			new Member("vindex",null,{constKindName:"vkind"})//这里把 vkind 放在了 vindex 前面
		]);
		
		private static const trait_method_memberV:Vector.<Member>=Vector.<Member>([
			new Member("disp_id"),
			new Member("methodi",Member.METHOD)
		]);
		
		private static const trait_function_memberV:Vector.<Member>=Vector.<Member>([
			new Member("slot_id"),
			new Member("functioni",Member.METHOD)
		]);
		
		private static const trait_class_memberV:Vector.<Member>=Vector.<Member>([
			new Member("slot_id"),
			new Member("classi",Member.CLASS,{xmlUseMarkKey:true})
		]);
		
		public var slot_id:int;
		public var type_name:AdvanceMultiname_info;
		public var vindex:*;
		public var vkind:int;
		
		public var disp_id:int;
		public var methodi:AdvanceMethod;
		
		//public var slot_id:int;
		public var functioni:AdvanceMethod;
		
		//public var slot_id:int;
		public var classi:AdvanceClass;
		
		public function AdvanceTraits_info(){
		}
		
		public function cloneAsMethodTrait():AdvanceTraits_info{
			var traits_info:AdvanceTraits_info=new AdvanceTraits_info();
			
			traits_info.name=name;
			traits_info.kind_attributes=kind_attributes;
			traits_info.kind_trait_type=kind_trait_type;
			traits_info.metadataV=metadataV;
			
			traits_info.disp_id=disp_id;
			traits_info.methodi=methodi.clone();
			
			return traits_info;
		}
		
		public function initByInfo(advanceABC:AdvanceABC,traits_info:Traits_info):void{
			initByInfo_fun(advanceABC,traits_info,memberV,traits_info.kind_attributes&TraitAttributes.Metadata);
			//
			switch(kind_trait_type){
				case TraitTypes.Slot:
				case TraitTypes.Const:
					//trait_slot
					//{
					//	u30 slot_id
					//	u30 type_name
					//	u30 vindex
					//	u8 vkind
					//}
					
					//The slot_id field is an integer from 0 to N and is used to identify a position in which this trait resides. A
					//value of 0 requests the AVM2 to assign a position.
					
					//This field is used to identify the type of the trait. It is an index into the multiname array of the
					//constant_pool. A value of zero indicates that the type is the any type (*).
					
					//This field is an index that is used in conjunction with the vkind field in order to define a value for the
					//trait. If it is 0, vkind is empty; otherwise it references one of the tables in the constant pool, depending on
					//the value of vkind.
					//0 表示没有默认值的属性，例如：public var a:int;，这时不需要 vkind
					//否则表示有默认值的属性，例如：public var a:int=123;
					
					//This field exists only when vindex is non-zero. It is used to determine how vindex will be interpreted.
					//See the "Constant Kind" table above for details.
					
					//vindex 和 vkind 合起来很像 Option_detail，Option_detail 是用作函数参数的默认值
					
					initByInfo_fun(advanceABC,traits_info,trait_slot_memberV);
				break;
				case TraitTypes.Method:
				case TraitTypes.Getter:
				case TraitTypes.Setter:
					//trait_method
					//{
					//	u30 disp_id
					//	u30 method
					//}
					
					//The disp_id field is a compiler assigned integer that is used by the AVM2 to optimize the resolution of
					//virtual function calls. An overridden method must have the same disp_id as that of the method in the
					//base class. A value of zero disables this optimization.
					
					//The method field is an index that points into the method array of the abcFile entry.
					
					initByInfo_fun(advanceABC,traits_info,trait_method_memberV);
				break;
				case TraitTypes.Function:
					//trait_function
					//{
					//	u30 slot_id
					//	u30 function
					//}
					
					//The slot_id field is an integer from 0 to N and is used to identify a position in which this trait resides.
					//A value of 0 requests the AVM2 to assign a position.
					
					//The function field is an index that points into the method array of the abcFile entry.
					
					initByInfo_fun(advanceABC,traits_info,trait_function_memberV);
				break;
				case TraitTypes.Clazz:
					//trait_class
					//{
					//	u30 slot_id
					//	u30 classi
					//}
					
					//The slot_id field is an integer from 0 to N and is used to identify a position in which this trait resides. A
					//value of 0 requests the AVM2 to assign a position.
					
					//The classi field is an index that points into the class array of the abcFile entry.
					
					initByInfo_fun(advanceABC,traits_info,trait_class_memberV);
				break;
			}
			//
		}
		public function toInfo(advanceABC:AdvanceABC):Traits_info{
			var traits_info:Traits_info=new Traits_info();
			
			toInfo_fun(advanceABC,traits_info,memberV);
			
			switch(kind_trait_type){
				case TraitTypes.Slot:
				case TraitTypes.Const:
					toInfo_fun(advanceABC,traits_info,trait_slot_memberV);
				break;
				case TraitTypes.Method:
				case TraitTypes.Getter:
				case TraitTypes.Setter:
					toInfo_fun(advanceABC,traits_info,trait_method_memberV);
				break;
				case TraitTypes.Function:
					toInfo_fun(advanceABC,traits_info,trait_function_memberV);
				break;
				case TraitTypes.Clazz:
					toInfo_fun(advanceABC,traits_info,trait_class_memberV);
				break;
			}
			
			return traits_info;
		}
		
		////
		CONFIG::toXMLAndInitByXML {
		public function toXML(xmlName:String):XML{
			var xml:XML=toXML_fun(memberV,xmlName);
			
			switch(kind_trait_type){
				case TraitTypes.Slot:
				case TraitTypes.Const:
					toXML_fun(trait_slot_memberV,xml);
				break;
				case TraitTypes.Method:
				case TraitTypes.Getter:
				case TraitTypes.Setter:
					toXML_fun(trait_method_memberV,xml);
				break;
				case TraitTypes.Function:
					toXML_fun(trait_function_memberV,xml);
				break;
				case TraitTypes.Clazz:
					toXML_fun(trait_class_memberV,xml);
				break;
			}
			
			return xml;
		}
		public function initByXML(marks:Object,xml:XML):void{
			initByXML_fun(marks,xml,memberV);
			
			//
			switch(kind_trait_type){
				case TraitTypes.Slot:
				case TraitTypes.Const:
					//trace("kind="+xml.vindex[0].@kind.toString());
					initByXML_fun(marks,xml,trait_slot_memberV);
					//trace("vindex.kind="+vindex.kind);
				break;
				case TraitTypes.Method:
				case TraitTypes.Getter:
				case TraitTypes.Setter:
					initByXML_fun(marks,xml,trait_method_memberV);
				break;
				case TraitTypes.Function:
					initByXML_fun(marks,xml,trait_function_memberV);
				break;
				case TraitTypes.Clazz:
					initByXML_fun(marks,xml,trait_class_memberV);
				break;
			}
			//
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}

//

// 常忘正则表达式
// /^\s*|\s*$/					//前后空白						"\nabc d  e 哈 哈\t \r".replace(/^\s*|\s*$/g,"") === "abc d  e 哈 哈"
// /[\\\/:*?\"<>|]/				//不合法的windows文件名字符集		"\\\/:*?\"<>|\\\/:*哈 哈?\"<>|\\哈 \/:*?\"<>|".replace(/[\\\/:*?\"<>|]/g,"") === "哈 哈哈 "
// /[a-zA-Z_][a-zA-Z0-9_]*/		//合法的变量名(不考虑中文)
// value=value.replace(/[^a-zA-Z0-9_]/g,"").replace(/^[0-9]*/,"");//替换不合法的变量名
// 先把除字母数字下划线的字符去掉,再把开头的数字去掉
// 想不到怎样能用一个正则表达式搞定...

//正则表达式30分钟入门教程		http://www.unibetter.com/deerchao/zhengzhe-biaodashi-jiaocheng-se.htm
//正则表达式用法及实例			http://eskimo.blogbus.com/logs/29095458.html
//常用正则表达式					http://www.williamlong.info/archives/433.html

/*

//常用值

//常用语句块

*/