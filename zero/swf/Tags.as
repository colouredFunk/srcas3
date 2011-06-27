﻿/***
Tags
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月9日 09:18:42
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.swf{
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	
	import zero.Outputer;
	public class Tags{
		public static function getRealFrameCount(
			tagV:Vector.<Tag>,
			FrameCount:int=-1//如果传入，表示需要检测是否正确
		):int{
			var realFrameCount:int=0;
			for each(var tag:Tag in tagV){
				if(tag.type==TagTypes.ShowFrame){
					realFrameCount++;
				}
			}
			
			if(FrameCount>-1){
				if(FrameCount==realFrameCount){
				}else{
					Outputer.output("FrameCount="+FrameCount+" 不正确\n修正为："+realFrameCount,"brown");
				}
			}
			
			return realFrameCount;
		}
		public static function getTagsByData(tagV:Vector.<Tag>,data:ByteArray,offset:int,endOffset:int):void{
			var tag:Tag;
			while(offset<endOffset){
				tagV[tagV.length]=tag=new Tag();
				tag.initByData(data,offset);
				offset=tag.bodyOffset+tag.bodyLength;
				
				if(TagTypes.typeNameV[tag.type]){
				}else{
					Outputer.outputError("未知 type："+tag.type+"，typeName="+TagTypes.typeNameV[tag.type]);
				}
				
				if(tag.type==TagTypes.End){
					break;
				}
			}
			
			if(offset==endOffset){
			}else{
				Outputer.output("getTagsByData offset="+offset+"，endOffset="+endOffset+"，offset!=endOffset","brown");
				if(offset>endOffset){
					tag.bodyLength+=endOffset-offset;
					Outputer.output("修正最后一个 tag：tag.bodyLength="+tag.bodyLength,"brown");
				}else{
					Outputer.outputError("offset="+offset+"，endOffset="+endOffset+"，offset!=endOffset");
				}
			}
		}
		
		public static function initByData_step(
			tagV:Vector.<Tag>,
			tagId:int,
			tagCount:int,
			timeLimit:int,//20110606 主要用于 DefineSprite 和 SWF 中减少瞬时调用 initByData_step 的次数，以提高运行速度，对 SWFProgresser 基本不影响
			_initByDataOptions:Object/*zero_swf_InitByDataOptions*/
		):int{
			if(_initByDataOptions&&_initByDataOptions.optionV){
			}else{
				return tagCount;
			}
			var t:int=getTimer();
			while(getTimer()-t<timeLimit){
				if(tagId<tagCount){
					var tag:Tag=tagV[tagId];
					switch(_initByDataOptions.optionV[tag.type]){
						case "数据块（仅位置）":
						case "数据块（字节码）":
						case "仅位置":
						case "字节码":
							//trace("忽略");
						break;
						case "结构":
							tag.getBody(_initByDataOptions);
						break;
						default:
							throw new Error("未知 option："+_initByDataOptions.optionV[tag.type]);
						break;
					}
					tagId++;
				}else{
					return tagCount;
				}
			}
			
			return tagId;
		}
		
		public static function toData_step(
			tagV:Vector.<Tag>,
			tagsData:ByteArray,
			tagId:int,
			tagCount:int,
			timeLimit:int,//20110606 主要用于 DefineSprite 和 SWF 中减少瞬时调用 initByData_step 的次数，以提高运行速度，对 SWFProgresser 基本不影响
			_toDataOptions:Object/*zero_swf_ToDataOptions*/
		):int{
			var t:int=getTimer();
			while(getTimer()-t<timeLimit){
				if(tagId<tagCount){
					var tag:Tag=tagV[tagId];
					tagsData.writeBytes(tag.toData(_toDataOptions));
					tagId++;
				}else{
					return tagCount;
				}
			}
			
			return tagId;
		}
		
		CONFIG::USE_XML{
			
		import zero.BytesAndStr16;
		
		////
		public static function getFrameIdDict(tagV:Vector.<Tag>):Dictionary{
			var frameId:int=-1;
			var frameIdDict:Dictionary=new Dictionary();
			for each(var tag:Tag in tagV){
				if(tag.type==TagTypes.ShowFrame){
					frameIdDict[tag]=++frameId;
				}
			}
			return frameIdDict;
		}
		
		public static function toXML_step(
			tagV:Vector.<Tag>,
			tagsXML:XML,
			frameIdDict:Dictionary,
			tagId:int,
			tagCount:int,
			timeLimit:int,//20110606 主要用于 DefineSprite 和 SWF 中减少瞬时调用 toXML_step 的次数，以提高运行速度，对 SWFProgresser 基本不影响
			_toXMLOptions:Object/*zero_swf_ToXMLOptions*/
		):int{
			var t:int=getTimer();
			while(getTimer()-t<timeLimit){
				if(tagId<tagCount){
					var tag:Tag=tagV[tagId];
						
					var currBlockOption:String,blockSize:int,lastTag:Tag;
					var option:String;
					if(_toXMLOptions){
						option=_toXMLOptions.optionV[tag.type];
					}else{
						option="字节码";
					}
					switch(option){
						case "数据块（仅位置）":
							lastTag=tag;
							currBlockOption=option;
							if(_toXMLOptions.src){
								while(++tagId<tagCount){
									if(currBlockOption==_toXMLOptions.optionV[tagV[tagId].type]){
									}else{
										break;
									}
									lastTag=tagV[tagId];
								}
								blockSize=lastTag.bodyOffset+lastTag.bodyLength-tag.headOffset;
								tagsXML.appendChild(
									<block
										src={_toXMLOptions.src}
										offset={tag.headOffset}
										length={blockSize}
									/>
								);
							}else{
								var currSrc:String=_toXMLOptions.getSrcFun(tag.getBodyData());
								while(++tagId<tagCount){
									if(
										currBlockOption==_toXMLOptions.optionV[tagV[tagId].type]
										&&
										currSrc==_toXMLOptions.getSrcFun(tag.getBodyData())
									){
									}else{
										break;
									}
									lastTag=tagV[tagId];
								}
								blockSize=lastTag.bodyOffset+lastTag.bodyLength-tag.headOffset;
								tagsXML.appendChild(
									<block
										src={currSrc}
										offset={tag.headOffset}
										length={blockSize}
									/>
								);
							}
						break;
						case "数据块（字节码）":
							lastTag=tag;
							currBlockOption=option;
							var blockData:ByteArray=tag.getBodyData();
							while(++tagId<tagCount){
								if(
									currBlockOption==_toXMLOptions.optionV[tagV[tagId].type]
									&&
									blockData==tag.getBodyData()
								){
								}else{
									break;
								}
								lastTag=tagV[tagId];
							}
							blockSize=lastTag.bodyOffset+lastTag.bodyLength-tag.headOffset;
							tagsXML.appendChild(
								<block
									length={blockSize}//此处 length 只用于查看，真正的 length 以 value 的长度为准
									value={
										BytesAndStr16.bytes2str16(
											blockData,
											tag.headOffset,
											blockSize
										)
									}
								/>
							);
						break;
						case "仅位置":
						case "字节码":
						case "结构":
							//if(option=="结构"){
							//	trace("忽略");
							//}
							var tagXML:XML=tag.toXML(_toXMLOptions);
							if(tag.type==TagTypes.ShowFrame){
								tagXML.@frameId=frameIdDict[tag];
							}
							tagsXML.appendChild(tagXML);
							
							tagId++;
						break;
						default:
							throw new Error("未知 option："+option);
						break;
					}
				}else{
					return tagCount;
				}
			}
			
			return tagId;
		}
		////
		
		////
		public static function initByXML_step(
			tagV:Vector.<Tag>,
			nodeXMLList:XMLList,
			nodeId:int,
			nodeCount:int,
			timeLimit:int,//20110606 主要用于 DefineSprite 和 SWF 中减少瞬时调用 initByXML_step 的次数，以提高运行速度，对 SWFProgresser 基本不影响
			_initByXMLOptions:Object/*zero_swf_InitByXMLOptions*/
		):int{
			var t:int=getTimer();
			while(getTimer()-t<timeLimit){
				if(nodeId<nodeCount){
					var nodeXML:XML=nodeXMLList[nodeId];
					switch(nodeXML.name().toString()){
						case "block":
							var block_data:ByteArray;
							var block_data_value:String=nodeXML.@value.toString();
							var block_data_offset:int,block_data_endOffset:int;
							if(block_data_value){
								block_data=BytesAndStr16.str162bytes(block_data_value);
								block_data_offset=0;
								block_data_endOffset=block_data.length;
							}else{
								var src:String=nodeXML.@src.toString();
								if(src){
									if(_initByXMLOptions){
									}else{
										throw new Error("需要提供 _initByXMLOptions");
									}
									block_data=_initByXMLOptions.resData||_initByXMLOptions.getResDataFun(src);
									block_data_offset=int(nodeXML.@offset.toString());
									block_data_endOffset=block_data_offset+int(nodeXML.@length.toString());
								}else{
									block_data=new ByteArray();
									block_data_offset=0;
									block_data_endOffset=0;
								}
							}
							
							getTagsByData(tagV,block_data,block_data_offset,block_data_endOffset);
						break;
						default:
							var tag:Tag=new Tag();
							tag.initByXML(nodeXML,_initByXMLOptions);
							tagV[tagV.length]=tag;
						break;
					}
					nodeId++;
				}else{
					return nodeCount;
				}
			}
			return nodeId;
		}
		////
		
		}//end of CONFIG::USE_XML
	}
}
		