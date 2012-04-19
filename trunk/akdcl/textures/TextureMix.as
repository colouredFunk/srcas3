package akdcl.textures
{
	import flash.display.BitmapData;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class TextureMix{
		public var bitmapData:BitmapData;
		public var xml:XML;
		public var texture:Object;
		public function TextureMix(_bmd:BitmapData, _xml:XML = null, _texture:Object = null):void {
			bitmapData = _bmd;
			xml = _xml;
			texture = _texture;
		}
		
		public function getTextures(_prefix:String):XMLList {
			return xml.children().(@name.toString().indexOf(_prefix + "_") == 0);
		}
		
		public function getTexture(_id:String):XML {
			return xml.child(_id)[0];
		}
		
		public function getNodeName(_xml:XML):String {
			var _string:String = _xml.@name;
			var _start:int = _string.indexOf("_");
			if (_start > 0) {
				return _string.substr(_start + 1);
			}
			return _string;
		}
	}
}