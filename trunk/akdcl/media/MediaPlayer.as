package akdcl.media {
	import akdcl.utils.PageID;

	/**
	 * ...
	 * @author ...
	 */
	public class MediaPlayer extends MediaProvider {
		//格式化播放列表
		public static var SOURCE_ID:String = "source";

		public static function createList(_list:*):XMLList {
			var _xml:XML;
			if ((_list is String) || (_list is Array)){
				if (_list is String){
					//将字符串按"|"格式成数组
					_list = _list.split("|");
				}
				_xml =    <root/>;
				for each (var _each:String in _list){
					_xml.appendChild(<list source={_each}/>);
				}
				_list = _xml.list;
			} else if (_list is XMLList || _list is XML){
				if (_list is XML){
					//取XML中的"list"列表
					_list = _list.list;
				}
				if (_list.attribute(SOURCE_ID).length() == 0){
					return null;
				}
			} else {
				return null;
			}
			return _list;
		}

		private var pageID:PageID;

		//播放列表
		private var __playlist:XMLList;

		public function get playlist():XMLList {
			return __playlist;
		}

		public function set playlist(_playlist:*):void {
			_playlist = createList(_playlist);
			if (!_playlist){
				return;
			}
			stop();
			__playlist = _playlist;
			pageID.length = __playlist.length();
			//dispatchEvent(new MediaEvent(MediaEvent.LIST_CHANGE));
		}

		//当前播放列表位置
		public function get playID():int {
			return pageID.id;
		}

		public function set playID(_playID:int):void {
			pageID.id = _playID;
		}
		//0:不循环，1:单首循环，2:顺序循环(全部播放完毕后停止)，3:顺序循环，4:随机播放
		private var __repeat:uint = 3;

		public function get repeat():uint {
			return __repeat;
		}

		public function set repeat(_repeat:uint):void {
			__repeat = _repeat;
		}

		override protected function init():void {
			super.init();
			pageID = new PageID();
			pageID.onIDChange = onPlayIDChangeHandler;
		}

		private function onPlayIDChangeHandler(_id:uint):void {
			stop();
			var _source:String = getMediaByID(_id);
			var _type:String = _source.split("?")[0];
			_type = String(_type.split(".").pop()).toLowerCase();
			switch(_type) {
				case "mp3":
				case "wav":
					break;
				case "gif":
				case "jpg":
				case "png":
					break;
				case "flv":
				case "mov":
				case "mp4":
				case "f4v":
					break;
				case "wma":
				case "wmv":
				case "mms":
				default:
					break;
			}
			play();
		}
	}

}