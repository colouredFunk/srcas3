package {
	import flash.display.Sprite;
	import flash.display.MovieClip;
	
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.display.StageDisplayState;
	
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.FullScreenEvent;
	
	import flash.system.Security;

	public class DocClass extends MovieClip {
		protected var __widthOrg:int;
		protected var __heightOrg:int;
		public function DocClass() {
			init();
		}
		protected function init():void {
			stop();
			__widthOrg=stage.stageWidth;
			__heightOrg=stage.stageHeight;
			__flashVars=stage.loaderInfo.parameters;
			Security.allowDomain("*");
			Security.allowInsecureDomain("*");
			stage.align=StageAlign.TOP;
			stage.scaleMode=StageScaleMode.NO_SCALE;
			stage.showDefaultContextMenu=false;
			//this.addEventListener(FullScreenEvent.FULL_SCREEN,$onFullScreen);
			//this.loaderInfo.addEventListener(ProgressEvent.PROGRESS,loading);
			//this.loaderInfo.addEventListener(Event.COMPLETE,loaded);
			this.addEventListener(Event.ENTER_FRAME,loading);
			onLoaded=function():void{
				if(this.currentFrame==1){
					play();
				}
			}
		}
		public var onLoading:Function;
		protected var loadedPct:Number;//0~1
		protected function loading(evt:*):void{
			var _nT:Number=loaderInfo.bytesLoaded/loaderInfo.bytesTotal;
			if(onLoading!=null){
				onLoading(_nT);
			}
			loadedPct=_nT;
			//if(_nT==1&&onLoaded!=null){
				//this.removeEventListener(Event.ENTER_FRAME,loading);
				//onLoaded();
			//}
		}
		public var onLoaded:Function;
		protected function loaded(evt:Event):void{
			loaderInfo.removeEventListener(ProgressEvent.PROGRESS,loading);
			loaderInfo.removeEventListener(Event.COMPLETE,loaded);
			if(onLoaded!=null){
				onLoaded();
			}
		}
		public function get widthOrg():int{
			return __widthOrg;
		}
		public function get heightOrg():int{
			return __heightOrg;
		}
		protected var __flashVars:Object;
		public function get flashVars():Object {
			return __flashVars;
		}
		public function get swfVersion():uint{
			return loaderInfo.swfVersion;
		}
		public var onFullScreen:Function;
		public function setFullScreen(_isFullScreen:Boolean):void {
			if (_isFullScreen) {
				stage.displayState=StageDisplayState.FULL_SCREEN;
			} else {
				stage.displayState=StageDisplayState.NORMAL;
			}
			if (onFullScreen!=null) {
				//onFullScreen(_isFullScreen,_isFullScreen?stage.fullScreenWidth:__widthOrg,_isFullScreen?stage.fullScreenHeight:__heightOrg);
			}
		}
	}
}