/***
MusicPlayer_Item
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年11月02日 11:46:49
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.works{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	import ui.Btn;
	
	import zero.getfonts.GetFont;
	
	public class MusicPlayer_Item extends Btn{
		
		public var label:Sprite;
		public var time:Sprite;
		
		private var onClickThis:Function;
		
		public function MusicPlayer_Item(){
		}
		public function initXML(xml:XML,_onClickThis:Function):void{
			onClickThis=_onClickThis;
			if(xml.@href.toString()||xml.@js.toString()){
				this.href=xml;
				release=null;
			}else{
				this.href=null;
				release=clickThis;
			}
			
			GetFont.initTxt(label["txt"],xml.label[0]);
			GetFont.initTxt(time["txt"],xml.time[0]);
		}
		public function clear():void{
			onClickThis=null;
		}
		private function clickThis():void{
			if(onClickThis==null){
			}else{
				onClickThis(this);
			}
		}
	}
}