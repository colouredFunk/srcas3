package akdcl.utils {

	dynamic public class NetClient {
		public static const CUE_POINT:String = "cuePoint";
		public static const IMAGE_DATA:String = "imageData";
		public static const META_DATA:String = "metaData";
		public static const COMPLETE:String = "complete";
		public static const PLAY_STATUS:String = "playStatus";
		public static const SEEK_POINT:String = "SeekPoint";
		public static const TEXT_DATA:String = "textData";
		public static const XMP_DATA:String = "xmpData";

		public static const CODE_SWITCH:String = "NetStream.Play.Switch";
		public static const CODE_COMPLETE:String = "NetStream.Play.Complete";
		public static const CODE_TRANSITIONCOMPLETE:String = "NetStream.Play.TransitionComplete";

		private var callback:Function;

		public function NetClient(_callback:Function):void {
			setCallback(_callback);
		}

		public function setCallback(_callback:Function):void {
			callback = _callback;
		}

		private function forward(_event:Object, _type:String):void {
			var _eventCopy:Object = {};
			for (var _i:String in _event){
				_eventCopy[_i] = _event[_i];
			}
			if (callback != null){
				callback(_eventCopy, _type);
			}
		}

		//name:String,parameters:Array,time:uint(second),type:String
		public function onCuePoint(_event:Object):void {
			forward(_event, CUE_POINT);
		}

		//data:ByteArray
		public function onImageData(_event:Object):void {
			forward(_event, IMAGE_DATA);
		}

		/*
		   seekpoints:Array,
		   videoframerate:uint,
		   duration:Number(second),
		   moovposition:uint,
		   width:uint,
		   height:uint,
		   avcprofile:uint,
		   videocodecid:String,
		   audiocodecid:String,
		   audiosamplerate:uint,
		   aacaot:uint,
		   audiochannels:uint,
		   avclevel:uint,
		   trackinfo:Array,
		   language:String,
		   length:uint
		 */
		public function onMetaData(_event:Object):void {
			forward(_event, META_DATA);
		}

		//code:String
		public function onPlayStatus(... args):void {
			for each (var _arg:*in args){
				if (_arg && _arg.hasOwnProperty("code")){
					if (_arg.code == CODE_COMPLETE){
						forward(_arg, COMPLETE);
						continue;
					}
					forward(_arg, PLAY_STATUS);
				}
			}
		}

		public function onSeekPoint(... args):void {
			forward(args[0], SEEK_POINT);
		}

		public function onTextData(_event:Object):void {
			forward(_event, TEXT_DATA);
		}

		public function onXMPData(... args):void {
			forward(args[0], XMP_DATA);
		}
	}
}
