/*
如果是正侧或顶视则可以手摆地图，且无深度问题，比较简单
俯视及斜俯视都要有深度问题层次问题所以要考虑的全面些
*/
import akdcl.tilegame.*;
class akdcl.tilegame.Map {
	//区别游戏类型
	public static var nType:Number=0;
	//区块宽度
	public static var nTile_w:Number=36;
	public static var nTile_w_half:Number;
	//斜视的区块高宽比
	public static var nScale:Number = 0.75;
	//当前地图的引用
	public static var mapNow;
	public static var screenWidth:Number=Stage.width;
	public static var screenHeight:Number=Stage.height;
	//
	private var nLeft:Number;
	private var nRight:Number;
	private var nTop:Number;
	private var nBottom:Number;
	//地图高
	public var nWidth:Number;
	//地图宽
	public var nHeight:Number;
	//加载地图的影片剪辑
	//应在这个剪辑里放置一个绝对低的影片剪辑用来存放路面的物体
	public var mClip:MovieClip;
	//存放区块用的对象
	public var obTile:Object;
	public var aObj:Array;
	//初始化地图的数组
	private var __aMap:Array;
	public function Map() {
		nTile_w_half = nTile_w/2;
		mapNow = this;
	}
	public function get aMap():Array {
		return __aMap;
	}
	//设置__aMap的时候同时给地图设定高宽以及一些界限
	public function set aMap(_aMap:Array):Void {
		__aMap = _aMap;
		nHeight = __aMap.length;
		nWidth = __aMap[0].length;
		if (nType<2) {
			nLeft = screenWidth-(nWidth-0.5)*nTile_w;
			nRight = 0.5*nTile_w;
			nTop = screenHeight-(nHeight-0.5)*nTile_w;
			nBottom = 0.5*nTile_w;
		} else {
			nLeft = screenWidth-nWidth*nTile_w;
			nRight = nHeight*nTile_w;
			nTop = screenHeight-(nWidth+nHeight)*nTile_w*nScale;
			nBottom = 0;
		}
	}
	public function addObj(_ob):Object {
		aObj.push(_ob);
		return _ob;
	}
	//初始化地图对象
	public function mapping():Void {
		obTile = {};
		aObj = [];
		for (var y:Number = 0; y<nHeight; y++) {
			for (var x:Number = 0; x<nWidth; x++) {
				var _tile:Tile=new Tile(x, y, aMap[y][x]);
				//_tile.nDepth_lv=0;
				obTile[getTileName(x, y)] = _tile;
			}
		}
	}
	//用来根据事先放到场景上的影片剪辑来初始化地图数组
	public function buildMapary(_m:MovieClip):Array {
		var bounds:Object = _m.getRect(_m);
		var xnum:Number = int((bounds.xMax+nTile_w*0.5)/nTile_w);
		var ynum:Number = int((bounds.yMax+nTile_w*0.5)/nTile_w);
		for (var each in _m) {
			var _s:String=_m[each]._name;
			if (_m[each].nValue != undefined) {
				var _s2:String= getTileName(Math.round(_m[each]._x/nTile_w), Math.round(_m[each]._y/nTile_w));
				_m[each]._name = _s2;
			}
			//trace("NAME:"+_s+"____"+_s2+"\n");
		}
		var aT:Array = [];
		var tmc:MovieClip;
		for (var i:Number = 0; i<ynum; i++) {
			aT[i] = [];
			for (var j:Number = 0; j<xnum; j++) {
				tmc = _m[getTileName(j, i)];
				if (tmc == undefined) {
					aT[i][j] = 0;
				} else {
					aT[i][j] = tmc.nValue;
				}
				/*tmc的信息已经使用完毕可以将他删除或另作处理
				比如希望保留手动摆放的地图区块
				且希望修改那些区块的合适深度，那么一开始就该将这些区块放到事先建立好的mBack或mMid里
				并将这些区块剪辑指向虚拟区块的mClip（如果用的到的话）
				*/
			}
		}
		return aT;
	}
	//将地图对象显示出来,即加载相对应得影片剪辑
	public function setClip_map(_m:MovieClip):Void {
		mClip = _m;
		if (mClip.mBack == undefined) {
			mClip.createEmptyMovieClip("mBack",0);
		}
		if (mClip.mMid == undefined) {
			mClip.createEmptyMovieClip("mMid",1);
		}
		if (mClip.mFore == undefined) {
			mClip.createEmptyMovieClip("mFore",2);
		}
		for (var i in obTile) {
			obTile[i].setClip();
		}
		for (var i in aObj) {
			aObj[i].setClip();
		}
	}
	//居中察看某个影片剪辑
	public function cameraViewMc(_m:MovieClip):Void {
		var nx:Number=screenWidth/2-_m._x;
		var ny:Number=screenHeight/2-_m._y;
		adjustMap(nx,ny);
	}
	//居中察看某点
	public function cameraViewPt(x:Number, y:Number):Void {
		var nx:Number=screenWidth/2-x;
		var ny:Number=screenHeight/2-y;
		adjustMap(nx,ny);
	}
	//地图滚动或是观察到了边界，就应该置入合适的数
	public function adjustMap(nx:Number,ny:Number):Void {
		if (nx<=nLeft) {
			mClip._x = nLeft;
		} else if (nx>=nRight) {
			mClip._x = nRight;
		} else {
			mClip._x =nx;
		}
		if (ny<=nTop) {
			mClip._y = nTop;
		} else if (ny>=nBottom) {
			mClip._y = nBottom;
		} else {
			mClip._y = ny;
		}
	}
	//返回对应横纵序区块
	public function getTile(x:Number, y:Number) {
		return obTile[getTileName(x, y)];
	}
	//返回对应横纵序区块名字
	public static function getTileName(x:Number, y:Number):String {
		return "tile_"+y+"_"+x;
	}
	//返回对应横纵序列以及深度等级的合理深度(_n:0~10)；俯视或斜俯视才用
	public static function getDepth(x:Number, y:Number, _n:Number):Number {
		var n:Number = x+y+1;
		return 10*n*(n-1)+x+n*_n;
	}
	//返回坐标对应的序列；
	public static function vpToLine(_n:Number):Number {
		return Math.round(_n/nTile_w);
	}
	//返回序列对应的坐标；
	public static function lineToVp(_n:Number):Number {
		return _n*nTile_w;
	}
	//===========================================
	//下面只在把区块地图扭曲成45度时才会用到的转换坐标的方法
	//返回坐标对应的可视x坐标；
	public static function viewX(x:Number, y:Number):Number {
		return x-y;
	}
	//返回坐标对应的可视y坐标；
	public static function viewY(x:Number, y:Number):Number {
		return (x+y)*nScale;
	}
	//返回可视坐标对应的x坐标；
	public static function vpX(x:Number, y:Number):Number {
		return (y/nScale+x)/2;
	}
	//返回可视坐标对应的y坐标；
	public static function vpY(x:Number, y:Number):Number {
		return (y/nScale-x)/2;
	}
	//根据对应横纵序列设定影片剪辑可视坐标；
	public static function vpToView(_m:MovieClip, x:Number, y:Number):Void {
		_m._x = viewX(x, y);
		_m._y = viewY(x, y);
	}
}