/***
SWFExtend
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年8月16日 11:03:51
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.swf{
	
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;
	
	import zero.swf.utils.SimpleDoABC;
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
			if(_metadata is String){
				getFileAttributesTagOrInsertOne().getBody(FileAttributes,null).HasMetadata=true;
				if(metadataTag){
					var metadata:Metadata=metadataTag.getBody(Metadata,null);
				}else{
					trace("木找到 Metadata，自动插入一个");
					metadataTag=new Tag();
					tagV.splice(1,0,metadataTag);
					metadata=new Metadata();
					metadataTag.setBody(metadata);
				}
				metadata.metadata=_metadata;
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
						return symbolClass.NameV[i].replace(/\:+/g,".");
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
								SimpleDoABC.getDoABCTag(simpleDocClassName,"mc",false),
								symbolClassTag
							);
							//var doABCTag:Tag=SimpleDoABC.getDoABCTag(simpleDocClassName,"mc");
							//import zero.swf.avm2.ABCClasses;
							//var doABC:DoABC=doABCTag.getBody(DoABC,{ABCDataClass:ABCClasses});
							//trace(doABC.toXML("doABC",{AVM2UseMarkStr:true}));
							//trace("param_typeV="+doABC.ABCData.classV[0].iinit.param_typeV);
							return;
						break;
					}
				}
				throw new Error("找不到插入点");
			}
			throw new Error("isAS3="+isAS3);
		}
		//
		
		private var avalibleDefineObjIdV:Vector.<int>;
		public function getAvalibleDefineObjId():int{
			if(avalibleDefineObjIdV){
			}else{
				avalibleDefineObjIdV=IDManager.getAvalibleDefineObjIdV(this);
			}
			return avalibleDefineObjIdV.shift();
		}
		
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