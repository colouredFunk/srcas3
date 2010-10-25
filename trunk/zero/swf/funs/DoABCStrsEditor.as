/***
DoABCStrsEditor 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年6月13日 13:38:23
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package _swf._fun{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	import swf_encode_and_decode.Tag;
	import zero.swf.TagType;
	import zero.gettersetter.*;
	import zero.swf.ReservedStrs;
	public class DoABCStrsEditor{
		public var strV:Vector.<String>;
		private var startData:ByteArray;
		private var endData:ByteArray;
		public function DoABCStrsEditor(){
		}
		public function initByData(
			data:ByteArray,
			tag:Tag
		):void{
			//对 DoABC 或 DoABCWithoutFlagsAndName 进行解码:
			var offset:int;
			switch(tag.type){
				case TagType.DoABC:
					offset=tag.bodyOffset+4;//跳过 Flags
					STRINGGetter.getStr(data,offset);
					offset+=STRINGGetter.strSize;//跳过 Name
				break;
				case TagType.DoABCWithoutFlagsAndName:
					offset=tag.bodyOffset;
				break;
				default:
					throw new Error("不是 DoABC tag.type="+tag.type);
					return;
				break;
			}
			
			//从这里起是 ABCData
			var startOffset:int=offset;
			var endOffset:int=tag.bodyOffset+tag.bodyLength;
			
			offset=startOffset+4;//跳过 minor_version,major_version
			
			//从这里起是 Constant_pool
			var integer_count:int=UGetterAndSetter.getU(data,offset);
			if(integer_count>0){
				while(--integer_count>0){
					UGetterAndSetter.getU(data,UGetterAndSetter.offset);
				}
			}//跳过 integer_count 和 integer[integer_count]
			
			var uinteger_count:int=UGetterAndSetter.getU(data,UGetterAndSetter.offset);
			if(uinteger_count>0){
				while(--uinteger_count>0){
					UGetterAndSetter.getU(data,UGetterAndSetter.offset);
				}
			}//跳过 uinteger_count 和 uinteger[uinteger_count]
			
			var double_count:int=UGetterAndSetter.getU(data,UGetterAndSetter.offset);
			offset=UGetterAndSetter.offset;
			if(double_count>0){
				offset+=(double_count-1)*8;
			}//跳过 double_count 和 double[double_count]
			
			startData=new ByteArray();
			startData.writeBytes(data,tag.bodyOffset,offset-tag.bodyOffset);
			//到这里都是 string_count 前面的数据,原封不动存到 startData 里就可以了
			
			//从这里起是 string_count 和 string[string_count]
			var string_count:int=UGetterAndSetter.getU(data,offset)-1;
			offset=UGetterAndSetter.offset;
			if(string_count>0){
				strV=new Vector.<String>();
				for(var i:int=0;i<string_count;i++){
					var strSize:int=UGetterAndSetter.getU(data,offset);
					data.position=UGetterAndSetter.offset;
					strV[i]=data.readUTFBytes(strSize);
					offset=data.position;
				}
			}
			
			//从这里起是 namespace_count 及后面的数据,原封不动存到 endData 里就可以了
			endData=new ByteArray();
			endData.writeBytes(data,offset,endOffset-offset);
		}
		public function replaceStrs(str0Arr:Array,strtArr:Array):void{
			//替换字符串
			/*
			var strMark:Object={};
			var i:int=0;
			for each(var str0:String in str0Arr){
				trace("str0="+str0);
				if(ReservedStrs.checkIsReserved(str0)){
					trace(str0+" 是保留字不推荐替换");
				}else{
					strMark[str0]=strtArr[i++];
				}
			}
			
			i=strV.length;
			while(--i>=0){
				var str:String=strV[i];
				var strt:String=strMark[str];
				if(strt){
					strV[i]=strt;
				}
			}
			*/
			var i:int=0;
			for each(var str0:String in str0Arr){
				if(ReservedStrs.checkIsReserved(str0)){
					trace(str0+" 是保留字不推荐替换");
				}else{
					var id:int=strV.indexOf(str0);
					if(id>=0){
						strV[id]=strtArr[i];
					}
				}
				i++;
			}
		}
		public function toData():ByteArray{
			//编码
			var data:ByteArray=new ByteArray();
			data.writeBytes(startData);
			
			if(strV.length>0){
				var string_count:int=strV.length+1;
				UGetterAndSetter.setU(string_count,data,data.length);
				for each(var str:String in strV){
					var strData:ByteArray=new ByteArray();
					strData.writeUTFBytes(str);
					UGetterAndSetter.setU(strData.length,data,data.length);
					data.position=data.length;
					data.writeBytes(strData);
				}
			}else{
				data[data.length]=0;
				data.position=data.length;
			}
			
			data.writeBytes(endData);
			return data;
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