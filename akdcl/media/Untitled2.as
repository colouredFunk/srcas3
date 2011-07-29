package com.greensock.loading {
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.core.LoaderItem;
	import com.greensock.loading.display.ContentDisplay;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.NetStatusEvent;
	import flash.events.ProgressEvent;
	import flash.events.TimerEvent;
	import flash.media.SoundTransform;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	
	[Event(name = "httpStatus", 	type = "com.greensock.events.LoaderEvent")]
	[Event(name = "netStatus", 	type = "flash.events.NetStatusEvent")]
	
	public class VideoLoader extends LoaderItem {
		
		/** @private **/
		protected var netStream:NetStream;
		/** @private **/
		protected var _forceTime:Number;
		/** @private **/
		protected var _duration:Number;
		/** @private **/
		protected var _prevTime:Number;
		/** @private **/
		protected var _firstCuePoint:CuePoint;
		
		/** @private **/
		protected var isPaused:Boolean;
		/** @private **/
		protected var isVideoComplete:Boolean;
		/** @private **/
		protected var isPausePending:Boolean;
		/** @private **/
		protected var isInitted:Boolean;
		/** @private **/
		protected var isBufferFull:Boolean;
		/** @private **/
		protected var _dispatchPlayProgress:Boolean;
		/** @private due to a bug in the NetStream class, we cannot seek() or pause() before the NetStream has dispatched a RENDER Event (or after 50ms for Flash Player 9). **/
		protected var isRenderedOnce:Boolean;
		
		/** The metaData that was received from the video (contains information about its width, height, frame rate, etc.). See Adobe's docs for information about a NetStream's onMetaData callback. **/
		public var metaData:Object;
		/** If the buffer becomes empty during playback and <code>autoAdjustBuffer</code> is <code>true</code> (the default), it will automatically attempt to adjust the NetStream's <code>bufferTime</code> based on the rate at which the video has been loading, estimating what it needs to be in order to play the rest of the video without emptying the buffer again. This can prevent the annoying problem of video playback start/stopping/starting/stopping on a system tht doesn't have enough bandwidth to adequately buffer the video. You may also set the <code>bufferTime</code> in the constructor's <code>vars</code> parameter to set the initial value. **/
		public var autoAdjustBuffer:Boolean;
		
		public function VideoLoader(urlOrRequest:*, vars:Object=null) {
			super(urlOrRequest, vars);
			_type = "VideoLoader";
			_nc = new NetConnection();
			_nc.connect(null);
			_nc.addEventListener("asyncError", _failHandler, false, 0, true);
			_nc.addEventListener("securityError", _failHandler, false, 0, true);
			
			_video = new Video(vars.width || 320, vars.height || 240);
			_video.smoothing = Boolean(vars.smoothing != false);
			_video.deblocking = uint(vars.deblocking);
			//the video isn't decoded into memory fully until the NetStream is attached to the Video object. We only attach it when it is in the display list (thus can be seen) in order to conserve memory.
			_video.addEventListener(Event.ADDED_TO_STAGE, _videoAddedToStage, false, 0, true);
			_video.addEventListener(Event.REMOVED_FROM_STAGE, _videoRemovedFromStage, false, 0, true);
			
			_refreshNetStream();
			
			_duration = isNaN(vars.estimatedDuration) ? 200 : Number(vars.estimatedDuration); //just set it to a high number so that the progress starts out low.
			
			isPaused = isPausePending = Boolean(vars.autoPlay == false);
			autoAdjustBuffer = !(vars.autoAdjustBuffer == false);
			
			volume = ("volume" in vars) ? Number(vars.volume) : 1;
			
			if (LoaderMax.contentDisplayClass is Class) {
				_sprite = new LoaderMax.contentDisplayClass(this);
				if (!_sprite.hasOwnProperty("rawContent")) {
					throw new Error("LoaderMax.contentDisplayClass must be set to a class with a 'rawContent' property, like com.greensock.loading.display.ContentDisplay");
				}
			} else {
				_sprite = new ContentDisplay(this);
			}
			Object(_sprite).rawContent = null; //so that the video doesn't initially show at the wrong size before the metaData is received at which point we can accurately determine the aspect ratio.
		}
		
		/** @private **/
		override protected function _load():void {
			_prepRequest();
			_repeatCount = 0;
			_prevTime = 0;
			isBufferFull = false;
			isRenderedOnce = false;
			metaData = null;
			isPausePending = isPaused;
			if (isPaused) {
				_setForceTime(0);
				_sound.volume = 0;
				netStream.soundTransform = _sound; //temporarily silence the audio because in some cases, the Flash Player will begin playing it for a brief second right before the buffer is full (we can't pause until then)
			} else {
				volume = _volume; //ensures the volume is back to normal in case it had been temporarily silenced while buffering
			}
			_sprite.addEventListener(Event.ENTER_FRAME, _loadingProgressCheck);
			_waitForRender();
			isVideoComplete = isInitted = false;
			netStream.play(_request.url);
		}
		
		/** @private **/
		override protected function _calculateProgress():void {
			_cachedBytesLoaded = netStream.bytesLoaded;
			if (_cachedBytesLoaded > 1) {
				
				_cachedBytesTotal = netStream.bytesTotal;
				if (_cachedBytesTotal <= _cachedBytesLoaded) {
					_cachedBytesTotal = ((metaData != null && isRenderedOnce && isInitted) || (getTimer() - _time >= 10000)) ? _cachedBytesLoaded : int(1.01 * _cachedBytesLoaded) + 1; //make sure the metaData has been received because if the NetStream file is cached locally sometimes the bytesLoaded == bytesTotal BEFORE the metaData arrives. Or timeout after 10 seconds.
				}
				if (!_auditedSize) {
					_auditedSize = true;
					dispatchEvent(new Event("auditedSize"));
				}
			}
			_cacheIsDirty = false;
		}
		
		/** 
		 * Attempts to jump to a certain time in the video. If the video hasn't downloaded enough to get to
		 * the new time or if there is no keyframe at that time value, it will get as close as possible.
		 * For example, to jump to exactly 3-seconds into the video and play from there:<br /><br /><code>
		 * 
		 * loader.gotoVideoTime(3, true);<br /><br /></code>
		 * 
		 * @param time The time (in seconds, offset from the very beginning) at which to place the virtual playhead on the video.
		 * @param forcePlay If <code>true</code>, the video will resume playback immediately after seeking to the new position.
		 * @param skipCuePoints If <code>true</code> (the default), any cue points that are positioned between the current videoTime and the destination time (defined by the <code>time</code> parameter) will be ignored when moving to the new videoTime. In other words, it is like a record player that has its needle picked up, moved, and dropped into a new position rather than dragging it across the record, triggering the various cue points (if any exist there). IMPORTANT: cue points are only triggered when the time advances in the forward direction; they are never triggered when rewinding or restarting. 
		 * @see #pauseVideo()
		 * @see #playVideo()
		 * @see #videoTime
		 * @see #playProgress
		 **/
		public function gotoVideoTime(time:Number, forcePlay:Boolean=false, skipCuePoints:Boolean=true):Number {
			if (isNaN(time)) {
				return NaN;
			} else if (time > _duration) {
				time = _duration;
			}
			var changed:Boolean = (time != videoTime);
			if (isInitted && isRenderedOnce && changed) { //don't seek() until metaData has been received otherwise it can prevent it from ever being received. Also, if the NetStream hasn't rendered once and we seek(), it often completely loses its audio!
				netStream.seek(time);
				isBufferFull = false;
			}
			isVideoComplete = false;
			_setForceTime(time);
			if (changed) {
				if (!skipCuePoints) {
					_playProgressHandler(null);
				} else {
					_prevTime = time;
				}
			}
			if (forcePlay) {
				playVideo();
			}
			if (changed && skipCuePoints && _dispatchPlayProgress) {
				dispatchEvent(new LoaderEvent(PLAY_PROGRESS, this));
			}
			return time;
		}
		
		/** @private **/
		protected function _setForceTime(time:Number):void {
			if (!(_forceTime || _forceTime == 0)) { //if _forceTime is already set, the listener was already added (we remove it after 1 frame or after the buffer fills for the first time and metaData is received (whichever takes longer)
				_waitForRender(); //if, for example, after a video has finished playing, we seek(0) the video and immediately check the playProgress, it returns 1 instead of 0 because it takes a short time to render the first frame and accurately reflect the netStream.time variable. So we use a single ENTER_FRAME to help us override the netStream.time value briefly.
			}
			_forceTime = time;
		}
		
		/** @private **/
		protected function _waitForRender():void {
			netStream.addEventListener(Event.RENDER, _renderHandler, false, 0, true); //only works in Flash Player 10 and later
		}
		
		/** @private **/
		protected function _applyPendingPause():void {
			isPausePending = false;
			volume = _volume; //Just resets the volume to where it should be because we temporarily made it silent during the buffer.
			netStream.seek(_forceTime || 0);
			if (_video.stage != null) {
				_video.attachNetStream(netStream); //in case it was removed
			}
			netStream.pause(); //don't just do videoPaused = true because sometimes Flash fires NetStream.Play.Start BEFORE the buffer is full, and we must check inside the videoPaused setter to see if if the buffer is full and wait to pause until it is.
		}
		
		/** @private **/
		protected function _forceInit():void {
			if (netStream.bufferTime >= _duration) {
				netStream.bufferTime = uint(_duration - 1);
			}
			isInitted = true;
			if (!isBufferFull && netStream.bufferLength >= netStream.bufferTime) { 
				_onBufferFull();
			}
			if (!isBufferFull && isPausePending && isRenderedOnce) {
				_video.attachNetStream(null); //if the NetStream is still buffering, there's a good chance that the video will appear to play briefly right before we pause it, so we detach the NetStream from the Video briefly to avoid that funky visual behavior (we attach it again as soon as it buffers).
			}
		}
		
		
//---- EVENT HANDLERS ------------------------------------------------------------------------------------
		
		/** @private **/
		protected function _metaDataHandler(info:Object):void {
			if (metaData == null || metaData.cuePoints == null) { //sometimes videos will trigger the onMetaData multiple times (especially F4V files) and occassionally the last call doesn't contain cue point data!
				metaData = info;
			}
			_duration = info.duration;
			if ("width" in info) {
				_video.width = Number(info.width); 
				_video.height = Number(info.height);
			}
			_forceInit();
			dispatchEvent(new LoaderEvent(LoaderEvent.INIT, this, "", info));
		}
		
		/** @private **/
		protected function _cuePointHandler(info:Object):void {
			if (!isPaused) { //in case there's a cue point very early on and autoPlay was set to false - remember, to work around bugs in NetStream, we cannot pause() it until we receive metaData and the first frame renders.
				dispatchEvent(new LoaderEvent(VIDEO_CUE_POINT, this, "", info));
			}
		}
		
		/** @private **/
		protected function _playProgressHandler(event:Event):void {
			if (!isBufferFull && netStream.bufferLength >= netStream.bufferTime) {
				_onBufferFull();
			}
			if (_firstCuePoint || _dispatchPlayProgress) {
				var prevTime:Number = _prevTime;
				_prevTime = videoTime;
				var next:CuePoint;
				var cp:CuePoint = _firstCuePoint;
				while (cp) {
					next = cp.next;
					if (cp.time > prevTime && cp.time <= _prevTime && !cp.gc) {
						dispatchEvent(new LoaderEvent(VIDEO_CUE_POINT, this, "", cp));
					}
					cp = next;
				}
				if (_dispatchPlayProgress && prevTime != _prevTime) {
					dispatchEvent(new LoaderEvent(PLAY_PROGRESS, this));
				}
			}
		}
		
		/** @private **/
		private static const NETSTREAM_PLAY_START:String = "NetStream.Play.Start";
		private static const NETSTREAM_PLAY_STOP:String = "NetStream.Play.Stop";
		private static const NETSTREAM_PLAY_STREAMNOTFOUND:String = "NetStream.Play.StreamNotFound";
		private static const NETSTREAM_PLAY_FAILED:String = "NetStream.Play.Failed";
		private static const NETSTREAM_PLAY_FILESTRUCTUREINVALID:String = "NetStream.Play.FileStructureInvalid";
		private static const NETSTREAM_PLAY_NOSUPPORTEDTRACKFOUND:String = "NetStream.Play.NoSupportedTrackFound";
		
		private static const NETSTREAM_BUFFER_FULL:String = "NetStream.Buffer.Full";
		private static const NETSTREAM_BUFFER_EMPTY:String = "NetStream.Buffer.Empty";
		
		private static const NETSTREAM_CONNECT_FAILED:String = "NetConnection.Connect.Failed";
		
		
		protected function _statusHandler(event:NetStatusEvent):void {
			switch(event.info.code) {
				case NETSTREAM_PLAY_START:
					if (!isPausePending) {
						//_sprite.addEventListener(Event.ENTER_FRAME, _playProgressHandler);
						//dispatchEvent(new LoaderEvent(VIDEO_PLAY, this));
					}
					break;
				case NETSTREAM_PLAY_STOP:
					isBufferFull = false;
					if (isPaused) {
						return; //Can happen when we seek() to a time in the video between the last keyframe and the end of the video file - NetStream.Play.Stop gets received even though the NetStream was paused.
					}
					isVideoComplete = true;
					//videoPaused = true;
					//_playProgressHandler(null);
					//dispatchEvent(new LoaderEvent(VIDEO_COMPLETE, this));
					break;
				case NETSTREAM_BUFFER_FULL:
					_onBufferFull();
					break;
				case NETSTREAM_BUFFER_EMPTY:
					isBufferFull = false;
					var videoRemaining:Number = duration - videoTime;
					var loadRemaining:Number = (1 / progress) * loadTime;
					if (autoAdjustBuffer && loadRemaining > videoRemaining) {
						netStream.bufferTime = videoRemaining * (1 - (videoRemaining / loadRemaining)) * 0.9; //90% of the estimated time because typically you'd want the video to start playing again sooner and the 10% might be made up while it's playing anyway.
					}
					dispatchEvent(new LoaderEvent(VIDEO_BUFFER_EMPTY, this));
					break;
				case NETSTREAM_PLAY_STREAMNOTFOUND:
				case NETSTREAM_PLAY_NOSUPPORTEDTRACKFOUND:
				case NETSTREAM_PLAY_FILESTRUCTUREINVALID:
				case NETSTREAM_PLAY_FAILED:
				case NETSTREAM_CONNECT_FAILED:
					//_failHandler(new LoaderEvent(LoaderEvent.ERROR, this, code));
					break;
			}
		}
		
		/** @private **/
		protected function _onBufferFull():void {
			if (!isRenderedOnce) { //in Flash Player 9, NetStream doesn't dispatch the RENDER event and the only reliable way I could find to sense when a render truly must have occured is to wait about 50 milliseconds after the buffer fills. Even waiting for an ENTER_FRAME event wouldn't work consistently (depending on the frame rate). Also, depending on the version of Flash that published the swf, the NetStream's NetStream.Buffer.Full status event may not fire (CS3 and CS4)!
				_waitForRender();
				return;
			}
			if (isPausePending) {
				if (!isInitted) {
					_video.attachNetStream(null); //in some rare circumstances, the NetStream will finish buffering even before the metaData has been received. If we pause() the NetStream before the metaData arrives, it can prevent the metaData from ever arriving (bug in Flash) even after you resume(). So in this case, we allow the NetStream to continue playing so that metaData can be received, but we detach it from the Video object so that the user doesn't see the video playing. The volume is also muted, so to the user things look paused even though the NetStream is continuing to play/load. We'll re-attach the NetStream to the Video after either the metaData arrives or 10 seconds elapse.
					return;
				} else if (isRenderedOnce) {
					_applyPendingPause();
				}
			}
			if (!isBufferFull) {
				isBufferFull = true;
				//dispatchEvent(new LoaderEvent(VIDEO_BUFFER_FULL, this));
			}
		}
		
		/** @private **/
		protected function _loadingProgressCheck(event:Event):void {
			var bl:uint = _cachedBytesLoaded;
			var bt:uint = _cachedBytesTotal;
			if (!isBufferFull && netStream.bufferLength >= netStream.bufferTime) {
				_onBufferFull();
			}
			_calculateProgress();
			if (_cachedBytesLoaded == _cachedBytesTotal) { 
				_sprite.removeEventListener(Event.ENTER_FRAME, _loadingProgressCheck);
				if (!isBufferFull) {
					_onBufferFull();
				}
				if (!isInitted) {
					_forceInit();
					_errorHandler(new LoaderEvent(LoaderEvent.ERROR, this, "No metaData was received."));
				}
				_completeHandler(event);
			} else if ((_cachedBytesLoaded / _cachedBytesTotal) != (bl / bt)) {
				dispatchEvent(new LoaderEvent(LoaderEvent.PROGRESS, this));
			}
		}
		
		/** @private **/
		protected function _renderHandler(event:Event):void {
			isRenderedOnce = true;
			if (!isPaused || isInitted) { //if the video hasn't initted yet and it's paused, keep reporting the _forceTime and let the _timer keep calling until the condition is no longer met. 
				_forceTime = NaN;
				netStream.removeEventListener(Event.RENDER, _renderHandler);
			}
			if (isPausePending) {
				if (isBufferFull) {
					_applyPendingPause();
				} else {
					//_video.attachNetStream(null);
				}
			}
		}
		
		
		
//---- GETTERS / SETTERS -------------------------------------------------------------------------
		public function set videoPaused(value:Boolean):void {
			var changed:Boolean = Boolean(value != isPaused);
			isPaused = value;
			if (isPaused) {
				//If we're trying to pause a NetStream that hasn't even been buffered yet, we run into problems where it won't load. So we need to set the isPausePending to true and then when it's buffered, it'll pause it at the beginning.
				if (!isRenderedOnce) {
					_setForceTime(0);
					isPausePending = true;
					_sound.volume = 0; //temporarily make it silent while buffering.
					netStream.soundTransform = _sound;
				} else {
					isPausePending = false;
					volume = _volume; //Just resets the volume to where it should be in case we temporarily made it silent during the buffer.
					netStream.pause();
				}
				if (changed) {
					_sprite.removeEventListener(Event.ENTER_FRAME, _playProgressHandler);
					dispatchEvent(new LoaderEvent(VIDEO_PAUSE, this));
				}
			} else {
				if (isPausePending || !isBufferFull) {
					if (_video.stage != null) {
						_video.attachNetStream(netStream); //in case we had to detach it while buffering and waiting for the metaData
					}
					//if we don't seek() first, sometimes the NetStream doesn't attach to the video properly!
					//if we don't seek() first and the NetStream was previously rendered between its last keyframe and the end of the file, the "NetStream.Play.Stop" will have been called and it will refuse to continue playing even after resume() is called!
					//if we seek() before the metaData has been received (isInitted==true), it typically prevents it from being received at all!
					//if we seek() before the NetStream has rendered once, it can lose audio completely!
					if (isInitted && isRenderedOnce) {
						netStream.seek(videoTime); 
						isBufferFull = false;
					}
					isPausePending = false;
				}
				volume = _volume; //Just resets the volume to where it should be in case we temporarily made it silent during the buffer.
				netStream.resume();
				if (changed) {
					_sprite.addEventListener(Event.ENTER_FRAME, _playProgressHandler);
					dispatchEvent(new LoaderEvent(VIDEO_PLAY, this));
				}
			}
		}
		
		/** A value between 0 and 1 describing the playback progress where 0 means the virtual playhead is at the very beginning of the video, 0.5 means it is at the halfway point and 1 means it is at the end of the video. **/
		public function get playProgress():Number {
			//Often times the duration MetaData that gets passed in doesn't exactly reflect the duration, so after the FLV is finished playing, the time and duration wouldn't equal each other, so we'd get percentPlayed values of 99.26978. We have to use this isVideoComplete variable to accurately reflect the status.
			//If for example, after an FLV has finished playing, we gotoVideoTime(0) the FLV and immediately check the playProgress, it returns 1 instead of 0 because it takes a short time to render the first frame and accurately reflect the netStream.time variable. So we use an interval to help us override the netStream.time value briefly.
			return (isVideoComplete) ? 1 : (videoTime / _duration);
		}
		
		/** The time (in seconds) at which the virtual playhead is positioned on the video. For example, if the virtual playhead is currently at the 3-second position (3 seconds from the beginning), this value would be 3. **/
		public function get videoTime():Number {
			if (isVideoComplete) {
				return _duration;
			} else if (_forceTime || _forceTime == 0) {
				return _forceTime;
			} else if (netStream.time > _duration) {
				return _duration * 0.995; //sometimes the NetStream reports a time that's greater than the duration so we must correct for that.
			} else {
				return netStream.time;
			}
		}
		
	}
}