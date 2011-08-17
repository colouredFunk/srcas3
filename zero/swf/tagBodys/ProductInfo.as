/***
ProductInfo
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年7月5日 13:52:16（代码生成器 V2.0.0 F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/
//其中swf_tag 41为ProductInfo tag 其中记录了通过flex sdk的相关版本信息其格式如下：
//ProductID (UI32)
//0: Unknown
//1: Macromedia Flex for J2EE
//2: Macromedia Flex for .NET
//3: Adobe Flex
//Edition (UI32)
//0: Developer Edition
//1: Full Commercial Edition
//2: Non Commercial Edition
//3: Educational Edition
//4: Not For Resale (NFR) Edition
//5: Trial Edition
//6: None
//MajorVersion (UI8)
//MinorVersion (UI8)
//BuildLow (UI32)
//BuildHigh (UI32)
//CompilationDate (UI64)
//Milliseconds since 1.1.1970
package zero.swf.tagBodys{
	import zero.swf.tagBodys.ProductIDAndEditions;
	import flash.utils.ByteArray;
	public class ProductInfo{//implements I_zero_swf_CheckCodesRight{
		public var ProductID:uint;						//UI32
		public var Edition:uint;						//UI32
		public var MajorVersion:int;					//UI8
		public var MinorVersion:int;					//UI8
		public var BuildLow:uint;						//UI32
		public var BuildHigh:uint;						//UI32
		public var CompilationDate:Number;				//UI64
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object/*zero_swf_InitByDataOptions*/):int{
			ProductID=data[offset++]|(data[offset++]<<8)|(data[offset++]<<16)|(data[offset++]<<24);
			Edition=data[offset++]|(data[offset++]<<8)|(data[offset++]<<16)|(data[offset++]<<24);
			MajorVersion=data[offset++];
			MinorVersion=data[offset++];
			BuildLow=data[offset++]|(data[offset++]<<8)|(data[offset++]<<16)|(data[offset++]<<24);
			BuildHigh=data[offset++]|(data[offset++]<<8)|(data[offset++]<<16)|(data[offset++]<<24);
			CompilationDate=
				(
					data[offset++]|
					(data[offset++]<<8)|
					(data[offset++]<<16)
				)
				+data[offset++]*16777216
				+data[offset++]*4294967296
				+data[offset++]*1099511627776
				+data[offset++]*281474976710656
				+data[offset++]*72057594037927940;
			return offset;
		}
		public function toData(_toDataOptions:Object/*zero_swf_ToDataOptions*/):ByteArray{
			var data:ByteArray=new ByteArray();
			data[0]=ProductID;
			data[1]=ProductID>>8;
			data[2]=ProductID>>16;
			data[3]=ProductID>>24;
			data[4]=Edition;
			data[5]=Edition>>8;
			data[6]=Edition>>16;
			data[7]=Edition>>24;
			data[8]=MajorVersion;
			data[9]=MinorVersion;
			data[10]=BuildLow;
			data[11]=BuildLow>>8;
			data[12]=BuildLow>>16;
			data[13]=BuildLow>>24;
			data[14]=BuildHigh;
			data[15]=BuildHigh>>8;
			data[16]=BuildHigh>>16;
			data[17]=BuildHigh>>24;
			data[18]=CompilationDate;
			data[19]=CompilationDate>>8;
			data[20]=CompilationDate>>16;
			data[21]=CompilationDate/16777216
			data[22]=CompilationDate/4294967296;
			data[23]=CompilationDate/1099511627776;
			data[24]=CompilationDate/281474976710656;
			data[25]=CompilationDate/72057594037927940;
			return data;
		}

		////
		CONFIG::USE_XML{
		public function toXML(xmlName:String,_toXMLOptions:Object/*zero_swf_ToXMLOptions*/):XML{
			return <{xmlName} class="zero.swf.tagBodys.ProductInfo"
				ProductID={ProductIDAndEditions.productIDV[ProductID]}
				Edition={ProductIDAndEditions.editionV[Edition]}
				MajorVersion={MajorVersion}
				MinorVersion={MinorVersion}
				BuildLow={BuildLow}
				BuildHigh={BuildHigh}
				CompilationDate={new Date(CompilationDate)}
			/>;
		}
		public function initByXML(xml:XML,_initByXMLOptions:Object/*zero_swf_InitByXMLOptions*/):void{
			ProductID=ProductIDAndEditions[xml.@ProductID.toString()];
			Edition=ProductIDAndEditions[xml.@Edition.toString()];
			MajorVersion=int(xml.@MajorVersion.toString());
			MinorVersion=int(xml.@MinorVersion.toString());
			BuildLow=uint(xml.@BuildLow.toString());
			BuildHigh=uint(xml.@BuildHigh.toString());
			CompilationDate=new Date(xml.@CompilationDate.toString()).time;
		}
		}//end of CONFIG::USE_XML
	}
}
