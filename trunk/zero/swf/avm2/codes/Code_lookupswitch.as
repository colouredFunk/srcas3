/***
Code_lookupswitch 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年11月9日 09:06:04 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf.avm2.codes{
	import zero.swf.avm2.AVM2Op;
	import flash.utils.ByteArray;
	public class Code_lookupswitch extends Code{
		public var op:int;								//u8
		public var default_offset:int;					//s24
		public var case_offsetV:Vector.<int>;
		//
		override public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			op=data[offset];
			default_offset+1=data[offset+1]|(data[offset+2]<<8)|(data[offset+3]<<16);
			if(default_offset+4&0x00008000){default_offset+4|=0xffff0000}//最高位为1,表示负数
			offset+=4;
			
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){var case_count:int=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{case_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{case_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{case_count=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{case_count=data[offset++];}
			//case_count
			case_offsetV=new Vector.<int>(case_count);
			for(var i:int=0;i<case_count;i++){
			
				if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){case_offsetV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{case_offsetV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{case_offsetV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{case_offsetV[i]=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{case_offsetV[i]=data[offset++];}
				//case_offsetV[i]
			}
			return offset;
		}
		override public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			data[0]=op;
			data[1]=default_2;
			data[2]=default_3>>8;
			data[3]=default_4>>16;
			var case_count:int=case_4V.length;
			var offset:int=4;
			if(case_count>>>7){if(case_count>>>14){if(case_count>>>21){if(case_count>>>28){data[offset++]=(case_count&0x7f)|0x80;data[offset++]=((case_count>>>7)&0x7f)|0x80;data[offset++]=((case_count>>>14)&0x7f)|0x80;data[offset++]=((case_count>>>21)&0x7f)|0x80;data[offset++]=case_count>>>28;}else{data[offset++]=(case_count&0x7f)|0x80;data[offset++]=((case_count>>>7)&0x7f)|0x80;data[offset++]=((case_count>>>14)&0x7f)|0x80;data[offset++]=case_count>>>21;}}else{data[offset++]=(case_count&0x7f)|0x80;data[offset++]=((case_count>>>7)&0x7f)|0x80;data[offset++]=case_count>>>14;}}else{data[offset++]=(case_count&0x7f)|0x80;data[offset++]=case_count>>>7;}}else{data[offset++]=case_count;}
			//case_count
			
			for each(var case_offset:int in case_offsetV){
			
				if(case_offset>>>7){if(case_offset>>>14){if(case_offset>>>21){if(case_offset>>>28){data[offset++]=(case_offset&0x7f)|0x80;data[offset++]=((case_offset>>>7)&0x7f)|0x80;data[offset++]=((case_offset>>>14)&0x7f)|0x80;data[offset++]=((case_offset>>>21)&0x7f)|0x80;data[offset++]=case_offset>>>28;}else{data[offset++]=(case_offset&0x7f)|0x80;data[offset++]=((case_offset>>>7)&0x7f)|0x80;data[offset++]=((case_offset>>>14)&0x7f)|0x80;data[offset++]=case_offset>>>21;}}else{data[offset++]=(case_offset&0x7f)|0x80;data[offset++]=((case_offset>>>7)&0x7f)|0x80;data[offset++]=case_offset>>>14;}}else{data[offset++]=(case_offset&0x7f)|0x80;data[offset++]=case_offset>>>7;}}else{data[offset++]=case_offset;}
				//case_offset
			}
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		override public function toXML(xmlName:String):XML{
			var xml:XML=<{xmlName} class="Code_lookupswitch"
				op={AVM2Op.opNameV[op]}
				default_offset={default_offset}
			/>;
			if(case_offsetV.length){
				var listXML:XML=<case_offsetList count={case_offsetV.length}/>
				for each(var case_offset:int in case_offsetV){
					listXML.appendChild(<case_offset value={case_offset}/>);
				}
				xml.appendChild(listXML);
			}
			return xml;
		}
		override public function initByXML(xml:XML):void{
			op=AVM2Op[xml.@op.toString()];
			default_offset=int(xml.@default_offset.toString());
			if(xml.case_offsetList.length()){
				var listXML:XML=xml.case_offsetList[0];
				var case_offsetXMLList:XMLList=listXML.case_offset;
				var i:int=-1;
				case_offsetV=new Vector.<int>(case_offsetXMLList.length());
				for each(var case_offsetXML:XML in case_offsetXMLList){
					i++;
					case_offsetV[i]=int(case_offsetXML.@value.toString());
				}
			}else{
				case_offsetV=new Vector.<int>();
			}
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
