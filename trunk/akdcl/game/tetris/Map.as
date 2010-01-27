package akdcl.game.tetris
{
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class  Map
	{
		public var mapWidth:uint = 20;
		public var mapHeight:uint = 20;
		
		private var mapArray:Array;
		public var perLineY:Array;
		public function Map() {
			
		}
		public function resetMap():void {
			mapArray = [];
			perLineY = [];
			var _x, _y:uint;
			for (_x = 0; _x < mapWidth; _x++) {
				perLineY.push(false);
			}
			for (_y = 0; _y < mapHeight; _y++) {
				mapArray.push(perLineY.concat());
			}
		}
		public function clone():Array {
			return Common.clone(mapArray);
		}
		public function getMap(_x:uint, _y:uint):Boolean {
			if (mapArray && mapArray[_y]) {
				if (mapArray[_y][_x]!=null) {
					return mapArray[_y][_x];
				}else {
					return true;
				}
			}
			return true;
		}
		public function setMap(_x:uint, _y:uint, _flag:Boolean):void {
			mapArray[_y][_x] = _flag;
		}
		public function clearLineY(_id:uint):void {
			mapArray.splice(_id, 1);
		}
		public function addLineY():void {
			mapArray.unshift(perLineY.concat());
		}
		public function getFullLineYId():Array {
			var _fullLine:Array = [];
			var _isFull:Boolean;
			for (var _i:int = mapHeight - 1; _i >= 0; _i-- ) {
				_isFull = true;
				for each(var _e:Boolean in mapArray[_i]) {
					if (!_e) {
						_isFull = false;
						break;
					}
				}
				if (_isFull) {
					_fullLine.push(_i);
				}
			}
			return _fullLine;
		}
	}
}