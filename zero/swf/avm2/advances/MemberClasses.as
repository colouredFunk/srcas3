/***
MemberClasses 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月28日 15:28:23
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf.avm2.advances{
	import zero.swf.avm2.Exception_info;
	import zero.swf.avm2.Instance_info;
	import zero.swf.avm2.Item_info;
	import zero.swf.avm2.Metadata_info;
	import zero.swf.avm2.Method_info;
	import zero.swf.avm2.Multiname_info;
	import zero.swf.avm2.Namespace_info;
	import zero.swf.avm2.Ns_set_info;
	import zero.swf.avm2.Option_detail;
	import zero.swf.avm2.Script_info;
	import zero.swf.avm2.Traits_info;
	import zero.swf.avm2.advances.traits.AdvanceTrait;
	import zero.swf.avm2.traits.Trait;

	public class MemberClasses{
		public static const classV:Vector.<Class>=Vector.<Class>([
			null,
			null,
			null,
			null,
			AdvanceNamespace_info,
			AdvanceNs_set_info,
			AdvanceMultiname_info,
			AdvanceMethod,
			AdvanceMetadata_info,
			AdvanceClass,
			AdvanceScript_info,
			AdvanceTraits_info,
			AdvanceTrait,
			AdvanceOption_detail,
			AdvanceItem_info,
			AdvanceException_info
		]);
		public static const vClassV:Vector.<Class>=Vector.<Class>([
			Vector.<int>,
			Vector.<int>,
			Vector.<Number>,
			Vector.<String>,
			Vector.<AdvanceNamespace_info>,
			Vector.<AdvanceNs_set_info>,
			Vector.<AdvanceMultiname_info>,
			Vector.<AdvanceMethod>,
			Vector.<AdvanceMetadata_info>,
			Vector.<AdvanceClass>,
			Vector.<AdvanceScript_info>,
			Vector.<AdvanceTraits_info>,
			Vector.<AdvanceTrait>,
			Vector.<AdvanceOption_detail>,
			Vector.<AdvanceItem_info>,
			Vector.<AdvanceException_info>
		]);
		
		
		public static const avm2ObjClassV:Vector.<Class>=Vector.<Class>([
			null,
			null,
			null,
			null,
			Namespace_info,
			Ns_set_info,
			Multiname_info,
			null,//Method_info,
			Metadata_info,
			null,//Instance_info,
			Script_info,
			Traits_info,
			Trait,
			Option_detail,
			Item_info,
			Exception_info
		]);
		public static const avm2ObjVClassV:Vector.<Class>=Vector.<Class>([
			Vector.<int>,
			Vector.<int>,
			Vector.<Number>,
			Vector.<String>,
			Vector.<Namespace_info>,
			Vector.<Ns_set_info>,
			Vector.<Multiname_info>,
			null,//Vector.<Method_info>,
			Vector.<Metadata_info>,
			null,//Vector.<Instance_info>,
			Vector.<Script_info>,
			Vector.<Traits_info>,
			Vector.<Trait>,
			Vector.<Option_detail>,
			Vector.<Item_info>,
			Vector.<Exception_info>
		]);
		
		/*
		private static const initValue:Boolean=firstInit();
		private static function firstInit():Boolean{
			trace("MemberClasses="+MemberClasses);//MemberClasses=null //- -
			var i:int=-1;
			for each(var memberType:String in Member.typeV){
				i++;
				MemberClasses[memberType]=classV[i];
				MemberClasses[memberType+"VClass"]=vClassV[i];
			}
			return true;
		}
		//*/
		
		/*
		private static const instance:MemberClasses=new MemberClasses();
		public function MemberClasses(){
			trace("MemberClasses="+MemberClasses);//MemberClasses=null //- -
			if(instance){
				throw new Error("这东西不是用来 new 的...");
			}
			var i:int=-1;
			for each(var memberType:String in Member.typeV){
				i++;
				MemberClasses[memberType]=classV[i];
				MemberClasses[memberType+"VClass"]=vClassV[i];
			}
		}
		//*/
		
		public static function firstInit():void{
			var i:int=-1;
			for each(var memberType:String in Member.typeV){
				i++;
				MemberClasses[memberType]=classV[i];
				MemberClasses[memberType+"VClass"]=vClassV[i];
				MemberClasses[memberType+"AVM2ObjClass"]=avm2ObjClassV[i];
				MemberClasses[memberType+"AVM2ObjVClass"]=avm2ObjVClassV[i];
			}
		}
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