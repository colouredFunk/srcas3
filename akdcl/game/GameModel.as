package akdcl.game
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLVariables;
	
	import akdcl.manager.SoundManager;
	import akdcl.net.AkdclLoader;
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
		
		public var btn_pause:Btn;
		public var btn_sound:*;
		public var btn_help:Btn;
		public var btn_back:Btn;
		protected var loader:AkdclLoader;
		
		protected var isGameWin:Boolean;
		public function GameModel() {
			Alert.AlertLayer = this;
			Alert.AlertClass = Alert_0;
			loader = new AkdclLoader();
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
				SoundManager.setSoundVol(1);
			}else {
				SoundManager.setSoundVol(0);
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
			Alert.createAlert(tipPause, false, labelBackToGame).callBack = function():void {
				pause = false;
			};
		}
		public function gameHelp():void {
			pause = true;
			Alert.createAlert(tipHelp, false, labelBackToGame).callBack = function():void {
				pause = false;
			};
		}
		public function gameStart():void {
			pause = true;
			Alert.createAlert(tipStart).callBack = function():void {
				startGame();
			}
		}
		public function gameReset():void {
			pause = true;
			Alert.createAlert(tipReset, true, labelResetGame, labelBackToGame).callBack = function(_b:Boolean):void {
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
			Alert.createAlert(tipGameWin, true,labelSubimt,labelResetGame).callBack = function(_b:Boolean):void {
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
			Alert.createAlert(tipGameOver, true,labelSubimt,labelResetGame).callBack = function(_b:Boolean):void {
				if (_b) {
					gameSubmit();
				}else {
					resetGame();
				}
			};
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
		public function getURL():void {
			loader.getURL(isGameWin?urlGameWin:urlGameOver, urlTarget, dataSubmit());
		}
		public function gameSubmit():void {
			pause = true;
			if (urlRequest&&urlRequest.length>0) {
				alertWait = Alert.createAlert(tipSubmit);
				alertWait.showBtns(false);
				loader.addEventListener(Event.COMPLETE, onRequsetLoaded);
				loader.addEventListener(IOErrorEvent.IO_ERROR, onRequsetError);
				loader.load(urlRequest,dataSubmit());
			}else {
				getURL();
			}
		}
		private var alertWait:Alert;
		private function onRequsetLoaded(_evt:Event):void {
			loader.removeEventListener(Event.COMPLETE, onRequsetLoaded);
			if (loader.content is String) {
				onRequsetError(null);
			}else if(loader.content.hasOwnProperty(result) && loader.content[result] == "1" || loader.content[result] == "true"){
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
		private function onRequsetError(_evt:IOErrorEvent):void {
			loader.removeEventListener(IOErrorEvent.IO_ERROR, onRequsetError);
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
	}
	
}