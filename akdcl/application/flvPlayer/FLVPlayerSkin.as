package akdcl.application.flvPlayer{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import ui_2.SimpleBtn;
	import ui_2.Slider
	
	import akdcl.application.flvPlayer.FLVPlayer;
	import fl.video.VideoState;
	
	import com.greensock.TweenMax;
	import flash.ui.Mouse;
	
	public class FLVPlayerSkin extends  SimpleBtn{
		public static var SkinClass:Class;
		
		public var btn_halo:*;
		public var bar_list:*;
		public var bar_ctrl:*;
		
		public var btn_list:*;
		public var btn_play:*;
		public var btn_stop:*;
		public var btn_prev:*;
		public var btn_next:*;
		public var bar_progress:*;
		public var btn_time:*;
		public var btn_sound:*;
		public var bar_sound:*;
		public var btn_screen:*;
		
		private var btnPerWidth:uint = 20;
		public var skinMode:uint = 2;
		public var btnDx:uint = 0;
		public var offRigth:uint = 10;
		public var offLeft:uint = 10;
		public var offTop:uint = 10;
		public var offBottom:uint = 10;
		
		public function FLVPlayerSkin() {
		}
		override protected function added(_evt:Event):void 
		{
			super.added(_evt);
			buttonMode = false;
			bar_list.buttonMode = false;
			bar_ctrl.buttonMode = false;
			hideSkin(0);
		}
		private var __player:FLVPlayer;
		public function get player():FLVPlayer {
			return __player;
		}
		public function set player(_player:FLVPlayer):void {
			__player = _player;
			setCtrl();
		}
		public function remove():void {
			__player = null;
		}
		private function setCtrl():void {
			
			btn_list = bar_list.btn_list;
			btn_play = bar_ctrl.btn_play;
			btn_stop = bar_ctrl.btn_stop;
			btn_prev = bar_ctrl.btn_prev;
			btn_next = bar_ctrl.btn_next;
			bar_progress = bar_ctrl.bar_progress;
			btn_time = bar_ctrl.btn_time;
			btn_sound = bar_ctrl.btn_sound;
			bar_sound = bar_ctrl.bar_sound;
			btn_screen = bar_ctrl.btn_screen;
			
			bar_progress.snapInterval = 0.01;
			
			
			setBtnsCtrl();
			press = function():void {
				if (bar_list.isIn||bar_ctrl.isIn) {
					return;
				}
				/*if (getTimer()-this.time_release<400) {
					this._parent.bar.btn_screen.release();
				} else {
				}*/
				//this.time_release = getTimer();
				if (player.isFullScreen) {
					rollOver();
				}
				btn_play.release();
			}
			rollOver = function():void {
				if (player.listLength > 0 && skinMode > 0) {
					showSkin();
				}
			}
			rollOut = hideSkin;
			hitArea = player.background;
			
			setColor(bar_progress.bar, BtnSkin_0.GLOW_COLOR);
			BtnSkin_0.glowLow(btn_halo.ani);
			BtnSkin_0.glowLow(bar_progress.bar);
			BtnSkin_0.glowLow(btn_time.txt);
		}
		public function setBtnsCtrl():void {
			
			btn_play.release = function():void {
				player.videoPlay();
			}
			btn_stop.release = function():void {
				player.videoStop();
			}
			btn_prev.release = function():void {
				player.playId++;
			}
			btn_next.release = function():void {
				player.playId--;
			}
			bar_progress.release = function():void {
				player.seekPercent(this.value);
			}
			bar_progress.press =bar_progress.change = function(_value:Number, _min:Number=0, _max:Number=0):void {
				updateTime(_value / bar_progress.maximum * player.totalTime, player.totalTime, bar_progress.isHold);
			}
			btn_sound.release = function():void  {
				player.mute=!player.mute;
			}
			/*bar_sound.snapInterval = 0.01;
			bar_sound.maximum = 1;
			bar_sound.change = function(_value:Number, _min:Number, _max:Number):void  {
				player.volume = _value;
			}*/
			btn_time.rollOver = function():void {
				BtnSkin_0.glowHith(btn_time.txt);
			}
			btn_time.rollOut = function():void {
				BtnSkin_0.glowLow(btn_time.txt);
			}
			btn_screen.release = function():void  {
				player.setFullScreen();
			};
		}
		private static function setColor(_clip:Sprite,_color:uint):void {
			TweenMax.to(_clip,0,{tint:_color});
		}
		private function showSkin():void {
			Mouse.show();
			TweenMax.killTweensOf(bar_ctrl);
			TweenMax.killTweensOf(bar_list);
			if (bar_ctrl.alpha<1) {
				TweenMax.to(bar_ctrl,0.5,{alpha:1});
				TweenMax.to(bar_list,0.5,{alpha:1});
			}
			if (player.isFullScreen) {
				this.addEventListener(Event.ENTER_FRAME, fullScreenCheckMouse);
			}
		}
		private var time_mouse:uint;
		private var delay_mouseStop:uint = 60;
		private function fullScreenCheckMouse(_evt:Event):void {
			time_mouse > 0 ? time_mouse++ : (time_mouse = 1);
			if (time_mouse > delay_mouseStop) {
				this.removeEventListener(Event.ENTER_FRAME, fullScreenCheckMouse);
				time_mouse = 1;
				if (!(bar_list.isIn||bar_ctrl.isIn||bar_list.isDown||bar_ctrl.isDown) && player.state == VideoState.PLAYING) {
					this.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
					rollOut();
				}
			}
		}
		private function mouseMove(_evt:MouseEvent):void {
			this.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
			rollOver();
		}
		private function hideSkin(_sec:Number=1):void {
			TweenMax.killTweensOf(bar_ctrl);
			TweenMax.killTweensOf(bar_list);
			if (bar_ctrl.alpha > 0) {
				var _delay:Number = 0.5;
				if (player.isFullScreen) {
					Mouse.hide();
					_delay = 0;
				}
				TweenMax.to(bar_ctrl,_sec,{alpha:0, delay:_sec>0?_delay:0});
				TweenMax.to(bar_list,_sec,{alpha:0, delay:_sec>0?_delay:0});
			}
		}
		private function showHalo(_state:String):void {
			switch(_state) {
				case VideoState.LOADING:
				case VideoState.BUFFERING:
					if (btn_halo.glowClip) {
						btn_halo.glowClip.gotoAndStop(2);
					}
					TweenMax.to(btn_halo,0.3,{autoAlpha:1,scaleX:1,scaleY:1});
					btn_halo.ani.play();
					break;
				case VideoState.PLAYING:
					if (btn_halo.glowClip) {
						btn_halo.glowClip.gotoAndStop(1);
					}
					TweenMax.to(btn_halo,0.5,{autoAlpha:0,scaleX:0.2,scaleY:0.2,onComplete:haloStop});
					break;
				case VideoState.PAUSED:
				case VideoState.STOPPED:
					if (btn_halo.glowClip) {
						btn_halo.glowClip.gotoAndStop(1);
					}
					TweenMax.to(btn_halo,0.3,{autoAlpha:1,scaleX:1,scaleY:1});
					btn_halo.ani.play();
					break;
				case VideoState.DISCONNECTED:
				case VideoState.CONNECTION_ERROR:
					TweenMax.to(btn_halo,0.3,{autoAlpha:1,scaleX:1,scaleY:1});
					btn_halo.ani.play();
					break;
			}
		}
		private function haloStop():void {
			btn_halo.ani.stop();
		}
		public function updateValue(_volume:Number):void {
			if (!btn_sound.glowClip) {
				return;
			}
			if (_volume == 0) {
				btn_sound.glowClip.gotoAndStop(1);
			} else {
				btn_sound.glowClip.gotoAndStop(1+Math.ceil(_volume*4));
			}
		}
		public function progress(_loaded:uint,_total:uint):void {
			bar_progress.track.value = _loaded / _total;
		}
		public function ready(_played:uint, _total:uint):void {
			playheadUpdate(_played,_total);
		}
		public function playheadUpdate(_played:uint, _total:uint):void {
			if (bar_progress.isHold) {
				return;
			}
			bar_progress.value = _played / _total * bar_progress.maximum;
		}
		private function updateTime(_n_0:uint,_n_1:uint,_flag:Boolean):void {
			var _s_0:String = Common.formatTime_2(_n_0);
			var _s_1:String = Common.formatTime_2(_n_1);
			if (_flag) {
				btn_time.html = true;
				_s_0 = "<font color='#00ff00'>" + _s_0 + "</font>";
			}else {
				btn_time.html = false;
			}
			btn_time.label = _s_0 + "/" + _s_1;
		}
		public function stateChange(_state:String):void {
			switch(_state) {
				case VideoState.LOADING:
					break;
				case VideoState.BUFFERING:
					break;
				case VideoState.PLAYING:
					if (btn_play.glowClip) {
						btn_play.glowClip.gotoAndStop(2);
					}
					btn_play.select = true;
					break;
				case VideoState.PAUSED:
					if (btn_play.glowClip) {
						btn_play.glowClip.gotoAndStop(1);
					}
					btn_play.select = false;
					break;
				case VideoState.SEEKING:
					break;
				case VideoState.REWINDING:
					break;
				case VideoState.STOPPED:
					if (btn_play.glowClip) {
						btn_play.glowClip.gotoAndStop(1);
					}
					btn_play.select = false;
					break;
				case VideoState.DISCONNECTED:
					break;
				case VideoState.CONNECTION_ERROR:
					break;
				case VideoState.RESIZING:
					break;
			}
			showHalo(_state);
		}
		private var skinWidth:uint;
		private var skinHeight:uint;
		public function setSize(_width:uint, _height:uint):void {
			setStyle_barList(_width, _height);
			setStyle_barCtrl(_width, _height);
		}
		public function get isShowTime():Boolean {
			return btn_time.visible;
		}
		public function set isShowTime(_b:Boolean):void {
			btn_time.visible = _b;
			setStyle_barCtrl();
		}
		public function get isAllowFullScreen():Boolean {
			return btn_screen.visible;
		}
		public function set isAllowFullScreen(_b:Boolean):void {
			btn_screen.visible = _b;
			setStyle_barCtrl();
		}
		private function oneDxFrom(_x:uint, _dir:int = 1):uint {
			return _x + (btnPerWidth + btnDx) * _dir;
		}
		private function setStyle_barCtrl(_width:uint=0, _height:uint=0):void {
			_width = _width || skinWidth;
			_height = _height || skinHeight;
			btn_play.x = offLeft + btnPerWidth*0.5;
			btn_stop.x = oneDxFrom(btn_play.x);
			if (player.listLength > 1) {
				//拥有视频列表
				btn_next.visible = btn_prev.visible = true;
				btn_prev.x = oneDxFrom(btn_stop.x);
				btn_next.x = oneDxFrom(btn_prev.x);
				bar_progress.x = oneDxFrom(btn_next.x);
			}else {
				btn_next.visible = btn_prev.visible = false;
				bar_progress.x = oneDxFrom(btn_stop.x);
			}
			if (isAllowFullScreen) {
				btn_screen.x = _width - (offRigth + btnPerWidth * 0.5);
				if (btn_screen.glowClip) {
					btn_screen.glowClip.gotoAndStop(player.isFullScreen?2:1);
				}
				btn_screen.select = player.isFullScreen;
				btn_sound.x = oneDxFrom(btn_screen.x, -1);
			}else {
				btn_sound.x = _width - (offRigth + btnPerWidth * 0.5);
			}
			if (isShowTime) {
				btn_time.x = btn_sound.x - btnPerWidth * 0.5;
				bar_progress.length = btn_time.x - btn_time.barWidth - bar_progress.x - btnPerWidth * 0.5;
			}else {
				btn_time.x = 0;
				bar_progress.length = (btn_sound.x - btnPerWidth * 0.5) - bar_progress.x - btnPerWidth * 0.5;
			}
			bar_ctrl.y = _height-offBottom;
			bar_ctrl.background.x = offLeft;
			bar_ctrl.background.width = _width - offRigth - offLeft;
			btn_halo.x = _width * 0.5;
			btn_halo.y = _height * 0.5;
		}
		private function setStyle_barList(_width:uint = 0, _height:uint = 0):void {
			if (player.listLength > 1) {
				//拥有视频列表
				bar_list.visible = true;
			}else {
				bar_list.visible = false;
				
			}
			btn_list.x = _width - (offRigth + btnPerWidth * 0.5);
			
			bar_list.y = offTop;
			bar_list.background.x = offLeft;
			bar_list.background.width = _width - offRigth - offLeft;
		}
		public static function createSkin():FLVPlayerSkin {
			var _skin:FLVPlayerSkin;
			if (SkinClass) {
				_skin = new SkinClass();
			}else {
				_skin = new FLVPlayerSkin();
			}
			return _skin;
		}
	} 
}