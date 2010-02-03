package akdcl.game.tetris
{
	import flash.display.MovieClip;
	import com.greensock.TweenMax;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class TileClip extends MovieClip
	{
		public function TileClip() {
			stop();
			width = Tile.TILE_WIDTH + 1;
			height = Tile.TILE_HEIGHT + 1;
		}
		private var __lineX:int;
		public function get lineX():int{
			return __lineX;
		}
		public function set lineX(_lineX:int):void{
			__lineX = _lineX;
			x = __lineX * Tile.TILE_WIDTH;
		}
		public function moveToLineX(_lineX:int):void {
			
		}
		private var __lineY:int;
		public function get lineY():int{
			return __lineY;
		}
		public function set lineY(_lineY:int):void{
			__lineY = _lineY;
			y = __lineY * Tile.TILE_HEIGHT;
		}
		public function moveToLineY(_lineY:int):void {
			__lineY = _lineY;
			TweenMax.to(this, 0.2, { y:__lineY * Tile.TILE_HEIGHT, roundProps:["y"]} );
		}
		public function changeStyle(_frame:uint):void {
			gotoAndStop(_frame)
		}
	}
	
}