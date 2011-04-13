/***
SWF0 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年5月9日 23:04:24
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf{
	import flash.display.*;
	import flash.events.*;
	import flash.system.Capabilities;
	import flash.utils.*;
	
	import zero.Outputer;

	public class SWF0{
		public static var playerVersion:int;
		public static var baseInfoNameV:Vector.<String>;
		
		private static const firstInitResult:*=function():void{
			playerVersion=int(Capabilities.version.match(/\d+,/)[0].replace(",",""));//例如 WIN 10,0,22,91 抽出 10;
			baseInfoNameV=Vector.<String>([
				"type","Version"
			]);
		}();
		
		public var type:String;
		public var Version:int=playerVersion;
		public var FileLength:int;
		
		public var data:ByteArray;
		
		public function SWF0(
			_type:String="CWS",
			_Version:int=0
		){
			type=_type;
			Version=_Version>0?_Version:playerVersion;
		}
		public function copyBaseInfo(swf:SWF0):void{
			var swfBaseInfoNameV:Vector.<String>=swf["constructor"].baseInfoNameV;
			var baseInfoNameV:Vector.<String>=this["constructor"].baseInfoNameV;
			//trace("copyBaseInfo: ");
			for each(var baseInfoName:String in swfBaseInfoNameV){
				if(baseInfoNameV.indexOf(baseInfoName)==-1){
					
				}else{
					this[baseInfoName]=swf[baseInfoName];
					//trace(baseInfoName,swf[baseInfoName]);
				}
			}
		}
		
		public function initBySWFData(swfData:ByteArray):void{
			data=swfData2Data(swfData);
		}
		public function toSWFData():ByteArray{
			return data2SWFData(data);
		}
		
		public function swfData2Data(swfData:ByteArray):ByteArray{
			//输入一个有效的SWF文件数据，返回SWF文件第8字节后面的数据(如果是压缩影片则解压)
			if(swfData.length>8){
				swfData.position=0;
				type=swfData.readUTFBytes(3);//压缩和非压缩标记
				
				var data:ByteArray=new ByteArray();
				data.writeBytes(swfData,8);
				
				switch(type){
					case "CWS":
						try{
							data.uncompress();
						}catch(e:Error){
							throw new Error("CWS 解压缩数据时出错");
						}
					break;
					case "FWS":
					break;
					default:
						//throw new Error("不是有效的SWF文件");
						var outputData:ByteArray=new ByteArray();
						var outputLen:int=100;
						outputData.writeBytes(swfData,0,Math.min(outputLen,swfData.length));
						throw new Error(
							"不是有效的SWF文件: "+outputData+(
								outputLen<swfData.length
								?
								"..."
								:
								""
							)
						);
					break;
				}
				
				Version=swfData[3];//播放器版本
				
				FileLength=data.length+8;//SWF文件长度
				if(FileLength!=(swfData[4]|(swfData[5]<<8)|(swfData[6]<<16)|(swfData[7]<<24))){
					Outputer.output(
						"文件长度不符 FileLength="+FileLength+
						",ErrorFileLength="+(swfData[4]|(swfData[5]<<8)|(swfData[6]<<16)|(swfData[7]<<24))
					,"brown");
				}
				
				return data;
			}
			throw new Error("不是有效的SWF文件");
			return null;
		}
		public function data2SWFData(data:ByteArray):ByteArray{
			//输入SWF文件第8字节后面的数据(如果是压缩影片则压缩)，返回一个有效的SWF文件数据
			
			FileLength=data.length+8;
			
			var newData:ByteArray;
			if(type=="CWS"){
				newData=new ByteArray();
				newData.writeBytes(data);
				newData.compress();
			}else{
				newData=data;
			}
			
			var swfData:ByteArray=new ByteArray();
			swfData.writeUTFBytes(type);
			swfData[3]=Version;
			swfData[4]=FileLength;
			swfData[5]=FileLength>>8;
			swfData[6]=FileLength>>16;
			swfData[7]=FileLength>>24;
			swfData.position=8;
			swfData.writeBytes(newData);
			return swfData;
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