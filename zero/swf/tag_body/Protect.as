/***
Protect 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年9月1日 14:30:52 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
//Field 		Type 								Comment
//Header 		RECORDHEADER 						Tag type = xx
//Reserved 		UI16 								Always 0
//Password 		Null-terminated STRING.(0 is NULL)	MD5-encrypted password
package zero.swf.tag_body{
	import flash.utils.ByteArray;
	public class Protect extends TagBody{
		public var password:String;				//Password
		//
		override public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			if(endOffset-offset==31){
				data.position=offset+2;
				password=data.readUTFBytes(28);
				return endOffset;
			}
			password="";
			return offset;
		}
		override public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			//var offset:int=0;//测试
			if(password){
				data[0]=0x00;
				data[1]=0x00;
				data.position=2;
				data.writeUTFBytes(password);
				data[data.length]=0;//字符串结束
			}
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		override public function toXML():XML{
			return <Protect
				password={password}
			/>;
		}
		override public function initByXML(xml:XML):void{
			password=xml.@password.toString();
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
