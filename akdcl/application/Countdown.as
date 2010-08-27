package akdcl.application
{
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class Countdown extends Timer
	{
		public static var COUNTDOWN:String = "countdown";
		protected var dateCountdown:Date;
		protected var dateNow:Date;
		protected var dateDis:Date;
		public function Countdown(_delay:Number, _repeatCount:int = 0) {
			super(_delay, _repeatCount);
			dateDis = new Date();
			dateNow = new Date();
			dateCountdown = new Date();
			dateCountdown.date++;
		}
		public function startCountdown(_dateCountdown:Date = null, _dateNow:Date = null):void {
			if (_dateCountdown) {
				dateCountdown = _dateCountdown;
			}
			if (_dateNow) {
				dateNow = _dateNow;
			}
			addEventListener(TimerEvent.TIMER, onTimerHandle);
			start();
		}
		public function stopCountdown():void {
			removeEventListener(TimerEvent.TIMER, onTimerHandle);
			stop();
		}
		protected function onTimerHandle(e:TimerEvent):void {
			var _dTime:int = dateCountdown.time - dateNow.time;
			if (_dTime>=0) {
				dateDis.time = _dTime;
				dateNow.seconds++;
			}else {
				dateDis.time = 0;
			}
			dispatchEvent(new TimerEvent(COUNTDOWN));
		}
		public function get year():uint {
			return dateDis.fullYear - 1970;
		}
		public function get month():uint {
			return dateDis.month;
		}
		public function get date():uint {
			return dateDis.date-1;
		}
		public function get hours():uint {
			if (dateDis.hours>=8) {
				return dateDis.hours-8;
			}else {
				return 24 + dateDis.hours - 8;
			}
		}
		public function get minutes():uint {
			return dateDis.minutes;
		}
		public function get seconds():uint {
			return dateDis.seconds;
		}
	}
}