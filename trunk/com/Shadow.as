import flash.geom.*;
package com{
	public class Shadow extends Sprite {
		public var drawContainer:*;
		
		public var rgb:uint = 0xffffff;
		public var alphaStart:Number=1;
		public var shadowLength:uint=10;
		public var disappear:Number=0.9;
		public var xEnd:Number;
		public var yEnd:Number;
		public var speed:Object;
		public var autoDraw:Boolean;
		public var shadowType:uint;
		
		protected var shadowList:Array;
		protected var fillSprite:Sprite;
		public function Shadow(){
			
		}
		protected function init():void {
			speed = {x:0, y:0};
			shadowList = [];
			fillSprite=new Sprite();
			fillSprite.blendMode = 8;
			visible = false;
			if (autoDraw) {
				beginDraw();
			}
		}
		public function runStep():void {
			setShadowList();
			//drawShadow(mFill,this);
		}
		protected function setShadow_list():void {
			if (shadowList.length>=shadowLength) {
				shadowList.shift();
			}
			shadowList.push(getPosNow(xEnd, yEnd));
		}
		protected function getPosNow(_x:Number,_y:Number) {
			var _p1:Point = new Point(0, 0);
			var _p2:Point = new Point(_x, _y);
			this.localToGlobal(_p1);
			parent.localToGlobal(_p2);
			fillSprite.globalToLocal(_p1);
			fillSprite.globalToLocal(_p2);
			return [_p1, _p2];
		}
		private static function drawShadow(_fill:Sprite, _sd:*):Number {
		if (_m.aShadow.length>1) {
			_mFill.clear();
			var nAlphaNow:Number = _m.nAlpha;
			var nDec:Number = _m.nAlpha/_m.nLen;
			var nDis_now:Number = 1;
			for (var i:Number = _m.aShadow.length-1; i>0; i--) {
				var p1 = _m.aShadow[i][0];
				var p2 = _m.aShadow[i][1];
				var p3 = _m.aShadow[i-1][1];
				var p4 = _m.aShadow[i-1][0];
				//p1.offset(_m.obSpeed.x,_m.obSpeed.y);
				//p2.offset(_m.obSpeed.x,_m.obSpeed.y);
				p3.offset(_m.obSpeed.x,_m.obSpeed.y);
				p4.offset(_m.obSpeed.x,_m.obSpeed.y);
				var p11, p22, p33, p44;
				if (_m.nType>0) {
					p22 = Point.interpolate(p2, p1, nDis_now);
					p11 = p1;
				} else if (_m.nType<0) {
					p22 = p2;
					p11 = Point.interpolate(p1, p2, nDis_now);
				} else if (_m.nType == 0) {
					p22 = Point.interpolate(p2, p1, nDis_now);
					p11 = Point.interpolate(p1, p2, nDis_now);
				}
				nDis_now *= _m.nDis;
				if (_m.nType == 0 && nDis_now<0.5) {
					nDis_now = 0.5;
				}
				if (_m.nType>0) {
					p33 = Point.interpolate(p3, p4, nDis_now);
					p44 = p4;
				} else if (_m.nType<0) {
					p33 = p3;
					p44 = Point.interpolate(p4, p3, nDis_now);
				} else if (_m.nType == 0) {
					p33 = Point.interpolate(p3, p4, nDis_now);
					p44 = Point.interpolate(p4, p3, nDis_now);
				}
				_mFill.beginFill(_m.nRgb,nAlphaNow);
				_mFill.moveTo(p11.x,p11.y);
				_mFill.lineTo(p22.x,p22.y);
				_mFill.lineTo(p33.x,p33.y);
				_mFill.lineTo(p44.x,p44.y);
				_mFill.endFill();
				nAlphaNow -= nDec;
			}
			return nDec;
		}
		return 0;
	}
	}
}
class com.Shadow extends Sprite {
	//影子由两个点构成,自己的(0,0)全局坐标以及_parent的(nEnd_x,nEnd_y)的全局坐标
	public var nEnd_x:Number = 0;
	public var nEnd_y:Number = 0;
	public var nRgb:Number = 0xffffff;
	public var nAlpha:Number = 100;
	public var nLen:Number = 12;
	public var nDis:Number = 0.9;
	public var aShadow:Array;
	public var bAuto:Boolean;
	public var mFill:MovieClip;
	public var nType:Number = 0;
	public var obSpeed:Object;
	public static var mDrawIn:MovieClip;
	public function Shadow() {
		init();
	}
	public function init():Void {
		obSpeed = {x:0, y:0};
		if (bAuto) {
			beginDraw();
		}
		onUnload = function ():Void {
			this.endDraw();
		};
	}
	public function runStep():Void {
		setShadow_list();
		drawShadow(mFill,this);
	}
	public function beginDraw(_m:MovieClip):Void {
		if (_m) {
			mDrawIn = _m;
		}
		bAuto = true;
		runStep();
		onEnterFrame = function ():Void {
			this.runStep();
		};
	}
	public function endDraw():Void {
		runStep();
		bAuto = false;
		mFill.nRgb = nRgb;
		mFill.nAlpha = nAlpha;
		mFill.nDis = nDis;
		mFill.nLen = nLen;
		mFill.nType = nType;
		mFill.obSpeed = obSpeed;
		mFill.aShadow = aShadow.concat();
		mFill.onEnterFrame = function():Void  {
			this.setShadow_list();
			this.aShadow.shift();
			this.nLen--;
			if (this.aShadow.length<=0) {
				this.removeMovieClip();
				return;
			}
			this.nAlpha -= com.Shadow.drawShadow(this, this);
			this.nDis *= this.nDis;
		};
		mFill = undefined;
		delete onEnterFrame;
	}
	public function remove():Void {
		endDraw();
		this.removeMovieClip();
	}
	private function setShadow_list():Void {
		if (mFill == undefined) {
			var nDepth:Number = mDrawIn.getNextHighestDepth();
			mFill = mDrawIn.createEmptyMovieClip("mFill"+nDepth, nDepth);
			mFill.blendMode = 8;
			aShadow = [];
		}
		if (aShadow.length>=nLen) {
			aShadow.shift();
		}
		aShadow.push(getPosNow(nEnd_x, nEnd_y));
	}
	private function getPosNow(x:Number, y:Number) {
		var p1:Point = new Point(0, 0);
		var p2:Point = new Point(x, y);
		this.localToGlobal(p1);
		_parent.localToGlobal(p2);
		mFill.globalToLocal(p1);
		mFill.globalToLocal(p2);
		return [p1, p2];
	}
	public static function drawShadow(_mFill:MovieClip, _m:MovieClip):Number {
		if (_m.aShadow.length>1) {
			_mFill.clear();
			var nAlphaNow:Number = _m.nAlpha;
			var nDec:Number = _m.nAlpha/_m.nLen;
			var nDis_now:Number = 1;
			for (var i:Number = _m.aShadow.length-1; i>0; i--) {
				var p1 = _m.aShadow[i][0];
				var p2 = _m.aShadow[i][1];
				var p3 = _m.aShadow[i-1][1];
				var p4 = _m.aShadow[i-1][0];
				//p1.offset(_m.obSpeed.x,_m.obSpeed.y);
				//p2.offset(_m.obSpeed.x,_m.obSpeed.y);
				p3.offset(_m.obSpeed.x,_m.obSpeed.y);
				p4.offset(_m.obSpeed.x,_m.obSpeed.y);
				var p11, p22, p33, p44;
				if (_m.nType>0) {
					p22 = Point.interpolate(p2, p1, nDis_now);
					p11 = p1;
				} else if (_m.nType<0) {
					p22 = p2;
					p11 = Point.interpolate(p1, p2, nDis_now);
				} else if (_m.nType == 0) {
					p22 = Point.interpolate(p2, p1, nDis_now);
					p11 = Point.interpolate(p1, p2, nDis_now);
				}
				nDis_now *= _m.nDis;
				if (_m.nType == 0 && nDis_now<0.5) {
					nDis_now = 0.5;
				}
				if (_m.nType>0) {
					p33 = Point.interpolate(p3, p4, nDis_now);
					p44 = p4;
				} else if (_m.nType<0) {
					p33 = p3;
					p44 = Point.interpolate(p4, p3, nDis_now);
				} else if (_m.nType == 0) {
					p33 = Point.interpolate(p3, p4, nDis_now);
					p44 = Point.interpolate(p4, p3, nDis_now);
				}
				_mFill.beginFill(_m.nRgb,nAlphaNow);
				_mFill.moveTo(p11.x,p11.y);
				_mFill.lineTo(p22.x,p22.y);
				_mFill.lineTo(p33.x,p33.y);
				_mFill.lineTo(p44.x,p44.y);
				_mFill.endFill();
				nAlphaNow -= nDec;
			}
			return nDec;
		}
		return 0;
	}
}