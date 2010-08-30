/***
DefineSceneAndFrameLabelData 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年8月30日 13:39:33 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
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

	import zero.BytesAndStr16;
	import zero.gettersetter.UGetterAndSetter;
	import zero.swf.BytesData;

	public class DefineSceneAndFrameLabelData extends TagBody{
		public var SceneCount:int;				//EncodedU32
		public var OffsetV:Vector.<int>;		
		public var NameV:Vector.<String>;		
		public var FrameLabelCount:int;			//EncodedU32
		public var FrameNumV:Vector.<int>;		
		public var FrameLabelV:Vector.<String>;	
		
		//
		override public function initByData(data:ByteArray,offset:int,endOffset:int):void{
			SceneCount=UGetterAndSetter.getU(data,offset);
			offset=UGetterAndSetter.offset;
			OffsetV=new Vector.<int>();
			NameV=new Vector.<String>();
			for(var i:int=0;i<SceneCount;i++){
				OffsetV[i]=UGetterAndSetter.getU(data,offset);
				offset=UGetterAndSetter.offset;
				var strSize:int=1;
				if(data[offset]){
					while(data[offset+(strSize++)]){};
					data.position=offset;
					NameV[i]=data.readUTFBytes(strSize);
				}else{
					NameV[i]="";
				}
				offset+=strSize;
				
			}
			FrameLabelCount=UGetterAndSetter.getU(data,offset);
			offset=UGetterAndSetter.offset;
			FrameNumV=new Vector.<int>();
			FrameLabelV=new Vector.<String>();
			for(var i:int=0;i<FrameLabelCount;i++){
				FrameNumV[i]=UGetterAndSetter.getU(data,offset);
				offset=UGetterAndSetter.offset;
				strSize=1;
				if(data[offset]){
					while(data[offset+(strSize++)]){};
					data.position=offset;
					FrameLabelV[i]=data.readUTFBytes(strSize);
				}else{
					FrameLabelV[i]="";
				}
				offset+=strSize;
				
			}
			
		}
		override public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			SceneCount=OffsetV.length;
			FrameLabelCount=FrameNumV.length;
			UGetterAndSetter.setU(SceneCount,data,0);
			var offset:int=UGetterAndSetter.offset;
			for(var i:int=0;i<SceneCount;i++){
				UGetterAndSetter.setU(OffsetV[i],data,offset);
				data.position=UGetterAndSetter.offset;
				data.writeUTFBytes(NameV[i]);
				offset=data.length;
				data[offset++]=0;//字符串结束
				
				
			}
			UGetterAndSetter.setU(FrameLabelCount,data,offset);
			offset=UGetterAndSetter.offset;
			for(var i:int=0;i<FrameLabelCount;i++){
				UGetterAndSetter.setU(FrameNumV[i],data,offset);
				data.position=UGetterAndSetter.offset;
				data.writeUTFBytes(FrameLabelV[i]);
				offset=data.length;
				data[offset]=0;//字符串结束
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
			var listXML:XML=xml.list[0];
			for(var i:int=0;i<FrameLabelCount;i++){
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
			var listXML:XML=xml.list[0];
			var FrameNumXMLList:XMLList=listXML.FrameNum;
			FrameNumV=new Vector.<int>();
			var FrameLabelXMLList:XMLList=listXML.FrameLabel;
			FrameLabelV=new Vector.<String>();
			FrameLabelCount=FrameNumXMLList.length();
			for(var i:int=0;i<FrameLabelCount;i++){
				FrameNumV[i]=int(FrameNumXMLList[i].@value.toString());
				FrameLabelV[i]=FrameLabelXMLList[i].@value.toString();
				
			}
			
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}

