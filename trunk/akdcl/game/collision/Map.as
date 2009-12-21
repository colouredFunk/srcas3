package akdcl.game.collision
{
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class  Map
	{
		
		public static const VALUE_STONE:uint = 1;
		public static const VALUE_BOMB:uint = 2;
		public static const VALUE_OTHERITEM:uint = 3;
		public static var mapWidth:uint = 12;
		public static var mapHeight:uint = 6;
		public static var picMax:uint = 20;
		public static var picCount:uint = 10;
		public static var picMin:uint;
		
		private var mapArray:Array;
		private var eachCount:Array;
		private var eachLimit:Array;
		private var eachTotal:uint;
		public var addDic:Object;
		private var hintArray:Array;
		public function Map() {
			eachCount = [];
			eachLimit = [];
			for (var _i:uint; _i < picMax; _i++) {
				eachCount[_i] = 0;
				eachLimit[_i] = 1;
			}
			eachLimit[1]=0.01;
			eachLimit[2]=0.03;
			eachLimit[3]=0.02;
		}
		public function resetPicCount():void {
			picMin = Map.mapHeight * Map.mapWidth / 10;
			if (picMin>picMax) {
				picMin = picMax;
			}
			picCount = picMin;
			if (picCount > picMax) {
				picCount = picMax;
			}
		}
		public function getArray():void {
			if (picCount > picMax) {
				picCount = picMax;
			}
			mapArray = [];
			var _mapX:Array;
			var _x, _y, _n:uint;
			for (_y = 0; _y < mapHeight; _y++) {
				_mapX = [];
				for (_x = 0; _x < mapWidth; _x++) {
					//do {
						_n = getTileValue();
					//} while (checkEachTile(_x, _y, _n));
					_mapX.push(_n);
				}
				mapArray.push(_mapX);
			}
		}
		//0为空
		//1~picMax:1石头（无法移动），2炸弹（炸毁石头），3道具（随机获得道具），其他正常（1,2,3需控制出现几率）
		public function getTileValue():uint {
			var _n:uint;
			do {
				_n = Math.floor(Math.random() * picCount) + 1;
				/*if (_n==1) {
					trace(eachCount[_n]+"____"+eachCount[_n] / eachTotal+"___"+eachLimit[_n]);
				}*/
			}while (eachCount[_n] / eachTotal > eachLimit[_n]);
			eachCount[_n]++;
			eachTotal++;
			return _n;
		}
		//洗牌
		public function shuffle():void{
			var _aryLine:Array = [];
			var _x, _y:uint;
			for (_y = 0; _y < mapHeight; _y++) {
				for (_x = 0; _x < mapWidth; _x++) {
					_aryLine.push(mapArray[_y][_x]);
				}
			}
			_aryLine.sort(randomSort);
			for (_y = 0; _y < mapHeight; _y++) {
				for (_x = 0; _x < mapWidth; _x++) {
					mapArray[_y][_x] = _aryLine.splice(0, 1)[0];
				}
			}
		}
		public function getMap(_x:uint, _y:uint):int {
			return mapArray[_y][_x];
		}
		public function setMap(_x:uint, _y:uint, _value:int):void {
			mapArray[_y][_x] = _value;
		}
		public function getAllStones():Array {
			resetAddDic();
			var _x, _y:uint;
			var _aryLine:Array = [];
			for (_y = 0; _y < mapHeight; _y++) {
				for (_x = 0; _x < mapWidth; _x++) {
					if (mapArray[_y][_x]==VALUE_STONE) {
						_aryLine.push([_x, _y]);
						addToDic(_x);
					}
				}
			}
			return (_aryLine.length>0)?[_aryLine]:[];
		}
		public function getLineX(_line:uint):Array {
			if (_line > mapWidth - 1) {
				_line = mapWidth - 1;
			}
			resetAddDic();
			var _aryLine:Array = [];
			for (var _i:int; _i < mapHeight;_i++ ) {
				_aryLine.push([_line, _i]);
				addToDic(_line);
			}
			return [_aryLine];
		}
		public function getLineY(_line:uint):Array {
			if (_line > mapHeight - 1) {
				_line = mapHeight - 1;
			}
			resetAddDic();
				
			var _aryLine:Array = [];
			for (var _i:int; _i < mapWidth;_i++ ) {
				_aryLine.push([_i,_line]);
				addToDic(_i);
			}
			return [_aryLine];
		}
		//检查单个，有待完善
		public function canRemove(_x:uint, _y:uint, _n:uint):Boolean {
			var _i:int;
			var _ary:Array = ["x:" + _x + "  y:" + _y + " n:" + _n + "\n"];
			var _countNum:uint = 1;
			for (_i = _x - 1; _i >= 0; _i--) {
				if (mapArray[_y] == null || mapArray[_y][_i] != _n) {
					break;
				}
				_ary.push("x:" + _i + "  y:" + _y + " n:" + mapArray[_y][_i] + "\n");
				_countNum++;
			}
			for (_i = _x + 1; _i < mapWidth; _i++) {
				if (mapArray[_y] == null || mapArray[_y][_i] != _n) {
					break;
				}
				_ary.push("x:" + _i + "  y:" + _y + " n:" + mapArray[_y][_i] + "\n");
				_countNum++;
			}
			if (_countNum > 2) {
				//trace("—");
				//trace(_ary);
				return true;
			}
			_ary = ["x:" + _x + "  y:" + _y + " n:" + _n + "\n"];
			_countNum = 1;
			for (_i = _y - 1; _i >= 0; _i--) {
				if (mapArray[_i] == null || mapArray[_i][_x] != _n) {
					break;
				}
				_ary.push("x:" + _x + "  y:" + _i + " n:" + mapArray[_i][_x] + "\n");
				_countNum++;
			}
			for (_i = _y + 1; _i < mapHeight; _i++) {
				if (mapArray[_i] == null || mapArray[_i][_x] != _n) {
					break;
				}
				_ary.push("x:" + _x + "  y:" + _i + " n:" + mapArray[_i][_x] + "\n");
				_countNum++;
			}
			if (_countNum > 2) {
				//trace("|");
				//trace(_ary);
				return true;
			}
			return false;
		}
		public function getSame(_n:uint):Array {
			var _x, _y:uint;
			var _aryLine:Array = [];
			resetAddDic();
				
			for (_y = 0; _y < mapHeight; _y++) {
				for (_x = 0; _x < mapWidth; _x++) {
					if (_n!=getMap(_x,_y)) {
						continue;
					}
					_aryLine.push([_x, _y]);
					addToDic(_x);
				}
			}
			return [_aryLine];
		}
		public function getRight():Array {
			var _x, _y, _n:uint;
			var _i, _j:uint;
			var _countNum:uint;
			var _ary:Array = [];
			var _aryLine:Array;
			var _dic:Object = { };
			resetAddDic();
			//横向搜索:
			for (_y = 0; _y < mapHeight; _y++) {
				for (_x = 0; _x < mapWidth - 2; _x++) {
					_countNum = 1;
					_n = mapArray[_y][_x];
					_i = _x + 1;
					while (_i < mapWidth) {
						if (!mapArray[_y][_i]|| mapArray[_y][_i] != _n) {
							break;
						}
						_countNum++;
						_i++;
					}
					if (_countNum > 2) {
						_aryLine = [];
						for (_j = _x; _j < _i; _j++) {
							if (_dic["t_" + _j + "_" + _y]) {
								continue;
							}
							_dic["t_" + _j + "_" + _y] = _aryLine;
							_aryLine.push([_j, _y]);
							addToDic(_j);
						}
						_ary.push(_aryLine);
						_x = _i;
					}
				}
			}
			//纵向搜索:
			for (_x = 0; _x < mapWidth; _x++) {
				for (_y = 0; _y < mapHeight - 2; _y++) {
					_countNum = 1;
					_n = mapArray[_y][_x];
					_i = _y + 1;
					while (_i < mapHeight) {
						if (!mapArray[_i][_x] || mapArray[_i][_x] != _n) {
							break;
						}
						_countNum++;
						_i++;
					}
					if (_countNum>2) {
						_aryLine = [];
						for (_j = _y; _j < _i; _j++) {
							if (_dic["t_" + _x + "_" + _j]) {
								continue;
							}
							_dic["t_" + _x + "_" + _j] = _aryLine;
							_aryLine.push([_x, _j]);
							addToDic(_x);
						}
						_ary.push(_aryLine);
						_y = _i;
					}
				}
			}
			return _ary;
		}
		public function isStone(_x:uint, _y:uint):Boolean {
			return isSame(_x, _y, VALUE_STONE);
		}
		private var arrayChack_0:Array = [	[[ -1, -1], [ 0, -2], [ 1, -1]],
											[[ -1, 2], [ 0, 3], [ 1, 2]]];
		private var arrayChack_1:Array = [[ -1, 1], [ 1, 1]];
		public function findRoad():Boolean{
			//前提必须!的值不为1才可以移动
			//任一个数为A有解
			//一                二
			//  X  2  X     或者 X  1  X  X  4  X
			//  1  !  3          2  !  A  a  !  5
			//  X  A  X          X  3  X  X  6  X
			//  X  a  X
			//  4  !  6
			//  X  5  X
			//
			//三                四
			//  X  A  X          X  1  X
			//  1  !  2     或者 A  !  a
			//  X  a  X          X  2  X
			var _x, _y, _n:uint;
			var _xM, _yM:uint;
			var _xMt, _yMt:uint;
			var _eA:Array;
			for (_y = 0; _y < mapHeight; _y++) {
				for (_x = 0; _x < mapWidth; _x++) {
					_n = mapArray[_y][_x];
					if (isSame(_x, _y + 1, _n)) {
						//图一
						//检测 123
						_xMt = _x, _yMt = _y - 1;
						if (!isStone(_xMt,_yMt)) {
							for each(_eA in arrayChack_0[0]) {
								_xM = _x + _eA[0], _yM = _y + _eA[1];
								if (isSame(_xM, _yM, _n)) { 
									addHint(_xM, _yM, _xMt, _yMt);
									return true;
								}
							}
						}
						//检测 456
						_xMt = _x, _yMt = _y + 2;
						if (!isStone(_xMt, _yMt)) {
							for each(_eA in arrayChack_0[1]) {
								_xM = _x + _eA[0], _yM = _y + _eA[1];
								if (isSame(_xM, _yM, _n)) { 
									addHint(_xM, _yM, _xMt, _yMt);
									return true;
								}
							}
						}
					}
					if (isSame(_x, _y + 2, _n)) {
						//图三
						//检测 12
						_xMt = _x, _yMt = _y + 1;
						if (!isStone(_xMt, _yMt)) {
							for each(_eA in arrayChack_1) {
								_xM = _x + _eA[0], _yM = _y + _eA[1];
								if (isSame(_xM, _yM, _n)) { 
									addHint(_xM, _yM, _xMt, _yMt);
									return true;
								}
							}
						}
					}
					if (isSame(_x + 1, _y, _n)) {
						//图二
						//检测 123
						_xMt = _x - 1, _yMt = _y;
						if (!isStone(_xMt, _yMt)) {
							for each(_eA in arrayChack_0[0]) {
								_xM = _x + _eA[1], _yM = _y + _eA[0];
								if (isSame(_xM, _yM, _n)) { 
									addHint(_xM, _yM, _xMt, _yMt);
									return true;
								}
							}
						}
						//检测 456
						_xMt = _x + 2, _yMt = _y;
						if (!isStone(_xMt, _yMt)) {
							for each(_eA in arrayChack_0[1]) {
								_xM = _x + _eA[1], _yM = _y + _eA[0];
								if (isSame(_xM, _yM, _n)) { 
									addHint(_xM, _yM, _xMt, _yMt);
									return true;
								}
							}
						}
					}
					if (isSame(_x + 2, _y, _n)) {
						//图四
						//检测 12
						_xMt = _x + 1, _yMt = _y;
						if (!isStone(_xMt, _yMt)) {
							for each(_eA in arrayChack_1) {
								_xM = _x + _eA[1], _yM = _y + _eA[0];
								if (isSame(_xM, _yM, _n)) { 
									addHint(_xM, _yM, _xMt, _yMt);
									return true;
								}
							}
						}
					}
				}
			}
			return false;
		}
		private function resetAddDic():void {
			addDic = { };
		}
		private function addToDic(_lineX:uint):void {
			if (addDic[_lineX]) {
				addDic[_lineX]++;
			}else {
				addDic[_lineX] = 1;
			}
		}
		private function isSame(_x:uint, _y:uint, _n:uint):Boolean {
			var _b:Boolean;
			_b = _x >= 0 && _x < mapWidth && _y >= 0 && _y < mapHeight;
			_b = _b && mapArray[_y][_x] == _n;
			return _b;
		}
		public function getHint():Array {
			//resetAddDic();
			//addToDic(hintArray[0][0]);
			//addToDic(hintArray[1][0]);
			return hintArray.concat();
		}
		public function checkMap():void {
			for (var _y:uint = 0; _y<mapHeight; _y++) {
				trace(mapArray[_y]);
			}
		}
		private function addHint(c1:uint,r1:uint,c2:uint,r2:uint):void{
			hintArray = [[c1, r1], [c2, r2]];
		}
		private static function randomSort(_a:Object,_b:Object):int{
			return Math.pow(-1,Math.floor(Math.random()*2));
		}
	}
}