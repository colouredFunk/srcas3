/***
AdvanceItem_info 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月26日 22:48:13
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

//The item_info entry consists of item_count elements that are interpreted as key/value pairs of indices into the
//string table of the constant pool. If the value of key is zero, this is a keyless entry and only carries a value.

//item_info
//{
//	u30 key
//	u30 value
//}

package zero.swf.avm2.advances{
	import zero.swf.avm2.Item_info;
	
	public class AdvanceItem_info extends Advance{
		
		public var key:String;
		public var value:String;
		//
		public function AdvanceItem_info(){
			
		}
		
		public function initByInfo(item_info:Item_info):void{
			key=AdvanceABC.currInstance.getInfoByIdAndVName(item_info.key,AdvanceABC.STRING);
			value=AdvanceABC.currInstance.getInfoByIdAndVName(item_info.value,AdvanceABC.STRING);
		}
		public function toInfo():Item_info{
			var item_info:Item_info=new Item_info();
			
			item_info.key=AdvanceABC.currInstance.getIdByInfoAndVName(key,AdvanceABC.STRING);
			item_info.value=AdvanceABC.currInstance.getIdByInfoAndVName(value,AdvanceABC.STRING);
			
			return item_info;
		}
		
		////
		CONFIG::toXMLAndInitByXML {
		public function toXML():XML{
			return <Item_info
				key={key}
				value={value}
			/>;
		}
		public function initByXML(xml:XML):void{
			key=xml.@key.toString();
			value=xml.@value.toString();
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