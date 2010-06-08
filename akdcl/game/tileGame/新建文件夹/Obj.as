import akdcl.tilegame.*;
class akdcl.tilegame.Obj {
	//虚拟坐标
	public var x:Number = 0;
	public var y:Number = 0;
	//存放物体朝向
	public var obDir:Object;
	//区块行列坐标
	public var nTile_x:Number = 0;
	public var nTile_y:Number = 0;
	//mClip的库链接
	public var sLink:String;
	//显示绑定
	public var mClip:MovieClip;
	//深度级别1~10，同一深度级别的物体不可以在同一区块重叠否则后果自负
	public var nDepth_lv:Number = 1;
	public function Obj(__x:Number, __y:Number, _sLink:String) {
		setXY(Map.lineToVp(__x),Map.lineToVp(__y));
		sLink = _sLink;
		obDir={x:1,y:0}
	}
	public function setXY(__x:Number, __y:Number):Void {
		x=__x, y=__y;
		nTile_x = Map.vpToLine(x);
		nTile_y = Map.vpToLine(y);
	}
	public function setDir(__x:Number, __y:Number):Void{
		//可以有8个方向的转向其中2,4,6,8是正方向.1,3,7,9是侧方向,5是停下的空方向如果需要用的话
		if(__x!=obDir.x||__y!=obDir.y){
			var _nT:Number=(__x+1)*3+2+__y;
			if(_nT==5){
				return;
			}
			obDir.x=__x,obDir.y=__y;
			mClip.gotoAndStop(_nT);
		}
	}
	//Map.nType=0;正视或侧视剪辑坐标_x，_y就是x,y；可以不刻意设置深度或方法0
	//Map.nType=1;45度正俯视剪辑坐标_x，_y就是x,y；需要刻意设置深度方法1
	//Map.nType=2;45度斜俯视剪辑坐标_x，_y需要vpToView(x,y)；需要刻意设置深度方法2
	public function setClip():Void {
		mClip = Map.mapNow.mClip.mMid.attachMovie(sLink, sLink, Map.getDepth(nTile_x, nTile_y, nDepth_lv));
		setDir(obDir.x,obDir.y);
		moveClip();
	}
	//根据虚拟坐标更新mClip的坐标
	public function moveClip():Void {
		if (Map.nType<2) {
			mClip._x = x;
			mClip._y = y;
		} else {
			Map.vpToView(mClip,x,y);
		}
	}
}