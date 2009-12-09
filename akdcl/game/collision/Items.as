package akdcl.game.collision
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class Items
	{
		public static const TYPE_BOMB:uint = 1;
		public static const TYPE_HINT:uint = 2;
		public static const TYPE_SHUFFLE:uint = 3;
		public static const TYPE_SAME:uint = 4;
		public static const TYPE_LINEX:uint = 5;
		public static const TYPE_LINEY:uint = 6;
		public static const TYPE_ADDTIME:uint = 7;
		public static const ITEMS_MAX:uint = 7;
		public static var itemLength:uint = 3;
		private var itemList:Array;
		public function Items() {
			itemList = [];
			//1石头消除
			//2提示getHint();自动
			//3刷新shuffle();自动
			//4同色消除removeAllRight(1,_n);手动
			//5横排消除removeAllRight(2,_x);手动
			//6竖排消除removeAllRight(3,_y);手动
			//7增加50%游戏时间
		}
		public function addItem(_type:int = -1, _value:uint = 0, _remain:uint = 1):Boolean {
			if (_type<0) {
				_type = Math.floor(Math.random() * (ITEMS_MAX - 1)) + 1 + 1;
				switch(_type) {
					case TYPE_HINT:
						_remain = 3;
						break;
				}
			}
			var _item:Item;
			for (var _i:uint; _i < itemList.length; _i++ ) {
				_item = itemList[_i];
				if (_item.isSame(_type, _value)) {
					_item.remain += _remain;
					updata();
					return true;
				}
			}
			if (_i < itemLength) {
				_item = new Item(_type, _value);
				_item.remain = _remain;
				itemList.push(_item);
				updata();
				return true;
			}
			return false;
		}
		public function useItem(_id:uint):void {
			var _item:Item = itemList[_id];
			if (!_item) {
				return;
			}
			itemUsed(_item);
			_item.remain--;
			if (_item.remain == 0) {
				itemList.splice(_id, 1);
			}
			updata();
		}
		private function itemUsed(_item:Item):void {
			switch(_item.type) {
				case TYPE_BOMB:
					Collision.instance.removeAllRight(4);
					break;
				case TYPE_HINT:
					Collision.instance.getHint();
					break;
				case TYPE_SHUFFLE:
					Collision.instance.shuffle();
					break;
				case TYPE_SAME:
					Collision.instance.removeAllRight(1,Math.floor(Math.random() * (Map.picCount - 3)) + 1 + 3);
					break;
				case TYPE_LINEX:
					Collision.instance.removeAllRight(2,Math.floor(Math.random() *Map.mapWidth));
					break;
				case TYPE_LINEY:
					Collision.instance.removeAllRight(3,Math.floor(Math.random() *Map.mapHeight));
					break;
				case TYPE_ADDTIME:
					Collision.instance.time-= Collision.instance.timeTotal * 0.5;
					break;
			}
		}
		public var onEachUpdata:Function;
		public function updata():void {
			var _item:Item;
			for (var _i:uint; _i < itemLength; _i++ ) {
				_item = itemList[_i];
				if (onEachUpdata!=null) {
					onEachUpdata(_item,_i);
				}
			}
		}
		public function checkItems():void {
			for each(var _item:Item in itemList) {
				trace(_item.toString());
			}
			trace("\n________________");
		}
	}
}