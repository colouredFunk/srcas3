/***
RateTable 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年2月7日 14:04:15
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

暂时不用
package _mp3{
	import flash.utils.*;
	public class RateTable{
		public static const bitrateTable:Vector.<Vector.<Vector.<int>>>=Vector.<Vector.<Vector.<int>>>([
			Vector.<Vector.<int>>([Vector.<int>([0,0,0,0]),Vector.<int>([0,0,0,0]),Vector.<int>([0,0,0,0]),Vector.<int>([0,0,0,0])]),
			Vector.<Vector.<int>>([Vector.<int>([32000,8000,8000,32000]),Vector.<int>([32000,32000,32000,32000]),Vector.<int>([32000,8000,8000,32000]),Vector.<int>([32000,32000,32000,32000])]),
			Vector.<Vector.<int>>([Vector.<int>([16000,16000,16000,48000]),Vector.<int>([16000,16000,16000,48000]),Vector.<int>([16000,16000,16000,48000]),Vector.<int>([40000,40000,48000,64000])]),
			Vector.<Vector.<int>>([Vector.<int>([24000,24000,24000,56000]),Vector.<int>([24000,24000,24000,56000]),Vector.<int>([24000,24000,24000,56000]),Vector.<int>([48000,48000,56000,96000])]),
			Vector.<Vector.<int>>([Vector.<int>([32000,32000,32000,64000]),Vector.<int>([32000,32000,32000,64000]),Vector.<int>([32000,32000,32000,64000]),Vector.<int>([56000,56000,64000,128000])]),
			Vector.<Vector.<int>>([Vector.<int>([40000,40000,40000,80000]),Vector.<int>([40000,40000,40000,80000]),Vector.<int>([40000,40000,40000,80000]),Vector.<int>([64000,64000,80000,160000])]),
			Vector.<Vector.<int>>([Vector.<int>([48000,48000,48000,96000]),Vector.<int>([48000,48000,48000,96000]),Vector.<int>([48000,48000,48000,96000]),Vector.<int>([80000,80000,96000,192000])]),
			Vector.<Vector.<int>>([Vector.<int>([56000,56000,56000,112000]),Vector.<int>([56000,56000,56000,112000]),Vector.<int>([56000,56000,56000,112000]),Vector.<int>([96000,96000,112000,224000])]),
			Vector.<Vector.<int>>([Vector.<int>([64000,64000,64000,128000]),Vector.<int>([64000,64000,64000,128000]),Vector.<int>([64000,64000,64000,128000]),Vector.<int>([112000,112000,128000,256000])]),
			Vector.<Vector.<int>>([Vector.<int>([80000,80000,80000,144000]),Vector.<int>([80000,80000,80000,144000]),Vector.<int>([80000,80000,80000,144000]),Vector.<int>([128000,128000,160000,288000])]),
			Vector.<Vector.<int>>([Vector.<int>([96000,96000,96000,160000]),Vector.<int>([96000,96000,96000,160000]),Vector.<int>([96000,96000,96000,160000]),Vector.<int>([160000,160000,192000,320000])]),
			Vector.<Vector.<int>>([Vector.<int>([112000,112000,112000,176000]),Vector.<int>([112000,112000,112000,176000]),Vector.<int>([112000,112000,112000,176000]),Vector.<int>([192000,192000,224000,352000])]),
			Vector.<Vector.<int>>([Vector.<int>([128000,128000,128000,192000]),Vector.<int>([128000,128000,128000,192000]),Vector.<int>([128000,128000,128000,192000]),Vector.<int>([224000,224000,256000,384000])]),
			Vector.<Vector.<int>>([Vector.<int>([144000,144000,144000,224000]),Vector.<int>([144000,144000,144000,224000]),Vector.<int>([144000,144000,144000,224000]),Vector.<int>([256000,256000,320000,416000])]),
			Vector.<Vector.<int>>([Vector.<int>([160000,160000,160000,256000]),Vector.<int>([160000,160000,160000,256000]),Vector.<int>([160000,160000,160000,256000]),Vector.<int>([320000,320000,384000,448000])]),
			null
		]);
		
		public static const frequencyTable:Vector.<Vector.<int>>=Vector.<Vector.<int>>([
			Vector.<int>([11025,12000,8000,0]),
			null,
			Vector.<int>([22050,24000,16000,0]),
			Vector.<int>([44100,48000,32000,0])
		]);

		//参考的 读取MP3文件信息的代码.mht
		public static function getCodes():void{
			var codeArr:Array=new Array();
			for(var bitrateId:int=0x0;bitrateId<=0xf;bitrateId++){
				var subCodeArr:Array=new Array();
				for(var version:int=1;version<=2;version++){//2和2.5是一样的
					var subSubCodeArr:Array=new Array();
					for(var layer:int=1;layer<=3;layer++){
						subSubCodeArr.push(getCodes_getBitrate(bitrateId,version,layer));
					}
					subCodeArr.push("Vector.<int>(["+subSubCodeArr.join(",")+"])");
				}
				codeArr.push("Vector.<Vector.<int>>(["+subCodeArr.join(",")+"])");
			}
			trace("public static const bitrateTable:Vector.<Vector.<Vector.<int>>>=Vector.<Vector.<Vector.<int>>>([\n\t"+codeArr.join(",\n\t")+"\n]);");
			
			codeArr=new Array();
			for(var frequencyId:int=0;frequencyId<=3;frequencyId++){
				subCodeArr=new Array();
				for(version=1;version<=3;version++){
					subCodeArr.push(getCodes_getFrequency(version,frequencyId));
				}
				codeArr.push("Vector.<int>(["+subCodeArr.join(",")+"])");
			}
			trace("\npublic static const frequencyTable:Vector.<Vector.<int>>=Vector.<Vector.<int>>([\n\t"+codeArr.join(",\n\t")+"\n]);");
		}
		
		private static const getCodes_str2V:Vector.<String>=Vector.<String>(["00","01","10","11"]);
		
		private static function getCodes_getFrequency($version:int,frequencyId:int):String{
			var $sample:String="";
			
			// Determine Sample Rate 
			switch ($version) 
			{ 
				case 0:
					$sample="-1";
				break;
				case 1: 
					switch (getCodes_str2V[frequencyId]) 
					{ 
						case "00": 
							$sample="44100"; 
							break; 
						case "01": 
							$sample="48000"; 
							break; 
						case "10": 
							$sample="32000"; 
							break; 
						case "11": 
							$sample="0"; 
							break; 
					} 
					break; 
				case 2: 
					switch (getCodes_str2V[frequencyId]) 
					{ 
						case "00": 
							$sample="22050"; 
							break; 
						case "01": 
							$sample="24000"; 
							break; 
						case "10": 
							$sample="16000"; 
							break; 
						case "11": 
							$sample="0"; 
							break; 
					} 
					break; 
				case 3: 
					switch (getCodes_str2V[frequencyId]) 
					{ 
						case "00": 
							$sample="11025"; 
							break; 
						case "01": 
							$sample="12000"; 
							break; 
						case "10": 
							$sample="8000"; 
							break; 
						case "11": 
							$sample="0"; 
							break; 
					} 
					break; 
			} 
			
			
			if($sample){
				return $sample;
			}
			throw new Error("$sample==\"\"");
			return null;
		}
		
		private static function getCodes_getBitrate(bitrateId:int,$version:int,$layer:int):String{
			var $index:String;
			var $bitrate:String="";
			
			if (($version==1)&&($layer==1)) 
			{ 
				$index="1"; 
			} 
			else if (($version==1)&&($layer==2)) 
			{ 
				$index="2"; 
			} 
			else if ($version==1) 
			{ 
				$index="3"; 
			} 
			else if ($layer==1) 
			{ 
				$index="4"; 
			} 
			else     
			{ 
				$index="5"; 
			} 
			
			var bitrateStr:String=bitrateId.toString(2);
			while(bitrateStr.length<4){
				bitrateStr="0"+bitrateStr;
			}
			
			switch (bitrateStr) 
			{ 
				case "0000": 
					$bitrate="0"; 
				break; 
				case "0001": 
					if (($layer>1)&&($version>1)) 
					{ 
						$bitrate="8000"; 
					} 
					else 
					{ 
						$bitrate="32000"; 
					} 
				break; 
				case "0010": 
					switch ($index) 
					{ 
						case "1": 
							$bitrate="64000"; 
						break; 
						case "2": 
							$bitrate="48000"; 
						break; 
						case "3": 
							$bitrate="40000"; 
						break; 
						case "4": 
							$bitrate="48000"; 
						break; 
						case "5": 
							$bitrate="16000"; 
						break; 
					} 
				break; 
				case "0011": 
					switch ($index) 
					{ 
						case "1": 
							$bitrate="96000"; 
							break; 
						case "2": 
							$bitrate="56000"; 
							break; 
						case "3": 
							$bitrate="48000"; 
							break; 
						case "4": 
							$bitrate="56000"; 
							break; 
						case "5": 
							$bitrate="24000"; 
							break; 
					} 
				break; 
				case "0100": 
					switch ($index) 
					{ 
						case "1": 
							$bitrate="128000"; 
							break; 
						case "2": 
							$bitrate="64000"; 
							break; 
						case "3": 
							$bitrate="56000"; 
							break; 
						case "4": 
							$bitrate="64000"; 
							break; 
						case "5": 
							$bitrate="32000"; 
							break; 
					} 
				break; 
				case "0101": 
					switch ($index) 
					{ 
						case "1": 
							$bitrate="160000"; 
							break; 
						case "2": 
							$bitrate="80000"; 
							break; 
						case "3": 
							$bitrate="64000"; 
							break; 
						case "4": 
							$bitrate="80000"; 
							break; 
						case "5": 
							$bitrate="40000"; 
							break; 
					} 
				break; 
				case "0110": 
					switch ($index) 
					{ 
						case "1": 
							$bitrate="192000"; 
							break; 
						case "2": 
							$bitrate="96000"; 
							break; 
						case "3": 
							$bitrate="80000"; 
							break; 
						case "4": 
							$bitrate="96000"; 
							break; 
						case "5": 
							$bitrate="48000"; 
							break; 
					} 
				break; 
				case "0111": 
					switch ($index) 
					{ 
						case "1": 
							$bitrate="224000"; 
							break; 
						case "2": 
							$bitrate="112000"; 
							break; 
						case "3": 
							$bitrate="96000"; 
							break; 
						case "4": 
							$bitrate="112000"; 
							break; 
						case "5": 
							$bitrate="56000"; 
							break; 
					} 
				break; 
				case "1000": 
					switch ($index) 
					{ 
						case "1": 
							$bitrate="256000"; 
							break; 
						case "2": 
							$bitrate="128000"; 
							break; 
						case "3": 
							$bitrate="112000"; 
							break; 
						case "4": 
							$bitrate="128000"; 
							break; 
						case "5": 
							$bitrate="64000"; 
							break; 
					} 
				break; 
				case "1001": 
					switch ($index) 
					{ 
						case "1": 
							$bitrate="288000"; 
							break; 
						case "2": 
							$bitrate="160000"; 
							break; 
						case "3": 
							$bitrate="128000"; 
							break; 
						case "4": 
							$bitrate="144000"; 
							break; 
						case "5": 
							$bitrate="80000"; 
							break; 
					} 
				break; 
				case "1010": 
					switch ($index) 
					{ 
						case "1": 
							$bitrate="320000"; 
							break; 
						case "2": 
							$bitrate="192000"; 
							break; 
						case "3": 
							$bitrate="160000"; 
							break; 
						case "4": 
							$bitrate="160000"; 
							break; 
						case "5": 
							$bitrate="96000"; 
							break; 
					} 
				break; 
				case "1011": 
					switch ($index) 
					{ 
						case "1": 
							$bitrate="352000"; 
							break; 
						case "2": 
							$bitrate="224000"; 
							break; 
						case "3": 
							$bitrate="192000"; 
							break; 
						case "4": 
							$bitrate="176000"; 
							break; 
						case "5": 
							$bitrate="112000"; 
							break; 
					} 
				break; 
				case "1100": 
					switch ($index) 
					{ 
						case "1": 
							$bitrate="384000"; 
							break; 
						case "2": 
							$bitrate="256000"; 
							break; 
						case "3": 
							$bitrate="224000"; 
							break; 
						case "4": 
							$bitrate="192000"; 
							break; 
						case "5": 
							$bitrate="128000"; 
							break; 
					} 
				break; 
				case "1101": 
					switch ($index) 
					{ 
						case "1": 
							$bitrate="416000"; 
							break; 
						case "2": 
							$bitrate="320000"; 
							break; 
						case "3": 
							$bitrate="256000"; 
							break; 
						case "4": 
							$bitrate="224000"; 
							break; 
						case "5": 
							$bitrate="144000"; 
							break; 
					} 
				break; 
				case "1110": 
					switch ($index) 
					{ 
						case "1": 
							$bitrate="448000"; 
							break; 
						case "2": 
							$bitrate="384000"; 
							break; 
						case "3": 
							$bitrate="320000"; 
							break; 
						case "4": 
							$bitrate="256000"; 
							break; 
						case "5": 
							$bitrate="160000"; 
							break; 
					} 
				break; 
				case "1111": 
					$bitrate="-1"; 
				break; 
				default:
					throw new Error("奇怪的 bitrateStr:"+bitrateStr);
				break;
			} 
			
			if($bitrate){
				return $bitrate;
			}
			throw new Error("$bitrate==\"\"");
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