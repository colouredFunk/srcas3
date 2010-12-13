/***
DefineButtonSound 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年12月12日 19:54:38 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
//DefineButtonSound
//The DefineButtonSound tag defines which sounds (if any) are played on state transitions.
//
//The minimum file format version is SWF 2.
//
//DefineButtonSound
//Field 				Type 										Comment
//Header 				RECORDHEADER 								Tag type = 17
//ButtonId 				UI16 										The ID of the button these sounds apply to.
//ButtonSoundChar0 		UI16 										Sound ID for OverUpToIdle
//ButtonSoundInfo0 		SOUNDINFO (if ButtonSoundChar0 is nonzero)	Sound style for OverUpToIdle
//ButtonSoundChar1 		UI16 										Sound ID for IdleToOverUp
//ButtonSoundInfo1 		SOUNDINFO (if ButtonSoundChar1 is nonzero)	Sound style for IdleToOverUp
//ButtonSoundChar2 		UI16 										Sound ID for OverUpToOverDown
//ButtonSoundInfo2 		SOUNDINFO (if ButtonSoundChar2 is nonzero)	Sound style for OverUpToOverDown
//ButtonSoundChar3 		UI16 										Sound ID for OverDownToOverUp
//ButtonSoundInfo3 		SOUNDINFO (if ButtonSoundChar3 is nonzero)	Sound style for OverDownToOverUp
package zero.swf.tagBodys{
	import zero.swf.records.SOUNDINFO;
	import flash.utils.ByteArray;
	public class DefineButtonSound{
		public var ButtonId:int;						//UI16
		public var ButtonSoundChar0:int;				//UI16
		public var ButtonSoundInfo0:SOUNDINFO;
		public var ButtonSoundChar1:int;				//UI16
		public var ButtonSoundInfo1:SOUNDINFO;
		public var ButtonSoundChar2:int;				//UI16
		public var ButtonSoundInfo2:SOUNDINFO;
		public var ButtonSoundChar3:int;				//UI16
		public var ButtonSoundInfo3:SOUNDINFO;
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			ButtonId=data[offset]|(data[offset+1]<<8);
			ButtonSoundChar0=data[offset+2]|(data[offset+3]<<8);
			offset+=4;
			if(ButtonSoundChar0){
			
				ButtonSoundInfo0=new SOUNDINFO();
				offset=ButtonSoundInfo0.initByData(data,offset,endOffset);
			}
			ButtonSoundChar1=data[offset++]|(data[offset++]<<8);
			
			if(ButtonSoundChar1){
			
				ButtonSoundInfo1=new SOUNDINFO();
				offset=ButtonSoundInfo1.initByData(data,offset,endOffset);
			}
			ButtonSoundChar2=data[offset++]|(data[offset++]<<8);
			
			if(ButtonSoundChar2){
			
				ButtonSoundInfo2=new SOUNDINFO();
				offset=ButtonSoundInfo2.initByData(data,offset,endOffset);
			}
			ButtonSoundChar3=data[offset++]|(data[offset++]<<8);
			
			if(ButtonSoundChar3){
			
				ButtonSoundInfo3=new SOUNDINFO();
				offset=ButtonSoundInfo3.initByData(data,offset,endOffset);
			}
			return offset;
		}
		public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			data[0]=ButtonId;
			data[1]=ButtonId>>8;
			data[2]=ButtonSoundChar0;
			data[3]=ButtonSoundChar0>>8;
			var offset:int=4;
			if(ButtonSoundChar0){
				data.position=offset;
				data.writeBytes(ButtonSoundInfo0.toData());
				offset=data.length;
			}
			data[offset++]=ButtonSoundChar1;
			data[offset++]=ButtonSoundChar1>>8;
			
			if(ButtonSoundChar1){
				data.position=offset;
				data.writeBytes(ButtonSoundInfo1.toData());
				offset=data.length;
			}
			data[offset++]=ButtonSoundChar2;
			data[offset++]=ButtonSoundChar2>>8;
			
			if(ButtonSoundChar2){
				data.position=offset;
				data.writeBytes(ButtonSoundInfo2.toData());
				offset=data.length;
			}
			data[offset++]=ButtonSoundChar3;
			data[offset++]=ButtonSoundChar3>>8;
			if(ButtonSoundChar3){
				data.position=offset;
				data.writeBytes(ButtonSoundInfo3.toData());
			}
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		public function toXML(xmlName:String):XML{
			var xml:XML=<{xmlName} class="DefineButtonSound"
				ButtonId={ButtonId}
				ButtonSoundChar0={ButtonSoundChar0}
				ButtonSoundChar1={ButtonSoundChar1}
				ButtonSoundChar2={ButtonSoundChar2}
				ButtonSoundChar3={ButtonSoundChar3}
			/>;
			if(ButtonSoundChar0){
				xml.appendChild(ButtonSoundInfo0.toXML("ButtonSoundInfo0"));
			}
			if(ButtonSoundChar1){
				xml.appendChild(ButtonSoundInfo1.toXML("ButtonSoundInfo1"));
			}
			if(ButtonSoundChar2){
				xml.appendChild(ButtonSoundInfo2.toXML("ButtonSoundInfo2"));
			}
			if(ButtonSoundChar3){
				xml.appendChild(ButtonSoundInfo3.toXML("ButtonSoundInfo3"));
			}
			return xml;
		}
		public function initByXML(xml:XML):void{
			ButtonId=int(xml.@ButtonId.toString());
			ButtonSoundChar0=int(xml.@ButtonSoundChar0.toString());
			if(ButtonSoundChar0){
				ButtonSoundInfo0=new SOUNDINFO();
				ButtonSoundInfo0.initByXML(xml.ButtonSoundInfo0[0]);
			}
			ButtonSoundChar1=int(xml.@ButtonSoundChar1.toString());
			if(ButtonSoundChar1){
				ButtonSoundInfo1=new SOUNDINFO();
				ButtonSoundInfo1.initByXML(xml.ButtonSoundInfo1[0]);
			}
			ButtonSoundChar2=int(xml.@ButtonSoundChar2.toString());
			if(ButtonSoundChar2){
				ButtonSoundInfo2=new SOUNDINFO();
				ButtonSoundInfo2.initByXML(xml.ButtonSoundInfo2[0]);
			}
			ButtonSoundChar3=int(xml.@ButtonSoundChar3.toString());
			if(ButtonSoundChar3){
				ButtonSoundInfo3=new SOUNDINFO();
				ButtonSoundInfo3.initByXML(xml.ButtonSoundInfo3[0]);
			}
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
