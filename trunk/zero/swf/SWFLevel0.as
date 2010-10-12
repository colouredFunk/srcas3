/***
SWFLevel0 版本:v1.0
简要说明:0级的SWF编码解码, 支持获取和修改 type, Version, FrameSize( wid 和 hei), FrameRate, 解析出每个 tag 的类型, 位置, 和长度(不含 DefineSprite 里的 tag)
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年8月11日 10:30:53
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	
	import zero.swf.tag_body.FileAttributes;
	import zero.swf.tag_body.Metadata;
	
	public class SWFLevel0{
		public function clear():void{
			dataAndTags.clear();
		}
		
		private var swfDataAndData:SWFDataAndData;
		private var dataAndBaseInfo:DataAndBaseInfo;
		public var dataAndTags:DataAndTags;
		
		public function SWFLevel0(){
			swfDataAndData=new SWFDataAndData();
			dataAndBaseInfo=new DataAndBaseInfo();
			dataAndTags=new DataAndTags();
		}
		public function copyBaseInfo(swf0:SWFLevel0):void{
			type=swf0.type;
			Version=swf0.Version;
			wid=swf0.wid;
			hei=swf0.hei;
			FrameRate=swf0.FrameRate;
			
			acceleration=swf0.acceleration;
			isAS3=swf0.isAS3;
			accessNetworkOnly=swf0.accessNetworkOnly;
			metadataStr=swf0.metadataStr;
		}
		//
		public function get type():String{
			return swfDataAndData.type;
		}
		public function set type(_type:String):void{
			swfDataAndData.type=_type;
		}
		public function get Version():int{
			return swfDataAndData.Version;
		}
		public function set Version(_Version:int):void{
			swfDataAndData.Version=_Version;
		}
		
		//
		public function get wid():int{
			return (dataAndBaseInfo.FrameSize.Xmax-dataAndBaseInfo.FrameSize.Xmin)/20;//获取到的值是以堤为单位, 1堤等于20像素, 所以要除以20
		}
		public function set wid(_wid:int):void{
			dataAndBaseInfo.FrameSize.Xmax=_wid*20+dataAndBaseInfo.FrameSize.Xmin;
		}
		public function get hei():int{
			return (dataAndBaseInfo.FrameSize.Ymax-dataAndBaseInfo.FrameSize.Ymin)/20;//获取到的值是以堤为单位, 1堤等于20像素, 所以要除以20
		}
		public function set hei(_hei:int):void{
			dataAndBaseInfo.FrameSize.Ymax=_hei*20+dataAndBaseInfo.FrameSize.Ymin;
		}
		public function get FrameRate():Number{
			return dataAndBaseInfo.FrameRate;
		}
		public function set FrameRate(_FrameRate:Number):void{
			dataAndBaseInfo.FrameRate=_FrameRate;
		}
		
		//
		private var fileAttributesTag:Tag;
		private var metadataTag:Tag;
		
		private var acceleration:String;//direct 和 gpu 在文档和实际情况中好像是倒过来的...
		private static const ACC_NORMAL:String="normal ";
		private static const ACC_DIRECT:String="direct";
		private static const ACC_GPU:String="gpu";
		public var isAS3:Boolean;
		public var accessNetworkOnly:Boolean;
		public var metadataStr:String;
		
		private var progress_finished:Function;
		
		//
		public function initBySWFData(swfData:ByteArray):void{
			initByData(swfDataAndData.swfData2Data(swfData));
		}
		public function initByData(data:ByteArray):void{
			dataAndBaseInfo.initByData(data);
			dataAndTags.initByData(data,dataAndBaseInfo.offset,data.length);
			tags2Infos();
		}
		public function tags2Infos():void{
			acceleration=ACC_NORMAL;
			isAS3=false;
			accessNetworkOnly=false;
			metadataStr="";
			fileAttributesTag=null;
			metadataTag=null;
			for each(var tag:Tag in dataAndTags.tagV){
				switch(tag.type){
					case TagType.FileAttributes:
						var fileAttributes:FileAttributes;
						if(tag.tagBody){
							fileAttributes=tag.tagBody as FileAttributes;
						}else{
							fileAttributes=new FileAttributes();
							fileAttributes.initByData(tag.bodyData,tag.bodyOffset,tag.bodyOffset+tag.bodyLength);
						}
						
						if(fileAttributes.UseDirectBlit){
							acceleration=ACC_DIRECT;
						}else if(fileAttributes.UseGPU){
							acceleration=ACC_GPU;
						}else{
							acceleration=ACC_NORMAL;
						}
						
						isAS3=(fileAttributes.ActionScript3==1);
						accessNetworkOnly=(fileAttributes.UseNetwork==1);
						fileAttributesTag=tag;
						fileAttributesTag.tagBody=fileAttributes;
					break;
					case TagType.Metadata:
						var metadata:Metadata;
						if(tag.tagBody){
							metadata=tag.tagBody as Metadata;
						}else{
							metadata=new Metadata();
							metadata.initByData(tag.bodyData,tag.bodyOffset,tag.bodyOffset+tag.bodyLength);
						}
						
						metadataStr=metadata.metadata;
						metadataTag=tag;
						metadataTag.tagBody=metadata;
					break;
				}
			}
		}
		public function infos2Tags():void{
			///*
			var tagId:int=dataAndTags.tagV.length;
			while(--tagId>=0){
				var tag:Tag=dataAndTags.tagV[tagId];
				switch(tag.type){
					case TagType.FileAttributes:
					case TagType.Metadata:
						dataAndTags.tagV.splice(tagId,1);
					break;
				}
			}
			//*/
			
			var fileAttributes:FileAttributes=new FileAttributes();
			switch(acceleration){
				case ACC_NORMAL:
					fileAttributes.UseDirectBlit=0;
					fileAttributes.UseGPU=0;
				break;
				case ACC_DIRECT:
					fileAttributes.UseDirectBlit=1;
					fileAttributes.UseGPU=0;
				break;
				case ACC_GPU:
					fileAttributes.UseDirectBlit=0;
					fileAttributes.UseGPU=1;
				break;
			}
			if(isAS3){
				if(Version<9){
					throw new Error("Version="+Version+", 不支持AS3");
					//Version=9;
				}else{
					fileAttributes.ActionScript3=1;
				}
			}else{
				fileAttributes.ActionScript3=0;
			}
			fileAttributes.UseNetwork=(accessNetworkOnly?1:0);
			
			if(metadataStr){
				fileAttributes.HasMetadata=1;
				var metadata:Metadata=new Metadata();
				metadata.metadata=metadataStr;
				if(!metadataTag){
					metadataTag=new Tag();
				}
				metadataTag.tagBody=metadata;
				dataAndTags.tagV.unshift(metadataTag);
			}else{
				fileAttributes.HasMetadata=0;
			}
			
			if(Version>=8){
				if(!fileAttributesTag){
					fileAttributesTag=new Tag();
				}
				fileAttributesTag.tagBody=fileAttributes;
				dataAndTags.tagV.unshift(fileAttributesTag);
			}
		}
		
		private var newData:ByteArray;
		public function toSWFData():ByteArray{
			prevToData();
			
			insertResTags();
			
			newData.writeBytes(dataAndTags.toData());
			var _newData:ByteArray=newData;
			newData=null;
			return swfDataAndData.data2SWFData(_newData);
		}
		
		public function prevToData():void{
			newData=new ByteArray();
			dataAndBaseInfo.getData(newData);
			newData.position=newData.length;
			
			infos2Tags();
		}
		
		public function toSWFData2(progress_start:Function,progress_progress:Function,_progress_finished:Function):void{
			prevToData();
			
			insertResTags();
			
			progress_finished=_progress_finished;
			dataAndTags.toData2(
				progress_start,
				progress_progress,
				toSWFData2_finished
			);
		}
		private function toSWFData2_finished(dataAndTagsNewData:ByteArray):void{
			newData.writeBytes(dataAndTagsNewData);
			
			var _progress_finished:Function=progress_finished;
			progress_finished=null;
			var _newData:ByteArray=newData;
			newData=null;
			_progress_finished(swfDataAndData.data2SWFData(_newData));
		}
		
		CONFIG::toXMLAndInitByXML{
		private var xml:XML;
		private function getXML(fileName:String):void{
			xml=<SWF fileName={fileName} type={type} Version={Version} FileLength={swfDataAndData.FileLength} wid={wid} hei={hei} FrameRate={FrameRate}/>;
			if(dataAndBaseInfo.FrameSize.Xmin===0){
			}else{
				xml.@left=dataAndBaseInfo.FrameSize.Xmin/20;
			}
			if(dataAndBaseInfo.FrameSize.Ymin===0){
			}else{
				xml.@top=dataAndBaseInfo.FrameSize.Ymin/20;
			}
		}
		public function toXML(fileName:String):XML{
			infos2Tags();
			
			insertResTags();
			
			getXML(fileName);
			
			xml.appendChild(dataAndTags.toXML());
			return xml;
		}
		public function toXML2(fileName:String,progress_start:Function,progress_progress:Function,_progress_finished:Function):void{
			infos2Tags();
			
			insertResTags();
			
			getXML(fileName);
			
			progress_finished=_progress_finished;
			dataAndTags.toXML2(
				progress_start,
				progress_progress,
				toXML2_finished
			);
		}
		private function toXML2_finished(dataAndTagsXML:XML):void{
			var _progress_finished:Function=progress_finished;
			progress_finished=null;
			xml.appendChild(dataAndTagsXML);
			_progress_finished(xml);
		}
		private function initFrameSizeByXML(xml:XML):void{
			var leftStr:String=xml.@left.toString();
			if(leftStr){
				dataAndBaseInfo.FrameSize.Xmin=int(leftStr)*20;
			}
			var topStr:String=xml.@top.toString();
			if(topStr){
				dataAndBaseInfo.FrameSize.Ymin=int(topStr)*20;
			}
			wid=int(xml.@wid.toString());
			hei=int(xml.@hei.toString());
		}
		public function initByXML(xml:XML):void{
			type=xml.@type.toString();
			Version=int(xml.@Version.toString());
			initFrameSizeByXML(xml);
			
			FrameRate=Number(xml.@FrameRate.toString());
			dataAndTags.initByXML(xml.tags[0]);
			
			tags2Infos();
		}
		public function initByXML2(xml:XML,progress_start:Function,progress_progress:Function,_progress_finished:Function):void{
			type=xml.@type.toString();
			Version=int(xml.@Version.toString());
			initFrameSizeByXML(xml);
			
			FrameRate=Number(xml.@FrameRate.toString());
			
			progress_finished=_progress_finished;
			
			dataAndTags.initByXML2(
				xml.tags[0],
				progress_start,
				progress_progress,
				initByXMLL2_finished
			);
		}
		private function initByXMLL2_finished():void{
			var _progress_finished:Function=progress_finished;
			progress_finished=null;
			
			tags2Infos();
			
			_progress_finished();
		}
		}//end of CONFIG::toXMLAndInitByXML
		
		
		
		private var resInserter:*;
		public function insertRes(
			resData:ByteArray,
			className:String,
			type:String,
			addSymbolClass:Boolean=false
		):void{
			if(resInserter){
			}else{
				try{
					var ResInserterClass:Class=getDefinitionByName("zero.swf.ResInserter") as Class;
				}catch(e:Error){
					throw new Error("未编译: zero.swf.ResInserter");
				}
				resInserter=new ResInserterClass(dataAndTags.tagV);
			}
			
			resInserter.insert(
				resData,
				className,
				type,
				addSymbolClass
			)
		}
		private function insertResTags():void{
			if(resInserter){
				var endTag:Tag=dataAndTags.tagV.pop();
				var lastShowFrameTag:Tag=dataAndTags.tagV.pop();
				dataAndTags.tagV=dataAndTags.tagV.concat(resInserter.getTagVAndReset());
				dataAndTags.tagV.push(lastShowFrameTag);
				dataAndTags.tagV.push(endTag);
			}
		}
	}
}

//

// 常忘正则表达式
// /^\s*|\s*$/					//前后空白						"\nabc d  e 哈 哈\t \r".replace(/^\s*|\s*$/g,"") === "abc d  e 哈 哈"
// /[\\\/:*?\"<>|]/				//不合法的windows文件名字符集		"\\\/:*?\"<>|\\\/:*哈 哈?\"<>|\\哈 \/:*?\"<>|".replace(/[\\\/:*?\"<>|]/g,"") === "哈 哈哈 "
// /[a-zA-Z_][a-zA-Z0-9_]*/		//合法的变量名(不考虑中文)
// value=value.replace(/[^a-zA-Z0-9_]/g,"").replace(/^[0-9]*/,"");//替换不合法的变量名
// 先把除字母数字下划线的字符去掉,再把开头的数字去掉
// 想不到怎样能用一个正则表达式搞定...

//正则表达式30分钟入门教程		http://www.unibetter.com/deerchao/zhengzhe-biaodashi-jiaocheng-se.htm
//正则表达式用法及实例			http://eskimo.blogbus.com/logs/29095458.html
//常用正则表达式					http://www.williamlong.info/archives/433.html

/*

//常用值

//常用语句块

*/