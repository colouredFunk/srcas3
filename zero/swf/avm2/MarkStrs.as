/***
MarkStrs 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年11月23日 19:56:42
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf.avm2{
	import flash.utils.Dictionary;
	public class MarkStrs{
		public var markStrDict:Dictionary;
		public var xmlDict:Dictionary;
		public var nsMark:Object;
		public var ns_setMark:Object;
		public var multinameMark:Object;
		public var methodMark:Object;
		public var metadataMark:Object;
		public var classDict:Dictionary;//使用 clazz.name 作为索引的 class 们
		public var newfunctionXMLV:Vector.<XML>;
		public function MarkStrs(){
			markStrDict=new Dictionary();
			xmlDict=new Dictionary();
			nsMark=new Object();
			ns_setMark=new Object();
			multinameMark=new Object();
			methodMark=new Object();
			metadataMark=new Object();
			classDict=new Dictionary();
			newfunctionXMLV=new Vector.<XML>();
		}
	}
}

