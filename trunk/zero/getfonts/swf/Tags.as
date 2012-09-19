/***
Tags
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月9日 09:18:42
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.getfonts.swf{
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	import flash.utils.getDefinitionByName;
	
	import zero.output;
	import zero.outputError;
	
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
					//realFrameCount==0 多见于 连接了 AS2 类的 DefineSprite
					if(realFrameCount){
						output("FrameCount="+FrameCount+" 不正确\n修正为："+realFrameCount,"brown");
					}
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
					outputError("未知 type："+tag.type+"，typeName="+TagTypes.typeNameV[tag.type]);
				}
				
				if(tag.type==TagTypes.End){
					break;
				}
			}
			
			if(offset==endOffset){
			}else{
				output("getTagsByData offset="+offset+"，endOffset="+endOffset+"，offset!=endOffset","brown");
				if(offset>endOffset){
					tag.bodyLength+=endOffset-offset;
					output("修正最后一个 tag：tag.bodyLength="+tag.bodyLength,"brown");
				}else{
					outputError("offset="+offset+"，endOffset="+endOffset+"，offset!=endOffset");
				}
			}
		}
		
		public static function initByData_step(
			tagV:Vector.<Tag>,
			tagId:int,
			tagCount:int,
			timeLimit:int,//20110606 主要用于 DefineSprite 和 SWF 中减少瞬时调用 initByData_step 的次数，以提高运行速度，对 SWFProgresser 基本不影响
			_initByDataOptions:Object
		):int{
			if(_initByDataOptions&&_initByDataOptions.optionV){
			}else{
				return tagCount;
			}
			var t:int=getTimer();
			while(getTimer()-t<timeLimit){
				if(tagId<tagCount){
					var tag:Tag=tagV[tagId];
					var _option:String;
					if(tag.type<256){
						_option=_initByDataOptions.optionV[tag.type]
					}else{
						_option="字节码";
					}
					switch(_option){
						case "数据块（仅位置）":
						case "数据块（字节码）":
						case "仅位置":
						case "字节码":
							//trace("忽略");
						break;
						case "结构":
							var TagBodyClassName:String="zero.swf.tagBodys."+TagTypes.typeNameV[tag.type];
							tag.getBody((_initByDataOptions.classes&&_initByDataOptions.classes[TagBodyClassName]||getDefinitionByName(TagBodyClassName)) as Class,_initByDataOptions);
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
			_toDataOptions:Object
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
	}
}
		