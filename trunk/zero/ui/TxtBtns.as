/***
TxtBtns 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2009年10月16日 11:16:39
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.ui{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	public class TxtBtns extends Sprite{
		public var onClickTxt:Function;
		public var w:int;
		public var dw:int;
		public var dh:int;
		public function TxtBtns(){
			this.addEventListener(Event.ADDED_TO_STAGE,added);
			w=30;
			dw=19;//18+1
			dh=19;//18+1
		}
		private function added(event:Event):void{
			this.removeEventListener(Event.ADDED_TO_STAGE,added);
			this.addEventListener(Event.REMOVED_FROM_STAGE,removed);
		}
		private function removed(event:Event):void{
			this.removeEventListener(Event.REMOVED_FROM_STAGE,removed);
			onClickTxt=null;
		}
		public function init(textsOrArr:*,_w:int=-1,_dw:int=-1,_dh:int=-1):void{
			w=_w>0?_w:w;
			dw=_dw>0?_dw:dw;
			dh=_dh>0?_dh:dh;
			var i:int=this.numChildren;
			while(--i>=0){
				this.removeChildAt(i);
			}
			if(textsOrArr){
				var x:int=0;
				var y:int=0;
				if(textsOrArr is String){
					textsOrArr=textsOrArr.split("");
				}
				for each(var text:String in textsOrArr){
					var txtBtn:TxtBtn=new TxtBtn(text,dw-1);
					txtBtn.x=x*dw;
					txtBtn.y=y*dh;
					this.addChild(txtBtn);
					txtBtn.onClick=clickTxt;
					
					if(++x>=w){
						x=0;
						y++;
					}
				}
			}
		}
		private function clickTxt(text:String):void{
			onClickTxt(text);
		}
	}
}

