package akdcl.silhouette{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.FrameLabel;
	
	import flash.geom.Point;
	
	import akdcl.utils.localToLocal;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	final public class SilhouetteMaker {
		private static var instance:SilhouetteMaker;
		public static function getInstance():SilhouetteMaker {
			if (instance) {
			} else {
				instance = new SilhouetteMaker();
			}
			return instance;
		}
		
		private var pointTemp:Point;
		public function SilhouetteMaker() {
			if (instance) {
				throw new Error("[ERROR]:SilhouetteMaker Singleton already constructed!");
			}
			instance = this;
			init();
		}
		
		private function init():void {
			pointTemp = new Point();
		}
		
		public function makeSilhouetteData(_model:MovieClip):XML {
			_model.gotoAndStop(1);
			var _xml:XML = <Silhouette/>;
			_xml.@name = _model.xml.name();
			formatModelXML(_model.xml, _xml);
			generateConstructor(_model, _xml);
			generateAnimation(_model, _xml);
			return _xml;
		}
		
		private function generateConstructor(_model:MovieClip, _xml:XML):void {
			var _parent:DisplayObject;
			var _joint:DisplayObject;
			var _x:Number;
			var _y:Number;
			var _jointXML:XML;
			
			//按照深度顺序检索
			for (var _i:uint = 0; _i < _model.numChildren; _i++ ) {
				_joint = _model.getChildAt(_i);
				_jointXML = _xml.elements(_joint.name)[0];
				if (_jointXML) {
					
					//delete _xml[_joint.name];
					//_xml.insertChildBefore(_xml.children()[0], _jointXML);
					if (_jointXML.@link.length() > 0) {
						_parent = _model.getChildByName(_jointXML.@link);
					}else {
						_parent = _model.getChildByName(_jointXML.@parent);
					}
					if (_parent) {
						pointTemp.x = 0;
						pointTemp.y = 0;
						pointTemp = localToLocal(_joint, _parent, pointTemp);
						_x = pointTemp.x;
						_y = pointTemp.y;
						if (_model.getChildIndex(_joint) < _model.getChildIndex(_parent)) {
							_jointXML.@z = "0";
						}
						/*
						if (_jointXML.@footX.length() > 0) {
							while (_xml) {
								if (_xml.parent().name() != _model.name) {
									_xml = _xml.parent();
								}else {
									pointTemp.x = int(_jointXML.@footX);
									pointTemp.y = int(_jointXML.@footY);
									_xml.parent().@y = localToLocal(_joint, _model, pointTemp).y;
									_xml = null;
								}
							}
						}
						*/
					}else {
						_x = _joint.x;
						_y = _joint.y;
					}
					_jointXML.@x = Math.round(_x * 100) /100;
					_jointXML.@y = Math.round(_y * 100) /100;
				}else {
					trace("model:" + _model.name, "joint:" + _joint.name, "未找到对应的配置XML节点");
				}
			}
		}
		
		private function generateAnimation(_model:MovieClip, _trussXML:XML):void {
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
			
			var _length:uint = _model.currentLabels.length;
			
			for (var _i:uint = 0; _i < _length; _i++ ) {
				_frameLabel = _model.currentLabels[_i];
				//忽略第一帧的帧标签
				if (_frameLabel.frame == 1) {
					continue;
				}
				
				//获取带标签的帧的长度
				if (_i + 1 == _length) {
					_labelFrameLength = _model.totalFrames - _frameLabel.frame + 1;
				}else {
					_labelFrameLength = _model.currentLabels[_i + 1].frame - _frameLabel.frame;
				}
				
				_model.gotoAndStop(_frameLabel.name);
				for (var _k:uint = 0; _k < _labelFrameLength; _k++ ) {
					
					for (var _j:uint = 0; _j < _model.numChildren; _j++ ) {
						_joint = _model.getChildAt(_j);
						_jointXML = _trussXML.elements(_joint.name)[0];
						if (!_jointXML) {
							//没有配置xml的元件忽略
							continue;
						}
						_parent = (_model.getChildByName(_jointXML.@parent) || _model) as DisplayObjectContainer;
						
						if (_jointXML.@link.length() > 0) {
							pointTemp.x = 0;
							pointTemp.y = 0;
							pointTemp = localToLocal(_joint, _model.getChildByName(_jointXML.@link), pointTemp);
							_x = pointTemp.x;
							_y = pointTemp.y;
							_r = _joint.rotation;
						}else if (_joint.parent != _parent) {
							pointTemp.x = 0;
							pointTemp.y = 0;
							pointTemp = localToLocal(_joint, _parent, pointTemp);
							_x = pointTemp.x;
							_y = pointTemp.y;
							_r = _joint.rotation - _parent.rotation;
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
							_frameXML.@f = int(_frameXML.@f) + 1;
						}else {
							_frameXML =<{_frameLabel.name} x={_x} y={_y} r={_r} f="1"/>;
							_jointXML.appendChild(_frameXML);
						}
						_frameXML = null;
					}
					_model.nextFrame();
				}
			}
			
			//Math.max(_clip.forepawR.localToTarget(_clip, bootPoint).y, _clip.forepawL.localToTarget(_clip, bootPoint).y);
		}
		
		private function formatModelXML(_xml:XML, _xmlCopy:XML = null, _level:uint = 0):XML {
			var _jointXMLCopy:XML;
			for each(var _jointXML:XML in _xml.children()) {
				if (_jointXML.@link.length() > 0) {
					_jointXML.@link;
				}else {
					_jointXML.parent().name();
				}
				_jointXMLCopy = _jointXML.copy();
				delete _jointXMLCopy.*;
				if (_level > 0) {
					_jointXMLCopy.@parent = _jointXML.parent().name();
				}
				_xmlCopy.appendChild(_jointXMLCopy);
				if (_jointXML.children().length() > 0) {
					formatModelXML(_jointXML, _xmlCopy, _level+1);
				}
			}
			return _xmlCopy;
		}
	}
}