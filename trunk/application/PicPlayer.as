package application
{
	import br.com.stimuli.loading.loadingtypes.VideoItem;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import com.greensock.TweenMax;
	import ui_2.SimpleBtn;
	/**
	 * ...
	 * @author Akdcl
	 */
	public class  PicPlayer extends Sprite
	{
		public static var LOAD:String = "pic_load";
		public static var RELOAD:String = "pic_reload";
		public static var LOADED:String = "pic_loaded";
		public static var ERROR:String = "pic_error";
		public static var TWEENED:String = "pic_tweened";
		public static var STATE_CHANGE:String = "pic_stateChange";
		
		public static var LOADING:String = "pic_loading";
		public static var TWEENING:String = "pic_tweening";
		public static var DELAYING:String = "pic_delaying";
		
		public var picWidth:uint;
		public var picHeight:uint;
		public var picAspectRatio:Number;
		public var fillMode:uint;
		public var timeDelay:Number;
		public var timeTween:Number;
		
		private var xml:XML;
		private var timer:Timer;
		private var loaderDic:Object;
		private var picNow:PicContainer;
		private var picPrev:PicContainer;
		private var tweenPrevFrom:Object;
		private var tweenPrevTo:Object;
		private var tweenStyle:XML;
		private var btn:SimpleBtn;
		public function PicPlayer() {
			addEventListener(Event.ADDED_TO_STAGE, added);
		}
		private function added(_evt:Event):void {
			stage.align=StageAlign.TOP_LEFT;
			removeEventListener(Event.ADDED_TO_STAGE, added);
			addEventListener(Event.REMOVED_FROM_STAGE, removed);
			timer = new Timer(100);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, timeRun);
			loaderDic = { };
			picNow = new PicContainer();
			picPrev = new PicContainer();
			addChild(picNow);
			addChild(picPrev);
			btn = new SimpleBtn();
			btn.hitArea = picNow;
			btn.userData = {url:null,type:"_blank"};
			btn.release = function():void {
				if (this.userData.url) {
					Common.getURL(this.userData.url,this.userData.type)
				}
			}
			addChild(btn);
		}
		private function removed(_evt:Event):void {
			removeEventListener(Event.REMOVED_FROM_STAGE, removed);
			timer.removeEventListener(TimerEvent.TIMER_COMPLETE, timeRun);
			loaderDic = null;
			removeChild(picNow);
			removeChild(picPrev);
			picNow = null;
			picPrev = null;
		}
		private function timeRun(_evt:TimerEvent):void {
			id_pic++;
		}
		public function loadXml(_url:String):void {
			Common.urlLoader(_url, xmlLoaded);
		}
		private function xmlLoaded(_evt:Event):void {
			xml = new XML(_evt.currentTarget.data);
			
			picWidth = width||picWidth||(stage.stageWidth-x*2);
			picHeight = height||picHeight||(stage.stageHeight-y*2);
			picAspectRatio = picHeight / picWidth;
			scaleX = scaleY = 1;
			
			fillMode = int(xml.fillMode) || fillMode;
			timeDelay = Number(xml.timeDelay) || timeDelay;
			timer.repeatCount = timeDelay * 10;
			timeTween = Number(xml.timeTween) || timeTween;
			if (xml.hasOwnProperty("tween")) {
				tweenStyle = xml.tween[0];
			}else {
				tweenStyle = <tween>
								<prev>
									<from autoAlpha="1"/>
									<to autoAlpha="0"/>
								</prev>
								<now>
									<from autoAlpha="0"/>
									<to autoAlpha="1"/>
								</now>
							</tween>
			}
			
			id_pic = 0;
		}
		private static function getObjInTween(_xml:XML,_depth:uint=0):Object {
			var _ob:Object;
			var _each:*;
			var _xmlList:XMLList = _xml.attributes();
			if (_xmlList.length() > 0) {
				_ob = { };
				for each(_each in _xmlList) {
					_ob[String(_each.name())] = Number(_each);
					//trace(_each.name()+":"+_each);
				}
			}
			_xmlList = _xml.elements();
			if (_xmlList.length() > 0) {
				if (!_ob) {
					_ob = { };
				}
				for each(_each in _xmlList) {
					_ob[String(_each.name())] = getObjInTween(_each,_depth+1);
					//trace(_depth+":"+_each.name());
				}
			}
			return _ob;
		}
		private var __state:String=TWEENED;
		public function get state():String {
			return __state;
		}
		private function setState(_state:String):void {
			__state = _state;
			switch(__state) {
				case LOAD:
					removeEventListener(Event.ENTER_FRAME, delaying);
					break;
				case RELOAD:
					removeEventListener(Event.ENTER_FRAME, delaying);
					addEventListener(Event.ENTER_FRAME, tweening);
					break;
				case LOADED:
					addEventListener(Event.ENTER_FRAME, tweening);
					break;
				case ERROR:
					break;
				case TWEENED:
					removeEventListener(Event.ENTER_FRAME, tweening);
					addEventListener(Event.ENTER_FRAME, delaying);
					break;
			}
			dispatchEvent(new Event(__state));
			dispatchEvent(new Event(STATE_CHANGE));
		}
		private var __id_pic:int=-1;
		public function get id_pic():int{
			return __id_pic;
		}
		public function set id_pic(_id_pic:int):void {
			if (state!=TWEENED||__id_pic==_id_pic) {
				return;
			}
			if (_id_pic<0) {
				_id_pic = xml.pic.length()-1;
			} else if (_id_pic>xml.pic.length()-1) {
				_id_pic = 0;
			}
			__id_pic = _id_pic;
			
			loadPic(getPicPath(__id_pic));
		}
		private function getPicPath(_id_pic:int):String {
			var _picPath:String = String(xml.pic[_id_pic].@src);
			if (_picPath == null || _picPath.length <= 0) {
				_picPath = xml.picesPath.text();
			}
			if (_picPath.indexOf(".") < 0) {
				if (_picPath.charAt(_picPath.length-1)!="/") {
					_picPath += "/";
				}
				_picPath += xml.pic[_id_pic].@name;
			}
			return _picPath;
		}
		private function loadPic(_path:String):void {
			timer.stop();
			if (loaderDic[_path] != null) {
				setState(RELOAD);
				picLoaded(loaderDic[_path]);
				return;
			}
			setState(LOAD);
			loaderDic[_path]=Common.loader(_path,picLoaded,picLoading,picError);
		}
		private function picError(_evt:ErrorEvent):void {
			setState(ERROR);
			id_pic++;
		}
		private function picLoaded(_evtOrLoader:*):void {
			if (_evtOrLoader is Event) {
				setState(LOADED);
				var _bmp:Bitmap = _evtOrLoader.currentTarget.content as Bitmap;
				_bmp.smoothing = true;
				_evtOrLoader = _evtOrLoader.currentTarget.loader as Loader;
			}
			if (xml.pic[id_pic].text().length()>0) {
				btn.userData.url = xml.pic[id_pic].text();
				if (xml.pic[id_pic].@type.length()>0) {
					btn.userData.type = xml.pic[id_pic].@type;
				}else {
					btn.userData.type = "_blank";
				}
				btn.enabled = true;
			}else {
				btn.enabled = false;
			}
			changePic(_evtOrLoader);
		}
		private function tweening(_evt:Event):void {
			dispatchEvent(new Event(TWEENING));
		}
		private function delaying(_evt:Event):void {
			dispatchEvent(new Event(DELAYING));
		}
		private function picLoading(_evt:ProgressEvent):void {
			dispatchEvent(new ProgressEvent(LOADING,false,false,_evt.bytesLoaded,_evt.bytesTotal));
		}
		private function changePic(_loader:Loader):void {
			
			picPrev.scaleX = picNow.scaleX;
			picPrev.scaleY = picNow.scaleY;
			picPrev.x = picNow.x;
			picPrev.y = picNow.y;
			picPrev.pic = picNow.pic;
			picNow.pic = _loader;
			
			var _picAspectRatio:Number = picNow.height / picNow.width;
			switch(fillMode) {
				case 0:
					break;
				case 1:
					if (_picAspectRatio < picAspectRatio) {
						picNow.width = picWidth;
						picNow.height = _picAspectRatio * picNow.width;
					}else {
						picNow.height = picHeight;
						picNow.width = picNow.height/_picAspectRatio;
					}
					break;
				case 2:
					picNow.width = picWidth;
					picNow.height = _picAspectRatio * picNow.width;
					break;
				case 3:
					picNow.height = picHeight;
					picNow.width = picNow.height/_picAspectRatio;
					break;
				case 4:
					picNow.width = picWidth;
					picNow.height = picHeight;
					break;
			}
			picNow.x = (picWidth - picNow.width) * 0.5;
			picNow.y = (picHeight - picNow.height) * 0.5;
			
			var _ob:Object;
			TweenMax.to(picPrev, 0, getObjInTween(tweenStyle.prev.from[0]));
			TweenMax.to(picPrev, timeTween, getObjInTween(tweenStyle.prev.to[0]));
			TweenMax.to(picNow, 0, getObjInTween(tweenStyle.now.from[0]));
			_ob = getObjInTween(tweenStyle.now.to[0]);
			_ob.onComplete = tweenEnd;
			TweenMax.to(picNow, timeTween, _ob);
		}
		private function tweenEnd():void {
			setState(TWEENED);
			timer.reset();
			timer.start();
		}
	}
}
import flash.display.Sprite;
import flash.display.DisplayObject;
class PicContainer extends Sprite {
	private var __pic:DisplayObject;
	public function PicContainer() {
	}
	public function get pic():DisplayObject {
		return __pic;
	}
	public function set pic(_pic:DisplayObject):void{
		if (!_pic) {
			return;
		}
		if (__pic&&__pic.parent==this) {
			removeChild(__pic);
		}
		__pic = _pic;
		addChild(__pic);
	}
}