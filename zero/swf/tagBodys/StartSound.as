/***
StartSound 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年12月12日 17:58:22 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
//StartSound is a control tag that either starts (or stops) playing a sound defined by
//DefineSound. The SoundId field identifies which sound is to be played. The SoundInfo field
//defines how the sound is played. Stop a sound by setting the SyncStop flag in the
//SOUNDINFO record.
//
//The minimum file format version is SWF 1.
//
//StartSound
//Field 			Type 			Comment
//Header 			RECORDHEADER 	Tag type = 15.
//SoundId 			UI16 			ID of sound character to play.
//SoundInfo 		SOUNDINFO 		Sound style information.
package zero.swf.tagBodys{
	import zero.swf.BytesData;
	import flash.utils.ByteArray;
	public class StartSound{
		public var SoundId:int;							//UI16
		public var restDatas:BytesData;
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			SoundId=data[offset]|(data[offset+1]<<8);
			offset+=2;
			restDatas=new BytesData();
			return restDatas.initByData(data,offset,endOffset);
		}
		public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			data[0]=SoundId;
			data[1]=SoundId>>8;
			data.position=2;
			data.writeBytes(restDatas.toData());
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		public function toXML(xmlName:String):XML{
			var xml:XML=<{xmlName} class="StartSound"
				SoundId={SoundId}
			/>;
			xml.appendChild(restDatas.toXML("restDatas"));
			return xml;
		}
		public function initByXML(xml:XML):void{
			SoundId=int(xml.@SoundId.toString());
			restDatas=new BytesData();
			restDatas.initByXML(xml.restDatas[0]);
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
