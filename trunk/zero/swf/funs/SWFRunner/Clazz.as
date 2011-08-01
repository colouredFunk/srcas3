/***
Clazz
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月13日 09:41:33
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.swf.avm1.runners{
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	public class Clazz extends Proxy{
		public var fun:Fun;
		
		private var className:String;
		private var values:Object;
		public var superClazz:Clazz;
		
		public function Clazz(
			codesRunner:CodesRunner,
			_fun:Fun,
			argsArr:Array,
			globalVars:Object,
			vars:Object
		){
			fun=_fun;
			values=new Object();
			className=fun.className;
			for(var name:String in fun.prototype){
				//trace("Clazz "+name+"="+fun.prototype[name]);
				this[name]=fun.prototype[name];
			}
			fun.run(codesRunner,this,argsArr,globalVars,vars);//构造
		}
		
		//callProperty(name:*, ... rest):*
		//覆盖可作为函数调用的对象属性的行为。 Proxy 
		override flash_proxy function callProperty(name:*, ... rest):*{
			if(name is QName){
				var qName:QName=name;
				switch(qName.localName){
					case "toString":
						return "[Clazz "+className+" 的某个实例]";
					break;
					default:
						throw new Error("暂不支持 callProperty："+qName.localName);
					break;
				}
			}
			throw new Error("暂不支持 callProperty："+name);
		}
			
		//deleteProperty(name:*):Boolean
		//覆盖删除属性的请求。 Proxy 
		override flash_proxy function deleteProperty(name:*):Boolean{
			throw new Error("暂不支持 deleteProperty");
		}
		
		//getDescendants(name:*):*
		//覆盖 descendant 运算符的使用。 Proxy 
		override flash_proxy function getDescendants(name:*):*{
			throw new Error("暂不支持 getDescendants");
		}
			
		//getProperty(name:*):*
		//覆盖对属性值的任何请求。 Proxy 
		override flash_proxy function getProperty(name:*):*{
			if(values.hasOwnProperty(name)){
				return values[name];
			}
			if(superClazz){
				return superClazz[name];
			}
			throw new Error("找不到属性："+name);
		}
			
		//hasProperty(name:*):Boolean
		//覆盖请求以按名称来检查对象是否具有特定属性。 Proxy 
		override flash_proxy function hasProperty(name:*):Boolean{
			return values.hasOwnProperty(name);
		}
		
		//isAttribute(name:*):Boolean
		//检查是否还将提供的 QName 标记为属性。 Proxy 
		override flash_proxy function isAttribute(name:*):Boolean{
			throw new Error("暂不支持 isAttribute");
		}
		
		//nextName(index:int):String
		//允许按索引编号枚举代理对象的属性以检索属性名称。 Proxy
		override flash_proxy function nextName(index:int):String{
			throw new Error("暂不支持 nextName");
		}
		
		//nextNameIndex(index:int):int
		//允许按索引编号枚举代理对象的属性。 Proxy 
		override flash_proxy function nextNameIndex(index:int):int{
			throw new Error("暂不支持 nextNameIndex");
		}
		
		//nextValue(index:int):*
		//允许按索引编号枚举代理对象的属性以检索属性值。 Proxy 
		override flash_proxy function nextValue(index:int):*{
			throw new Error("暂不支持 nextValue");
		}
			
		//setProperty(name:*, value:*):void
		//覆盖更改属性值的调用。
		override flash_proxy function setProperty(name:*, value:*):void{
			values[name]=value;
		}
	}
}

 
