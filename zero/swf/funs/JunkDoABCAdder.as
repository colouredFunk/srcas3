/***
JunkDoABCAdder
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月14日 18:53:47
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.swf.funs{
	
	import zero.*;
	import zero.ZeroCommon;
	import zero.swf.*;
	import zero.swf.tagBodys.*;
	
	public class JunkDoABCAdder{
		public static function addJunkDoABC(tagV:Vector.<Tag>):Boolean{
			//添加坏掉但不会被播放器运行到的 DoABC tag
			//如果是文档类可直接挂 ASV
			//如果是非文档类在点击查看代码时挂 ASV 和闪客精灵
			
			trace("暂时只支持搜索 SymbolClass 中的类名及只支持默认包下的类");
			
			var i:int;
			
			var tag:Tag;
			
			var firstDoABCTag:Tag=null;
			var DocClassName:String=null;
			var classNameV:Vector.<String>=new Vector.<String>();
			
			for each(tag in tagV){
				switch(tag.type){
					case TagTypes.DoABC:
					case TagTypes.DoABCWithoutFlagsAndName:
						if(firstDoABCTag){
						}else{
							firstDoABCTag=tag;
						}
					break;
					case TagTypes.SymbolClass:
						var symbolClass:SymbolClass=tag.getBody(null) as SymbolClass;
						i=0;
						for each(var Name:String in symbolClass.NameV){
							if(Name.indexOf(".")==-1){trace("未考虑 '::'");
								if(symbolClass.TagV[i]==0){
									DocClassName=Name;
								}else{
									classNameV.push(Name);
								}
							}
							i++;
						}
					break;
				}
			}
			
			if(firstDoABCTag){
				
				ZeroCommon.disorder(classNameV);
				
				var frontNameV:Vector.<String>=new Vector.<String>();
				var backNameV:Vector.<String>=new Vector.<String>();
				
				//尽量保证前面至少有一个
				if(DocClassName){
					frontNameV.push(DocClassName);
				}else if(classNameV.length){
					frontNameV.push(classNameV.pop());
				}
				
				if(classNameV.length){
					var ran:int=int(Math.random()*classNameV.length/2);
					frontNameV=frontNameV.concat(classNameV.slice(0,ran));
					backNameV=classNameV.slice(ran);
				}
				
				if(frontNameV.length&&backNameV.length){
					trace("frontNameV="+frontNameV);
					trace("backNameV="+backNameV);
					
					var avalibleDefineObjIdV:Vector.<int>=getAvalibleDefineObjIdV(tagV);
					
					var firstDoABCTagPos:int=tagV.indexOf(firstDoABCTag);
					tagV.splice(firstDoABCTagPos,1);
					
					var className:String;
					
					i=firstDoABCTagPos;
					
					for each(className in frontNameV){
						//放前面
						tagV.splice(i++,0,getJunkDoABCSpriteTag(avalibleDefineObjIdV.shift(),className));
					}
					
					tagV.splice(i++,0,firstDoABCTag);
					
					for each(className in backNameV){
						//放后面
						tagV.splice(i++,0,getJunkDoABCSpriteTag(avalibleDefineObjIdV.shift(),className));
					}
					
					return true;
				}else{
					trace("没有插入任何 JunkDoABCSpriteTag");
				}
			}else{
				trace("没有 DoABC Tag");
			}
			return false;
		}
		
		private static function getJunkDoABCSpriteTag(id:int,className:String,type:int=0):Tag{
			var defineSprite:DefineSprite=new DefineSprite();
			defineSprite.id=id;
			defineSprite.tagV=new Vector.<Tag>();
			switch(type){
				//可准备多种
				default:
					defineSprite.tagV[0]=getLoopGenericNameDoABCTag(className);
				break;
			}
			defineSprite.tagV[1]=new Tag(TagTypes.ShowFrame);
			defineSprite.tagV[2]=new Tag(TagTypes.End);
			var tag:Tag=new Tag();
			tag.setBody(defineSprite);
			return tag;
		}
		private static function getLoopGenericNameDoABCTag(className:String):Tag{
			//一个指向自己的 Vector.<XXX>
			return SimpleDoABC.getDoABCTag(
				className,
				"01 00 00 00 00 10 00 2e 00 00 00 00 0f 00 0a 43 6c 61 73 73 31 32 33 34 35 0d 66 6c 61 73 68 2e 64 69 73 70 6c 61 79 06 53 70 72 69 74 65 01 73 0b 5f 5f 41 53 33 5f 5f 2e 76 65 63 06 56 65 63 74 6f 72 06 53 74 72 69 6e 67 06 4f 62 6a 65 63 74 0c 66 6c 61 73 68 2e 65 76 65 6e 74 73 0f 45 76 65 6e 74 44 69 73 70 61 74 63 68 65 72 0d 44 69 73 70 6c 61 79 4f 62 6a 65 63 74 11 49 6e 74 65 72 61 63 74 69 76 65 4f 62 6a 65 63 74 16 44 69 73 70 6c 61 79 4f 62 6a 65 63 74 43 6f 6e 74 61 69 6e 65 72 07 16 01 16 03 18 02 05 00 16 06 16 0a 00 0c 07 01 02 07 02 04 07 04 05 07 05 07 07 01 08 1d 04 01 06 07 01 09 07 06 0b 07 02 0c 07 02 0d 07 02 0e 03 00 00 00 00 00 00 00 00 00 00 00 00 00 01 01 02 09 03 00 01 01 03 00 00 06 00 00 00 01 02 01 01 04 01 00 03 00 01 01 08 09 03 d0 30 47 00 00 01 01 01 09 0a 06 d0 30 d0 49 00 47 00 00 02 02 01 01 08 23 d0 30 65 00 60 07 30 60 08 30 60 09 30 60 0a 30 60 0b 30 60 02 30 60 02 58 00 1d 1d 1d 1d 1d 1d 68 01 47 00 00"
			);
		}
	}
}
		