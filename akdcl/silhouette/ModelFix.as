package akdcl.silhouette{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.FrameLabel;
	import flash.geom.Rectangle;
	
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
		
		private static function generateModelAnimation(_model:MovieClip, _jointXMLDic:Object):XML {
			var _animationXML:XML = <animation/>;
			var _jointXML:XML;
			var _frameXML:XML;
			var _frameXMLList:XMLList;
			
			var _frameLabel:FrameLabel;
			
			var _parent:DisplayObjectContainer;
			var _joint:DisplayObject;
			var _x:Number;
			var _y:Number;
			var _r:Number;
			var _point:Point;
			
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
						_jointXML = _jointXMLDic[_joint.name];
						if (!_jointXML) {
							//没有配置xml的元件忽略
							continue;
						}
						_parent = (_model.getChildByName(_jointXML.parent().name()) || _model) as DisplayObjectContainer;
						
						if (_jointXML.@link.length() > 0) {
							pointTemp.x = 0;
							pointTemp.y = 0;
							_point = localToLocal(_joint, _model.getChildByName(_jointXML.@link), pointTemp);
							_x = _point.x;
							_y = _point.y;
							_r = _joint.rotation;
						}else if (_joint.parent != _parent) {
							pointTemp.x = 0;
							pointTemp.y = 0;
							_point = localToLocal(_joint, _parent, pointTemp);
							_x = _point.x;
							_y = _point.y;
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
						
						_jointXML = _animationXML.elements(_joint.name)[0];
						if (!_jointXML) {
							_jointXML = <{_joint.name}/>;
							_animationXML.appendChild(_jointXML);
						}
						
						_frameXMLList = _jointXML.elements(_frameLabel.name);
						if (_frameXMLList.length() > 0) {
							_frameXML = _frameXMLList[_frameXMLList.length() - 1];
						}
						
						if (_frameXML && int(_frameXML.@x) == int(_x) && int(_frameXML.@y) == int(_y) && int(_frameXML.@r) == int(_r)) {
							_frameXML.@f = int(_frameXML.@f) + 1;
						}else {
							_frameXML =<{_frameLabel.name} x={_x} y={_y} r={_r} f="1"/>;
							_jointXML.appendChild(_frameXML);
						}
					}
					_model.nextFrame();
				}
			}
			
			//Math.max(_clip.forepawR.localToTarget(_clip, bootPoint).y, _clip.forepawL.localToTarget(_clip, bootPoint).y);
			return _animationXML;
		}
		
		private var pointTemp:Point;
		private var xml:XML;
		public function SilhouetteMaker() {
			if (instance) {
				throw new Error("[ERROR]:SilhouetteMaker Singleton already constructed!");
			}
			instance = this;
			init();
		}
		
		private function init():void {
			pointTemp = new Point();
			xml = <root/>;
			xml.appendChild(<models/>);
			
			var _i:uint = 0;
			do {
				eachFrame();
			}while (++_i<totalFrames);
		}
		
		public function makeSilhouetteData(_model:MovieClip):void {
			_model.gotoAndStop(1);
			generateModelData(_model);
		}
		
		private function generateModelConstruct(_model:MovieClip):Object {
			var _xml:XML = _model.xml;
			var _xmlData:XML =<{_xml.name()}/>;
			
			
			
			
			
			
			
			
			
			if (!_jointXMLDic) {
				_jointXMLDic = {};
			}
			
			var _parent:DisplayObject;
			var _joint:DisplayObject;
			var _point:Point;
			var _rect:Rectangle;
			var _x:Number;
			var _y:Number;
			
			for each(var _jointXML:XML in _xml.children()) {
				_joint = _model.getChildByName(_jointXML.name());
				if (_jointXML.@link.length() > 0) {
					_parent = _model.getChildByName(_jointXML.@link);
				}else {
					_parent = _model.getChildByName(_jointXML.parent().name());
				}
				if (_joint) {
					_rect = _joint.getRect(_joint);
					_jointXML.@pX = Math.round(_rect.left * 100) /100;
					_jointXML.@pY = Math.round(_rect.top * 100) /100;
					if (_parent) {
						pointTemp.x = 0;
						pointTemp.y = 0;
						_point = localToLocal(_joint, _parent, pointTemp);
						_x = _point.x;
						_y = _point.y;
						if (_model.getChildIndex(_joint) < _model.getChildIndex(_parent)) {
							_jointXML.@z = "0";
						}
					}else {
						_x = _joint.x;
						_y = _joint.y;
					}
					_jointXML.@x = Math.round(_x * 100) /100;
					_jointXML.@y = Math.round(_y * 100) /100;
					_jointXMLDic[_jointXML.name()] = _jointXML;
					
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
					trace(_jointXML.name(), "no part in model!!!");
				}
				if (_jointXML.children().length() > 0) {
					generateModelConstruct(_model, _jointXML, _jointXMLDic);
				}
			}
			return _jointXMLDic;
		}
		
		private function generateModelData(_model:MovieClip):void {
			var _dic:Object = generateModelConstruct(_model, _model.xml);
			if (_dic) {
				xml.models[_model.xml.name()][0] = _model.xml;
				var _animationXML:XML = generateModelAnimation(_model, _dic);
				_animationXML.setName(_model.xml.name());
				xml.animations[_animationXML.name()][0] = _animationXML;
			}
			trace(xml.toXMLString());
		}
	}
	
}