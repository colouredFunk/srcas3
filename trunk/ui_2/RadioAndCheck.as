package ui_2
{
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class RadioAndCheck 
	{
		private static var groupItemDic:Object = { };
		private static var groupSelectDic:Object = { };
		private static var groupParamsDic:Object = { };
		public static function addToGroup(_groupName:String, _item:*):void {
			if (!groupItemDic[_groupName]) {
				groupItemDic[_groupName] = new Array();
				groupSelectDic[_groupName] = new Array();
				setLimit(_groupName, 0);
			}
			/*if (_n != 0 && obGroup[_s+"_limit"]<_n) {
				obGroup[_s+"_limit"] = _n;
			}*/
			groupItemDic[_groupName].push(_item);
		}
		public static function removeFromGroup(_groupName:String, _item:*):void {
			Common.removeFromArray(groupItemDic[_groupName], _item);
			Common.removeFromArray(groupSelectDic[_groupName], _item);
		}
		public static function selectItem(_groupName:String, _item:*):Boolean {
			var _limit:uint = getLimit(_groupName);
			var _groupSelect:Array = groupSelectDic[_groupName];
			if (_limit == 0) {
				if (_groupSelect[0]) {
					getRadioUnselectFun(_groupName)(_groupSelect[0]);
					unselectItem(_groupName, _groupSelect[0]);
				}
				_groupSelect.push(_item);
				return true;
			}else if (_limit > _groupSelect.length) {
				_groupSelect.push(_item);
				return true;
			} else {
				return false;
			}
		}
		public static function unselectItem(_groupName:String, _item:*):void {
			Common.removeFromArray(groupSelectDic[_groupName], _item);
		}
		private static const KEY_LIMIT:String = "limit";
		private static const KEY_RADIO_UNSELECT_FUN:String = "radioUnselectFun";
		public static function getRadioUnselectFun(_groupName:String):Function {
			return groupParamsDic[_groupName + KEY_RADIO_UNSELECT_FUN];
		}
		public static function setRadioUnselectFun(_groupName:String, _fun:Function):void {
			groupParamsDic[_groupName + KEY_RADIO_UNSELECT_FUN] = _fun;
		}
		public static function getLimit(_groupName:String):uint {
			return int(groupParamsDic[_groupName + KEY_LIMIT]);
		}
		public static function setLimit(_groupName:String, _limit:uint, _auto:Boolean = true):void {
			if (_auto?(getLimit(_groupName)< _limit):true) {
				groupParamsDic[_groupName + KEY_LIMIT] = _limit;
			}else {
				
			}
			if (_limit==0) {
				setRadioUnselectFun(_groupName,unSelectItemFun);
			}
		}
		private static function unSelectItemFun(_item:*):void {
			_item.select = false;
		}
	}
	
}