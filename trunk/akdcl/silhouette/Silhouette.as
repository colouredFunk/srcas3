package akdcl.silhouette
{
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class Silhouette {
		protected static var animationData:Object = { };
		protected static function formatAnimation(_xml:XML):Object {
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
			animationData[_xml.@name] = _data;
			return _data;
		}
		
		protected var aData:Object;
		protected var container:Object;
		protected var aniList:Array;
		protected var jointDic:Object;
		
		public function Silhouette(_container:Object) {
			super();
			aniList = [];
			jointDic = { };
			container = _container;
		}
		
		public function formatSilhouette(_xml:XML):void {
			aData = formatAnimation(_xml);
			
			var _joint:Object;
			var _parent:Object;
			var _ani:Animation;
			var _name:String;
			var _index:int;
			
			for each(var _jointXML:XML in _xml.children()) {
				_name = _jointXML.name();
				_joint = jointDic[_name];
				if (!_joint) {
					continue;
				}
				_ani = new Animation(_name);
				_parent = jointDic[_jointXML.@parent];
				_ani.joint = _joint;
				
				//根据z修改深度
				if (_parent) {
					//根据z修改深度
					_index = _jointXML.@z.length() > 0?int(_jointXML.@z): -1;
					if (_index < 0) {
						_parent.addChild(_joint);
					}else {
						_parent.addChildAt(_joint, _index);
					}
				}else {
					//根据z修改深度
					container.addChild(_joint);
				}
				_ani.offset.x = _joint.x = int(_jointXML.@x);
				_ani.offset.y = _joint.y = int(_jointXML.@y);
				//按照link和parent排序
				aniList.push(_ani);
			}
			/*
			var _lock:ModelPart;
			for each(_jointXML in _xmlList) {
				if (_jointXML.@lock.length() > 0) {
					_joint = partDic[_jointXML.name()];
					_lock = partDic[_jointXML.@lock];
					_lock.addFrom(_joint);
					_joint.lockPoint = new Point(int(_jointXML.@x), int(_jointXML.@y));
				}
			}
			*/
		}
		public function addJoint(_joint:Object, _id:String):void {
			jointDic[_id] = _joint;
		}
		
		public function addLinked(_joint:Object):void {
			
		}
		
		public function playTo(_frameLabel:String, _toFrame:uint, _listFrame:uint = 0, _isLoop:Boolean = false ):void {
			var _data:Object;
			for each(var _a:Animation in aniList) {
				_data = aData[_a.name][_frameLabel];
				_a.playTo(_data, _toFrame, _listFrame, _isLoop);
			}
		}
		
		public function update():void {
			for each(var _a:Animation in aniList) {
				_a.update();
			}
			/*
			for each(var _joint:ModelPart in lockFrom) {
				pointTemp = localToTarget(_joint.parent, _joint.lockPoint);
				_joint.control.x = pointTemp.x;
				_joint.control.y = pointTemp.y;
				//_joint.update();
			}
			*/
		}
	}
	
}