/***
DoAction 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年8月31日 13:29:02 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
//DoAction instructs Flash Player to perform a list of actions when the current frame is
//complete. The actions are performed when the ShowFrame tag is encountered, regardless of
//where in the frame the DoAction tag appears.
//Starting with SWF 9, if the ActionScript3 field of the FileAttributes tag is 1, the contents of
//the DoAction tag will be ignored.

//Field 			Type 							Comment
//Header 			RECORDHEADER 					Tag type = 12
//Actions 			ACTIONRECORD [zero or more] 	List of actions to perform (see following table, ActionRecord)
//ActionEndFlag 	UI8 = 0 						Always set to 0
package zero.swf.tag_body{

	import flash.utils.ByteArray;

	import zero.BytesAndStr16;
	import zero.swf.BytesData;

	public class DoAction extends TagBody{
		public var Actions:BytesData;			
		//
		override public function initByData(data:ByteArray,offset:int,endOffset:int):void{
			Actions=new BytesData();
			Actions.initByData(data,offset,endOffset-1);
			//offset=endOffset-1;//ActionEndFlag
		}
		override public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			//var offset:int=0;//测试
			data.writeBytes(Actions.toData());
			data[data.length]=0x00;//ActionEndFlag
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		override public function toXML():XML{
			var xml:XML=<DoAction>
				<Actions/>
			</DoAction>;
			xml.Actions.appendChild(Actions.toXML());
			return xml;
		}
		override public function initByXML(xml:XML):void{
			Actions=new BytesData();
			Actions.initByXML(xml.Actions.children()[0]);
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
