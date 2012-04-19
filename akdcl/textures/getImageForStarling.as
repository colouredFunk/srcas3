package akdcl.textures
{
	import starling.display.Image;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public function getImageForStarling (_):Image{
		
	}
	private function getJoint(_textXML:XML,_texture:Texture):Sprite {
			var _rect:Rectangle = new Rectangle(int(_textXML.@x), int(_textXML.@y), int(_textXML.@width), int(_textXML.@height));
			var _subT:SubTexture = new SubTexture(_texture, _rect);
			var _img:Image = new Image(_subT);
			_img.x = int(_textXML.@frameX);
			_img.y = int(_textXML.@frameY);
			
			var _sprite:Sprite = new Sprite();
			_sprite.name = _textXML.@id;
			_sprite.addChild(_img);
			return _sprite;
		}
}