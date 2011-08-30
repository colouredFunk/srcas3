package akdcl.media {
	import akdcl.utils.PageID;

	/**
	 * ...
	 * @author ...
	 */
	public class MediaPlayer extends MediaProvider {
		private var imagePD:ImageProvider;
		private var soundPD:SoundProvider;
		private var videoPD:VideoProvider;
		private var wmpPD:WMPProvider;

		private var pageID:PageID;
		private var contentPDList:Array;

		//播放列表
		private var __playlist:Playlist;

		public function get playlist():Playlist {
			return __playlist;
		}

		public function set playlist(_playlist:*):void {
			_playlist = Playlist.createList(_playlist);
			if (!_playlist){
				return;
			}
			stop();
			__playlist = _playlist;
			pageID.length = __playlist.length;
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
			contentPDList = [];
			imagePD = new ImageProvider();
			soundPD = new SoundProvider();
			videoPD = new VideoProvider();
			wmpPD = new WMPProvider();
			pageID = new PageID();
			pageID.onIDChange = onPlayIDChangeHandler;
		}

		private function onPlayIDChangeHandler(_id:uint):void {
			stop();
			var _content:MediaProvider;
			for each (_content in contentPDList){
				_content.removeEventListener(MediaEvent.BUFFER_PROGRESS, onBufferProgressHandler);
				_content.removeEventListener(MediaEvent.LOAD_ERROR, onLoadErrorHandler);
				_content.removeEventListener(MediaEvent.LOAD_PROGRESS, onLoadProgressHandler);
				_content.removeEventListener(MediaEvent.LOAD_COMPLETE, onLoadCompleteHandler);
				_content.removeEventListener(MediaEvent.PLAY_COMPLETE, onPlayCompleteHandler);
			}

			var _item:PlayItem = playlist.getItem(_id);
			var _source:String = _item.source;
			var _type:String = _source.split("?")[0];
			_type = String(_type.split(".").pop()).toLowerCase();
			switch (_type){
				case "gif":
				case "jpg":
				case "png":
				case "swf":
					imagePD.load(_source);
					contentPDList[0] = imagePD;
					break;
				case "mp3":
				case "wav":
					soundPD.load(_source);
					contentPDList[0] = soundPD;
					break;
				case "flv":
				case "mov":
				case "mp4":
				case "f4v":
					videoPD.load(_source);
					contentPDList[0] = videoPD;
					break;
				case "wma":
				case "wmv":
				case "mms":
					wmpPD.load(_source);
					contentPDList[0] = wmpPD;
				default:
					break;
			}
			for each (_content in contentPDList){
				_content.addEventListener(MediaEvent.BUFFER_PROGRESS, onBufferProgressHandler);
				_content.addEventListener(MediaEvent.LOAD_ERROR, onLoadErrorHandler);
				_content.addEventListener(MediaEvent.LOAD_PROGRESS, onLoadProgressHandler);
				_content.addEventListener(MediaEvent.LOAD_COMPLETE, onLoadCompleteHandler);
				_content.addEventListener(MediaEvent.PLAY_COMPLETE, onPlayCompleteHandler);
			}
			play();
		}

		override public function load(_source:String):void {
			playlist = _source;
		}

		override public function play(_startTime:int = -1):void {
			if (playID < 0){
				playID = 0;
				return;
			}
			for each (var _content:MediaProvider in contentPDList){
				_content.play(_startTime);
			}
			super.play(_startTime);
		}

		override public function pause():void {
			for each (var _content:MediaProvider in contentPDList){
				_content.pause();
			}
			super.pause();
		}

		override public function stop():void {
			for each (var _content:MediaProvider in contentPDList){
				_content.stop();
			}
			super.stop();
		}

		public function next():void {
			playID++;
		}

		public function prev():void {
			playID--;
		}

		override protected function onLoadErrorHandler(_evt:* = null):void {
			if (playlist.length() == 1){
				//如果播放列表只有一个源，则停止播放
				stop();
			} else {
				//根据repeat的值执行下一步
				onPlayCompleteHandler();
			}
			super.onLoadErrorHandler(_evt);
		}

		override protected function onPlayCompleteHandler(_evt:* = null):void {
			switch (repeat){
				case 0:
					stop();
					break;
				case 1:
					stop();
					play();
					break;
				case 2:
					if (playID == playlist.length - 1){
						stop();
					} else {
						next();
					}
					break;
				case 3:
					if (playlist.length == 1){
						stop();
						play();
					} else {
						next();
					}
					break;
				case 4:
					//待完善
					stop();
					break;
			}
			super.onPlayCompleteHandler(_evt);
		}
	}

}