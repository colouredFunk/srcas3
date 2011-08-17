/***
Protect
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年7月5日 13:52:16（代码生成器 V2.0.0 F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/
//Field 		Type 								Comment
//Header 		RECORDHEADER 						Tag type = xx
//Reserved 		UI16 								Always 0
//Password 		Null-terminated STRING.(0 is NULL)	MD5-encrypted password
package zero.swf.tagBodys{
	import flash.utils.ByteArray;
	public class Protect{//implements I_zero_swf_CheckCodesRight{
		public var password:String;						//Password
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object/*zero_swf_InitByDataOptions*/):int{
			if(endOffset-offset==31){
				data.position=offset+2;
				password=data.readUTFBytes(28);
				return endOffset;
			}
			password="";
			return offset;
		}
		public function toData(_toDataOptions:Object/*zero_swf_ToDataOptions*/):ByteArray{
			var data:ByteArray=new ByteArray();
			if(password){
				data.writeUTFBytes("\x00\x00"+password+"\x00");
			}
			return data;
		}

		////
		CONFIG::USE_XML{
		public function toXML(xmlName:String,_toXMLOptions:Object/*zero_swf_ToXMLOptions*/):XML{
			return <{xmlName} class="zero.swf.tagBodys.Protect"
				password={password}
			/>;
		}
		public function initByXML(xml:XML,_initByXMLOptions:Object/*zero_swf_InitByXMLOptions*/):void{
			password=xml.@password.toString();
		}
		}//end of CONFIG::USE_XML
	}
}
