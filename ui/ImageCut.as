package ui{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	import flash.net.*;
	import flash.system.*;
	import flash.geom.*;

	public class ImageCut extends Sprite {
		public var freeTran:*;
		public var rectClip:Sprite;
		public var frameClip:Sprite;
		public var intactClip:Sprite;
		public var thumbnailClip:Sprite;
		public var btn_reset:*;
		public var btn_ok:*;
		public var btn_browse:*;

		private var intactBmp:Bitmap;
		private var thumbnailBmp:Bitmap;
		private var bmpThumbnail:BitmapData;
		private var bmpIntact:BitmapData;

		public function ImageCut() {
			init();
		}
		private function init():void {
			x=Math.round(x);
			y=Math.round(y);
			thumbnailBmp=new Bitmap();
			thumbnailClip.addChild(thumbnailBmp);
			thumbnailClip.x=Math.round(thumbnailClip.x);
			thumbnailClip.y=Math.round(thumbnailClip.y);
			intactBmp=new Bitmap();
			intactClip.addChild(intactBmp);
			intactClip.x=Math.round(intactClip.x);
			intactClip.y=Math.round(intactClip.y);
			intactClip.width=Math.round(intactClip.width);
			intactClip.height=Math.round(intactClip.height);

			intactClip.addEventListener(MouseEvent.MOUSE_DOWN,click);
			intactClip.buttonMode=true;
			rectClip.visible=false;
			rectClip.addEventListener(MouseEvent.MOUSE_DOWN,click);
			rectClip.buttonMode=true;
			freeTran.pic=rectClip;
			freeTran.visible=false;
			freeTran.dragRect=new Rectangle(frameClip.x,frameClip.y,frameClip.width,frameClip.height);
		}
		public function getBitmapData():BitmapData {
			return bmpThumbnail;
		}
		public function setIntact(_bmpIntact:BitmapData):void {
			if (bmpIntact) {
				bmpIntact.dispose();
			}
			bmpIntact=_bmpIntact;
			intactBmp.bitmapData=bmpIntact;
			intactBmp.smoothing=true;
			rectClip.visible=true;
			freeTran.visible=true;
			reset();
			reset();
			freeTran.moving=function():void{
				enterFrame();
			};
		}
		public function reset():void {
			if (! bmpIntact) {
				return;
			}
			intactClip.rotation=0;
			if (intactClip.width/intactClip.height>frameClip.width/frameClip.height) {
				intactClip.width=frameClip.width;
				intactClip.scaleY=intactClip.scaleX;
				intactClip.x=frameClip.x;
				intactClip.y=frameClip.y+(frameClip.height-intactClip.height)*0.5;
			} else {
				intactClip.height=frameClip.height;
				intactClip.scaleX=intactClip.scaleY;
				intactClip.x=frameClip.x+(frameClip.width-intactClip.width)*0.5;
				intactClip.y=frameClip.y;
			}
			rectClip.x=int(frameClip.x+frameClip.width*0.5);
			rectClip.y=int(frameClip.y+frameClip.height*0.5);
			rectClip.rotation=0;
			rectClip.scaleX=rectClip.scaleY=1;
			rectClip["frameClip"].visible=false;
			freeTran.pic=null;
			freeTran.pic=rectClip;
			enterFrame();
		}
		private function click(evt:MouseEvent):void {
			freeTran.setPicByMouse(evt.currentTarget as DisplayObject);
		}
		private function getContainBmd(_obj:*,_bg:*):BitmapData {
			var _rect:Rectangle=_obj.getBounds(_obj);
			var _bmd:BitmapData=new BitmapData(_rect.width,_rect.height,true,0x00000000);
			var _m:Matrix=_bg.transform.concatenatedMatrix;
			var _objM:Matrix=new Matrix(1,0,0,1,- _rect.x,- _rect.y);
			_obj.frameClip.visible=true;
			_bmd.draw(_obj,_objM);
			_obj.frameClip.visible=false;
			_objM.tx*=-1;
			_objM.ty*=-1;
			var _m2:Matrix=_obj.transform.concatenatedMatrix;
			_objM.concat(_m2);
			_objM.invert();
			_m.concat(_objM);
			_bmd.draw(_bg,_m);
			return _bmd;
		}
		private function enterFrame():void {
			if (bmpThumbnail) {
				bmpThumbnail.dispose();
			}
			bmpThumbnail=getContainBmd(rectClip,intactClip);
			thumbnailBmp.bitmapData=bmpThumbnail;
			intactBmp.smoothing=true;
		}
	}
}