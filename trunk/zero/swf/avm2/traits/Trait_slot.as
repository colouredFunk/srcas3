/***
Trait_slot 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月19日 18:58:12 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
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

//This field exists only when vindex is non-zero. It is used to determine how vindex will be interpreted.
//See the "Constant Kind" table above for details.
package zero.swf.avm2.traits{
	import zero.swf.vmarks.ConstantKind;
	import flash.utils.ByteArray;
	public class Trait_slot extends Trait{
		public var slot_id:int;							//u30
		public var type_name:int;						//u30
		public var vindex:int;							//u30
		public var vkind:int;							//u8
		//
		override public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			//#offsetpp
			if(data[offset]>>>7){
				if(data[offset+1]>>>7){
					if(data[offset+2]>>>7){
						if(data[offset+3]>>>7){
							slot_id=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);
						}else{
							slot_id=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);
						}
					}else{
						slot_id=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);
					}
				}else{
					slot_id=(data[offset++]&0x7f)|(data[offset++]<<7);
				}
			}else{
				slot_id=data[offset++];
			}
			//
			//#offsetpp
			
			if(data[offset]>>>7){
				if(data[offset+1]>>>7){
					if(data[offset+2]>>>7){
						if(data[offset+3]>>>7){
							type_name=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);
						}else{
							type_name=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);
						}
					}else{
						type_name=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);
					}
				}else{
					type_name=(data[offset++]&0x7f)|(data[offset++]<<7);
				}
			}else{
				type_name=data[offset++];
			}
			//
			//#offsetpp
			
			if(data[offset]>>>7){
				if(data[offset+1]>>>7){
					if(data[offset+2]>>>7){
						if(data[offset+3]>>>7){
							vindex=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);
						}else{
							vindex=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);
						}
					}else{
						vindex=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);
					}
				}else{
					vindex=(data[offset++]&0x7f)|(data[offset++]<<7);
				}
			}else{
				vindex=data[offset++];
			}
			//
			//#offsetpp
			
			if(vindex){
				vkind=data[offset++];
			}
			return offset;
		}
		override public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			//var offset:int=0;//测试
			//#offsetpp
			var offset:int=0;
			if(slot_id>>>7){
				if(slot_id>>>14){
					if(slot_id>>>21){
						if(slot_id>>>28){
							data[offset++]=(slot_id&0x7f)|0x80;
							data[offset++]=((slot_id>>>7)&0x7f)|0x80;
							data[offset++]=((slot_id>>>14)&0x7f)|0x80;
							data[offset++]=((slot_id>>>21)&0x7f)|0x80;
							data[offset++]=slot_id>>>28;
						}else{
							data[offset++]=(slot_id&0x7f)|0x80;
							data[offset++]=((slot_id>>>7)&0x7f)|0x80;
							data[offset++]=((slot_id>>>14)&0x7f)|0x80;
							data[offset++]=slot_id>>>21;
						}
					}else{
						data[offset++]=(slot_id&0x7f)|0x80;
						data[offset++]=((slot_id>>>7)&0x7f)|0x80;
						data[offset++]=slot_id>>>14;
					}
				}else{
					data[offset++]=(slot_id&0x7f)|0x80;
					data[offset++]=slot_id>>>7;
				}
			}else{
				data[offset++]=slot_id;
			}
			//
			//#offsetpp
			
			if(type_name>>>7){
				if(type_name>>>14){
					if(type_name>>>21){
						if(type_name>>>28){
							data[offset++]=(type_name&0x7f)|0x80;
							data[offset++]=((type_name>>>7)&0x7f)|0x80;
							data[offset++]=((type_name>>>14)&0x7f)|0x80;
							data[offset++]=((type_name>>>21)&0x7f)|0x80;
							data[offset++]=type_name>>>28;
						}else{
							data[offset++]=(type_name&0x7f)|0x80;
							data[offset++]=((type_name>>>7)&0x7f)|0x80;
							data[offset++]=((type_name>>>14)&0x7f)|0x80;
							data[offset++]=type_name>>>21;
						}
					}else{
						data[offset++]=(type_name&0x7f)|0x80;
						data[offset++]=((type_name>>>7)&0x7f)|0x80;
						data[offset++]=type_name>>>14;
					}
				}else{
					data[offset++]=(type_name&0x7f)|0x80;
					data[offset++]=type_name>>>7;
				}
			}else{
				data[offset++]=type_name;
			}
			//
			//#offsetpp
			
			if(vindex>>>7){
				if(vindex>>>14){
					if(vindex>>>21){
						if(vindex>>>28){
							data[offset++]=(vindex&0x7f)|0x80;
							data[offset++]=((vindex>>>7)&0x7f)|0x80;
							data[offset++]=((vindex>>>14)&0x7f)|0x80;
							data[offset++]=((vindex>>>21)&0x7f)|0x80;
							data[offset++]=vindex>>>28;
						}else{
							data[offset++]=(vindex&0x7f)|0x80;
							data[offset++]=((vindex>>>7)&0x7f)|0x80;
							data[offset++]=((vindex>>>14)&0x7f)|0x80;
							data[offset++]=vindex>>>21;
						}
					}else{
						data[offset++]=(vindex&0x7f)|0x80;
						data[offset++]=((vindex>>>7)&0x7f)|0x80;
						data[offset++]=vindex>>>14;
					}
				}else{
					data[offset++]=(vindex&0x7f)|0x80;
					data[offset++]=vindex>>>7;
				}
			}else{
				data[offset++]=vindex;
			}
			//
			if(vindex){
				data[offset++]=vkind;
			}
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		override public function toXML():XML{
			var xml:XML=<Trait_slot
				slot_id={slot_id}
				type_name={type_name}
				vindex={vindex}
				vkind={ConstantKind.kindV[vkind]}
			/>;
			if(vindex){
				
			}else{
				delete xml.@vkind;
			}
			return xml;
		}
		override public function initByXML(xml:XML):void{
			slot_id=int(xml.@slot_id.toString());
			type_name=int(xml.@type_name.toString());
			vindex=int(xml.@vindex.toString());
			if(vindex){
				vkind=ConstantKind[xml.@vkind.toString()];
			}
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
