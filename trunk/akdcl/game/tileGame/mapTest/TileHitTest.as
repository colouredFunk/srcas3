package 
{
	import akdcl.game.tileGame.Map;
	import akdcl.game.tileGame.Tile;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import tileHitTest.TileModel;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class TileHitTest extends MovieClip 
	{
		public var container:*;
		private var tileModel:TileModel;
		private var btn_p0, btn_pt:*;
		
		private var mapContainer:Sprite;
		private var map:Map;
		private var matrix_0:Array = [
		[0],
		null,
		null,
		null,
		null,
		null,
		null,
		[null, null, 4, 4, null, null,9, 9],
		null,
		null,
		null,
		[null, null, null, null, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15],
		];
		public function TileHitTest() {
			//tileModel = container.tile_model;
			btn_p0 = container.btn_p0;
			btn_pt = container.btn_pt;
			btn_p0.press = btn_pt.press =  function():void {
				startDragPt(this);
			}
			btn_p0.release = btn_pt.release =  function():void {
				stopDragPt(this);
			}
			mapContainer = new Sprite();
			container.addChildAt(mapContainer, 0);
			
			
			map = new Map();
			map.tileWidth = 40;
			map.tileHeight = 40;
			map.matrix = matrix_0;
			map.mapping();
			map.eachTile(setTile);
			
			
			
			
		}
		private function setTile(_tile:Tile):void {
			var _tileModel:TileModel = new TileModel();
			_tileModel.tile = _tile;
			_tileModel.update();
			mapContainer.addChild(_tileModel);
		}
		private function startDragPt(_pt:*):void {
			_pt.startDrag(true);
		}
		private function stopDragPt(_pt:*):void {
			_pt.stopDrag();
		}
		private function hitTestPtVector(_x:Number, _y:Number,_dx:Number,_dy:Number):void {
			var _xt:Number = _x + _dx;
			var _yt:Number = _y + _dy;
			
			var _tileX_0:uint = map.xToTileX(_x);
			var _tileY_0:uint = map.yToTileY(_y);
			
			var _tileX_t:uint = map.xToTileX(_xt);
			var _tileY_t:uint = map.yToTileY(_yt);
			
			var _tile_t:Tile = map.getTile(_tileX_t, _tileY_t);
			
			
			
			if (_tile_t) {
				var _checkX:Boolean = (_dx * _tile_t.walkX >= 0);
				var _checkY:Boolean = (_dy * _tile_t.walkY >= 0);
				if (_checkX && _checkY) {
					//目标区块可通行
				}else if (!_checkX && !_checkY) {
					//目标区块无法通行
					//找到精确的碰撞点
				}else if(_checkX) {
					//y轴方向有可能无法通过
					
					var _y0:Number = (_tileY_t + _tile_t.walkY * 0.5) * map.tileHeight;
					
					xxxxx = (_y0 - _y) * (_xt - _x) / (_yt - _y) + _x;
				}else {
					//x轴方向有可能无法通过
					
					var _x0:Number = (_tileX_t + _tile_t.walkX * 0.5) * map.tileWidth;
					
					yyyyy = (_x0 - _x) * (_yt - _y) / (_xt - _x) + _y;
				}
			}
			//return false;
		}
	}
	
}
