/***
URLIDBtn 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年5月27日 21:39:20
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.ui{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	import zero.net.GotoURL;
	import ui.Btn;
	public class URLIDBtn extends IDBtn{
		public var xmlName:String
		public function URLIDBtn(_xmlName:String=null){
			if(_xmlName){
				xmlName=_xmlName;
			}else{
				var className:String=getQualifiedClassName(this);
				xmlName=className.charAt(0).toLowerCase()+className.substr(1);
				if(getId(className)>=0){
					xmlName=xmlName.substr(0,xmlName.length-id.toString().length);
				}
			}
			release=gotoURL;
		}
		public function gotoURL():void{
			GotoURL.goto(
				(getDefinitionByName("zero.ui.BaseLoadURLPoj") as Object).xml[xmlName][id]
			);
		}
	}
}

