/***
DefineSceneAndFrameLabelData 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年8月31日 14:09:47 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
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
//Offset1 			EncodedU32 			Frame offset for scene 1
//Name1 				STRING 				Name of scene 1
//... ... ...
//OffsetN 			EncodedU32 			Frame offset for scene N
//NameN 				STRING 				Name of scene N
//FrameLabelCount 	EncodedU32 			Number of frame labels
//FrameNum1 			EncodedU32 			Frame number of frame label #1 (zero-based, global to symbol)
//FrameLabel1 		STRING 				Frame label string of frame label #1
//... ... ...
//FrameNumN 			EncodedU32 			Frame number of frame label #N (zero-based, global to symbol)
//FrameLabelN 		STRING 				Frame label string of frame label #N
package zero.swf.tag_body{
	import flash.utils.ByteArray;
	public class DefineSceneAndFrameLabelData extends TagBody{
		public var SceneCount:int;				//EncodedU32
		public var OffsetV:Vector.<int>;		
		public var NameV:Vector.<String>;		
		public var FrameLabelCount:int;			//EncodedU32
		public var FrameNumV:Vector.<int>;		
		public var FrameLabelV:Vector.<String>;	
		//
		override public function initByData(data:ByteArray,offset:int,endOffset:int):void{
			//#offsetpp
			var get_u_value:int=0;
			var get_u_step:int=0;
			do{
				get_u_value=data[offset++];
				get_u_value|=((get_u_value&0x7f)<<get_u_step);// get_u_value & 0111 1111
				get_u_step+=7;
			}while(get_u_value&0x80);// get_u_value & 1000 0000
			SceneCount=get_u_value;
			//
			OffsetV=new Vector.<int>();
			NameV=new Vector.<String>();
			//#offsetpp
			for(var i:int=0;i<SceneCount;i++){
				//#offsetpp
				get_u_value=0;
				get_u_step=0;
				do{
					get_u_value=data[offset++];
					get_u_value|=((get_u_value&0x7f)<<get_u_step);// get_u_value & 0111 1111
					get_u_step+=7;
				}while(get_u_value&0x80);// get_u_value & 1000 0000
				OffsetV[i]=get_u_value;
				//
				var get_str_size:int=0;
				while(data[offset+(get_str_size++)]){}
				data.position=offset;
				NameV[i]=data.readUTFBytes(get_str_size);
				offset+=get_str_size;
			}
			//#offsetpp
			get_u_value=0;
			get_u_step=0;
			do{
				get_u_value=data[offset++];
				get_u_value|=((get_u_value&0x7f)<<get_u_step);// get_u_value & 0111 1111
				get_u_step+=7;
			}while(get_u_value&0x80);// get_u_value & 1000 0000
			FrameLabelCount=get_u_value;
			//
			FrameNumV=new Vector.<int>();
			FrameLabelV=new Vector.<String>();
			//#offsetpp
			for(i=0;i<FrameLabelCount;i++){
				//#offsetpp
				get_u_value=0;
				get_u_step=0;
				do{
					get_u_value=data[offset++];
					get_u_value|=((get_u_value&0x7f)<<get_u_step);// get_u_value & 0111 1111
					get_u_step+=7;
				}while(get_u_value&0x80);// get_u_value & 1000 0000
				FrameNumV[i]=get_u_value;
				//
				get_str_size=0;
				while(data[offset+(get_str_size++)]){}
				data.position=offset;
				FrameLabelV[i]=data.readUTFBytes(get_str_size);
				offset+=get_str_size;
			}
		}
		override public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			//var offset:int=0;//测试
			SceneCount=OffsetV.length;
			FrameLabelCount=FrameNumV.length;
			var offset:int=0;
			//#offsetpp
			var set_u_value:int=SceneCount;
			while(true){
				var set_u_byteValue:int=set_u_value&0x7f;
				set_u_value>>>=7;
				if(set_u_value){
					data[offset++]=0x80|set_u_byteValue;
				}else{
					data[offset++]=set_u_byteValue;
					break;
				}
			}
			//
			//#offsetpp
			for(var i:int=0;i<SceneCount;i++){
				//#offsetpp
				set_u_value=OffsetV[i];
				while(true){
					set_u_byteValue=set_u_value&0x7f;
					set_u_value>>>=7;
					if(set_u_value){
						data[offset++]=0x80|set_u_byteValue;
					}else{
						data[offset++]=set_u_byteValue;
						break;
					}
				}
				//
				data.position=offset;
				data.writeUTFBytes(NameV[i]);
				offset=data.length;
				data[offset++]=0;//字符串结束
			}
			//#offsetpp
			set_u_value=FrameLabelCount;
			while(true){
				set_u_byteValue=set_u_value&0x7f;
				set_u_value>>>=7;
				if(set_u_value){
					data[offset++]=0x80|set_u_byteValue;
				}else{
					data[offset++]=set_u_byteValue;
					break;
				}
			}
			//
			//#offsetpp
			for(i=0;i<FrameLabelCount;i++){
				//#offsetpp
				set_u_value=FrameNumV[i];
				while(true){
					set_u_byteValue=set_u_value&0x7f;
					set_u_value>>>=7;
					if(set_u_value){
						data[offset++]=0x80|set_u_byteValue;
					}else{
						data[offset++]=set_u_byteValue;
						break;
					}
				}
				//
				data.position=offset;
				data.writeUTFBytes(FrameLabelV[i]);
				offset=data.length;
				data[offset++]=0;//字符串结束
			}
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		override public function toXML():XML{
			SceneCount=OffsetV.length;
			FrameLabelCount=FrameNumV.length;
			var xml:XML=<DefineSceneAndFrameLabelData
				SceneCount={SceneCount}
				FrameLabelCount={FrameLabelCount}
			>
				<list vNames="OffsetV,NameV" count={SceneCount}/>
				<list vNames="FrameNumV,FrameLabelV" count={FrameLabelCount}/>
			</DefineSceneAndFrameLabelData>;
			var listXML:XML=xml.list[0];
			for(var i:int=0;i<SceneCount;i++){
				listXML.appendChild(<Offset value={OffsetV[i]}/>);
				listXML.appendChild(<Name value={NameV[i]}/>);
			}
			listXML=xml.list[1];
			for(i=0;i<FrameLabelCount;i++){
				listXML.appendChild(<FrameNum value={FrameNumV[i]}/>);
				listXML.appendChild(<FrameLabel value={FrameLabelV[i]}/>);
			}
			return xml;
		}
		override public function initByXML(xml:XML):void{
			SceneCount=int(xml.@SceneCount.toString());
			var listXML:XML=xml.list[0];
			var OffsetXMLList:XMLList=listXML.Offset;
			OffsetV=new Vector.<int>();
			var NameXMLList:XMLList=listXML.Name;
			NameV=new Vector.<String>();
			SceneCount=OffsetXMLList.length();
			for(var i:int=0;i<SceneCount;i++){
				OffsetV[i]=int(OffsetXMLList[i].@value.toString());
				NameV[i]=NameXMLList[i].@value.toString();
			}
			FrameLabelCount=int(xml.@FrameLabelCount.toString());
			listXML=xml.list[1];
			var FrameNumXMLList:XMLList=listXML.FrameNum;
			FrameNumV=new Vector.<int>();
			var FrameLabelXMLList:XMLList=listXML.FrameLabel;
			FrameLabelV=new Vector.<String>();
			FrameLabelCount=FrameNumXMLList.length();
			for(i=0;i<FrameLabelCount;i++){
				FrameNumV[i]=int(FrameNumXMLList[i].@value.toString());
				FrameLabelV[i]=FrameLabelXMLList[i].@value.toString();
			}
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
