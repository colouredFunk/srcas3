package akdcl.application
{
	//import br.com.stimuli.loading.loadingtypes.VideoItem;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Shape;
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
		public static var XML_LOADED:String = "PicPlayer_xml_loaded";
		public static var STATE_CHANGE:String = "PicPlayer_pic_stateChange";
		
		public static var LOAD:String = "PicPlayer_pic_load";
		public static var RELOAD:String = "PicPlayer_pic_reload";
		public static var LOADED:String = "PicPlayer_pic_loaded";
		public static var RELOADED:String = "PicPlayer_pic_reloaded";
		public static var ERROR:String = "PicPlayer_pic_error";
		public static var TWEENED:String = "PicPlayer_pic_tweened";
		
		public static var LOADING:String = "PicPlayer_pic_loading";
		public static var TWEENING:String = "PicPlayer_pic_tweening";
		public static var DELAYING:String = "PicPlayer_pic_delaying";
		
		public var picWidth:uint;
		public var picHeight:uint;
		public var picAspectRatio:Number;
		public var fillMode:uint;
		public var timeTween:Number;
		
		public var xml:XML;
		private var timer:Timer;
		private var loaderDic:Object;
		private var picNow:PicContainer;
		private var picPrev:PicContainer;
		private var tweenPrevFrom:Object;
		private var tweenPrevTo:Object;
		private var tweenStyle:XML;
		private var btn:SimpleBtn;
		private var backShape:Shape;
		
		public var txt_debug:*;
		public function PicPlayer() {
			addEventListener(Event.ADDED_TO_STAGE, added);
		}
		private function added(_evt:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, added);
			addEventListener(Event.REMOVED_FROM_STAGE, removed);
			
			timer = new Timer(100);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimeRunHandle);
			
			loaderDic = { };
			
			picNow = new PicContainer();
			picPrev = new PicContainer();
			addChild(picNow);
			addChild(picPrev);
			
			btn = new SimpleBtn();
			btn.hitArea = picNow;
			btn.userData = {href:null,target:"_blank"};
			btn.press = function():void {
				TweenMax.killTweensOf(txt_debug);
				TweenMax.to(txt_debug,0.5,{autoAlpha:1,delay:2});
			}
			btn.release = function():void {
				TweenMax.killTweensOf(txt_debug);
				TweenMax.to(txt_debug, 0.5, { autoAlpha:0 } );
				clickPic();
			}
			btn.rollOver = function():void {
				timer.stop();
			}
			btn.rollOut = function():void {
				timer.start();
			}
			addChild(btn);
			
			
			var _backShape:*= getChildAt(0);
			if (_backShape != txt_debug) {
				backShape =  _backShape as Shape;
				backShape.visible = false;
			}
			txt_debug.visible = false;
			txt_debug.alpha = 0;
			addChild(txt_debug);
		}
		private function removed(_evt:Event):void {
			removeEventListener(Event.REMOVED_FROM_STAGE, removed);
			timer.removeEventListener(TimerEvent.TIMER_COMPLETE, onTimeRunHandle);
			loaderDic = null;
			removeChild(picNow);
			removeChild(picPrev);
			picNow = null;
			picPrev = null;
		}
		private function onTimeRunHandle(_evt:TimerEvent):void {
			id_pic++;
		}
		public function get autoSize():Boolean {
			return backShape == null;
		}
		private var __timeDelay:Number;
		public function get timeDelay():Number{
			return __timeDelay;
		}
		public function set timeDelay(_timeDelay:Number):void{
			__timeDelay = _timeDelay;
			timer.repeatCount = timeDelay * 10;
		}
		public function loadXml(_url:String):void {
			if (!_url) {
				return;
			}
			var _xml:XML = XML(_url);
			if (_xml.pic.length() > 0) {
				xmlLoaded( { currentTarget: { data:_url }} );
			}else {
				Common.urlLoader(_url, xmlLoaded);
			}
		}
		public function clickPic():void {
			if (btn.userData.href) {
				Common.getURL(btn.userData.href,btn.userData.target)
			}
		}
		private var __masked:Boolean;
		public function get masked():Boolean {
			return __masked;
		}
		[Inspectable(defaultValue = false, type = "Boolean", name = "是否圆角遮罩")]
		public function set masked(_masked:Boolean):void {
			__masked = _masked;
			if (__masked) {
				mask = backShape;
			}else if (mask == backShape) {
				mask = null;
			}
		}
		private function xmlLoaded(_evt:*):void {
			xml = new XML(_evt.currentTarget.data);
			if (backShape) {
				picWidth = width;
				picHeight = height;
			}
			if (picWidth*picHeight==0) {
				stage.align = StageAlign.TOP_LEFT;
				picWidth = stage.stageWidth - x * 2;
				picHeight = stage.stageHeight - y * 2;
			}
			picAspectRatio = picHeight / picWidth;
			scaleX = scaleY = 1;
			if (backShape) {
				backShape.width = picWidth;
				backShape.height = picHeight;
			}
			txt_debug.text = "图片尺寸：" + picWidth + " x " + picHeight;
			
			fillMode = int(xml.fillMode) || fillMode;
			timeDelay = Number(xml.timeDelay) || timeDelay;
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
			dispatchEvent(new Event(XML_LOADED));
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
		public function get picLength():uint {
			return xml.pic.length();
		}
		private var __id_pic:int=-1;
		public function get id_pic():int{
			return __id_pic;
		}
		public function set id_pic(_id_pic:int):void {
			if ((state != TWEENED && state != ERROR) || __id_pic == _id_pic) {
				return;
			}
			if (_id_pic<0) {
				_id_pic = picLength-1;
			} else if (_id_pic>picLength-1) {
				_id_pic = 0;
			}
			__id_pic = _id_pic;
			
			loadPic(getPicPath(__id_pic));
		}
		public function getPicXML(_id:uint):XML {
			return xml.pic[_id][0];
		}
		private function getPicPath(_id_pic:int):String {
			var _picPath:String = String(xml.pic[_id_pic].@src);
			if (_picPath == null || _picPath.length <= 0) {
				_picPath = xml.picesPath.text();
				if (_picPath.charAt(_picPath.length-1)!="/") {
					//_picPath += "/";
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
			for (var _i:String in loaderDic) {
				if (!loaderDic[_i].content) {
					delete loaderDic[_i];
				}
			}
			id_pic++;
		}
		private function picLoaded(_evtOrLoader:*):void {
			if (_evtOrLoader is Event) {
				setState(LOADED);
				var _bmp:Bitmap = _evtOrLoader.currentTarget.content as Bitmap;
				if (_bmp) {
					_bmp.smoothing = true;
				}
				_evtOrLoader = _evtOrLoader.currentTarget.loader as Loader;
			}
			setState(RELOADED);
			if (xml.pic[id_pic].@href.length()>0&&String(xml.pic[id_pic].@href).length>0) {
				btn.userData.href = String(xml.pic[id_pic].@href);
				if (xml.pic[id_pic].@target.length()>0) {
					btn.userData.target = String(xml.pic[id_pic].@target);
				}else {
					btn.userData.target = "_blank";
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
						picNow.width = picNow.height / _picAspectRatio;
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
			if (fillMode==0) {
				
			}else {
				picNow.x = (picWidth - picNow.width) * 0.5;
				picNow.y = (picHeight - picNow.height) * 0.5;
			}
			
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