package akdcl.game.collision
{
	import akdcl.game.collision.Tile;
	import akdcl.game.collision.Map;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	
	import com.greensock.TweenMax;
	
	import ui_2.Btn;
	/**
	 * ...
	 * @author Akdcl
	 */
	public class  Collision extends Sprite
	{
		public static var instance:Collision;
		public var rec_follow:Btn;
		public var rec_select:Btn;
		public var tileContainer:Sprite;
		public var hardest:uint = 3000;
		
		private const rec_widthOrg:uint = 50;
		private const rec_heightOrg:uint = 50;
		
		private var lineX_select:uint;
		private var lineY_select:uint;
		private var lineX_now:uint;
		private var lineY_now:uint;
		private var isPress:Boolean;
		private var isSelect:Boolean;
		
		private var numRemoved:uint;
		private var map:Map;
		private var tileFixDic:Object;
		private var tileFallDic:Dictionary;
		private var tileRemoveDic:Dictionary;
		private var removeList:Array;
		private var tileFallDicLength:uint;
		private var tileRemoveDicLength:uint;
		private var timer:Timer;
		
		private var numCombo:uint;
		public var timeTotal:uint = 60;
		public var timeAdd:uint = 1;
		public var onRemoveTiles:Function;
		public var onRemoveType:Function;
		public var onTimerChange:Function;
		public var onTimerOver:Function;
		public var onScoreChange:Function;
		public var onRecMove:Function;
		public var onRecUnmove:Function;
		public function Collision() {
			instance = this;
			map = new Map();
			if (!tileContainer) {
				tileContainer = new Sprite();
				addChildAt(tileContainer,0);
			}
			
			rec_select.visible = false;
			rec_follow.alpha = 0;
			rec_select.mouseEnabled = false;
			rec_select.mouseChildren = false;
			rec_follow.mouseChildren = false;
			rec_follow.hitArea = tileContainer;
			rec_follow.rollOver = function():void {
				this.alpha = 1;
			}
			rec_follow.rollOut = function():void {
				this.alpha = 0;
			}
			rec_follow.press = function():void {
				if (!isControl || map.isStone(lineX_now, lineY_now)) {
					if (map.isStone(lineX_now, lineY_now)&&onRecUnmove!=null) {
						onRecUnmove();
					}
					return;
				}
				if (isSelect && Math.abs(lineX_now - lineX_select) + Math.abs(lineY_now - lineY_select) == 1) {
					changeTiles(lineX_select, lineY_select, lineX_now, lineY_now);
					isSelect = false;
				}else {
					lineX_select = lineX_now;
					lineY_select = lineY_now;
					isPress = true;
				}
				rec_select.visible = false;
			}
			rec_follow.release = function():void {
				if(isPress){
					isSelect = true;
					isPress = false;
					rec_select.x = lineX_now * Tile.tileWidth;
					rec_select.y = lineY_now * Tile.tileHeight;
					rec_select.visible = true;
				}
			}
			time++;
			timer = new Timer(1000);
			timer.addEventListener(TimerEvent.TIMER, timerRun);
			this.addEventListener(Event.ENTER_FRAME, moveRecSelect);
		}
		public function checkMap():void {
			map.checkMap();
		}
		public function setPause(_b:Boolean):void {
			if (_b) {
				timer.stop();
				visible = false;
			}else {
				timer.start();
				visible = true;
			}
		}
		private var __score:uint;
		public function get score():uint {
			return __score;
		}
		public function set score(_score:uint):void {
			if (_score<0) {
				_score = 0;
			}
			if (__score==_score) {
				return;
			}
			__score = _score;
			if (onScoreChange!=null) {
				onScoreChange(__score);
			}
		}
		private var __time:int;
		public function get time():int{
			return __time;
		}
		public function set time(_time:int):void{
			if (_time<0) {
				_time = 0;
			}else if (_time>timeTotal) {
				_time = timeTotal;
			}
			if (__time==_time) {
				return;
			}
			__time=_time;
			if (onTimerChange!=null) {
				onTimerChange(time,timeTotal);
			}
		}
		public function get isControl():Boolean {
			return timer.running;
		}
		public function reset():void {
			score = 0;
			time = 0;
			numRemoved = 0;
			map.resetPicCount();
			buildMap();
		}
		public function buildMap():void {
			for each(var _e:Tile in tileFixDic) {
				_e.removeRightNow();
			}
			tileContainer.alpha = 1;
			setRecSize(Tile.tileWidth, Tile.tileHeight);
			tileFixDic = { };
			tileFallDic = new Dictionary();
			tileRemoveDic = new Dictionary();
			map.getArray();
			var _x, _y, _n:uint;
			for (_y = Map.mapHeight-1; _y >=0; _y-- ) {
				for (_x = 0; _x < Map.mapWidth; _x++ ) {
					createTile(_x, _y-Map.mapHeight, map.getMap(_x, _y));
				}
			}
		}
		public function getHint():void {
			var _ary:Array = map.getHint();
			changeTiles(_ary[0][0],_ary[0][1],_ary[1][0],_ary[1][1]);
		}
		public function shuffle():void {
			map.shuffle();
			for each(var _e:Tile in tileFixDic) {
				_e.value = map.getMap(_e.lineX,_e.lineY);
			}
			removeAllRight();
		}
		public function isHit(_lineX:int, _lineY:int):Boolean {
			var _b:Boolean;
			if (Tile.acceleration>0) {
				_b = Tile.isVertical ? (_lineY>=Map.mapHeight) : (_lineX>=Map.mapWidth);
			} else {
				_b = Tile.isVertical ? (_lineY<=0) : (_lineX<=0);
			}
			_b = _b || getFixTile(_lineX, _lineY);
			return _b;
		}
		public function changeTiles(_lineX_0:uint, _lineY_0:uint, _lineX_1:uint, _lineY_1:uint, _isBack:Boolean = false):void {
			var _tile_0:Tile = getFixTile(_lineX_0, _lineY_0);
			var _tile_1:Tile = getFixTile(_lineX_1, _lineY_1);
			if (!_tile_0 || !_tile_1 || map.isStone(_lineX_0, _lineY_0) || map.isStone(_lineX_1, _lineY_1)) {
				return;
			}
			if (!_isBack) {
				time++;
			}
			timer.stop();
			TweenMax.to(_tile_0, 0.3, { x:_tile_1.x, y:_tile_1.y } );
			TweenMax.to(_tile_1, 0.4, { x:_tile_0.x, y:_tile_0.y, onComplete:changeEnd, onCompleteParams:[_tile_0, _tile_1, _isBack] } );
		}
		private function changeEnd(_tile_0:Tile, _tile_1:Tile, _isBack:Boolean = false):void {
			var _lineX:int = _tile_0.lineX;
			var _lineY:int = _tile_0.lineY;
			setFixTile(_tile_1.lineX,_tile_1.lineY,_tile_0);
			setFixTile(_lineX, _lineY, _tile_1);
			if (_isBack) {
				timer.start();
				return;
			}
			var _isRigth:Boolean;
			_isRigth = map.canRemove(_tile_0.lineX, _tile_0.lineY, _tile_0.value) || map.canRemove(_tile_1.lineX, _tile_1.lineY, _tile_1.value);
			if (_isRigth) {
				removeAllRight();
			}else {
				changeTiles(_tile_0.lineX, _tile_0.lineY, _tile_1.lineX, _tile_1.lineY, true);
			}
		}
		public function removeAllRight(_removeType:uint = 0, ..._arg):void {
			switch(_removeType) {
				case 0:
					removeList = map.getRight();
					break;
				case 1:
					removeList = map.getSame(_arg[0]);
					break;
				case 2:
					removeList = map.getLineX(_arg[0]);
					break;
				case 3:
					removeList = map.getLineY(_arg[0]);
					break;
				case 4:
					removeList = map.getAllStones();
					break;
			}
			if (removeList.length == 0) {
				//无连击
				numCombo = 0;
				var _isContinue:Boolean = map.findRoad();
				if (_isContinue) {
					//仍然有解
					//继续游戏
					timer.start();
				}else {
					//无解
					//刷新地图
					TweenMax.to(tileContainer, 0.5, {alpha:0, onComplete:buildMap} );
				}
				return;
			}
			//连击
			numCombo ++;
			timer.stop();
			var _tile:Tile;
			
			var _scoreAdd:uint = 0;
			for each(var _e:* in removeList) {
				//各种消除类型
				for each(var _eL:* in _e) {
					_tile = getFixTile(_eL[0], _eL[1]);
					if (!_tile) {
						continue;
					}
					_tile.remove();
				}
				if (_removeType==0) {
					_scoreAdd += _e.length * (_e.length + 2);
					if (_tile && onRemoveType != null) {
						onRemoveType(_tile.value);
					}
				}else {
					_scoreAdd += _e.length * 4;
				}
			}
			_scoreAdd *= numCombo;
			score += _scoreAdd;
			time -= timeAdd * (numCombo > 1?(numCombo * 0.5):1);
		}
		private function setRecSize(_w:Number,_h:Number):void {
			rec_select.scaleX = _w / rec_widthOrg;
			rec_select.scaleY = _h / rec_heightOrg;
			rec_follow.scaleX = _w / rec_widthOrg;
			rec_follow.scaleY = _h / rec_heightOrg;
		}
		private function moveRecSelect(_evt:Event):void {
			var _lineX:uint = int(mouseX / Tile.tileWidth);
			var _lineY:uint = int(mouseY / Tile.tileWidth);
			if (lineX_now==_lineX&&lineY_now==_lineY) {
				return;
			}
			if (rec_follow.alpha>0&&onRecMove!=null) {
				onRecMove();
			}
			lineX_now = _lineX;
			lineY_now = _lineY;
			rec_follow.x = lineX_now * Tile.tileWidth;
			rec_follow.y = lineY_now * Tile.tileHeight;
			if (isPress) {
				if (lineX_select != lineX_now || lineY_select != lineY_now) {
					if (lineX_select != lineX_now) {
						changeTiles(lineX_select, lineY_select, lineX_select + (lineX_select > lineX_now? -1: 1), lineY_select);
					}else {
						changeTiles(lineX_select, lineY_select, lineX_select, lineY_select + (lineY_select > lineY_now? -1: 1));
					}
					isPress = false;
				}
			}
		}
		private function timerRun(_evt:TimerEvent):void {
			time++;
			if (time==timeTotal) {
				timer.stop();
				if (onTimerOver!=null) {
					onTimerOver();
				}
			}
		}
		private function createTile(_lineX:int,_lineY:int,_value:uint=0):Tile {
			var _tile:Tile = new Tile();
			_tile.onFallBegin = function():void {
				addFallTile(this);
			}
			_tile.onFallEnd = function():void {
				removeFallTile(this);
			}
			_tile.onRemove = function():void {
				addRemoveTile(this);
			}
			_tile.onRemoveFallBegin = function():void {
				removeRemoveTile(this);
			}
			_tile.setLine(_lineX, _lineY);
			_tile.value = _value;
			_tile.fallBegin();
			tileContainer.addChildAt(_tile,0);
			return _tile;
		}
		private function getDicKey(_lineX:int, _lineY:int):String {
			return "TILE_"+_lineY+"_"+_lineX;
		}
		private function getFixTile(_lineX:int, _lineY:int):Tile{
			return tileFixDic[getDicKey(_lineX, _lineY)];
		}
		private function setFixTile(_lineX:int, _lineY:int, _tile:Tile=null):void {
			if (_tile) {
				tileFixDic[getDicKey(_lineX, _lineY)] = _tile;
				_tile.setLine(_lineX, _lineY);
				map.setMap(_tile.lineX, _tile.lineY, _tile.value);
			}else{
				delete tileFixDic[getDicKey(_lineX, _lineY)];
			}
		}
		private function fillMap():void {
			var _x, _y:uint;
			var _tile:Tile;
			for (_y = 0; _y < Map.mapHeight; _y++ ) {
				for (_x = 0; _x < Map.mapWidth; _x++ ) {
					_tile = getFixTile(_x, _y);
					map.setMap(_x, _y, _tile?_tile.value:0);
				}
			}
		}
		private function addFallTile(_tile:Tile):void {
			if (tileFallDic[_tile]==_tile) {
				return;
			}
			setFixTile(_tile.lineX, _tile.lineY);
			tileFallDic[_tile] = _tile;
			tileFallDicLength++;
			makePrevFall(_tile);
		}
		private function removeFallTile(_tile:Tile):void {
			if (tileFallDic[_tile]!=_tile) {
				return;
			}
			delete tileFallDic[_tile];
			setFixTile(_tile.lineX, _tile.lineY, _tile);
			tileFallDicLength--;
			if (tileFallDicLength == 0) {
				//所有下落块下落完毕
				//根据当前块值填充地图
				fillMap();
				//检测是否有连击情况
				removeAllRight();
			}
		}
		private function addRemoveTile(_tile:Tile):void {
			if (tileRemoveDic[_tile]==_tile) {
				return;
			}
			setFixTile(_tile.lineX, _tile.lineY);
			tileRemoveDic[_tile] = _tile;
			tileRemoveDicLength++;
		}
		private function removeRemoveTile(_tile:Tile):void {
			if (tileRemoveDic[_tile]!=_tile) {
				return;
			}
			delete tileRemoveDic[_tile];
			addChild(_tile);
			makePrevFall(_tile);
			tileRemoveDicLength--;
			numRemoved++;
			if (tileRemoveDicLength == 0) {
				//所有需要消除的块已消除完毕
				//根据消除情况，增加新的块
				var _x, _y:uint;
				for (var _i:* in map.addDic) {
					_x = int(_i);
					for (_y = 0; _y < map.addDic[_i]; _y++) {
						createTile(_x, -(1 + _y), map.getTileValue());
					}
				}
				Map.picCount = Map.picMin + numRemoved / hardest * (Map.picMax - Map.picMin);
				if (onRemoveTiles != null) {
					onRemoveTiles(numRemoved);
				}
			}
		}
		private function makePrevFall(_tile:Tile):void {
			var _ary:Array = _tile.findPrev();
			var _lineX:int = _ary[0];
			var _lineY:int = _ary[1];
			var _tilePrev:Tile = getFixTile(_lineX, _lineY);
			if (_tilePrev) {
				_tilePrev.fallBegin();
			}
		}
	}
}
