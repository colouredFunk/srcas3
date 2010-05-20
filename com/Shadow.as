package com{
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	import flash.display.Sprite;
	import flash.display.BlendMode;
	
	import flash.events.Event;
	
	public class Shadow extends Sprite {
		public static var drawContainer:DisplayObjectContainer;
		
		public var xEnd:Number=0;
		public var yEnd:Number=0;
		public var rgb:uint=0xffffff;
		public var alphaStart:Number=1;
		public var shadowLength:uint=10;
		public var disappear:Number = 0.9;
		public var speed:Object;
		public var autoDraw:Boolean;
		public var shadowType:uint;
		protected var shadowList:Array;
		protected var fillSprite:Sprite;
		public function Shadow() {
			addEventListener(Event.ADDED_TO_STAGE, onAddToStageHandle);
		}
		protected function onAddToStageHandle(_evt:Event):void {
			if(!drawContainer){
				return;
			}
			removeEventListener(Event.ADDED_TO_STAGE, onAddToStageHandle);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStageHandle);
			speed = { x:0, y:0 };
			shadowList = [];
			fillSprite = new Sprite();
			fillSprite.filters = filters;
			fillSprite.blendMode = blendMode;
			drawContainer.addChild(fillSprite);
			
			addEventListener(Event.ENTER_FRAME, runStep);
			
			alphaStart = alpha;
			rgb = transform.colorTransform.color == 0?rgb:transform.colorTransform.color;
			
			visible = false;
			blendMode = BlendMode.NORMAL;
			filters = null;
		}
		protected function onRemoveFromStageHandle(_evt:Event):void {
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStageHandle);
			removeEventListener(Event.ENTER_FRAME, runStep);
			if (fillSprite && drawContainer.contains(fillSprite) ) {
				drawContainer.removeChild(fillSprite);
			}
			speed = null;
			shadowList = null;
		}
		public function runStep(_evt:Event=null):void {
			setShadowList();
			drawShadow(fillSprite,this);
		}
		protected function setShadowList():void {
			if (shadowList.length>=shadowLength) {
				shadowList.shift();
			}
			shadowList.push(getPosNow());
		}
		protected function getPosNow() {
			var _p1:Point=new Point(0,0);
			var _p2:Point=new Point(xEnd,yEnd);
			_p1=fillSprite.globalToLocal(localToGlobal(_p1));
			_p2=fillSprite.globalToLocal(parent.localToGlobal(_p2));
			return [_p1,_p2];
		}
		private static function drawShadow(_fill:Sprite,_sd:*):Number {
			if (_sd.shadowList.length>1) {
				_fill.graphics.clear();
				var _alphaNow:Number=_sd.alphaStart;
				var _dAlpha:Number=_alphaNow/(_sd.shadowLength-1);
				var _dis:Number=1;
				var _p1:*;
				var _p2:*;
				var _p3:*;
				var _p4:*;
				var _p11:*;
				var _p22:*;
				var _p33:*;
				var _p44:*;
				for (var _i:int=_sd.shadowList.length-1; _i>0; _i--) {
					_p1=_sd.shadowList[_i][0];
					_p2=_sd.shadowList[_i][1];
					_p3=_sd.shadowList[_i-1][1];
					_p4=_sd.shadowList[_i-1][0];
					//p1.offset(_m.obSpeed.x,_m.obSpeed.y);
					//p2.offset(_m.obSpeed.x,_m.obSpeed.y);
					_p3.offset(_sd.speed.x,_sd.speed.y);
					_p4.offset(_sd.speed.x,_sd.speed.y);
					if (_sd.shadowType>0) {
						_p22=Point.interpolate(_p2,_p1,_dis);
						_p11=_p1;
					} else if (_sd.shadowType<0) {
						_p22=_p2;
						_p11=Point.interpolate(_p1,_p2,_dis);
					} else if (_sd.shadowType==0) {
						_p22=Point.interpolate(_p2,_p1,_dis);
						_p11=Point.interpolate(_p1,_p2,_dis);
					}
					_dis*=_sd.disappear;
					if (_sd.shadowType==0&&_dis<0.5) {
						_dis=0.5;
					}
					if (_sd.shadowType>0) {
						_p33=Point.interpolate(_p3,_p4,_dis);
						_p44=_p4;
					} else if (_sd.shadowType<0) {
						_p33=_p3;
						_p44=Point.interpolate(_p4,_p3,_dis);
					} else if (_sd.shadowType==0) {
						_p33=Point.interpolate(_p3,_p4,_dis);
						_p44=Point.interpolate(_p4,_p3,_dis);
					}
					_fill.graphics.beginFill(_sd.rgb, _alphaNow);
					_fill.graphics.moveTo(_p11.x,_p11.y);
					_fill.graphics.lineTo(_p22.x,_p22.y);
					_fill.graphics.lineTo(_p33.x,_p33.y);
					_fill.graphics.lineTo(_p44.x,_p44.y);
					_fill.graphics.endFill();
					_alphaNow-=_dAlpha;
				}
				return _dAlpha;
			}
			return 0;
		}
	}
}