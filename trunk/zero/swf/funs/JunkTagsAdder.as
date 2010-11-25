/***
JunkTagsAdder 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年11月12日 19:37:18
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf.funs{
	import flash.utils.ByteArray;
	
	import zero.swf.*;
	
	public class JunkTagsAdder extends JunksAdder{
		public static function addJunkTags(swf:SWF2,total:int=10):void{
			if(total>swf.tagV.length){
				total=swf.tagV.length;
			}
			
			var actionLoopIdArr:Array=getIdArr(total,swf.tagV.length);
			
			var loopSpriteIdArr:Array=getIdArr(total,swf.tagV.length);
			
			//var emptySoundStreamBlockIdArr:Array=getIdArr(total,swf.tagV.length);
			var emptySoundStreamBlockSpriteIdArr:Array=getIdArr(total,swf.tagV.length);
			
			var avalibleDefineObjIdV:Vector.<int>=GetAvalibleDefineObjIdV.getAvalibleDefineObjIdV(swf.tagV);
			
			var i:int=swf.tagV.length;
			loop:while(--i>=0){
				var tag:Tag=swf.tagV[i];
				switch(tag.type){
					case TagType.End:
					break;
					case TagType.FileAttributes:
					case TagType.Metadata:
					case TagType.SetBackgroundColor:
					case TagType.EnableDebugger:
					case TagType.EnableDebugger2:
					case TagType.DebugID:
					case TagType.ScriptLimits:
					case TagType.ProductInfo:
						break loop;
					break;
					default:
						///*
						if(actionLoopIdArr[i]){
							swf.tagV.splice(i,0,getActionLoopTag());
						}
						//*/
						
						///*
						if(loopSpriteIdArr[i]){
							swf.tagV.splice(i,0,getLoopSpriteTag(avalibleDefineObjIdV.shift()));
						}
						//*/
						
						/*
						if(emptySoundStreamBlockIdArr[i]){
							//trace("能挂闪客精灵，但是 FlashPlayer 10 播放时会有 “啪” 的一声，而且让 FlashPlayer 9 和 8 挂了");
							
							//使 闪客精灵 挂掉的元素
							//一个空的 SoundStreamBlock:
							swf.tagV.splice(i,0,new Tag(TagType.SoundStreamBlock));
						}
						//*/
						if(emptySoundStreamBlockSpriteIdArr[i]){
							swf.tagV.splice(i,0,getEmptySoundStreamBlockSpriteTag(avalibleDefineObjIdV.shift()));
						}
						
					break;
				}
			}
		}
		
		private static function getActionLoopTag():Tag{
			var doActionTag:Tag=new Tag(TagType.DoAction);
			
			var data:ByteArray=new ByteArray();
			
			//ASV 会卡住
			//一个无限循环的DoAction:
			
			//return
			//label1:
			//branch label1
			
			data[0]=0x3e;
			data[1]=0x99;
			data[2]=0x02;
			data[3]=0x00;
			data[4]=0xfb;
			data[5]=0xff;
			data[6]=0x00;
			
			doActionTag.setBodyData(data);
			
			return doActionTag;
		}
		
		private static function getLoopSpriteTag(defId:int):Tag{
			var spriteTag:Tag=new Tag(TagType.DefineSprite);
			
			var data:ByteArray=new ByteArray();
			
			//ASV 会挂掉
			//一个循环引用的DefineSprite:
			
			data[0]=defId;
			data[1]=defId>>8;//sprite.id=defId
			
			data[2]=0x01;
			data[3]=0x00;//sprite.dataAndTags.FrameCount=1
			
			data[4]=0x05;
			data[5]=0x01;//placeObject header
			
			data[6]=defId;
			data[7]=defId>>8;//placeObject.CharacterId=defId，把自己 place 到自己里面
			
			data[8]=0x01;
			data[9]=0x00;//placeObject.Depth=1
			
			data[10]=0x00;//placeObject.MATRIX
			
			data[11]=0x40;
			data[12]=0x00;//ShowFrame
			
			data[13]=0x00;
			data[14]=0x00;//End
			
			spriteTag.setBodyData(data);
			
			return spriteTag;
		}
		
		private static function getEmptySoundStreamBlockSpriteTag(defId:int):Tag{
			var spriteTag:Tag=new Tag(TagType.DefineSprite);
			
			var data:ByteArray=new ByteArray();
			
			//闪客精灵 会挂掉
			//一个带空白SoundStreamBlock的DefineSprite:
			
			data[0]=defId;
			data[1]=defId>>8;//sprite.id=defId
			
			data[2]=0x01;
			data[3]=0x00;//sprite.dataAndTags.FrameCount=1
			
			data[4]=0xff;
			data[5]=0x04;
			data[6]=0x00;
			data[7]=0x00;
			data[8]=0x00;
			data[9]=0x00;//SoundStreamBlock header
			
			data[10]=0x40;
			data[11]=0x00;//ShowFrame
			
			data[12]=0x00;
			data[13]=0x00;//End
			
			spriteTag.setBodyData(data);
			
			return spriteTag;
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