package akdcl.silhouette
{
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class Silhouette {
		protected static var allXML:XML =<root/>;
		protected static var animationData:Object = { };
		public static function decode(_xml:XML, _isRadian:Boolean = false):void {
			var _name:String = _xml.@name;
			var _data:Object = animationData[_name];
			if (_data) {
				return;
			}
			
			allXML.appendChild(_xml);
			animationData[_name] = _data = { };
			
			var _joint:Object;
			var _frameXMLList:XMLList;
			var _frames:Array;
			var _frameValue:FrameValue;
			var _r:Number;
			for each(var _jointXML:XML in _xml.children()) {
				_joint = _data[_jointXML.name()] = {};
				for each(var _frameXML:XML in _jointXML.children()) {
					_frameXMLList = _jointXML.elements(_frameXML.name());
					if (_frameXMLList.length() > 1) {
						_frames = [];
						for each(_frameXML in _frameXMLList) {
							_r = Number(_frameXML.@r);
							if (_isRadian) {
								_r = _r * Math.PI / 180;
							}
							_frameValue = new FrameValue(Number(_frameXML.@x), Number(_frameXML.@y), _r);
							_frameValue.frame = int(_frameXML.@f);
							_frames.push(_frameValue);
						}
						_joint[_frameXML.name()] = _frames;
					}else {
						_r = Number(_frameXML.@r);
						if (_isRadian) {
							_r = _r * Math.PI / 180;
						}
						_frameValue = new FrameValue(Number(_frameXML.@x), Number(_frameXML.@y), _r);
						_frameValue.frame = int(_frameXML.@f);
						_joint[_frameXML.name()] = _frameValue;
					}
					
				}
			}
			trace(_xml);
		}
		
		protected var aData:Object;
		protected var container:Object;
		protected var jointDic:Object;
		protected var aniDic:Object;
		protected var aniList:Array;
		
		public function Silhouette(_container:Object) {
			super();
			jointDic = { };
			aniDic = { };
			aniList = [];
			
			if (_container) {
				addJoints(_container);
			}
		}
		
		public function setup(_xmlID:String, _isRadian:Boolean = false):void {
			aData = animationData[_xmlID];
			var _xml:XML = allXML.children().(@name == _xmlID)[0];
			if (!container || !_xml) {
				return;
			}
			
			var _ani:Animation;
			var _linkAni:Animation;
			var _joint:Object;
			var _parent:Object;
			var _jointXML:XML;
			var _name:String;
			var _isContent:Boolean;
			var _index:int;
			
			var _len:uint = _xml.children().length();
			
			var _indexT:int;
			var _jointT:Object;
			var _list:Array = [];
			
			//按照link和parent优先索引
			for (var _i:uint = 0; _i < _len; _i++ ) {
				_jointXML = _xml.children()[_i];
				_name = _jointXML.name();
				_joint = jointDic[_name];
				if (!_joint) {
					continue;
				}
				
				_ani = new Animation(_name);
				_ani.joint = _joint;
				_parent = jointDic[_jointXML.@parent];
				_isContent = _jointXML.@cont.length() > 0;
				
				if (_parent && !_isContent) {
					_linkAni = aniDic[_jointXML.@parent];
					_linkAni.addLinked(_ani, Number(_jointXML.@x), Number(_jointXML.@y));
				}else {
					_ani.offset.x = _joint.x = Number(_jointXML.@x);
					_ani.offset.y = _joint.y = Number(_jointXML.@y);
				}
				
				_index = int(_jointXML.@z);
				
				if (_parent && _isContent) {
					if (_index<0) {
						_parent.addChild(_joint);
					}else {
						_parent.addChildAt(_joint, 0);
					}
				}else {
					for (var _j:uint = _index; _j < _list.length; _j++) {
						_jointT = _list[_j];
						if (_jointT) {
							break;
						}
					}
					
					if (_jointT) {
						container.addChildAt(_joint, container.getChildIndex(_jointT)-1);
					}else {
						container.addChild(_joint);
					}
					
					_list[_index] = _joint;
					_jointT = null;
				}
				
				//按照link和parent排序
				aniList.push(_ani);
				aniDic[_name] = _ani;
			}
		}
		
		public function playTo(_frameLabel:String, _toFrame:uint, _listFrame:uint = 0, _loopType:int = 0, _delayFrame:uint = 0, _delayJoints:Array=null, _halfJoints:Array=null):void {
			var _frameFix:uint;
			if (_delayFrame >= 0) {
				_frameFix = _toFrame + _delayFrame;
				_delayFrame = _toFrame;
			}else {
				_frameFix = _toFrame;
				_delayFrame = _toFrame - _delayFrame;
			}
			
			var _data:Object;
			for each(var _a:Animation in aniList) {
				_data = aData[_a.name][_frameLabel];
				if (!_data) {
					continue;
				}
				if (_delayJoints && _delayJoints.indexOf(_a.name) >= 0) {
					_toFrame = _delayFrame;
				}else {
					_toFrame = _frameFix;
				}
				_a.playTo(_data, _toFrame, (_halfJoints && _halfJoints.indexOf(_a.name) >= 0)?_listFrame * 0.5:_listFrame, _loopType);
			}
		}
		
		public function update():void {
			for each(var _a:Animation in aniList) {
				_a.update();
			}
		}
		
		public function addJoints(_container:Object):void {
			var _id:String;
			var _joint:Object;
			for (var _i:uint = 0; _i < _container.numChildren; _i++) {
				_id = _container.getChildAt(_i).name;
				_joint = _container.getChildAt(_i);
				jointDic[_id] = _joint;
			}
			container = _container;
		}
	}
	
}