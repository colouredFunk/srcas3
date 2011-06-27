/***
StartSound2
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月15日 13:32:48（代码生成器 V1.1.0 F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/
//StartSound2
//StartSound is a control tag that either starts (or stops) playing a sound defined by
//DefineSound. The SoundId field identifies which sound is to be played. The SoundInfo field
//defines how the sound is played. Stop a sound by setting the SyncStop flag in the
//SOUNDINFO record.
//The minimum file format version is SWF 9. Supported in Flash Player 9.0.45.0 and later.

//StartSound
//Field 			Type 			Comment
//Header 			RECORDHEADER 	Tag type = 89.
//SoundClassName 	STRING 			Name of the sound class to play.
//SoundInfo 		SOUNDINFO 		Sound style information.
package zero.swf.tagBodys{
	import zero.swf.BytesData;
	import flash.utils.ByteArray;
	public class StartSound2{//implements I_zero_swf_CheckCodesRight{
		public var SoundClassName:String;				//STRING
		public var restDatas:BytesData;
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object/*zero_swf_InitByDataOptions*/):int{
			var get_str_size:int=0;
			while(data[offset+(get_str_size++)]){}
			data.position=offset;
			SoundClassName=data.readUTFBytes(get_str_size);
			offset+=get_str_size;
			
			restDatas=new BytesData();
			return restDatas.initByData(data,offset,endOffset,_initByDataOptions);
		}
		public function toData(_toDataOptions:Object/*zero_swf_ToDataOptions*/):ByteArray{
			var data:ByteArray=new ByteArray();
			data.writeUTFBytes(SoundClassName+"\x00");
			data.writeBytes(restDatas.toData(_toDataOptions));
			return data;
		}

		////
		CONFIG::USE_XML{
		public function toXML(xmlName:String,_toXMLOptions:Object/*zero_swf_ToXMLOptions*/):XML{
			var xml:XML=<{xmlName} class="StartSound2"
				SoundClassName={SoundClassName}
			/>;
			xml.appendChild(restDatas.toXML("restDatas",_toXMLOptions));
			return xml;
		}
		public function initByXML(xml:XML,_initByXMLOptions:Object/*zero_swf_InitByXMLOptions*/):void{
			SoundClassName=xml.@SoundClassName.toString();
			restDatas=new BytesData();
			restDatas.initByXML(xml.restDatas[0],_initByXMLOptions);
		}
		}//end of CONFIG::USE_XML
	}
}
