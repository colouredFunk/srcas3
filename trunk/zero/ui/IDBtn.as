/***
IDBtn 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年5月12日 11:39:20
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.ui{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	import ui.Btn;
	public class IDBtn extends Btn{
		public var id:int;
		public function IDBtn(){
			id=getId(getQualifiedClassName(this));
			if(id==-1){
				trace("IDBtn 找不到id: "+this);
			}
		}
		public static function getId(str:String):int{
			var numStr:String=str.replace(/.*?(\d+$)/,"$1");
			if(numStr){
				var id:int=int(numStr);
				if(id.toString()==numStr){
					return id;
				}
			}
			return -1;
		}
	}
}

