package akdcl.game.tetris
{
	import akdcl.key.AtkKey;
	import akdcl.key.Key;
	import akdcl.key.KeyManager;
	import akdcl.events.KeyEvent;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import com.greensock.TweenMax;
	/**
	 * ...
	 * @author Akdcl
	 */
	public class  Tetris extends Sprite
	{
		public var map:Map;
		protected var timer:Timer;
		protected var tileActive:Tile;
		protected var clipContainer:Sprite;
		
		public var timerSpeed:uint = 500;
		public var moveSpeed:uint = 25;
		public var downSpeed:uint = 25;
		public var removePerLevel:uint = 10;
		public var difficultyAdd:Number = 0.2;
		public var nextShowMax:uint = 4;
		
		protected var keyManager:KeyManager;
		protected var dirKeys:AtkKey;
		protected var rotateKeys:AtkKey;
		protected var upKey:Key;
		protected var downKey:Key;
		protected var leftKey:Key;
		protected var rightKey:Key;
		
		public var onTileFalled:Function;
		public var onTileRemove:Function;
		public var onNextLevel:Function;
		public var onGameOver:Function;
		
		protected static var SCOREADD_LINE:Array = [3, 5, 9, 17];
		protected static const TILE_MODEL:Array = [Tile.A0, Tile.A1, Tile.A2, Tile.A3, Tile.A4, Tile.A5, Tile.A6];
		public function Tetris() {
			timer = new Timer(timerSpeed);
			timer.addEventListener(TimerEvent.TIMER, timeRun);
			
			keyManager=new KeyManager(stage,moveSpeed);
			upKey=new Key("W");
			downKey=new Key("S");
			leftKey=new Key("A");
			rightKey=new Key("D");
			//fireKey=new Key(32,"SPACE");
			dirKeys = new AtkKey(keyManager, leftKey, rightKey);
			rotateKeys = new AtkKey(keyManager, upKey, downKey);
			
			dirKeys.onKeyDown = function(_evt:KeyEvent):void {
				keysDown(_evt.keyName);
			}
			dirKeys.onKeyHold = function(_evt:KeyEvent):void {
				if(_evt.holdTime<10){
					return;
				}
				keysDown(_evt.keyName);
			}
			rotateKeys.onKeyDown = function(_evt:KeyEvent):void {
				keysDown(_evt.keyName);
			}
			rotateKeys.onKeyUp = function(_evt:KeyEvent):void {
				switch(_evt.keyName) {
					case "W":
						break;
					case "S":
						timer.delay = timerSpeed / difficulty;
						break;
				}
			}
			map = new Map();
			map.mapHeight = 20;
			map.mapWidth = 10;
			
			clipContainer = new Sprite();
			addChild(clipContainer);
		}
		public function set pause(_pause:Boolean):void {
			if (_pause) {
				timer.stop();
				dirKeys.stop();
				rotateKeys.stop();
			}else {
				timer.start();
				dirKeys.start();
				rotateKeys.start();
			}
		}
		public function reset():void {
			clearMap();
			level = 0;
			score = 0;
			removeCounts = 0;
			creatTileActive();
			timer.reset();
		}
		protected function clearMap():void {
			removeAllClip();
			map.resetMap();
			clipMap = map.clone();
		}
		private var __level:int = 0;
		public function get level():int{
			return __level;
		}
		public function set level(_level:int):void {
			__level = _level;
			difficulty = 1 + __level * difficultyAdd;
			timer.delay = timerSpeed / difficulty;
		}
		protected var difficulty:Number = 1;
		private var __removeCounts:uint;
		public function get removeCounts():uint{
			return __removeCounts;
		}
		public function set removeCounts(_removeCounts:uint):void{
			__removeCounts = _removeCounts;
		}
		private var __score:int;
		public function get score():int{
			return __score;
		}
		public function set score(_score:int):void{
			if (_score<0) {
				_score = 0;
			}else if (_score>999999) {
				_score = 999999;
			}
			__score = _score;
		}
		protected function keysDown(_keyName:String):void {
			if (!tileActive) {
				return;
			}
			switch(_keyName) {
				case "W":
					if (isHit(1,0,0)) {
						//tileActive.rotate(1);
					}
					break;
				case "S":
					timer.delay = downSpeed;
					break;
				case "A":
					if (!isHit(0, -1)) {
						tileActive.lineX--;
					}
					break;
				case "D":
					if (!isHit(0, 1)) {
						tileActive.lineX++;
					}
					break;
			}
		}
		public var nextShowList:Array;
		protected function getRandomModel():uint {
			if (!nextShowList) {
				nextShowList = [];
			}
			var _n:uint;
			while (nextShowList.length < nextShowMax) {
				_n = Math.floor(Math.random() * TILE_MODEL.length);
				nextShowList.push(_n);
			}
			return nextShowList.shift();
		}
		protected function timeRun(_evt:TimerEvent):void {
			if (!tileActive) {
				return;
			}
			if (isHit(0, 0, 1)) {
				creatClipFromActive();
			}else{
				tileActive.lineY++;
			}
		}
		protected function creatTileActive():void {
			if (tileActive) {
				removeChild(tileActive);
			}
			var _id:uint = getRandomModel();
			tileActive = new Tile(TILE_MODEL[_id]);
			tileActive.rotateMax = Tile.ROTATENUM_MAX[_id];
			tileActive.changeStyle(_id+1);
			tileActive.lineX = map.mapWidth * 0.5-1;
			addChild(tileActive);
		}
		protected var clipMap:Array;
		protected var tempClip:Sprite;
		protected var removeCount_current:int;
		protected function creatClipFromActive():void {
			var _matrix:Array = tileActive.matrixCopy;
			var _clip:TileClip;
			var _x, _y:int;
			for each(var _e:Array in _matrix) {
				_x = tileActive.lineX + _e[0];
				_y = tileActive.lineY + _e[1];
				map.setMap(_x, _y, true);
				_clip = new TileClip();
				_clip.changeStyle(tileActive.frame);
				_clip.lineX = _x;
				_clip.lineY = _y;
				clipContainer.addChild(_clip);
				if (clipMap[_y][_x]) {
					clipContainer.removeChild(clipMap[_y][_x]);
				}
				clipMap[_y][_x] = _clip;
			}
			
			var _lineY:uint = tileActive.lineY;
			if (onTileFalled!=null) {
				onTileFalled(tileActive);
			}
			removeChild(tileActive);
			tileActive = null;
			if (_lineY == 0) {
				if (onGameOver!=null) {
					onGameOver();
				}
				return;
			}
			var _fullLine:Array = map.getFullLineYId();
			removeCount_current = _fullLine.length;
			if (_fullLine.length == 0) {
				score += _lineY * difficulty;
				creatTileActive();
				return;
			}
			removeCounts += removeCount_current;
			if (onTileRemove!=null) {
				onTileRemove(removeCounts);
			}
			score += _lineY * difficulty * SCOREADD_LINE[removeCount_current];
			tempClip = new Sprite();
			addChild(tempClip);
			var _id:uint;
			for (var _i:uint = 0; _i < _fullLine.length; _i++) {
				_id = _fullLine[_i];
				map.clearLineY(_id);
				removeLineClip(clipMap.splice(_id, 1)[0]);
			}
			for (_i = 0; _i < _fullLine.length; _i++) {
				map.addLineY();
				clipMap.unshift(map.perLineY.concat());
			}
		}
		protected function updateClip():void {
			var _x, _y:uint;
			for (_y = 0; _y < map.mapHeight; _y++) {
				if (!clipMap[_y]) {
					continue;
				}
				for (_x = 0; _x < map.mapWidth; _x++) {
					if (clipMap[_y][_x]) {
						//clipMap[_y][_x].lineX = _x;
						clipMap[_y][_x].moveToLineY(_y);
						//lineY = _y;
					}else {
						continue;
					}
				}
			}
		}
		protected function removeLineClip(_list:Array):void {
			for each(var _e:* in _list) {
				if (_e is DisplayObject) {
					tempClip.addChild(_e);
				}
			}
			removeCount_current--;
			if (removeCount_current == 0) {
				tempClip.alpha = 1;
				TweenMax.to(tempClip, 0.3, { colorMatrixFilter: { colorize:0xffffff, brightness:2 }, yoyo:true, repeat:1 } );
				TweenMax.to(tempClip, 0.3, { alpha:0, delay:0.3 , onComplete:removeEnd } );
			}
		}
		protected function removeAllClip():void {
			if (!clipMap) {
				return;
			}
			var _x, _y:uint;
			for (_y = 0; _y < map.mapHeight; _y++) {
				if (!clipMap[_y]) {
					continue;
				}
				for (_x = 0; _x < map.mapWidth; _x++) {
					if (clipMap[_y][_x]) {
						clipContainer.removeChild(clipMap[_y][_x]);
					}else {
						continue;
					}
				}
			}
		}
		protected function removeEnd():void {
			removeChild(tempClip);
			var _level:uint = int(removeCounts / removePerLevel);
			if (_level > level) {
				level = _level;
				//clearMap();
				if (onNextLevel != null) {
					onNextLevel();
				}
			}
			updateClip();
			creatTileActive();
		}
		protected function isHit(_dr:int = 0, _dx:int = 0, _dy:int = 0):Boolean {
			var _matrix:Array = tileActive.matrixCopy;
			if (_dr!=0) {
				tileActive.rotate(_dr);
			}
			var _x, _y:int;
			for each(var _e:Array in _matrix) {
				_x = tileActive.lineX + _e[0] + _dx;
				_y = tileActive.lineY + _e[1] + _dy;
				if (map.getMap(_x, _y)) {
					if (_dr!=0) {
						tileActive.rotate(-_dr);
					}
					return true;
				}
			}
			return false;
		}
	}
}
