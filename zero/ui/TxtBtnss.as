/***
TxtBtnss 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2009年11月10日 13:09:51
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.ui{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	public class TxtBtnss extends Sprite{
		public var onClickTxt:Function;
		public function TxtBtnss(){
			this.addEventListener(Event.ADDED_TO_STAGE,added);
			onClickTxt=trace;
		}
		private function added(event:Event):void{
			this.removeEventListener(Event.ADDED_TO_STAGE,added);
			this.addEventListener(Event.REMOVED_FROM_STAGE,removed);
			this.cacheAsBitmap=true;
		}
		private function removed(event:Event):void{
			this.removeEventListener(Event.REMOVED_FROM_STAGE,removed);
			onClickTxt=null;
		}
		public function init(
			textTable:Array,
			wid2:int,
			hei2:int,
			dw1:int=-1,
			w:int=-1,
			dw2:int=-1,
			dh2:int=-1,
			spliter:String=""
		):void{
			var t:int=getTimer();
			var i:int=this.numChildren;
			while(--i>=0){
				this.removeChildAt(i);
			}
			var y:int=0;
			var mainSp:Sprite=new Sprite();
			mainSp.x=wid2;
			mainSp.y=hei2;
			this.addChild(mainSp);
			for each(var arr:Array in textTable){
				var sp:Sprite=new Sprite();
				mainSp.addChild(sp);
				sp.y=y;
				var txtBtn:TxtBtn=new TxtBtn(arr[0],dw1);
				txtBtn.alpha=0.7;
				txtBtn.mouseEnabled=txtBtn.mouseChildren=false;
				sp.addChild(txtBtn);
				var txtBtns:TxtBtns=new TxtBtns();
				txtBtns.x=sp.width+1;
				if(spliter){
					txtBtns.init(arr[1].split(spliter),w,dw2,dh2);
				}else{
					txtBtns.init(arr[1],w,dw2,dh2);
				}
				sp.addChild(txtBtns);
				txtBtns.onClickTxt=clickTxt;
				y+=sp.height;
			}
			var g:Graphics=this.graphics;
			g.clear();
			//g.lineStyle(1,0xff0000);
			g.drawRect(0,0,wid2*2+mainSp.width,hei2*2+mainSp.height);
			trace("TxtBtnss.init time="+(getTimer()-t));
		}
		private function clickTxt(text:String):void{
			onClickTxt(text);
		}
	}
}

