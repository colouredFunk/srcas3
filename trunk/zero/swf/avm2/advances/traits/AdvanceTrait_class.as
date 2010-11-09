/***
AdvanceTrait_class 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月27日 19:40:01
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

//trait_class
//{
//	u30 slot_id
//	u30 classi
//}

//The slot_id field is an integer from 0 to N and is used to identify a position in which this trait resides. A
//value of 0 requests the AVM2 to assign a position.

//The classi field is an index that points into the class array of the abcFile entry.

package zero.swf.avm2.advances.traits{
	import zero.swf.avm2.advances.Member;
	import zero.swf.avm2.advances.AdvanceABC;
	import zero.swf.avm2.advances.AdvanceClass;
	import zero.swf.avm2.traits.Trait_class;

	public class AdvanceTrait_class extends AdvanceTrait{
		
		private static const memberV:Vector.<Member>=Vector.<Member>([
			new Member("slot_id"),
			new Member("classi",Member.CLASS,{xmlUseMarkKey:true})
		]);
		
		public var slot_id:int;
		public var classi:AdvanceClass;
		
		public function AdvanceTrait_class(){
		}
		
		public function initByInfo(trait_class:Trait_class):void{
			initByInfo_fun(trait_class,memberV);
		}
		public function toInfo():Trait_class{
			var trait_class:Trait_class=new Trait_class();
			
			toInfo_fun(trait_class,memberV);
			
			return trait_class;
		}
		
		////
		CONFIG::toXMLAndInitByXML {
		public function toXML(xmlName:String):XML{
			return toXML_fun(memberV,xmlName);
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