package akdcl.skeleton
{
	import flash.geom.Point;
	
	/**
	 * 用来格式化、管理骨骼配置与骨骼动画的静态工具类
	 * @author Akdcl
	 */
	final public class ConnectionData {
		/**
		 * @private
		 */
		internal static const BONE:String = "bone";
		
		/**
		 * @private
		 */
		internal static const ANIMATION:String = "animation";
		
		/**
		 * @private
		 */
		protected static var armatureXML:XML =<root/>;
		
		/**
		 * @private
		 */
		protected static var animationData:Object = { };
		
		/**
		 * 将ConnectionDataMaker生成的XML数据转换成内置数据
		 * @param _xml XML数据
		 * @param _isRadian XML数据中的角度是否使用弧度制，默认使用角度制，当使用starling时需要使用弧度制
		 */
		public static function setData(_xml:XML, _isRadian:Boolean = false):void {
			var _name:String = _xml.@name;
			var _data:Object = animationData[_name];
			if (_data) {
				return;
			}
			
			armatureXML.appendChild(_xml);
			animationData[_name] = _data = { };
			
			var _frames:Object;
			var _nodeList:NodeList;
			var _node:Node;
			var _frameXMLList:XMLList;
			var _r:Number;
			var _animationXMLList:XMLList = _xml.elements(ANIMATION);
			for each(var _frameXML:XML in _animationXMLList) {
				_frames = _data[_frameXML.@name] = { };
				for each(var _nodeXML:XML in _frameXML.children()) {
					_name = _nodeXML.name();
					if (_frames[_name]) {
						continue;
					}
					_frameXMLList = _frameXML.elements(_name);
					if (_frameXMLList.length() > 1) {
						_nodeList = _frames[_name] = new NodeList();
						if (_frameXMLList[0].@scale.length() > 0) {
							_nodeList.scale = Number(_frameXMLList[0].@scale);
						}
						if (_frameXMLList[0].@delay .length() > 0) {
							_nodeList.delay = Number(_frameXMLList[0].@delay);
						}
						if (_frameXML.@delay.length() > 0) {
							_nodeList.delay -= Number(_frameXML.@delay);
						}
						for each(_nodeXML in _frameXMLList) {
							_r = Number(_nodeXML.@r);
							if (_isRadian) {
								_r = _r * Math.PI / 180;
							}
							_node = new Node(Number(_nodeXML.@x), Number(_nodeXML.@y), _r, Number(_nodeXML.@sX), Number(_nodeXML.@sY));
							if (_nodeXML.@alpha.length()>0) {
								_node.alpha = Number(_nodeXML.@alpha);
							}
							_node.totalFrames = int(_nodeXML.@f);
							_nodeList.addValue(_node);
						}
					}else {
						_r = Number(_nodeXML.@r);
						if (_isRadian) {
							_r = _r * Math.PI / 180;
						}
						_node = new Node(Number(_nodeXML.@x), Number(_nodeXML.@y), _r, Number(_nodeXML.@sX), Number(_nodeXML.@sY));
						if (_nodeXML.@alpha.length()>0) {
							_node.alpha = Number(_nodeXML.@alpha);
						}
						_frames[_name] = _node;
					}
				}
			}
			trace(_xml);
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