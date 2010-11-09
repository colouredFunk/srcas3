/***
Code_debug 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年11月9日 09:06:04 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf.avm2.codes{
	import zero.swf.avm2.AVM2Op;
	import flash.utils.ByteArray;
	public class Code_debug extends Code{
		public var op:int;								//u8
		public var debug_type:int;						//u8
		public var index:int;							//u30
		public var reg:int;								//u8
		public var extra:int;							//u30
		//
		override public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			op=data[offset];
			debug_type=data[offset+1];
			offset+=2;
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){index=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{index=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{index=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{index=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{index=data[offset++];}
			//index
			reg=data[offset++];
			
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){extra=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{extra=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{extra=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{extra=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{extra=data[offset++];}
			//extra
			return offset;
		}
		override public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			data[0]=op;
			data[1]=debug_type;
			var offset:int=2;
			if(index>>>7){if(index>>>14){if(index>>>21){if(index>>>28){data[offset++]=(index&0x7f)|0x80;data[offset++]=((index>>>7)&0x7f)|0x80;data[offset++]=((index>>>14)&0x7f)|0x80;data[offset++]=((index>>>21)&0x7f)|0x80;data[offset++]=index>>>28;}else{data[offset++]=(index&0x7f)|0x80;data[offset++]=((index>>>7)&0x7f)|0x80;data[offset++]=((index>>>14)&0x7f)|0x80;data[offset++]=index>>>21;}}else{data[offset++]=(index&0x7f)|0x80;data[offset++]=((index>>>7)&0x7f)|0x80;data[offset++]=index>>>14;}}else{data[offset++]=(index&0x7f)|0x80;data[offset++]=index>>>7;}}else{data[offset++]=index;}
			//index
			data[offset++]=reg;
			
			if(extra>>>7){if(extra>>>14){if(extra>>>21){if(extra>>>28){data[offset++]=(extra&0x7f)|0x80;data[offset++]=((extra>>>7)&0x7f)|0x80;data[offset++]=((extra>>>14)&0x7f)|0x80;data[offset++]=((extra>>>21)&0x7f)|0x80;data[offset++]=extra>>>28;}else{data[offset++]=(extra&0x7f)|0x80;data[offset++]=((extra>>>7)&0x7f)|0x80;data[offset++]=((extra>>>14)&0x7f)|0x80;data[offset++]=extra>>>21;}}else{data[offset++]=(extra&0x7f)|0x80;data[offset++]=((extra>>>7)&0x7f)|0x80;data[offset++]=extra>>>14;}}else{data[offset++]=(extra&0x7f)|0x80;data[offset++]=extra>>>7;}}else{data[offset++]=extra;}
			//extra
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		override public function toXML(xmlName:String):XML{
			return <{xmlName} class="Code_debug"
				op={AVM2Op.opNameV[op]}
				debug_type={debug_type}
				index={index}
				reg={reg}
				extra={extra}
			/>;
		}
		override public function initByXML(xml:XML):void{
			op=AVM2Op[xml.@op.toString()];
			debug_type=int(xml.@debug_type.toString());
			index=int(xml.@index.toString());
			reg=int(xml.@reg.toString());
			extra=int(xml.@extra.toString());
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
