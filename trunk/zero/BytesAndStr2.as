/***
BytesAndStr2 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:28cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2009年12月2日 17:11:21
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero{
	import flash.utils.*;
	public class BytesAndStr2{
		public static const _2V:Vector.<String>=Vector.<String>([
			"00000000","00000001","00000010","00000011","00000100","00000101","00000110","00000111","00001000","00001001","00001010","00001011","00001100","00001101","00001110","00001111",
			"00010000","00010001","00010010","00010011","00010100","00010101","00010110","00010111","00011000","00011001","00011010","00011011","00011100","00011101","00011110","00011111",
			"00100000","00100001","00100010","00100011","00100100","00100101","00100110","00100111","00101000","00101001","00101010","00101011","00101100","00101101","00101110","00101111",
			"00110000","00110001","00110010","00110011","00110100","00110101","00110110","00110111","00111000","00111001","00111010","00111011","00111100","00111101","00111110","00111111",
			"01000000","01000001","01000010","01000011","01000100","01000101","01000110","01000111","01001000","01001001","01001010","01001011","01001100","01001101","01001110","01001111",
			"01010000","01010001","01010010","01010011","01010100","01010101","01010110","01010111","01011000","01011001","01011010","01011011","01011100","01011101","01011110","01011111",
			"01100000","01100001","01100010","01100011","01100100","01100101","01100110","01100111","01101000","01101001","01101010","01101011","01101100","01101101","01101110","01101111",
			"01110000","01110001","01110010","01110011","01110100","01110101","01110110","01110111","01111000","01111001","01111010","01111011","01111100","01111101","01111110","01111111",
			"10000000","10000001","10000010","10000011","10000100","10000101","10000110","10000111","10001000","10001001","10001010","10001011","10001100","10001101","10001110","10001111",
			"10010000","10010001","10010010","10010011","10010100","10010101","10010110","10010111","10011000","10011001","10011010","10011011","10011100","10011101","10011110","10011111",
			"10100000","10100001","10100010","10100011","10100100","10100101","10100110","10100111","10101000","10101001","10101010","10101011","10101100","10101101","10101110","10101111",
			"10110000","10110001","10110010","10110011","10110100","10110101","10110110","10110111","10111000","10111001","10111010","10111011","10111100","10111101","10111110","10111111",
			"11000000","11000001","11000010","11000011","11000100","11000101","11000110","11000111","11001000","11001001","11001010","11001011","11001100","11001101","11001110","11001111",
			"11010000","11010001","11010010","11010011","11010100","11010101","11010110","11010111","11011000","11011001","11011010","11011011","11011100","11011101","11011110","11011111",
			"11100000","11100001","11100010","11100011","11100100","11100101","11100110","11100111","11101000","11101001","11101010","11101011","11101100","11101101","11101110","11101111",
			"11110000","11110001","11110010","11110011","11110100","11110101","11110110","11110111","11111000","11111001","11111010","11111011","11111100","11111101","11111110","11111111"
		]);
		public static const _2Obj:Object=get_2Obj();
		private static function get_2Obj():Object{
			var _2Obj:Object=new Object();
			_2Obj["00000000"]=0x00;_2Obj["00000001"]=0x01;_2Obj["00000010"]=0x02;_2Obj["00000011"]=0x03;_2Obj["00000100"]=0x04;_2Obj["00000101"]=0x05;_2Obj["00000110"]=0x06;_2Obj["00000111"]=0x07;_2Obj["00001000"]=0x08;_2Obj["00001001"]=0x09;_2Obj["00001010"]=0x0a;_2Obj["00001011"]=0x0b;_2Obj["00001100"]=0x0c;_2Obj["00001101"]=0x0d;_2Obj["00001110"]=0x0e;_2Obj["00001111"]=0x0f;
			_2Obj["00010000"]=0x10;_2Obj["00010001"]=0x11;_2Obj["00010010"]=0x12;_2Obj["00010011"]=0x13;_2Obj["00010100"]=0x14;_2Obj["00010101"]=0x15;_2Obj["00010110"]=0x16;_2Obj["00010111"]=0x17;_2Obj["00011000"]=0x18;_2Obj["00011001"]=0x19;_2Obj["00011010"]=0x1a;_2Obj["00011011"]=0x1b;_2Obj["00011100"]=0x1c;_2Obj["00011101"]=0x1d;_2Obj["00011110"]=0x1e;_2Obj["00011111"]=0x1f;
			_2Obj["00100000"]=0x20;_2Obj["00100001"]=0x21;_2Obj["00100010"]=0x22;_2Obj["00100011"]=0x23;_2Obj["00100100"]=0x24;_2Obj["00100101"]=0x25;_2Obj["00100110"]=0x26;_2Obj["00100111"]=0x27;_2Obj["00101000"]=0x28;_2Obj["00101001"]=0x29;_2Obj["00101010"]=0x2a;_2Obj["00101011"]=0x2b;_2Obj["00101100"]=0x2c;_2Obj["00101101"]=0x2d;_2Obj["00101110"]=0x2e;_2Obj["00101111"]=0x2f;
			_2Obj["00110000"]=0x30;_2Obj["00110001"]=0x31;_2Obj["00110010"]=0x32;_2Obj["00110011"]=0x33;_2Obj["00110100"]=0x34;_2Obj["00110101"]=0x35;_2Obj["00110110"]=0x36;_2Obj["00110111"]=0x37;_2Obj["00111000"]=0x38;_2Obj["00111001"]=0x39;_2Obj["00111010"]=0x3a;_2Obj["00111011"]=0x3b;_2Obj["00111100"]=0x3c;_2Obj["00111101"]=0x3d;_2Obj["00111110"]=0x3e;_2Obj["00111111"]=0x3f;
			_2Obj["01000000"]=0x40;_2Obj["01000001"]=0x41;_2Obj["01000010"]=0x42;_2Obj["01000011"]=0x43;_2Obj["01000100"]=0x44;_2Obj["01000101"]=0x45;_2Obj["01000110"]=0x46;_2Obj["01000111"]=0x47;_2Obj["01001000"]=0x48;_2Obj["01001001"]=0x49;_2Obj["01001010"]=0x4a;_2Obj["01001011"]=0x4b;_2Obj["01001100"]=0x4c;_2Obj["01001101"]=0x4d;_2Obj["01001110"]=0x4e;_2Obj["01001111"]=0x4f;
			_2Obj["01010000"]=0x50;_2Obj["01010001"]=0x51;_2Obj["01010010"]=0x52;_2Obj["01010011"]=0x53;_2Obj["01010100"]=0x54;_2Obj["01010101"]=0x55;_2Obj["01010110"]=0x56;_2Obj["01010111"]=0x57;_2Obj["01011000"]=0x58;_2Obj["01011001"]=0x59;_2Obj["01011010"]=0x5a;_2Obj["01011011"]=0x5b;_2Obj["01011100"]=0x5c;_2Obj["01011101"]=0x5d;_2Obj["01011110"]=0x5e;_2Obj["01011111"]=0x5f;
			_2Obj["01100000"]=0x60;_2Obj["01100001"]=0x61;_2Obj["01100010"]=0x62;_2Obj["01100011"]=0x63;_2Obj["01100100"]=0x64;_2Obj["01100101"]=0x65;_2Obj["01100110"]=0x66;_2Obj["01100111"]=0x67;_2Obj["01101000"]=0x68;_2Obj["01101001"]=0x69;_2Obj["01101010"]=0x6a;_2Obj["01101011"]=0x6b;_2Obj["01101100"]=0x6c;_2Obj["01101101"]=0x6d;_2Obj["01101110"]=0x6e;_2Obj["01101111"]=0x6f;
			_2Obj["01110000"]=0x70;_2Obj["01110001"]=0x71;_2Obj["01110010"]=0x72;_2Obj["01110011"]=0x73;_2Obj["01110100"]=0x74;_2Obj["01110101"]=0x75;_2Obj["01110110"]=0x76;_2Obj["01110111"]=0x77;_2Obj["01111000"]=0x78;_2Obj["01111001"]=0x79;_2Obj["01111010"]=0x7a;_2Obj["01111011"]=0x7b;_2Obj["01111100"]=0x7c;_2Obj["01111101"]=0x7d;_2Obj["01111110"]=0x7e;_2Obj["01111111"]=0x7f;
			_2Obj["10000000"]=0x80;_2Obj["10000001"]=0x81;_2Obj["10000010"]=0x82;_2Obj["10000011"]=0x83;_2Obj["10000100"]=0x84;_2Obj["10000101"]=0x85;_2Obj["10000110"]=0x86;_2Obj["10000111"]=0x87;_2Obj["10001000"]=0x88;_2Obj["10001001"]=0x89;_2Obj["10001010"]=0x8a;_2Obj["10001011"]=0x8b;_2Obj["10001100"]=0x8c;_2Obj["10001101"]=0x8d;_2Obj["10001110"]=0x8e;_2Obj["10001111"]=0x8f;
			_2Obj["10010000"]=0x90;_2Obj["10010001"]=0x91;_2Obj["10010010"]=0x92;_2Obj["10010011"]=0x93;_2Obj["10010100"]=0x94;_2Obj["10010101"]=0x95;_2Obj["10010110"]=0x96;_2Obj["10010111"]=0x97;_2Obj["10011000"]=0x98;_2Obj["10011001"]=0x99;_2Obj["10011010"]=0x9a;_2Obj["10011011"]=0x9b;_2Obj["10011100"]=0x9c;_2Obj["10011101"]=0x9d;_2Obj["10011110"]=0x9e;_2Obj["10011111"]=0x9f;
			_2Obj["10100000"]=0xa0;_2Obj["10100001"]=0xa1;_2Obj["10100010"]=0xa2;_2Obj["10100011"]=0xa3;_2Obj["10100100"]=0xa4;_2Obj["10100101"]=0xa5;_2Obj["10100110"]=0xa6;_2Obj["10100111"]=0xa7;_2Obj["10101000"]=0xa8;_2Obj["10101001"]=0xa9;_2Obj["10101010"]=0xaa;_2Obj["10101011"]=0xab;_2Obj["10101100"]=0xac;_2Obj["10101101"]=0xad;_2Obj["10101110"]=0xae;_2Obj["10101111"]=0xaf;
			_2Obj["10110000"]=0xb0;_2Obj["10110001"]=0xb1;_2Obj["10110010"]=0xb2;_2Obj["10110011"]=0xb3;_2Obj["10110100"]=0xb4;_2Obj["10110101"]=0xb5;_2Obj["10110110"]=0xb6;_2Obj["10110111"]=0xb7;_2Obj["10111000"]=0xb8;_2Obj["10111001"]=0xb9;_2Obj["10111010"]=0xba;_2Obj["10111011"]=0xbb;_2Obj["10111100"]=0xbc;_2Obj["10111101"]=0xbd;_2Obj["10111110"]=0xbe;_2Obj["10111111"]=0xbf;
			_2Obj["11000000"]=0xc0;_2Obj["11000001"]=0xc1;_2Obj["11000010"]=0xc2;_2Obj["11000011"]=0xc3;_2Obj["11000100"]=0xc4;_2Obj["11000101"]=0xc5;_2Obj["11000110"]=0xc6;_2Obj["11000111"]=0xc7;_2Obj["11001000"]=0xc8;_2Obj["11001001"]=0xc9;_2Obj["11001010"]=0xca;_2Obj["11001011"]=0xcb;_2Obj["11001100"]=0xcc;_2Obj["11001101"]=0xcd;_2Obj["11001110"]=0xce;_2Obj["11001111"]=0xcf;
			_2Obj["11010000"]=0xd0;_2Obj["11010001"]=0xd1;_2Obj["11010010"]=0xd2;_2Obj["11010011"]=0xd3;_2Obj["11010100"]=0xd4;_2Obj["11010101"]=0xd5;_2Obj["11010110"]=0xd6;_2Obj["11010111"]=0xd7;_2Obj["11011000"]=0xd8;_2Obj["11011001"]=0xd9;_2Obj["11011010"]=0xda;_2Obj["11011011"]=0xdb;_2Obj["11011100"]=0xdc;_2Obj["11011101"]=0xdd;_2Obj["11011110"]=0xde;_2Obj["11011111"]=0xdf;
			_2Obj["11100000"]=0xe0;_2Obj["11100001"]=0xe1;_2Obj["11100010"]=0xe2;_2Obj["11100011"]=0xe3;_2Obj["11100100"]=0xe4;_2Obj["11100101"]=0xe5;_2Obj["11100110"]=0xe6;_2Obj["11100111"]=0xe7;_2Obj["11101000"]=0xe8;_2Obj["11101001"]=0xe9;_2Obj["11101010"]=0xea;_2Obj["11101011"]=0xeb;_2Obj["11101100"]=0xec;_2Obj["11101101"]=0xed;_2Obj["11101110"]=0xee;_2Obj["11101111"]=0xef;
			_2Obj["11110000"]=0xf0;_2Obj["11110001"]=0xf1;_2Obj["11110010"]=0xf2;_2Obj["11110011"]=0xf3;_2Obj["11110100"]=0xf4;_2Obj["11110101"]=0xf5;_2Obj["11110110"]=0xf6;_2Obj["11110111"]=0xf7;_2Obj["11111000"]=0xf8;_2Obj["11111001"]=0xf9;_2Obj["11111010"]=0xfa;_2Obj["11111011"]=0xfb;_2Obj["11111100"]=0xfc;_2Obj["11111101"]=0xfd;_2Obj["11111110"]=0xfe;_2Obj["11111111"]=0xff;
			return _2Obj;
		}
		
		public static function bytes2str2(bytes:ByteArray,offset:int,length:int):String{
			//输出字节数据的 2 进制形式
			
			var str:String="";
			while(--length>=0){
				str+=" "+_2V[bytes[offset++]];
			}
			return str.substr(1);
			
		}
		public static function str22bytes(str2:String):ByteArray{
			//根据一列 "xxxxxxxx xxxxxxxx xxxxxxxx xxxxxxxx ..." 得到对应的ByteArray
			var bytes:ByteArray=new ByteArray();
			if(str2){
				var i:int=0;
				for each(var str:String in str2.split(" ")){
					bytes[i++]=_2Obj[str];
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