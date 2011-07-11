/***
Traits_info
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月19日 22:24:32（代码生成器 V1.1.0 F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf）
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
//vindex
//This field is an index that is used in conjunction with the vkind field in order to define a value for the
//trait. If it is 0, vkind is empty; otherwise it references one of the tables in the constant pool, depending on
//the value of vkind.
//vkind
//This field exists only when vindex is non-zero. It is used to determine how vindex will be interpreted.
//See the "Constant Kind" table above for details.

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
package zero.swf.avm2{
	import zero.swf.avm2.TraitTypeAndAttributes;
	import flash.utils.ByteArray;
	public class Traits_info{//implements I_zero_swf_CheckCodesRight{
		public var name:int;							//u30
		public var ATTR_Final:Boolean;
		public var ATTR_Override:Boolean;
		public var kind_trait_type:int;
		//Slot，Const				u30_1 表现为：slot_id，u30_2 表现为：type_name
		//Method，Getter，Setter		u30_1 表现为：disp_id，u30_2 表现为：method
		//Function_					u30_1 表现为：slot_id，u30_2 表现为：function
		//Class_					u30_1 表现为：slot_id，u30_2 表现为：classi
		public var u30_1:int;							//u30
		public var u30_2:int;							//u30
		//vindex 和 vkind 仅用于 Slot 和 Const
		public var vindex:int;							//u30
		public var vkind:int;							//u8
		public var metadataV:Vector.<int>;
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object/*zero_swf_InitByDataOptions*/):int{
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){name=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{name=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{name=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{name=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{name=data[offset++];}
			//name
			var flags:int=data[offset++];
			ATTR_Final=((flags&TraitTypeAndAttributes.ATTR_Final)?true:false);
			ATTR_Override=((flags&TraitTypeAndAttributes.ATTR_Override)?true:false);
			kind_trait_type=flags&0x0f;					//00001111
			
			
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){u30_1=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{u30_1=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{u30_1=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{u30_1=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{u30_1=data[offset++];}
			//u30_1
			
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){u30_2=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{u30_2=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{u30_2=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{u30_2=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{u30_2=data[offset++];}
			//u30_2
			
			switch(kind_trait_type){
				case TraitTypeAndAttributes.Slot:
				case TraitTypeAndAttributes.Const:
					if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){vindex=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{vindex=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{vindex=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{vindex=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{vindex=data[offset++];}
					//vindex
			
					if(vindex){
						vkind=data[offset++];
					}
				break;
			}
			
			if(flags&TraitTypeAndAttributes.ATTR_Metadata){
				
				if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){var metadata_count:int=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{metadata_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{metadata_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{metadata_count=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{metadata_count=data[offset++];}
				//metadata_count
				
				if(metadata_count){
					metadataV=new Vector.<int>();
					for(var i:int=0;i<metadata_count;i++){
				
						if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){metadataV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{metadataV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{metadataV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{metadataV[i]=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{metadataV[i]=data[offset++];}
						//metadataV[i]
					}
				}else{
					metadataV=null;
				}
			}else{
				metadataV=null;
			}
			return offset;
		}
		public function toData(_toDataOptions:Object/*zero_swf_ToDataOptions*/):ByteArray{
			var data:ByteArray=new ByteArray();
			var offset:int=0;
			if(name>>>7){if(name>>>14){if(name>>>21){if(name>>>28){data[offset++]=(name&0x7f)|0x80;data[offset++]=((name>>>7)&0x7f)|0x80;data[offset++]=((name>>>14)&0x7f)|0x80;data[offset++]=((name>>>21)&0x7f)|0x80;data[offset++]=name>>>28;}else{data[offset++]=(name&0x7f)|0x80;data[offset++]=((name>>>7)&0x7f)|0x80;data[offset++]=((name>>>14)&0x7f)|0x80;data[offset++]=name>>>21;}}else{data[offset++]=(name&0x7f)|0x80;data[offset++]=((name>>>7)&0x7f)|0x80;data[offset++]=name>>>14;}}else{data[offset++]=(name&0x7f)|0x80;data[offset++]=name>>>7;}}else{data[offset++]=name;}
			//name
			var flags:int=0;
			if(ATTR_Final){
				flags|=TraitTypeAndAttributes.ATTR_Final;
			}
			if(ATTR_Override){
				flags|=TraitTypeAndAttributes.ATTR_Override;
			}
			flags|=kind_trait_type;						//00001111
			var flagsOffset:int=offset;
			offset++;
			
			if(u30_1>>>7){if(u30_1>>>14){if(u30_1>>>21){if(u30_1>>>28){data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=((u30_1>>>14)&0x7f)|0x80;data[offset++]=((u30_1>>>21)&0x7f)|0x80;data[offset++]=u30_1>>>28;}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=((u30_1>>>14)&0x7f)|0x80;data[offset++]=u30_1>>>21;}}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=u30_1>>>14;}}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=u30_1>>>7;}}else{data[offset++]=u30_1;}
			//u30_1
			
			if(u30_2>>>7){if(u30_2>>>14){if(u30_2>>>21){if(u30_2>>>28){data[offset++]=(u30_2&0x7f)|0x80;data[offset++]=((u30_2>>>7)&0x7f)|0x80;data[offset++]=((u30_2>>>14)&0x7f)|0x80;data[offset++]=((u30_2>>>21)&0x7f)|0x80;data[offset++]=u30_2>>>28;}else{data[offset++]=(u30_2&0x7f)|0x80;data[offset++]=((u30_2>>>7)&0x7f)|0x80;data[offset++]=((u30_2>>>14)&0x7f)|0x80;data[offset++]=u30_2>>>21;}}else{data[offset++]=(u30_2&0x7f)|0x80;data[offset++]=((u30_2>>>7)&0x7f)|0x80;data[offset++]=u30_2>>>14;}}else{data[offset++]=(u30_2&0x7f)|0x80;data[offset++]=u30_2>>>7;}}else{data[offset++]=u30_2;}
			//u30_2
			
			switch(kind_trait_type){
				case TraitTypeAndAttributes.Slot:
				case TraitTypeAndAttributes.Const:
					if(vindex>>>7){if(vindex>>>14){if(vindex>>>21){if(vindex>>>28){data[offset++]=(vindex&0x7f)|0x80;data[offset++]=((vindex>>>7)&0x7f)|0x80;data[offset++]=((vindex>>>14)&0x7f)|0x80;data[offset++]=((vindex>>>21)&0x7f)|0x80;data[offset++]=vindex>>>28;}else{data[offset++]=(vindex&0x7f)|0x80;data[offset++]=((vindex>>>7)&0x7f)|0x80;data[offset++]=((vindex>>>14)&0x7f)|0x80;data[offset++]=vindex>>>21;}}else{data[offset++]=(vindex&0x7f)|0x80;data[offset++]=((vindex>>>7)&0x7f)|0x80;data[offset++]=vindex>>>14;}}else{data[offset++]=(vindex&0x7f)|0x80;data[offset++]=vindex>>>7;}}else{data[offset++]=vindex;}
					//vindex
			
					if(vindex){
						data[offset++]=vkind;
					}
				break;
			}
			
			if(metadataV){
				var metadata_count:int=metadataV.length;
				if(metadata_count){
					flags|=TraitTypeAndAttributes.ATTR_Metadata;
					
					if(metadata_count>>>7){if(metadata_count>>>14){if(metadata_count>>>21){if(metadata_count>>>28){data[offset++]=(metadata_count&0x7f)|0x80;data[offset++]=((metadata_count>>>7)&0x7f)|0x80;data[offset++]=((metadata_count>>>14)&0x7f)|0x80;data[offset++]=((metadata_count>>>21)&0x7f)|0x80;data[offset++]=metadata_count>>>28;}else{data[offset++]=(metadata_count&0x7f)|0x80;data[offset++]=((metadata_count>>>7)&0x7f)|0x80;data[offset++]=((metadata_count>>>14)&0x7f)|0x80;data[offset++]=metadata_count>>>21;}}else{data[offset++]=(metadata_count&0x7f)|0x80;data[offset++]=((metadata_count>>>7)&0x7f)|0x80;data[offset++]=metadata_count>>>14;}}else{data[offset++]=(metadata_count&0x7f)|0x80;data[offset++]=metadata_count>>>7;}}else{data[offset++]=metadata_count;}
					//metadata_count
				
					for each(var metadata:int in metadataV){
				
						if(metadata>>>7){if(metadata>>>14){if(metadata>>>21){if(metadata>>>28){data[offset++]=(metadata&0x7f)|0x80;data[offset++]=((metadata>>>7)&0x7f)|0x80;data[offset++]=((metadata>>>14)&0x7f)|0x80;data[offset++]=((metadata>>>21)&0x7f)|0x80;data[offset++]=metadata>>>28;}else{data[offset++]=(metadata&0x7f)|0x80;data[offset++]=((metadata>>>7)&0x7f)|0x80;data[offset++]=((metadata>>>14)&0x7f)|0x80;data[offset++]=metadata>>>21;}}else{data[offset++]=(metadata&0x7f)|0x80;data[offset++]=((metadata>>>7)&0x7f)|0x80;data[offset++]=metadata>>>14;}}else{data[offset++]=(metadata&0x7f)|0x80;data[offset++]=metadata>>>7;}}else{data[offset++]=metadata;}
						//metadata
					}
				}
			}
			data[flagsOffset]=flags;
			return data;
		}

		////
		CONFIG::USE_XML{
		public function toXML(xmlName:String,_toXMLOptions:Object/*zero_swf_ToXMLOptions*/):XML{
			var xml:XML=<{xmlName} class="zero.swf.avm2.Traits_info"
				name={name}
				ATTR_Final={ATTR_Final}
				ATTR_Override={ATTR_Override}
				kind_trait_type={TraitTypeAndAttributes.typeV[kind_trait_type]}
				u30_1={u30_1}
				u30_2={u30_2}
			/>;
			
			switch(kind_trait_type){
				case TraitTypeAndAttributes.Slot:
				case TraitTypeAndAttributes.Const:
					xml.@vindex=vindex;
					if(vindex){
						xml.@vkind=vkind;
					}
				break;
			}
			if(metadataV){
				if(metadataV.length){
					var metadataListXML:XML=<metadataList count={metadataV.length}/>
					for each(var metadata:int in metadataV){
						metadataListXML.appendChild(<metadata value={metadata}/>);
					}
					xml.appendChild(metadataListXML);
				}
			}
			return xml;
		}
		public function initByXML(xml:XML,_initByXMLOptions:Object/*zero_swf_InitByXMLOptions*/):void{
			name=int(xml.@name.toString());
			
			ATTR_Final=(xml.@ATTR_Final.toString()=="true");
			ATTR_Override=(xml.@ATTR_Override.toString()=="true");
			
			kind_trait_type=TraitTypeAndAttributes[xml.@kind_trait_type.toString()];
			
			u30_1=int(xml.@u30_1.toString());
			u30_2=int(xml.@u30_2.toString());
			
			switch(kind_trait_type){
				case TraitTypeAndAttributes.Slot:
				case TraitTypeAndAttributes.Const:
					vindex=int(xml.@vindex.toString());
					if(vindex){
						vkind=int(xml.@vkind.toString());
					}
				break;
			}
			var metadataXMLList:XMLList=xml.metadataList.metadata;
			if(metadataXMLList.length()){
				var i:int=-1;
				metadataV=new Vector.<int>();
				for each(var metadataXML:XML in metadataXMLList){
					i++;
					metadataV[i]=int(metadataXML.@value.toString());
				}
			}else{
				metadataV=null;
			}
		}
		}//end of CONFIG::USE_XML
	}
}
