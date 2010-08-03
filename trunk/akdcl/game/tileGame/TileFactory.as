package akdcl.game.tileGame
{
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class TileFactory
	{
		public static const walkFlagValues:Array=[[0,0],[1,0],[0,1],[-1,0],[0,-1],[1,1],[-1,1],[-1,-1],[1,-1],[0,NaN],[NaN,0],[1,NaN],[NaN,1],[-1,NaN],[NaN,-1],[NaN,NaN]];
		public static function makeTile(_tileX:uint, _tileY:uint, _flag:uint):Tile {
			var _tile:Tile;
			if (_flag<16) {
				_tile = new TileRect(_tileX, _tileY, walkFlagValues[_flag]);
			}else if (_flag<20) {
				
			}
		}
	}
	
}