/***
ACTIONRECORD 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年8月31日 14:22:20
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf.avm1{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	
	public class ACTIONRECORD{
		public static var actionRecordV:Vector.<ACTIONRECORD>;
		public static function reset():void{
			actionRecordV=new Vector.<ACTIONRECORD>();
		}
		public static function clear():void{
			actionRecordV=null;
		}
		
		public var codeArr:Array;
		public function ACTIONRECORD(){
			if(actionRecordV){
				actionRecordV[actionRecordV.length]=this;
			}
		}
		
		public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			var labelId:int=0;
			var labelMarkArr:Array=new Array();
			var codeByOffsetArr:Array=new Array();
			var code:*;
			
			while(offset<endOffset){
				var pos:int=offset;
				var op:int=data[offset++];
				var opName:String=Op.opNameV[op];
				
				var get_str_size:int;
				
				//测试
				//trace("pos="+pos+",opName="+opName);
				code=null;
				//
				
				if(opName){
					if(op<0x80){
						code=op;
						trace("--"+opName);
					}else{
						var Length:int=data[offset++]|(data[offset++]<<8);
						switch(op){
							//0x80
							case Op.gotoFrame:
								//_gotoFrame instructs Flash Player to go to the specified frame in the current file.
								//Field 				Type 					Comment
								//_gotoFrame 		ACTIONRECORDHEADER 		ActionCode = 0x81; Length is always 2
								//Frame 				UI16 					Frame index
								
								code=new ActionRecordObj(op,data[offset++]|(data[offset++]<<8));
							break;
							//0x82
							case Op.getURL:
								//_getURL instructs Flash Player to get the URL that UrlString specifies. The URL can
								//be of any type, including an HTML file, an image or another SWF file. If the file is playing in
								//a browser, the URL is displayed in the frame that TargetString specifies. The "_level0" and
								//"_level1" special target names are used to load another SWF file into levels 0 and 1
								//respectively.
								
								//Field 			Type 				Comment
								//_getURL 		ACTIONRECORDHEADER 	ActionCode = 0x83
								//UrlString 		STRING 				Target URL string
								//TargetString 		STRING 				Target string
								
								get_str_size=0;
								while(data[offset+(get_str_size++)]){}
								data.position=offset;
								code=new ActionRecordObj(op,{UrlString:data.readUTFBytes(get_str_size)});
								offset+=get_str_size;
								
								get_str_size=0;
								while(data[offset+(get_str_size++)]){}
								data.position=offset;
								code.value.TargetString=data.readUTFBytes(get_str_size);
								offset+=get_str_size;
							break;
							//0x84
							//0x85
							//0x86
							break;
							case Op.setRegister:
								//_setRegister reads the next object from the stack (without popping it) and stores it in
								//one of four registers. If _function2 is used, up to 256 registers are available.
								//Field 				Type 					Comment
								//_setRegister 	ACTIONRECORDHEADER 		ActionCode = 0x87
								//RegisterNumber 		UI8
								
								code=new ActionRecordObj(op,data[offset++]);
							break;
							case Op.constants:
								//_constants
								//_constants creates a new constant pool, and replaces the old constant pool if one already exists.
								//Field 				Type 				Comment
								//_constants 			ACTIONRECORDHEADER 	ActionCode = 0x88
								//Count 				UI16 				Number of _constants to follow
								//_constants 			STRING[Count] 		String _constants
								
								var Count:int=data[offset++]|(data[offset++]<<8);
								code=new ActionRecordObj(op,new Vector.<String>());
								for(var i:int=0;i<Count;i++){
									get_str_size=0;
									while(data[offset+(get_str_size++)]){}
									data.position=offset;
									code.value[i]=data.readUTFBytes(get_str_size);
									//trace('"'+code.value[i]+'"');
									offset+=get_str_size;
								}
							break;
							//0x89
							case Op.ifFrameLoaded:
								//_ifFrameLoaded instructs Flash Player to wait until the specified frame; otherwise skips the specified number of actions.
								//Field 				Type 				Comment
								//_ifFrameLoaded 	ACTIONRECORDHEADER 	ActionCode = 0x8A; Length is always 3
								//Frame 				UI16 				Frame to wait for
								//SkipCount 			UI8 				Number of actions to skip if frame is not loaded
								
								code=new ActionRecordObj(op,{
									Frame:data[offset++]|(data[offset++]<<8),
									SkipCount:data[offset++]
								});
							break;
							case Op.setTarget:
								//_setTarget instructs Flash Player to change the context of subsequent actions, so they
								//apply to a named object (TargetName) rather than the current file.
								//For example, the SetTarget action can be used to control the Timeline of a sprite object. The
								//following sequence of actions sends a sprite called "spinner" to the first frame in its
								//Timeline:
								//1. SetTarget "spinner"
								//2. GotoFrame zero
								//3. SetTarget " " (empty string)
								//4. End of actions. (Action code = 0)
								//All actions following SetTarget “spinner” apply to the spinner object until SetTarget “”,
								//which sets the action context back to the current file. For a complete discussion of target
								//names see DefineSprite.
								
								//Field 			Type 					Comment
								//_setTarget 	ACTIONRECORDHEADER 		ActionCode = 0x8B
								//TargetName 		STRING 					Target of action target
								
								get_str_size=0;
								while(data[offset+(get_str_size++)]){}
								data.position=offset;
								code=new ActionRecordObj(op,data.readUTFBytes(get_str_size));
								offset+=get_str_size;
							break;
							case Op.gotoLabel:
								//_goToLabel instructs Flash Player to go to the frame associated with the specified label.
								//You can attach a label to a frame with the FrameLabel tag.
								//Field 			Type 				Comment
								//_goToLabel 	ACTIONRECORDHEADER 	ActionCode = 0x8C
								//Label 			STRING 				Frame label
								
								get_str_size=0;
								while(data[offset+(get_str_size++)]){}
								data.position=offset;
								code=new ActionRecordObj(op,data.readUTFBytes(get_str_size));
								offset+=get_str_size;
							break;
							case Op.ifFrameLoadedExpr:
								//_ifFrameLoadedExpr waits for a frame to be loaded and is stack based.
								//Field 				Type 				Comment
								//_ifFrameLoadedExpr 	ACTIONRECORDHEADER 	ActionCode = 0x8D; Length is always 1
								//SkipCount 			UI8 				The number of actions to skip
								
								code=new ActionRecordObj(op,data[offset++]);
							break;
							case Op.function2:
								////arObj=new ActionRecordObj_function2(data,offset,endOffset2);
							break;
							case Op.try_:
								////arObj=new ActionRecordObj_try(data,offset,endOffset2);
							break;
							//0x90
							//0x91
							//0x92
							//0x93
							case Op.with_:
								////arObj=new ActionRecordObj_with(data,offset,endOffset2);
							break;
							//0x95
							case Op.push:
								////arObj=new ActionRecordObj_push(data,offset,endOffset2);
							break;
							//0x97
							//0x98
							case Op.branch:
								//_branch creates an unconditional branch.
								//Field 		Type 				Comment
								//_branch 	ACTIONRECORDHEADER 	ActionCode = 0x99
								//BranchOffset 	SI16 				Offset
								
							case Op.branchIfTrue:	
								//_if creates a conditional test and branch.
								//Field 		Type 				Comment
								//_if 		ACTIONRECORDHEADER 	ActionCode = 0x9D
								//BranchOffset 	SI16 				Offset
								
								/*
								var label:int=data[offset]|(data[offset+1]<<8);
								if(label>>>15){//如果是负数(最高位是1表示负数)补足32位
									label|=0xffff0000;
								}
								arObj=new ActionRecordObj_value(label);
								*/
							break;
							case Op.getURL2:
								////arObj=new ActionRecordObj_getURL2(data,offset,endOffset2);
							break;
							case Op.function_:
								////arObj=new ActionRecordObj_function(data,offset,endOffset2);
							break;
							//0x9c
							//case Op.branchIfTrue:
							//break;
							case Op.callFrame:
								//_callFrame calls a subroutine.
								//Field 			Type 				Comment
								//_callFrame 		ACTIONRECORDHEADER 	ActionCode = 0x9E
								////arObj=new ActionRecordObj();
							break;
							case Op.gotoFrame2:
								////arObj=new ActionRecordObj_gotoFrame2(data,offset,endOffset2);
							break;
							//0xa0
							//0xa1
							//0xa2
							//0xa3
							//0xa4
							//0xa5
							//0xa6
							//0xa7
							//0xa8
							//0xa9
							//0xaa
							//0xab
							//0xac
							//0xad
							//0xae
							//0xaf
							//0xb0
							//0xb1
							//0xb2
							//0xb3
							//0xb4
							//0xb5
							//0xb6
							//0xb7
							//0xb8
							//0xb9
							//0xba
							//0xbb
							//0xbc
							//0xbd
							//0xbe
							//0xbf
							//0xc0
							//0xc1
							//0xc2
							//0xc3
							//0xc4
							//0xc5
							//0xc6
							//0xc7
							//0xc8
							//0xc9
							//0xca
							//0xcb
							//0xcc
							//0xcd
							//0xce
							//0xcf
							//0xd0
							//0xd1
							//0xd2
							//0xd3
							//0xd4
							//0xd5
							//0xd6
							//0xd7
							//0xd8
							//0xd9
							//0xda
							//0xdb
							//0xdc
							//0xdd
							//0xde
							//0xdf
							//0xe0
							//0xe1
							//0xe2
							//0xe3
							//0xe4
							//0xe5
							//0xe6
							//0xe7
							//0xe8
							//0xe9
							//0xea
							//0xeb
							//0xec
							//0xed
							//0xee
							//0xef
							//0xf0
							//0xf1
							//0xf2
							//0xf3
							//0xf4
							//0xf5
							//0xf6
							//0xf7
							//0xf8
							//0xf9
							//0xfa
							//0xfb
							//0xfc
							//0xfd
							//0xfe
							//0xff
						}
						trace("--"+code);
						if(offset==pos+3+Length){
						}else{
							//trace("offset 不正确, offset="+offset);
							offset=pos+3+Length;
							//trace("已修正为: "+offset);
						}
					}
					
				}else{
					throw new Error("未知 op: "+op);
				}
			}
			return endOffset;
		}
		public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			return data;
		}
		
		////
		CONFIG::toXMLAndInitByXML {
		public function toXML(xmlName:String):XML{
			return <{xmlName}/>;
		}
		public function initByXML(xml:XML):void{
		}
		}//end of CONFIG::toXMLAndInitByXML
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