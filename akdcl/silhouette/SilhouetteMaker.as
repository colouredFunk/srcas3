package akdcl.silhouette{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.FrameLabel;
	
	import flash.geom.Point;
	
	import akdcl.utils.localToLocal;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	final public class SilhouetteMaker {
		private static const BONE:String = "bone";
		private static const ANIMATION:String = "animation";
		private static var pointTemp:Point = new Point();
		public static function encode(_templet:Templet):XML {
			var _xml:XML = <silhouette/>;
			_xml.@name = _templet.getTempletName();
			formatTempletXML(_templet.xml, _xml);
			generateBone(_templet, _xml);
			generateAnimation(_templet, _xml);
			return _xml;
		}
		
		private static function generateBone(_templet:Templet, _xml:XML):void {
			var _parent:DisplayObject;
			var _joint:DisplayObject;
			var _x:Number;
			var _y:Number;
			var _jointXML:XML;
			
			//按照深度顺序检索
			var _jointXMLList:XMLList = _xml.elements(BONE);
			var _length:uint = _templet.numChildren;
			var _dz:int = 0;
			for (var _i:uint = 0; _i < _length; _i++ ) {
				_joint = _templet.getChildAt(_i);
				_jointXML = _jointXMLList.(@name == _joint.name)[0];
				if (_jointXML) {
					_parent = _templet.getChildByName(_jointXML.@parent);
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
					_jointXML.@x = Math.round(_x * 100) /100;
					_jointXML.@y = Math.round(_y * 100) / 100;
					
					/*if (_jointXML.@cont.length() > 0) {
						_jointXMLList.(@name == _jointXML.@parent)[0].@conta = 1;
						_dz++;
						if (_templet.getChildIndex(_joint) < _templet.getChildIndex(_parent)) {
							_jointXML.@z = 0;
						}else {
							_jointXML.@z = -1;
						}
					}else {*/
						_jointXML.@z = _templet.getChildIndex(_joint) - _dz;
					//}
					
				}else {
					trace("templet:" + _templet.getTempletName(), "joint:" + _joint.name, "未找到对应的配置XML节点");
				}
			}
		}
		
		private static function generateAnimation(_templet:Templet, _xml:XML):void {
			
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
			
			var _arr:Array;
			
			var _frameXML:XML;
			var _jointXML:XML;
			var _jointFrameXML:XML;
			var _frameXMLList:XMLList;
			var _jointXMLList:XMLList = _xml.elements(BONE);
			var _length:uint = _templet.currentLabels.length;
			for (var _i:uint = 0; _i < _length; _i++ ) {
				_frameLabel = _templet.currentLabels[_i];
				//忽略第一帧的帧标签
				if (_frameLabel.frame == 1) {
					continue;
				}
				
				//获取带标签的帧的长度
				if (_i + 1 == _length) {
					_labelFrameLength = _templet.totalFrames - _frameLabel.frame + 1;
				}else {
					_labelFrameLength = _templet.currentLabels[_i + 1].frame - _frameLabel.frame;
				}
				_frameXML =<{ANIMATION} name={_frameLabel.name}/>;
				_xml.appendChild(_frameXML);
				_templet.gotoAndStop(_frameLabel.name);
				for (var _k:uint = 0; _k < _labelFrameLength; _k++ ) {
					for (var _j:uint = 0; _j < _templet.numChildren; _j++ ) {
						_joint = _templet.getChildAt(_j);
						_jointXML = _jointXMLList.(@name == _joint.name)[0];
						if (!_jointXML) {
							//没有配置xml的元件忽略
							continue;
						}
						
						_parent = (_templet.getChildByName(_jointXML.@parent)) as DisplayObjectContainer;
						
						if (_parent) {
							/*if (_jointXML.@cont.length() > 0) {
								_r = _joint.rotation - _parent.rotation;
								pointTemp.x = 0;
								pointTemp.y = 0;
								pointTemp = localToLocal(_joint, _parent, pointTemp);
								_x = pointTemp.x;
								_y = pointTemp.y;
							}else {*/
								_r = _joint.rotation;
								pointTemp.x = 0;
								pointTemp.y = 0;
								pointTemp = localToLocal(_joint, _parent, pointTemp);
								_x = pointTemp.x;
								_y = pointTemp.y;
							//}
						}else {
							_r = _joint.rotation;
							_x = _joint.x;
							_y = _joint.y;
						}
						
						_r = Math.round(_r * 100) / 100;
						_x = Math.round((_x - Number(_jointXML.@x)) * 100) / 100;
						_y = Math.round((_y - Number(_jointXML.@y)) * 100) / 100;
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
						_jointXML = null;
						_frameXMLList = _frameXML.elements(_joint.name);
						if (_frameXMLList.length() > 0) {
							_jointXML = _frameXMLList[_frameXMLList.length() - 1];
						}
						
						if (_jointXML && int(_jointXML.@x) == int(_x) && int(_jointXML.@y) == int(_y) && int(_jointXML.@r) == int(_r) && Number(_jointXML.@sX) == Number(_sX) && Number(_jointXML.@sX) == Number(_sY)) {
							//忽略相同的节点
							_jointXML.@f = int(_jointXML.@f) + 1;
						}else {
							_jointFrameXML =<{_joint.name} x={_x} y={_y} r={_r} sX={_sX} sY={_sY} f="1"/>;
							//
							_scale = Number(_joint["scale"]);
							_joint["scale"] = 0;
							if (!isNaN(_scale) && _scale != 0) {
								_jointFrameXML.@scale = _scale;
							}
							//
							_delay = Number(_joint["delay"]);
							_joint["delay"] = 0;
							if (!isNaN(_delay) && _delay != 0) {
								_jointFrameXML.@delay = _delay;
								if (_delay < 0&&Number(_frameXML.@delay)>_delay) {
									_frameXML.@delay = _delay;
								}
							}
							if (_jointXML) {
								_frameXML.insertChildAfter(_jointXML,_jointFrameXML);
							}else {
								_frameXML.appendChild(_jointFrameXML);
							}
						}
					}
					_templet.nextFrame();
				}
			}
			//Math.max(_clip.forepawR.localToTarget(_clip, bootPoint).y, _clip.forepawL.localToTarget(_clip, bootPoint).y);
		}
		
		private static function formatTempletXML(_xml:XML, _xmlCopy:XML = null, _level:uint = 0):XML {
			var _jointXMLCopy:XML;
			for each(var _jointXML:XML in _xml.children()) {
				_jointXMLCopy = _jointXML.copy();
				_jointXMLCopy.setName(BONE);
				_jointXMLCopy.@name = _jointXML.name();
				if (_level > 0) {
					_jointXMLCopy.@parent = _jointXML.parent().name();
				}
				delete _jointXMLCopy.*;
				_xmlCopy.appendChild(_jointXMLCopy);
				if (_jointXML.children().length() > 0) {
					formatTempletXML(_jointXML, _xmlCopy, _level+1);
				}
			}
			return _xmlCopy;
		}
	}
}