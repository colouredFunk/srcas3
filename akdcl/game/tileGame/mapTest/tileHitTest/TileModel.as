package tileHitTest
{
	import akdcl.game.tileGame.Tile;
	import flash.display.MovieClip;
	import ui_2.Btn;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class TileModel extends Btn 
	{
		public var clip:MovieClip;
		public var tile:Tile;
		public function TileModel() {
			clip.stop();
		}
		public function update():void {
			if (!tile) {
				return;
			}
			clip.gotoAndStop(tile.walkFlag + 1);
			x = tile.tileX * tile.map.tileWidth;
			y = tile.tileY * tile.map.tileHeight;
			release = function():void {
				tile.walkFlag++;
				update();
			}
		}
	}
	
}