/***
Code_u30_u30 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年11月9日 08:59:40 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf.avm2.codes{
	import zero.swf.avm2.AVM2Op;
	import flash.utils.ByteArray;
	public class Code_u30_u30 extends Code{
		public var op:int;								//u8
		public var u30_1:int;							//u30
		public var u30_2:int;							//u30
		//
		override public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			op=data[offset];
			++offset;
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){u30_1=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{u30_1=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{u30_1=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{u30_1=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{u30_1=data[offset++];}
			//u30_1
			
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){u30_2=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{u30_2=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{u30_2=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{u30_2=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{u30_2=data[offset++];}
			//u30_2
			return offset;
		}
		override public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			data[0]=op;
			var offset:int=1;
			if(u30_1>>>7){if(u30_1>>>14){if(u30_1>>>21){if(u30_1>>>28){data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=((u30_1>>>14)&0x7f)|0x80;data[offset++]=((u30_1>>>21)&0x7f)|0x80;data[offset++]=u30_1>>>28;}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=((u30_1>>>14)&0x7f)|0x80;data[offset++]=u30_1>>>21;}}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=((u30_1>>>7)&0x7f)|0x80;data[offset++]=u30_1>>>14;}}else{data[offset++]=(u30_1&0x7f)|0x80;data[offset++]=u30_1>>>7;}}else{data[offset++]=u30_1;}
			//u30_1
			
			if(u30_2>>>7){if(u30_2>>>14){if(u30_2>>>21){if(u30_2>>>28){data[offset++]=(u30_2&0x7f)|0x80;data[offset++]=((u30_2>>>7)&0x7f)|0x80;data[offset++]=((u30_2>>>14)&0x7f)|0x80;data[offset++]=((u30_2>>>21)&0x7f)|0x80;data[offset++]=u30_2>>>28;}else{data[offset++]=(u30_2&0x7f)|0x80;data[offset++]=((u30_2>>>7)&0x7f)|0x80;data[offset++]=((u30_2>>>14)&0x7f)|0x80;data[offset++]=u30_2>>>21;}}else{data[offset++]=(u30_2&0x7f)|0x80;data[offset++]=((u30_2>>>7)&0x7f)|0x80;data[offset++]=u30_2>>>14;}}else{data[offset++]=(u30_2&0x7f)|0x80;data[offset++]=u30_2>>>7;}}else{data[offset++]=u30_2;}
			//u30_2
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		override public function toXML(xmlName:String):XML{
			return <{xmlName} class="Code_u30_u30"
				op={AVM2Op.opNameV[op]}
				u30_1={u30_1}
				u30_2={u30_2}
			/>;
		}
		override public function initByXML(xml:XML):void{
			op=AVM2Op[xml.@op.toString()];
			u30_1=int(xml.@u30_1.toString());
			u30_2=int(xml.@u30_2.toString());
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
