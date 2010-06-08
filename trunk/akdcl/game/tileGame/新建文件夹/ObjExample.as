import akdcl.tilegame.*;
class akdcl.tilegame.ObjExample extends ObjMove {
	public var lockView:Boolean;
	public function ObjExample(__x:Number, __y:Number, _sLink:String,_w:Number,_h:Number) {
		super(__x,__y,_sLink,_w,_h);
	}
	//实现横板移动跳跃的例子进程
	public function run_0():Void {
		obSpeed.g = 1;
		onHit = function (_nXY:Number, _nSp:Number):Void {
			if (_nXY == 1) {
				obSpeed.y = 0;
			}
		};
		run_0 = function ():Void {
			if (Key.isDown(Key.LEFT)) {
				obSpeed.x = -nSpeed;
			} else if (Key.isDown(Key.RIGHT)) {
				obSpeed.x = nSpeed;
			} else {
				obSpeed.x = 0;
			}
			if (Key.isDown(Key.UP)) {
				if (!obSpeed.bKey) {
					obSpeed.y = -13;
					obSpeed.bKey = true;
				}
			} else {
				obSpeed.bKey = false;
			}
			obSpeed.y += obSpeed.g;
			moveStep();
			Map.mapNow.cameraViewMc(mClip);
		};
	}
	//实现移动的例子进程
	public function run_1():Void {
		if (Key.isDown(Key.LEFT)) {
			obSpeed.x = -nSpeed;
		} else if (Key.isDown(Key.RIGHT)) {
			obSpeed.x = nSpeed;
		} else {
			obSpeed.x = 0;
		}
		if (Key.isDown(Key.UP)) {
			obSpeed.y = -nSpeed;
		} else if (Key.isDown(Key.DOWN)) {
			obSpeed.y = nSpeed;
		} else {
			obSpeed.y = 0;
		}
		setDir(Common.vpNum(obSpeed.x),Common.vpNum(obSpeed.y));
		moveStep_1();
		if(lockView){
			Map.mapNow.cameraViewMc(mClip);
		}
	}
	//实现整步数移动的例子进程
	public function run_2():Void {
		if (Key.isDown(Key.LEFT)) {
			obSpeed.x = -nSpeed;
		} else if (Key.isDown(Key.RIGHT)) {
			obSpeed.x = nSpeed;
		} else if (obSpeed.x != 0 && x%Map.nTile_w<nSpeed) {
			obSpeed.x = 0;
		}
		if (Key.isDown(Key.UP)) {
			obSpeed.y = -nSpeed;
		} else if (Key.isDown(Key.DOWN)) {
			obSpeed.y = nSpeed;
		} else if (obSpeed.y != 0 && y%Map.nTile_w<nSpeed) {
			obSpeed.y = 0;
		}
		setDir(Common.vpNum(obSpeed.x),Common.vpNum(obSpeed.y));
		moveStep();
		if(lockView){
			Map.mapNow.cameraViewMc(mClip);
		}
	}
	//实现移动的例子进程
	/*public function run_3(_m:MovieClip):Void {
		var _nx:Number=Map.vpX(_m._xmouse,_m._ymouse);
		var _ny:Number=Map.vpY(_m._xmouse,_m._ymouse);
		_nx=Map.vpToLine(_nx);
		_ny=Map.vpToLine(_ny);
		if(nTile_x!=_nx){
			obSpeed.x = nSpeed*(_nx>nTile_x?1:-1);
		}else if (obSpeed.x != 0 && x%Map.nTile_w<nSpeed){
			obSpeed.x =0;
		}
		if(nTile_y!=_ny){
			obSpeed.y = nSpeed*(_ny>nTile_y?1:-1);
		}else if (obSpeed.y != 0 && y%Map.nTile_w<nSpeed){
			obSpeed.y =0;
		}
		setDir(Common.vpNum(obSpeed.x),Common.vpNum(obSpeed.y));
		moveStep();
		if(lockView){
			Map.mapNow.cameraViewMc(mClip);
		}
	}*/
}