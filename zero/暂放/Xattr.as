/***
Xattr 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年11月24日 11:46:35
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero{
	[Deprecated(replacement="Common.esc_xattr 和 Common.unesc_xattr")]
	public class Xattr{
		private static var stringXML:XML=<string/>;
		public static function esc_xattr(str:String):String{
			if(str){
				stringXML.@value=str;
				str=stringXML.toXMLString().replace("<string value=\"","");
				return str.substr(0,str.length-3).replace(/>/g,"&gt;");
			}
			return str;
		}
		public static function unesc_xattr(str:String):String{
			if(str){
				return new XML("<string value=\""+str+"\"/>").@value.toString();
			}
			return str;
		}
		
		//var stringXML:XML;
		//
		//stringXML=<string value="#"/>
		//trace(stringXML.toXMLString());//输出：<string value="#"/>
		//trace(stringXML.toXMLString().replace(/^<string value=(".*")\/>$/,"$1"));//输出："#"
		//
		//stringXML=<string value=""/>
		//trace(stringXML.toXMLString());//输出：<string value=""/>
		//trace(stringXML.toXMLString().replace(/^<string value=(".*")\/>$/,"$1"));//输出：<string value=""/> (出错)
		
	}
}

