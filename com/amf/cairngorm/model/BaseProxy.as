package com.amf.cairngorm.model 
{
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	/**
	 * ...
	 * @author Ron Tian

	 */
	public class BaseProxy extends Proxy
	{
		private var instance:*;
		protected var property_array:Array;
		protected var function_array:Array;
		/**
		 * 
		 * @param	instance	需要绑定的实例对象
		 */
		public function BaseProxy(instance:*) 
		{
			this.instance = instance;
			property_array = new Array();
			function_array = new Array();
		}
		
		/**
		 * 绑定对象
		 * @param	object		需要绑定的对象
		 * @param	property	需要绑定对象的属性或方法
		 * @param	value		Proxy对应的属性或方法
		 */
		public function bindProperty(object:*,property:String,value:String):void
		{
			property_array.push( { object:object,property:property,value:value} );
		}
		
		/**
		 * 绑定方法
		 * @param	function	需要绑定的方法
		 * @param	value		Proxy对应的属性或方法
		 */
		public function bindFunction(func:Function,value:String):void
		{
			function_array.push({func:func,value:value});
		}
		
		/**
		 * 解除绑定对象
		 * @param	object		需要解除绑定的对象
		 * @param	property	需要解除绑定对象的属性或方法
		 * @param	value		Proxy对应的属性或方法
		 * @return	Booleam		是否解除绑定成功
		 */
		public function unBindProperty(object:*,property:String,value:String):Boolean
		{
			var len:int = property_array.length;
			for (var i:int = 0; i < len; i++)
			{
				if (property_array[i].object == object && property_array[i].property == property && property_array[i].value == value)
				{
					property_array.splice(i, 1);
					return true;
				}
			}
			return false;
		}
		
		/**
		 * 解除绑定方法
		 * @param	function	需要解除绑定的方法
		 * @param	value		Proxy对应的属性或方法
		 * @return	Booleam		是否解除绑定成功
		 */
		public function unBindFunction(func:Function,value:String):Boolean
		{
			var len:int = function_array.length;
			for (var i:int = 0; i < len; i++)
			{
				if (function_array[i].func == func && function_array[i].value == value)
				{
					function_array.splice(i, 1);
					return true;
				}
			}
			return false;
		}
		
		/**
		 * 执行并绑定方法
		 * @param	name	方法名称
		 * @param	...rest	方法参数
		 * @return	方法的返回值
		 */
		override flash_proxy function callProperty(name:*, ...rest):* 
		{
			trace("fdasfasf");
			var result:*= instance[name].apply(instance, rest);
			var i:int;
			var len:int;
			len = property_array.length;
			for (i = 0; i < len; i++)
			{
				if (property_array[i].value == name)
				{
					property_array[i].object[property_array[i].property].apply(property_array[i].object, rest);
				}
			}
			len = function_array.length;
			for (i = 0; i < len; i++)
			{
				if (function_array[i].value == name)
				{
					function_array[i].func.apply(instance , rest);
				}
			}
			return result;
		}
		
		/**
		 * 获取属性的值
		 * @param	name	属性的名称
		 * @return	返回属性对应的值
		 */
		override flash_proxy function getProperty(name:*):* 
		{
			return instance[name];
		}
		
		/**
		 * 执行并绑定属性
		 * @param	name	属性的名称
		 * @param	value	属性的值
		 */
		override flash_proxy function setProperty(name:*, value:*):void 
		{
			instance[name] = value;
			var len:int;
			var i:int
			len = property_array.length;
			for (i = 0; i < len; i++)
			{
				if (property_array[i].value==name)
				{
					property_array[i].object[property_array[i].property] = value;
				}
			}
			len = function_array.length;
			for (i = 0; i < len; i++)
			{
				if (function_array[i].value==name)
				{
					function_array[i].func(value);
				}
			}
		}
	}
	
}