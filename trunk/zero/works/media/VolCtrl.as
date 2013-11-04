/***
VolCtrl
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；已婚（单身美女们没机会了~~）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2013年11月04日 12:03:39
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.works.media{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	import ui.Btn;
	
	public class VolCtrl extends Sprite{
		
		private var volMaskShapeWid0:int;
		
		private var onUpdateVol:Function;
		
		public var laba:Btn;
		public var volBtn:Btn;
		private var volume:Number;
		
		private var on:Boolean;
		private var oldVolume:Number;
		
		public function VolCtrl(){
			on=true;
		}
		
		public function init(_volume:Number,_onUpdateVol:Function):void{
			volume=_volume;
			clear();
			laba.release=clickLaba;
			if(volMaskShapeWid0>0){
			}else{
				if(volBtn){
					volBtn.mouseChildren=true;
					volMaskShapeWid0=volBtn["maskShape"].width;
					updateBtnVol();
					volBtn.addEventListener(MouseEvent.MOUSE_DOWN,startCtrlVol);
				}
			}	
			onUpdateVol=_onUpdateVol;
		}
		
		public function clear():void{
			if(volBtn){
				volBtn.removeEventListener(MouseEvent.MOUSE_DOWN,startCtrlVol);
			}
			onUpdateVol=null;
		}
		
		private function startCtrlVol(...args):void{
			stage.addEventListener(MouseEvent.MOUSE_UP,stopCtrlVol);
			this.addEventListener(Event.ENTER_FRAME,ctrlVol);
		}
		
		private function ctrlVol(...args):void{
			if(volBtn){
				var _wid:int=volBtn.mouseX-volBtn["maskShape"].x;
				if(_wid>1){
					if(_wid>volMaskShapeWid0){
						_wid=volMaskShapeWid0;
					}
					volume=(_wid-1)/(volMaskShapeWid0-1);
				}else{
					_wid=1;
					volume=0;
				}
			}
			on=true;
			updateBtnVol();
			if(onUpdateVol==null){
			}else{
				onUpdateVol(volume);
			}
		}
		
		private function updateBtnVol():void{
			if(volBtn){
				volBtn["maskShape"].width=1+volume*(volMaskShapeWid0-1);
				if(volBtn.hasOwnProperty("thumb")){
					volBtn["thumb"].x=volBtn["maskShape"].x+volBtn["maskShape"].width;
				}
				if(laba.hasOwnProperty("gra")){
					if(laba["gra"].totalFrames>1){
						if(volume>0){
							laba["gra"].gotoAndStop(2+int((laba["gra"].totalFrames-2)*volume));
						}else{
							laba["gra"].gotoAndStop(1);
						}
					}
				}
			}
		}
		private function stopCtrlVol(...args):void{
			stage.removeEventListener(MouseEvent.MOUSE_UP,stopCtrlVol);
			this.removeEventListener(Event.ENTER_FRAME,ctrlVol);
		}
		
		private function clickLaba():void{
			if(on){
				oldVolume=volume;
				volume=0;
				on=false;
			}else{
				volume=oldVolume;
				on=true;
			}
			//trace("on="+on);
			//trace("oldVolume="+oldVolume);
			//trace("volume="+volume);
			updateBtnVol();
			if(onUpdateVol==null){
			}else{
				onUpdateVol(volume);
			}
		}
		
	}
}