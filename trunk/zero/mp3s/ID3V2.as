/***
ID3V2 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年2月7日 12:48:11
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

/*
ID3V2
ID3V2到现在一共有4个版本，但流行的播放软件一般只支持第3版，既ID3v2.3。
由于ID3V1记录在MP3文件的末尾，ID3V2就只好记录在MP3文件的首部了(如果有一天发布ID3V3，真不知道该记录在哪里)。
也正是由于这个原因，对ID3V2的操作比ID3V1要慢。
而且ID3V2结构比ID3V1的结构要复杂得多，但比前者全面且可以伸缩和扩展。
下面就介绍一下ID3V2.3。
每个ID3V2.3的标签都一个标签头和若干个标签帧或一个扩展标签头组成。
关于曲目的信息如标题、作者等都存放在不同的标签帧中，扩展标签头和标签帧并不是必要的，但每个标签至少要有一个标签帧。
标签头和标签帧一起顺序存放在MP3文件的首部。

一、标签头
在文件的首部顺序记录10个字节的ID3V2.3的头部。数据结构如下：
char Header[3];	//必须为"ID3"否则认为标签不存在
char Ver;		//版本号ID3V2.3就记录3
char Revision;	//副版本号此版本记录为0
char Flag;		//存放标志的字节，这个版本只定义了三位，稍后详细解说
char Size[4];	//标签大小，包括标签头的10个字节和所有的标签帧的大小

1.标志字节
标志字节一般为0，定义如下：
abc00000

a -- 表示是否使用Unsynchronisation(这个单词不知道是什么意思，字典里也没有找到，一般不设置)
b -- 表示是否有扩展头部，一般没有(至少Winamp没有记录)，所以一般也不设置
c -- 表示是否为测试标签(99.99%的标签都不是测试用的啦，所以一般也不设置)

2.标签大小
一共四个字节，但每个字节只用7位，最高位不使用恒为0。所以格式如下
0xxxxxxx 0xxxxxxx 0xxxxxxx 0xxxxxxx
计算大小时要将0去掉，得到一个28位的二进制数，就是标签大小(不懂为什么要这样做)，计算公式如下：
int total_size;
total_size =   (Size[0]&0x7F)*0x200000
+(Size[1]&0x7F)*0x400
+(Size[2]&0x7F)*0x80
+(Size[3]&0x7F)

*/

package zero.mp3s{
	import flash.utils.*;
	public class ID3V2{
		
		
		public var Ver:int;
		public var Revision:int;
		public var Flag:int;
		public var Size:int;
		
		public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			data.position=offset;
			if(data.readUTFBytes(3)=="ID3"){//Header
				offset+=3;
				Ver=data[offset++];
				if(Ver==3){
				}else{
					throw new Error("不支持的 Ver: "+Ver);
				}
				Revision=data[offset++];
				Flag=data[offset++];
				Size=((data[offset++]&0x7f)<<21)|
					((data[offset++]&0x7f)<<14)|
					((data[offset++]&0x7f)<<7)|
					(data[offset++]&0x7f);
				trace("id3v2.Size="+Size);
				
				offset+=Size;//后面的暂时不写直接跳过, 具体参考 "CSDN技术中心 ID3文件格式.mht"
			}
			return offset;
		}
		public function toData():ByteArray{
			return null;
		}
	}
}

