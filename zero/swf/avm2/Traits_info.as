/***
Traits_info 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月20日 16:47:02 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
//A trait is a fixed property of an object or class; it has a name, a type, and some associated data. The
//traits_info structure bundles these data.

//traits_info
//{
//	u30 name
//	u8 kind
//	u8 data[]
//	u30 metadata_count
//	u30 metadata[metadata_count]
//}

//The name field is an index into the multiname array of the constant pool; it provides a name for the trait.
//The value can not be zero, and the multiname entry specified must be a QName.

//The kind field contains two four-bit fields. The lower four bits determine the kind of this trait. The
//upper four bits comprise a bit vector providing attributes of the trait. See the following tables and
//sections for full descriptions.

//The interpretation of the data field depends on the type of the trait, which is provided by the low four
//bits of the kind field. See below for a full description.

//The following table summarizes the trait types.
//Type 				Value
//Trait_Slot 		0
//Trait_Method 		1
//Trait_Getter 		2
//Trait_Setter 		3
//Trait_Class 		4
//Trait_Function 	5
//Trait_Const 		6

//These fields are present only if ATTR_Metadata is present in the upper four bits of the kind field.
//The value of the metadata_count field is the number of entries in the metadata array. That array
//contains indices into the metadata array of the abcFile.

//As previously mentioned the upper nibble of the kind field is used to encode attributes. A description of how
//the attributes are interpreted for each kind is outlined below. Any other combination of attribute with kind
//is ignored.
//Attributes 		Value
//ATTR_Final 		0x1 	Is used with Trait_Method, Trait_Getter and Trait_Setter. It marks a method that cannot be overridden by a sub-class
//ATTR_Override 	0x2 	Is used with Trait_Method, Trait_Getter and Trait_Setter. It marks a method that has been overridden in this class
//ATTR_Metadata 	0x4 	Is used to signal that the fields metadata_count and metadata follow the data field in the traits_info entry
package zero.swf.avm2{
	import zero.swf.vmarks.TraitAttributes;
	import zero.swf.vmarks.TraitTypes;
	import zero.swf.avm2.traits.Trait;
	import flash.utils.ByteArray;
	public class Traits_info extends AVM2Obj{
		public var name:int;							//u30
		public var kind_attributes:int;
		public var kind_trait_type:int;
		public var trait:Trait;
		public var metadataV:Vector.<int>;
		//
		override public function initByData(data:ByteArray,offset:int,endOffset:int):int{
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
			var flags:int=data[offset++];
			kind_attributes=(flags<<24)>>>28;			//11110000
			kind_trait_type=flags&0x0f;					//00001111
			//
			trait=new TraitTypes.classV[kind_trait_type]();
			offset=trait.initByData(data,offset,endOffset);
			//
			
			
			if(kind_attributes&TraitAttributes.Metadata){
			
			
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
				metadataV=new Vector.<int>(metadata_count);
				for(var i:int=0;i<metadata_count;i++){
			
					if(data[offset]>>>7){
						if(data[offset+1]>>>7){
							if(data[offset+2]>>>7){
								if(data[offset+3]>>>7){
									metadataV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);
								}else{
									metadataV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);
								}
							}else{
								metadataV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);
							}
						}else{
							metadataV[i]=(data[offset++]&0x7f)|(data[offset++]<<7);
						}
					}else{
						metadataV[i]=data[offset++];
					}
					//
				}
			}
			return offset;
		}
		override public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
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
			var flags:int=0;
			flags|=kind_attributes<<4;					//11110000
			flags|=kind_trait_type;						//00001111
			data[offset++]=flags;
			
			data.position=offset;
			data.writeBytes(trait.toData());
			offset=data.length;
			
			if(metadataV){
				var metadata_count:int=metadataV.length;
			
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
			
				for each(var metadata:int in metadataV){
			
					if(metadata>>>7){
						if(metadata>>>14){
							if(metadata>>>21){
								if(metadata>>>28){
									data[offset++]=(metadata&0x7f)|0x80;
									data[offset++]=((metadata>>>7)&0x7f)|0x80;
									data[offset++]=((metadata>>>14)&0x7f)|0x80;
									data[offset++]=((metadata>>>21)&0x7f)|0x80;
									data[offset++]=metadata>>>28;
								}else{
									data[offset++]=(metadata&0x7f)|0x80;
									data[offset++]=((metadata>>>7)&0x7f)|0x80;
									data[offset++]=((metadata>>>14)&0x7f)|0x80;
									data[offset++]=metadata>>>21;
								}
							}else{
								data[offset++]=(metadata&0x7f)|0x80;
								data[offset++]=((metadata>>>7)&0x7f)|0x80;
								data[offset++]=metadata>>>14;
							}
						}else{
							data[offset++]=(metadata&0x7f)|0x80;
							data[offset++]=metadata>>>7;
						}
					}else{
						data[offset++]=metadata;
					}
					//
				}
			}
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		override public function toXML():XML{
			var xml:XML=<Traits_info
				name={name}
				kind_attributes={(
					"|"+TraitAttributes.flagV[kind_attributes&TraitAttributes.Final]+
					"|"+TraitAttributes.flagV[kind_attributes&TraitAttributes.Override]+
					"|"+TraitAttributes.flagV[kind_attributes&TraitAttributes.Metadata]
				).replace(/\|null/g,"").substr(1)}
				kind_trait_type={TraitTypes.typeV[kind_trait_type]}
			>
				<trait/>
				<metadataList/>
			</Traits_info>;
			xml.trait.appendChild(trait.toXML());
			if(metadataV&&metadataV.length){
				var listXML:XML=xml.metadataList[0];
				listXML.@count=metadataV.length;
				for each(var metadata:int in metadataV){
					listXML.appendChild(<metadata value={metadata}/>);
				}
			}else{
				delete xml.metadataList;
			}
			return xml;
		}
		override public function initByXML(xml:XML):void{
			name=int(xml.@name.toString());
			
			kind_attributes=0;
			for each(var kind_attributesStr:String in xml.@kind_attributes.toString().split("|")){
				kind_attributes|=TraitAttributes[kind_attributesStr];
			}
			
			kind_trait_type=TraitTypes[xml.@kind_trait_type.toString()];
			//
			var traitXML:XML=xml.trait.children()[0];
			trait=new TraitTypes.classV[kind_trait_type]();
			trait.initByXML(traitXML);
			//
			if(xml.metadataList.length()){
				var listXML:XML=xml.metadataList[0];
				var metadataXMLList:XMLList=listXML.metadata;
				var i:int=-1;
				metadataV=new Vector.<int>(metadataXMLList.length());
				for each(var metadataXML:XML in metadataXMLList){
					i++;
					metadataV[i]=int(metadataXML.@value.toString());
				}
			}
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
