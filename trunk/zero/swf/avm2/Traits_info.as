/***
Traits_info 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年11月3日 11:48:48 
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
	import zero.swf.vmarks.ConstantKind;
	import zero.swf.vmarks.TraitAttributes;
	import zero.swf.vmarks.TraitTypes;
	import flash.utils.ByteArray;
	public class Traits_info extends AVM2Obj{
		public var name:int;							//u30
		public var kind_attributes:int;
		public var kind_trait_type:int;
		
		
		public var slot_id:int;							//u30
		public var type_name:int;						//u30
		public var vindex:int;							//u30
		public var vkind:int;							//u8
		
		public var disp_id:int;							//u30
		public var methodi:int;							//u30
		
		public var functioni:int;						//u30
		
		public var classi:int;							//u30
		
		public var metadataV:Vector.<int>;
		//
		override public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){name=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{name=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{name=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{name=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{name=data[offset++];}
			//name
			var flags:int=data[offset++];
			kind_attributes=(flags<<24)>>>28;			//11110000
			kind_trait_type=flags&0x0f;					//00001111
			//
			switch(kind_trait_type){
				case TraitTypes.Slot:
				case TraitTypes.Const:
					//trait_slot
					//{
					//	u30 slot_id
					//	u30 type_name
					//	u30 vindex
					//	u8 vkind
					//}
					
					//The slot_id field is an integer from 0 to N and is used to identify a position in which this trait resides. A
					//value of 0 requests the AVM2 to assign a position.
					
					//This field is used to identify the type of the trait. It is an index into the multiname array of the
					//constant_pool. A value of zero indicates that the type is the any type (*).
					
					//This field is an index that is used in conjunction with the vkind field in order to define a value for the
					//trait. If it is 0, vkind is empty; otherwise it references one of the tables in the constant pool, depending on
					//the value of vkind.
					//0 表示没有默认值的属性，例如：public var a:int;，这时不需要 vkind
					//否则表示有默认值的属性，例如：public var a:int=123;
					
					//This field exists only when vindex is non-zero. It is used to determine how vindex will be interpreted.
					//See the "Constant Kind" table above for details.
					
					//vindex 和 vkind 合起来很像 Option_detail，Option_detail 是用作函数参数的默认值
					
					if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){slot_id=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{slot_id=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{slot_id=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{slot_id=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{slot_id=data[offset++];}
					//slot_id
					
					if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){type_name=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{type_name=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{type_name=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{type_name=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{type_name=data[offset++];}
					//type_name
					
					if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){vindex=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{vindex=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{vindex=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{vindex=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{vindex=data[offset++];}
					//vindex
					
					if(vindex){
						vkind=data[offset++];
					}
				break;
				case TraitTypes.Method:
				case TraitTypes.Getter:
				case TraitTypes.Setter:
					//trait_method
					//{
					//	u30 disp_id
					//	u30 method
					//}
					
					//The disp_id field is a compiler assigned integer that is used by the AVM2 to optimize the resolution of
					//virtual function calls. An overridden method must have the same disp_id as that of the method in the
					//base class. A value of zero disables this optimization.
					
					//The method field is an index that points into the method array of the abcFile entry.
					
					if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){disp_id=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{disp_id=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{disp_id=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{disp_id=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{disp_id=data[offset++];}
					//disp_id
					
					if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){methodi=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{methodi=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{methodi=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{methodi=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{methodi=data[offset++];}
					//methodi
				break;
				case TraitTypes.Function:
					//trait_function
					//{
					//	u30 slot_id
					//	u30 function
					//}
					
					//The slot_id field is an integer from 0 to N and is used to identify a position in which this trait resides.
					//A value of 0 requests the AVM2 to assign a position.
					
					//The function field is an index that points into the method array of the abcFile entry.
					
					if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){slot_id=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{slot_id=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{slot_id=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{slot_id=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{slot_id=data[offset++];}
					//slot_id
					
					if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){functioni=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{functioni=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{functioni=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{functioni=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{functioni=data[offset++];}
					//functioni
				break;
				case TraitTypes.Clazz:
					//trait_class
					//{
					//	u30 slot_id
					//	u30 classi
					//}
					
					//The slot_id field is an integer from 0 to N and is used to identify a position in which this trait resides. A
					//value of 0 requests the AVM2 to assign a position.
					
					//The classi field is an index that points into the class array of the abcFile entry.
					
					if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){slot_id=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{slot_id=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{slot_id=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{slot_id=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{slot_id=data[offset++];}
					//slot_id
					
					if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){classi=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{classi=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{classi=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{classi=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{classi=data[offset++];}
					//classi
				break;
			}
			//
			
			if(kind_attributes&TraitAttributes.Metadata){
			
			
				if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){var metadata_count:int=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{metadata_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{metadata_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{metadata_count=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{metadata_count=data[offset++];}
				//metadata_count
				metadataV=new Vector.<int>(metadata_count);
				for(var i:int=0;i<metadata_count;i++){
			
					if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){metadataV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{metadataV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{metadataV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{metadataV[i]=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{metadataV[i]=data[offset++];}
					//metadataV[i]
				}
			}
			return offset;
		}
		override public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			var offset:int=0;
			if(name>>>7){if(name>>>14){if(name>>>21){if(name>>>28){data[offset++]=(name&0x7f)|0x80;data[offset++]=((name>>>7)&0x7f)|0x80;data[offset++]=((name>>>14)&0x7f)|0x80;data[offset++]=((name>>>21)&0x7f)|0x80;data[offset++]=name>>>28;}else{data[offset++]=(name&0x7f)|0x80;data[offset++]=((name>>>7)&0x7f)|0x80;data[offset++]=((name>>>14)&0x7f)|0x80;data[offset++]=name>>>21;}}else{data[offset++]=(name&0x7f)|0x80;data[offset++]=((name>>>7)&0x7f)|0x80;data[offset++]=name>>>14;}}else{data[offset++]=(name&0x7f)|0x80;data[offset++]=name>>>7;}}else{data[offset++]=name;}
			//name
			var flags:int=0;
			flags|=kind_attributes<<4;					//11110000
			flags|=kind_trait_type;						//00001111
			data[offset++]=flags;
			
			switch(kind_trait_type){
				case TraitTypes.Slot:
				case TraitTypes.Const:
					if(slot_id>>>7){if(slot_id>>>14){if(slot_id>>>21){if(slot_id>>>28){data[offset++]=(slot_id&0x7f)|0x80;data[offset++]=((slot_id>>>7)&0x7f)|0x80;data[offset++]=((slot_id>>>14)&0x7f)|0x80;data[offset++]=((slot_id>>>21)&0x7f)|0x80;data[offset++]=slot_id>>>28;}else{data[offset++]=(slot_id&0x7f)|0x80;data[offset++]=((slot_id>>>7)&0x7f)|0x80;data[offset++]=((slot_id>>>14)&0x7f)|0x80;data[offset++]=slot_id>>>21;}}else{data[offset++]=(slot_id&0x7f)|0x80;data[offset++]=((slot_id>>>7)&0x7f)|0x80;data[offset++]=slot_id>>>14;}}else{data[offset++]=(slot_id&0x7f)|0x80;data[offset++]=slot_id>>>7;}}else{data[offset++]=slot_id;}
					//slot_id
					
					if(type_name>>>7){if(type_name>>>14){if(type_name>>>21){if(type_name>>>28){data[offset++]=(type_name&0x7f)|0x80;data[offset++]=((type_name>>>7)&0x7f)|0x80;data[offset++]=((type_name>>>14)&0x7f)|0x80;data[offset++]=((type_name>>>21)&0x7f)|0x80;data[offset++]=type_name>>>28;}else{data[offset++]=(type_name&0x7f)|0x80;data[offset++]=((type_name>>>7)&0x7f)|0x80;data[offset++]=((type_name>>>14)&0x7f)|0x80;data[offset++]=type_name>>>21;}}else{data[offset++]=(type_name&0x7f)|0x80;data[offset++]=((type_name>>>7)&0x7f)|0x80;data[offset++]=type_name>>>14;}}else{data[offset++]=(type_name&0x7f)|0x80;data[offset++]=type_name>>>7;}}else{data[offset++]=type_name;}
					//type_name
					
					if(vindex>>>7){if(vindex>>>14){if(vindex>>>21){if(vindex>>>28){data[offset++]=(vindex&0x7f)|0x80;data[offset++]=((vindex>>>7)&0x7f)|0x80;data[offset++]=((vindex>>>14)&0x7f)|0x80;data[offset++]=((vindex>>>21)&0x7f)|0x80;data[offset++]=vindex>>>28;}else{data[offset++]=(vindex&0x7f)|0x80;data[offset++]=((vindex>>>7)&0x7f)|0x80;data[offset++]=((vindex>>>14)&0x7f)|0x80;data[offset++]=vindex>>>21;}}else{data[offset++]=(vindex&0x7f)|0x80;data[offset++]=((vindex>>>7)&0x7f)|0x80;data[offset++]=vindex>>>14;}}else{data[offset++]=(vindex&0x7f)|0x80;data[offset++]=vindex>>>7;}}else{data[offset++]=vindex;}
					//vindex
					if(vindex){
						data[offset++]=vkind;
					}
				break;
				case TraitTypes.Method:
				case TraitTypes.Getter:
				case TraitTypes.Setter:
					if(disp_id>>>7){if(disp_id>>>14){if(disp_id>>>21){if(disp_id>>>28){data[offset++]=(disp_id&0x7f)|0x80;data[offset++]=((disp_id>>>7)&0x7f)|0x80;data[offset++]=((disp_id>>>14)&0x7f)|0x80;data[offset++]=((disp_id>>>21)&0x7f)|0x80;data[offset++]=disp_id>>>28;}else{data[offset++]=(disp_id&0x7f)|0x80;data[offset++]=((disp_id>>>7)&0x7f)|0x80;data[offset++]=((disp_id>>>14)&0x7f)|0x80;data[offset++]=disp_id>>>21;}}else{data[offset++]=(disp_id&0x7f)|0x80;data[offset++]=((disp_id>>>7)&0x7f)|0x80;data[offset++]=disp_id>>>14;}}else{data[offset++]=(disp_id&0x7f)|0x80;data[offset++]=disp_id>>>7;}}else{data[offset++]=disp_id;}
					//disp_id
					
					if(methodi>>>7){if(methodi>>>14){if(methodi>>>21){if(methodi>>>28){data[offset++]=(methodi&0x7f)|0x80;data[offset++]=((methodi>>>7)&0x7f)|0x80;data[offset++]=((methodi>>>14)&0x7f)|0x80;data[offset++]=((methodi>>>21)&0x7f)|0x80;data[offset++]=methodi>>>28;}else{data[offset++]=(methodi&0x7f)|0x80;data[offset++]=((methodi>>>7)&0x7f)|0x80;data[offset++]=((methodi>>>14)&0x7f)|0x80;data[offset++]=methodi>>>21;}}else{data[offset++]=(methodi&0x7f)|0x80;data[offset++]=((methodi>>>7)&0x7f)|0x80;data[offset++]=methodi>>>14;}}else{data[offset++]=(methodi&0x7f)|0x80;data[offset++]=methodi>>>7;}}else{data[offset++]=methodi;}
					//methodi
				break;
				case TraitTypes.Function:
					if(slot_id>>>7){if(slot_id>>>14){if(slot_id>>>21){if(slot_id>>>28){data[offset++]=(slot_id&0x7f)|0x80;data[offset++]=((slot_id>>>7)&0x7f)|0x80;data[offset++]=((slot_id>>>14)&0x7f)|0x80;data[offset++]=((slot_id>>>21)&0x7f)|0x80;data[offset++]=slot_id>>>28;}else{data[offset++]=(slot_id&0x7f)|0x80;data[offset++]=((slot_id>>>7)&0x7f)|0x80;data[offset++]=((slot_id>>>14)&0x7f)|0x80;data[offset++]=slot_id>>>21;}}else{data[offset++]=(slot_id&0x7f)|0x80;data[offset++]=((slot_id>>>7)&0x7f)|0x80;data[offset++]=slot_id>>>14;}}else{data[offset++]=(slot_id&0x7f)|0x80;data[offset++]=slot_id>>>7;}}else{data[offset++]=slot_id;}
					//slot_id
					
					if(functioni>>>7){if(functioni>>>14){if(functioni>>>21){if(functioni>>>28){data[offset++]=(functioni&0x7f)|0x80;data[offset++]=((functioni>>>7)&0x7f)|0x80;data[offset++]=((functioni>>>14)&0x7f)|0x80;data[offset++]=((functioni>>>21)&0x7f)|0x80;data[offset++]=functioni>>>28;}else{data[offset++]=(functioni&0x7f)|0x80;data[offset++]=((functioni>>>7)&0x7f)|0x80;data[offset++]=((functioni>>>14)&0x7f)|0x80;data[offset++]=functioni>>>21;}}else{data[offset++]=(functioni&0x7f)|0x80;data[offset++]=((functioni>>>7)&0x7f)|0x80;data[offset++]=functioni>>>14;}}else{data[offset++]=(functioni&0x7f)|0x80;data[offset++]=functioni>>>7;}}else{data[offset++]=functioni;}
					//functioni
				break;
				case TraitTypes.Clazz:
					if(slot_id>>>7){if(slot_id>>>14){if(slot_id>>>21){if(slot_id>>>28){data[offset++]=(slot_id&0x7f)|0x80;data[offset++]=((slot_id>>>7)&0x7f)|0x80;data[offset++]=((slot_id>>>14)&0x7f)|0x80;data[offset++]=((slot_id>>>21)&0x7f)|0x80;data[offset++]=slot_id>>>28;}else{data[offset++]=(slot_id&0x7f)|0x80;data[offset++]=((slot_id>>>7)&0x7f)|0x80;data[offset++]=((slot_id>>>14)&0x7f)|0x80;data[offset++]=slot_id>>>21;}}else{data[offset++]=(slot_id&0x7f)|0x80;data[offset++]=((slot_id>>>7)&0x7f)|0x80;data[offset++]=slot_id>>>14;}}else{data[offset++]=(slot_id&0x7f)|0x80;data[offset++]=slot_id>>>7;}}else{data[offset++]=slot_id;}
					//slot_id
					
					if(classi>>>7){if(classi>>>14){if(classi>>>21){if(classi>>>28){data[offset++]=(classi&0x7f)|0x80;data[offset++]=((classi>>>7)&0x7f)|0x80;data[offset++]=((classi>>>14)&0x7f)|0x80;data[offset++]=((classi>>>21)&0x7f)|0x80;data[offset++]=classi>>>28;}else{data[offset++]=(classi&0x7f)|0x80;data[offset++]=((classi>>>7)&0x7f)|0x80;data[offset++]=((classi>>>14)&0x7f)|0x80;data[offset++]=classi>>>21;}}else{data[offset++]=(classi&0x7f)|0x80;data[offset++]=((classi>>>7)&0x7f)|0x80;data[offset++]=classi>>>14;}}else{data[offset++]=(classi&0x7f)|0x80;data[offset++]=classi>>>7;}}else{data[offset++]=classi;}
					//classi
				break;
			}
			
			if(kind_attributes&TraitAttributes.Metadata){
				var metadata_count:int=metadataV.length;
			
				if(metadata_count>>>7){if(metadata_count>>>14){if(metadata_count>>>21){if(metadata_count>>>28){data[offset++]=(metadata_count&0x7f)|0x80;data[offset++]=((metadata_count>>>7)&0x7f)|0x80;data[offset++]=((metadata_count>>>14)&0x7f)|0x80;data[offset++]=((metadata_count>>>21)&0x7f)|0x80;data[offset++]=metadata_count>>>28;}else{data[offset++]=(metadata_count&0x7f)|0x80;data[offset++]=((metadata_count>>>7)&0x7f)|0x80;data[offset++]=((metadata_count>>>14)&0x7f)|0x80;data[offset++]=metadata_count>>>21;}}else{data[offset++]=(metadata_count&0x7f)|0x80;data[offset++]=((metadata_count>>>7)&0x7f)|0x80;data[offset++]=metadata_count>>>14;}}else{data[offset++]=(metadata_count&0x7f)|0x80;data[offset++]=metadata_count>>>7;}}else{data[offset++]=metadata_count;}
				//metadata_count
			
				for each(var metadata:int in metadataV){
			
					if(metadata>>>7){if(metadata>>>14){if(metadata>>>21){if(metadata>>>28){data[offset++]=(metadata&0x7f)|0x80;data[offset++]=((metadata>>>7)&0x7f)|0x80;data[offset++]=((metadata>>>14)&0x7f)|0x80;data[offset++]=((metadata>>>21)&0x7f)|0x80;data[offset++]=metadata>>>28;}else{data[offset++]=(metadata&0x7f)|0x80;data[offset++]=((metadata>>>7)&0x7f)|0x80;data[offset++]=((metadata>>>14)&0x7f)|0x80;data[offset++]=metadata>>>21;}}else{data[offset++]=(metadata&0x7f)|0x80;data[offset++]=((metadata>>>7)&0x7f)|0x80;data[offset++]=metadata>>>14;}}else{data[offset++]=(metadata&0x7f)|0x80;data[offset++]=metadata>>>7;}}else{data[offset++]=metadata;}
					//metadata
				}
			}
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		override public function toXML(xmlName:String):XML{
			var xml:XML=<{xmlName} class="Traits_info"
				name={name}
				kind_attributes={(
					"|"+TraitAttributes.flagV[kind_attributes&TraitAttributes.Final]+
					"|"+TraitAttributes.flagV[kind_attributes&TraitAttributes.Override]+
					"|"+TraitAttributes.flagV[kind_attributes&TraitAttributes.Metadata]
				).replace(/\|null/g,"").substr(1)}
				kind_trait_type={TraitTypes.typeV[kind_trait_type]}
			/>;
			
			switch(kind_trait_type){
				case TraitTypes.Slot:
				case TraitTypes.Const:
					xml.@slot_id=slot_id;
					xml.@type_name=type_name;
					xml.@vindex=vindex;
					if(vindex){
						xml.@vkind=ConstantKind.kindV[vkind];
					}
				break;
				case TraitTypes.Method:
				case TraitTypes.Getter:
				case TraitTypes.Setter:
					xml.@disp_id=disp_id;
					xml.@methodi=methodi;
				break;
				case TraitTypes.Function:
					xml.@slot_id=slot_id;
					xml.@functioni=functioni;
				break;
				case TraitTypes.Clazz:
					xml.@slot_id=slot_id;
					xml.@classi=classi;
				break;
			}
			
			if(kind_attributes&TraitAttributes.Metadata){
				if(metadataV.length){
					var listXML:XML=<metadataList count={metadataV.length}/>
					for each(var metadata:int in metadataV){
						listXML.appendChild(<metadata value={metadata}/>);
					}
					xml.appendChild(listXML);
				}
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
			switch(kind_trait_type){
				case TraitTypes.Slot:
				case TraitTypes.Const:
					slot_id=int(xml.@slot_id.toString());
					type_name=int(xml.@type_name.toString());
					vindex=int(xml.@vindex.toString());
					if(vindex){
						vkind=ConstantKind[xml.@vkind.toString()];
					}
				break;
				case TraitTypes.Method:
				case TraitTypes.Getter:
				case TraitTypes.Setter:
					disp_id=int(xml.@disp_id.toString());
					methodi=int(xml.@methodi.toString());
				break;
				case TraitTypes.Function:
					slot_id=int(xml.@slot_id.toString());
					functioni=int(xml.@functioni.toString());
				break;
				case TraitTypes.Clazz:
					slot_id=int(xml.@slot_id.toString());
					classi=int(xml.@classi.toString());
				break;
			}
			//
			if(kind_attributes&TraitAttributes.Metadata){
				if(xml.metadataList.length()){
					var listXML:XML=xml.metadataList[0];
					var metadataXMLList:XMLList=listXML.metadata;
					var i:int=-1;
					metadataV=new Vector.<int>(metadataXMLList.length());
					for each(var metadataXML:XML in metadataXMLList){
						i++;
						metadataV[i]=int(metadataXML.@value.toString());
					}
				}else{
					metadataV=new Vector.<int>();
				}
			}
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
