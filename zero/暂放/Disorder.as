/***
Disorder 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年11月30日 13:16:01
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	
	[Deprecated(replacement="Common.disorder 和 Common.getDisorderArr")]
	public class Disorder{
		public static function disorder(arr:*):void{
			//打乱
			var L:int=arr.length;
			var i:int=L;
			while(--i>=0){
				var ran:int=int(Math.random()*L);
				var temp:*=arr[i];
				arr[i]=arr[ran];
				arr[ran]=temp;
			}
		}
		public static function getDisorderArr(L:int):Array{
			var arr:Array=new Array();
			for(var i:int=0;i<L;i++){
				arr[i]=i;
			}
			disorder(arr);
			return arr;
		}
	}
}

