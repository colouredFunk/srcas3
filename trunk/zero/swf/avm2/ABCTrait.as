/***
ABCTrait
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月26日 13:38:30
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
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
package zero.swf.avm2{
	import flash.utils.Dictionary;
	public class ABCTrait{
		public var name:ABCMultiname;
		public var ATTR_Final:Boolean;
		public var ATTR_Override:Boolean;
		public var kind_trait_type:int;
		public var slot_id:int;
		public var type_name:ABCMultiname;
		public var vkindAndVIndex:ABCConstantItem;
		public var disp_id:int;
		public var method:ABCMethod;
		public var function_:ABCMethod;
		public var classi:ABCClass;
		public var metadataV:Vector.<ABCMetadata>;
		//
		public function initByInfo(
			traits_info:Traits_info,
			integerV:Vector.<int>,
			uintegerV:Vector.<int>,
			doubleV:Vector.<Number>,
			stringV:Vector.<String>,
			allNsV:Vector.<ABCNamespace>,
			allMultinameV:Vector.<ABCMultiname>,
			allMethodV:Vector.<ABCMethod>,
			allMetadataV:Vector.<ABCMetadata>,
			classV:Vector.<ABCClass>,
			_initByDataOptions:Object/*zero_swf_InitByDataOptions*/
		):void{
			var i:int;
			
			//The name field is an index into the multiname array of the constant pool; it provides a name for the trait.
			//The value can not be zero, and the multiname entry specified must be a QName.
			if(traits_info.name>0){
				name=allMultinameV[traits_info.name];
				if(name.kind==MultinameKinds.QName){
				}else{
					throw new Error("name.kind="+name.kind);
				}
			}else{
				throw new Error("traits_info.name="+traits_info.name);
			}
			
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
			
			//As previously mentioned the upper nibble of the kind field is used to encode attributes. A description of how
			//the attributes are interpreted for each kind is outlined below. Any other combination of attribute with kind
			//is ignored.
			//Attributes 		Value
			//ATTR_Final 		0x1 	Is used with Trait_Method, Trait_Getter and Trait_Setter. It marks a method that cannot be overridden by a sub-class
			//ATTR_Override 	0x2 	Is used with Trait_Method, Trait_Getter and Trait_Setter. It marks a method that has been overridden in this class
			//ATTR_Metadata 	0x4 	Is used to signal that the fields metadata_count and metadata follow the data field in the traits_info entry
			
			ATTR_Final=traits_info.ATTR_Final;
			ATTR_Override=traits_info.ATTR_Override;
			
			kind_trait_type=traits_info.kind_trait_type;
			
			switch(kind_trait_type){
				case TraitTypeAndAttributes.Slot:
				case TraitTypeAndAttributes.Const:
					
					//A kind value of Trait_Slot (0) or Trait_Const (6) requires that the data field be read using trait_slot,
					//which takes the following form:
					//trait_slot
					//{
					//	u30 slot_id
					//	u30 type_name
					//	u30 vindex
					//	u8 vkind
					//}
					
					//slot_id
					//The slot_id field is an integer from 0 to N and is used to identify a position in which this trait resides. A
					//value of 0 requests the AVM2 to assign a position.
					slot_id=traits_info.u30_1;
					
					//type_name
					//This field is used to identify the type of the trait. It is an index into the multiname array of the
					//constant_pool. A value of zero indicates that the type is the any type (*).
					type_name=allMultinameV[traits_info.u30_2]//allMultinameV[0]==null
					
					//vindex
					//This field is an index that is used in conjunction with the vkind field in order to define a value for the
					//trait. If it is 0, vkind is empty; otherwise it references one of the tables in the constant pool, depending on
					//the value of vkind.
					//vkind
					//This field exists only when vindex is non-zero. It is used to determine how vindex will be interpreted.
					//See the "Constant Kind" table above for details.
					
					if(traits_info.vindex>0){
						vkindAndVIndex=new ABCConstantItem();
						vkindAndVIndex.initByInfo(
							traits_info.vkind,
							traits_info.vindex,
							integerV,
							uintegerV,
							doubleV,
							stringV,
							allNsV,
							_initByDataOptions
						);
					}else{
						vkindAndVIndex=null;
					}
				break;
				case TraitTypeAndAttributes.Method:
				case TraitTypeAndAttributes.Getter:
				case TraitTypeAndAttributes.Setter:
					
					//A kind value of Trait_Method (0x01), Trait_Getter (0x02) or Trait_Setter (0x03) implies that the
					//trait_method entry should be used.
					//trait_method
					//{
					//	u30 disp_id
					//	u30 method
					//}
					
					//disp_id
					//The disp_id field is a compiler assigned integer that is used by the AVM2 to optimize the resolution of
					//virtual function calls. An overridden method must have the same disp_id as that of the method in the
					//base class. A value of zero disables this optimization.
					disp_id=traits_info.u30_1;
					
					//method
					//The method field is an index that points into the method array of the abcFile entry.
					method=allMethodV[traits_info.u30_2];
				break;
				case TraitTypeAndAttributes.Function_:
					
					//A kind value of Trait_Function (0x05) implies that the trait_function entry should be used.
					//trait_function
					//{
					//	u30 slot_id
					//	u30 function
					//}
					
					//slot_id
					//The slot_id field is an integer from 0 to N and is used to identify a position in which this trait resides.
					//A value of 0 requests the AVM2 to assign a position.
					slot_id=traits_info.u30_1;
					
					//function
					//The function field is an index that points into the method array of the abcFile entry.
					function_=allMethodV[traits_info.u30_2];
				break;
				case TraitTypeAndAttributes.Class_:
					
					//A kind value of Trait_Class (0x04) implies that the trait_class entry should be used.
					//trait_class
					//{
					//	u30 slot_id
					//	u30 classi
					//}
					
					//slot_id
					//The slot_id field is an integer from 0 to N and is used to identify a position in which this trait resides. A
					//value of 0 requests the AVM2 to assign a position.
					slot_id=traits_info.u30_1;
					
					//class
					//The classi field is an index that points into the class array of the abcFile entry.
					classi=classV[traits_info.u30_2];
				break;
			}
			
			//These fields are present only if ATTR_Metadata is present in the upper four bits of the kind field.
			//The value of the metadata_count field is the number of entries in the metadata array. That array
			//contains indices into the metadata array of the abcFile.
			if(traits_info.metadataV){
				if(traits_info.metadataV.length){
					i=-1;
					metadataV=new Vector.<ABCMetadata>();
					for each(var metadata:int in traits_info.metadataV){
						i++;
						metadataV[i]=allMetadataV[metadata];
					}
				}else{
					metadataV=null;
				}
			}else{
				metadataV=null;
			}
		}
		public function getInfo_product(productMark:ProductMark):void{
			
			//The name field is an index into the multiname array of the constant pool; it provides a name for the trait.
			//The value can not be zero, and the multiname entry specified must be a QName.
			productMark.productMultiname(name);
			
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
			
			//As previously mentioned the upper nibble of the kind field is used to encode attributes. A description of how
			//the attributes are interpreted for each kind is outlined below. Any other combination of attribute with kind
			//is ignored.
			//Attributes 		Value
			//ATTR_Final 		0x1 	Is used with Trait_Method, Trait_Getter and Trait_Setter. It marks a method that cannot be overridden by a sub-class
			//ATTR_Override 	0x2 	Is used with Trait_Method, Trait_Getter and Trait_Setter. It marks a method that has been overridden in this class
			//ATTR_Metadata 	0x4 	Is used to signal that the fields metadata_count and metadata follow the data field in the traits_info entry
			
			switch(kind_trait_type){
				case TraitTypeAndAttributes.Slot:
				case TraitTypeAndAttributes.Const:
					
					//A kind value of Trait_Slot (0) or Trait_Const (6) requires that the data field be read using trait_slot,
					//which takes the following form:
					//trait_slot
					//{
					//	u30 slot_id
					//	u30 type_name
					//	u30 vindex
					//	u8 vkind
					//}
					
					//slot_id
					//The slot_id field is an integer from 0 to N and is used to identify a position in which this trait resides. A
					//value of 0 requests the AVM2 to assign a position.
					
					//type_name
					//This field is used to identify the type of the trait. It is an index into the multiname array of the
					//constant_pool. A value of zero indicates that the type is the any type (*).
					productMark.productMultiname(type_name);
					
					//vindex
					//This field is an index that is used in conjunction with the vkind field in order to define a value for the
					//trait. If it is 0, vkind is empty; otherwise it references one of the tables in the constant pool, depending on
					//the value of vkind.
					//vkind
					//This field exists only when vindex is non-zero. It is used to determine how vindex will be interpreted.
					//See the "Constant Kind" table above for details.
					
					if(vkindAndVIndex){
						vkindAndVIndex.getInfo_product(productMark);
					}
				break;
				case TraitTypeAndAttributes.Method:
				case TraitTypeAndAttributes.Getter:
				case TraitTypeAndAttributes.Setter:
					
					//A kind value of Trait_Method (0x01), Trait_Getter (0x02) or Trait_Setter (0x03) implies that the
					//trait_method entry should be used.
					//trait_method
					//{
					//	u30 disp_id
					//	u30 method
					//}
					
					//disp_id
					//The disp_id field is a compiler assigned integer that is used by the AVM2 to optimize the resolution of
					//virtual function calls. An overridden method must have the same disp_id as that of the method in the
					//base class. A value of zero disables this optimization.
					
					//method
					//The method field is an index that points into the method array of the abcFile entry.
					productMark.productMethod(method);
				break;
				case TraitTypeAndAttributes.Function_:
					
					//A kind value of Trait_Function (0x05) implies that the trait_function entry should be used.
					//trait_function
					//{
					//	u30 slot_id
					//	u30 function
					//}
					
					//slot_id
					//The slot_id field is an integer from 0 to N and is used to identify a position in which this trait resides.
					//A value of 0 requests the AVM2 to assign a position.
					
					//function
					//The function field is an index that points into the method array of the abcFile entry.
					productMark.productMethod(function_);
				break;
				case TraitTypeAndAttributes.Class_:
					
					//A kind value of Trait_Class (0x04) implies that the trait_class entry should be used.
					//trait_class
					//{
					//	u30 slot_id
					//	u30 classi
					//}
					
					//slot_id
					//The slot_id field is an integer from 0 to N and is used to identify a position in which this trait resides. A
					//value of 0 requests the AVM2 to assign a position.
					
					//class
					//The classi field is an index that points into the class array of the abcFile entry.
					//classi.getInfo_product(productMark);
				break;
			}
			
			//These fields are present only if ATTR_Metadata is present in the upper four bits of the kind field.
			//The value of the metadata_count field is the number of entries in the metadata array. That array
			//contains indices into the metadata array of the abcFile.
			if(metadataV){
				for each(var metadata:ABCMetadata in metadataV){
					productMark.productMetadata(metadata);
				}
			}
		}
		public function getInfo(productMark:ProductMark,_toDataOptions:Object/*zero_swf_ToDataOptions*/):Traits_info{
			var i:int;
			var traits_info:Traits_info=new Traits_info();
			
			//The name field is an index into the multiname array of the constant pool; it provides a name for the trait.
			//The value can not be zero, and the multiname entry specified must be a QName.
			if(name){
				if(name.kind==MultinameKinds.QName){
					traits_info.name=productMark.getMultinameId(name);
				}else{
					throw new Error("name.kind="+name.kind);
				}
			}else{
				throw new Error("name="+name);
			}
			
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
			
			//As previously mentioned the upper nibble of the kind field is used to encode attributes. A description of how
			//the attributes are interpreted for each kind is outlined below. Any other combination of attribute with kind
			//is ignored.
			//Attributes 		Value
			//ATTR_Final 		0x1 	Is used with Trait_Method, Trait_Getter and Trait_Setter. It marks a method that cannot be overridden by a sub-class
			//ATTR_Override 	0x2 	Is used with Trait_Method, Trait_Getter and Trait_Setter. It marks a method that has been overridden in this class
			//ATTR_Metadata 	0x4 	Is used to signal that the fields metadata_count and metadata follow the data field in the traits_info entry
			
			traits_info.ATTR_Final=ATTR_Final;
			traits_info.ATTR_Override=ATTR_Override;
			
			traits_info.kind_trait_type=kind_trait_type;
			
			switch(kind_trait_type){
				case TraitTypeAndAttributes.Slot:
				case TraitTypeAndAttributes.Const:
					
					//A kind value of Trait_Slot (0) or Trait_Const (6) requires that the data field be read using trait_slot,
					//which takes the following form:
					//trait_slot
					//{
					//	u30 slot_id
					//	u30 type_name
					//	u30 vindex
					//	u8 vkind
					//}
					
					//slot_id
					//The slot_id field is an integer from 0 to N and is used to identify a position in which this trait resides. A
					//value of 0 requests the AVM2 to assign a position.
					traits_info.u30_1=slot_id;
					
					//type_name
					//This field is used to identify the type of the trait. It is an index into the multiname array of the
					//constant_pool. A value of zero indicates that the type is the any type (*).
					traits_info.u30_2=productMark.getMultinameId(type_name);
					
					//vindex
					//This field is an index that is used in conjunction with the vkind field in order to define a value for the
					//trait. If it is 0, vkind is empty; otherwise it references one of the tables in the constant pool, depending on
					//the value of vkind.
					//vkind
					//This field exists only when vindex is non-zero. It is used to determine how vindex will be interpreted.
					//See the "Constant Kind" table above for details.
					
					if(vkindAndVIndex){
						var arr:Array=vkindAndVIndex.getInfo(productMark,_toDataOptions);
						if(arr[1]>0){
							traits_info.vindex=arr[1];
							traits_info.vkind=arr[0];
						}else{
							traits_info.vindex=0;
							traits_info.vkind=0;
						}
					}else{
						traits_info.vindex=0;
						traits_info.vkind=0;
					}
				break;
				case TraitTypeAndAttributes.Method:
				case TraitTypeAndAttributes.Getter:
				case TraitTypeAndAttributes.Setter:
					
					//A kind value of Trait_Method (0x01), Trait_Getter (0x02) or Trait_Setter (0x03) implies that the
					//trait_method entry should be used.
					//trait_method
					//{
					//	u30 disp_id
					//	u30 method
					//}
					
					//disp_id
					//The disp_id field is a compiler assigned integer that is used by the AVM2 to optimize the resolution of
					//virtual function calls. An overridden method must have the same disp_id as that of the method in the
					//base class. A value of zero disables this optimization.
					traits_info.u30_1=disp_id;
					
					//method
					//The method field is an index that points into the method array of the abcFile entry.
					traits_info.u30_2=productMark.getMethodId(method);
				break;
				case TraitTypeAndAttributes.Function_:
					
					//A kind value of Trait_Function (0x05) implies that the trait_function entry should be used.
					//trait_function
					//{
					//	u30 slot_id
					//	u30 function
					//}
					
					//slot_id
					//The slot_id field is an integer from 0 to N and is used to identify a position in which this trait resides.
					//A value of 0 requests the AVM2 to assign a position.
					traits_info.u30_1=slot_id;
					
					//function
					//The function field is an index that points into the method array of the abcFile entry.
					traits_info.u30_2=productMark.getMethodId(function_);
				break;
				case TraitTypeAndAttributes.Class_:
					
					//A kind value of Trait_Class (0x04) implies that the trait_class entry should be used.
					//trait_class
					//{
					//	u30 slot_id
					//	u30 classi
					//}
					
					//slot_id
					//The slot_id field is an integer from 0 to N and is used to identify a position in which this trait resides. A
					//value of 0 requests the AVM2 to assign a position.
					traits_info.u30_1=slot_id;
					
					//class
					//The classi field is an index that points into the class array of the abcFile entry.
					traits_info.u30_2=productMark.getClassId(classi);
				break;
			}
			
			//These fields are present only if ATTR_Metadata is present in the upper four bits of the kind field.
			//The value of the metadata_count field is the number of entries in the metadata array. That array
			//contains indices into the metadata array of the abcFile.
			if(metadataV){
				if(metadataV.length){
					i=-1;
					traits_info.metadataV=new Vector.<int>();
					for each(var metadata:ABCMetadata in metadataV){
						i++;
						traits_info.metadataV[i]=productMark.getMetadataId(metadata);
					}
				}else{
					traits_info.metadataV=null;
				}
			}else{
				traits_info.metadataV=null;
			}
			
			return traits_info;
		}
		
		////
		CONFIG::USE_XML{
		public function toXMLAndMark(markStrs:MarkStrs,xmlName:String,_toXMLOptions:Object/*zero_swf_ToXMLOptions*/):XML{
			var xml:XML=<{xmlName}/>;
			
			if(name){
				if(name.kind==MultinameKinds.QName){
					xml.appendChild(name.toXMLAndMark(markStrs,"name",_toXMLOptions));
				}else{
					throw new Error("name.kind="+name.kind);
				}
			}else{
				throw new Error("name="+name);
			}
			
			xml.@ATTR_Final=ATTR_Final;
			xml.@ATTR_Override=ATTR_Override;
			
			xml.@kind_trait_type=TraitTypeAndAttributes.typeV[kind_trait_type];
				
			switch(kind_trait_type){
				case TraitTypeAndAttributes.Slot:
				case TraitTypeAndAttributes.Const:
					
					xml.@slot_id=slot_id;
					
					if(type_name){
						xml.appendChild(type_name.toXMLAndMark(markStrs,"type_name",_toXMLOptions));
					}
					
					if(vkindAndVIndex){
						xml.appendChild(vkindAndVIndex.toXMLAndMark(markStrs,"vkindAndVIndex",_toXMLOptions));
					}
				break;
				case TraitTypeAndAttributes.Method:
				case TraitTypeAndAttributes.Getter:
				case TraitTypeAndAttributes.Setter:
					
					xml.@disp_id=disp_id;
					
					xml.appendChild(method.toXMLAndMark(markStrs,name.toMarkStrAndMark(markStrs),"method",_toXMLOptions));
				break;
				case TraitTypeAndAttributes.Function_:
					
					xml.@slot_id=slot_id;
					
					xml.appendChild(function_.toXMLAndMark(markStrs,name.toMarkStrAndMark(markStrs),"function_",_toXMLOptions));
				break;
				case TraitTypeAndAttributes.Class_:
					
					xml.@slot_id=slot_id;
					
					xml.appendChild(classi.name.toXMLAndMark(markStrs,"classi",_toXMLOptions));
				break;
			}
			
			if(metadataV){
				if(metadataV.length){
					var metadataListXML:XML=<metadataList count={metadataV.length}/>
					for each(var metadata:ABCMetadata in metadataV){
						metadataListXML.appendChild(metadata.toXMLAndMark(markStrs,"metadata",_toXMLOptions));
					}
					xml.appendChild(metadataListXML);
				}
			}
			
			return xml;
		}
		public function initByXMLAndMark(markStrs:MarkStrs,xml:XML,_initByXMLOptions:Object/*zero_swf_InitByXMLOptions*/):void{
			var i:int;
			
			var nameXML:XML=xml.name[0];
			if(nameXML){
				name=ABCMultiname.xml2multiname(markStrs,nameXML,_initByXMLOptions);
				if(name.kind==MultinameKinds.QName){
				}else{
					throw new Error("name.kind="+name.kind);
				}
			}else{
				throw new Error("nameXML="+nameXML);
			}
			
			ATTR_Final=(xml.@ATTR_Final.toString()=="true");
			ATTR_Override=(xml.@ATTR_Override.toString()=="true");
			
			kind_trait_type=TraitTypeAndAttributes[xml.@kind_trait_type.toString()];
			
			switch(kind_trait_type){
				case TraitTypeAndAttributes.Slot:
				case TraitTypeAndAttributes.Const:
					
					slot_id=int(xml.@slot_id.toString());
					
					var type_nameXML:XML=xml.type_name[0];
					if(type_nameXML){
						type_name=ABCMultiname.xml2multiname(markStrs,type_nameXML,_initByXMLOptions);
					}else{
						type_name=null;
					}
					
					var vkindAndVIndexXML:XML=xml.vkindAndVIndex[0];
					if(vkindAndVIndexXML){
						vkindAndVIndex=new ABCConstantItem();
						vkindAndVIndex.initByXMLAndMark(markStrs,vkindAndVIndexXML,_initByXMLOptions);
					}else{
						vkindAndVIndex=null;
					}
				break;
				case TraitTypeAndAttributes.Method:
				case TraitTypeAndAttributes.Getter:
				case TraitTypeAndAttributes.Setter:
					
					disp_id=int(xml.@disp_id.toString());
					
					method=new ABCMethod();
					method.initByXMLAndMark(markStrs,xml.method[0],_initByXMLOptions);
				break;
				case TraitTypeAndAttributes.Function_:
					
					slot_id=int(xml.@slot_id.toString());
					
					function_=new ABCMethod();
					method.initByXMLAndMark(markStrs,xml.function_[0],_initByXMLOptions);
				break;
				case TraitTypeAndAttributes.Class_:
					
					slot_id=int(xml.@slot_id.toString());
					
					var class_name:ABCMultiname=ABCMultiname.xml2multiname(markStrs,xml.classi[0],_initByXMLOptions);
					classi=markStrs.classDict[class_name];
					if(classi){
					}else{
						throw new Error("找不到 "+class_name.toMarkStrAndMark(markStrs)+" 对应的 ABCClass，请检查 ABCClasses.initByXML()");
					}
				break;
			}
			
			var metadataXMLList:XMLList=xml.metadataList.metadata;
			if(metadataXMLList.length()){
				i=-1;
				metadataV=new Vector.<ABCMetadata>();
				for each(var metadataXML:XML in metadataXMLList){
					i++;
					metadataV[i]=ABCMetadata.xml2metadata(markStrs,metadataXML,_initByXMLOptions);
				}
			}
		}
		}//end of CONFIG::USE_XML
	}
}	