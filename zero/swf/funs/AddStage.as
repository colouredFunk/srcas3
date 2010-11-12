/***
AddStage 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年11月12日 20:30:08
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf.funs{
	import zero.swf.*;
	import zero.swf.avm2.*;
	import zero.swf.avm2.advances.*;
	import zero.swf.tagBodys.*;
	import zero.swf.vmarks.*;
	
	public class AddStage{
		public static function addStageToSWF(swf:SWF2,stageName:String):void{
			for each(var tag:Tag in swf.tagV){
				switch(tag.type){
					case TagType.DoABC:
					case TagType.DoABCWithoutFlagsAndName:
						addStageToABC((tag.getBody() as DoABCWithoutFlagsAndName).advanceABC,stageName);
					break;
				}
			}
		}
		public static function addStageToABC(advanceABC:AdvanceABC,stageName:String):void{
			for each(var multiname_info:AdvanceMultiname_info in advanceABC.multiname_infoV){
				if(multiname_info){
					trace("multiname_info.name="+multiname_info.name);
					if(multiname_info.name=="stage"){
						if(
							multiname_info.kind==MultinameKind.QName
							&&
							multiname_info.ns.kind==NamespaceKind.PackageNamespace
							&&
							multiname_info.ns.name==""
						){
							multiname_info.kind=MultinameKind.Multiname;
							multiname_info.ns_set=new AdvanceNs_set_info();
							multiname_info.ns_set.nsV=new Vector.<AdvanceNamespace_info>();
							multiname_info.ns_set.nsV[0]=new AdvanceNamespace_info();
							multiname_info.ns_set.nsV[0].kind=NamespaceKind.PackageNamespace;
							multiname_info.ns_set.nsV[0].name="";
							//multiname_info.name=stageName;
						}
					}
				}
			}
			/*
			for each(var clazz:AdvanceClass in advanceABC.classV){
				for each(var traits_info:AdvanceTraits_info in clazz.itraits_infoV){
					trace(TraitTypes.typeV[traits_info.kind_trait_type]);
					switch(traits_info.kind_trait_type){
						case TraitTypes.Slot:
							//trace(traits_info.name.toXML("name"));
							break;
						case TraitTypes.Method:
							traits_info.name.name="混淆";
							break;
						case TraitTypes.Getter:
						case TraitTypes.Setter:
						case TraitTypes.Clazz:
						case TraitTypes.Function:
						case TraitTypes.Const:
						break;
					}
				}
			}
			*/
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