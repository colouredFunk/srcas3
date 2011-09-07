package akdcl.media {
	import akdcl.utils.PageID;

	/**
	 * ...
	 * @author ...
	 */
	/// @eventType	akdcl.media.MediaEvent.LIST_CHANGE
	[Event(name="listChange",type="akdcl.media.MediaEvent")]

	/// @eventType	akdcl.media.MediaEvent.PLAY_ITEM_CHANGE
	[Event(name="playItemChange",type="akdcl.media.MediaEvent")]

	public class MediaPlayer extends MediaProvider {
		private var imagePD:ImageProvider;
		private var soundPD:SoundProvider;
		private var videoPD:VideoProvider;
		private var wmpPD:WMPProvider;

		private var pageID:PageID;
		private var providers:Array;

		override public function get loadProgress():Number {
			var _progress:Number = 1;
			for each (var _content:MediaProvider in playContent){
				_progress = Math.min(_content.loadProgress, _progress);
			}
			return _progress;
		}

		override public function get totalTime():uint {
			var _time:uint = 0;
			for each (var _content:MediaProvider in playContent){
				_time = Math.max(_content.totalTime, _time);
			}
			return _time;
		}

		override public function get bufferProgress():Number {
			var _progress:Number = 1;
			for each (var _content:MediaProvider in playContent){
				_progress = Math.min(_content.bufferProgress, _progress);
			}
			return _progress;
		}

		override public function get position():uint {
			var _time:uint = 0;
			for each (var _content:MediaProvider in playContent){
				_time = Math.max(_content.position, _time);
			}
			return _time;
		}

		override public function get volume():Number {
			return super.volume;
		}

		override public function set volume(value:Number):void {
			super.volume = value;
			for each (var _content:MediaProvider in providers){
				_content.volume = volume;
			}
		}

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
			dispatchEvent(new MediaEvent(MediaEvent.LIST_CHANGE));
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

		private var __container:DisplayRect;
		public function get container():DisplayRect {
			return __container;
		}
		public function MediaPlayer(_container:DisplayRect = null) {
			if (_container) {
				__container = _container;
			}
		}

		override protected function init():void {
			super.init();
			imagePD = new ImageProvider();
			soundPD = new SoundProvider();
			videoPD = new VideoProvider();
			wmpPD = new WMPProvider();
			providers = [soundPD, videoPD, wmpPD, imagePD];
			playContent = [];
			pageID = new PageID();
			pageID.onIDChange = onPlayIDChangeHandler;
			if (!__container) {
				__container = new DisplayRect();
				__container.autoRemove = false;
			}
		}
		override public function remove():void {
			__container.remove();
			super.remove();
		}

		private function onPlayIDChangeHandler(_id:uint):void {
			var _content:MediaProvider;
			for each (_content in playContent) {
				_content.removeEventListener(MediaEvent.BUFFER_PROGRESS, onBufferProgressHandler);
				_content.removeEventListener(MediaEvent.LOAD_ERROR, onLoadErrorHandler);
				_content.removeEventListener(MediaEvent.LOAD_PROGRESS, onLoadProgressHandler);
				_content.removeEventListener(MediaEvent.LOAD_COMPLETE, onLoadCompleteHandler);
				_content.removeEventListener(MediaEvent.PLAY_COMPLETE, onPlayCompleteHandler);
				
				if (_content.hasOwnProperty("container")){
					_content["container"] = null;
				}
				if (_content.playState!=PlayState.COMPLETE) {
					_content.stop();
				}
			}

			playItem = playlist.getItem(_id);
			__container.label = playItem.source;
			var _type:String = playItem.source.split("?")[0];
			_type = String(_type.split(".").pop()).toLowerCase();
			switch (_type){
				case "gif":
				case "jpg":
				case "png":
				case "swf":
					imagePD.load(playItem);
					playContent[0] = imagePD;
					break;
				case "mp3":
				case "wav":
					soundPD.load(playItem);
					playContent[0] = soundPD;
					break;
				case "flv":
				case "mov":
				case "mp4":
				case "f4v":
					videoPD.load(playItem);
					playContent[0] = videoPD;
					break;
				case "wma":
				case "wmv":
				case "mms":
				default:
					wmpPD.load(playItem);
					playContent[0] = wmpPD;
					break;
			}
			for each (_content in playContent){
				if (_content.hasOwnProperty("container")){
					_content["container"] = __container;
				}
				_content.addEventListener(MediaEvent.BUFFER_PROGRESS, onBufferProgressHandler);
				_content.addEventListener(MediaEvent.LOAD_ERROR, onLoadErrorHandler);
				_content.addEventListener(MediaEvent.LOAD_PROGRESS, onLoadProgressHandler);
				_content.addEventListener(MediaEvent.LOAD_COMPLETE, onLoadCompleteHandler);
				_content.addEventListener(MediaEvent.PLAY_COMPLETE, onPlayCompleteHandler);
			}
			dispatchEvent(new MediaEvent(MediaEvent.PLAY_ITEM_CHANGE));
			play(0);
		}

		override public function load(_item:*):void {
			super.load(null);
			playlist = _item;
		}

		override public function play(_startTime:int = -1):void {
			if (playID < 0){
				playID = 0;
				return;
			}
			for each (var _content:MediaProvider in playContent){
				_content.play(_startTime);
			}
			super.play(_startTime);
		}

		override public function pause():void {
			for each (var _content:MediaProvider in playContent){
				_content.pause();
			}
			super.pause();
		}

		override public function stop():void {
			for each (var _content:MediaProvider in playContent){
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
			if (playlist.length == 1){
				//如果播放列表只有一个源，则停止播放
				super.onLoadErrorHandler(_evt);
			} else {
				//根据repeat的值执行下一步
				onPlayCompleteHandler(false);
			}
		}

		override protected function onPlayCompleteHandler(_evt:* = null):void {
			super.onPlayCompleteHandler(_evt);
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
		}
	}

}