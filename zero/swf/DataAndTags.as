/***
DataAndTags 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年1月13日 14:42:31
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf{
	import flash.utils.*;
	
	import zero.BytesAndStr16;
	import zero.Outputer;
	import zero.swf.avm1.Op;
	import zero.swf.tag_body.DefineSprite;
	import zero.swf.tag_body.FileAttributes;
	import zero.swf.tag_body.Metadata;
	import zero.swf.tag_body.TagBody;

	public class DataAndTags extends BaseDat{
		public static const structorOption:String="结构";
		public static const resourceOption:String="资源";
		public static const byteCodesOption:String="字节码";
		public static const onlyLocationOption:String="仅位置";
		public static const noOutputOption:String="不输出";
		
		public static const defaultOption:String=byteCodesOption;
		
		public static var mustBeStructorTagBodyClasses:Vector.<Class>;
		
		public static var optionIndexs:Object=getOptionIndexs();
		private static function getOptionIndexs():Object{
			mustBeStructorTagBodyClasses=new Vector.<Class>(TagType.typeNameArr.length);
			mustBeStructorTagBodyClasses.fixed=true;
			
			mustBeStructorTagBodyClasses[TagType.FileAttributes]=FileAttributes;
			mustBeStructorTagBodyClasses[TagType.Metadata]=Metadata;
			
			var optionIndexs:Object=new Object();
			optionIndexs[structorOption]=0;
			optionIndexs[resourceOption]=1;
			optionIndexs[byteCodesOption]=2;
			optionIndexs[onlyLocationOption]=3;
			optionIndexs[noOutputOption]=4;
			return optionIndexs;
		}
		
		private static var optionV:Vector.<String>;
		public static function setOption(optionXML:XML):void{
			var optionMark:Object=getOptionMarkByOptionXML(optionXML);
			var typeNum:int=TagType.typeNameArr.length;
			optionV=new Vector.<String>(typeNum);
			optionV.fixed=true;
			
			var TagBodyClass:Class;
			
			while(--typeNum>=0){
				optionV[typeNum]=optionMark[TagType.typeNameArr[typeNum]]||defaultOption;
			}
			
			for each(TagBodyClass in mustBeStructorTagBodyClasses){
				if(TagBodyClass){
					optionV[mustBeStructorTagBodyClasses.indexOf(TagBodyClass)]=structorOption;
				}
			}
			//trace("optionV="+optionV);
			//trace(("optionV="+optionV).replace(new RegExp(defaultOption,"g"),"").replace(/,+/g,"\n"));
		}
		public static function getOptionMarkByOptionXML(optionXML:XML):Object{
			var optionMark:Object=new Object();
			for each(var tagXML:XML in optionXML.tag){
				optionMark[tagXML.@type.toString()]=tagXML.@option.toString();
			}
			return optionMark;
		}
		
		private var intervalId:int=-1;
		public function clear():void{
			clearInterval(intervalId);
		}
		
		/*
		private static function getDefaultData():ByteArray{
			var defaultData:ByteArray=new ByteArray();
			defaultData[0]=0x01;
			defaultData[1]=0x00;
			
			//defaultData[2]=0x40;
			//defaultData[3]=0x00;
			//defaultData[4]=0x00;
			//defaultData[5]=0x00;
			
			defaultData[2]=0x44;
			defaultData[3]=0x11;
			defaultData[4]=0x08;
			defaultData[5]=0x00;
			defaultData[6]=0x00;
			defaultData[7]=0x00;
			defaultData[8]=0x40;
			defaultData[9]=0x00;
			defaultData[10]=0x00;
			defaultData[11]=0x00;
			
			return defaultData;
		}
		*/
		
		//public var data:ByteArray;
		public var FrameCount:int;
		public var tagV:Vector.<Tag>;
		private var progress_progress:Function;
		private var progress_finished:Function;
		private var actionResult:*;
		private var actionName:String;
		private var curr_childId:int;
		private var curr_frameId:int;
		private var totalChild:int;
		
		public function DataAndTags(){
			//var defaultData:ByteArray=getDefaultData();
			//initByData(defaultData,0,defaultData.length);
		}
		
		override public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			FrameCount=data[offset++]|(data[offset++]<<8);//帧数是一个int, 在SWF里以 UI16(Unsigned 16-bit integer value, 16位无符号整数) 的结构保存
			curr_frameId=0;
			tagV=getTagV(data,offset,endOffset);
			
			if(FrameCount!=curr_frameId){
				Outputer.output("FrameCount="+FrameCount+" 不正确","brown");
				FrameCount=curr_frameId;
				Outputer.output("修正为: "+FrameCount,"brown");
			}
			return endOffset;
		}
		
		private function getTagV(data:ByteArray,offset:int,endOffset:int):Vector.<Tag>{
			var tagV:Vector.<Tag>=new Vector.<Tag>();
			var tag:Tag;
			while(offset<endOffset){
				tag=new Tag();
				tagV[tagV.length]=tag;
				
				tag.initByData(data,offset);
				offset=tag.bodyOffset;
				var nextTagOffset:int=tag.bodyOffset+tag.bodyLength;
				
				var TagBodyClass:Class;
				switch(optionV[tag.type]){
					case structorOption:
						TagBodyClass=Tag.getTagBodyClassByType(tag.type);
						if(TagBodyClass){
						}else{
							throw new Error("TagBodyClass: "+TagType.typeNameArr[tag.type]+" 未定义");
						}
					break;
					default:
						TagBodyClass=null;
					break;
				}
				if(TagBodyClass){
					tag.tagBody=new TagBodyClass();
					offset=tag.tagBody.initByData(data,offset,nextTagOffset);
					if(offset===nextTagOffset){
					}else{
						Outputer.outputError(TagType.typeNameArr[tag.type]+" offset="+offset+",nextTagOffset="+nextTagOffset);
					}
				}else{
					if(tag.type==TagType.End){
						break;
					}
				}
				if(tag.type==TagType.ShowFrame){
					curr_frameId++;
				}
				offset=nextTagOffset;
			}
			if(offset===endOffset){
			}else{
				Outputer.output("最后一个 tag: "+TagType.typeNameArr[tag.type],"brown");
				Outputer.output("offset="+offset+",endOffset="+endOffset+",offset!=endOffset","brown");
				if(offset>endOffset){
					tag.bodyLength+=endOffset-offset;
					Outputer.output("修正最后一个 tag: tag.bodyLength="+tag.bodyLength,"brown");
				}else{
					Outputer.outputError("offset="+offset+",endOffset="+endOffset+",offset!=endOffset");
				}
				//if(tag.type==TagType.End){
				//	
				//}else{
				//	
				//}
			}
			return tagV;
		}
		
		/*
		public function getRealFrameCount():int{
			var realFrameCount:int=0;
			for each(var tag:Tag in tagV){
				if(tag.type==TagType.ShowFrame){
					realFrameCount++;
				}
			}
			return realFrameCount;
		}
		//*/
		
		private var toDataResult:ByteArray;
		private function toData_start():void{
			toDataResult=new ByteArray();
			toDataResult.position=2;
			curr_frameId=0;
			curr_childId=-1;
		}
		private function toData_end():void{
			FrameCount=curr_frameId;
			toDataResult[0]=FrameCount;
			toDataResult[1]=FrameCount>>8;
		}
		override public function toData():ByteArray{
			run("toData");
			var newData:ByteArray=toDataResult;
			toDataResult=null;
			return newData;
		}
		public function toData2(progress_start:Function,_progress_progress:Function,_progress_finished:Function):void{
			run("toData",progress_start,_progress_progress,_progress_finished);
		}
		private function toData_step():void{
			var tag:Tag=tagV[curr_childId];
			var newBodyData:ByteArray;
			if(tag.tagBody){
				newBodyData=tag.tagBody.toData();
			}else{
				newBodyData=new ByteArray();
				if(tag.bodyLength>0){
					newBodyData.writeBytes(tag.bodyData,tag.bodyOffset,tag.bodyLength);
				}
			}
			if(tag.type==TagType.ShowFrame){
				curr_frameId++;
			}
			//toDataResult.writeBytes(Tag.getHeaderData(tag.type,newBodyData.length,tag.test_isShort));
			toDataResult.writeBytes(Tag.getHeaderData(tag.type,newBodyData.length));
			toDataResult.writeBytes(newBodyData);
		}
		//
		private function run(
			_actionName:String,
			progress_start:Function=null,
			_progress_progress:Function=null,
			_progress_finished:Function=null
		):void{
			actionName=_actionName;
			totalChild=tagV.length;
			this[actionName+"_start"]();
			if(_progress_finished!=null){
				progress_progress=_progress_progress;
				progress_finished=_progress_finished;
				if(progress_start!=null){
					progress_start("当前 tag %1 / 总 tag %2",totalChild);
				}
				actionResult=this[actionName+"Result"];
				clearInterval(intervalId);
				intervalId=setInterval(action_interval,30);
			}else{
				var action_step:Function=this[actionName+"_step"];
				while(++curr_childId<totalChild){
					action_step();
				};
				this[actionName+"_end"]();
			}
		}
		private function action_interval():void{
			
			var t:int=getTimer();
			while(getTimer()-t<30){
				if(++curr_childId>=totalChild){
					clearInterval(intervalId);
					
					this[actionName+"_end"]();
					
					progress_progress(totalChild,totalChild);
					
					var _progress_finished:Function=progress_finished;
					
					progress_progress=null;
					progress_finished=null;
					
					_progress_finished(actionResult);
					actionResult=null;
					return;
				}
				this[actionName+"_step"]();
			}
			progress_progress(curr_childId,totalChild);
		}
		

		
		CONFIG::toXMLAndInitByXML{
		private var toXMLResult:XML;
		private var toXML_startOffset:int;
		private var toXML_endOffset:int;
		private function toXML_start():void{
			toXMLResult=<tags FrameCount={FrameCount}/>;
			curr_frameId=0;
			curr_childId=-1;
			
			toXML_startOffset=-1;
			toXML_endOffset=-1;
		}
		private function toXML_end():void{
			FrameCount=curr_frameId;
			toXMLResult.@FrameCount=FrameCount;
			checkAddDataBlock();
		}
		override public function toXML():XML{
			run("toXML");
			var newXML:XML=toXMLResult;
			toXMLResult=null;
			return newXML;
		}
		public function toXML2(progress_start:Function,_progress_progress:Function,_progress_finished:Function):void{
			run("toXML",progress_start,_progress_progress,_progress_finished);
		}
		private function toXML_step():void{
			var tag:Tag=tagV[curr_childId];
			if(optionV[tag.type]===noOutputOption){
				//如果不是用同一个swf的数据的则可能会出错
				if(toXML_startOffset==-1){
					toXML_startOffset=tag.headOffset;
				}
				toXML_endOffset=tag.bodyOffset+tag.bodyLength;
			}else{
				checkAddDataBlock();
				//var tagXML:XML=<tag type={TagType.typeNameArr[tag.type]} typeNum={tag.type} test_isShort={tag.test_isShort}/>;
				var tagXML:XML=<tag type={TagType.typeNameArr[tag.type]} typeNum={tag.type}/>;
				
				switch(optionV[tag.type]){
					case structorOption:
						if(tag.tagBody){
							tagXML.appendChild(tag.tagBody.toXML());
						}else{
							throw new Error("暂不支持");
						}
					break;
					case resourceOption:
						if(tag.tagBody){
							throw new Error("暂不支持");
						}
						
						var typeName:String=TagType.typeNameArr[tag.type];
						
						if(DefineObjs[typeName]){
						}else{
							throw new Error("暂不支持");
						}
						
						var bodyXML:XML=<body defId={tag.getDefId()}/>;
						DataMark.toXML_addResource(tag,bodyXML);
						tagXML.appendChild(bodyXML);
					break;
					case byteCodesOption:
						if(tag.tagBody){
							throw new Error("暂不支持");
						}
						if(tag.bodyData&&tag.bodyLength>0){
							tagXML.appendChild(<body length={tag.bodyLength} value={BytesAndStr16.bytes2str16(tag.bodyData,tag.bodyOffset,tag.bodyLength)}/>);
						}
					break;
					case onlyLocationOption:
						if(tag.tagBody){
							throw new Error("暂不支持");
						}
						if(tag.bodyData&&tag.bodyLength>0){
							tagXML.appendChild(<body offset={tag.bodyOffset} length={tag.bodyLength}/>);
						}
					break;
					//case noOutputOption:
					//break;
					default:
						throw new Error("未知 option: "+optionV[tag.type]);
					break;
				}
				
				if(tag.type==TagType.ShowFrame){
					tagXML.@frameId=curr_frameId;
				}
				toXMLResult.appendChild(tagXML);
			}
			if(tag.type==TagType.ShowFrame){
				curr_frameId++;
			}
		}
		private function checkAddDataBlock():void{
			//trace("toXML_startOffset="+toXML_startOffset,"toXML_endOffset="+toXML_endOffset);
			if(toXML_startOffset<toXML_endOffset){
				toXMLResult.appendChild(<dataBlock offset={toXML_startOffset} length={toXML_endOffset-toXML_startOffset}/>);
				toXML_startOffset=-1;
				toXML_endOffset=-1
			}
		}
		//
		private var initByData_tagsChildrenXMLList:XMLList;
		private function initByXML_start(xml:XML):void{
			FrameCount=int(xml.@FrameCount.toString());
			initByData_tagsChildrenXMLList=xml.children();
			totalChild=initByData_tagsChildrenXMLList.length();
			tagV=new Vector.<Tag>();
			curr_frameId=0;
			curr_childId=-1;
		}
		private function initByXML_end():void{
			if(FrameCount!=curr_frameId){
				Outputer.output("FrameCount="+FrameCount+",curr_frameId="+curr_frameId,"brown");
				FrameCount=curr_frameId;
			}
		}
		override public function initByXML(xml:XML):void{
			initByXML_start(xml);
			while(++curr_childId<totalChild){
				initByXML_step();
			}
			initByXML_end();
		}
		public function initByXML2(xml:XML,progress_start:Function,_progress_progress:Function,_progress_finished:Function):void{
			initByXML_start(xml);
			progress_progress=_progress_progress;
			progress_finished=_progress_finished;
			if(progress_start!=null){
				progress_start("当前节点 %1 / 总节点 %2",totalChild);
			}
			clearInterval(intervalId);
			intervalId=setInterval(initByXML_interval,30);
		}
		private function initByXML_interval():void{
			
			var t:int=getTimer();
			while(getTimer()-t<30){
				if(++curr_childId>=totalChild){
					clearInterval(intervalId);
					
					initByXML_end();
					
					progress_progress(totalChild,totalChild);
					
					var _progress_finished:Function=progress_finished;
					
					progress_progress=null;
					progress_finished=null;
					
					_progress_finished();
					return;
				}
				initByXML_step();
				//trace("tagV="+tagV.length)
			}
			progress_progress(curr_childId,totalChild);
		}
		private function initByXML_step():void{
			var tagsChildXML:XML=initByData_tagsChildrenXMLList[curr_childId];
			var tag:Tag;
			var offsetStr:String,lengthStr:String;
			
			if(tagsChildXML.name().toString()=="dataBlock"){
				offsetStr=tagsChildXML.@offset.toString();
				lengthStr=tagsChildXML.@length.toString();
				if(offsetStr&&lengthStr){
					var offset:int=int(offsetStr);
					var endOffset:int=offset+int(lengthStr);
					for each(tag in getTagV(DataMark.data,offset,endOffset)){
						//trace("tag="+tag);
						tagV[tagV.length]=tag;
					}
					//trace("------------------");
				}else{
					Outputer.outputError("offsetStr="+offsetStr+",lengthStr="+lengthStr);
				}
			}else{
				var typeName:String=tagsChildXML.@type.toString();
				if(typeName){
					var type:int=TagType[typeName];
					//tag.test_isShort=tagXML.@test_isShort.toString()=="true";
					if(TagType.typeNameArr[type]===typeName){
						if(tagsChildXML.children().length()==0){
							tag=new Tag();
							tag.type=type;
							tag.bodyData=new ByteArray();
						}else{
							var bodyXML:XML=tagsChildXML.children()[0];
							if(bodyXML.name()=="body"){
								var valueStr:String=bodyXML.@value.toString();
								if(valueStr){
									//字节码
									tag=new Tag();
									tag.type=type;
									tag.bodyData=BytesAndStr16.str162bytes(valueStr);
								}else{
									var resourcePath:String=bodyXML.@resource.toString();
									if(resourcePath){
										var defIdStr:String=bodyXML.@defId.toString();
										if(defIdStr){
											tag=DataMark.getDefineTag(resourcePath,int(defIdStr));
											if(tag.type===type){
											}else{
												Outputer.output("一个 "+TagType.typeNameArr[type]+" 被替换成: "+TagType.typeNameArr[tag.type]+"(可能会引起问题?)","brown");
											}
										}
									}else{
										lengthStr=bodyXML.@length.toString();
										if(lengthStr){
											if(lengthStr=="0"){
												tag=new Tag();
												tag.type=type;
												tag.bodyData=new ByteArray();
											}else{
												//这时 offset 和 length 都是必须的
												offsetStr=bodyXML.@offset.toString();
												if(offsetStr){
													//var resourceStr:String=bodyXML.@resourceStr.toString();
													//if(resourceStr){
													//	var data:ByteArray=DataMark[resourceStr];
													//}
													//暂时还只是从整个SWF里取数据:
													if(DataMark.data){
														tag=new Tag();
														tag.type=type;
														tag.bodyData=DataMark.data;
														tag.bodyOffset=int(offsetStr);
														tag.bodyLength=int(lengthStr);
													}else{
														Outputer.outputError("DataMark.data="+DataMark.data+",极可能是因为没和原来的SWF放一块...");
														tag=new Tag();
														tag.type=type;
														tag.bodyData=new ByteArray();
													}
												}else{
													throw new Error("offsetStr="+offsetStr);
												}
											}
										}else{
											tag=new Tag();
											tag.type=type;
											tag.bodyData=new ByteArray();
										}
									}
								}
							}else{
								var TagBodyClass:Class=Tag.getTagBodyClassByType(type);
								if(TagBodyClass){
								}else{
									throw new Error("TagBodyClass: "+typeName+" 未定义");
								}
								var tagBody:TagBody=new TagBodyClass();
								tagBody.initByXML(bodyXML);
								tag=new Tag();
								tag.tagBody=tagBody;
							}
						}
						tagV[tagV.length]=tag;
						
						if(tag.type==TagType.ShowFrame){
							curr_frameId++;
						}
						return;
					}
				}
				Outputer.outputError("未知 typeName="+typeName+",typeNum="+tagsChildXML.@typeNum.toString());
			}
		}
		}//end of CONFIG::toXMLAndInitByXML
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