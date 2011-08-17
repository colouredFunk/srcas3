/***
SWFExtend
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年8月16日 11:03:51
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.swf{
	
	import flash.utils.ByteArray;
	
	import zero.swf.tagBodys.*;
	
	public class SWFExtend extends SWF{
		public function SWFExtend(
			_type:String=null,
			_Version:int=0,
			_width:Number=-1,
			_height:Number=-1,
			_FrameRate:Number=0,
			_tagV:Vector.<Tag>=null
		){
			super(
				_type,
				_Version,
				_width,
				_height,
				_FrameRate,
				_tagV
			);
		}
		
		//获取或设置 ActionScript 版本是否 3
		public function get isAS3():Boolean{
			var fileAttributesTag:Tag=getFirstTag(TagTypes.FileAttributes);
			if(fileAttributesTag){
				return fileAttributesTag.getBody(FileAttributes,null).ActionScript3;
			}
			return false;
		}
		public function set isAS3(_isAS3:Boolean):void{
			getFileAttributesTagOrInsertOne().getBody(FileAttributes,null).ActionScript3=_isAS3;
		}
		//
		
		//获取或设置是否仅访问网络
		public function get UseNetwork():Boolean{
			var fileAttributesTag:Tag=getFirstTag(TagTypes.FileAttributes);
			if(fileAttributesTag){
				return fileAttributesTag.getBody(FileAttributes,null).UseNetwork;
			}
			return false;
		}
		public function set UseNetwork(_UseNetwork:Boolean):void{
			getFileAttributesTagOrInsertOne().getBody(FileAttributes,null).UseNetwork=_UseNetwork;
		}
		//
		
		//获取或设置 metadata
		public function get metadata():String{
			var metadataTag:Tag=getFirstTag(TagTypes.Metadata);
			if(metadataTag){
				return metadataTag.getBody(Metadata,null).metadata;
			}
			return null;
		}
		public function set metadata(_metadata:String):void{
			var metadataTag:Tag=getFirstTag(TagTypes.Metadata);
			if(metadata is String){
				if(metadataTag){
					getFileAttributesTagOrInsertOne().getBody(FileAttributes,null).HasMetadata=true;
					metadataTag.getBody(Metadata,null).metadata=_metadata;
				}else{
					trace("木找到 Metadata，可考虑自动插入一个");
				}
			}else{
				if(metadataTag){
					tagV.splice(tagV.indexOf(metadataTag),1);
				}
				var fileAttributesTag:Tag=getFirstTag(TagTypes.FileAttributes);
				if(fileAttributesTag){
					fileAttributesTag.getBody(FileAttributes,null).HasMetadata=false;
				}
			}
		}
		//
		
		//获取或设置背景颜色
		public function get bgColor():int{
			var setBackgroundColorTag:Tag=getFirstTag(TagTypes.SetBackgroundColor);
			if(setBackgroundColorTag){
				return setBackgroundColorTag.getBody(SetBackgroundColor,null).BackgroundColor;
			}
			return 0xffffff;
		}
		public function set bgColor(_bgColor:int):void{
			var setBackgroundColorTag:Tag=getFirstTag(TagTypes.SetBackgroundColor);
			if(setBackgroundColorTag){
				setBackgroundColorTag.getBody(SetBackgroundColor,null).BackgroundColor=_bgColor;
			}else{
				trace("木找到 SetBackgroundColor，可考虑自动插入一个");
			}
		}
		//
		
		//获取或添加文档类（仅限 AS3 的 SWF）
		public function get docClassName():String{
			if(isAS3){
				for each(var tag:Tag in getTagsByType(TagTypes.SymbolClass)){
					var symbolClass:SymbolClass=tag.getBody(SymbolClass,null);
					var i:int=symbolClass.TagV.indexOf(0);
					if(i>-1){
						return symbolClass.NameV[i].replace(/\:\:/g,".");
					}
				}
				return null;
			}
			throw new Error("isAS3="+isAS3);
		}
		public function addSimpleDocClass(simpleDocClassName:String):void{
			//添加一个 public dynamic _docClassName extends MovieClip
			if(isAS3){
				if(docClassName){
					throw new Error("文档类已有："+docClassName+"，请考虑 ReplaceDocClass");
				}
				if(simpleDocClassName.search(/\:\:|\./)>-1){
					throw new Error("暂不支持的 simpleDocClassName"+simpleDocClassName);
				}
				
				//0x0a,0x43,0x6c,0x61,0x73,0x73,0x31,0x32,0x33,0x34,0x35
				var docClassNameData:ByteArray=new ByteArray();
				docClassNameData.writeUTFBytes(simpleDocClassName);
				if(docClassNameData.length>0x7f){
					throw new Error("暂不支持长度超过 0x7f 的 simpleDocClassName: "+simpleDocClassName);
				}
				
				var mcClassData:ByteArray=new ByteArray();
				var byte:int;
				for each(byte in [0x01,0x00,0x00,0x00,0x00,0x10,0x00,0x2e,0x00,0x00,0x00,0x00,0x0c,0x00]){
					mcClassData[mcClassData.length]=byte;
				}
				//0x0a,0x43,0x6c,0x61,0x73,0x73,0x31,0x32,0x33,0x34,0x35
				mcClassData[mcClassData.length]=docClassNameData.length;
				mcClassData.position=mcClassData.length;
				mcClassData.writeBytes(docClassNameData);
				for each(byte in [0x0d,0x44,0x69,0x73,0x70,0x6c,0x61,0x79,0x4f,0x62,0x6a,0x65,0x63,0x74,0x16,0x44,0x69,0x73,0x70,0x6c,0x61,0x79,0x4f,0x62,0x6a,0x65,0x63,0x74,0x43,0x6f,0x6e,0x74,0x61,0x69,0x6e,0x65,0x72,0x0f,0x45,0x76,0x65,0x6e,0x74,0x44,0x69,0x73,0x70,0x61,0x74,0x63,0x68,0x65,0x72,0x11,0x49,0x6e,0x74,0x65,0x72,0x61,0x63,0x74,0x69,0x76,0x65,0x4f,0x62,0x6a,0x65,0x63,0x74,0x09,0x4d,0x6f,0x76,0x69,0x65,0x43,0x6c,0x69,0x70,0x06,0x4f,0x62,0x6a,0x65,0x63,0x74,0x06,0x53,0x70,0x72,0x69,0x74,0x65,0x0d,0x66,0x6c,0x61,0x73,0x68,0x2e,0x64,0x69,0x73,0x70,0x6c,0x61,0x79,0x0c,0x66,0x6c,0x61,0x73,0x68,0x2e,0x65,0x76,0x65,0x6e,0x74,0x73,0x05,0x18,0x02,0x16,0x01,0x16,0x0a,0x16,0x0b,0x00,0x09,0x07,0x02,0x02,0x07,0x03,0x07,0x07,0x02,0x08,0x07,0x04,0x05,0x07,0x03,0x03,0x07,0x03,0x06,0x07,0x03,0x04,0x07,0x03,0x09,0x03,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x01,0x01,0x02,0x08,0x01,0x00,0x00,0x00,0x01,0x00,0x01,0x02,0x01,0x01,0x04,0x01,0x00,0x03,0x00,0x01,0x01,0x0a,0x0b,0x06,0xd0,0x30,0xd0,0x49,0x00,0x47,0x00,0x00,0x01,0x01,0x01,0x09,0x0a,0x03,0xd0,0x30,0x47,0x00,0x00,0x02,0x02,0x01,0x01,0x09,0x27,0xd0,0x30,0x65,0x00,0x60,0x03,0x30,0x60,0x04,0x30,0x60,0x05,0x30,0x60,0x06,0x30,0x60,0x07,0x30,0x60,0x08,0x30,0x60,0x02,0x30,0x60,0x02,0x58,0x00,0x1d,0x1d,0x1d,0x1d,0x1d,0x1d,0x1d,0x68,0x01,0x47,0x00,0x00]){
					mcClassData[mcClassData.length]=byte;
				}
				
				var doABCTag:Tag=new Tag(TagTypes.DoABC);
				doABCTag.setBodyData(mcClassData);
				
				for each(var tag:Tag in tagV){
					switch(tag.type){
						case TagTypes.DoABC:
						case TagTypes.DoABCWithoutFlagsAndName:
						case TagTypes.SymbolClass:
						case TagTypes.ShowFrame:
							var insertPos:int=tagV.indexOf(tag);
							var symbolClass:SymbolClass=new SymbolClass();
							symbolClass.TagV=new Vector.<int>();
							symbolClass.TagV[0]=0;
							symbolClass.NameV=new Vector.<String>();
							symbolClass.NameV[0]=simpleDocClassName;
							var symbolClassTag:Tag=new Tag();
							symbolClassTag.setBody(symbolClass);
							tagV.splice(
								insertPos,
								0,
								doABCTag,
								symbolClassTag
							);
							return;
						break;
					}
				}
				throw new Error("找不到插入点");
			}
			throw new Error("isAS3="+isAS3);
		}
		//
		/*
		//获取可用的 id 们
		private function _getAvalibleDefIdV(mark:Array,tagV:Vector.<Tag>):Vector.<int>{
			for each(var tag:Tag in tagV){
				if(tag.type==TagTypes.DefineSprite){//一般来说 DefineSprite 内不会有 DefineObj
					_getAvalibleDefIdV(mark,tag.getBody(DefineSprite,null).tagV);
				}else{
					var typeName:String=TagTypes.typeNameV[tag.type];
					if(typeName){
						if(DefineObjs[typeName]){
							id=tag.UI16Id;
							
							if(avalibleDefineObjIdArr[id]){
								throw new Error("发现重复的 id:"+id+"，typeName="+typeName);
							}
							avalibleDefineObjIdArr[id]=true;
						}
					}else{
						switch(tag.type){
							case 255:
								//常见的扰乱反编译器的 tag
								break;
							default:
								//主要是如果新版本的 flash 出新 tag 了知道一下
								throw new Error("未知 TagType: "+tag.type);
								break;
						}
					}
				}
			}
		}
		public function getAvalibleDefIdV():Vector.<int>{
			var mark:Array=new Array();
			//mark[0]=true;//有可能被文档类占用
			
			_getAvalibleDefIdV(mark,tagV);
			
			var avalibleDefIdV:Vector.<int>=new Vector.<int>();
			for(var id:int=1;id<0x8000;id++){//0 有可能被文档类占用,所以从1开始
				if(mark[id]){
				}else{
					avalibleDefIdV[avalibleDefIdV.length]=id;
				}
			}
			return avalibleDefIdV;
		}
		*/
		
		private function getFileAttributesTagOrInsertOne():Tag{
			var fileAttributesTag:Tag=getFirstTag(TagTypes.FileAttributes);
			if(fileAttributesTag){
			}else{
				trace("木找到 FileAttributes，自动插入一个");
				fileAttributesTag=new Tag();
				var fileAttributes:FileAttributes=new FileAttributes();
				fileAttributesTag.setBody(fileAttributes);
				tagV.unshift(fileAttributesTag);
			}
			return fileAttributesTag;
		}
		private function getTagsByType(type:int):Vector.<Tag>{
			var tagsByType:Vector.<Tag>=new Vector.<Tag>();
			for each(var tag:Tag in tagV){
				if(tag.type==type){
					tagsByType.push(tag);
				}
			}
			return tagsByType;
		}
		private function getFirstTag(type:int):Tag{
			for each(var tag:Tag in tagV){
				if(tag.type==type){
					return tag;
				}
			}
			return null;
		}
	}
}