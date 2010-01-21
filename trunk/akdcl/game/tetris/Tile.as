package akdcl.game.tetris
{
	/**
	 * ...
	 * @author Akdcl
	 */
	public class Tile extends Sprite
	{
		public static const A0:Array = [[0, 0], [0, 1], [0, 2], [0, 3]];
		public static const A1:Array = [[0, 0], [1, 0], [0, 1], [1, 1]];
		public static const A2:Array = [[0, 0], [0, 1], [1, 1], [0, 2]];
		public static const A3:Array = [[0, 0], [1, 0], [0, 1], [0, 2]];
		public static const A4:Array = [[0, 0], [0, 1], [0, 2], [1, 2]];
		public static const A5:Array = [[0, 0], [0, 1], [1, 1], [1, 2]];
		public static const A6:Array = [[1, 0], [0, 1], [1, 1], [0, 2]];
		protected var matrix:Array;
		public function Tile(_matrix:Array) {
			matrix = _matrix.concat();
		}
	}
	
}