/***
ForEachTraits 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年11月29日 10:16:32
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf.funs{
	import flash.utils.Dictionary;
	
	import zero.Outputer;
	import zero.swf.*;
	import zero.swf.avm2.*;
	import zero.swf.avm2.advances.*;
	import zero.swf.tagBodys.*;
	import zero.swf.vmarks.*;
	
	public class ForEachTraits{
		public static function forEachTraits(
			swf:SWF2,
			className:String,
			traitsNameArr:Array,
			fun:Function
		):void{
			DoABCWithoutFlagsAndName.setDecodeABC(AdvanceABC);
			var tag:Tag,advanceABC:AdvanceABC,clazz:AdvanceClass;
			var traitsNameMark:Object=new Object();
			for each(var traitsName:String in traitsNameArr){
				traitsNameMark["~"+traitsName]=true;
			}
			for each(tag in swf.tagV){
				switch(tag.type){
					case TagType.DoABC:
					case TagType.DoABCWithoutFlagsAndName:
						advanceABC=(tag.getBody() as DoABCWithoutFlagsAndName).abc as AdvanceABC
						for each(clazz in advanceABC.clazzV){
							if(
								(
									clazz.name.ns.name
									?
									clazz.name.ns.name+"."+clazz.name.name
									:
									clazz.name.name
								)==className
							){
								var i:int;
								i=clazz.itraits_infoV.length;
								while(--i>=0){
									traitsName=clazz.itraits_infoV[i].name.name;
									//trace("traitsName="+traitsName);
									if(traitsNameMark["~"+traitsName]){
										trace("traitsName="+traitsName);
										//clazz.itraits_infoV.splice(i,1);
										fun(clazz,clazz.itraits_infoV,i,traitsName);
									}
								}
								i=clazz.ctraits_infoV.length;
								while(--i>=0){
									traitsName=clazz.ctraits_infoV[i].name.name;
									//trace("traitsName="+traitsName);
									if(traitsNameMark["~"+traitsName]){
										trace("traitsName="+traitsName);
										//clazz.ctraits_infoV.splice(i,1);
										fun(clazz,clazz.ctraits_infoV,i,traitsName);
									}
								}
								DoABCWithoutFlagsAndName.setDecodeABC(null);
								return;
							}
						}
					break;
				}
			}
			throw new Error("找不到 class: "+className);
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