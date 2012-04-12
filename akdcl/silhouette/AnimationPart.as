package akdcl.silhouette
{
	import flash.display.Sprite;
	
	import flash.geom.Point;
	
	import flash.utils.getDefinitionByName;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class AnimationPart extends Sprite
	{
		protected var animationData:Object;
		protected var partDic:Object;
		
		public function AnimationPart() {
			init();
		}
		
		protected function init():void {
			mouseEnabled = false;
			mouseChildren = false;
			partDic = { };
		}
		
		public function actionTo(_frameLabel:String, _time:uint, _listTime:uint = 0, _loop:int = 0):void {
			var _data:Object;
			for each(var _part:ModelPart in partDic) {
				_data = animationData[_part.name][_frameLabel];
				if (_data is Array) {
					_part.tween.tweenList(_data as Array, _time, _listTime, _loop);
				}else {
					_part.tween.tweenTo(_data as TweenValue, _time);
				}
			}
		}
		
		public function update():void {
			for each(var _part:ModelPart in partDic) {
				_part.tween.update();
				_part.update();
			}
		}
		
		protected function fixPart(_xml:XML, _level:uint = 0):void {
			var _xmlList:XMLList = _xml.children();
			var _Class:Class;
			var _part:ModelPart;
			var _parent:ModelPart;
			for each(var _partXML:XML in _xmlList) {
				_Class = getDefinitionByName(_partXML.@constructor) as Class;
				_part = new _Class() as ModelPart;
				_part.name = _partXML.name();
				partDic[_partXML.name()] = _part;
				_parent = partDic[_partXML.parent().name()];
				
				//还有lock的情况
				if (_parent) {
					_parent.addPart(_part, int(_partXML.@x), int(_partXML.@y), _partXML.@d.length() > 0?int(_partXML.@d): -1);
				}else {
					addChild(_part);
					_part.x = int(_partXML.@x);
					_part.y = int(_partXML.@y);
				}
				
				fixPart(_partXML, _level + 1);
			}
			if (_level == 0) {
				var _lock:ModelPart;
				for each(_partXML in _xmlList) {
					if (_partXML.@lock.length() > 0) {
						_part = partDic[_partXML.name()];
						_lock = partDic[_partXML.@lock];
						_lock.addFrom(_part);
						_part.lockPoint = new Point(int(_partXML.@x), int(_partXML.@y));
					}
				}
			}
		}
		
		protected function fixAnimation(_xml:XML):Object {
			var _data:Object = { };
			var _part:Object;
			var _node:Array;
			var _tweenValue:TweenValue;
			var _nodeXML:XML;
			var _valueXML:XML;
			var _length:uint;
			var _id:uint;
			
			for each(var _frameXML:XML in _xml.children()) {
				_length = _frameXML.node.length();
				if (_length > 0) {
					for each(_nodeXML in _frameXML.node) {
						for each(_valueXML in _nodeXML.children()) {
							_part = _data[_valueXML.name()];
							if (!_part) {
								_part = _data[_valueXML.name()] = { };
							}
							_node = _part[_frameXML.name()];
							if (!_node) {
								_node = _part[_frameXML.name()] = [];
								_node[_length] = [];
							}
							_id = _nodeXML.childIndex();
							_tweenValue = _node[_id] = new TweenValue(int(_valueXML.@x), int(_valueXML.@y), int(_valueXML.@rotation));
							//把帧间隔和帧标记放到数组末尾的一个数组内
							//帧间隔位于前半部分
							_node[_length][_id] = int(_nodeXML.@frame) - int(_frameXML.@frame);
							//帧标记位于后半部分
							_node[_length][_id + _length] = _nodeXML.@id;
						}
					}
					//list动画数据格式
					//{body:{run:[TweenValue,TweenValue,[0,1,"0","1"]],...},...}
				}else {
					for each(_valueXML in _frameXML.children()) {
						_part = _data[_valueXML.name()];
						if (!_part) {
							_part = _data[_valueXML.name()] = { };
						}
						_tweenValue = _part[_frameXML.name()] = new TweenValue(int(_valueXML.@x), int(_valueXML.@y), int(_valueXML.@rotation));
					}
					//普通动画格式
					//{body:{stand:TweenValue,...},...}
				}
			}
			return _data;
		}
	}
}