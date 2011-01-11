/***
SWF2 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月14日 16:26:16
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf{
	import flash.utils.ByteArray;
	
	import zero.swf.tagBodys.FileAttributes;
	import zero.swf.tagBodys.Metadata;
	
	public class SWF2 extends SWF1{
		//
		public static var baseInfoNameV:Vector.<String>;
		
		public static var TagTypeOrderV:Vector.<int>;
		
		private static var getSetValueTagBodyClasses:Vector.<Class>;
		private static var getSetValueMemberNames:Vector.<String>;
		private static var getSetValueValueNames:Vector.<String>;
		private static var getSetValueDefaultValues:Vector.<Object>;
		
		private static const firstInitResult:*=function():void{
			baseInfoNameV=Vector.<String>([
				"type","Version","x","y","width","height","FrameRate","acceleration","isAS3","accessNetworkOnly","metadataStr"
			]);
			
			TagTypeOrderV=Vector.<int>([
				//TagType.FileAttributes,
				//TagType.Metadata,
				TagType.SetBackgroundColor,
				TagType.EnableDebugger,
				TagType.EnableDebugger2,
				TagType.DebugID,
				TagType.ScriptLimits,
				TagType.ProductInfo
			]);
			
			getSetValueTagBodyClasses=new Vector.<Class>(256);
			getSetValueMemberNames=new Vector.<String>(256);
			getSetValueValueNames=new Vector.<String>(256);
			getSetValueDefaultValues=new Vector.<Object>(256);
		}();
		
		public static function addGetSetValueTagBody(
			TagBodyClass:Class,
			memberName:String,
			valueName:String,
			defaultValue:*
		):void{
			/*
			使用方法，例如添加读写背景颜色的功能：
			
			SWF2.addGetSetValueTagBody(
				SetBackgroundColor,
				"BackgroundColor",
				"bgColor",
				0xffffff
			);
			var swf:SWF2=new SWF2();
			swf.setValue("bgColor",0xff3300);
			trace("bgColor="+swf.getValue("bgColor"));
			
			*/
			
			if(TagBodyClass==Metadata||TagBodyClass==FileAttributes){
				throw new Error("TagBodyClass="+TagBodyClass+" 已经被征用");
			}
			var typeName:String=TagAndBodyClasses.getTypeNameByTagBodyOrBodyClass(TagBodyClass);
			if(typeName){
				var type:int=TagType[typeName];
				if(typeName===TagType.typeNameArr[type]){
					getSetValueTagBodyClasses[type]=TagBodyClass;
					getSetValueMemberNames[type]=memberName;
					getSetValueValueNames[type]=valueName;
					getSetValueDefaultValues[type]=defaultValue;
					return;
				}
			}
			throw new Error("TagBodyClass="+TagBodyClass+", typeName="+typeName);
		}
		
		private var getSetValueValues:Object;
		public function getValue(valueName:String):*{
			return getSetValueValues[valueName];
		}
		public function setValue(valueName:String,value:*):void{
			getSetValueValues[valueName]=value;
		}
		//private var getSetValueTags:Vector.<Tag>;
		
		public var tagV:Vector.<Tag>;
		
		private var dataAndTags:DataAndTags;
		
		public function SWF2(
			_type:String="CWS",
			_Version:int=0,
			_width:Number=800,
			_height:Number=600,
			_FrameRate:Number=30,
			_isAS3:Boolean=true,
			_accessNetworkOnly:Boolean=false,
			_metadataStr:String=null
		){
			super(_type,_Version,_width,_height,_FrameRate);
			
			isAS3=_isAS3;
			accessNetworkOnly=_accessNetworkOnly;
			metadataStr=_metadataStr;
			
			tagV=new Vector.<Tag>();
			
			//写入默认值们到 getSetValueValues
			getSetValueValues=new Object();
			var getSetValueId:int=getSetValueValueNames.length;
			while(--getSetValueId>=0){
				var valueName:String=getSetValueValueNames[getSetValueId];
				if(valueName){
					getSetValueValues[valueName]=getSetValueDefaultValues[getSetValueId];
					//trace(valueName+"="+getSetValueValues[valueName]);
				}
			}
		}
		public function clear():void{
			if(dataAndTags){
				dataAndTags.clear();
			}
		}
		
		//
		
		public var acceleration:String;//direct 和 gpu 在文档和实际情况中好像是倒过来的...
		
		private static const ACC_NORMAL:String="normal ";
		private static const ACC_DIRECT:String="direct";
		private static const ACC_GPU:String="gpu";
		
		public var isAS3:Boolean;
		public var accessNetworkOnly:Boolean;
		public var metadataStr:String;
		
		private var progress_finished:Function;
		
		//
		override public function initByData(_data:ByteArray):void{
			var data:ByteArray=initBaseInfoByData(_data);
			CurrSWFVersion.Version=Version;
			var dataAndTags:DataAndTags=new DataAndTags();
			dataAndTags.initByData(data,0,data.length);
			tagV=dataAndTags.tagV;
			
			tags2Infos();
		}
		public function tags2Infos():void{
			acceleration=ACC_NORMAL;
			isAS3=false;
			accessNetworkOnly=false;
			metadataStr="";
			for each(var tag:Tag in tagV){
				switch(tag.type){
					case TagType.FileAttributes:
						var fileAttributes:FileAttributes=tag.getBody() as FileAttributes;
						
						if(fileAttributes.UseDirectBlit){
							acceleration=ACC_DIRECT;
						}else if(fileAttributes.UseGPU){
							acceleration=ACC_GPU;
						}else{
							acceleration=ACC_NORMAL;
						}
						
						isAS3=(fileAttributes.ActionScript3==1);
						accessNetworkOnly=(fileAttributes.UseNetwork==1);
					break;
					case TagType.Metadata:
						metadataStr=(tag.getBody() as Metadata).metadata;
					break;
					default:
						var valueName:String=getSetValueValueNames[tag.type];
						if(valueName){
							//trace("valueName="+valueName);
							getSetValueValues[valueName]=tag.getBody()[getSetValueMemberNames[tag.type]];
						}
					break;
				}
			}
		}
		public function infos2Tags():void{
			///*
			var tagId:int=tagV.length;
			var tag:Tag;
			while(--tagId>=0){
				tag=tagV[tagId];
				switch(tag.type){
					case TagType.FileAttributes:
					case TagType.Metadata:
						tagV.splice(tagId,1);
					break;
					default:
						if(getSetValueTagBodyClasses[tag.type]){
							tagV.splice(tagId,1);
						}
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
			
			var getSetValueTags:Vector.<Tag>=new Vector.<Tag>(TagTypeOrderV.length);
			var getSetValueId:int=getSetValueValueNames.length;
			while(--getSetValueId>=0){
				var valueName:String=getSetValueValueNames[getSetValueId];
				if(valueName){
					tag=new Tag();
					tag.setBody(new getSetValueTagBodyClasses[getSetValueId]());
					tag.getBody()[getSetValueMemberNames[getSetValueId]]=getSetValueValues[valueName];
					var tagOrderId:int=TagTypeOrderV.indexOf(tag.type);
					if(tagOrderId==-1){
						getSetValueTags.push(tag);
					}else{
						getSetValueTags[tagOrderId]=tag;
					}
				}
			}
			
			var i:int=getSetValueTags.length;
			while(--i>=0){
				tag=getSetValueTags[i];
				if(tag){
					tagV.unshift(tag);
				}
			}
			
			if(metadataStr){
				fileAttributes.HasMetadata=1;
				tag=new Tag();
				tag.setBody(new Metadata());
				(tag.getBody() as Metadata).metadata=metadataStr;
				tagV.unshift(tag);
			}else{
				fileAttributes.HasMetadata=0;
			}
			
			//if(Version>=8){
			if(
				fileAttributes.UseDirectBlit
				||
				fileAttributes.UseGPU
				||
				fileAttributes.HasMetadata
				||
				fileAttributes.ActionScript3
				||
				fileAttributes.UseNetwork
			){
				tag=new Tag();
				tag.setBody(fileAttributes);
				tagV.unshift(tag);
			}
		}
		
		override public function toData():ByteArray{
			infos2Tags();
			
			//updateInsertedRes();
			
			var data:ByteArray=baseInfo2Data();
			data.position=data.length;
			CurrSWFVersion.Version=Version;
			var dataAndTags:DataAndTags=new DataAndTags();
			dataAndTags.tagV=tagV;
			
			data.writeBytes(dataAndTags.toData());
			return data;
		}
		public function toSWFData2(progress_start:Function,progress_progress:Function,_progress_finished:Function):void{
			infos2Tags();
			
			//updateInsertedRes();
			
			data=baseInfo2Data();
			data.position=data.length;
			CurrSWFVersion.Version=Version;
			dataAndTags=new DataAndTags();
			dataAndTags.tagV=tagV;
			
			progress_finished=_progress_finished;
			dataAndTags.toData2(
				progress_start,
				progress_progress,
				toSWFData2_finished
			);
		}
		private function toSWFData2_finished(dataAndTagsNewData:ByteArray):void{
			data.writeBytes(dataAndTagsNewData);
			
			var _progress_finished:Function=progress_finished;
			progress_finished=null;
			dataAndTags=null;
			var _data:ByteArray=data;
			data=null;
			_progress_finished(data2SWFData(_data));
		}
		
		CONFIG::toXMLAndInitByXML{
		private var xml:XML;
		private function getXML():void{
			xml=<SWF type={type} Version={Version} FileLength={FileLength} width={width} height={height} FrameRate={FrameRate}/>;
			if(x===0){
			}else{
				xml.@x=x;
			}
			if(y===0){
			}else{
				xml.@y=y;
			}
		}
		public function toXML():XML{
			infos2Tags();
			
			//updateInsertedRes();
			
			getXML();
			
			CurrSWFVersion.Version=Version;
			var dataAndTags:DataAndTags=new DataAndTags();
			dataAndTags.tagV=tagV;
			xml.appendChild(dataAndTags.toXML("dataAndTags"));
			return xml;
		}
		public function toXML2(progress_start:Function,progress_progress:Function,_progress_finished:Function):void{
			infos2Tags();
			
			//updateInsertedRes();
			
			getXML();
			
			progress_finished=_progress_finished;
			CurrSWFVersion.Version=Version;
			dataAndTags=new DataAndTags();
			dataAndTags.tagV=tagV;
			dataAndTags.toXML2(
				progress_start,
				progress_progress,
				toXML2_finished
			);
		}
		private function toXML2_finished(dataAndTagsXML:XML):void{
			var _progress_finished:Function=progress_finished;
			progress_finished=null;
			dataAndTags=null;
			xml.appendChild(dataAndTagsXML);
			_progress_finished(xml);
		}
		private function initFrameSizeByXML(xml:XML):void{
			var xStr:String=xml.@x.toString();
			if(xStr){
				x=Number(xStr);
			}else{
				x=0;
			}
			var yStr:String=xml.@y.toString();
			if(yStr){
				y=Number(yStr);
			}else{
				y=0;
			}
			width=Number(xml.@width.toString());
			height=Number(xml.@height.toString());
			//trace("width="+width,"height="+height);
		}
		public function initByXML(xml:XML):void{
			type=xml.@type.toString();
			Version=int(xml.@Version.toString());
			initFrameSizeByXML(xml);
			
			FrameRate=Number(xml.@FrameRate.toString());
			CurrSWFVersion.Version=Version;
			var dataAndTags:DataAndTags=new DataAndTags();
			dataAndTags.initByXML(xml.dataAndTags[0]);
			tagV=dataAndTags.tagV;
			
			tags2Infos();
		}
		public function initByXML2(xml:XML,progress_start:Function,progress_progress:Function,_progress_finished:Function):void{
			type=xml.@type.toString();
			Version=int(xml.@Version.toString());
			initFrameSizeByXML(xml);
			
			FrameRate=Number(xml.@FrameRate.toString());
			
			progress_finished=_progress_finished;
			
			CurrSWFVersion.Version=Version;
			dataAndTags=new DataAndTags();
			dataAndTags.initByXML2(
				xml.dataAndTags[0],
				progress_start,
				progress_progress,
				initByXML2_finished
			);
		}
		private function initByXML2_finished():void{
			var _progress_finished:Function=progress_finished;
			progress_finished=null;
			
			tagV=dataAndTags.tagV;
			dataAndTags=null;
			
			tags2Infos();
			
			_progress_finished();
		}
		}//end of CONFIG::toXMLAndInitByXML
		
		
		/*
		private var resInserter:*;
		public function insertRes(
			resData:ByteArray,
			className:String,
			type:String,
			frameId:int=-1,
			addDoABC:Boolean=false,
			addSymbolClass:Boolean=false
		):void{
			if(resInserter){
			}else{
				try{
					import flash.utils.getDefinitionByName;
					var ResInserterClass:Class=getDefinitionByName("zero.swf.funs.ResInserter") as Class;
				}catch(e:Error){
					throw new Error("未编译: zero.swf.funs.ResInserter");
				}
				resInserter=new ResInserterClass(tagV);
			}
			
			resInserter.insert(
				resData,
				className,
				type,
				frameId,
				addDoABC,
				addSymbolClass
			)
		}
		
		public function updateInsertedRes():void{
			//把插入的 resTag 们放到对应的帧里
			if(resInserter){
				resInserter.getTagVAndReset(tagV);
			}
		}
		*/
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