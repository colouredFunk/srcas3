package akdcl.skeleton
{
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	final public class ConnectionData {
		public static const BONE:String = "bone";
		public static const ANIMATION:String = "animation";
		
		protected static var armatureXML:XML =<root/>;
		protected static var animationData:Object = { };
		
		public static function setData(_xml:XML, _isRadian:Boolean = false):void {
			var _name:String = _xml.@name;
			var _data:Object = animationData[_name];
			if (_data) {
				return;
			}
			
			armatureXML.appendChild(_xml);
			animationData[_name] = _data = { };
			
			var _frames:Object;
			var _frameList:FrameList;
			var _frame:Frame;
			var _frameXMLList:XMLList;
			var _r:Number;
			var _animationXMLList:XMLList = _xml.elements(ANIMATION);
			for each(var _frameXML:XML in _animationXMLList) {
				_frames = _data[_frameXML.@name] = { };
				for each(var _boneXML:XML in _frameXML.children()) {
					_name = _boneXML.name();
					if (_frames[_name]) {
						continue;
					}
					_frameXMLList = _frameXML.elements(_name);
					if (_frameXMLList.length() > 1) {
						_frameList = _frames[_name] = new FrameList();
						if (_frameXMLList[0].@scale.length() > 0) {
							_frameList.scale = Number(_frameXMLList[0].@scale);
						}
						if (_frameXMLList[0].@delay .length() > 0) {
							_frameList.delay = Number(_frameXMLList[0].@delay);
						}
						if (_frameXML.@delay.length() > 0) {
							_frameList.delay -= Number(_frameXML.@delay);
						}
						for each(_boneXML in _frameXMLList) {
							_r = Number(_boneXML.@r);
							if (_isRadian) {
								_r = _r * Math.PI / 180;
							}
							_frame = new Frame(Number(_boneXML.@x), Number(_boneXML.@y), _r, Number(_boneXML.@sX), Number(_boneXML.@sY));
							_frame.frame = int(_boneXML.@f);
							_frameList.addValue(_frame);
						}
					}else {
						_r = Number(_boneXML.@r);
						if (_isRadian) {
							_r = _r * Math.PI / 180;
						}
						_frame = new Frame(Number(_boneXML.@x), Number(_boneXML.@y), _r, Number(_boneXML.@sX), Number(_boneXML.@sY));
						_frames[_name] = _frame;
					}
				}
			}
			trace(armatureXML);
		}
		
		public static function getAnimation(_id:String):Object {
			return animationData[_id];
		}
		public static function getBones(_id:String):XMLList {
			var _xmlList:XMLList = armatureXML.children().(@name == _id).elements(BONE);
			if (_xmlList.length() == 0) {
				return null;
			}
			return _xmlList;
		}
	}
}