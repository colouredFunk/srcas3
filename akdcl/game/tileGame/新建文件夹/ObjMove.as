import akdcl.tilegame.*;
class akdcl.tilegame.ObjMove extends Obj {
	//移动速度标量
	public var nSpeed:Number = 3;
	//移动速度矢量
	public var obSpeed:Object;
	//存放围绕物体四周的点的横纵偏移量
	public var aPoint_x:Array;
	public var aPoint_y:Array;
	//物体虚拟高
	public var nWidth:Number;
	//物体虚拟宽
	public var nHeight:Number;
	private var nW_half:Number;
	private var nH_half:Number;
	private var obTemp:Object;
	private var __nTile_x:Number = 0;
	private var __nTile_y:Number = 0;
	private var nTile_xPrev:Number = 0;
	private var nTile_yPrev:Number = 0;
	private var Prev_x:Number = 0;
	private var Prev_y:Number = 0;
	//用于更加精确的切换层次时用的
	private var nTile_x_floor:Number;
	private var nTile_y_floor:Number;
	//到达新的区块时触发
	public var onArrive:Function;
	//完整到达新的区块时触发
	public var onArriveInt:Function;
	//移动时触发
	public var onMoving:Function;
	//闯到障碍时触发
	public var onHit:Function;
	public function ObjMove(__x:Number, __y:Number, _sLink:String, _w:Number, _h:Number) {
		super(__x,__y,_sLink);
		nWidth = _w;
		nHeight = _h;
		init();
	}
	private function init():Void {
		nW_half = nWidth/2;
		nH_half = nHeight/2;
		obSpeed = {x:0, y:0};
		obTemp = {};
		setCorners();
	}
	public function get nTile_x():Number {
		return __nTile_x;
	}
	public function get nTile_y():Number {
		return __nTile_y;
	}
	public function set nTile_x(_nTile_x:Number):Void {
		if (_nTile_x != __nTile_x) {
			nTile_xPrev = __nTile_x;
			__nTile_x = _nTile_x;
			onArrive();
		}
	}
	public function set nTile_y(_nTile_y:Number):Void {
		if (_nTile_y != __nTile_y) {
			nTile_yPrev = __nTile_y;
			__nTile_y = _nTile_y;
			onArrive();
		}
	}
	public function setXY(__x:Number, __y:Number):Void {
		Prev_x=x,Prev_y=y;
		super.setXY(__x,__y);
		if (x%Map.nTile_w == 0 && y%Map.nTile_w == 0) {
			onArriveInt();
		}
		var _rx:Number = Map.vpToLine(x-nW_half);
		var _ry:Number = Map.vpToLine(y-nW_half);
		if (nTile_x_floor != _rx || nTile_y_floor != _ry) {
			nTile_x_floor = _rx;
			nTile_y_floor = _ry;
			setDepth(nTile_x_floor,nTile_y_floor);
		}
	}
	private function setDepth(__x:Number, __y:Number):Void {
		mClip.swapDepths(Map.getDepth(__x, __y, nDepth_lv));
	}
	//设置周围的点
	private function setCorners():Void {
		aPoint_x = new Array();
		aPoint_y = new Array();
		var xn:Number = Math.ceil(nWidth/Map.nTile_w);
		var yn:Number = Math.ceil(nHeight/Map.nTile_w);
		for (var i:Number = 0; i<xn+1; i++) {
			aPoint_x[i] = nWidth*(i/xn-0.5);
		}
		for (var i:Number = 0; i<yn+1; i++) {
			aPoint_y[i] = nHeight*(i/yn-0.5);
		}
		aPoint_x[aPoint_x.length-1]--;
		aPoint_y[aPoint_y.length-1]--;
	}
	//检测水平方向的通行状况
	private function getxCorners():Number {
		obTemp.dsp_x = obSpeed.x>0 ? 1 : -1;
		var nDx:Number = x+obTemp.dsp_x*nW_half-int(obTemp.dsp_x>0);
		obTemp.dx = Map.vpToLine(nDx+obSpeed.x);
		var _n:Number = 0;
		for (var i in aPoint_y) {
			var dy:Number = Map.vpToLine(y+aPoint_y[i]);
			var _tile = Map.mapNow.getTile(obTemp.dx, dy);
			if (_tile.nWalk_x == undefined || (obTemp.dsp_x == -_tile.nWalk_x && obTemp.dx != Map.vpToLine(nDx))) {
				//该区块整个x轴或某一正负方向无法通行
				//return false
				_n++;
				var _nDir:Number = int(i);
			}
		}
		//有3种情况:2无法通过,1,-1需要绕行,0可以通过
		if (_n == aPoint_y.length) {
			return 2;
		} else if (_n == 0) {
			return 0;
		}
		return _nDir*2-1;
	}
	//检测垂直方向的通行状况
	private function getyCorners():Number {
		obTemp.dsp_y = obSpeed.y>0 ? 1 : -1;
		var nDy:Number = y+obTemp.dsp_y*nH_half-int(obTemp.dsp_y>0);
		obTemp.dy = Map.vpToLine(nDy+obSpeed.y);
		var _n:Number = 0;
		for (var i in aPoint_x) {
			var dx:Number = Map.vpToLine(x+aPoint_x[i]);
			var _tile = Map.mapNow.getTile(dx, obTemp.dy);
			//该区块无法通行||(该区块的该方向无法通行&&物体没有进入块里面)
			if (_tile.nWalk_y == undefined || (obTemp.dsp_y == -_tile.nWalk_y && obTemp.dy != Map.vpToLine(nDy))) {
				//该区块整个y轴或某一正负方向无法通行
				//return false;
				_n++;
				var _nDir:Number = int(i);
			}
		}
		//有3种情况:2无法通过,1,-1需要绕行,0可以通过
		if (_n == aPoint_x.length) {
			return 2;
		} else if (_n == 0) {
			return 0;
		}
		return _nDir*2-1;
	}
	private function closeToX(_nTile:Number, _nDir:Number):Number {
		return Map.lineToVp(_nTile)+_nDir*(Map.nTile_w_half-nW_half);
	}
	private function closeToY(_nTile:Number, _nDir:Number):Number {
		return Map.lineToVp(_nTile)+_nDir*(Map.nTile_w_half-nH_half);
	}
	//普通移动方式
	public function moveStep():Void {
		var _ix:Number = x;
		var _iy:Number = y;
		var _bx:Boolean;
		var _by:Boolean;
		if (obSpeed.x != 0) {
			_bx = !getxCorners();
			if (_bx) {
				_ix += obSpeed.x;
			} else {
				_ix = closeToX(obTemp.dx-obTemp.dsp_x, obTemp.dsp_x);
				onHit(0,obSpeed.x);
			}
		}
		if (obSpeed.y != 0) {
			_by = !getyCorners();
			if (_by) {
				_iy += obSpeed.y;
			} else {
				_iy = closeToY(obTemp.dy-obTemp.dsp_y, obTemp.dsp_y);
				onHit(1,obSpeed.y);
			}
		}
		/*if(_bx+_by==1){
			if(_bx){
				_ix=x+(_iy-y)*obSpeed.x/obSpeed.y;
			}else{
				_iy=y+(_ix-x)*obSpeed.y/obSpeed.x;
			}
		}*/
		if (_bx && _by) {
			var _offx:Number = aPoint_x[obSpeed.x>0 ? aPoint_x.length-1 : 0];
			var _offy:Number = aPoint_y[obSpeed.y>0 ? aPoint_y.length-1 : 0];
			var _tile = Map.mapNow.getTile(Map.vpToLine(_ix+_offx), Map.vpToLine(_iy+_offy));
			if (isNaN(_tile.nWalk_x) || isNaN(_tile.nWalk_y)) {
				if (nTile_xPrev == nTile_x) {
					_ix = x;
				} else if (nTile_yPrev == nTile_y) {
					_iy = y;
				} else {
					random(2)>0 ? _ix=x : _iy=y;
				}
			}
		}
		if (x != _ix || y != _iy) {
			setXY(_ix,_iy);
			moveClip();
			onMoving();
		}
	}
	//======================
	//这个移动方式可以方便按键控制绕开墙壁
	public function moveStep_1():Void {
		var _ix:Number = x;
		var _iy:Number = y;
		var _bx:Boolean;
		var _by:Boolean;
		if (obSpeed.x != 0) {
			var _nx:Number = getxCorners();
			if (_nx != 0) {
				_ix = closeToX(obTemp.dx-obTemp.dsp_x, obTemp.dsp_x);
			}
		}
		if (obSpeed.y != 0) {
			var _ny:Number = getyCorners();
			if (_ny != 0) {
				_iy = closeToY(obTemp.dy-obTemp.dsp_y, obTemp.dsp_y);
			}
		}
		if (obSpeed.x != 0 && !(Math.abs(_nx) == 1 && (_ny == 0 || _ny == 2))) {
			if (_nx == 0) {
				_ix += obSpeed.x;
			} else if (_nx != 2) {
				_iy -= Math.abs(obSpeed.x)*_nx;
			}
				_bx = true;
		}
		if (obSpeed.y != 0 && !(Math.abs(_ny) == 1 && (_nx == 0 || _nx == 2))) {
			if (_ny == 0) {
				_iy += obSpeed.y;
			} else if (_ny != 2) {
				_ix -= Math.abs(obSpeed.y)*_ny;
			}
				_by = true;
		}
		if (_bx && _by) {
			var _offx:Number = aPoint_x[obSpeed.x>0 ? aPoint_x.length-1 : 0];
			var _offy:Number = aPoint_y[obSpeed.y>0 ? aPoint_y.length-1 : 0];
			var _tile = Map.mapNow.getTile(Map.vpToLine(_ix+_offx), Map.vpToLine(_iy+_offy));
			if (isNaN(_tile.nWalk_x) || isNaN(_tile.nWalk_y)) {
				if (Prev_x == x) {
					_ix = x;
				} else if (Prev_y == y) {
					_iy = y;
				} else {
					random(2)>0 ? _ix=x : _iy=y;
				}
			}
		}
		if (x != _ix || y != _iy) {
			setXY(_ix,_iy);
			moveClip();
			onMoving();
		}
	}
}