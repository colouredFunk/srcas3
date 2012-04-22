package akdcl.skeleton{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.FrameLabel;
	
	import flash.geom.Point;
	
	import akdcl.utils.localToLocal;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	final public class ConnectionDataMaker {
		private static var pointTemp:Point = new Point();
		public static function encode(_contour:Contour):XML {
			var _xml:XML = <skeleton/>;
			_xml.@name = _contour.getName();
			formatXML(_contour.xml, _xml);
			generateBone(_contour, _xml);
			generateAnimation(_contour, _xml);
			return _xml;
		}
		
		private static function formatXML(_xml:XML, _xmlCopy:XML = null, _level:uint = 0):void {
			var _boneCopy:XML;
			var _boneXMLList:XMLList = _xml.children();
			for each(var _boneXML:XML in _boneXMLList) {
				_boneCopy = _boneXML.copy();
				_boneCopy.setName(ConnectionData.BONE);
				_boneCopy.@name = _boneXML.name();
				if (_level > 0) {
					_boneCopy.@parent = _boneXML.parent().name();
				}
				delete _boneCopy.*;
				_xmlCopy.appendChild(_boneCopy);
				if (_boneXML.children().length() > 0) {
					formatXML(_boneXML, _xmlCopy, _level+1);
				}
			}
		}
		
		private static function generateBone(_contour:Contour, _xml:XML):void {
			var _parent:DisplayObject;
			var _joint:DisplayObject;
			var _x:Number;
			var _y:Number;
			var _boneXML:XML;
			
			//按照深度顺序检索
			var _boneXMLList:XMLList = _xml.elements(ConnectionData.BONE);
			var _length:uint = _contour.numChildren;
			for (var _i:uint = 0; _i < _length; _i++ ) {
				_joint = _contour.getChildAt(_i);
				_boneXML = _boneXMLList.(@name == _joint.name)[0];
				if (_boneXML) {
					_parent = _contour.getChildByName(_boneXML.@parent);
					if (_parent) {
						pointTemp.x = 0;
						pointTemp.y = 0;
						pointTemp = localToLocal(_joint, _parent, pointTemp);
						_x = pointTemp.x;
						_y = pointTemp.y;
					}else {
						_x = _joint.x;
						_y = _joint.y;
					}
					_boneXML.@x = Math.round(_x * 100) /100;
					_boneXML.@y = Math.round(_y * 100) / 100;
					_boneXML.@z = _contour.getChildIndex(_joint);
				}else {
					trace("contour:" + _contour.getName(), "bone:" + _joint.name, "未找到对应的配置XML节点");
				}
			}
		}
		
		private static function generateAnimation(_contour:Contour, _xml:XML):void {
			var _frameLabel:FrameLabel;
			
			var _parent:DisplayObjectContainer;
			var _joint:DisplayObject;
			var _r:Number;
			var _x:Number;
			var _y:Number;
			var _sX:Number;
			var _sY:Number;
			var _delay:Number;
			var _scale:Number;
			
			var _labelFrameLength:uint;
			var _name:String;
			
			var _animationXML:XML;
			var _boneXML:XML;
			var _boneFrameXML:XML;
			var _frameXMLList:XMLList;
			var _boneXMLList:XMLList = _xml.elements(ConnectionData.BONE);
			var _length:uint = _contour.currentLabels.length;
			for (var _i:uint = 0; _i < _length; _i++ ) {
				_frameLabel = _contour.currentLabels[_i];
				//忽略第一帧的帧标签
				if (_frameLabel.frame == 1) {
					continue;
				}
				
				//获取带标签的帧的长度
				if (_i + 1 == _length) {
					_labelFrameLength = _contour.totalFrames - _frameLabel.frame + 1;
				}else {
					_labelFrameLength = _contour.currentLabels[_i + 1].frame - _frameLabel.frame;
				}
				_animationXML =<{ConnectionData.ANIMATION} name={_frameLabel.name}/>;
				_xml.appendChild(_animationXML);
				_contour.gotoAndStop(_frameLabel.name);
				for (var _k:uint = 0; _k < _labelFrameLength; _k++ ) {
					//扫描标签动画的每帧
					for (var _j:uint = 0; _j < _contour.numChildren; _j++ ) {
						_joint = _contour.getChildAt(_j);
						_name = _joint.name;
						_boneXML = _boneXMLList.(@name == _name)[0];
						if (!_boneXML) {
							//没有配置xml的元件忽略
							continue;
						}
						
						_parent = (_contour.getChildByName(_boneXML.@parent)) as DisplayObjectContainer;
						
						if (_parent) {
							_r = _joint.rotation - _parent.rotation;
							pointTemp.x = 0;
							pointTemp.y = 0;
							pointTemp = localToLocal(_joint, _parent, pointTemp);
							_x = pointTemp.x - Number(_boneXML.@x);
							_y = pointTemp.y - Number(_boneXML.@y);
						}else {
							_r = _joint.rotation;
							_x = _joint.x;
							_y = _joint.y;
						}
						
						_r = Math.round(_r * 100) / 100;
						_x = Math.round(_x * 100) / 100;
						_y = Math.round(_y * 100) / 100;
						_sX = Math.round(_joint.scaleX * 20) / 20;
						_sY = Math.round(_joint.scaleY * 20) / 20;
						if (Math.abs(_r) < 1) {
							_r = 0;
						}
						if (Math.abs(_x) < 1) {
							_x = 0;
						}
						if (Math.abs(_y) < 1) {
							_y = 0;
						}
						
						_boneXML = null;
						_frameXMLList = _animationXML.elements(_name);
						if (_frameXMLList.length() > 0) {
							_boneXML = _frameXMLList[_frameXMLList.length() - 1];
						}
						
						if (_boneXML && int(_boneXML.@x) == int(_x) && int(_boneXML.@y) == int(_y) && int(_boneXML.@r) == int(_r) && Number(_boneXML.@sX) == Number(_sX) && Number(_boneXML.@sX) == Number(_sY)) {
							//忽略相同的节点
							_boneXML.@f = int(_boneXML.@f) + 1;
						}else {
							_boneFrameXML =<{_name} x={_x} y={_y} r={_r} sX={_sX} sY={_sY} f="1"/>;
							_scale = _contour.getValue(_name, "scale");
							if (_scale) {
								_boneFrameXML.@scale = _scale;
							}
							_delay = _contour.getValue(_name, "delay");
							if (_delay) {
								_boneFrameXML.@delay = _delay;
								if (_delay < 0 && Number(_animationXML.@delay) > _delay) {
									_animationXML.@delay = _delay;
								}
							}
							if (_boneXML) {
								_animationXML.insertChildAfter(_boneXML, _boneFrameXML);
							}else {
								_animationXML.appendChild(_boneFrameXML);
							}
						}
					}
					_contour.clearValues();
					_contour.nextFrame();
				}
			}
		}
	}
}