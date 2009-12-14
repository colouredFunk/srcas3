package ui_2
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	/**
	 * ...
	 * @author Akdcl
	 */
	public class Popup extends MovieClip
	{	
		public static var PopupLayer:Sprite;
		public var callBack:Function;
		
		public var txt_show:*;
		public var btn_y:*;
		public var btn_n:*;
		public var btn_x:*;
		public var bar:*;
		public var userData:Object;
		
		protected var maskArea:Sprite;
		protected var isYN:Boolean;
		protected var isDrag:Boolean;
		protected var isMask:Boolean;
		public function Popup() {
			this.addEventListener(Event.ADDED_TO_STAGE,added);
			stop();
		}
		protected function added(_evt:Event):void {
			this.removeEventListener(Event.ADDED_TO_STAGE,added);
			this.addEventListener(Event.REMOVED_FROM_STAGE,removed);
			if (btn_y) {
				btn_y.release = function():void {
					if((callBack!=null)?(callBack(true)!= false):true){
						remove();
					}
				};
			}
			if (btn_n) {
				btn_n.release=function ():void {
					if((callBack!=null)?(callBack(false)!= false):true){
						remove();
					}
				};
			}
			if (btn_x) {
				btn_x.release = btn_n.release;
			}
			if(txt_show){
				txt_show.mouseEnabled = false;
			}
			bar.buttonMode=false;
			bar.press = function():void  {
				parent.addChild(this.parent);
				startDrag();
			};
			bar.release =function ():void {
				stopDrag();
				adjustXY();
			};
			maskArea=new Sprite();
			addChildAt(maskArea,0);
		}
		protected function removed(_evt:Event):void {
			this.removeEventListener(Event.REMOVED_FROM_STAGE,removed);
			removeChild(maskArea);
			callBack=null;
		}
		public function get text():String{
			return txt_show.text;
		}
		public function set text(_text:String):void {
			if (txt_show) {
				txt_show.htmlText=_text;
			}
		}
		public function popup(_alert:String):void{
			if(!stage){
				if(PopupLayer){
					PopupLayer.addChild(this);
					this.x = int(PopupLayer.stage.stageWidth * 0.5);
					this.y = int(PopupLayer.stage.stageHeight * 0.5);
					if (_alert) {
						text = _alert;
					}
					adjustXY();
				}else{
					trace("PopupLayer is null!!!" );
					return;
				}
			}
			setBar(true,true);
		}
		public function setBar(_isDrag:Boolean=false,_isMask:Boolean=false):void {
			if (_isDrag) {
				bar.enabled=true;
			} else {
				bar.enabled=false;
			}
			if(_isMask){
				maskArea.hitArea=(parent as Sprite);
			}else{
				maskArea.hitArea=null;
			}
			isMask=_isMask;
			isDrag=_isDrag;
		}
		private var rect:Rectangle;
		private function adjustXY():void {
			rect=getRect(this);
			if (- x>rect.left) {
				x=- rect.left;
			} else if (x>stage.stageWidth-rect.right) {
				x=stage.stageWidth-rect.right;
			}
			if (- y>rect.top) {
				y=- rect.top;
			} else if (y>stage.stageHeight-rect.bottom) {
				y=stage.stageHeight-rect.bottom;
			}
			x=int(x);
			y=int(y);
		}
		public function remove():void {
			if (parent) {
				parent.removeChild(this);
			}
		}
	}
	
}