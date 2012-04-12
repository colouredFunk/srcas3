package tools
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.FrameLabel;
	
	import flash.geom.Point;
	import flash.utils.getQualifiedClassName;
	
	import game.model.ModelData;
	
	import akdcl.utils.objectToString;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	dynamic public class  ModelFix extends MovieClip
	{
		new ModelData();
		
		private static function localToLocal(_localFrom:DisplayObject, _localTo:DisplayObject, _x:*= 0, _y:Number = 0):Point {
			var _point:Point;
			if (_x is Point) {
				_point = _x;
			}else {
				_point = new Point(_x, _y);
			}
			return _localTo.globalToLocal(_localFrom.localToGlobal(_point));
		}
		
		private static function generateModelConstruct(_model:MovieClip, _xml:XML, _partXMLDic:Object = null):Object {
			if (!_partXMLDic) {
				_partXMLDic = {};
			}
			var _parent:DisplayObject;
			var _part:DisplayObject;
			var _point:Point;
			
			for each(var _partXML:XML in _xml.children()) {
				_part = _model.getChildByName(_partXML.name());
				if (_partXML.@lock.length() > 0) {
					_parent = _model.getChildByName(_partXML.@lock);
				}else {
					_parent = _model.getChildByName(_partXML.parent().name());
				}
				if (_part) {
					if (_parent) {
						_point = localToLocal(_part, _parent);
						_partXML.@x = Math.round(_point.x);
						_partXML.@y = Math.round(_point.y);
					}else {
						_partXML.@x = Math.round(_part.x);
						_partXML.@y = Math.round(_part.y);
					}
					_partXML.@constructor = getQualifiedClassName(_part);
					
					_partXMLDic[_partXML.name()] = _partXML;
					
					if (_partXML.@footX.length() > 0) {
						while (_xml) {
							if (_xml.parent().name() != _model.name) {
								_xml = _xml.parent();
							}else {
								_xml.parent().@y = localToLocal(_part, _model, int(_partXML.@footX), int(_partXML.@footY)).y;
								_xml = null;
							}
						}
					}
				}else {
					trace(_partXML.name(), "no part in model!!!");
				}
				if (_partXML.children().length() > 0) {
					generateModelConstruct(_model, _partXML, _partXMLDic);
				}
			}
			return _partXMLDic;
		}
		
		protected static function generateModelAnimation(_model:MovieClip, _partXMLDic:Object):XML {
			var _animationXML:XML = <{_model.name}/>;
			var _frameXML:XML;
			var _frameListXML:XML;
			var _partXML:XML;
			
			var _frameLabel:FrameLabel;
			
			var _parent:DisplayObjectContainer;
			var _part:DisplayObject;
			var _x:Number;
			var _y:Number;
			var _rotation:int;
			var _point:Point;
			var _arr:Array;
			
			
			for (var _i:uint = 0; _i < _model.currentLabels.length; _i++ ) {
				_frameLabel = _model.currentLabels[_i];
				if (_frameLabel.frame == 1) {
					continue;
				}
				if (_frameLabel.name.indexOf("_") >= 0) {
					_arr = _frameLabel.name.split("_");
					_frameListXML = _animationXML.elements(_arr[0])[0];
					if (_frameListXML) {
					}else {
						_frameListXML = <{_arr[0]} frame={_frameLabel.frame}/>;
						_animationXML.appendChild(_frameListXML);
					}
					_frameXML =<node id={_arr[1]} frame={_frameLabel.frame}/>;
					_frameListXML.appendChild(_frameXML);
				}else {
					_frameXML = <{_frameLabel.name} frame={_frameLabel.frame}/>;
					_animationXML.appendChild(_frameXML);
				}
				_model.gotoAndStop(_frameLabel.name);
				
				for (var _j:uint = 0; _j < _model.numChildren; _j++ ) {
					_part = _model.getChildAt(_j);
					_partXML = _partXMLDic[_part.name];
					if (!_partXML) {
						continue;
					}
					_parent = (_model.getChildByName(_partXML.parent().name()) || _model) as DisplayObjectContainer;
					
					if (_partXML.@lock.length() > 0) {
						_point = localToLocal(_part, _model.getChildByName(_partXML.@lock));
						_x = Math.round(_point.x - int(_partXML.@x));
						_y = Math.round(_point.y - int(_partXML.@y));
						_rotation = _part.rotation;
					}else if (_part.parent != _parent) {
						_point = localToLocal(_part, _parent);
						_x = Math.round(_point.x);
						_y = Math.round(_point.y);
						_rotation = _part.rotation - _parent.rotation;
					}else {
						_x = Math.round(_part.x);
						_y = Math.round(_part.y);
						_rotation = _part.rotation;
					}
					_frameXML.appendChild(<{_part.name} x={_x} y={_y} rotation={_rotation}/>);
				}
				
				//Math.max(_clip.forepawR.localToTarget(_clip, bootPoint).y, _clip.forepawL.localToTarget(_clip, bootPoint).y);
			}
			return _animationXML;
		}
		
		private var xml:XML;
		public function ModelFix() {
			stop();
			//xml = XML(ModelData.data.toXMLString());
			xml = ModelData.data;
			var _i:uint = 0;
			do {
				eachFrame();
			}while (++_i<totalFrames);
		}
		
		private function eachFrame():void {
			var _i:uint = 0;
			var _model:MovieClip;
			do {
				_model = getChildAt(_i) as MovieClip;
				_model.gotoAndStop(1);
				generateModelData(_model);
			}while (++_i<numChildren);
		}
		
		private function generateModelData(_model:MovieClip):void {
			var _xml:XML = xml.models.elements(_model.name)[0];
			var _animationXML:XML;
			if (_xml) {
				_animationXML = generateModelAnimation(_model, generateModelConstruct(_model, _xml));
				xml.animations[_animationXML.name()][0] = _animationXML;
			}
			trace(xml.toXMLString());
		}
	}
	
}