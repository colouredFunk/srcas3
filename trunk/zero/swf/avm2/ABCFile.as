/***
ABCFile 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月19日 20:10:40 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
//abcFile
//{
//	u16 				minor_version
//	u16 				major_version
//	cpool_info 			constant_pool
//	u30 				method_count
//	method_info 		method[method_count]
//	u30 				metadata_count
//	metadata_info 		metadata[metadata_count]
//	u30 				class_count
//	instance_info 		instance[class_count]
//	class_info 			class[class_count]
//	u30 				script_count
//	script_info 		script[script_count]
//	u30 				method_body_count
//	method_body_info	method_body[method_body_count]
//}

//The values of major_version and minor_version are the major and minor version numbers of the
//abcFile format. A change in the minor version number signifies a change in the file format that is
//backward compatible, in the sense that an implementation of the AVM2 can still make use of a file of an
//older version. A change in the major version number denotes an incompatible adjustment to the file
//format.
//As of the publication of this overview, the major version is 46 and the minor version is 16.
//minor_version一般就是16
//major_version一般就是46

//The constant_pool is a variable length structure composed of integers, doubles, strings, namespaces,
//namespace sets, and multinames. These constants are referenced from other parts of the abcFile
//structure.
//常量池

//The value of method_count is the number of entries in the method array. Each entry in the method array
//is a variable length method_info structure. The array holds information about every method defined in
//this abcFile. The code for method bodies is held separately in the method_body array (see below).
//Some entries in method may have no body—this is the case for native methods, for example.

//The value of metadata_count is the number of entries in the metadata array. Each metadata entry is a
//metadata_info structure that maps a name to a set of string values.

//The value of class_count is the number of entries in the instance and class arrays.

//Each instance entry is a variable length instance_info structure which specifies the characteristics of
//object instances created by a particular class.

//Each class entry defines the characteristics of a class. It is used in conjunction with the instance field to
//derive a full description of an AS Class.

//The value of script_count is the number of entries in the script array.

//Each script entry is a script_info structure that defines the characteristics of a single script in this file. As explained in the
//previous chapter, the last entry in this array is the entry point for execution in the abcFile.

//The value of method_body_count is the number of entries in the method_body array. Each method_body

//entry consists of a variable length method_body_info structure which contains the instructions for an
//individual method or function.
package zero.swf.avm2{
	import zero.swf.avm2.Constant_pool;
	import zero.swf.avm2.Method_info;
	import zero.swf.avm2.Metadata_info;
	import zero.swf.avm2.Instance_info;
	import zero.swf.avm2.Class_info;
	import zero.swf.avm2.Script_info;
	import zero.swf.avm2.Method_body_info;
	import flash.utils.ByteArray;
	public class ABCFile extends AVM2Obj{
		public var minor_version:int;					//UI16
		public var major_version:int;					//UI16
		public var constant_pool:Constant_pool;
		public var method_infoV:Vector.<Method_info>;
		public var metadata_infoV:Vector.<Metadata_info>;
		public var instance_infoV:Vector.<Instance_info>;
		public var class_infoV:Vector.<Class_info>;
		public var script_infoV:Vector.<Script_info>;
		public var method_body_infoV:Vector.<Method_body_info>;
		//
		override public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			minor_version=data[offset]|(data[offset+1]<<8);
			major_version=data[offset+2]|(data[offset+3]<<8);
			//#offsetpp
			offset+=4;
			constant_pool=new Constant_pool();
			offset=constant_pool.initByData(data,offset,endOffset);
			//#offsetpp
			
			//#offsetpp
			
			if(data[offset]>>>7){
				if(data[offset+1]>>>7){
					if(data[offset+2]>>>7){
						if(data[offset+3]>>>7){
							var method_count:int=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);
						}else{
							method_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);
						}
					}else{
						method_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);
					}
				}else{
					method_count=(data[offset++]&0x7f)|(data[offset++]<<7);
				}
			}else{
				method_count=data[offset++];
			}
			//
			method_infoV=new Vector.<Method_info>(method_count);
			for(var i:int=0;i<method_count;i++){
				//#offsetpp
			
				method_infoV[i]=new Method_info();
				offset=method_infoV[i].initByData(data,offset,endOffset);
			}
			//#offsetpp
			
			//#offsetpp
			
			if(data[offset]>>>7){
				if(data[offset+1]>>>7){
					if(data[offset+2]>>>7){
						if(data[offset+3]>>>7){
							var metadata_count:int=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);
						}else{
							metadata_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);
						}
					}else{
						metadata_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);
					}
				}else{
					metadata_count=(data[offset++]&0x7f)|(data[offset++]<<7);
				}
			}else{
				metadata_count=data[offset++];
			}
			//
			metadata_infoV=new Vector.<Metadata_info>(metadata_count);
			for(i=0;i<metadata_count;i++){
				//#offsetpp
			
				metadata_infoV[i]=new Metadata_info();
				offset=metadata_infoV[i].initByData(data,offset,endOffset);
			}
			//#offsetpp
			
			//#offsetpp
			
			if(data[offset]>>>7){
				if(data[offset+1]>>>7){
					if(data[offset+2]>>>7){
						if(data[offset+3]>>>7){
							var class_count:int=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);
						}else{
							class_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);
						}
					}else{
						class_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);
					}
				}else{
					class_count=(data[offset++]&0x7f)|(data[offset++]<<7);
				}
			}else{
				class_count=data[offset++];
			}
			//
			instance_infoV=new Vector.<Instance_info>(class_count);
			for(i=0;i<class_count;i++){
				//#offsetpp
			
				instance_infoV[i]=new Instance_info();
				offset=instance_infoV[i].initByData(data,offset,endOffset);
			}
			//#offsetpp
			
			class_infoV=new Vector.<Class_info>(class_count);
			for(i=0;i<class_count;i++){
				//#offsetpp
			
				class_infoV[i]=new Class_info();
				offset=class_infoV[i].initByData(data,offset,endOffset);
			}
			//#offsetpp
			
			//#offsetpp
			
			if(data[offset]>>>7){
				if(data[offset+1]>>>7){
					if(data[offset+2]>>>7){
						if(data[offset+3]>>>7){
							var script_count:int=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);
						}else{
							script_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);
						}
					}else{
						script_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);
					}
				}else{
					script_count=(data[offset++]&0x7f)|(data[offset++]<<7);
				}
			}else{
				script_count=data[offset++];
			}
			//
			script_infoV=new Vector.<Script_info>(script_count);
			for(i=0;i<script_count;i++){
				//#offsetpp
			
				script_infoV[i]=new Script_info();
				offset=script_infoV[i].initByData(data,offset,endOffset);
			}
			//#offsetpp
			
			//#offsetpp
			
			if(data[offset]>>>7){
				if(data[offset+1]>>>7){
					if(data[offset+2]>>>7){
						if(data[offset+3]>>>7){
							var method_body_count:int=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);
						}else{
							method_body_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);
						}
					}else{
						method_body_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);
					}
				}else{
					method_body_count=(data[offset++]&0x7f)|(data[offset++]<<7);
				}
			}else{
				method_body_count=data[offset++];
			}
			//
			method_body_infoV=new Vector.<Method_body_info>(method_body_count);
			for(i=0;i<method_body_count;i++){
				//#offsetpp
			
				method_body_infoV[i]=new Method_body_info();
				offset=method_body_infoV[i].initByData(data,offset,endOffset);
			}
			return offset;
		}
		override public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			//var offset:int=0;//测试
			data[0]=minor_version;
			data[1]=minor_version>>8;
			data[2]=major_version;
			data[3]=major_version>>8;
			data.position=4;
			data.writeBytes(constant_pool.toData());
			var offset:int=data.length;
			var method_count:int=method_infoV.length;
			//#offsetpp
			if(method_count>>>7){
				if(method_count>>>14){
					if(method_count>>>21){
						if(method_count>>>28){
							data[offset++]=(method_count&0x7f)|0x80;
							data[offset++]=((method_count>>>7)&0x7f)|0x80;
							data[offset++]=((method_count>>>14)&0x7f)|0x80;
							data[offset++]=((method_count>>>21)&0x7f)|0x80;
							data[offset++]=method_count>>>28;
						}else{
							data[offset++]=(method_count&0x7f)|0x80;
							data[offset++]=((method_count>>>7)&0x7f)|0x80;
							data[offset++]=((method_count>>>14)&0x7f)|0x80;
							data[offset++]=method_count>>>21;
						}
					}else{
						data[offset++]=(method_count&0x7f)|0x80;
						data[offset++]=((method_count>>>7)&0x7f)|0x80;
						data[offset++]=method_count>>>14;
					}
				}else{
					data[offset++]=(method_count&0x7f)|0x80;
					data[offset++]=method_count>>>7;
				}
			}else{
				data[offset++]=method_count;
			}
			//
			//#offsetpp
			
			data.position=offset;
			for each(var method_info:Method_info in method_infoV){
				data.writeBytes(method_info.toData());
			}
			offset=data.length;
			var metadata_count:int=metadata_infoV.length;
			//#offsetpp
			
			if(metadata_count>>>7){
				if(metadata_count>>>14){
					if(metadata_count>>>21){
						if(metadata_count>>>28){
							data[offset++]=(metadata_count&0x7f)|0x80;
							data[offset++]=((metadata_count>>>7)&0x7f)|0x80;
							data[offset++]=((metadata_count>>>14)&0x7f)|0x80;
							data[offset++]=((metadata_count>>>21)&0x7f)|0x80;
							data[offset++]=metadata_count>>>28;
						}else{
							data[offset++]=(metadata_count&0x7f)|0x80;
							data[offset++]=((metadata_count>>>7)&0x7f)|0x80;
							data[offset++]=((metadata_count>>>14)&0x7f)|0x80;
							data[offset++]=metadata_count>>>21;
						}
					}else{
						data[offset++]=(metadata_count&0x7f)|0x80;
						data[offset++]=((metadata_count>>>7)&0x7f)|0x80;
						data[offset++]=metadata_count>>>14;
					}
				}else{
					data[offset++]=(metadata_count&0x7f)|0x80;
					data[offset++]=metadata_count>>>7;
				}
			}else{
				data[offset++]=metadata_count;
			}
			//
			//#offsetpp
			
			data.position=offset;
			for each(var metadata_info:Metadata_info in metadata_infoV){
				data.writeBytes(metadata_info.toData());
			}
			offset=data.length;
			var class_count:int=instance_infoV.length;
			//#offsetpp
			
			if(class_count>>>7){
				if(class_count>>>14){
					if(class_count>>>21){
						if(class_count>>>28){
							data[offset++]=(class_count&0x7f)|0x80;
							data[offset++]=((class_count>>>7)&0x7f)|0x80;
							data[offset++]=((class_count>>>14)&0x7f)|0x80;
							data[offset++]=((class_count>>>21)&0x7f)|0x80;
							data[offset++]=class_count>>>28;
						}else{
							data[offset++]=(class_count&0x7f)|0x80;
							data[offset++]=((class_count>>>7)&0x7f)|0x80;
							data[offset++]=((class_count>>>14)&0x7f)|0x80;
							data[offset++]=class_count>>>21;
						}
					}else{
						data[offset++]=(class_count&0x7f)|0x80;
						data[offset++]=((class_count>>>7)&0x7f)|0x80;
						data[offset++]=class_count>>>14;
					}
				}else{
					data[offset++]=(class_count&0x7f)|0x80;
					data[offset++]=class_count>>>7;
				}
			}else{
				data[offset++]=class_count;
			}
			//
			//#offsetpp
			
			data.position=offset;
			for each(var instance_info:Instance_info in instance_infoV){
				data.writeBytes(instance_info.toData());
			}
			for each(var class_info:Class_info in class_infoV){
				data.writeBytes(class_info.toData());
			}
			offset=data.length;
			var script_count:int=script_infoV.length;
			//#offsetpp
			
			if(script_count>>>7){
				if(script_count>>>14){
					if(script_count>>>21){
						if(script_count>>>28){
							data[offset++]=(script_count&0x7f)|0x80;
							data[offset++]=((script_count>>>7)&0x7f)|0x80;
							data[offset++]=((script_count>>>14)&0x7f)|0x80;
							data[offset++]=((script_count>>>21)&0x7f)|0x80;
							data[offset++]=script_count>>>28;
						}else{
							data[offset++]=(script_count&0x7f)|0x80;
							data[offset++]=((script_count>>>7)&0x7f)|0x80;
							data[offset++]=((script_count>>>14)&0x7f)|0x80;
							data[offset++]=script_count>>>21;
						}
					}else{
						data[offset++]=(script_count&0x7f)|0x80;
						data[offset++]=((script_count>>>7)&0x7f)|0x80;
						data[offset++]=script_count>>>14;
					}
				}else{
					data[offset++]=(script_count&0x7f)|0x80;
					data[offset++]=script_count>>>7;
				}
			}else{
				data[offset++]=script_count;
			}
			//
			//#offsetpp
			
			data.position=offset;
			for each(var script_info:Script_info in script_infoV){
				data.writeBytes(script_info.toData());
			}
			offset=data.length;
			var method_body_count:int=method_body_infoV.length;
			//#offsetpp
			
			if(method_body_count>>>7){
				if(method_body_count>>>14){
					if(method_body_count>>>21){
						if(method_body_count>>>28){
							data[offset++]=(method_body_count&0x7f)|0x80;
							data[offset++]=((method_body_count>>>7)&0x7f)|0x80;
							data[offset++]=((method_body_count>>>14)&0x7f)|0x80;
							data[offset++]=((method_body_count>>>21)&0x7f)|0x80;
							data[offset++]=method_body_count>>>28;
						}else{
							data[offset++]=(method_body_count&0x7f)|0x80;
							data[offset++]=((method_body_count>>>7)&0x7f)|0x80;
							data[offset++]=((method_body_count>>>14)&0x7f)|0x80;
							data[offset++]=method_body_count>>>21;
						}
					}else{
						data[offset++]=(method_body_count&0x7f)|0x80;
						data[offset++]=((method_body_count>>>7)&0x7f)|0x80;
						data[offset++]=method_body_count>>>14;
					}
				}else{
					data[offset++]=(method_body_count&0x7f)|0x80;
					data[offset++]=method_body_count>>>7;
				}
			}else{
				data[offset++]=method_body_count;
			}
			//
			//#offsetpp
			
			data.position=offset;
			for each(var method_body_info:Method_body_info in method_body_infoV){
				data.writeBytes(method_body_info.toData());
			}
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		override public function toXML():XML{
			var xml:XML=<ABCFile
				minor_version={minor_version}
				major_version={major_version}
			>
				<constant_pool/>
				<list vNames="method_infoV" count={method_infoV.length}/>
				<list vNames="metadata_infoV" count={metadata_infoV.length}/>
				<list vNames="instance_infoV" count={instance_infoV.length}/>
				<list vNames="class_infoV" count={class_infoV.length}/>
				<list vNames="script_infoV" count={script_infoV.length}/>
				<list vNames="method_body_infoV" count={method_body_infoV.length}/>
			</ABCFile>;
			xml.constant_pool.appendChild(constant_pool.toXML());
			var listXML:XML=xml.list[0];
			for each(var method_info:Method_info in method_infoV){
				var itemXML:XML=<method_info/>;
				itemXML.appendChild(method_info.toXML());
				listXML.appendChild(itemXML);
			}
			listXML=xml.list[1];
			for each(var metadata_info:Metadata_info in metadata_infoV){
				itemXML=<metadata_info/>;
				itemXML.appendChild(metadata_info.toXML());
				listXML.appendChild(itemXML);
			}
			listXML=xml.list[2];
			for each(var instance_info:Instance_info in instance_infoV){
				itemXML=<instance_info/>;
				itemXML.appendChild(instance_info.toXML());
				listXML.appendChild(itemXML);
			}
			listXML=xml.list[3];
			for each(var class_info:Class_info in class_infoV){
				itemXML=<class_info/>;
				itemXML.appendChild(class_info.toXML());
				listXML.appendChild(itemXML);
			}
			listXML=xml.list[4];
			for each(var script_info:Script_info in script_infoV){
				itemXML=<script_info/>;
				itemXML.appendChild(script_info.toXML());
				listXML.appendChild(itemXML);
			}
			listXML=xml.list[5];
			for each(var method_body_info:Method_body_info in method_body_infoV){
				itemXML=<method_body_info/>;
				itemXML.appendChild(method_body_info.toXML());
				listXML.appendChild(itemXML);
			}
			return xml;
		}
		override public function initByXML(xml:XML):void{
			minor_version=int(xml.@minor_version.toString());
			major_version=int(xml.@major_version.toString());
			constant_pool=new Constant_pool();
			constant_pool.initByXML(xml.constant_pool.children()[0]);
			var listXML:XML=xml.list[0];
			var method_infoXMLList:XMLList=listXML.method_info;
			var i:int=-1;
			method_infoV=new Vector.<Method_info>(method_infoXMLList.length());
			for each(var method_infoXML:XML in method_infoXMLList){
				i++;
				method_infoV[i]=new Method_info();
				method_infoV[i].initByXML(method_infoXML.children()[0]);
			}
			listXML=xml.list[1];
			var metadata_infoXMLList:XMLList=listXML.metadata_info;
			i=-1;
			metadata_infoV=new Vector.<Metadata_info>(metadata_infoXMLList.length());
			for each(var metadata_infoXML:XML in metadata_infoXMLList){
				i++;
				metadata_infoV[i]=new Metadata_info();
				metadata_infoV[i].initByXML(metadata_infoXML.children()[0]);
			}
			listXML=xml.list[2];
			var instance_infoXMLList:XMLList=listXML.instance_info;
			i=-1;
			instance_infoV=new Vector.<Instance_info>(instance_infoXMLList.length());
			for each(var instance_infoXML:XML in instance_infoXMLList){
				i++;
				instance_infoV[i]=new Instance_info();
				instance_infoV[i].initByXML(instance_infoXML.children()[0]);
			}
			listXML=xml.list[3];
			var class_infoXMLList:XMLList=listXML.class_info;
			i=-1;
			class_infoV=new Vector.<Class_info>(class_infoXMLList.length());
			for each(var class_infoXML:XML in class_infoXMLList){
				i++;
				class_infoV[i]=new Class_info();
				class_infoV[i].initByXML(class_infoXML.children()[0]);
			}
			listXML=xml.list[4];
			var script_infoXMLList:XMLList=listXML.script_info;
			i=-1;
			script_infoV=new Vector.<Script_info>(script_infoXMLList.length());
			for each(var script_infoXML:XML in script_infoXMLList){
				i++;
				script_infoV[i]=new Script_info();
				script_infoV[i].initByXML(script_infoXML.children()[0]);
			}
			listXML=xml.list[5];
			var method_body_infoXMLList:XMLList=listXML.method_body_info;
			i=-1;
			method_body_infoV=new Vector.<Method_body_info>(method_body_infoXMLList.length());
			for each(var method_body_infoXML:XML in method_body_infoXMLList){
				i++;
				method_body_infoV[i]=new Method_body_info();
				method_body_infoV[i].initByXML(method_body_infoXML.children()[0]);
			}
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
