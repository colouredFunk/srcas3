package akdcl.game
{
	import akdcl.game.SoundManage;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLVariables;
	import ui_2.Btn;
	import ui_2.Alert;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class GameModel extends Sprite
	{
		public var urlRequest:String = "http://www.wanmei.com/";
		public var urlGameWin:String = "http://www.wanmei.com/";
		public var urlGameOver:String = "http://www.wanmei.com/";
		public var urlTarget:String = "_self";
		public var result:String = "result";
		
		public var tipPause:String = "游戏暂停中！";
		public var tipHelp:String = "游戏帮助！";
		public var tipStart:String = "游戏开始！";
		public var tipReset:String = "重新开始游戏吗？！";
		public var tipGameWin:String = "游戏胜利！";
		public var tipGameOver:String = "游戏失败！";
		public var tipSubmit:String = "提交中，请稍后...";
		public var tipRefuse:String = "拒绝提交！";
		public var tipFail:String = "提交失败！";
		public var tipFailPage:String = "提交页面错误！";
		
		public var labelBackToGame:String = "回到游戏";
		public var labelResetGame:String = "重新游戏";
		public var labelSubimt:String = "提交分数";
		public var labelTryAgain:String = "重试";
		public var game:*;
		
		public var AlertClass:Class = Alert_0;
		public var btn_pause:Btn;
		public var btn_sound:*;
		public var btn_help:Btn;
		public var btn_back:Btn;
		
		protected var isGameWin:Boolean;
		public function GameModel() {
			Alert.AlertLayer = this;
			btn_pause.release = function():void {
				gamePause();
			}
			btn_sound.release = function():void {
				sound = !sound;
			}
			btn_help.release = function():void {
				gameHelp();
			}
			btn_back.release = function():void {
				gameReset();
			}
			gameStart();
		}
		private var __pause:Boolean;
		public function get pause():Boolean {
			return __pause;
		}
		public function set pause(_pause:Boolean):void {
			__pause = _pause;
		}
		private var __sound:Boolean = true;
		public function get sound():Boolean{
			return __sound;
		}
		public function set sound(_sound:Boolean):void {
			__sound = _sound;
			btn_sound.clip.gotoAndStop(__sound?1:2);
			if (__sound) {
				SoundManage.stopSound();
			}else {
				SoundManage.returnSound();
			}
		}
		public function startGame():void {
			pause = false;
		}
		public function resetGame():void {
			pause = false;
		}
		public function gamePause():void {
			pause = true;
			getAlert(tipPause, false, labelBackToGame).callBack = function():void {
				pause = false;
			};
		}
		public function gameHelp():void {
			pause = true;
			getAlert(tipHelp, false, labelBackToGame).callBack = function():void {
				pause = false;
			};
		}
		public function gameStart():void {
			pause = true;
			getAlert(tipStart).callBack = function():void {
				startGame();
			}
		}
		public function gameReset():void {
			pause = true;
			getAlert(tipReset, true, labelResetGame, labelBackToGame).callBack = function(_b:Boolean):void {
				if (_b) {
					resetGame();
				}else {
					pause = false;
				}
			};
		}
		public function gameWin(_isEnd:Boolean = true):void {
			pause = true;
			if (!_isEnd) {
				return;
			}
			isGameWin = true;
			getAlert(tipGameWin, true,labelSubimt,labelResetGame).callBack = function(_b:Boolean):void {
				if (_b) {
					gameSubmit();
				}else {
					resetGame();
				}
			};
		}
		public function gameOver():void {
			pause = true;
			isGameWin = false;
			getAlert(tipGameOver, true,labelSubimt,labelResetGame).callBack = function(_b:Boolean):void {
				if (_b) {
					gameSubmit();
				}else {
					resetGame();
				}
			};
		}
		public function gameSubmit():void {
			pause = true;
			if (urlRequest&&urlRequest.length>0) {
				alertWait = getAlert(tipSubmit);
				alertWait.showBtns(false);
				var _loader:URLLoader = Common.urlLoader(urlRequest, onRequsetLoaded, null, onRequsetError, dataSubmit());
			}else {
				getURL();
			}
		}
		protected var send:*;
		protected var load:*;
		public function setXML(_xml:XML):void {
			for each(var _e:XML in _xml.options.children()){
				if(this.hasOwnProperty(_e.name())){
					this[_e.name()]=_e.text();
				}
			}
			load = _xml.load;
			send = _xml.send;
			
			result = load.result.@key;
		}
		protected function dataSubmit():Object {
			var _data:Object = { test:"test" };
			return _data;
		}
		private var alertWait:Alert;
		private function onRequsetLoaded(_evt:Event):void {
			var _result:URLVariables = new URLVariables();
			try {
				_result.decode(_evt.currentTarget.data);
			}catch (_error:*) {
				onRequsetError(null);
				return;
			}
			if (_result.hasOwnProperty(result) && _result[result] == "1" || _result[result] == "true") {
				alertWait.remove();
				getURL();
			}else {
				alertWait.callBack = function():void {
					resetGame();
				}
				alertWait.showBtns(true, false, labelResetGame);
				alertWait.text = tipRefuse;
			}
		}
		private function getURL():void {
			Common.getURL(isGameWin?urlGameWin:urlGameOver, urlTarget, dataSubmit());
		}
		private function onRequsetError(_evt:IOErrorEvent):void {
			alertWait.callBack = function(_b:Boolean):void {
				if (_b) {
					gameSubmit();
				}else {
					resetGame();
				}
			}
			alertWait.showBtns(true, true,labelTryAgain,labelResetGame);
			alertWait.text = _evt?tipFail:tipFailPage;
			
		}
		public function getAlert(_str:String,_isYN:Boolean=false,_yes:String=null,_no:String=null):Alert {
			var _alert:Alert = new AlertClass();
			_alert.alert(_str, _isYN, _yes, _no);
			return _alert;
		}
	}
	
}