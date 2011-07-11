/***
So 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2011年4月3日 20:10:09
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.net{
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.utils.*;
	
	public class So{
		
		private var so:SharedObject;
		private var soXMLFile:*;
		private var name:String;
		private var xml:XML;
		
		public function So(
			_name:String,
			_so_version:String,
			_xml:XML=null
		){
			
			name=_name;
			
			var FileClass:Class;
			try{
				FileClass=getDefinitionByName("flash.filesystem.File") as Class;
			}catch(e:Error){
				FileClass=null;
			}
			
			
			if(FileClass){
				soXMLFile=new FileClass(FileClass.applicationDirectory.nativePath+"/so.xml");
				if(soXMLFile.exists){
					xml=readXMLFromFile(soXMLFile);
				}else{
					xml=<so/>;
					writeXMLToFile(xml,soXMLFile);
				}
				
			}else{
				so=SharedObject.getLocal(name,"/");
				if(so.data.xml){
					xml=new XML(so.data.xml);
				}else{
					xml=<so/>;
					so.data.xml=xml.toXMLString();
				}
			}
			
			if(xml.@so_version.toString()==_so_version){
			}else{
				
				reset();
				
				xml=_xml||<so/>;
				xml.@so_version=_so_version;
				update();
				
				trace("重置 so, xml="+xml.toXMLString());
			}
		}
		
		private function getNode(key:String):XML{
			return xml.node.(@key==key)[0];
		}
		public function getValue(key:String):String{
			return xml["@"+key].toString();
		}
		public function setValue(key:String,value:String):void{
			xml["@"+key]=value;
			update();
		}
		public function getXML(key:String,defaultXML:XML):XML{
			var node:XML=getNode(key);
			if(node){
				return node.children()[0];
			}
			return defaultXML;
		}
		public function setXML(key:String,newXML:XML):void{
			var node:XML=getNode(key);
			if(node){
			}else{
				node=<node key={key}/>;
				xml.appendChild(node);
			}
			node.setChildren(newXML);
			//trace("node="+node);
			update();
		}
		
		public function reset():void{
			xml=<so/>;
			if(soXMLFile){
				writeXMLToFile(xml,soXMLFile);
			}else{
				//
				//so.data={};//属性是只读的
				
				//
				for(var valueName:String in so.data){
					delete so.data[valueName];
				}
				
				so.data.xml=xml.toXMLString();
			}
		}
		
		public function update():void{
			if(soXMLFile){
				writeXMLToFile(xml,soXMLFile);
			}else{
				so.data.xml=xml.toXMLString();
			}
		}
		private function readXMLFromFile(file:*):XML{
			var fs:*=new (getDefinitionByName("flash.filesystem.FileStream"))();
			fs.open(file,getDefinitionByName("flash.filesystem.FileMode").READ);
			var xmlStr:String=fs.readUTFBytes(fs.bytesAvailable);
			fs.close();
			return new XML(xmlStr);
		}
		private function writeXMLToFile(xml:XML,file:*):void{
			var fs:*=new (getDefinitionByName("flash.filesystem.FileStream"))();
			fs.open(file,getDefinitionByName("flash.filesystem.FileMode").WRITE);
			fs.writeUTFBytes(('<?xml version="1.0" encoding="utf-8"?>\n'+xml.toXMLString()).replace(/\r\n/g,"\n").replace(/\n/g,"\r\n"));
			fs.close();
		}
		
		public function flush():void{
			so.flush();
		}
	}
}

