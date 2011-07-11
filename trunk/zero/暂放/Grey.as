/***
Grey 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月14日 21:42:51
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	import flash.filters.ColorMatrixFilter;
	
	[Deprecated(replacement="Common.setGrey")]
	public class Grey{
		public static function setEnabled(obj:InteractiveObject,enabled:Boolean):void{
			if(enabled){
				obj.mouseEnabled=true;
				obj.filters=null;
			}else{
				obj.mouseEnabled=false;
				obj.filters=[new ColorMatrixFilter([0.3086000084877014,0.6093999743461609,0.0820000022649765,0,0,0.3086000084877014,0.6093999743461609,0.0820000022649765,0,0,0.3086000084877014,0.6093999743461609,0.0820000022649765,0,0,0,0,0,1,0])];
			}
		}
	}
}

