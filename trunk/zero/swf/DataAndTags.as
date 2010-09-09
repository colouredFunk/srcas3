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
	import zero.swf.tag_body.TagBody;
	import zero.swf.tag_body.DefineSprite;
	import zero.swf.tag_body.FileAttributes;
	import zero.swf.tag_body.Metadata;

	public class DataAndTags{
		private static var activateTagBodyClassV:Vector.<Class>=new Vector.<Class>(0x100);
		public static function activateTagBodyClasses(tagBodyClasses:Array):void{
			activateTagBodyClassV=new Vector.<Class>(0x100);
			activateTagBodyClassV.fixed=true;
			for each(var tagBodyClass:Class in tagBodyClasses){
				activateTagBodyClassV[Tag.getTypeByQualifiedClassName(tagBodyClass)]=tagBodyClass;
			}
			activateTagBodyClassV[TagType.DefineSprite]=DefineSprite;
			activateTagBodyClassV[TagType.FileAttributes]=FileAttributes;
			activateTagBodyClassV[TagType.Metadata]=Metadata;
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
		
		public function DataAndTags(){
			//var defaultData:ByteArray=getDefaultData();
			//initByData(defaultData,0,defaultData.length);
		}
		
		public function initByData(data:ByteArray,offset:int,endOffset:int):void{
			FrameCount=data[offset++]|(data[offset++]<<8);//帧数是一个int, 在SWF里以 UI16(Unsigned 16-bit integer value, 16位无符号整数) 的结构保存
			tagV=new Vector.<Tag>();
			var tag:Tag;
			while(offset<endOffset){
				tag=new Tag();
				tagV[tagV.length]=tag;
				
				tag.initByData(data,offset);
				offset=tag.bodyOffset;
				var nextTagOffset:int=tag.bodyOffset+tag.bodyLength;
				if(tag.type==TagType.DefineSprite){
					var defineSprite:DefineSprite=new DefineSprite();
					defineSprite.id=data[offset++]|(data[offset++]<<8);
					defineSprite.dataAndTags.initByData(data,offset,nextTagOffset);
					tag.tagBody=defineSprite;
				}else{
					var tagBodyClass:Class=activateTagBodyClassV[tag.type];
					if(tagBodyClass){
						tag.tagBody=new tagBodyClass();
						offset=tag.tagBody.initByData(data,offset,nextTagOffset);
						if(offset===nextTagOffset){
							
						}else{
							throw new Error("offset="+offset+",nextTagOffset="+nextTagOffset);
						}
					}else{
						if(tag.type==TagType.End){
							break;
						}
					}
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
					throw new Error("offset="+offset+",endOffset="+endOffset+",offset!=endOffset");
				}
				//if(tag.type==TagType.End){
				//	
				//}else{
				//	
				//}
			}
			
			if(FrameCount!=getRealFrameCount()){
				Outputer.output("FrameCount="+FrameCount+" 不正确","brown");
				FrameCount=getRealFrameCount();
				Outputer.output("修正为: "+FrameCount,"brown");
			}
			
			//trace("---------------------------------------");
		}
		public function getRealFrameCount():int{
			var realFrameCount:int=0;
			for each(var tag:Tag in tagV){
				if(tag.type==TagType.ShowFrame){
					realFrameCount++;
				}
			}
			return realFrameCount;
		}
		
		private var toData_newData:ByteArray;
		private var toData_tagId:int;
		
		private var progress_progress:Function;
		private var progress_finished:Function;
		public function toData():ByteArray{
			///===
			toData_newData=new ByteArray();
			toData_newData.position=2;
			toData_tagId=-1;
			///===
			
			var totalTag:int=tagV.length;
			while(++toData_tagId<totalTag){
				toData_step()
			};
			
			///===
			FrameCount=getRealFrameCount();
			toData_newData[0]=FrameCount;
			toData_newData[1]=FrameCount>>8;
			///===
			
			var newData:ByteArray=toData_newData;
			toData_newData=null;
			return newData;
		}
		
		public function toData2(
			progress_start:Function,
			_progress_progress:Function,
			_progress_finished:Function
		):void{
			///===
			toData_newData=new ByteArray();
			toData_newData.position=2;
			toData_tagId=-1;
			///===
			
			progress_progress=_progress_progress;
			progress_finished=_progress_finished;
			if(progress_start!=null){
				progress_start("当前 tag %1 / 总 tag %2",tagV.length);
			}
			clearInterval(intervalId);
			intervalId=setInterval(toData_interval,30);
		}
		private function toData_interval():void{
			
			var t:int=getTimer();
			while(getTimer()-t<30){
				if(++toData_tagId>=tagV.length){
					clearInterval(intervalId);
					
					///===
					FrameCount=getRealFrameCount();
					toData_newData[0]=FrameCount;
					toData_newData[1]=FrameCount>>8;
					///===
					
					progress_progress(tagV.length,tagV.length);
					
					var newData:ByteArray=toData_newData;
					var _progress_finished:Function=progress_finished;
					
					toData_newData=null;
					progress_progress=null;
					progress_finished=null;
					
					_progress_finished(newData);
					return;
				}
				toData_step();
			}
			progress_progress(toData_tagId,tagV.length);
		}
		private function toData_step():void{
			var tag:Tag=tagV[toData_tagId];
			var newBodyData:ByteArray;
			switch(tag.type){
				case TagType.DefineSprite:
					var defineSprite:DefineSprite=tag.tagBody as DefineSprite;
					newBodyData=new ByteArray();
					newBodyData[0]=defineSprite.id;
					newBodyData[1]=defineSprite.id>>8;
					newBodyData.position=2;
					newBodyData.writeBytes(defineSprite.dataAndTags.toData());
				break;
				default:
					if(tag.tagBody){
						newBodyData=tag.tagBody.toData();
					}else{
						newBodyData=new ByteArray();
						if(tag.bodyLength>0){
							newBodyData.writeBytes(tag.bodyData,tag.bodyOffset,tag.bodyLength);
						}
					}
				break;
			}
			
			toData_newData.writeBytes(Tag.getHeaderData(tag.type,newBodyData.length,tag.test_isShort));
			toData_newData.writeBytes(newBodyData);
		}
		
		//public function forEachTag(fun:Function):void{
		//	var tagId:int=tagV.length;
		//	while(--tagId>=0){
		//		fun(data,tagV[tagId],tagV,tagId);
		//	}
		//}
		
		CONFIG::toXMLAndInitByXML{
		public function toXML():XML{
			var xml:XML=<tags FrameCount={FrameCount}/>;
			var realFrameCount:int=0;
			for each(var tag:Tag in tagV){
				var tagXML:XML=<tag type={TagType.typeNameArr[tag.type]} typeNum={tag.type} test_isShort={tag.test_isShort}/>;
				switch(tag.type){
					case TagType.DefineSprite:
						var defineSprite:DefineSprite=tag.tagBody as DefineSprite;
						var defineSpriteXML:XML=<DefineSprite id={defineSprite.id}/>;
						defineSpriteXML.appendChild(defineSprite.dataAndTags.toXML());
						tagXML.appendChild(defineSpriteXML);
					break;
					default:
						if(tag.tagBody){
							tagXML.appendChild(tag.tagBody.toXML());
						}else{
							if(tag.bodyData){
								if(tag.bodyLength>0){
									tagXML.appendChild(<body length={tag.bodyLength} value={BytesAndStr16.bytes2str16(tag.bodyData,tag.bodyOffset,tag.bodyLength)}/>);
								}
							}
						}
					break;
				}
				if(tag.type==TagType.ShowFrame){
					tagXML.@frameId=realFrameCount++;
				}
				xml.appendChild(tagXML);
			}
			FrameCount=realFrameCount;
			xml.@FrameCount=FrameCount;
			return xml;
		}
		public function initByXML(xml:XML):void{
			FrameCount=int(xml.@FrameCount.toString());
			var realFrameCount:int=0;
			tagV=new Vector.<Tag>();
			var tagId:int=0;
			for each(var tagXML:XML in xml.tag){
				var typeName:String=tagXML.@type.toString();
				if(typeName){
					var tag:Tag=new Tag();
					tag.type=TagType[typeName];
					tag.test_isShort=tagXML.@test_isShort.toString()=="true";
					if(TagType.typeNameArr[tag.type]===typeName){
						tagV[tagId]=tag;
						switch(tag.type){
							case TagType.DefineSprite:
								var defineSprite:DefineSprite=new DefineSprite();
								var defineSpriteXML:XML=tagXML.DefineSprite[0];
								defineSprite.id=int(defineSpriteXML.@id.toString());
								defineSprite.dataAndTags.initByXML(defineSpriteXML.tags[0]);
								tag.tagBody=defineSprite;
							break;
							default:
								if(tagXML.children().length()==0){
									tag.bodyData=new ByteArray();
								}else{
									var bodyXML:XML=tagXML.children()[0];
									if(bodyXML.name()=="body"){
										tag.bodyData=BytesAndStr16.str162bytes(bodyXML.@value.toString());
									}else{
										var TagBodyClass:Class=activateTagBodyClassV[tag.type];
										if(TagBodyClass){
											var tagBody:TagBody=new TagBodyClass();
											tagBody.initByXML(bodyXML);
											tag.tagBody=tagBody;
										}else{
											throw new Error("typeName="+typeName+",TagBodyClass=="+TagBodyClass);
										}
									}
								}
							break;
						}
						if(tag.type==TagType.ShowFrame){
							realFrameCount++;
						}
						tagId++;
						continue;
					}
				}
				throw new Error("未知 typeName="+typeName+",typeNum="+tagXML.@typeNum.toString());
			}
			if(FrameCount!=realFrameCount){
				Outputer.output("FrameCount="+FrameCount+",realFrameCount="+realFrameCount,"brown");
				FrameCount=realFrameCount;
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