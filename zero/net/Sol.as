/***
Sol
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年7月28日 20:29:07
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.net{
	import flash.net.SharedObject;
	import flash.utils.Proxy;
	import flash.utils.clearTimeout;
	import flash.utils.flash_proxy;
	import flash.utils.getDefinitionByName;
	import flash.utils.setTimeout;
	
	public class Sol extends Proxy{
		private var timeoutId:int;
		
		private var so:SharedObject;
		private var soXMLFile:*;
		public var xml:XML;
		public var currSettingXML:XML;
		
		public function Sol(nameOrSoXMLFile:*){
			if(nameOrSoXMLFile){
				if(nameOrSoXMLFile is String){
					so=SharedObject.getLocal(nameOrSoXMLFile,"/");
					if(so.data.xml){
						xml=new XML(so.data.xml);
					}else{
						reset();
					}
				}else{
					soXMLFile=nameOrSoXMLFile;
					if(soXMLFile.exists){
						xml=readXMLFromFile(soXMLFile);
					}else{
						reset();
					}
				}
				normalize();
			}else{
				throw new Error("nameOrSoXMLFile="+nameOrSoXMLFile);
			}
		}
		public function clear():void{
			clearTimeout(timeoutId);
			
			so=null;
			soXMLFile=null;
			xml=null;
			currSettingXML=null;
		}
		
		private function normalize():void{
			var settingXMLArr:Array=new Array();
			var settingXML:XML,settingName:String;
			var mark:Object=new Object();
			for each(settingXML in xml.setting){
				settingName=settingXML.@name.toString();
				if(settingName){
					if(mark["~"+settingName]){
						continue;
					}
					mark["~"+settingName]=true;
					settingXMLArr.push(settingXML);
				}else{
					throw new Error("settingName 为空："+settingXML.toXMLString());
				}
			}
			settingXMLArr.sortOn("@name",Array.CASEINSENSITIVE);
			xml=<sol/>;
			if(currSettingXML){
				xml.@currSettingName=currSettingXML.@name.toString();
			}else{
				xml.@currSettingName="默认";
			}
			for each(settingXML in settingXMLArr){
				xml.appendChild(settingXML);
			}
			currSettingXML=null;
			for each(settingXML in xml.setting){
				if(settingXML.@name.toString()==xml.@currSettingName.toString()){
					currSettingXML=settingXML;
					break;
				}
			}
			if(currSettingXML){
			}else{
				reset();
			}
		}
		public function reset():void{
			if(soXMLFile){
			}else{
				//
				//so.data={};//属性是只读的
				
				//
				for(var valueName:String in so.data){
					delete so.data[valueName];
				}
			}
			
			xml=<sol currSettingName="默认">
					<setting name="默认"/>
				</sol>
			currSettingXML=xml.setting[0];
			update();
		}
		public function addSetting(newSettingXML:XML):void{
			xml.prependChild(newSettingXML);
			currSettingXML=newSettingXML;
			normalize();
			update();
		}
		private function updateDelay():void{
			clearTimeout(timeoutId);
			timeoutId=setTimeout(update,500);
		}
		public function update():void{
			//trace("update");
			clearTimeout(timeoutId);
			if(soXMLFile){
				writeXMLToFile(xml,soXMLFile);
			}else{
				so.data.xml=xml.toXMLString();
				so.flush();
			}
		}
		
		private static function readXMLFromFile(file:*):XML{
			var fs:*=new (getDefinitionByName("flash.filesystem.FileStream"))();
			fs.open(file,getDefinitionByName("flash.filesystem.FileMode").READ);
			var xmlStr:String=fs.readUTFBytes(fs.bytesAvailable);
			fs.close();
			return new XML(xmlStr);
		}
		private static function writeXMLToFile(xml:XML,file:*):void{
			var fs:*=new (getDefinitionByName("flash.filesystem.FileStream"))();
			fs.open(file,getDefinitionByName("flash.filesystem.FileMode").WRITE);
			fs.writeUTFBytes(('<?xml version="1.0" encoding="utf-8"?>\n'+xml.toXMLString()).replace(/\r\n/g,"\n").replace(/\n/g,"\r\n"));
			fs.close();
		}
		
		//getProperty(name:*):*
		//覆盖对属性值的任何请求。 Proxy 
		override flash_proxy function getProperty(name:*):*{
			var valueXML:XML=currSettingXML[name][0];
			if(valueXML){
				return xml2value(valueXML);
			}
			return undefined;
		}
		
		private function xml2value(valueXML:XML):*{
			
			var itemXML:XML;
			
			switch(valueXML.@type.toString()){
				case "true":
					return true;
				break;
				case "false":
					return false;
				break;
				case "null":
					return null;
				break;
				case "undefined":
					return undefined;
				break;
				case "int":
					return int(valueXML.@value.toString());
				break;
				case "uint":
					return uint(valueXML.@value.toString());
				break;
				case "Number":
					return Number(valueXML.@value.toString());
				break;
				case "String":
					return valueXML.@value.toString();
				break;
				case "XML":
					return valueXML.children()[0];
				break;
				case "Array":
					var arr:Array=new Array();
					var i:int=-1;
					for each(itemXML in valueXML.children()){
						i++;
						arr[i]=xml2value(itemXML);
					}
					return arr;
				break;
				case "Object":
					var obj:Object=new Object();
					for each(itemXML in valueXML.children()){
						obj[itemXML.@valueName.toString()]=xml2value(itemXML);
					}
					return obj;
				break;
			}
			
			throw new Error("valueXML="+valueXML);
		}
		
		//setProperty(name:*, value:*):void
		//覆盖更改属性值的调用。
		override flash_proxy function setProperty(name:*, value:*):void{
			currSettingXML[name]=value2xml(name,value);
			updateDelay();
		}
		private function value2xml(name:String,value:*):XML{
			switch(value){
				case true:
					return <{name} type="true"/>;
				break;
				case false:
					return <{name} type="false"/>;
				break;
				case null:
					return <{name} type="null"/>;
				break;
				case undefined:
					return <{name} type="undefined"/>;
				break;
			}
			if(value is int){
				return <{name} type="int" value={value}/>;
			}
			if(value is uint){
				return <{name} type="uint" value={value}/>;
			}
			if(value is Number){
				return <{name} type="Number" value={value}/>;
			}
			if(value is String){
				return <{name} type="String" value={value}/>;
			}
			
			var valueXML:XML;
			
			if(value){
				switch(value.constructor){
					case XML:
						valueXML=<{name} type="XML"/>;
						valueXML.appendChild(value);
						return valueXML;
					break;
					case Array:
						valueXML=<{name} type="Array"/>;
						var L:int=value.length;
						for(var i:int=0;i<L;i++){
							valueXML.appendChild(value2xml("item",value[i]));
						}
						return valueXML;
					break;
					case Object:
						valueXML=<{name} type="Object"/>;
						for(var valueName:String in value){
							var itemXML:XML=value2xml("item"+i,value[valueName]);
							itemXML.@valueName=valueName;
							valueXML.appendChild(itemXML);
						}
						return valueXML;
					break;
				}
			}
			
			throw new Error("value="+value);
		}
		
		//callProperty(name:*, ... rest):*
		//覆盖可作为函数调用的对象属性的行为。 Proxy 
		override flash_proxy function callProperty(name:*, ... rest):*{
			throw new Error("暂不支持 callProperty");
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
		
		//hasProperty(name:*):Boolean
		//覆盖请求以按名称来检查对象是否具有特定属性。 Proxy 
		override flash_proxy function hasProperty(name:*):Boolean{
			throw new Error("暂不支持 hasProperty");
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
	}
}