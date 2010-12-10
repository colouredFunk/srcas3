/***
BytesAndStr16 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2009年11月19日 09:33:59
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero{
	import flash.utils.*;
	public class BytesAndStr16{
		public static const _16V:Vector.<String>=Vector.<String>([
			"00","01","02","03","04","05","06","07","08","09","0a","0b","0c","0d","0e","0f",
			"10","11","12","13","14","15","16","17","18","19","1a","1b","1c","1d","1e","1f",
			"20","21","22","23","24","25","26","27","28","29","2a","2b","2c","2d","2e","2f",
			"30","31","32","33","34","35","36","37","38","39","3a","3b","3c","3d","3e","3f",
			"40","41","42","43","44","45","46","47","48","49","4a","4b","4c","4d","4e","4f",
			"50","51","52","53","54","55","56","57","58","59","5a","5b","5c","5d","5e","5f",
			"60","61","62","63","64","65","66","67","68","69","6a","6b","6c","6d","6e","6f",
			"70","71","72","73","74","75","76","77","78","79","7a","7b","7c","7d","7e","7f",
			"80","81","82","83","84","85","86","87","88","89","8a","8b","8c","8d","8e","8f",
			"90","91","92","93","94","95","96","97","98","99","9a","9b","9c","9d","9e","9f",
			"a0","a1","a2","a3","a4","a5","a6","a7","a8","a9","aa","ab","ac","ad","ae","af",
			"b0","b1","b2","b3","b4","b5","b6","b7","b8","b9","ba","bb","bc","bd","be","bf",
			"c0","c1","c2","c3","c4","c5","c6","c7","c8","c9","ca","cb","cc","cd","ce","cf",
			"d0","d1","d2","d3","d4","d5","d6","d7","d8","d9","da","db","dc","dd","de","df",
			"e0","e1","e2","e3","e4","e5","e6","e7","e8","e9","ea","eb","ec","ed","ee","ef",
			"f0","f1","f2","f3","f4","f5","f6","f7","f8","f9","fa","fb","fc","fd","fe","ff"
		]);
		public static const _16Obj:Object=function():Object{
			var _16Obj:Object=new Object();
			_16Obj["00"]=0x00;_16Obj["01"]=0x01;_16Obj["02"]=0x02;_16Obj["03"]=0x03;_16Obj["04"]=0x04;_16Obj["05"]=0x05;_16Obj["06"]=0x06;_16Obj["07"]=0x07;_16Obj["08"]=0x08;_16Obj["09"]=0x09;_16Obj["0a"]=0x0a;_16Obj["0b"]=0x0b;_16Obj["0c"]=0x0c;_16Obj["0d"]=0x0d;_16Obj["0e"]=0x0e;_16Obj["0f"]=0x0f;
			_16Obj["10"]=0x10;_16Obj["11"]=0x11;_16Obj["12"]=0x12;_16Obj["13"]=0x13;_16Obj["14"]=0x14;_16Obj["15"]=0x15;_16Obj["16"]=0x16;_16Obj["17"]=0x17;_16Obj["18"]=0x18;_16Obj["19"]=0x19;_16Obj["1a"]=0x1a;_16Obj["1b"]=0x1b;_16Obj["1c"]=0x1c;_16Obj["1d"]=0x1d;_16Obj["1e"]=0x1e;_16Obj["1f"]=0x1f;
			_16Obj["20"]=0x20;_16Obj["21"]=0x21;_16Obj["22"]=0x22;_16Obj["23"]=0x23;_16Obj["24"]=0x24;_16Obj["25"]=0x25;_16Obj["26"]=0x26;_16Obj["27"]=0x27;_16Obj["28"]=0x28;_16Obj["29"]=0x29;_16Obj["2a"]=0x2a;_16Obj["2b"]=0x2b;_16Obj["2c"]=0x2c;_16Obj["2d"]=0x2d;_16Obj["2e"]=0x2e;_16Obj["2f"]=0x2f;
			_16Obj["30"]=0x30;_16Obj["31"]=0x31;_16Obj["32"]=0x32;_16Obj["33"]=0x33;_16Obj["34"]=0x34;_16Obj["35"]=0x35;_16Obj["36"]=0x36;_16Obj["37"]=0x37;_16Obj["38"]=0x38;_16Obj["39"]=0x39;_16Obj["3a"]=0x3a;_16Obj["3b"]=0x3b;_16Obj["3c"]=0x3c;_16Obj["3d"]=0x3d;_16Obj["3e"]=0x3e;_16Obj["3f"]=0x3f;
			_16Obj["40"]=0x40;_16Obj["41"]=0x41;_16Obj["42"]=0x42;_16Obj["43"]=0x43;_16Obj["44"]=0x44;_16Obj["45"]=0x45;_16Obj["46"]=0x46;_16Obj["47"]=0x47;_16Obj["48"]=0x48;_16Obj["49"]=0x49;_16Obj["4a"]=0x4a;_16Obj["4b"]=0x4b;_16Obj["4c"]=0x4c;_16Obj["4d"]=0x4d;_16Obj["4e"]=0x4e;_16Obj["4f"]=0x4f;
			_16Obj["50"]=0x50;_16Obj["51"]=0x51;_16Obj["52"]=0x52;_16Obj["53"]=0x53;_16Obj["54"]=0x54;_16Obj["55"]=0x55;_16Obj["56"]=0x56;_16Obj["57"]=0x57;_16Obj["58"]=0x58;_16Obj["59"]=0x59;_16Obj["5a"]=0x5a;_16Obj["5b"]=0x5b;_16Obj["5c"]=0x5c;_16Obj["5d"]=0x5d;_16Obj["5e"]=0x5e;_16Obj["5f"]=0x5f;
			_16Obj["60"]=0x60;_16Obj["61"]=0x61;_16Obj["62"]=0x62;_16Obj["63"]=0x63;_16Obj["64"]=0x64;_16Obj["65"]=0x65;_16Obj["66"]=0x66;_16Obj["67"]=0x67;_16Obj["68"]=0x68;_16Obj["69"]=0x69;_16Obj["6a"]=0x6a;_16Obj["6b"]=0x6b;_16Obj["6c"]=0x6c;_16Obj["6d"]=0x6d;_16Obj["6e"]=0x6e;_16Obj["6f"]=0x6f;
			_16Obj["70"]=0x70;_16Obj["71"]=0x71;_16Obj["72"]=0x72;_16Obj["73"]=0x73;_16Obj["74"]=0x74;_16Obj["75"]=0x75;_16Obj["76"]=0x76;_16Obj["77"]=0x77;_16Obj["78"]=0x78;_16Obj["79"]=0x79;_16Obj["7a"]=0x7a;_16Obj["7b"]=0x7b;_16Obj["7c"]=0x7c;_16Obj["7d"]=0x7d;_16Obj["7e"]=0x7e;_16Obj["7f"]=0x7f;
			_16Obj["80"]=0x80;_16Obj["81"]=0x81;_16Obj["82"]=0x82;_16Obj["83"]=0x83;_16Obj["84"]=0x84;_16Obj["85"]=0x85;_16Obj["86"]=0x86;_16Obj["87"]=0x87;_16Obj["88"]=0x88;_16Obj["89"]=0x89;_16Obj["8a"]=0x8a;_16Obj["8b"]=0x8b;_16Obj["8c"]=0x8c;_16Obj["8d"]=0x8d;_16Obj["8e"]=0x8e;_16Obj["8f"]=0x8f;
			_16Obj["90"]=0x90;_16Obj["91"]=0x91;_16Obj["92"]=0x92;_16Obj["93"]=0x93;_16Obj["94"]=0x94;_16Obj["95"]=0x95;_16Obj["96"]=0x96;_16Obj["97"]=0x97;_16Obj["98"]=0x98;_16Obj["99"]=0x99;_16Obj["9a"]=0x9a;_16Obj["9b"]=0x9b;_16Obj["9c"]=0x9c;_16Obj["9d"]=0x9d;_16Obj["9e"]=0x9e;_16Obj["9f"]=0x9f;
			_16Obj["a0"]=0xa0;_16Obj["a1"]=0xa1;_16Obj["a2"]=0xa2;_16Obj["a3"]=0xa3;_16Obj["a4"]=0xa4;_16Obj["a5"]=0xa5;_16Obj["a6"]=0xa6;_16Obj["a7"]=0xa7;_16Obj["a8"]=0xa8;_16Obj["a9"]=0xa9;_16Obj["aa"]=0xaa;_16Obj["ab"]=0xab;_16Obj["ac"]=0xac;_16Obj["ad"]=0xad;_16Obj["ae"]=0xae;_16Obj["af"]=0xaf;
			_16Obj["b0"]=0xb0;_16Obj["b1"]=0xb1;_16Obj["b2"]=0xb2;_16Obj["b3"]=0xb3;_16Obj["b4"]=0xb4;_16Obj["b5"]=0xb5;_16Obj["b6"]=0xb6;_16Obj["b7"]=0xb7;_16Obj["b8"]=0xb8;_16Obj["b9"]=0xb9;_16Obj["ba"]=0xba;_16Obj["bb"]=0xbb;_16Obj["bc"]=0xbc;_16Obj["bd"]=0xbd;_16Obj["be"]=0xbe;_16Obj["bf"]=0xbf;
			_16Obj["c0"]=0xc0;_16Obj["c1"]=0xc1;_16Obj["c2"]=0xc2;_16Obj["c3"]=0xc3;_16Obj["c4"]=0xc4;_16Obj["c5"]=0xc5;_16Obj["c6"]=0xc6;_16Obj["c7"]=0xc7;_16Obj["c8"]=0xc8;_16Obj["c9"]=0xc9;_16Obj["ca"]=0xca;_16Obj["cb"]=0xcb;_16Obj["cc"]=0xcc;_16Obj["cd"]=0xcd;_16Obj["ce"]=0xce;_16Obj["cf"]=0xcf;
			_16Obj["d0"]=0xd0;_16Obj["d1"]=0xd1;_16Obj["d2"]=0xd2;_16Obj["d3"]=0xd3;_16Obj["d4"]=0xd4;_16Obj["d5"]=0xd5;_16Obj["d6"]=0xd6;_16Obj["d7"]=0xd7;_16Obj["d8"]=0xd8;_16Obj["d9"]=0xd9;_16Obj["da"]=0xda;_16Obj["db"]=0xdb;_16Obj["dc"]=0xdc;_16Obj["dd"]=0xdd;_16Obj["de"]=0xde;_16Obj["df"]=0xdf;
			_16Obj["e0"]=0xe0;_16Obj["e1"]=0xe1;_16Obj["e2"]=0xe2;_16Obj["e3"]=0xe3;_16Obj["e4"]=0xe4;_16Obj["e5"]=0xe5;_16Obj["e6"]=0xe6;_16Obj["e7"]=0xe7;_16Obj["e8"]=0xe8;_16Obj["e9"]=0xe9;_16Obj["ea"]=0xea;_16Obj["eb"]=0xeb;_16Obj["ec"]=0xec;_16Obj["ed"]=0xed;_16Obj["ee"]=0xee;_16Obj["ef"]=0xef;
			_16Obj["f0"]=0xf0;_16Obj["f1"]=0xf1;_16Obj["f2"]=0xf2;_16Obj["f3"]=0xf3;_16Obj["f4"]=0xf4;_16Obj["f5"]=0xf5;_16Obj["f6"]=0xf6;_16Obj["f7"]=0xf7;_16Obj["f8"]=0xf8;_16Obj["f9"]=0xf9;_16Obj["fa"]=0xfa;_16Obj["fb"]=0xfb;_16Obj["fc"]=0xfc;_16Obj["fd"]=0xfd;_16Obj["fe"]=0xfe;_16Obj["ff"]=0xff;
			return _16Obj;
		}()
		
		public static function bytes2str16(bytes:ByteArray,offset:int,length:int):String{
			//输出字节数据的 16 进制形式
			
			var str:String="";
			while(--length>=0){
				str+=" "+_16V[bytes[offset++]];
			}
			return str.substr(1);
			
		}
		public static function str162bytes(str16:String):ByteArray{
			//根据一列 "xx xx xx xx ..." 得到对应的ByteArray
			var bytes:ByteArray=new ByteArray();
			if(str16){
				var i:int=0;
				for each(var str:String in str16.split(" ")){
					bytes[i++]=_16Obj[str];
				}
			}
			return bytes;
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