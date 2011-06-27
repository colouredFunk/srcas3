/***
DefineSceneAndFrameLabelData
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月15日 13:32:48（代码生成器 V1.1.0 F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/
//DefineSceneAndFrameLabelData
//The DefineSceneAndFrameLabelData tag contains scene and frame label data for a
//MovieClip. Scenes are supported for the main timeline only, for all other movie clips a single
//scene is exported.
//
//DefineSceneAndFrameLabelData
//Field 				Type 				Comment
//Header 				RECORDHEADER 		Tag type = 86
//SceneCount 			EncodedU32 			Number of scenes
//Offset1 				EncodedU32 			Frame offset for scene 1
//Name1 				STRING 				Name of scene 1
//... ... ...
//OffsetN 				EncodedU32 			Frame offset for scene N
//NameN 				STRING 				Name of scene N
//FrameLabelCount 		EncodedU32 			Number of frame labels
//FrameNum1 			EncodedU32 			Frame number of frame label #1 (zero-based, global to symbol)
//FrameLabel1 			STRING 				Frame label string of frame label #1
//... ... ...
//FrameNumN 			EncodedU32 			Frame number of frame label #N (zero-based, global to symbol)
//FrameLabelN 			STRING 				Frame label string of frame label #N
package zero.swf.tagBodys{
	import flash.utils.ByteArray;
	public class DefineSceneAndFrameLabelData{//implements I_zero_swf_CheckCodesRight{
		public var OffsetV:Vector.<int>;
		public var NameV:Vector.<String>;
		public var FrameNumV:Vector.<int>;
		public var FrameLabelV:Vector.<String>;
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object/*zero_swf_InitByDataOptions*/):int{
			//#offsetpp
			
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){var SceneCount:int=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{SceneCount=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{SceneCount=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{SceneCount=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{SceneCount=data[offset++];}
			//SceneCount
			OffsetV=new Vector.<int>(SceneCount);
			NameV=new Vector.<String>(SceneCount);
			for(var i:int=0;i<SceneCount;i++){
			
				if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){OffsetV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{OffsetV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{OffsetV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{OffsetV[i]=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{OffsetV[i]=data[offset++];}
				//OffsetV[i]
			
				var get_str_size:int=0;
				while(data[offset+(get_str_size++)]){}
				data.position=offset;
				NameV[i]=data.readUTFBytes(get_str_size);
				offset+=get_str_size;
			}
			
			
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){var FrameLabelCount:int=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{FrameLabelCount=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{FrameLabelCount=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{FrameLabelCount=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{FrameLabelCount=data[offset++];}
			//FrameLabelCount
			FrameNumV=new Vector.<int>(FrameLabelCount);
			FrameLabelV=new Vector.<String>(FrameLabelCount);
			for(i=0;i<FrameLabelCount;i++){
			
				if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){FrameNumV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{FrameNumV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{FrameNumV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{FrameNumV[i]=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{FrameNumV[i]=data[offset++];}
				//FrameNumV[i]
			
				get_str_size=0;
				while(data[offset+(get_str_size++)]){}
				data.position=offset;
				FrameLabelV[i]=data.readUTFBytes(get_str_size);
				offset+=get_str_size;
			}
			return offset;
		}
		public function toData(_toDataOptions:Object/*zero_swf_ToDataOptions*/):ByteArray{
			var data:ByteArray=new ByteArray();
			var SceneCount:int=OffsetV.length;
			var offset:int=0;
			if(SceneCount>>>7){if(SceneCount>>>14){if(SceneCount>>>21){if(SceneCount>>>28){data[offset++]=(SceneCount&0x7f)|0x80;data[offset++]=((SceneCount>>>7)&0x7f)|0x80;data[offset++]=((SceneCount>>>14)&0x7f)|0x80;data[offset++]=((SceneCount>>>21)&0x7f)|0x80;data[offset++]=SceneCount>>>28;}else{data[offset++]=(SceneCount&0x7f)|0x80;data[offset++]=((SceneCount>>>7)&0x7f)|0x80;data[offset++]=((SceneCount>>>14)&0x7f)|0x80;data[offset++]=SceneCount>>>21;}}else{data[offset++]=(SceneCount&0x7f)|0x80;data[offset++]=((SceneCount>>>7)&0x7f)|0x80;data[offset++]=SceneCount>>>14;}}else{data[offset++]=(SceneCount&0x7f)|0x80;data[offset++]=SceneCount>>>7;}}else{data[offset++]=SceneCount;}
			//SceneCount
			
			var i:int=-1;
			for each(var Offset:int in OffsetV){
				i++;
			
				if(Offset>>>7){if(Offset>>>14){if(Offset>>>21){if(Offset>>>28){data[offset++]=(Offset&0x7f)|0x80;data[offset++]=((Offset>>>7)&0x7f)|0x80;data[offset++]=((Offset>>>14)&0x7f)|0x80;data[offset++]=((Offset>>>21)&0x7f)|0x80;data[offset++]=Offset>>>28;}else{data[offset++]=(Offset&0x7f)|0x80;data[offset++]=((Offset>>>7)&0x7f)|0x80;data[offset++]=((Offset>>>14)&0x7f)|0x80;data[offset++]=Offset>>>21;}}else{data[offset++]=(Offset&0x7f)|0x80;data[offset++]=((Offset>>>7)&0x7f)|0x80;data[offset++]=Offset>>>14;}}else{data[offset++]=(Offset&0x7f)|0x80;data[offset++]=Offset>>>7;}}else{data[offset++]=Offset;}
				//Offset
				data.position=offset;
				data.writeUTFBytes(NameV[i]+"\x00");
				offset=data.length;
			}
			var FrameLabelCount:int=FrameNumV.length;
			
			if(FrameLabelCount>>>7){if(FrameLabelCount>>>14){if(FrameLabelCount>>>21){if(FrameLabelCount>>>28){data[offset++]=(FrameLabelCount&0x7f)|0x80;data[offset++]=((FrameLabelCount>>>7)&0x7f)|0x80;data[offset++]=((FrameLabelCount>>>14)&0x7f)|0x80;data[offset++]=((FrameLabelCount>>>21)&0x7f)|0x80;data[offset++]=FrameLabelCount>>>28;}else{data[offset++]=(FrameLabelCount&0x7f)|0x80;data[offset++]=((FrameLabelCount>>>7)&0x7f)|0x80;data[offset++]=((FrameLabelCount>>>14)&0x7f)|0x80;data[offset++]=FrameLabelCount>>>21;}}else{data[offset++]=(FrameLabelCount&0x7f)|0x80;data[offset++]=((FrameLabelCount>>>7)&0x7f)|0x80;data[offset++]=FrameLabelCount>>>14;}}else{data[offset++]=(FrameLabelCount&0x7f)|0x80;data[offset++]=FrameLabelCount>>>7;}}else{data[offset++]=FrameLabelCount;}
			//FrameLabelCount
			
			i=-1;
			for each(var FrameNum:int in FrameNumV){
				i++;
			
				if(FrameNum>>>7){if(FrameNum>>>14){if(FrameNum>>>21){if(FrameNum>>>28){data[offset++]=(FrameNum&0x7f)|0x80;data[offset++]=((FrameNum>>>7)&0x7f)|0x80;data[offset++]=((FrameNum>>>14)&0x7f)|0x80;data[offset++]=((FrameNum>>>21)&0x7f)|0x80;data[offset++]=FrameNum>>>28;}else{data[offset++]=(FrameNum&0x7f)|0x80;data[offset++]=((FrameNum>>>7)&0x7f)|0x80;data[offset++]=((FrameNum>>>14)&0x7f)|0x80;data[offset++]=FrameNum>>>21;}}else{data[offset++]=(FrameNum&0x7f)|0x80;data[offset++]=((FrameNum>>>7)&0x7f)|0x80;data[offset++]=FrameNum>>>14;}}else{data[offset++]=(FrameNum&0x7f)|0x80;data[offset++]=FrameNum>>>7;}}else{data[offset++]=FrameNum;}
				//FrameNum
				data.position=offset;
				data.writeUTFBytes(FrameLabelV[i]+"\x00");
				offset=data.length;
			}
			return data;
		}

		////
		CONFIG::USE_XML{
		public function toXML(xmlName:String,_toXMLOptions:Object/*zero_swf_ToXMLOptions*/):XML{
			var xml:XML=<{xmlName} class="DefineSceneAndFrameLabelData"/>;
			if(OffsetV.length){
				var listXML:XML=<OffsetAndNameList count={OffsetV.length}/>
				var i:int=-1;
				for each(var Offset:int in OffsetV){
					i++;
					listXML.appendChild(<Offset value={Offset}/>);
					listXML.appendChild(<Name value={NameV[i]}/>);
				}
				xml.appendChild(listXML);
			}
			if(FrameNumV.length){
				listXML=<FrameNumAndFrameLabelList count={FrameNumV.length}/>
				i=-1;
				for each(var FrameNum:int in FrameNumV){
					i++;
					listXML.appendChild(<FrameNum value={FrameNum}/>);
					listXML.appendChild(<FrameLabel value={FrameLabelV[i]}/>);
				}
				xml.appendChild(listXML);
			}
			return xml;
		}
		public function initByXML(xml:XML,_initByXMLOptions:Object/*zero_swf_InitByXMLOptions*/):void{
			if(xml.OffsetAndNameList.length()){
				var listXML:XML=xml.OffsetAndNameList[0];
				var OffsetXMLList:XMLList=listXML.Offset;
				var NameXMLList:XMLList=listXML.Name;
				var i:int=-1;
				OffsetV=new Vector.<int>(OffsetXMLList.length());
				NameV=new Vector.<String>(NameXMLList.length());
				for each(var OffsetXML:XML in OffsetXMLList){
					i++;
					OffsetV[i]=int(OffsetXML.@value.toString());
					NameV[i]=NameXMLList[i].@value.toString();
				}
			}else{
				OffsetV=new Vector.<int>();
				NameV=new Vector.<String>();
			}
			if(xml.FrameNumAndFrameLabelList.length()){
				listXML=xml.FrameNumAndFrameLabelList[0];
				var FrameNumXMLList:XMLList=listXML.FrameNum;
				var FrameLabelXMLList:XMLList=listXML.FrameLabel;
				i=-1;
				FrameNumV=new Vector.<int>(FrameNumXMLList.length());
				FrameLabelV=new Vector.<String>(FrameLabelXMLList.length());
				for each(var FrameNumXML:XML in FrameNumXMLList){
					i++;
					FrameNumV[i]=int(FrameNumXML.@value.toString());
					FrameLabelV[i]=FrameLabelXMLList[i].@value.toString();
				}
			}else{
				FrameNumV=new Vector.<int>();
				FrameLabelV=new Vector.<String>();
			}
		}
		}//end of CONFIG::USE_XML
	}
}
