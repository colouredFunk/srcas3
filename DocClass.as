package {
	import flash.display.Sprite;
	import flash.display.MovieClip;
	//import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.display.StageDisplayState;
	
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.FullScreenEvent;

	public class DocClass extends MovieClip {
		public static var single:DocClass;
		protected var __WIDTH:int;
		protected var __HEIGHT:int;
		public function DocClass() {
			super();
			init();
		}
		protected function init():void {
			single=this;
			__WIDTH=stage.stageWidth;
			__HEIGHT=stage.stageHeight;
			__flashVars=stage.loaderInfo.parameters;
			stage.align=StageAlign.TOP;
			stage.align=StageScaleMode.NO_SCALE;
			stage.showDefaultContextMenu=false;
			//this.addEventListener(FullScreenEvent.FULL_SCREEN,$onFullScreen);
			loaderInfo.addEventListener(ProgressEvent.PROGRESS,loading);
			loaderInfo.addEventListener(Event.COMPLETE,loaded);
			stop();
			onLoaded=function():void{
				if(this.currentFrame==1){
					play();
				}
			}
		}
		public var onLoading:Function;
		protected function loading(evt:ProgressEvent):void{
			if(onLoading!=null){
				onLoading(evt.bytesLoaded/evt.bytesTotal);
			}
		}
		public var onLoaded:Function;
		protected function loaded(evt:Event):void{
			loaderInfo.removeEventListener(ProgressEvent.PROGRESS,loading);
			loaderInfo.removeEventListener(Event.COMPLETE,loaded);
			if(onLoaded!=null){
				onLoaded();
			}
		}
		public function get WIDTH():int{
			return __WIDTH;
		}
		public function get HEIGHT():int{
			return __HEIGHT;
		}
		protected var __flashVars:Object;
		public function get flashVars():Object {
			return __flashVars;
		}
		public var onFullScreen:Function;
		public function setFullScreen(_isFullScreen:Boolean):void {
			if (_isFullScreen) {
				stage.displayState=StageDisplayState.FULL_SCREEN;
			} else {
				stage.displayState=StageDisplayState.NORMAL;
			}
			if (onFullScreen!=null) {
				//onFullScreen(_isFullScreen,_isFullScreen?stage.fullScreenWidth:__WIDTH,_isFullScreen?stage.fullScreenHeight:__HEIGHT);
			}
		}
	}
}