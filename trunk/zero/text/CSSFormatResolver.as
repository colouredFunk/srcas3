/***
CSSFormatResolver 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月11日 20:58:06
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.text{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	
	import flashx.textLayout.container.*;
	import flashx.textLayout.conversion.*;
	import flashx.textLayout.elements.*;
	import flashx.textLayout.formats.*;
	
	public class CSSFormatResolver implements IFormatResolver{
		private var csss:Object;
		public function CSSFormatResolver(styleXML:XML){
			csss=new Object();
			var styleStr:String=styleXML.toString();
			var cssElementsArr:Array=styleStr.match(/\{[\s\S]*?\}/g);
			//trace(cssElementsArr);
			var cssClassNameStrArr:Array=styleStr.split(/\{[\s\S]*?\}/);
			var cssElementsId:int=0;
			for each(var cssClassNameStr:String in cssClassNameStrArr){
				var cssClassName:String=cssClassNameStr.replace(/^\s*|\s*$/g,"");
				if(cssClassName){
					//trace("cssClassName="+cssClassName);
					csss[cssClassName]=new CSSFormat(cssElementsArr[cssElementsId++].replace(/\{\}/g,""));
				}
			}
		}
		public function resolveFormat(elem:Object):ITextLayoutFormat{
			//trace("resolveFormat elem="+elem);
			var cssClassName:String=elem.getStyle("class");
			if(cssClassName){
				//trace("resolveFormat elem="+elem);
				//trace("resolveFormat cssClassName="+cssClassName);
				var cssFormat:CSSFormat=csss[cssClassName]||csss["."+cssClassName]||csss["#"+cssClassName];
				if(cssFormat){
					if(cssFormat.backgroundColor==null){
					}else{
						if(elem is SpanElement){
							
						}else{
							trace("貌似只有 span 支持 backgroundColor ?- -");
						}
					}
				}
				return csss[cssClassName]||csss["."+cssClassName]||csss["#"+cssClassName];
			}
			return null;
		}
		public function resolveUserFormat(elem:Object,userStyle:String):*{
			//trace("resolveUserFormat elem="+elem);
			return null;
		}
		public function invalidateAll(tf:TextFlow):void{
			//trace("invalidateAll tf="+tf);
		}
		public function invalidate(target:Object):void{
			//trace("invalidate target="+target);
		}
		public function getResolverForNewFlow(oldFlow:TextFlow,newFlow:TextFlow):IFormatResolver{
			//trace("getResolverForNewFlow");
			return this;
		}
	}
}

