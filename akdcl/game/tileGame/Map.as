package 
{
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class Map extends Object
	{
		//区别游戏类型
		//public static var nType:Number=0;
		//区块宽度
		//public static var nTile_w:Number=36;
		//public static var nTile_w_half:Number;
		//斜视的区块高宽比
		//public static var nScale:Number = 0.75;
		//当前地图的引用
		//public static var screenWidth:Number=Stage.width;
		//public static var screenHeight:Number=Stage.height;
		
		//private var nLeft:Number;
		//private var nRight:Number;
		//private var nTop:Number;
		//private var nBottom:Number;
		
		//地图宽
		public var mapWidth:uint;
		//地图高
		public var mapHeight:uint;
		public var tileDic:Object;
		public function Map() {
			tileDic = { };
		}
		private var __mapAry:Array;
		public function get mapAry():Array {
			return __mapAry;
		}
		public function set mapAry(_mapAry:Array):void {
			__mapAry = _mapAry;
			mapHeight = __mapAry.length;
			mapWidth = __mapAry[0].length;
		}
		public function mapping():void {
			var _x, _y:uint = 0;
			for (_y = 0; _y < mapHeight; _y++) {
				for (_x = 0; _x < mapWidth; _x++) {
					//var _tile:Tile=new Tile(x, y, aMap[y][x]);
					//_tile.nDepth_lv=0;
					//obTile[getTileName(x, y)] = _tile;
				}
			}
		}
		/*//用来根据事先放到场景上的影片剪辑来初始化地图数组
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
					//tmc的信息已经使用完毕可以将他删除或另作处理
					//比如希望保留手动摆放的地图区块
					//且希望修改那些区块的合适深度，那么一开始就该将这些区块放到事先建立好的mBack或mMid里
					//并将这些区块剪辑指向虚拟区块的mClip（如果用的到的话）
					
				}
			}
			return aT;
		}*/
		//返回对应横纵序区块
		public function getTile(_x:uint, _y:uint):* {
			return tileDic[getTileName(_x, _y)];
		}
		//返回对应横纵序区块名字
		public static function getTileName(_x:uint, _y:uint):String {
			return "tile_" + _y + "_" + _x;
		}
	}
}