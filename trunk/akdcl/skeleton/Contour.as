package akdcl.skeleton
{
	import flash.display.MovieClip;
	
	/**
	 * 用于在FlashCS里创建骨骼数据的模板，实例使用一次后，就无用处了
	 * @author Akdcl
	 */
	public class Contour extends MovieClip {
		/**
		 * 配置骨骼从属关系的xml。并且xml节点名name()会被用来当作ConnectionData的索引ID，一定不要重复
		 */
		public var xml:XML;
		private var values:Object;
		
		/**
		 * 构造函数
		 */
		public function Contour() {
			reset();
		}
		
		/**
		 * @private
		 */
		public function getName():String {
			return xml.name();
		}
		
		/**
		 * 为关节设置特殊变量
		 * @param _id 显示关键ID
		 * @param _key 值名，有scale和delay两个值，scale是用来缩放骨骼动画的周期T的，delay是用来延缓骨骼动画的
		 * @example 例子使手臂动画相对于其他身体部分的动画，周期缩短为0.5，并滞后0.1（这个值是相对于整个动画周期而定）
		 * <listing version="3.0">setValue("arm", "scale", 0.5);setValue("arm", "delay", 0.1);</listing >
		 */
		public function setValue(_id:String, _key:String, _v:*):void {
			var _value:Object = values[_id];
			if (!_value) {
				_value = values[_id] = { };
			}
			_value[_key] = _v;
		}
		
		/**
		 * @private
		 */
		internal function getValue(_id:String, _key:String):* {
			var _value:Object = values[_id];
			if (_value) {
				return _value[_key];
			}
			return false;
		}
		
		public function reset():void {
			clearValues();
			gotoAndStop(1);
		}
		
		/**
		 * 删除这个模板，当通过ConnectionDataMaker转化数据后，就可以删除这个模板了
		 */
		public function remove():void {
			values = null;
			stop();
			xml = null;
			if (parent) {
				parent.removeChild(this);
			}
		}
		
		/**
		 * @private
		 */
		internal function clearValues():void {
			values = { };
		}
	}
	
}