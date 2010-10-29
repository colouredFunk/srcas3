/***
EnableDebugger 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月20日 15:01:30 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
//Field 		Type 								Comment
//Header 		RECORDHEADER 						Tag type = xx
//Reserved 		UI16 								Always 0
//Password 		Null-terminated STRING.(0 is NULL)	MD5-encrypted password
package zero.swf.tagBodys{
	import flash.utils.ByteArray;
	public class EnableDebugger{
		public var password:String;						//Password
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			if(endOffset-offset==31){
				data.position=offset+2;
				password=data.readUTFBytes(28);
				return endOffset;
			}
			password="";
			return offset;
		}
		public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			if(password){
				data.writeUTFBytes("\x00\x00"+password+"\x00");
			}
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		public function toXML():XML{
			return <EnableDebugger
				password={password}
			/>;
		}
		public function initByXML(xml:XML):void{
			password=xml.@password.toString();
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
