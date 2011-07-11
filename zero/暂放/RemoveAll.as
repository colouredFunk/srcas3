/***
RemoveAll 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月27日 18:16:39
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	
	[Deprecated(replacement="Common.removeAll")]
	public class RemoveAll{
		public static function removeAll(sp:Sprite):void{
			var i:int=sp.numChildren;
			while(--i>=0){
				sp.removeChildAt(i);
			}
		}
	}
}

