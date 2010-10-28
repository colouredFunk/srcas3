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
	import zero.swf.avm2.advances.traits.AdvanceTrait;
	import zero.swf.avm2.advances.traits.AdvanceTraitTypes;
	import zero.swf.vmarks.TraitAttributes;
	import zero.swf.vmarks.TraitTypes;

	public class AdvanceTraits_info extends Advance{
		
		private static const memberV:Vector.<Member>=Vector.<Member>([
			new Member("name",Member.MULTINAME_INFO),
			new Member("kind_attributes",null,{flagClass:TraitAttributes}),
			new Member("kind_trait_type",null,{kindClass:TraitTypes,kindVName:"typeV"}),
			new Member("trait",Member.TRAIT,{classV:AdvanceTraitTypes.classV,classVIdName:"kind_trait_type"}),
			new Member("metadata",Member.METADATA_INFO,{isList:true,curr:Member.CURR_CASE}),
		]);
		
		public var name:AdvanceMultiname_info;
		public var kind_attributes:int;
		public var kind_trait_type:int;
		public var trait:AdvanceTrait;
		public var metadataV:Vector.<AdvanceMetadata_info>;
		
		public function AdvanceTraits_info(){
		}
		
		public function initByInfo(traits_info:Traits_info):void{
			initByInfo_fun(traits_info,memberV,traits_info.kind_attributes&TraitAttributes.Metadata);
		}
		public function toInfo():Traits_info{
			var traits_info:Traits_info=new Traits_info();
			
			toInfo_fun(traits_info,memberV);
			
			return traits_info;
		}
		
		////
		CONFIG::toXMLAndInitByXML {
		public function toXML():XML{
			return toXML_fun(memberV);
		}
		public function initByXML(xml:XML):void{
			initByXML_fun(xml,memberV);
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