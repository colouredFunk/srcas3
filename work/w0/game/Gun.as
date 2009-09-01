/*
Gun 版本:v1.0
简要说明:
创建人:AKDCL
创建时间:2009年9月1日 14:33:43
历次修改:未有修改
用法举例:
*/

package game{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;

	public class Gun extends Sprite {
		private var bulletsRemain:uint=90;
		private var bulletsIn:uint=30;
		private var bulletsPer:uint=30;
		//射击延时，以毫秒为单位
		private var time_colddown:uint=100;
		//装填延时，以毫秒为单位
		private var time_reload:uint=2000;
		//扳机
		private var trigger:Boolean;
		//自动步枪
		private var automatic:Boolean=true;
		
		private var timer_fire:Timer;
		public function Gun() {
			reload();
			timer_fire=new Timer(time_colddown) ;
			timer_fire.addEventListener(TimerEvent.TIMER_COMPLETE,resetFire);
		}
		public var onFire:Function;
		public var onFireFailed:Function;
		public function fire(_trigger:Boolean=false):void {
			trigger=_trigger;
			if (_trigger) {
				if(timer_fire.running){
					return;
				}
				if (bulletsIn>0) {
					timer_fire.repeatCount=1;
					timer_fire.delay=time_colddown;
					timer_fire.start();
					bulletsIn--;
					if (onFire!=null) {
						onFire(bulletsIn);
					}
				}else{
					if (onFireFailed!=null) {
						onFireFailed();
					}
				}
			} else{
				
			}
		}
		private function resetFire(_evt:TimerEvent):void{
			trace("can fire now!");
			if(automatic&&trigger){
				fire(true);
			}
		}
		public var onReload:Function;
		public var onReloadFailed:Function;
		public function reload():void {
			if (bulletsIn>=bulletsPer) {
				if (onReload!=null) {
					onReloadFailed();
				}
				return;
			}
			if (bulletsRemain<=0) {
				if (onReload!=null) {
					onReloadFailed(true);
				}
				return;
			}
			if (bulletsRemain>bulletsPer) {
				bulletsIn=bulletsPer;
				bulletsRemain-=bulletsPer;
			} else {
				bulletsIn=bulletsRemain;
				bulletsRemain=0;
			}
			if (onReload!=null) {
				onReload(bulletsIn,bulletsRemain);
			}
		}
	}
}

//

//

/**/