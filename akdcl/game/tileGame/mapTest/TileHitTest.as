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
		private var p_hit:*;
		private var mapContainer:Sprite;
		private var map:Map;
		private var matrix_0:Array = [
		[0],
		null,
		null,
		[null, null, 10],
		[null, null, 10],
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
			p_hit = container.p_hit;
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
			startDragPt(btn_p0);
			stopDragPt(btn_p0);
			
		}
		private function setTile(_tile:Tile):void {
			var _tileModel:TileModel = new TileModel();
			_tileModel.tile = _tile;
			_tileModel.update();
			mapContainer.addChild(_tileModel);
		}
		private function startDragPt(_pt:*):void {
			_pt.startDrag(true);
			btn_pt.lineClip.visible = false;
			p_hit.visible = false;
		}
		private function stopDragPt(_pt:*):void {
			_pt.stopDrag();
			btn_pt.lineClip.visible = true;
			btn_pt.lineClip.rotation = Math.atan2(btn_p0.y - btn_pt.y, btn_p0.x - btn_pt.x) * 180 / Math.PI;
			btn_pt.lineClip.clip.scaleX = Math.sqrt(Math.pow(btn_p0.y - btn_pt.y, 2) + Math.pow(btn_p0.x - btn_pt.x, 2));
			var _isHit:Boolean;
			_isHit = map.hitTest_2(btn_p0.x, btn_p0.y, btn_pt.x, btn_pt.y );
			if (_isHit) {
				p_hit.visible = true;
				p_hit.x = map.hitTestPt.x;
				p_hit.y = map.hitTestPt.y;
			}else {
				p_hit.visible = false;
			}
		}
	}
	
}
