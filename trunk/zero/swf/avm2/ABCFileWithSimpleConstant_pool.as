/***
ABCFileWithSimpleConstant_pool 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年11月18日 15:38:50 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
//The constant pool is a block of array-based entries(entry 条目) that reflect the constants used by all methods.
//Each of the count entries (for example, int_count) must be one more than the number of entries in the corresponding
//array, 
//每个条目数组的 count 都是比数组长度多1(1表示0,2表示1,...因为0表示了特别的意义，下面有提及)
//and the first entry in the array is element "1". 
//For all constant pools, the index "0" has a special meaning,
//typically a sensible default value. For example, the "0" entry is used to represent the empty sting (""), the any
//namespace, or the any type (*) depending on the context it is used in. When "0" has a special meaning it is
//described in the text below.

//cpool_info
//{
//	u30 			int_count
//	s32 			integer[int_count]
//	u30 			uint_count
//	u32 			uinteger[uint_count]
//	u30 			double_count
//	d64 			double[double_count]
//	u30 			string_count
//	string_info 	string[string_count]
//	u30 			namespace_count
//	namespace_info 	namespace[namespace_count]
//	u30 			ns_set_count
//	ns_set_info 	ns_set[ns_set_count]
//	u30 			multiname_count
//	multiname_info 	multiname[multiname_count]
//}

//The value of int_count is the number of entries in the integer array, plus one. The integer array
//holds integer constants referenced by the bytecode. The "0" entry of the integer array is not present in
//the abcFile; it represents the zero value for the purposes of providing values for optional parameters and
//field initialization.

//The value of uint_count is the number of entries in the uinteger array, plus one. The uinteger array
//holds unsigned integer constants referenced by the bytecode. The "0" entry of the uinteger array is not
//present in the abcFile; it represents the zero value for the purposes of providing values for optional
//parameters and field initialization.

//The value of double_count is the number of entries in the double array, plus one. The double array
//holds IEEE double-precision floating point constants referenced by the bytecode. 
//The "0" entry of the double array is not present in the abcFile; it represents the NaN (Not-a-Number) value for the purposes of providing values for optional parameters and field initialization.
//0 代表 NaN	

//The value of string_count is the number of entries in the string array, plus one. The string array
//holds UTF-8 encoded strings referenced by the compiled code and by many other parts of the abcFile.
//In addition to describing string constants in programs, string data in the constant pool are used in the
//description of names of many kinds. Entry "0" of the string array is not present in the abcFile; it
//represents the empty string in most contexts but is also used to represent the "any" name in others
//(known as "*" in ActionScript).

//The value of namespace_count is the number of entries in the namespace array, plus one. The
//namespace array describes the namespaces used by the bytecode and also for names of many kinds. Entry
//"0" of the namespace array is not present in the abcFile; it represents the "any" namespace (known as
//"*" in ActionScript).

//The value of ns_set_count is the number of entries in the ns_set array, plus one. The ns_set array
//describes namespace sets used in the descriptions of multinames. The "0" entry of the ns_set array is not
//present in the abcFile.

//The value of multiname_count is the number of entries in the multiname array, plus one. The
//multiname array describes names used by the bytecode. The "0" entry of the multiname array is not
//present in the abcFile.
package zero.swf.avm2{
	import zero.swf.BytesData;
	import flash.utils.Endian;
	import flash.utils.ByteArray;
	public class ABCFileWithSimpleConstant_pool extends AVM2Obj{
		public var minor_version:int;					//UI16
		public var major_version:int;					//UI16
		public var integerV:Vector.<int>;
		public var uintegerV:Vector.<int>;
		public var doubleV:Vector.<Number>;
		public var stringV:Vector.<String>;
		public var restDatas:BytesData;
		//
		override public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			data.endian=Endian.LITTLE_ENDIAN;
			minor_version=data[offset]|(data[offset+1]<<8);
			major_version=data[offset+2]|(data[offset+3]<<8);
			offset+=4;
			
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){var integer_count:int=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{integer_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{integer_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{integer_count=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{integer_count=data[offset++];}
			//integer_count
			integerV=new Vector.<int>(integer_count);
			for(var i:int=1;i<integer_count;i++){
			
				if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){integerV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{integerV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{integerV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{integerV[i]=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{integerV[i]=data[offset++];}
				//integerV[i]
			}
			
			
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){var uinteger_count:int=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{uinteger_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{uinteger_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{uinteger_count=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{uinteger_count=data[offset++];}
			//uinteger_count
			uintegerV=new Vector.<int>(uinteger_count);
			for(i=1;i<uinteger_count;i++){
			
				if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){uintegerV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{uintegerV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{uintegerV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{uintegerV[i]=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{uintegerV[i]=data[offset++];}
				//uintegerV[i]
			}
			
			
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){var double_count:int=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{double_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{double_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{double_count=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{double_count=data[offset++];}
			//double_count
			doubleV=new Vector.<Number>(double_count);
			data.position=offset;
			for(i=1;i<double_count;i++){
				doubleV[i]=data.readDouble();
			}
			offset=data.position;
			
			
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){var string_count:int=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{string_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{string_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{string_count=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{string_count=data[offset++];}
			//string_count
			stringV=new Vector.<String>(string_count);
			for(i=1;i<string_count;i++){
			
				if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){var get_str_size:int=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{get_str_size=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{get_str_size=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{get_str_size=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{get_str_size=data[offset++];}
				//get_str_size
				
				if(get_str_size){
					//处理 "\x00"
					var get_str_end_offset:int=offset+get_str_size;
					var get_str_str:String="";
					do{
						if(data[offset]){
							data.position=offset;
							var get_str_sub_str:String=data.readUTFBytes(get_str_end_offset-offset);
							var get_str_data:ByteArray=new ByteArray();
							get_str_data.writeUTFBytes(get_str_sub_str);
							get_str_str+=get_str_sub_str;
							offset+=get_str_data.length;
						}else{
							get_str_str+="\x00";
							offset++;
						}
					}while(offset<get_str_end_offset);
					if(offset==get_str_end_offset){
					}else{
						offset=get_str_end_offset;
						//throw new Error("get_str_data.length="+get_str_data.length+",get_str_size="+get_str_size+",get_str_str=\""+get_str_str+"\"");
						import zero.Outputer;
						Outputer.output("get_str_data.length="+get_str_data.length+",get_str_size="+get_str_size+",get_str_str=\""+get_str_str+"\"","brown");
					}
					stringV[i]=get_str_str;
				}else{
					stringV[i]="";
				}
				//
			}
			
			restDatas=new BytesData();
			return restDatas.initByData(data,offset,endOffset);
		}
		override public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			data.endian=Endian.LITTLE_ENDIAN;
			data[0]=minor_version;
			data[1]=minor_version>>8;
			data[2]=major_version;
			data[3]=major_version>>8;
			var integer_count:int=integerV.length;
			var offset:int=4;
			if(integer_count>>>7){if(integer_count>>>14){if(integer_count>>>21){if(integer_count>>>28){data[offset++]=(integer_count&0x7f)|0x80;data[offset++]=((integer_count>>>7)&0x7f)|0x80;data[offset++]=((integer_count>>>14)&0x7f)|0x80;data[offset++]=((integer_count>>>21)&0x7f)|0x80;data[offset++]=integer_count>>>28;}else{data[offset++]=(integer_count&0x7f)|0x80;data[offset++]=((integer_count>>>7)&0x7f)|0x80;data[offset++]=((integer_count>>>14)&0x7f)|0x80;data[offset++]=integer_count>>>21;}}else{data[offset++]=(integer_count&0x7f)|0x80;data[offset++]=((integer_count>>>7)&0x7f)|0x80;data[offset++]=integer_count>>>14;}}else{data[offset++]=(integer_count&0x7f)|0x80;data[offset++]=integer_count>>>7;}}else{data[offset++]=integer_count;}
			//integer_count
			
			var i:int=0;
			for each(var integer:int in integerV){
				if(i<1){
					i++;
					continue;
				}
			
				if(integer>>>7){if(integer>>>14){if(integer>>>21){if(integer>>>28){data[offset++]=(integer&0x7f)|0x80;data[offset++]=((integer>>>7)&0x7f)|0x80;data[offset++]=((integer>>>14)&0x7f)|0x80;data[offset++]=((integer>>>21)&0x7f)|0x80;data[offset++]=integer>>>28;}else{data[offset++]=(integer&0x7f)|0x80;data[offset++]=((integer>>>7)&0x7f)|0x80;data[offset++]=((integer>>>14)&0x7f)|0x80;data[offset++]=integer>>>21;}}else{data[offset++]=(integer&0x7f)|0x80;data[offset++]=((integer>>>7)&0x7f)|0x80;data[offset++]=integer>>>14;}}else{data[offset++]=(integer&0x7f)|0x80;data[offset++]=integer>>>7;}}else{data[offset++]=integer;}
				//integer
			}
			var uinteger_count:int=uintegerV.length;
			
			if(uinteger_count>>>7){if(uinteger_count>>>14){if(uinteger_count>>>21){if(uinteger_count>>>28){data[offset++]=(uinteger_count&0x7f)|0x80;data[offset++]=((uinteger_count>>>7)&0x7f)|0x80;data[offset++]=((uinteger_count>>>14)&0x7f)|0x80;data[offset++]=((uinteger_count>>>21)&0x7f)|0x80;data[offset++]=uinteger_count>>>28;}else{data[offset++]=(uinteger_count&0x7f)|0x80;data[offset++]=((uinteger_count>>>7)&0x7f)|0x80;data[offset++]=((uinteger_count>>>14)&0x7f)|0x80;data[offset++]=uinteger_count>>>21;}}else{data[offset++]=(uinteger_count&0x7f)|0x80;data[offset++]=((uinteger_count>>>7)&0x7f)|0x80;data[offset++]=uinteger_count>>>14;}}else{data[offset++]=(uinteger_count&0x7f)|0x80;data[offset++]=uinteger_count>>>7;}}else{data[offset++]=uinteger_count;}
			//uinteger_count
			
			i=0;
			for each(var uinteger:int in uintegerV){
				if(i<1){
					i++;
					continue;
				}
			
				if(uinteger>>>7){if(uinteger>>>14){if(uinteger>>>21){if(uinteger>>>28){data[offset++]=(uinteger&0x7f)|0x80;data[offset++]=((uinteger>>>7)&0x7f)|0x80;data[offset++]=((uinteger>>>14)&0x7f)|0x80;data[offset++]=((uinteger>>>21)&0x7f)|0x80;data[offset++]=uinteger>>>28;}else{data[offset++]=(uinteger&0x7f)|0x80;data[offset++]=((uinteger>>>7)&0x7f)|0x80;data[offset++]=((uinteger>>>14)&0x7f)|0x80;data[offset++]=uinteger>>>21;}}else{data[offset++]=(uinteger&0x7f)|0x80;data[offset++]=((uinteger>>>7)&0x7f)|0x80;data[offset++]=uinteger>>>14;}}else{data[offset++]=(uinteger&0x7f)|0x80;data[offset++]=uinteger>>>7;}}else{data[offset++]=uinteger;}
				//uinteger
			}
			var double_count:int=doubleV.length;
			
			if(double_count>>>7){if(double_count>>>14){if(double_count>>>21){if(double_count>>>28){data[offset++]=(double_count&0x7f)|0x80;data[offset++]=((double_count>>>7)&0x7f)|0x80;data[offset++]=((double_count>>>14)&0x7f)|0x80;data[offset++]=((double_count>>>21)&0x7f)|0x80;data[offset++]=double_count>>>28;}else{data[offset++]=(double_count&0x7f)|0x80;data[offset++]=((double_count>>>7)&0x7f)|0x80;data[offset++]=((double_count>>>14)&0x7f)|0x80;data[offset++]=double_count>>>21;}}else{data[offset++]=(double_count&0x7f)|0x80;data[offset++]=((double_count>>>7)&0x7f)|0x80;data[offset++]=double_count>>>14;}}else{data[offset++]=(double_count&0x7f)|0x80;data[offset++]=double_count>>>7;}}else{data[offset++]=double_count;}
			//double_count
			
			i=0;
			data.position=offset;
			for each(var double:Number in doubleV){
				if(i<1){
					i++;
					continue;
				}
				data.writeDouble(double);
			}
			offset=data.length;
			var string_count:int=stringV.length;
			
			if(string_count>>>7){if(string_count>>>14){if(string_count>>>21){if(string_count>>>28){data[offset++]=(string_count&0x7f)|0x80;data[offset++]=((string_count>>>7)&0x7f)|0x80;data[offset++]=((string_count>>>14)&0x7f)|0x80;data[offset++]=((string_count>>>21)&0x7f)|0x80;data[offset++]=string_count>>>28;}else{data[offset++]=(string_count&0x7f)|0x80;data[offset++]=((string_count>>>7)&0x7f)|0x80;data[offset++]=((string_count>>>14)&0x7f)|0x80;data[offset++]=string_count>>>21;}}else{data[offset++]=(string_count&0x7f)|0x80;data[offset++]=((string_count>>>7)&0x7f)|0x80;data[offset++]=string_count>>>14;}}else{data[offset++]=(string_count&0x7f)|0x80;data[offset++]=string_count>>>7;}}else{data[offset++]=string_count;}
			//string_count
			
			i=0;
			for each(var string:String in stringV){
				if(i<1){
					i++;
					continue;
				}
				var set_str_data:ByteArray=new ByteArray();
				set_str_data.writeUTFBytes(string);
				var set_str_size:int=set_str_data.length;
				if(set_str_size>>>7){if(set_str_size>>>14){if(set_str_size>>>21){if(set_str_size>>>28){data[offset++]=(set_str_size&0x7f)|0x80;data[offset++]=((set_str_size>>>7)&0x7f)|0x80;data[offset++]=((set_str_size>>>14)&0x7f)|0x80;data[offset++]=((set_str_size>>>21)&0x7f)|0x80;data[offset++]=set_str_size>>>28;}else{data[offset++]=(set_str_size&0x7f)|0x80;data[offset++]=((set_str_size>>>7)&0x7f)|0x80;data[offset++]=((set_str_size>>>14)&0x7f)|0x80;data[offset++]=set_str_size>>>21;}}else{data[offset++]=(set_str_size&0x7f)|0x80;data[offset++]=((set_str_size>>>7)&0x7f)|0x80;data[offset++]=set_str_size>>>14;}}else{data[offset++]=(set_str_size&0x7f)|0x80;data[offset++]=set_str_size>>>7;}}else{data[offset++]=set_str_size;}
				//set_str_size
				data.position=offset;
				data.writeBytes(set_str_data);
				offset=data.length;
				set_str_size
			}
			data.position=offset;
			data.writeBytes(restDatas.toData());
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		override public function toXML(xmlName:String):XML{
			var xml:XML=<{xmlName} class="ABCFileWithSimpleConstant_pool"
				minor_version={minor_version}
				major_version={major_version}
			/>;
			if(integerV.length){
				var listXML:XML=<integerList count={integerV.length}/>
				var i:int=0;
				for each(var integer:int in integerV){
					if(i<1){
						i++;
						continue;
					}
					listXML.appendChild(<integer value={integer}/>);
				}
				xml.appendChild(listXML);
			}
			if(uintegerV.length){
				listXML=<uintegerList count={uintegerV.length}/>
				i=0;
				for each(var uinteger:int in uintegerV){
					if(i<1){
						i++;
						continue;
					}
					listXML.appendChild(<uinteger value={uinteger}/>);
				}
				xml.appendChild(listXML);
			}
			if(doubleV.length){
				listXML=<doubleList count={doubleV.length}/>
				i=0;
				for each(var double:Number in doubleV){
					if(i<1){
						i++;
						continue;
					}
					listXML.appendChild(<double value={double}/>);
				}
				xml.appendChild(listXML);
			}
			if(stringV.length){
				listXML=<stringList count={stringV.length}/>
				i=0;
				for each(var string:String in stringV){
					if(i<1){
						i++;
						continue;
					}
					listXML.appendChild(<string value={string/*要求10.1.52.14或以上的播放器 或 2.0.2.12610 以上的 air 才能正确的处理 "\x00"*/}/>);
				}
				xml.appendChild(listXML);
			}
			xml.appendChild(restDatas.toXML("restDatas"));
			return xml;
		}
		override public function initByXML(xml:XML):void{
			minor_version=int(xml.@minor_version.toString());
			major_version=int(xml.@major_version.toString());
			if(xml.integerList.length()){
				var listXML:XML=xml.integerList[0];
				var integerXMLList:XMLList=listXML.integer;
			
				if(integerXMLList.length()){
					var i:int=0;
					integerV=new Vector.<int>(integerXMLList.length()+1);
					for each(var integerXML:XML in integerXMLList){
						i++;
						integerV[i]=int(integerXML.@value.toString());
					}
				}else{
					integerV=new Vector.<int>();
				}
			}else{
				integerV=new Vector.<int>();
			}
			if(xml.uintegerList.length()){
				listXML=xml.uintegerList[0];
				var uintegerXMLList:XMLList=listXML.uinteger;
			
				if(uintegerXMLList.length()){
					i=0;
					uintegerV=new Vector.<int>(uintegerXMLList.length()+1);
					for each(var uintegerXML:XML in uintegerXMLList){
						i++;
						uintegerV[i]=int(uintegerXML.@value.toString());
					}
				}else{
					uintegerV=new Vector.<int>();
				}
			}else{
				uintegerV=new Vector.<int>();
			}
			if(xml.doubleList.length()){
				listXML=xml.doubleList[0];
				var doubleXMLList:XMLList=listXML.double;
			
				if(doubleXMLList.length()){
					i=0;
					doubleV=new Vector.<Number>(doubleXMLList.length()+1);
					for each(var doubleXML:XML in doubleXMLList){
						i++;
						doubleV[i]=Number(doubleXML.@value.toString());
					}
				}else{
					doubleV=new Vector.<Number>();
				}
			}else{
				doubleV=new Vector.<Number>();
			}
			if(xml.stringList.length()){
				listXML=xml.stringList[0];
				var stringXMLList:XMLList=listXML.string;
			
				if(stringXMLList.length()){
					i=0;
					stringV=new Vector.<String>(stringXMLList.length()+1);
					for each(var stringXML:XML in stringXMLList){
						i++;
						stringV[i]=stringXML.@value.toString();
					}
				}else{
					stringV=new Vector.<String>();
				}
			}else{
				stringV=new Vector.<String>();
			}
			restDatas=new BytesData();
			restDatas.initByXML(xml.restDatas[0]);
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
