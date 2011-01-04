/***
BtnAni 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年4月29日 22:42:36
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.ui{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	public class BtnAni{
		private static const aniV:Vector.<BtnAni>=new Vector.<BtnAni>();
		
		private static var ani:MovieClip=new MovieClip();
		private static var child:Sprite;
		public static function updateAni(_ani:MovieClip):void{
			//trace("ani="+ani);
			ani=_ani;
			child=ani.getChildAt(0) as Sprite;
			ani.gotoAndStop(1);
		}
		public static function updateAll():void{
			for each(var ani:BtnAni in aniV){
				ani.setState(ani.currentFrame);
			}
		}
		
		public var currentLabel:String;
		public var currentFrame:int;
		
		private var sp:Sprite;
		public function BtnAni(_sp:Sprite):void{
			sp=_sp;
			if(sp.root){
				aniV[aniV.length]=this;
				//trace("aniV.length="+aniV.length);
				sp.addEventListener(Event.REMOVED_FROM_STAGE,removed);
			}else{
				sp.addEventListener(Event.ADDED_TO_STAGE,added);
			}
		}
		private function added(event:Event):void{
			sp.removeEventListener(Event.ADDED_TO_STAGE,added);
			sp.addEventListener(Event.REMOVED_FROM_STAGE,removed);
			aniV[aniV.length]=this;
			//trace("aniV.length="+aniV.length);
		}
		private function removed(event:Event):void{
			aniV.splice(aniV.indexOf(this),1);
			sp.removeEventListener(Event.REMOVED_FROM_STAGE,removed);
			//sp["ani"]=null;
			sp=null;
		}
		public function setState(frame:Object):void{
			if(sp){
				ani.gotoAndStop(frame);
				currentLabel=ani.currentLabel;
				currentFrame=ani.currentFrame;
				sp.transform.colorTransform=child.transform.colorTransform;
				sp.filters=child.filters.concat(ani.filters);
				//trace("sp.filters="+sp.filters);
			}
		}
		public function get currentLabels():Array{
			return ani.currentLabels;
		}
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