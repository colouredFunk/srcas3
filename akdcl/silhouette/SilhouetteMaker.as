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
		private static var pointTemp:Point = new Point();
		public static function encode(_templet:Templet):XML {
			var _xml:XML = <Silhouette/>;
			_xml.@name = _templet.getTempletName();
			formatTempletXML(_templet.xml, _xml);
			generateConstructor(_templet, _xml);
			generateAnimation(_templet, _xml);
			return _xml;
		}
		
		private static function generateConstructor(_templet:Templet, _xml:XML):void {
			var _parent:DisplayObject;
			var _joint:DisplayObject;
			var _x:Number;
			var _y:Number;
			var _jointXML:XML;
			var _len:uint;
			
			//按照深度顺序检索
			_len = _templet.numChildren;
			var _dz:int = 0;
			for (var _i:uint = 0; _i < _len; _i++ ) {
				_joint = _templet.getChildAt(_i);
				_jointXML = _xml.elements(_joint.name)[0];
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
					
					if (_jointXML.@cont.length() > 0) {
						_dz++;
						if (_templet.getChildIndex(_joint) < _templet.getChildIndex(_parent)) {
							_jointXML.@z = 0;
						}else {
							_jointXML.@z = -1;
						}
					}else {
						_jointXML.@z = _templet.getChildIndex(_joint) - _dz;
					}
					
				}else {
					trace("templet:" + _templet.getTempletName(), "joint:" + _joint.name, "未找到对应的配置XML节点");
				}
			}
		}
		
		private static function generateAnimation(_templet:Templet, _trussXML:XML):void {
			var _jointXML:XML;
			var _frameXML:XML;
			var _frameXMLList:XMLList;
			
			var _frameLabel:FrameLabel;
			
			var _parent:DisplayObjectContainer;
			var _joint:DisplayObject;
			var _x:Number;
			var _y:Number;
			var _r:Number;
			
			var _labelFrameLength:uint;
			
			var _arr:Array;
			
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
				
				_templet.gotoAndStop(_frameLabel.name);
				for (var _k:uint = 0; _k < _labelFrameLength; _k++ ) {
					
					for (var _j:uint = 0; _j < _templet.numChildren; _j++ ) {
						_joint = _templet.getChildAt(_j);
						_jointXML = _trussXML.elements(_joint.name)[0];
						if (!_jointXML) {
							//没有配置xml的元件忽略
							continue;
						}
						
						_parent = (_templet.getChildByName(_jointXML.@parent)) as DisplayObjectContainer;
						
						if (_parent) {
							if (_jointXML.@cont.length() > 0) {
								pointTemp.x = 0;
								pointTemp.y = 0;
								pointTemp = localToLocal(_joint, _parent, pointTemp);
								_x = pointTemp.x;
								_y = pointTemp.y;
								_r = _joint.rotation - _parent.rotation;
							}else {
								pointTemp.x = 0;
								pointTemp.y = 0;
								pointTemp = localToLocal(_joint, _parent, pointTemp);
								_x = pointTemp.x;
								_y = pointTemp.y;
								_r = _joint.rotation;
							}
						}else {
							_x = _joint.x;
							_y = _joint.y;
							_r = _joint.rotation;
						}
						
						_x = Math.round((_x - Number(_jointXML.@x)) * 100) / 100;
						_y = Math.round((_y - Number(_jointXML.@y)) * 100) / 100;
						_r = Math.round(_r * 100) / 100;
						if (Math.abs(_x) < 1) {
							_x = 0;
						}
						if (Math.abs(_y) < 1) {
							_y = 0;
						}
						if (Math.abs(_r) < 1) {
							_r = 0;
						}
						_frameXMLList = _jointXML.elements(_frameLabel.name);
						if (_frameXMLList.length() > 0) {
							_frameXML = _frameXMLList[_frameXMLList.length() - 1];
						}
						
						if (_frameXML && int(_frameXML.@x) == int(_x) && int(_frameXML.@y) == int(_y) && int(_frameXML.@r) == int(_r)) {
							//忽略相同的节点
							//if (_k == _labelFrameLength - 1) {
								//忽略最后一个节点的长度
								//_frameXML.@f = 1;
							//}else {
								_frameXML.@f = int(_frameXML.@f) + 1;
							//}
						}else {
							_frameXML =<{_frameLabel.name} x={_x} y={_y} r={_r} f="1"/>;
							_jointXML.appendChild(_frameXML);
						}
						_frameXML = null;
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
				delete _jointXMLCopy.*;
				if (_level > 0) {
					_jointXMLCopy.@parent = _jointXML.parent().name();
				}
				_xmlCopy.appendChild(_jointXMLCopy);
				if (_jointXML.children().length() > 0) {
					formatTempletXML(_jointXML, _xmlCopy, _level+1);
				}
			}
			return _xmlCopy;
		}
	}
}