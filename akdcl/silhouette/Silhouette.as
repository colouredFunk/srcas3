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
			
			var _frame:Object;
			var _jointFrameXMLList:XMLList;
			var _frames:FrameList;
			var _frameValue:FrameValue;
			var _r:Number;
			for each(var _frameXML:XML in _xml.elements("animation")) {
				_frame = _data[_frameXML.@name] = { };
				for each(var _jointXML:XML in _frameXML.children()) {
					_name = _jointXML.name();
					if (_frame[_name]) {
						continue;
					}
					_jointFrameXMLList = _frameXML.elements(_name);
					if (_jointFrameXMLList.length() > 1) {
						_frames = _frame[_name] = new FrameList();
						if (_jointFrameXMLList[0].@scale.length() > 0) {
							_frames.scale = Number(_jointFrameXMLList[0].@scale);
						}
						for each(_jointXML in _jointFrameXMLList) {
							_r = Number(_jointXML.@r);
							if (_isRadian) {
								_r = _r * Math.PI / 180;
							}
							_frameValue = new FrameValue(Number(_jointXML.@x), Number(_jointXML.@y), _r);
							_frameValue.frame = int(_jointXML.@f);
							_frames.addValue(_frameValue);
						}
					}else {
						_frame[_name] = _frameValue;
						_r = Number(_jointXML.@r);
						if (_isRadian) {
							_r = _r * Math.PI / 180;
						}
						_frameValue = new FrameValue(Number(_jointXML.@x), Number(_jointXML.@y), _r);
						_frameValue.frame = int(_jointXML.@f);
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
			
			
			var _indexT:int;
			var _jointT:Object;
			var _list:Array = [];
			var _jointXMLList:XMLList = _xml.elements("bone");
			var _len:uint = _jointXMLList.length();
			
			//按照link和parent优先索引
			for (var _i:uint = 0; _i < _len; _i++ ) {
				_jointXML = _jointXMLList[_i];
				_name = _jointXML.@name;
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
					_linkAni.addChild(_ani, Number(_jointXML.@x), Number(_jointXML.@y));
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
		
		public function playTo(_frameLabel:String, _toFrame:uint, _listFrame:uint = 0, _loopType:int = 0, _delayFrame:int = 0, _delayJoints:Array=null):void {
			var _frameFix:int;
			if (_delayFrame >= 0) {
				_frameFix = _toFrame;
				_delayFrame = _toFrame + _delayFrame;
			}else {
				_frameFix = _toFrame - _delayFrame;
				_delayFrame = _toFrame;
			}
			
			var _data:Object = aData[_frameLabel];
			for each(var _a:Animation in aniList) {
				if (_delayJoints && _delayJoints.indexOf(_a.name) >= 0) {
					_toFrame = _delayFrame;
				}else {
					_toFrame = _frameFix;
				}
				_a.playTo(_data[_a.name], _toFrame, _listFrame, _loopType);
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