/***
MP3 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年2月7日 10:45:41
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

/*
MP3 文件大体分为三部分：TAG_V2(ID3V2)，音频数据，TAG_V1(ID3V1)
a). ID3V2 包含了作者，作曲，专辑等信息，长度不固定，扩展了ID3V1 的信息量。 
b). 一系列的帧，个数由文件大小和帧长决定。
. 每个帧的长度可能不固定，也可能固定，由位率bitrate 决定 
. 每个帧又分为帧头和数据实体两部分 
. 帧头记录了mp3 的位率，采样率，版本等信息，每个帧之间相互独立 
c). ID3V1 包含了作者，作曲，专辑等信息，长度为128Byte。
*/

package zero.mp3s{
	import flash.utils.*;
	public class MP3{
		private var id3V2:ID3V2;
		private var id3V1:ByteArray;
		private var frameV:Vector.<Frame>;
		public function MP3(){
			
		}
		public function initByMP3Data(mp3Data:ByteArray):void{
			mp3Data.position=0;
			var offset:int;
			if(mp3Data.readUTFBytes(3)=="ID3"){
				id3V2=new ID3V2();
				offset=id3V2.initByData(mp3Data,0,mp3Data.length);
			}else{
				offset=0;
			}
			frameV=new Vector.<Frame>();
			var frame:Frame;
			while(mp3Data[offset]==0xff){
				frameV.push(frame=new Frame());
				offset=frame.initByData(mp3Data,offset,mp3Data.length);
				trace("-----------------------------------------------------------------------------");
			}
			if(offset+3<=mp3Data.length){
				mp3Data.position=offset;
				if(mp3Data.readUTFBytes(3)=="TAG"){
					id3V1=new ByteArray();
					id3V1.writeBytes(mp3Data,offset,mp3Data.length-offset);
				}
			}
		}
		public function toMP3Data():ByteArray{
			return null;
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