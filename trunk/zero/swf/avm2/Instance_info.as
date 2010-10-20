/***
Instance_info 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月19日 15:31:58 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
//The instance_info entry is used to define the characteristics of a run-time object (a class instance) within the
//AVM2. The corresponding(对应的) class_info entry is used in order to fully define an ActionScript 3.0 Class.

//instance_info
//{
//	u30 name
//	u30 super_name
//	u8 flags
//	u30 protectedNs
//	u30 intrf_count
//	u30 interface[intrf_count]
//	u30 iinit
//	u30 trait_count
//	traits_info trait[trait_count]
//}

//The name field is an index into the multiname array of the constant pool; it provides a name for the
//class. The entry specified must be a QName.
//The super_name field is an index into the multiname array of the constant pool; it provides the name of
//the base class of this class, if any. A value of zero indicates that this class has no base class.			

//The flags field is used to identify various options when interpreting the instance_info entry. It is bit
//vector; the following entries are defined. Other bits must be zero.
//Name 							Value 	Meaning
//CONSTANT_ClassSealed 			0x01 	The class is sealed: properties can not be dynamically added to instances of the class.
//CONSTANT_ClassFinal 			0x02 	The class is final: it cannot be a base class for any other class.
//CONSTANT_ClassInterface 		0x04 	The class is an interface.
//CONSTANT_ClassProtectedNs 	0x08 	The class uses its protected namespace and the protectedNs field is present in the interface_info structure.

//This field is present only if the CONSTANT_ProtectedNs bit of flags is set. It is an index into the
//namespace array of the constant pool and identifies the namespace that serves as the protected namespace
//for this class.

//The value of the intrf_count field is the number of entries in the interface array. The interface array
//contains indices into the multiname array of the constant pool; the referenced names specify the interfaces
//implemented by this class. None of the indices may be zero.

//This is an index into the method array of the abcFile; it references the method that is invoked whenever
//an object of this class is constructed. This method is sometimes referred to as an instance initializer.

//The value of trait_count is the number of elements in the trait array. The trait array defines the set
//of traits of a class instance. The next section defines the meaning of the traits_info structure.
package zero.swf.avm2{
	import zero.swf.vmarks.InstanceFlags;
	import zero.swf.avm2.Traits_info;
	import flash.utils.ByteArray;
	public class Instance_info extends AVM2Obj{
		public var name:int;							//u30
		public var super_name:int;						//u30
		public var flags:int;							//u8
		public var protectedNs:int;						//u30
		public var intrfV:Vector.<int>;
		public var iinit:int;							//u30
		public var traits_infoV:Vector.<Traits_info>;
		//
		override public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			//#offsetpp
			if(data[offset]>>>7){
				if(data[offset+1]>>>7){
					if(data[offset+2]>>>7){
						if(data[offset+3]>>>7){
							name=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);
						}else{
							name=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);
						}
					}else{
						name=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);
					}
				}else{
					name=(data[offset++]&0x7f)|(data[offset++]<<7);
				}
			}else{
				name=data[offset++];
			}
			//
			//#offsetpp
			
			if(data[offset]>>>7){
				if(data[offset+1]>>>7){
					if(data[offset+2]>>>7){
						if(data[offset+3]>>>7){
							super_name=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);
						}else{
							super_name=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);
						}
					}else{
						super_name=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);
					}
				}else{
					super_name=(data[offset++]&0x7f)|(data[offset++]<<7);
				}
			}else{
				super_name=data[offset++];
			}
			//
			flags=data[offset++];
			//#offsetpp
			
			if(flags&InstanceFlags.ClassProtectedNs){
				//#offsetpp
			
				if(data[offset]>>>7){
					if(data[offset+1]>>>7){
						if(data[offset+2]>>>7){
							if(data[offset+3]>>>7){
								protectedNs=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);
							}else{
								protectedNs=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);
							}
						}else{
							protectedNs=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);
						}
					}else{
						protectedNs=(data[offset++]&0x7f)|(data[offset++]<<7);
					}
				}else{
					protectedNs=data[offset++];
				}
				//
			}
			//#offsetpp
			
			//#offsetpp
			
			if(data[offset]>>>7){
				if(data[offset+1]>>>7){
					if(data[offset+2]>>>7){
						if(data[offset+3]>>>7){
							var intrf_count:int=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);
						}else{
							intrf_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);
						}
					}else{
						intrf_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);
					}
				}else{
					intrf_count=(data[offset++]&0x7f)|(data[offset++]<<7);
				}
			}else{
				intrf_count=data[offset++];
			}
			//
			intrfV=new Vector.<int>(intrf_count);
			for(var i:int=0;i<intrf_count;i++){
				//#offsetpp
			
				if(data[offset]>>>7){
					if(data[offset+1]>>>7){
						if(data[offset+2]>>>7){
							if(data[offset+3]>>>7){
								intrfV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);
							}else{
								intrfV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);
							}
						}else{
							intrfV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);
						}
					}else{
						intrfV[i]=(data[offset++]&0x7f)|(data[offset++]<<7);
					}
				}else{
					intrfV[i]=data[offset++];
				}
				//
			}
			//#offsetpp
			
			if(data[offset]>>>7){
				if(data[offset+1]>>>7){
					if(data[offset+2]>>>7){
						if(data[offset+3]>>>7){
							iinit=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);
						}else{
							iinit=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);
						}
					}else{
						iinit=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);
					}
				}else{
					iinit=(data[offset++]&0x7f)|(data[offset++]<<7);
				}
			}else{
				iinit=data[offset++];
			}
			//
			//#offsetpp
			
			//#offsetpp
			
			if(data[offset]>>>7){
				if(data[offset+1]>>>7){
					if(data[offset+2]>>>7){
						if(data[offset+3]>>>7){
							var traits_info_count:int=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);
						}else{
							traits_info_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);
						}
					}else{
						traits_info_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);
					}
				}else{
					traits_info_count=(data[offset++]&0x7f)|(data[offset++]<<7);
				}
			}else{
				traits_info_count=data[offset++];
			}
			//
			traits_infoV=new Vector.<Traits_info>(traits_info_count);
			for(i=0;i<traits_info_count;i++){
				//#offsetpp
			
				traits_infoV[i]=new Traits_info();
				offset=traits_infoV[i].initByData(data,offset,endOffset);
			}
			return offset;
		}
		override public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			//var offset:int=0;//测试
			//#offsetpp
			var offset:int=0;
			if(name>>>7){
				if(name>>>14){
					if(name>>>21){
						if(name>>>28){
							data[offset++]=(name&0x7f)|0x80;
							data[offset++]=((name>>>7)&0x7f)|0x80;
							data[offset++]=((name>>>14)&0x7f)|0x80;
							data[offset++]=((name>>>21)&0x7f)|0x80;
							data[offset++]=name>>>28;
						}else{
							data[offset++]=(name&0x7f)|0x80;
							data[offset++]=((name>>>7)&0x7f)|0x80;
							data[offset++]=((name>>>14)&0x7f)|0x80;
							data[offset++]=name>>>21;
						}
					}else{
						data[offset++]=(name&0x7f)|0x80;
						data[offset++]=((name>>>7)&0x7f)|0x80;
						data[offset++]=name>>>14;
					}
				}else{
					data[offset++]=(name&0x7f)|0x80;
					data[offset++]=name>>>7;
				}
			}else{
				data[offset++]=name;
			}
			//
			//#offsetpp
			
			if(super_name>>>7){
				if(super_name>>>14){
					if(super_name>>>21){
						if(super_name>>>28){
							data[offset++]=(super_name&0x7f)|0x80;
							data[offset++]=((super_name>>>7)&0x7f)|0x80;
							data[offset++]=((super_name>>>14)&0x7f)|0x80;
							data[offset++]=((super_name>>>21)&0x7f)|0x80;
							data[offset++]=super_name>>>28;
						}else{
							data[offset++]=(super_name&0x7f)|0x80;
							data[offset++]=((super_name>>>7)&0x7f)|0x80;
							data[offset++]=((super_name>>>14)&0x7f)|0x80;
							data[offset++]=super_name>>>21;
						}
					}else{
						data[offset++]=(super_name&0x7f)|0x80;
						data[offset++]=((super_name>>>7)&0x7f)|0x80;
						data[offset++]=super_name>>>14;
					}
				}else{
					data[offset++]=(super_name&0x7f)|0x80;
					data[offset++]=super_name>>>7;
				}
			}else{
				data[offset++]=super_name;
			}
			//
			data[offset++]=flags;
			//#offsetpp
			
			if(protectedNs){
				//#offsetpp
			
				if(protectedNs>>>7){
					if(protectedNs>>>14){
						if(protectedNs>>>21){
							if(protectedNs>>>28){
								data[offset++]=(protectedNs&0x7f)|0x80;
								data[offset++]=((protectedNs>>>7)&0x7f)|0x80;
								data[offset++]=((protectedNs>>>14)&0x7f)|0x80;
								data[offset++]=((protectedNs>>>21)&0x7f)|0x80;
								data[offset++]=protectedNs>>>28;
							}else{
								data[offset++]=(protectedNs&0x7f)|0x80;
								data[offset++]=((protectedNs>>>7)&0x7f)|0x80;
								data[offset++]=((protectedNs>>>14)&0x7f)|0x80;
								data[offset++]=protectedNs>>>21;
							}
						}else{
							data[offset++]=(protectedNs&0x7f)|0x80;
							data[offset++]=((protectedNs>>>7)&0x7f)|0x80;
							data[offset++]=protectedNs>>>14;
						}
					}else{
						data[offset++]=(protectedNs&0x7f)|0x80;
						data[offset++]=protectedNs>>>7;
					}
				}else{
					data[offset++]=protectedNs;
				}
				//
			}
			var intrf_count:int=intrfV.length;
			//#offsetpp
			
			if(intrf_count>>>7){
				if(intrf_count>>>14){
					if(intrf_count>>>21){
						if(intrf_count>>>28){
							data[offset++]=(intrf_count&0x7f)|0x80;
							data[offset++]=((intrf_count>>>7)&0x7f)|0x80;
							data[offset++]=((intrf_count>>>14)&0x7f)|0x80;
							data[offset++]=((intrf_count>>>21)&0x7f)|0x80;
							data[offset++]=intrf_count>>>28;
						}else{
							data[offset++]=(intrf_count&0x7f)|0x80;
							data[offset++]=((intrf_count>>>7)&0x7f)|0x80;
							data[offset++]=((intrf_count>>>14)&0x7f)|0x80;
							data[offset++]=intrf_count>>>21;
						}
					}else{
						data[offset++]=(intrf_count&0x7f)|0x80;
						data[offset++]=((intrf_count>>>7)&0x7f)|0x80;
						data[offset++]=intrf_count>>>14;
					}
				}else{
					data[offset++]=(intrf_count&0x7f)|0x80;
					data[offset++]=intrf_count>>>7;
				}
			}else{
				data[offset++]=intrf_count;
			}
			//
			//#offsetpp
			
			for each(var intrf:int in intrfV){
				//#offsetpp
			
				if(intrf>>>7){
					if(intrf>>>14){
						if(intrf>>>21){
							if(intrf>>>28){
								data[offset++]=(intrf&0x7f)|0x80;
								data[offset++]=((intrf>>>7)&0x7f)|0x80;
								data[offset++]=((intrf>>>14)&0x7f)|0x80;
								data[offset++]=((intrf>>>21)&0x7f)|0x80;
								data[offset++]=intrf>>>28;
							}else{
								data[offset++]=(intrf&0x7f)|0x80;
								data[offset++]=((intrf>>>7)&0x7f)|0x80;
								data[offset++]=((intrf>>>14)&0x7f)|0x80;
								data[offset++]=intrf>>>21;
							}
						}else{
							data[offset++]=(intrf&0x7f)|0x80;
							data[offset++]=((intrf>>>7)&0x7f)|0x80;
							data[offset++]=intrf>>>14;
						}
					}else{
						data[offset++]=(intrf&0x7f)|0x80;
						data[offset++]=intrf>>>7;
					}
				}else{
					data[offset++]=intrf;
				}
				//
			}
			//#offsetpp
			
			if(iinit>>>7){
				if(iinit>>>14){
					if(iinit>>>21){
						if(iinit>>>28){
							data[offset++]=(iinit&0x7f)|0x80;
							data[offset++]=((iinit>>>7)&0x7f)|0x80;
							data[offset++]=((iinit>>>14)&0x7f)|0x80;
							data[offset++]=((iinit>>>21)&0x7f)|0x80;
							data[offset++]=iinit>>>28;
						}else{
							data[offset++]=(iinit&0x7f)|0x80;
							data[offset++]=((iinit>>>7)&0x7f)|0x80;
							data[offset++]=((iinit>>>14)&0x7f)|0x80;
							data[offset++]=iinit>>>21;
						}
					}else{
						data[offset++]=(iinit&0x7f)|0x80;
						data[offset++]=((iinit>>>7)&0x7f)|0x80;
						data[offset++]=iinit>>>14;
					}
				}else{
					data[offset++]=(iinit&0x7f)|0x80;
					data[offset++]=iinit>>>7;
				}
			}else{
				data[offset++]=iinit;
			}
			//
			var traits_info_count:int=traits_infoV.length;
			//#offsetpp
			
			if(traits_info_count>>>7){
				if(traits_info_count>>>14){
					if(traits_info_count>>>21){
						if(traits_info_count>>>28){
							data[offset++]=(traits_info_count&0x7f)|0x80;
							data[offset++]=((traits_info_count>>>7)&0x7f)|0x80;
							data[offset++]=((traits_info_count>>>14)&0x7f)|0x80;
							data[offset++]=((traits_info_count>>>21)&0x7f)|0x80;
							data[offset++]=traits_info_count>>>28;
						}else{
							data[offset++]=(traits_info_count&0x7f)|0x80;
							data[offset++]=((traits_info_count>>>7)&0x7f)|0x80;
							data[offset++]=((traits_info_count>>>14)&0x7f)|0x80;
							data[offset++]=traits_info_count>>>21;
						}
					}else{
						data[offset++]=(traits_info_count&0x7f)|0x80;
						data[offset++]=((traits_info_count>>>7)&0x7f)|0x80;
						data[offset++]=traits_info_count>>>14;
					}
				}else{
					data[offset++]=(traits_info_count&0x7f)|0x80;
					data[offset++]=traits_info_count>>>7;
				}
			}else{
				data[offset++]=traits_info_count;
			}
			//
			//#offsetpp
			
			data.position=offset;
			for each(var traits_info:Traits_info in traits_infoV){
				data.writeBytes(traits_info.toData());
			}
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		override public function toXML():XML{
			var xml:XML=<Instance_info
				name={name}
				super_name={super_name}
				flags={(
					"|"+InstanceFlags.flagV[flags&InstanceFlags.ClassSealed]+
					"|"+InstanceFlags.flagV[flags&InstanceFlags.ClassFinal]+
					"|"+InstanceFlags.flagV[flags&InstanceFlags.ClassInterface]+
					"|"+InstanceFlags.flagV[flags&InstanceFlags.ClassProtectedNs]
				).replace(/\|null/g,"").substr(1)}
				protectedNs={protectedNs}
				iinit={iinit}
			>
				<list vNames="intrfV" count={intrfV.length}/>
				<list vNames="traits_infoV" count={traits_infoV.length}/>
			</Instance_info>;
			if(protectedNs){
				
			}else{
				delete xml.@protectedNs;
			}
			var listXML:XML=xml.list[0];
			for each(var intrf:int in intrfV){
				listXML.appendChild(<intrf value={intrf}/>);
			}
			listXML=xml.list[1];
			for each(var traits_info:Traits_info in traits_infoV){
				var itemXML:XML=<traits_info/>;
				itemXML.appendChild(traits_info.toXML());
				listXML.appendChild(itemXML);
			}
			return xml;
		}
		override public function initByXML(xml:XML):void{
			name=int(xml.@name.toString());
			super_name=int(xml.@super_name.toString());
			
			flags=0;
			for each(var flagsStr:String in xml.@flags.toString().split("|")){
				flags|=InstanceFlags[flagsStr];
			}
			
			if(xml.@protectedNs){
				protectedNs=int(xml.@protectedNs.toString());
			}
			var listXML:XML=xml.list[0];
			var intrfXMLList:XMLList=listXML.intrf;
			var i:int=-1;
			intrfV=new Vector.<int>(intrfXMLList.length());
			for each(var intrfXML:XML in intrfXMLList){
				i++;
				intrfV[i]=int(intrfXML.@value.toString());
			}
			iinit=int(xml.@iinit.toString());
			listXML=xml.list[1];
			var traits_infoXMLList:XMLList=listXML.traits_info;
			i=-1;
			traits_infoV=new Vector.<Traits_info>(traits_infoXMLList.length());
			for each(var traits_infoXML:XML in traits_infoXMLList){
				i++;
				traits_infoV[i]=new Traits_info();
				traits_infoV[i].initByXML(traits_infoXML.children()[0]);
			}
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
