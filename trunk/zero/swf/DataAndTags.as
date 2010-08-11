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
	public class DataAndTags{
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
		
		public var data:ByteArray;
		public var FrameCount:int;
		public var tagV:Vector.<Tag>;
		
		public function DataAndTags(){
			var defaultData:ByteArray=getDefaultData();
			initByData(defaultData,0,defaultData.length);
		}
		
		public function initByData(_data:ByteArray,offset:int,endOffset:int):void{
			data=_data;
			FrameCount=data[offset++]|(data[offset++]<<8);//帧数是一个int, 在SWF里以 UI16(Unsigned 16-bit integer value, 16位无符号整数) 的结构保存
			//trace("FrameCount="+FrameCount);
			tagV=new Vector.<Tag>();
			var tag:Tag;
			var tagId:int=-1;
			var realFrameCount:int=0;
			while(offset<endOffset){
				tagV[++tagId]=tag=new Tag();
				tag.initByData(data,offset);
				offset=tag.bodyOffset+tag.bodyLength;
				//trace(TagType.typeArr[tag.type]);
				if(tag.type==TagType.ShowFrame){
					realFrameCount++;
				}
			}
			if(FrameCount!=realFrameCount){
				trace("FrameCount="+FrameCount+",realFrameCount="+realFrameCount);
			}
			
			//trace("---------------------------------------");
		}
		public function getData(newData:ByteArray,offset:int):void{
			//trace("FrameCount="+FrameCount);
			var frameCountOffset:int=offset;
			newData.position=offset+2;
			var realFrameCount:int=0;
			for each(var tag:Tag in tagV){
				//trace(TagType.typeArr[tag.type]);
				tag.getNewDataByData(data,newData);
				if(tag.type==TagType.ShowFrame){
					realFrameCount++;
				}
			}
			FrameCount=realFrameCount;
			newData[frameCountOffset]=FrameCount;
			newData[frameCountOffset+1]=FrameCount>>8;
			
			//trace("---------------------------------------");
		}
		
		public function forEachTag(fun:Function):void{
			var tagId:int=tagV.length;
			while(--tagId>=0){
				fun(data,tagV[tagId],tagV,tagId);
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