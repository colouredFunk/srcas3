package akdcl.textures
{
	import flash.geom.Rectangle;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.display.DisplayObject;
	import starling.textures.Texture;
	import starling.textures.SubTexture;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	final public class EasyForStarling {
		public static function addJointsTo(_sprite:Sprite, _textureMix:TextureMix, _id:String):void {
			var _xmlList:XMLList = _textureMix.getTextures(_id);
			
			for each(var _textXML:XML in _xmlList) {
				_sprite.addChild(getJoint(_textXML, _textureMix));
			}
		}
		
		private static function getJoint(_textXML:XML, _textureMix:TextureMix):DisplayObject {
			var _rect:Rectangle = new Rectangle(int(_textXML.@x), int(_textXML.@y), int(_textXML.@width), int(_textXML.@height));
			var _subT:SubTexture = new SubTexture(_textureMix.texture as Texture, _rect);
			var _img:Image = new Image(_subT);
			_img.pivotX = -int(_textXML.@frameX);
			_img.pivotY = -int(_textXML.@frameY);
			_img.name = _textureMix.getNodeName(_textXML);
			
			//var _sprite:Sprite = new Sprite();
			//_sprite.name = _img.name;
			//_sprite.addChild(_img);
			return _img;
		}
	}
	
}
			
			