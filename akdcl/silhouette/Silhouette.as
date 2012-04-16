package akdcl.silhouette
{
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class Silhouette {
		public static function formatAnimation(_xml:XML):Object {
			var _data:Object = { };
			var _joint:Object;
			var _frameXMLList:XMLList;
			var _frames:Array;
			var _frameValue:FrameValue;
			for each(var _jointXML:XML in _xml.children()) {
				_joint = _data[_jointXML.name()] = {};
				for each(var _frameXML:XML in _jointXML.children()) {
					_frameXMLList = _jointXML.elements(_frameXML.name());
					if (_frameXMLList.length() > 1) {
						_frames = [];
						for each(_frameXML in _frameXMLList) {
							_frameValue = new FrameValue(int(_frameXML.@x), int(_frameXML.@y), int(_frameXML.@r));
							_frames.push(_frameValue);
						}
						_joint[_frameXML.name()] = _frames;
					}else {
						_frameValue = new FrameValue(int(_frameXML.@x), int(_frameXML.@y), int(_frameXML.@r));
						_joint[_frameXML.name()] = _frameValue;
					}
					
				}
			}
			return _data;
		}
		
		/*protected function fixPart(_xml:XML, _level:uint = 0):void {
			var _xmlList:XMLList = _xml.children();
			var _part:Object;
			var _parent:Object;
			for each(var _jointXML:XML in _xmlList) {
				_Class = getDefinitionByName(_jointXML.@constructor) as Class;
				_part = new _Class() as ModelPart;
				_part.name = _jointXML.name();
				partDic[_jointXML.name()] = _part;
				_parent = partDic[_jointXML.parent().name()];
				
				//还有lock的情况
				if (_parent) {
					_parent.addPart(_part, int(_jointXML.@x), int(_jointXML.@y), _jointXML.@d.length() > 0?int(_jointXML.@d): -1);
				}else {
					addChild(_part);
					_part.x = int(_jointXML.@x);
					_part.y = int(_jointXML.@y);
				}
				
				fixPart(_jointXML, _level + 1);
			}
			if (_level == 0) {
				var _lock:ModelPart;
				for each(_jointXML in _xmlList) {
					if (_jointXML.@lock.length() > 0) {
						_part = partDic[_jointXML.name()];
						_lock = partDic[_jointXML.@lock];
						_lock.addFrom(_part);
						_part.lockPoint = new Point(int(_jointXML.@x), int(_jointXML.@y));
					}
				}
			}
		}*/
		
		protected var animationDic:Dictionary;
		public function Silhouette() {
			animationDic = new Dictionary();
		}
		
		protected function addJoint(_parent:*, _child:*, _x:int, _y:int, _index:int = -1):void {
			_child.x = _x;
			_child.y = _y;
			if (_index < 0) {
				_parent.addChild(_child);
			}else {
				_parent.addChildAt(_child, _index);
			}
			var _a:Animation = new Animation();
			_a.clip = _child;
			animationDic[_child] = _a;
		}
		
		protected function addLinked(_child:Object):void {
			
		}
		
		public function update():void {
			for each(var _a:Animation in animationDic) {
				_a.update();
			}
			/*for each(var _part:ModelPart in lockFrom) {
				pointTemp = localToTarget(_part.parent, _part.lockPoint);
				_part.control.x = pointTemp.x;
				_part.control.y = pointTemp.y;
				//_part.update();
			}*/
		}
	}
	
}