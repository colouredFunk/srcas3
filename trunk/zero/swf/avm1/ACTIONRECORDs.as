/***
ACTIONRECORDs 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年8月31日 14:22:20
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
//Actions are an essential part of an interactive SWF file. Actions allow a file to react to events
//such as mouse movements or mouse clicks. The SWF 3 action model and earlier supports a
//simple action model. The SWF 4 action model supports a greatly enhanced action model that
//includes an expression evaluator, variables, and conditional branching and looping. The
//SWF 5 action model adds a JavaScript-style object model, data types, and functions.
//
//DoAction
//DoAction instructs Flash Player to perform a list of actions when the current frame is
//complete. The actions are performed when the ShowFrame tag is encountered, regardless of
//where in the frame the DoAction tag appears.
//Starting with SWF 9, if the ActionScript3 field of the FileAttributes tag is 1, the contents of
//the DoAction tag will be ignored.
//
//Field 			Type 							Comment
//Header 			RECORDHEADER 					Tag type = 12
//Actions 			ACTIONRECORD [zero or more] 	List of actions to perform (see following table, ActionRecord)
//ActionEndFlag 	UI8 = 0 						Always set to 0
//
//ACTIONRECORD
//An ACTIONRECORD consists of an ACTIONRECORDHEADER followed by a possible
//data payload. The ACTIONRECORDHEADER describes the action using an ActionCode.
//If the action also carries data, the ActionCode's high bit will be set which indicates that the
//ActionCode is followed by a 16-bit length and a data payload. Note that many actions have
//no data payload and only consist of a single byte value.
//An ACTIONRECORDHEADER has the following layout:
//Field 			Type 					Comment
//ActionCode 		UI8 					An action code
//Length 			If code >= 0x80, UI16 	The number of bytes in the ACTIONRECORDHEADER, not counting the ActionCode and Length fields.
package zero.swf.avm1{
	import flash.utils.ByteArray;
	import zero.BytesAndStr16;
	import zero.ComplexString;
	import zero.Outputer;
	import zero.swf.codes.Code;
	import zero.swf.codes.LabelMark;
	public class ACTIONRECORDs{//implements I_zero_swf_CheckCodesRight{
		private var hexArr:Array;//只用于 toXML 20110528
		public var codeArr:Array;
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object/*zero_swf_InitByDataOptions*/):int{
			var labelId:int=-1;
			var labelByPosArr:Array=new Array();
			var codeByPosArr:Array=new Array();
			if(_initByDataOptions&&_initByDataOptions.ActionsGetHexArr){
				var hexByPosArr:Array=new Array();
			}
			
			var code_value:*;
			var Length:int;
			
			var jumpOffset:int,jumpPos:int,i:int;
			var skipId:int,skipLength:int;
			
			var get_str_size:int;
			
			var constStrV:Vector.<String>;
			
			var flags:int;
			var NumParams:int;
			
			var startOffset:int=offset;
			
			while(offset<endOffset){
				var pos:int=offset;
				var op:int=data[offset++];
				
				if(op<0x80){
					codeByPosArr[pos]=op;
					if(AVM1Ops.opNameV[op]){
					}else{
						Outputer.outputError("未知 op: "+op);
					}
				}else{
					switch(op){
						case AVM1Ops.call://0x9e	//
							//ActionCall
							//ActionCall calls a subroutine.
							//Field 				Type 					Comment
							//ActionCall 			ACTIONRECORDHEADER 		ActionCode = 0x9E
							//ActionCall does the following:
							//1. Pops a value off the stack.
							//This value should be either a string that matches a frame label, or a number that indicates
							//a frame number. The value can be prefixed by a target string that identifies the movie clip
							//that contains the frame being called.
							//2. If the frame is successfully located, the actions in the target frame are executed.
							//After the actions in the target frame are executed, execution resumes at the instruction
							//after the ActionCall instruction.
							//3. If the frame cannot be found, nothing happens.
							
							///
							offset+=2;//Length==0
							
							///
							codeByPosArr[pos]=new Code(op);
							
							///
						
						break;
						case AVM1Ops.storeRegister://0x87	//UI8
							//ActionStoreRegister
							//ActionStoreRegister reads the next object from the stack (without popping it) and stores it in
							//one of four registers. If ActionDefineFunction2 is used, up to 256 registers are available.
							//Field 				Type 					Comment
							//ActionStoreRegister 	ACTIONRECORDHEADER 		ActionCode = 0x87
							//RegisterNumber 		UI8
							//ActionStoreRegister parses register number from the StoreRegister tag.
							
							///
							offset+=2;//Length==1
							
							///
							codeByPosArr[pos]=new Code(op,data[offset++]);
							
							///
							
						break;
						case AVM1Ops.gotoFrame://0x81	//UI16
							//ActionGotoFrame
							//ActionGotoFrame instructs Flash Player to go to the specified（指定） frame in the current file.
							//Field 				Type 					Comment
							//ActionGotoFrame 		ACTIONRECORDHEADER 		ActionCode = 0x81; Length is always 2
							//Frame 				UI16 					Frame index
							
							///
							offset+=2;//Length==2
							
							///
							codeByPosArr[pos]=new Code(op,data[offset++]|(data[offset++]<<8));
							
							///
							
						break;
						case AVM1Ops.gotoFrame2://0x9f	//UB[8],UI16
							//ActionGotoFrame2
							//ActionGotoFrame2 goes to a frame and is stack based.
							//Field 				Type 						Comment
							//ActionGotoFrame2 		ACTIONRECORDHEADER 			ActionCode = 0x9F
							//Reserved 				UB[6] 						Always 0
							//SceneBiasFlag 		UB[1] 						Scene bias flag
							//Play flag 			UB[1] 						0 = Go to frame and stop
							//													1 = Go to frame and play
							//SceneBias 			If SceneBiasFlag = 1, UI16 	Number to be added to frame determined by stack argument
							//ActionGotoFrame2 does the following:
							//1. Pops a frame off the stack.
							//■ If the frame is a number, n, the next frame of the movie to be displayed is the nth
							//frame in the current movie clip.
							//■ If the frame is a string, frame is treated as a frame label. If the specified label exists in
							//the current movie clip, the labeled frame will become the current frame. Otherwise,
							//the action is ignored.
							//2. Either a frame or a number can be prefixed by a target path, for example, /MovieClip:3 or
							///MovieClip:FrameLabel.
							//3. If the Play flag is set, the action goes to the specified frame and begins playing the enclosing
							//movie clip. Otherwise, the action goes to the specified frame and stops.
							
							///
							offset+=2;//Length==1或3
							
							///
							flags=data[offset++];
							code_value={
								Play:((flags&0x01)?true:false)				//00000001
							};
							//Reserved=flags&0xfc;							//11111100
							if(flags&0x02){//SceneBiasFlag					//00000010
								code_value.SceneBias=data[offset++]|(data[offset++]<<8);
							}
							codeByPosArr[pos]=new Code(op,code_value);
							
							///
							
						break;
						case AVM1Ops.setTarget://0x8b	//STRING
							//ActionSetTarget
							//ActionSetTarget instructs Flash Player to change the context of subsequent（随后） actions, so they
							//apply to a named object (TargetName) rather than the current file.
							//For example, the SetTarget action can be used to control the Timeline of a sprite object. The
							//following sequence of actions sends a sprite called "spinner" to the first frame in its
							//Timeline:
							//1. SetTarget "spinner"
							//2. GotoFrame zero
							//3. SetTarget " " (empty string)
							//4. End of actions. (Action code = 0)
							//All actions following SetTarget "spinner" apply to the spinner object until SetTarget "",
							//which sets the action context back to the current file. For a complete discussion of target
							//names see DefineSprite.
							//Field 				Type 					Comment
							//ActionSetTarget 		ACTIONRECORDHEADER 		ActionCode = 0x8B
							//TargetName 			STRING 					Target of action target
						case AVM1Ops.gotoLabel://0x8c	//STRING
							//ActionGoToLabel
							//ActionGoToLabel instructs Flash Player to go to the frame associated with the specified label.
							//You can attach a label to a frame with the FrameLabel tag.
							//Field 				Type 					Comment
							//ActionGoToLabel 		ACTIONRECORDHEADER 		ActionCode = 0x8C
							//Label 				STRING 					Frame label
							
							///
							Length=data[offset++]|(data[offset++]<<8);
							
							///
							data.position=offset;
							codeByPosArr[pos]=new Code(op,data.readUTFBytes(Length));
							offset+=Length;
							
							///
						
						break;
						
						case AVM1Ops.waitForFrame://0x8a	//UI16,UI8(label)
							//ActionWaitForFrame
							//ActionWaitForFrame instructs Flash Player to wait until the specified frame; otherwise skips
							//the specified number of actions.
							//Field 				Type 					Comment
							//ActionWaitForFrame 	ACTIONRECORDHEADER 		ActionCode = 0x8A; Length is always 3
							//Frame 				UI16 					Frame to wait for
							//SkipCount 			UI8 					Number of actions to skip if frame is not loaded
							
							///
							offset+=2;//Length==3
							
							///
							code_value={
								Frame:data[offset++]|(data[offset++]<<8)
							};
							
							skipId=data[offset++];
							jumpPos=offset;
							while(--skipId>=0){
								if(data[jumpPos++]<0x80){//skipOp
								}else{
									skipLength=data[jumpPos++]|(data[jumpPos++]<<8);
									jumpPos+=skipLength;
								}
							}
							trace("data="+BytesAndStr16.bytes2str16(data,offset,jumpPos-offset));
							if(jumpPos<0||jumpPos>endOffset){
								jumpPos=endOffset;
								Outputer.output("jumpPos 已修正为: "+jumpPos,"brown");
							}
							code_value.label=(labelByPosArr[jumpPos]||(labelByPosArr[jumpPos]=new LabelMark(++labelId)));
							codeByPosArr[pos]=new Code(op,code_value);
							
							///
							
						break;
						case AVM1Ops.waitForFrame2://0x8d	//UI8(label)
							//ActionWaitForFrame2
							//ActionWaitForFrame2 waits for a frame to be loaded and is stack based.
							//Field 				Type 					Comment
							//ActionWaitForFrame2 	ACTIONRECORDHEADER 		ActionCode = 0x8D; Length is always 1
							//SkipCount 			UI8 					The number of actions to skip
							//ActionWaitForFrame2 does the following:
							//1. Pops a frame off the stack.
							//2. If the frame is loaded, skip the next n actions that follow the current action, where n is
							//indicated by SkipCount.
							//The frame is evaluated in the same way as ActionGotoFrame2.
							
							///
							offset+=2;//Length==1
							
							///
							skipId=data[offset++];
							jumpPos=offset;
							while(--skipId>=0){
								if(data[jumpPos++]<0x80){//skipOp
								}else{
									skipLength=data[jumpPos++]|(data[jumpPos++]<<8);
									jumpPos+=skipLength;
								}
							}
							if(jumpPos<0||jumpPos>endOffset){
								jumpPos=endOffset;
								Outputer.output("jumpPos 已修正为: "+jumpPos,"brown");
							}
							codeByPosArr[pos]=new Code(op,labelByPosArr[jumpPos]||(labelByPosArr[jumpPos]=new LabelMark(++labelId)));
							
							///
							
						break;
						case AVM1Ops.with_://0x94	//UI16(label)
							//ActionWith
							//Defines a With block of script.
							//Field 				Type 					Comment
							//ActionWith 			ACTIONRECORDHEADER 		ActionCode = 0x94
							//Size 					UI16 					# of bytes of code that follow
							//ActionWith does the following:
							//1. Pops the object involved with the With.
							//2. Parses the size (body length) of the With block from the ActionWith tag.
							//3. Checks to see if the depth of calls exceeds the maximum depth, which is 16 for SWF 6 and
							//later, and 8 for SWF 5.
							//If the With depth exceeds the maximum depth, the next Size bytes of data are skipped
							//rather than executed.
							//4. After the ActionWith tag, the next Size bytes of action codes are considered to be the body
							//of the With block.
							//5. Adds the With block to the scope chain.
							
							///
							offset+=2;//Length==2
							
							///
							jumpOffset=data[offset++]|(data[offset++]<<8);//其实不是 jump
							jumpPos=offset+jumpOffset;//offset+Size
							if(jumpPos<0||jumpPos>endOffset){
								jumpPos=endOffset;
								Outputer.output("jumpPos 已修正为: "+jumpPos,"brown");
							}
							codeByPosArr[pos]=new Code(op,labelByPosArr[jumpPos]||(labelByPosArr[jumpPos]=new LabelMark(++labelId)));
							
							///
							
						break;
						case AVM1Ops.jump://0x99	//SI16(label)
							//ActionJump
							//ActionJump creates an unconditional branch.
							//Field 				Type 					Comment
							//ActionJump 			ACTIONRECORDHEADER 		ActionCode = 0x99
							//BranchOffset 			SI16 					Offset
							//ActionJump adds BranchOffset bytes to the instruction pointer in the execution stream.
							//The offset is a signed quantity, enabling branches from –32,768 bytes to 32,767 bytes. An
							//offset of 0 points to the action directly after the ActionJump action.
						case AVM1Ops.if_://0x9d		//SI16(label)
							//ActionIf
							//ActionIf creates a conditional test and branch.
							//Field 				Type 					Comment
							//ActionIf 				ACTIONRECORDHEADER 		ActionCode = 0x9D
							//BranchOffset 			SI16 					Offset
							//ActionIf does the following:
							//1. Pops Condition, a number, off the stack.
							//2. Converts Condition to a Boolean value.
							//3. Tests if Condition is true.
							//If Condition is true, BranchOffset bytes are added to the instruction pointer in the
							//execution stream.
							//NOTE
							//When playing a SWF 4 file, Condition is not converted to a Boolean value and is
							//instead compared to 0, not true.
							//The offset is a signed quantity, enabling branches from –32768 bytes to 32767 bytes. An
							//offset of 0 points to the action directly after the ActionIf action.
							
							///
							offset+=2;//Length==2
							
							///
							jumpOffset=data[offset++]|(data[offset++]<<8);
							if(jumpOffset&0x00008000){jumpOffset|=0xffff0000}//最高位为1,表示负数
							jumpPos=offset+jumpOffset;
							if(jumpPos<0||jumpPos>endOffset){
								jumpPos=endOffset;
								Outputer.output("jumpPos 已修正为: "+jumpPos,"brown");
							}
							codeByPosArr[pos]=new Code(op,labelByPosArr[jumpPos]||(labelByPosArr[jumpPos]=new LabelMark(++labelId)));
							
							///
							
						break;
						
						case AVM1Ops.getURL://0x83	//STRING,STRING
							//ActionGetURL
							//ActionGetURL instructs Flash Player to get the URL that UrlString specifies. The URL can
							//be of any type, including an HTML file, an image or another SWF file. If the file is playing in
							//a browser, the URL is displayed in the frame that TargetString specifies. The "_level0" and
							//"_level1" special target names are used to load another SWF file into levels 0 and 1 respectively.
							//Field 				Type 					Comment
							//ActionGetURL 			ACTIONRECORDHEADER 		ActionCode = 0x83
							//UrlString 			STRING 					Target URL string
							//TargetString 			STRING 					Target string
							
							///
							Length=data[offset++]|(data[offset++]<<8);
							
							///
							get_str_size=0;
							while(data[offset+(get_str_size++)]){}
							data.position=offset;
							code_value={
								UrlString:data.readUTFBytes(get_str_size)
							};
							offset+=get_str_size;
							get_str_size=0;
							while(data[offset+(get_str_size++)]){}
							data.position=offset;
							code_value.TargetString=data.readUTFBytes(get_str_size);
							offset+=get_str_size;
							codeByPosArr[pos]=new Code(op,code_value);
							
							///
							if(offset==pos+3+Length){
							}else{
								trace("offset 不正确, offset="+offset);
								offset=pos+3+Length;
								trace("已修正为: "+offset);
							}
							
						break;
						case AVM1Ops.getURL2://0x9a	//UB[8]
							//ActionGetURL2
							//ActionGetURL2 gets a URL and is stack based.
							//Field 				Type 				Comment
							//ActionGetURL2 		ACTIONRECORDHEADER 	ActionCode = 0x9A; Length is always 1
							//SendVarsMethod 		UB[2] 				0 = None
							//											1 = GET
							//											2 = POST
							//Reserved 				UB[4] 				Always 0
							//LoadTargetFlag 		UB[1] 				0 = Target is a browser window
							//											1 = Target is a path to a sprite
							//LoadVariablesFlag 	UB[1] 				0 = No variables to load
							//											1 = Load variables
							//ActionGetURL2 does the following:
							//1. Pops target off the stack.
							//■ A LoadTargetFlag value of 0 indicates that the target is a window. The target can be an
							//empty string to indicate the current window.
							//■ A LoadTargetFlag value of 1 indicates that the target is a path to a sprite. The target
							//path can be in slash or dot syntax.
							//2. Pops a URL off the stack; the URL specifies the URL to be retrieved.
							//3. SendVarsMethod specifies the method to use for the HTTP request.
							//■ A SendVarsMethod value of 0 indicates that this is not a form request, so the movie
							//clip's variables should not be encoded and submitted.
							//■ A SendVarsMethod value of 1 specifies a HTTP GET request.
							//■ A SendVarsMethod value of 2 specifies a HTTP POST request.
							//4. If the SendVarsMethod value is 1 (GET) or 2 (POST), the variables in the current movie
							//clip are submitted to the URL by using the standard x-www-form-urlencoded encoding
							//and the HTTP request method specified by method.
							//If the LoadVariablesFlag is set, the server is expected to respond with a MIME type of
							//application/x-www-form-urlencoded and a body in the format
							//var1=value1&var2=value2&...&varx=valuex. This response is used to populate
							//ActionScript variables rather than display a document. The variables populated can be in a
							//timeline (if LoadTargetFlag is 0) or in the specified sprite (if LoadTargetFlag is 1).
							//If the LoadTargetFlag is specified without the LoadVariablesFlag, the server is expected to
							//respond with a MIME type of application/x-shockwave-flash and a body that consists of a
							//SWF file. This response is used to load a subfile into the specified sprite rather than to display
							//an HTML document.
							
							//文档有错：
							
							//9a 01 00 00	getURL(url,target);
							//9a 01 00 01	getURL(url,target,"get");
							//9a 01 00 02	getURL(url,target,"post");
							//9a 01 00 03	getURL(url,target);
							
							//9a 01 00 40	loadMovie(url,mc);
							//9a 01 00 41	loadMovie(url,mc,"get");
							//9a 01 00 42	loadMovie(url,mc,"post");
							//9a 01 00 43	loadMovie(url,mc);
							
							//9a 01 00 80	loadVariablesNum(url,num);
							//9a 01 00 81	loadVariablesNum(url,num,"get");
							//9a 01 00 82	loadVariablesNum(url,num,"post");
							//9a 01 00 83	loadVariablesNum(url,num);
							
							//9a 01 00 c0	loadVariables(url,mc);
							//9a 01 00 c1	loadVariables(url,mc,"get");
							//9a 01 00 c2	loadVariables(url,mc,"post");
							//9a 01 00 c3	loadVariables(url,mc);
							
							///
							offset+=2;//Length==1
							
							///
							flags=data[offset++];
							code_value={
								LoadVariablesFlag:((flags&0x80)?true:false)			//10000000
							};
							code_value.LoadTargetFlag=((flags&0x40)?true:false);		//01000000
							//Reserved=flags&0x3c;										//00111100
							code_value.SendVarsMethod=flags&0x03;						//00000011
							codeByPosArr[pos]=new Code(op,code_value);
							
							///
							
						break;
						
						case AVM1Ops.constantPool://0x88	//UI16,STRING[Count]
							//ActionConstantPool
							//ActionConstantPool creates a new constant pool, and replaces the old constant pool if one
							//already exists.
							//Field 				Type 					Comment
							//ActionConstantPool 	ACTIONRECORDHEADER 		ActionCode = 0x88
							//Count 				UI16 					Number of constants to follow
							//ConstantPool 			STRING[Count] 			String constants
							
							///
							Length=data[offset++]|(data[offset++]<<8);
							
							///
							constStrV=new Vector.<String>();
							var Count:int=data[offset++]|(data[offset++]<<8);
							for(i=0;i<Count;i++){
								get_str_size=0;
								while(data[offset+(get_str_size++)]){}
								data.position=offset;
								constStrV[i]=data.readUTFBytes(get_str_size);
								offset+=get_str_size;
							}
							codeByPosArr[pos]=new Code(op,constStrV);
							
							///
							if(offset==pos+3+Length){
							}else{
								trace("offset 不正确, offset="+offset);
								offset=pos+3+Length;
								trace("已修正为: "+offset);
							}
							
						break;
						case AVM1Ops.push://0x96	//(UI8,STRING|FLOAT|UI8|DOUBLE|UI32|UI16)s
							//ActionPush
							//ActionPush pushes one or more values to the stack.
							//Field 				Type 					Comment
							//ActionPush 			ACTIONRECORDHEADER 		ActionCode = 0x96
							//Type 					UI8 					0 = string literal
							//												1 = floating-point literal
							//												The following types are available in SWF 5 and later:
							//												2 = null
							//												3 = undefined
							//												4 = register
							//												5 = Boolean
							//												6 = double
							//												7 = integer
							//												8 = constant 8
							//												9 = constant 16
							//String 				If Type = 0, STRING 	Null-terminated character string
							//Float 				If Type = 1, FLOAT 		32-bit IEEE single-precision little-endian floating-point value
							//RegisterNumber 		If Type = 4, UI8 		Register number
							//Boolean 				If Type = 5, UI8 		Boolean value
							//Double 				If Type = 6, DOUBLE 	64-bit IEEE double-precision littleendian double value
							//Integer 				If Type = 7, UI32 		32-bit little-endian integer
							//Constant8 			If Type = 8, UI8 		Constant pool index (for indexes < 256) (see ActionConstantPool)
							//Constant16 			If Type = 9, UI16 		Constant pool index (for indexes >= 256) (see ActionConstantPool)
							//ActionPush pushes one or more values onto the stack. The Type field specifies the type of the
							//value to be pushed.
							//If Type = 1, the value to be pushed is specified as a 32-bit IEEE single-precision little-endian
							//floating-point value. 
							
							//PropertyIds are pushed as FLOATs. ActionGetProperty and ActionSetProperty use PropertyIds to access the properties of named objects.
							//ActionGetProperty 和 ActionSetProperty 用浮点数来索引对应的属性名（貌似改成整数了也没事）。
							
							//If Type = 4, the value to be pushed is a register number. Flash Player supports up to 4
							//registers. With the use of ActionDefineFunction2, up to 256 registers can be used.
							
							//In the first field of ActionPush, the length in ACTIONRECORD defines the total number of
							//Type and value bytes that follow the ACTIONRECORD itself. More than one set of Type
							//and value fields may follow the first field, depending on the number of bytes that the length
							//in ACTIONRECORD specifies.
							//ActionPush 可能会 push 一个或多个值，直到到达这个 ActionPush ACTIONRECORD 的结尾。
							
							///
							Length=data[offset++]|(data[offset++]<<8);
							
							///
							var numData:ByteArray;
							i=-1;
							var pushValueV:Vector.<*>=new Vector.<*>();
							while(offset<pos+3+Length){
								i++;
								switch(data[offset++]){
									case 0:
										get_str_size=0;
										while(data[offset+(get_str_size++)]){}
										data.position=offset;
										pushValueV[i]=data.readUTFBytes(get_str_size);
										offset+=get_str_size;
									break;
									case 1:
										//好像没见过。。。
										numData=new ByteArray();
										numData[3]=data[offset++];
										numData[2]=data[offset++];
										numData[1]=data[offset++];
										numData[0]=data[offset++];
										numData.position=0;
										pushValueV[i]=numData.readFloat();
										
										//data.endian=Endian.LITTLE_ENDIAN;
										//data.position=offset;
										//pushValueV[i]=data.readFloat();
										//offset+=4;
									break;
									case 2:
										pushValueV[i]=null;
									break;
									case 3:
										pushValueV[i]=undefined;
									break;
									case 4:
										pushValueV[i]={r:data[offset++]};
									break;
									case 5:
										pushValueV[i]=(data[offset++]?true:false);
									break;
									case 6:
										numData=new ByteArray();
										numData[3]=data[offset++];
										numData[2]=data[offset++];
										numData[1]=data[offset++];
										numData[0]=data[offset++];
										numData[7]=data[offset++];
										numData[6]=data[offset++];
										numData[5]=data[offset++];
										numData[4]=data[offset++];
										numData.position=0;
										pushValueV[i]=numData.readDouble();
										
										//data.endian=Endian.LITTLE_ENDIAN;
										//data.position=offset;
										//pushValueV[i]=data.readDouble();
										//offset+=8;
									break;
									case 7:
										pushValueV[i]=data[offset++]|(data[offset++]<<8)|(data[offset++]<<16)|(data[offset++]<<24);
									break;
									case 8:
										pushValueV[i]=constStrV[data[offset++]];
									break;
									case 9:
										pushValueV[i]=constStrV[data[offset++]|(data[offset++]<<8)];
									break;
									default:
										throw new Error("未知 pushType");
									break;
								}
							}
							codeByPosArr[pos]=new Code(op,pushValueV);
							
							///
							if(offset==pos+3+Length){
							}else{
								trace("offset 不正确, offset="+offset);
								offset=pos+3+Length;
								trace("已修正为: "+offset);
							}
							
						break;
						case AVM1Ops.try_://0x8f	//UB[8],UI16,UI16,UI16,STRING|UI8,UI8[TrySize],UI8[CatchSize],UI8[FinallySize]
							//ActionTry
							//ActionTry defines handlers for exceptional conditions, implementing the ActionScript try,
							//catch, and finally keywords.
							//Field 				Type 									Comment
							//ActionTry 			ACTIONRECORDHEADER 						ActionCode = 0x8F
							//Reserved 				UB[5] 									Always zero
							//CatchInRegisterFlag 	UB[1] 									0 - Do not put caught object into register (instead, store in named variable)
							//																1 - Put caught object into register (do not store in named variable)
							//FinallyBlockFlag 		UB[1] 									0 - No finally block
							//																1 - Has finally block
							//CatchBlockFlag 		UB[1] 									0 - No catch block
							//																1 - Has catch block
							//TrySize 				UI16 									Length of the try block
							//CatchSize 			UI16 									Length of the catch block
							//FinallySize 			UI16 									Length of the finally block
							//CatchName 			If CatchInRegisterFlag = 0, STRING		Name of the catch variable
							//CatchRegister 		If CatchInRegisterFlag = 1, UI8 		Register to catch into
							//TryBody 				UI8[TrySize] 							Body of the try block
							//CatchBody 			UI8[CatchSize] 							Body of the catch block, if any
							//FinallyBody 			UI8[FinallySize] 						Body of the finally block, if any
							//NOTE
							//The CatchSize and FinallySize fields always exist, whether or not the CatchBlockFlag or
							//FinallyBlockFlag settings are 1.
							//NOTE
							//The try, catch, and finally blocks do not use end tags to mark the end of their respective
							//blocks. Instead, the length of a block is set by the TrySize, CatchSize, and FinallySize
							//values.
							
							///
							Length=data[offset++]|(data[offset++]<<8);
							
							///
							flags=data[offset++];
							//Reserved=flags&0xf8;									//11111000
							
							var TrySize:int=data[offset++]|(data[offset++]<<8);//其实不是 jump
							var CatchSize:int=data[offset++]|(data[offset++]<<8);//其实不是 jump
							var FinallySize:int=data[offset++]|(data[offset++]<<8);//其实不是 jump
							if(flags&0x04){//CatchInRegisterFlag					//00000100
								code_value={
									CatchRegister:data[offset++]
								};
							}else{
								get_str_size=0;
								while(data[offset+(get_str_size++)]){}
								data.position=offset;
								code_value={
									CatchName:data.readUTFBytes(get_str_size)
								}
								offset+=get_str_size;
							}
							jumpPos=offset+TrySize;
							if(jumpPos<0||jumpPos>endOffset){
								jumpPos=endOffset;
								Outputer.output("jumpPos 已修正为: "+jumpPos,"brown");
							}
							code_value.TryBody=(labelByPosArr[jumpPos]||(labelByPosArr[jumpPos]=new LabelMark(++labelId)));
							if(flags&0x01){//CatchBlockFlag							//00000001
								jumpPos=offset+TrySize+CatchSize;
								if(jumpPos<0||jumpPos>endOffset){
									jumpPos=endOffset;
									Outputer.output("jumpPos 已修正为: "+jumpPos,"brown");
								}
								code_value.CatchBody=(labelByPosArr[jumpPos]||(labelByPosArr[jumpPos]=new LabelMark(++labelId)));
							}
							if(flags&0x02){//FinallyBlockFlag						//00000010
								jumpPos=offset+TrySize+CatchSize+FinallySize;
								if(jumpPos<0||jumpPos>endOffset){
									jumpPos=endOffset;
									Outputer.output("jumpPos 已修正为: "+jumpPos,"brown");
								}
								code_value.FinallyBody=(labelByPosArr[jumpPos]||(labelByPosArr[jumpPos]=new LabelMark(++labelId)));
							}
							codeByPosArr[pos]=new Code(op,code_value);
							
							///
							if(offset==pos+3+Length){
							}else{
								trace("offset 不正确, offset="+offset);
								offset=pos+3+Length;
								trace("已修正为: "+offset);
							}
						
						break;
						case AVM1Ops.defineFunction://0x9b	//STRING,UI16,STRING[NumParams],UI16(label)
							//ActionDefineFunction
							//NOTE
							//ActionDefineFunction is rarely used as of SWF 7 and later; it was superseded by
							//ActionDefineFunction2.
							//ActionDefineFunction defines a function with a given name and body size.
							//Field 				Type 					Comment
							//ActionDefineFunction 	ACTIONRECORDHEADER 		ActionCode = 0x9B
							//FunctionName 			STRING 					Function name, empty if anonymous
							//NumParams 			UI16 					# of parameters
							//param 1 				STRING 					Parameter name 1
							//param 2 				STRING 					Parameter name 2
							//...
							//param N 				STRING 					Parameter name N
							//codeSize 				UI16 					# of bytes of code that follow
							//ActionDefineFunction parses (in order) FunctionName, NumParams, [param1, param2, …,
							//param N] and then code size.
							//ActionDefineFunction does the following:
							//1. Parses the name of the function (name) from the action tag.
							//2. Skips the parameters in the tag.
							//3. Parses the code size from the tag.
							//After the DefineFunction tag, the next codeSize bytes of action data are considered to be
							//the body of the function.
							//4. Gets the code for the function.
							//ActionDefineFunction can be used in the following ways:
							//Usage 1 Pushes an anonymous function on the stack that does not persist. This function is
							//a function literal that is declared in an expression instead of a statement. An anonymous
							//function can be used to define a function, return its value, and assign it to a variable in one
							//expression, as in the following ActionScript:
							//area = (function () {return Math.PI * radius *radius;})(5);
							//Usage 2 Sets a variable with a given FunctionName and a given function definition. This is
							//the more conventional function definition. For example, in ActionScript:
							//function Circle(radius) {
							//	this.radius = radius;
							//	this.area = Math.PI * radius * radius;
							//}
							
							///
							Length=data[offset++]|(data[offset++]<<8);
							
							///
							get_str_size=0;
							while(data[offset+(get_str_size++)]){}
							data.position=offset;
							code_value={
								FunctionName:data.readUTFBytes(get_str_size),
								paramV:new Vector.<String>()
							};
							offset+=get_str_size;
							
							NumParams=data[offset++]|(data[offset++]<<8);
							for(i=0;i<NumParams;i++){
								get_str_size=0;
								while(data[offset+(get_str_size++)]){}
								data.position=offset;
								code_value.paramV[i]=data.readUTFBytes(get_str_size);
								offset+=get_str_size;
							}
							
							jumpOffset=data[offset++]|(data[offset++]<<8);//其实不是 jump
							jumpPos=offset+jumpOffset;//offset+codeSize
							if(jumpPos<0||jumpPos>endOffset){
								jumpPos=endOffset;
								Outputer.output("jumpPos 已修正为: "+jumpPos,"brown");
							}
							code_value.endMark=(labelByPosArr[jumpPos]||(labelByPosArr[jumpPos]=new LabelMark(++labelId)));
							codeByPosArr[pos]=new Code(op,code_value);
							
							///
							if(offset==pos+3+Length){
							}else{
								trace("offset 不正确, offset="+offset);
								offset=pos+3+Length;
								trace("已修正为: "+offset);
							}
							
						break;
						case AVM1Ops.defineFunction2://0x8e	//STRING,UI16,UI8,UB[8],UB[8],(UI8,STRING)[NumParams],UI16(label)
							//ActionDefineFunction2
							//ActionDefineFunction2 is similar to ActionDefineFunction, with additional features that can
							//help speed up the execution of function calls by preventing the creation of unused variables in
							//the function's activation object and by enabling the replacement of local variables with a
							//variable number of registers. With ActionDefineFunction2, a function can allocate its own
							//private set of up to 256 registers. Parameters or local variables can be replaced with a register,
							//which is loaded with the value instead of the value being stored in the function's activation
							//object. (The activation object is an implicit local scope that contains named arguments and
							//local variables. For further description of the activation object, see the ECMA-262 standard.)
							//ActionDefineFunction2 also includes six flags to instruct Flash Player to preload variables,
							//and three flags to suppress variables. By setting PreloadParentFlag, PreloadRootFlag,
							//PreloadSuperFlag, PreloadArgumentsFlag, PreloadThisFlag, or
							//PreloadGlobalFlag, common variables can be preloaded into registers before the function
							//executes (_parent, _root, super, arguments, this, or _global, respectively). With flags
							//SuppressSuper, SuppressArguments, and SuppressThis, common variables super,
							//arguments, and this are not created. By using suppress flags, Flash Player avoids preevaluating
							//variables, thus saving time and improving performance.
							//No suppress flags are provided for _parent, _root, or _global because Flash Player always
							//evaluates these variables as needed; no time is ever wasted on pre-evaluating these variables.
							//Specifying both the preload flag and the suppress flag for any variable is not allowed.
							//The body of the function that ActionDefineFunction2 specifies should use ActionPush and
							//ActionStoreRegister for local variables that are assigned to registers. ActionGetVariable and
							//ActionSetVariable cannot be used for variables assigned to registers.
							//Flash Player 6 release 65 and later supports ActionDefineFunction2.
							//Field 				Type 						Comment
							//ActionDefineFunction2	ACTIONRECORDHEADER 			ActionCode = 0x8E
							//FunctionName 			STRING 						Name of function, empty if anonymous
							//NumParams 			UI16 						# of parameters
							//RegisterCount 		UI8 						Number of registers to allocate, up to 255 registers (from 0 to 254)
							//PreloadParentFlag 	UB[1] 						0 = Don't preload _parent into register
							//													1 = Preload _parent into register
							//PreloadRootFlag 		UB[1] 						0 = Don't preload _root into register
							//													1 = Preload _root into register
							//SuppressSuperFlag 	UB[1] 						0 = Create super variable
							//													1 = Don't create super variable
							//PreloadSuperFlag 		UB[1] 						0 = Don't preload super into register
							//													1 = Preload super into register
							//SuppressArgumentsFlag	UB[1] 						0 = Create arguments variable
							//													1 = Don't create arguments variable
							//PreloadArgumentsFlag 	UB[1] 						0 = Don't preload arguments into register
							//													1 = Preload arguments into register
							//SuppressThisFlag 		UB[1] 						0 = Create this variable
							//													1 = Don't create this variable
							//PreloadThisFlag 		UB[1] 						0 = Don't preload this into register
							//													1 = Preload this into register
							//Reserved 				UB[7] 						Always 0
							//PreloadGlobalFlag 	UB[1] 						0 = Don't preload _global into register
							//													1 = Preload _global into register
							//Parameters 			REGISTERPARAM[NumParams]	See REGISTERPARAM, following
							//codeSize 				UI16 						# of bytes of code that follow
							//REGISTERPARAM is defined as follows:
							//Field 				Type 					Comment
							//Register 				UI8 					For each parameter to the function, a register can be specified. If the register specified is zero, the parameter is created as a variable named ParamName in the activation object, which can be referenced with ActionGetVariable and ActionSetVariable. If the register specified is nonzero, the parameter is copied into the register, and it can be referenced with ActionPush and ActionStoreRegister, and no variable is created in the activation object.
							//ParamName 			STRING 					Parameter name
							//The function body following an ActionDefineFunction2 consists of further action codes, just
							//as for ActionDefineFunction.
							//Flash Player selects register numbers by first copying each argument into the register specified
							//in the corresponding REGISTERPARAM record. Next, the preloaded variables are copied
							//into registers starting at 1, and in the order this, arguments, super, _root, _parent,
							//and _global, skipping any that are not to be preloaded. (The SWF file must accurately
							//specify which registers will be used by preloaded variables and ensure that no parameter uses a
							//register number that falls within this range, or else that parameter is overwritten by a
							//preloaded variable.)
							//The value of NumParams should equal the number of parameter registers. The value of
							//RegisterCount should equal NumParams plus the number of preloaded variables and the
							//number of local variable registers desired.
							//For example, if NumParams is 2, RegisterCount is 6, PreloadThisFlag is 1, and
							//PreloadRootFlag is 1, the REGISTERPARAM records will probably specify registers 3 and 4.
							//Register 1 will be this, register 2 will be _root, registers 3 and 4 will be the first and second
							//parameters, and registers 5 and 6 will be for local variables.
							
							///
							Length=data[offset++]|(data[offset++]<<8);
							
							///
							get_str_size=0;
							while(data[offset+(get_str_size++)]){}
							data.position=offset;
							code_value={
								FunctionName:data.readUTFBytes(get_str_size),
								Parameters:new Vector.<Object>()
							};
							offset+=get_str_size;
							
							NumParams=data[offset++]|(data[offset++]<<8);
							
							code_value.RegisterCount=data[offset++];
							
							flags=data[offset++];
							code_value.PreloadParentFlag=((flags&0x80)?true:false);				//10000000
							code_value.PreloadRootFlag=((flags&0x40)?true:false);					//01000000
							code_value.SuppressSuperFlag=((flags&0x20)?true:false);				//00100000
							code_value.PreloadSuperFlag=((flags&0x10)?true:false);					//00010000
							code_value.SuppressArgumentsFlag=((flags&0x08)?true:false);			//00001000
							code_value.PreloadArgumentsFlag=((flags&0x04)?true:false);				//00000100
							code_value.SuppressThisFlag=((flags&0x02)?true:false);					//00000010
							code_value.PreloadThisFlag=((flags&0x01)?true:false);					//00000001
							
							flags=data[offset++];
							//Reserved=flags&0xfe;													//11111110
							code_value.PreloadGlobalFlag=((flags&0x01)?true:false);				//00000001
							
							for(i=0;i<NumParams;i++){
								code_value.Parameters[i]={Register:data[offset++]};
								get_str_size=0;
								while(data[offset+(get_str_size++)]){}
								data.position=offset;
								code_value.Parameters[i].ParamName=data.readUTFBytes(get_str_size);
								offset+=get_str_size;
							}
							
							jumpOffset=data[offset++]|(data[offset++]<<8);//其实不是 jump
							jumpPos=offset+jumpOffset;//offset+codeSize
							if(jumpPos<0||jumpPos>endOffset){
								jumpPos=endOffset;
								Outputer.output("jumpPos 已修正为: "+jumpPos,"brown");
							}
							code_value.endMark=(labelByPosArr[jumpPos]||(labelByPosArr[jumpPos]=new LabelMark(++labelId)));
							codeByPosArr[pos]=new Code(op,code_value);
							
							///
							if(offset==pos+3+Length){
							}else{
								trace("offset 不正确, offset="+offset);
								offset=pos+3+Length;
								trace("已修正为: "+offset);
							}
							
						break;
						
						default:
						
							///
							Length=data[offset++]|(data[offset++]<<8);
							
							///
							codeByPosArr[pos]=new ByteArray();
							codeByPosArr[pos].writeBytes(data,pos,3+Length);
							Outputer.output("对未知代码使用 ByteArray 进行记录："+BytesAndStr16.bytes2str16(codeByPosArr[pos],0,codeByPosArr[pos].length),"brown");
							Outputer.outputError("未知 op: "+op);
							offset+=Length;
							
							///
							
						break;
					}
				}
				if(hexByPosArr){
					hexByPosArr[pos]=BytesAndStr16.bytes2str16(data,pos,offset-pos);
				}
			}
			
			if(offset==endOffset){
			}else{
				trace("offset="+offset+",endOffset="+endOffset);
			}
			
			if(hexByPosArr){
				hexArr=new Array();
			}
			codeArr=new Array();
			var codeId:int=-1;
			
			for(offset=startOffset;offset<=endOffset;offset++){
				if(labelByPosArr[offset]){
					codeId++;
					codeArr[codeId]=labelByPosArr[offset];
				}
				if(codeByPosArr[offset]==null){
				}else{
					codeId++;
					if(hexArr){
						hexArr[codeId]=hexByPosArr[offset];
					}
					codeArr[codeId]=codeByPosArr[offset];
				}
			}
			
			return endOffset;
		}
		public function toData(_toDataOptions:Object/*zero_swf_ToDataOptions*/):ByteArray{
			var data:ByteArray=new ByteArray();
			//data.endian=Endian.LITTLE_ENDIAN;
			
			var posMarkArr:Array=new Array();//记录 branch, branchIfTrue, function_, function2 的位置及相关的 label 位置
			
			var offset:int,pos:int,Length:int;
			
			var jumpOffset:int,i:int;
			
			var pushValue:*;
			
			var code:*;
			
			var flags:int;
			var NumParams:int;
			
			var skipLength:int;
			
			//统计需要放 const 里的字符串
			var constStrMark:Object=new Object();
			var constCode:Code=null;
			i=-1;
			var constStrV:Vector.<String>=new Vector.<String>();
			loop:for each(code in codeArr){
				if(code is Code){
					switch(code.op){
						case AVM1Ops.constantPool://0x88
							constCode=code;
							break loop;
						break;
						case AVM1Ops.push://0x96
							for each(pushValue in code.value){
								if(pushValue){//pushValue==""的不需要
									if(pushValue is String){
										if(constStrMark["~"+pushValue]>0){
											constStrMark["~"+pushValue]++;
										}else{
											constStrMark["~"+pushValue]=1;
											i++;
											constStrV[i]=pushValue;
										}
									}
								}
							}
						break;
					}
				}
			}
			if(constCode){
				//如果本来就已经有 constCode 了
			}else{
				constCode=new Code(AVM1Ops.constantPool,new Vector.<String>());
				i=-1;
				for each(pushValue in constStrV){
					if(constStrMark["~"+pushValue]>1){//使用2次或以上的字符串才有需要放常量池里
						i++;
						constCode.value[i]=pushValue;
					}
				}
			}
			constStrV=constCode.value;
			if(constStrV.length){
				constStrMark=new Object();
				i=constStrV.length;
				while(--i>=0){
					constStrMark["~"+constStrV[i]]=i;
				}
				
				data[0]=AVM1Ops.constantPool;
				
				//Length
				
				var Count:int=constStrV.length;
				data[3]=Count;
				data[4]=Count>>8;
				data.position=5;
				for each(pushValue in constStrV){
					data.writeUTFBytes(pushValue+"\x00");
				}
				
				offset=pos=data.length;
				Length=offset-3;
				data[1]=Length;
				data[2]=Length>>8;
			}else{
				constCode=null;
				constStrV=null;
				constStrMark=null;
				offset=pos=0;
			}
			//
			
			
			for each(code in codeArr){
				//trace("code="+code);
				if(code is LabelMark){
					code.pos=offset;
				}else if(code is ByteArray){
					Outputer.output("使用 ByteArray 进行记录的未知代码："+BytesAndStr16.bytes2str16(code,0,code.length),"brown");
					data.position=offset;
					data.writeBytes(code,0,code.length);
					offset=data.length;
				}else{
					if(code is int){
						data[offset++]=code;
					}else if(code is Code){
						switch(code.op){
							case AVM1Ops.call://0x9e	//
								//ActionCall
								//ActionCall calls a subroutine.
								//Field 				Type 					Comment
								//ActionCall 			ACTIONRECORDHEADER 		ActionCode = 0x9E
								//ActionCall does the following:
								//1. Pops a value off the stack.
								//This value should be either a string that matches a frame label, or a number that indicates
								//a frame number. The value can be prefixed by a target string that identifies the movie clip
								//that contains the frame being called.
								//2. If the frame is successfully located, the actions in the target frame are executed.
								//After the actions in the target frame are executed, execution resumes at the instruction
								//after the ActionCall instruction.
								//3. If the frame cannot be found, nothing happens.
								
								///
								data[offset++]=code.op;
								
								data[offset++]=0x00;
								data[offset++]=0x00;//Length==0
								
								///
								
								///
							
							break;
							case AVM1Ops.storeRegister://0x87	//UI8
								//ActionStoreRegister
								//ActionStoreRegister reads the next object from the stack (without popping it) and stores it in
								//one of four registers. If ActionDefineFunction2 is used, up to 256 registers are available.
								//Field 				Type 					Comment
								//ActionStoreRegister 	ACTIONRECORDHEADER 		ActionCode = 0x87
								//RegisterNumber 		UI8
								//ActionStoreRegister parses register number from the StoreRegister tag.
								
								///
								data[offset++]=code.op;
								
								data[offset++]=0x01;
								data[offset++]=0x00;//Length==1
								
								///
								data[offset++]=code.value;
								
								///
							
							break;
							case AVM1Ops.gotoFrame://0x81	//UI16
								//ActionGotoFrame
								//ActionGotoFrame instructs Flash Player to go to the specified（指定） frame in the current file.
								//Field 				Type 					Comment
								//ActionGotoFrame 		ACTIONRECORDHEADER 		ActionCode = 0x81; Length is always 2
								//Frame 				UI16 					Frame index
								
								///
								data[offset++]=code.op;
								
								data[offset++]=0x02;
								data[offset++]=0x00;//Length==2
								
								///
								data[offset++]=code.value;
								data[offset++]=code.value>>8;
								
								///
							
							break;
							case AVM1Ops.gotoFrame2://0x9f	//UB[8],UI16
								//ActionGotoFrame2
								//ActionGotoFrame2 goes to a frame and is stack based.
								//Field 				Type 						Comment
								//ActionGotoFrame2 		ACTIONRECORDHEADER 			ActionCode = 0x9F
								//Reserved 				UB[6] 						Always 0
								//SceneBiasFlag 		UB[1] 						Scene bias flag
								//Play flag 			UB[1] 						0 = Go to frame and stop
								//													1 = Go to frame and play
								//SceneBias 			If SceneBiasFlag = 1, UI16 	Number to be added to frame determined by stack argument
								//ActionGotoFrame2 does the following:
								//1. Pops a frame off the stack.
								//■ If the frame is a number, n, the next frame of the movie to be displayed is the nth
								//frame in the current movie clip.
								//■ If the frame is a string, frame is treated as a frame label. If the specified label exists in
								//the current movie clip, the labeled frame will become the current frame. Otherwise,
								//the action is ignored.
								//2. Either a frame or a number can be prefixed by a target path, for example, /MovieClip:3 or
								///MovieClip:FrameLabel.
								//3. If the Play flag is set, the action goes to the specified frame and begins playing the enclosing
								//movie clip. Otherwise, the action goes to the specified frame and stops.
								
								///
								data[offset++]=code.op;
								
								flags=0;
								//flags|=Reserved;							//11111100
								if(code.value.SceneBias>-1){
									flags|=0x02;//SceneBiasFlag				//00000010
									
									///
									data[offset++]=0x03;
									data[offset++]=0x00;//Length==3
								}else{
									///
									data[offset++]=0x01;
									data[offset++]=0x00;//Length==1
								}
								if(code.value.Play){
									flags|=0x01;							//00000001
								}
								data[offset++]=flags;
								if(code.value.SceneBias>-1){
									data[offset++]=code.value.SceneBias;
									data[offset++]=code.value.SceneBias>>8;
								}
								
								///
								
							break;
							case AVM1Ops.setTarget://0x8b	//STRING
								//ActionSetTarget
								//ActionSetTarget instructs Flash Player to change the context of subsequent（随后） actions, so they
								//apply to a named object (TargetName) rather than the current file.
								//For example, the SetTarget action can be used to control the Timeline of a sprite object. The
								//following sequence of actions sends a sprite called "spinner" to the first frame in its
								//Timeline:
								//1. SetTarget "spinner"
								//2. GotoFrame zero
								//3. SetTarget " " (empty string)
								//4. End of actions. (Action code = 0)
								//All actions following SetTarget "spinner" apply to the spinner object until SetTarget "",
								//which sets the action context back to the current file. For a complete discussion of target
								//names see DefineSprite.
								//Field 				Type 					Comment
								//ActionSetTarget 		ACTIONRECORDHEADER 		ActionCode = 0x8B
								//TargetName 			STRING 					Target of action target
							case AVM1Ops.gotoLabel://0x8c	//STRING
								//ActionGoToLabel
								//ActionGoToLabel instructs Flash Player to go to the frame associated with the specified label.
								//You can attach a label to a frame with the FrameLabel tag.
								//Field 				Type 					Comment
								//ActionGoToLabel 		ACTIONRECORDHEADER 		ActionCode = 0x8C
								//Label 				STRING 					Frame label
								
								pos=offset;
								
								///
								data[offset++]=code.op;
								
								offset+=2;//Length
								
								///
								data.position=offset;
								data.writeUTFBytes(code.value+"\x00");
								offset=data.length;
								
								///
								Length=offset-pos-3;
								data[pos+1]=Length;
								data[pos+2]=Length>>8;
							
							break;
							
							case AVM1Ops.waitForFrame://0x8a	//UI16,UI8(label)
								//ActionWaitForFrame
								//ActionWaitForFrame instructs Flash Player to wait until the specified frame; otherwise skips
								//the specified number of actions.
								//Field 				Type 					Comment
								//ActionWaitForFrame 	ACTIONRECORDHEADER 		ActionCode = 0x8A; Length is always 3
								//Frame 				UI16 					Frame to wait for
								//SkipCount 			UI8 					Number of actions to skip if frame is not loaded
								
								///
								data[offset++]=code.op;
								
								data[offset++]=0x03;
								data[offset++]=0x00;//Length==3
								
								///
								data[offset++]=code.value.Frame;
								data[offset++]=code.value.Frame>>8;
								offset++;//SkipCount
								posMarkArr[offset]=code;
								
								///
							
							break;
							case AVM1Ops.waitForFrame2://0x8d	//UI8(label)
								//ActionWaitForFrame2
								//ActionWaitForFrame2 waits for a frame to be loaded and is stack based.
								//Field 				Type 					Comment
								//ActionWaitForFrame2 	ACTIONRECORDHEADER 		ActionCode = 0x8D; Length is always 1
								//SkipCount 			UI8 					The number of actions to skip
								//ActionWaitForFrame2 does the following:
								//1. Pops a frame off the stack.
								//2. If the frame is loaded, skip the next n actions that follow the current action, where n is
								//indicated by SkipCount.
								//The frame is evaluated in the same way as ActionGotoFrame2.
								
								///
								data[offset++]=code.op;
								
								data[offset++]=0x01;
								data[offset++]=0x00;//Length==1
								
								///
								offset++;//SkipCount
								posMarkArr[offset]=code;
								
								///
							
							break;
							case AVM1Ops.with_://0x94	//UI16(label)
								//ActionWith
								//Defines a With block of script.
								//Field 				Type 					Comment
								//ActionWith 			ACTIONRECORDHEADER 		ActionCode = 0x94
								//Size 					UI16 					# of bytes of code that follow
								//ActionWith does the following:
								//1. Pops the object involved with the With.
								//2. Parses the size (body length) of the With block from the ActionWith tag.
								//3. Checks to see if the depth of calls exceeds the maximum depth, which is 16 for SWF 6 and
								//later, and 8 for SWF 5.
								//If the With depth exceeds the maximum depth, the next Size bytes of data are skipped
								//rather than executed.
								//4. After the ActionWith tag, the next Size bytes of action codes are considered to be the body
								//of the With block.
								//5. Adds the With block to the scope chain.
							case AVM1Ops.jump://0x99	//SI16(label)
								//ActionJump
								//ActionJump creates an unconditional branch.
								//Field 				Type 					Comment
								//ActionJump 			ACTIONRECORDHEADER 		ActionCode = 0x99
								//BranchOffset 			SI16 					Offset
								//ActionJump adds BranchOffset bytes to the instruction pointer in the execution stream.
								//The offset is a signed quantity, enabling branches from –32,768 bytes to 32,767 bytes. An
								//offset of 0 points to the action directly after the ActionJump action.
							case AVM1Ops.if_://0x9d		//SI16(label)
								//ActionIf
								//ActionIf creates a conditional test and branch.
								//Field 				Type 					Comment
								//ActionIf 				ACTIONRECORDHEADER 		ActionCode = 0x9D
								//BranchOffset 			SI16 					Offset
								//ActionIf does the following:
								//1. Pops Condition, a number, off the stack.
								//2. Converts Condition to a Boolean value.
								//3. Tests if Condition is true.
								//If Condition is true, BranchOffset bytes are added to the instruction pointer in the
								//execution stream.
								//NOTE
								//When playing a SWF 4 file, Condition is not converted to a Boolean value and is
								//instead compared to 0, not true.
								//The offset is a signed quantity, enabling branches from –32768 bytes to 32767 bytes. An
								//offset of 0 points to the action directly after the ActionIf action.
								
								///
								data[offset++]=code.op;
								
								data[offset++]=0x02;
								data[offset++]=0x00;//Length==2
								
								///
								offset+=2;//Size 或 BranchOffset
								posMarkArr[offset]=code.value;
								
								///
							
							break;
							
							case AVM1Ops.getURL://0x83	//STRING,STRING
								//ActionGetURL
								//ActionGetURL instructs Flash Player to get the URL that UrlString specifies. The URL can
								//be of any type, including an HTML file, an image or another SWF file. If the file is playing in
								//a browser, the URL is displayed in the frame that TargetString specifies. The "_level0" and
								//"_level1" special target names are used to load another SWF file into levels 0 and 1 respectively.
								//Field 				Type 					Comment
								//ActionGetURL 			ACTIONRECORDHEADER 		ActionCode = 0x83
								//UrlString 			STRING 					Target URL string
								//TargetString 			STRING 					Target string
								
								pos=offset;
								
								///
								data[offset++]=code.op;
								
								offset+=2;//Length
								
								///
								data.position=offset;
								data.writeUTFBytes(code.value.UrlString+"\x00");
								data.writeUTFBytes(code.value.TargetString+"\x00");
								offset=data.length;
								
								///
								Length=offset-pos-3;
								data[pos+1]=Length;
								data[pos+2]=Length>>8;
							
							break;
							case AVM1Ops.getURL2://0x9a	//UB[8]
								//ActionGetURL2
								//ActionGetURL2 gets a URL and is stack based.
								//Field 				Type 				Comment
								//ActionGetURL2 		ACTIONRECORDHEADER 	ActionCode = 0x9A; Length is always 1
								//SendVarsMethod 		UB[2] 				0 = None
								//											1 = GET
								//											2 = POST
								//Reserved 				UB[4] 				Always 0
								//LoadTargetFlag 		UB[1] 				0 = Target is a browser window
								//											1 = Target is a path to a sprite
								//LoadVariablesFlag 	UB[1] 				0 = No variables to load
								//											1 = Load variables
								//ActionGetURL2 does the following:
								//1. Pops target off the stack.
								//■ A LoadTargetFlag value of 0 indicates that the target is a window. The target can be an
								//empty string to indicate the current window.
								//■ A LoadTargetFlag value of 1 indicates that the target is a path to a sprite. The target
								//path can be in slash or dot syntax.
								//2. Pops a URL off the stack; the URL specifies the URL to be retrieved.
								//3. SendVarsMethod specifies the method to use for the HTTP request.
								//■ A SendVarsMethod value of 0 indicates that this is not a form request, so the movie
								//clip's variables should not be encoded and submitted.
								//■ A SendVarsMethod value of 1 specifies a HTTP GET request.
								//■ A SendVarsMethod value of 2 specifies a HTTP POST request.
								//4. If the SendVarsMethod value is 1 (GET) or 2 (POST), the variables in the current movie
								//clip are submitted to the URL by using the standard x-www-form-urlencoded encoding
								//and the HTTP request method specified by method.
								//If the LoadVariablesFlag is set, the server is expected to respond with a MIME type of
								//application/x-www-form-urlencoded and a body in the format
								//var1=value1&var2=value2&...&varx=valuex. This response is used to populate
								//ActionScript variables rather than display a document. The variables populated can be in a
								//timeline (if LoadTargetFlag is 0) or in the specified sprite (if LoadTargetFlag is 1).
								//If the LoadTargetFlag is specified without the LoadVariablesFlag, the server is expected to
								//respond with a MIME type of application/x-shockwave-flash and a body that consists of a
								//SWF file. This response is used to load a subfile into the specified sprite rather than to display
								//an HTML document.
								
								//文档有错：
								//SendVarsMethod 		UB[2] 					0 = None
								//												1 = GET
								//												2 = POST
								//Reserved 				UB[4] 					Always 0
								//LoadTargetFlag 		UB[1] 					0 = Target is a browser window
								//												1 = Target is a path to a sprite
								//LoadVariablesFlag 	UB[1] 					0 = No variables to load
								//												1 = Load variables
								//正确的应该是：
								//LoadVariablesFlag 	UB[1] 					0 = No variables to load
								//												1 = Load variables
								//LoadTargetFlag 		UB[1] 					0 = Target is a browser window
								//												1 = Target is a path to a sprite
								//Reserved 				UB[4] 					Always 0
								//SendVarsMethod 		UB[2] 					0 = None
								//												1 = GET
								//
								
								///
								data[offset++]=code.op;
								
								data[offset++]=0x01;
								data[offset++]=0x00;//Length==1
								
								///
								flags=0;
								if(code.value.LoadVariablesFlag){
									flags|=0x80;								//10000000
								}
								if(code.value.LoadTargetFlag){
									flags|=0x40;								//01000000
								}
								//flags|=Reserved;								//00111100
								flags|=code.value.SendVarsMethod;				//00000011
								data[offset++]=flags;
								
								///
							
							break;
							
							case AVM1Ops.constantPool://0x88	//UI16,STRING[Count]
								//ActionConstantPool
								//ActionConstantPool creates a new constant pool, and replaces the old constant pool if one
								//already exists.
								//Field 				Type 					Comment
								//ActionConstantPool 	ACTIONRECORDHEADER 		ActionCode = 0x88
								//Count 				UI16 					Number of constants to follow
								//ConstantPool 			STRING[Count] 			String constants
								//
								
								if(constCode){
									if(constCode==code){
									}else{
										throw new Error("constCode!=code");
									}
								}
							break;
							case AVM1Ops.push://0x96	//(UI8,STRING|FLOAT|UI8|DOUBLE|UI32|UI16)s
								//ActionPush
								//ActionPush pushes one or more values to the stack.
								//Field 				Type 					Comment
								//ActionPush 			ACTIONRECORDHEADER 		ActionCode = 0x96
								//Type 					UI8 					0 = string literal
								//												1 = floating-point literal
								//												The following types are available in SWF 5 and later:
								//												2 = null
								//												3 = undefined
								//												4 = register
								//												5 = Boolean
								//												6 = double
								//												7 = integer
								//												8 = constant 8
								//												9 = constant 16
								//String 				If Type = 0, STRING 	Null-terminated character string
								//Float 				If Type = 1, FLOAT 		32-bit IEEE single-precision little-endian floating-point value
								//RegisterNumber 		If Type = 4, UI8 		Register number
								//Boolean 				If Type = 5, UI8 		Boolean value
								//Double 				If Type = 6, DOUBLE 	64-bit IEEE double-precision littleendian double value
								//Integer 				If Type = 7, UI32 		32-bit little-endian integer
								//Constant8 			If Type = 8, UI8 		Constant pool index (for indexes < 256) (see ActionConstantPool)
								//Constant16 			If Type = 9, UI16 		Constant pool index (for indexes >= 256) (see ActionConstantPool)
								//ActionPush pushes one or more values onto the stack. The Type field specifies the type of the
								//value to be pushed.
								//If Type = 1, the value to be pushed is specified as a 32-bit IEEE single-precision little-endian
								//floating-point value. 
								
								//PropertyIds are pushed as FLOATs. ActionGetProperty and ActionSetProperty use PropertyIds to access the properties of named objects.
								//ActionGetProperty 和 ActionSetProperty 用浮点数来索引对应的属性名（貌似改成整数了也没事）。
								
								//If Type = 4, the value to be pushed is a register number. Flash Player supports up to 4
								//registers. With the use of ActionDefineFunction2, up to 256 registers can be used.
								
								//In the first field of ActionPush, the length in ACTIONRECORD defines the total number of
								//Type and value bytes that follow the ACTIONRECORD itself. More than one set of Type
								//and value fields may follow the first field, depending on the number of bytes that the length
								//in ACTIONRECORD specifies.
								//ActionPush 可能会 push 一个或多个值，直到到达这个 ActionPush ACTIONRECORD 的结尾。
								
								pos=offset;
								
								///
								data[offset++]=code.op;
								
								offset+=2;//Length
								
								///
								for each(pushValue in code.value){
									switch(pushValue){
										case null:
											data[offset++]=0x02;
										break;
										case undefined:
											data[offset++]=0x03;
										break;
										case true:
											data[offset++]=0x05;
											data[offset++]=0x01;
										break;
										case false:
											data[offset++]=0x05;
											data[offset++]=0x00;
										break;
										default:
											if(pushValue is String){
												if(constStrV&&constStrMark["~"+pushValue]>-1){
													if(constStrMark["~"+pushValue]>0xff){
														data[offset++]=0x09;
														data[offset++]=constStrMark["~"+pushValue];
														data[offset++]=constStrMark["~"+pushValue]>>8;
													}else{
														data[offset++]=0x08;
														data[offset++]=constStrMark["~"+pushValue];
													}
												}else{
													data[offset++]=0x00;
													data.position=offset;
													data.writeUTFBytes(pushValue+"\x00");
													offset=data.length;
												}
											}else if(pushValue is int){
												data[offset++]=0x07;
												data[offset++]=pushValue;
												data[offset++]=pushValue>>8;
												data[offset++]=pushValue>>16;
												data[offset++]=pushValue>>24;
											}else if(pushValue is Number){
												data[offset++]=0x06;
												var numData:ByteArray=new ByteArray();
												numData.position=0;
												numData.writeDouble(pushValue);
												data[offset++]=numData[3];
												data[offset++]=numData[2];
												data[offset++]=numData[1];
												data[offset++]=numData[0];
												data[offset++]=numData[7];
												data[offset++]=numData[6];
												data[offset++]=numData[5];
												data[offset++]=numData[4];
											}else{
												data[offset++]=0x04;
												data[offset++]=pushValue.r;
											}
										break;
									}
								}
							
								///
								Length=offset-pos-3;
								data[pos+1]=Length;
								data[pos+2]=Length>>8;
							
							break;
							case AVM1Ops.try_://0x8f	//UB[8],UI16,UI16,UI16,STRING|UI8,UI8[TrySize],UI8[CatchSize],UI8[FinallySize]
								//ActionTry
								//ActionTry defines handlers for exceptional conditions, implementing the ActionScript try,
								//catch, and finally keywords.
								//Field 				Type 									Comment
								//ActionTry 			ACTIONRECORDHEADER 						ActionCode = 0x8F
								//Reserved 				UB[5] 									Always zero
								//CatchInRegisterFlag 	UB[1] 									0 - Do not put caught object into register (instead, store in named variable)
								//																1 - Put caught object into register (do not store in named variable)
								//FinallyBlockFlag 		UB[1] 									0 - No finally block
								//																1 - Has finally block
								//CatchBlockFlag 		UB[1] 									0 - No catch block
								//																1 - Has catch block
								//TrySize 				UI16 									Length of the try block
								//CatchSize 			UI16 									Length of the catch block
								//FinallySize 			UI16 									Length of the finally block
								//CatchName 			If CatchInRegisterFlag = 0, STRING		Name of the catch variable
								//CatchRegister 		If CatchInRegisterFlag = 1, UI8 		Register to catch into
								//TryBody 				UI8[TrySize] 							Body of the try block
								//CatchBody 			UI8[CatchSize] 							Body of the catch block, if any
								//FinallyBody 			UI8[FinallySize] 						Body of the finally block, if any
								//NOTE
								//The CatchSize and FinallySize fields always exist, whether or not the CatchBlockFlag or
								//FinallyBlockFlag settings are 1.
								//NOTE
								//The try, catch, and finally blocks do not use end tags to mark the end of their respective
								//blocks. Instead, the length of a block is set by the TrySize, CatchSize, and FinallySize
								//values.
								
								pos=offset;
								
								///
								data[offset++]=code.op;
								
								offset+=2;//Length
								
								///
								flags=0;
								//flags|=Reserved;							//11111000
								if(code.value.CatchRegister>-1){
									flags|=0x04;//CatchInRegisterFlag		//00000100
								}
								if(code.value.CatchBody){
									flags|=0x01;//CatchBlockFlag			//00000001
								}
								if(code.value.FinallyBody){
									flags|=0x02;//FinallyBlockFlag			//00000010
								}
								data[offset++]=flags;
								
								offset+=6;//TrySize,CatchSize,FinallySize
								
								code.value.SizePos=offset;//- -
								
								if(code.value.CatchRegister>-1){
									data[offset++]=code.value.CatchRegister;
								}else{
									data.position=offset;
									data.writeUTFBytes(code.value.CatchName+"\x00");
									offset=data.length;
								}
								
								posMarkArr[offset]=code;
							
								///
								Length=offset-pos-3;
								data[pos+1]=Length;
								data[pos+2]=Length>>8;
							
							break;
							case AVM1Ops.defineFunction://0x9b	//STRING,UI16,STRING[NumParams],UI16(label)
								//ActionDefineFunction
								//NOTE
								//ActionDefineFunction is rarely used as of SWF 7 and later; it was superseded by
								//ActionDefineFunction2.
								//ActionDefineFunction defines a function with a given name and body size.
								//Field 				Type 					Comment
								//ActionDefineFunction 	ACTIONRECORDHEADER 		ActionCode = 0x9B
								//FunctionName 			STRING 					Function name, empty if anonymous
								//NumParams 			UI16 					# of parameters
								//param 1 				STRING 					Parameter name 1
								//param 2 				STRING 					Parameter name 2
								//...
								//param N 				STRING 					Parameter name N
								//codeSize 				UI16 					# of bytes of code that follow
								//ActionDefineFunction parses (in order) FunctionName, NumParams, [param1, param2, …,
								//param N] and then code size.
								//ActionDefineFunction does the following:
								//1. Parses the name of the function (name) from the action tag.
								//2. Skips the parameters in the tag.
								//3. Parses the code size from the tag.
								//After the DefineFunction tag, the next codeSize bytes of action data are considered to be
								//the body of the function.
								//4. Gets the code for the function.
								//ActionDefineFunction can be used in the following ways:
								//Usage 1 Pushes an anonymous function on the stack that does not persist. This function is
								//a function literal that is declared in an expression instead of a statement. An anonymous
								//function can be used to define a function, return its value, and assign it to a variable in one
								//expression, as in the following ActionScript:
								//area = (function () {return Math.PI * radius *radius;})(5);
								//Usage 2 Sets a variable with a given FunctionName and a given function definition. This is
								//the more conventional function definition. For example, in ActionScript:
								//function Circle(radius) {
								//	this.radius = radius;
								//	this.area = Math.PI * radius * radius;
								//}
								
								pos=offset;
								
								///
								data[offset++]=code.op;
								
								offset+=2;//Length
								
								///
								data.position=offset;
								data.writeUTFBytes(code.value.FunctionName+"\x00");
								offset=data.length;
								NumParams=code.value.paramV.length;
								data[offset++]=NumParams;
								data[offset++]=NumParams>>8;
								data.position=offset;
								for each(var param:String in code.value.paramV){
									data.writeUTFBytes(param+"\x00");
								}
								offset=data.length;
								offset+=2;//codeSize
								posMarkArr[offset]=code.value.endMark;
							
								///
								Length=offset-pos-3;
								data[pos+1]=Length;
								data[pos+2]=Length>>8;
							
							break;
							case AVM1Ops.defineFunction2://0x8e	//STRING,UI16,UI8,UB[8],UB[8],(UI8,STRING)[NumParams],UI16(label)
								//ActionDefineFunction2
								//ActionDefineFunction2 is similar to ActionDefineFunction, with additional features that can
								//help speed up the execution of function calls by preventing the creation of unused variables in
								//the function's activation object and by enabling the replacement of local variables with a
								//variable number of registers. With ActionDefineFunction2, a function can allocate its own
								//private set of up to 256 registers. Parameters or local variables can be replaced with a register,
								//which is loaded with the value instead of the value being stored in the function's activation
								//object. (The activation object is an implicit local scope that contains named arguments and
								//local variables. For further description of the activation object, see the ECMA-262 standard.)
								//ActionDefineFunction2 also includes six flags to instruct Flash Player to preload variables,
								//and three flags to suppress variables. By setting PreloadParentFlag, PreloadRootFlag,
								//PreloadSuperFlag, PreloadArgumentsFlag, PreloadThisFlag, or
								//PreloadGlobalFlag, common variables can be preloaded into registers before the function
								//executes (_parent, _root, super, arguments, this, or _global, respectively). With flags
								//SuppressSuper, SuppressArguments, and SuppressThis, common variables super,
								//arguments, and this are not created. By using suppress flags, Flash Player avoids preevaluating
								//variables, thus saving time and improving performance.
								//No suppress flags are provided for _parent, _root, or _global because Flash Player always
								//evaluates these variables as needed; no time is ever wasted on pre-evaluating these variables.
								//Specifying both the preload flag and the suppress flag for any variable is not allowed.
								//The body of the function that ActionDefineFunction2 specifies should use ActionPush and
								//ActionStoreRegister for local variables that are assigned to registers. ActionGetVariable and
								//ActionSetVariable cannot be used for variables assigned to registers.
								//Flash Player 6 release 65 and later supports ActionDefineFunction2.
								//Field 				Type 						Comment
								//ActionDefineFunction2	ACTIONRECORDHEADER 			ActionCode = 0x8E
								//FunctionName 			STRING 						Name of function, empty if anonymous
								//NumParams 			UI16 						# of parameters
								//RegisterCount 		UI8 						Number of registers to allocate, up to 255 registers (from 0 to 254)
								//PreloadParentFlag 	UB[1] 						0 = Don't preload _parent into register
								//													1 = Preload _parent into register
								//PreloadRootFlag 		UB[1] 						0 = Don't preload _root into register
								//													1 = Preload _root into register
								//SuppressSuperFlag 	UB[1] 						0 = Create super variable
								//													1 = Don't create super variable
								//PreloadSuperFlag 		UB[1] 						0 = Don't preload super into register
								//													1 = Preload super into register
								//SuppressArgumentsFlag	UB[1] 						0 = Create arguments variable
								//													1 = Don't create arguments variable
								//PreloadArgumentsFlag 	UB[1] 						0 = Don't preload arguments into register
								//													1 = Preload arguments into register
								//SuppressThisFlag 		UB[1] 						0 = Create this variable
								//													1 = Don't create this variable
								//PreloadThisFlag 		UB[1] 						0 = Don't preload this into register
								//													1 = Preload this into register
								//Reserved 				UB[7] 						Always 0
								//PreloadGlobalFlag 	UB[1] 						0 = Don't preload _global into register
								//													1 = Preload _global into register
								//Parameters 			REGISTERPARAM[NumParams]	See REGISTERPARAM, following
								//codeSize 				UI16 						# of bytes of code that follow
								//REGISTERPARAM is defined as follows:
								//Field 				Type 					Comment
								//Register 				UI8 					For each parameter to the function, a register can be specified. If the register specified is zero, the parameter is created as a variable named ParamName in the activation object, which can be referenced with ActionGetVariable and ActionSetVariable. If the register specified is nonzero, the parameter is copied into the register, and it can be referenced with ActionPush and ActionStoreRegister, and no variable is created in the activation object.
								//ParamName 			STRING 					Parameter name
								//The function body following an ActionDefineFunction2 consists of further action codes, just
								//as for ActionDefineFunction.
								//Flash Player selects register numbers by first copying each argument into the register specified
								//in the corresponding REGISTERPARAM record. Next, the preloaded variables are copied
								//into registers starting at 1, and in the order this, arguments, super, _root, _parent,
								//and _global, skipping any that are not to be preloaded. (The SWF file must accurately
								//specify which registers will be used by preloaded variables and ensure that no parameter uses a
								//register number that falls within this range, or else that parameter is overwritten by a
								//preloaded variable.)
								//The value of NumParams should equal the number of parameter registers. The value of
								//RegisterCount should equal NumParams plus the number of preloaded variables and the
								//number of local variable registers desired.
								//For example, if NumParams is 2, RegisterCount is 6, PreloadThisFlag is 1, and
								//PreloadRootFlag is 1, the REGISTERPARAM records will probably specify registers 3 and 4.
								//Register 1 will be this, register 2 will be _root, registers 3 and 4 will be the first and second
								//parameters, and registers 5 and 6 will be for local variables.
								
								pos=offset;
								
								///
								data[offset++]=code.op;
								
								offset+=2;//Length
								
								///
								data.position=offset;
								data.writeUTFBytes(code.value.FunctionName+"\x00");
								offset=data.length;
								
								NumParams=code.value.Parameters.length;
								data[offset++]=NumParams;
								data[offset++]=NumParams>>8;
								
								data[offset++]=code.value.RegisterCount;
								
								flags=0;
								if(code.value.PreloadParentFlag){
									flags|=0x80;
								}
								if(code.value.PreloadRootFlag){
									flags|=0x40;
								}
								if(code.value.SuppressSuperFlag){
									flags|=0x20;
								}
								if(code.value.PreloadSuperFlag){
									flags|=0x10;
								}
								if(code.value.SuppressArgumentsFlag){
									flags|=0x08;
								}
								if(code.value.PreloadArgumentsFlag){
									flags|=0x04;
								}
								if(code.value.SuppressThisFlag){
									flags|=0x02;
								}
								if(code.value.PreloadThisFlag){
									flags|=0x01;
								}
								data[offset++]=flags;
								
								flags=0;
								//flags|=Reserved;
								if(code.value.PreloadGlobalFlag){
									flags|=0x01;
								}
								data[offset++]=flags;
								
								for each(var Parameter:Object in code.value.Parameters){
									data[offset++]=Parameter.Register;
									data.position=offset;
									data.writeUTFBytes(Parameter.ParamName+"\x00");
									offset=data.length;
								}
								offset+=2;//codeSize
								posMarkArr[offset]=code.value.endMark;
							
								///
								Length=offset-pos-3;
								data[pos+1]=Length;
								data[pos+2]=Length>>8;
							
							break;
							
							default:
								throw new Error("未知 op: "+code.op);
							break;
						}
					}
				}
			}
			
			var skipId:int,jumpPos:int;
			
			var endOffset:int=data.length;
			for(offset=0;offset<=endOffset;offset++){
				code=posMarkArr[offset];
				if(code){
					if(code is LabelMark){
						jumpOffset=code.pos-offset;
						data[offset-2]=jumpOffset;
						data[offset-1]=jumpOffset>>8;
					}else{
						switch(code.op){
							case AVM1Ops.try_:
								var TrySize:int=code.value.TryBody.pos-offset;
								data[code.value.SizePos-6]=TrySize;
								data[code.value.SizePos-5]=TrySize>>8;
								if(code.value.CatchBody){
									var CatchSize:int=code.value.CatchBody.pos-offset-TrySize;
									data[code.value.SizePos-4]=CatchSize;
									data[code.value.SizePos-3]=CatchSize>>8;
								}
								if(code.value.FinallyBody){
									var FinallySize:int=code.value.FinallyBody.pos-offset-TrySize-CatchSize;
									data[code.value.SizePos-2]=FinallySize;
									data[code.value.SizePos-1]=FinallySize>>8;
								}
							break;
							case AVM1Ops.waitForFrame:
								skipId=0;
								jumpPos=offset;
								while(jumpPos<code.value.label.pos){
									skipId++;
									if(data[jumpPos++]<0x80){//skipOp
									}else{
										skipLength=data[jumpPos++]|(data[jumpPos++]<<8);
										jumpPos+=skipLength;
									}
								}
								data[offset-1]=skipId;
							break;
							case AVM1Ops.waitForFrame2:
								skipId=0;
								jumpPos=offset;
								while(jumpPos<code.value.pos){
									skipId++;
									if(data[jumpPos++]<0x80){//skipOp
									}else{
										skipLength=data[jumpPos++]|(data[jumpPos++]<<8);
										jumpPos+=skipLength;
									}
								}
								data[offset-1]=skipId;
							break;
							default:
								throw new Error("发现 posMarkArr 里的奇怪的 code, code.op="+code.op);
							break;
						}
					}
				}
			}
			
			return data;
		}
		
		////
		CONFIG::USE_XML{
		public function toXML(xmlName:String,_toXMLOptions:Object/*zero_swf_ToXMLOptions*/):XML{
			var pushValue:*,subStr:String;
			if(codeArr.length){
				var codesStr:String="";
				if(hexArr){
					var codeId:int=-1;
				}
				for each(var code:* in codeArr){
					if(hexArr){
						codeId++;
						if(hexArr[codeId]){
							codesStr+="\t\t\t\t\t//"+hexArr[codeId]+"\n";
						}
					}
					if(code is LabelMark){
						codesStr+="\t\t\t\tlabel"+code.labelId+":\n";
					}else if(code is ByteArray){
						Outputer.output("使用 ByteArray 进行记录的未知代码："+BytesAndStr16.bytes2str16(code,0,code.length),"brown");
						codesStr+="\t\t\t\t\t"+BytesAndStr16.bytes2str16(code,0,code.length)+"\n";
					}else{
						if(code is int){
							codesStr+="\t\t\t\t\t"+AVM1Ops.opNameV[code]+"\n";
						}else if(code is Code){
							switch(code.op){
								case AVM1Ops.call://0x9e	//
									//ActionCall
									//ActionCall calls a subroutine.
									//Field 				Type 					Comment
									//ActionCall 			ACTIONRECORDHEADER 		ActionCode = 0x9E
									//ActionCall does the following:
									//1. Pops a value off the stack.
									//This value should be either a string that matches a frame label, or a number that indicates
									//a frame number. The value can be prefixed by a target string that identifies the movie clip
									//that contains the frame being called.
									//2. If the frame is successfully located, the actions in the target frame are executed.
									//After the actions in the target frame are executed, execution resumes at the instruction
									//after the ActionCall instruction.
									//3. If the frame cannot be found, nothing happens.
									
									codesStr+="\t\t\t\t\t"+AVM1Ops.opNameV[code.op]+"\n";
								break;
								case AVM1Ops.storeRegister://0x87	//int
									//ActionStoreRegister
									//ActionStoreRegister reads the next object from the stack (without popping it) and stores it in
									//one of four registers. If ActionDefineFunction2 is used, up to 256 registers are available.
									//Field 				Type 					Comment
									//ActionStoreRegister 	ACTIONRECORDHEADER 		ActionCode = 0x87
									//RegisterNumber 		UI8
									//ActionStoreRegister parses register number from the StoreRegister tag.
									
									codesStr+="\t\t\t\t\t"+AVM1Ops.opNameV[code.op]+" "+code.value+"\n";
								break;
								case AVM1Ops.gotoFrame://0x81	//int
									//ActionGotoFrame
									//ActionGotoFrame instructs Flash Player to go to the specified（指定） frame in the current file.
									//Field 				Type 					Comment
									//ActionGotoFrame 		ACTIONRECORDHEADER 		ActionCode = 0x81; Length is always 2
									//Frame 				UI16 					Frame index
									
									codesStr+="\t\t\t\t\t"+AVM1Ops.opNameV[code.op]+" "+code.value+"\n";
								break;
								case AVM1Ops.gotoFrame2://0x9f	//{Play:Boolean,SceneBias:int}
									//ActionGotoFrame2
									//ActionGotoFrame2 goes to a frame and is stack based.
									//Field 				Type 						Comment
									//ActionGotoFrame2 		ACTIONRECORDHEADER 			ActionCode = 0x9F
									//Reserved 				UB[6] 						Always 0
									//SceneBiasFlag 		UB[1] 						Scene bias flag
									//Play flag 			UB[1] 						0 = Go to frame and stop
									//													1 = Go to frame and play
									//SceneBias 			If SceneBiasFlag = 1, UI16 	Number to be added to frame determined by stack argument
									//ActionGotoFrame2 does the following:
									//1. Pops a frame off the stack.
									//■ If the frame is a number, n, the next frame of the movie to be displayed is the nth
									//frame in the current movie clip.
									//■ If the frame is a string, frame is treated as a frame label. If the specified label exists in
									//the current movie clip, the labeled frame will become the current frame. Otherwise,
									//the action is ignored.
									//2. Either a frame or a number can be prefixed by a target path, for example, /MovieClip:3 or
									///MovieClip:FrameLabel.
									//3. If the Play flag is set, the action goes to the specified frame and begins playing the enclosing
									//movie clip. Otherwise, the action goes to the specified frame and stops.
									
									codesStr+="\t\t\t\t\t"+AVM1Ops.opNameV[code.op]+" "+(code.value.Play?"PLAY":"STOP")
									if(code.value.SceneBias>-1){
										codesStr+=","+code.value.SceneBias;
									}
									codesStr+="\n";
								break;
								case AVM1Ops.setTarget://0x8b	//String
									//ActionSetTarget
									//ActionSetTarget instructs Flash Player to change the context of subsequent（随后） actions, so they
									//apply to a named object (TargetName) rather than the current file.
									//For example, the SetTarget action can be used to control the Timeline of a sprite object. The
									//following sequence of actions sends a sprite called "spinner" to the first frame in its
									//Timeline:
									//1. SetTarget "spinner"
									//2. GotoFrame zero
									//3. SetTarget " " (empty string)
									//4. End of actions. (Action code = 0)
									//All actions following SetTarget "spinner" apply to the spinner object until SetTarget "",
									//which sets the action context back to the current file. For a complete discussion of target
									//names see DefineSprite.
									//Field 				Type 					Comment
									//ActionSetTarget 		ACTIONRECORDHEADER 		ActionCode = 0x8B
									//TargetName 			STRING 					Target of action target
								case AVM1Ops.gotoLabel://0x8c	//String
									//ActionGoToLabel
									//ActionGoToLabel instructs Flash Player to go to the frame associated with the specified label.
									//You can attach a label to a frame with the FrameLabel tag.
									//Field 				Type 					Comment
									//ActionGoToLabel 		ACTIONRECORDHEADER 		ActionCode = 0x8C
									//Label 				STRING 					Frame label
									
									codesStr+="\t\t\t\t\t"+AVM1Ops.opNameV[code.op]+" \""+ComplexString.normal.escape(code.value)+"\"\n";
								break;
								
								case AVM1Ops.waitForFrame://0x8a	//{Frame:int,label:LabelMark}
									//ActionWaitForFrame
									//ActionWaitForFrame instructs Flash Player to wait until the specified frame; otherwise skips
									//the specified number of actions.
									//Field 				Type 					Comment
									//ActionWaitForFrame 	ACTIONRECORDHEADER 		ActionCode = 0x8A; Length is always 3
									//Frame 				UI16 					Frame to wait for
									//SkipCount 			UI8 					Number of actions to skip if frame is not loaded
									
									codesStr+="\t\t\t\t\t"+AVM1Ops.opNameV[code.op]+" "+code.value.Frame+",label"+code.value.label.labelId+"\n";
								break;
								case AVM1Ops.waitForFrame2://0x8d	//LabelMark
									//ActionWaitForFrame2
									//ActionWaitForFrame2 waits for a frame to be loaded and is stack based.
									//Field 				Type 					Comment
									//ActionWaitForFrame2 	ACTIONRECORDHEADER 		ActionCode = 0x8D; Length is always 1
									//SkipCount 			UI8 					The number of actions to skip
									//ActionWaitForFrame2 does the following:
									//1. Pops a frame off the stack.
									//2. If the frame is loaded, skip the next n actions that follow the current action, where n is
									//indicated by SkipCount.
									//The frame is evaluated in the same way as ActionGotoFrame2.
								case AVM1Ops.with_://0x94	//LabelMark
									//ActionWith
									//Defines a With block of script.
									//Field 				Type 					Comment
									//ActionWith 			ACTIONRECORDHEADER 		ActionCode = 0x94
									//Size 					UI16 					# of bytes of code that follow
									//ActionWith does the following:
									//1. Pops the object involved with the With.
									//2. Parses the size (body length) of the With block from the ActionWith tag.
									//3. Checks to see if the depth of calls exceeds the maximum depth, which is 16 for SWF 6 and
									//later, and 8 for SWF 5.
									//If the With depth exceeds the maximum depth, the next Size bytes of data are skipped
									//rather than executed.
									//4. After the ActionWith tag, the next Size bytes of action codes are considered to be the body
									//of the With block.
									//5. Adds the With block to the scope chain.
								case AVM1Ops.jump://0x99	//LabelMark
									//ActionJump
									//ActionJump creates an unconditional branch.
									//Field 				Type 					Comment
									//ActionJump 			ACTIONRECORDHEADER 		ActionCode = 0x99
									//BranchOffset 			SI16 					Offset
									//ActionJump adds BranchOffset bytes to the instruction pointer in the execution stream.
									//The offset is a signed quantity, enabling branches from –32,768 bytes to 32,767 bytes. An
									//offset of 0 points to the action directly after the ActionJump action.
								case AVM1Ops.if_://0x9d		//LabelMark
									//ActionIf
									//ActionIf creates a conditional test and branch.
									//Field 				Type 					Comment
									//ActionIf 				ACTIONRECORDHEADER 		ActionCode = 0x9D
									//BranchOffset 			SI16 					Offset
									//ActionIf does the following:
									//1. Pops Condition, a number, off the stack.
									//2. Converts Condition to a Boolean value.
									//3. Tests if Condition is true.
									//If Condition is true, BranchOffset bytes are added to the instruction pointer in the
									//execution stream.
									//NOTE
									//When playing a SWF 4 file, Condition is not converted to a Boolean value and is
									//instead compared to 0, not true.
									//The offset is a signed quantity, enabling branches from –32768 bytes to 32767 bytes. An
									//offset of 0 points to the action directly after the ActionIf action.
									
									codesStr+="\t\t\t\t\t"+AVM1Ops.opNameV[code.op]+" label"+code.value.labelId+"\n";
								break;
								
								case AVM1Ops.getURL://0x83	//{UrlString:String,TargetString:String}
									//ActionGetURL
									//ActionGetURL instructs Flash Player to get the URL that UrlString specifies. The URL can
									//be of any type, including an HTML file, an image or another SWF file. If the file is playing in
									//a browser, the URL is displayed in the frame that TargetString specifies. The "_level0" and
									//"_level1" special target names are used to load another SWF file into levels 0 and 1 respectively.
									//Field 				Type 					Comment
									//ActionGetURL 			ACTIONRECORDHEADER 		ActionCode = 0x83
									//UrlString 			STRING 					Target URL string
									//TargetString 			STRING 					Target string
									
									codesStr+="\t\t\t\t\t"+AVM1Ops.opNameV[code.op]+" \""+ComplexString.normal.escape(code.value.UrlString)+"\",\""+ComplexString.normal.escape(code.value.TargetString)+"\"\n";
								break;
								case AVM1Ops.getURL2://0x9a	//{LoadVariablesFlag:Boolean,LoadTargetFlag:Boolean,SendVarsMethod:int}
									//ActionGetURL2
									//ActionGetURL2 gets a URL and is stack based.
									//Field 				Type 				Comment
									//ActionGetURL2 		ACTIONRECORDHEADER 	ActionCode = 0x9A; Length is always 1
									//SendVarsMethod 		UB[2] 				0 = None
									//											1 = GET
									//											2 = POST
									//Reserved 				UB[4] 				Always 0
									//LoadTargetFlag 		UB[1] 				0 = Target is a browser window
									//											1 = Target is a path to a sprite
									//LoadVariablesFlag 	UB[1] 				0 = No variables to load
									//											1 = Load variables
									//ActionGetURL2 does the following:
									//1. Pops target off the stack.
									//■ A LoadTargetFlag value of 0 indicates that the target is a window. The target can be an
									//empty string to indicate the current window.
									//■ A LoadTargetFlag value of 1 indicates that the target is a path to a sprite. The target
									//path can be in slash or dot syntax.
									//2. Pops a URL off the stack; the URL specifies the URL to be retrieved.
									//3. SendVarsMethod specifies the method to use for the HTTP request.
									//■ A SendVarsMethod value of 0 indicates that this is not a form request, so the movie
									//clip's variables should not be encoded and submitted.
									//■ A SendVarsMethod value of 1 specifies a HTTP GET request.
									//■ A SendVarsMethod value of 2 specifies a HTTP POST request.
									//4. If the SendVarsMethod value is 1 (GET) or 2 (POST), the variables in the current movie
									//clip are submitted to the URL by using the standard x-www-form-urlencoded encoding
									//and the HTTP request method specified by method.
									//If the LoadVariablesFlag is set, the server is expected to respond with a MIME type of
									//application/x-www-form-urlencoded and a body in the format
									//var1=value1&var2=value2&...&varx=valuex. This response is used to populate
									//ActionScript variables rather than display a document. The variables populated can be in a
									//timeline (if LoadTargetFlag is 0) or in the specified sprite (if LoadTargetFlag is 1).
									//If the LoadTargetFlag is specified without the LoadVariablesFlag, the server is expected to
									//respond with a MIME type of application/x-shockwave-flash and a body that consists of a
									//SWF file. This response is used to load a subfile into the specified sprite rather than to display
									//an HTML document.
									
									codesStr+="\t\t\t\t\t"+AVM1Ops.opNameV[code.op];
									if(code.value.LoadVariablesFlag){
										if(code.value.LoadTargetFlag){
											codesStr+=" LOAD_VARIABLES"
										}else{
											codesStr+=" LOAD_VARIABLES_NUM"
										}
									}else{
										if(code.value.LoadTargetFlag){
											codesStr+=" LOAD_MOVIE"
										}else{
											codesStr+=" GET_URL"
										}
									}
									switch(code.value.SendVarsMethod){
										case 1:
											codesStr+=",GET";
										break;
										case 2:
											codesStr+=",POST";
										break;
										default://0 或 3
											//codesStr+="";
										break;
									}
									codesStr+="\n";
								break;
								
								case AVM1Ops.constantPool://0x88	//Vector.<String>
									//ActionConstantPool
									//ActionConstantPool creates a new constant pool, and replaces the old constant pool if one
									//already exists.
									//Field 				Type 					Comment
									//ActionConstantPool 	ACTIONRECORDHEADER 		ActionCode = 0x88
									//Count 				UI16 					Number of constants to follow
									//ConstantPool 			STRING[Count] 			String constants
									
									subStr="";
									for each(pushValue in code.value){
										subStr+=",\""+ComplexString.normal.escape(pushValue)+"\"";
									}
									codesStr+="\t\t\t\t\t//"+AVM1Ops.opNameV[code.op]+" "+subStr.substr(1)+"\n";
									//codesStr+="\t\t\t\t\t"+AVM1Ops.opNameV[code.op]+" "+subStr.substr(1)+"\n";trace("暂时不使用自动注解");
								break;
								case AVM1Ops.push://0x96	//Vector.<*>
									//ActionPush
									//ActionPush pushes one or more values to the stack.
									//Field 				Type 					Comment
									//ActionPush 			ACTIONRECORDHEADER 		ActionCode = 0x96
									//Type 					UI8 					0 = string literal
									//												1 = floating-point literal
									//												The following types are available in SWF 5 and later:
									//												2 = null
									//												3 = undefined
									//												4 = register
									//												5 = Boolean
									//												6 = double
									//												7 = integer
									//												8 = constant 8
									//												9 = constant 16
									//String 				If Type = 0, STRING 	Null-terminated character string
									//Float 				If Type = 1, FLOAT 		32-bit IEEE single-precision little-endian floating-point value
									//RegisterNumber 		If Type = 4, UI8 		Register number
									//Boolean 				If Type = 5, UI8 		Boolean value
									//Double 				If Type = 6, DOUBLE 	64-bit IEEE double-precision littleendian double value
									//Integer 				If Type = 7, UI32 		32-bit little-endian integer
									//Constant8 			If Type = 8, UI8 		Constant pool index (for indexes < 256) (see ActionConstantPool)
									//Constant16 			If Type = 9, UI16 		Constant pool index (for indexes >= 256) (see ActionConstantPool)
									//ActionPush pushes one or more values onto the stack. The Type field specifies the type of the
									//value to be pushed.
									//If Type = 1, the value to be pushed is specified as a 32-bit IEEE single-precision little-endian
									//floating-point value. 
									
									//PropertyIds are pushed as FLOATs. ActionGetProperty and ActionSetProperty use PropertyIds to access the properties of named objects.
									//ActionGetProperty 和 ActionSetProperty 用浮点数来索引对应的属性名（貌似改成整数了也没事）。
									
									//If Type = 4, the value to be pushed is a register number. Flash Player supports up to 4
									//registers. With the use of ActionDefineFunction2, up to 256 registers can be used.
									
									//In the first field of ActionPush, the length in ACTIONRECORD defines the total number of
									//Type and value bytes that follow the ACTIONRECORD itself. More than one set of Type
									//and value fields may follow the first field, depending on the number of bytes that the length
									//in ACTIONRECORD specifies.
									//ActionPush 可能会 push 一个或多个值，直到到达这个 ActionPush ACTIONRECORD 的结尾。
									
									subStr="";
									for each(pushValue in code.value){
										if(pushValue is String){
											subStr+=",\""+ComplexString.normal.escape(pushValue)+"\"";
										}else if(pushValue is Number){
											subStr+=","+pushValue;
										}else if(pushValue===true){
											subStr+=","+pushValue;
										}else if(pushValue){
											subStr+=",r:"+pushValue.r;
										}else{
											subStr+=","+pushValue;
										}
									}
									codesStr+="\t\t\t\t\t"+AVM1Ops.opNameV[code.op]+" "+subStr.substr(1)+"\n";
								break;
								case AVM1Ops.try_://0x8f	//{CatchRegister:int|CatchName:String,TryBody:LabelMark,CatchBody:LabelMark,FinallyBody:LabelMark}
									//ActionTry
									//ActionTry defines handlers for exceptional conditions, implementing the ActionScript try,
									//catch, and finally keywords.
									//Field 				Type 									Comment
									//ActionTry 			ACTIONRECORDHEADER 						ActionCode = 0x8F
									//Reserved 				UB[5] 									Always zero
									//CatchInRegisterFlag 	UB[1] 									0 - Do not put caught object into register (instead, store in named variable)
									//																1 - Put caught object into register (do not store in named variable)
									//FinallyBlockFlag 		UB[1] 									0 - No finally block
									//																1 - Has finally block
									//CatchBlockFlag 		UB[1] 									0 - No catch block
									//																1 - Has catch block
									//TrySize 				UI16 									Length of the try block
									//CatchSize 			UI16 									Length of the catch block
									//FinallySize 			UI16 									Length of the finally block
									//CatchName 			If CatchInRegisterFlag = 0, STRING		Name of the catch variable
									//CatchRegister 		If CatchInRegisterFlag = 1, UI8 		Register to catch into
									//TryBody 				UI8[TrySize] 							Body of the try block
									//CatchBody 			UI8[CatchSize] 							Body of the catch block, if any
									//FinallyBody 			UI8[FinallySize] 						Body of the finally block, if any
									//NOTE
									//The CatchSize and FinallySize fields always exist, whether or not the CatchBlockFlag or
									//FinallyBlockFlag settings are 1.
									//NOTE
									//The try, catch, and finally blocks do not use end tags to mark the end of their respective
									//blocks. Instead, the length of a block is set by the TrySize, CatchSize, and FinallySize
									//values.
									
									codesStr+="\t\t\t\t\t"+AVM1Ops.opNameV[code.op];
									if(code.value.CatchRegister>-1){
										codesStr+=" r:"+code.value.CatchRegister;
									}else{
										codesStr+=" "+ComplexString.normal.escape(code.value.CatchName);
									}
									codesStr+="(try end label"+code.value.TryBody.labelId+")";
									if(code.value.CatchBody){
										codesStr+="(catch end label"+code.value.CatchBody.labelId+")";
									}
									if(code.value.FinallyBody){
										codesStr+="(finally end label"+code.value.FinallyBody.labelId+")";
									}
									codesStr+="\n";
								break;
								case AVM1Ops.defineFunction://0x9b	//{FunctionName:String,paramV:Vector.<String>,endMark:LabelMark}
									//ActionDefineFunction
									//NOTE
									//ActionDefineFunction is rarely used as of SWF 7 and later; it was superseded by
									//ActionDefineFunction2.
									//ActionDefineFunction defines a function with a given name and body size.
									//Field 				Type 					Comment
									//ActionDefineFunction 	ACTIONRECORDHEADER 		ActionCode = 0x9B
									//FunctionName 			STRING 					Function name, empty if anonymous
									//NumParams 			UI16 					# of parameters
									//param 1 				STRING 					Parameter name 1
									//param 2 				STRING 					Parameter name 2
									//...
									//param N 				STRING 					Parameter name N
									//codeSize 				UI16 					# of bytes of code that follow
									//ActionDefineFunction parses (in order) FunctionName, NumParams, [param1, param2, …,
									//param N] and then code size.
									//ActionDefineFunction does the following:
									//1. Parses the name of the function (name) from the action tag.
									//2. Skips the parameters in the tag.
									//3. Parses the code size from the tag.
									//After the DefineFunction tag, the next codeSize bytes of action data are considered to be
									//the body of the function.
									//4. Gets the code for the function.
									//ActionDefineFunction can be used in the following ways:
									//Usage 1 Pushes an anonymous function on the stack that does not persist. This function is
									//a function literal that is declared in an expression instead of a statement. An anonymous
									//function can be used to define a function, return its value, and assign it to a variable in one
									//expression, as in the following ActionScript:
									//area = (function () {return Math.PI * radius *radius;})(5);
									//Usage 2 Sets a variable with a given FunctionName and a given function definition. This is
									//the more conventional function definition. For example, in ActionScript:
									//function Circle(radius) {
									//	this.radius = radius;
									//	this.area = Math.PI * radius * radius;
									//}
									
									subStr="";
									for each(var param:String in code.value.paramV){
										subStr+=","+ComplexString.normal.escape(param);
									}
									codesStr+="\t\t\t\t\t"+AVM1Ops.opNameV[code.op]+" "+ComplexString.normal.escape(code.value.FunctionName)+"("+subStr.substr(1)+")(end label"+code.value.endMark.labelId+")\n";
								break;
								case AVM1Ops.defineFunction2://0x8e	//{FunctionName:String,RegisterCount:int,PreloadParentFlag:Boolean,PreloadRootFlag:Boolean,SuppressSuperFlag:Boolean,PreloadSuperFlag:Boolean,SuppressArgumentsFlag:Boolean,PreloadArgumentsFlag:Boolean,SuppressThisFlag:Boolean,PreloadThisFlag:Boolean,PreloadGlobalFlag:Boolean,Parameters:Vector.<Object>,endMark:LabelMark}
									//ActionDefineFunction2
									//ActionDefineFunction2 is similar to ActionDefineFunction, with additional features that can
									//help speed up the execution of function calls by preventing the creation of unused variables in
									//the function's activation object and by enabling the replacement of local variables with a
									//variable number of registers. With ActionDefineFunction2, a function can allocate its own
									//private set of up to 256 registers. Parameters or local variables can be replaced with a register,
									//which is loaded with the value instead of the value being stored in the function's activation
									//object. (The activation object is an implicit local scope that contains named arguments and
									//local variables. For further description of the activation object, see the ECMA-262 standard.)
									//ActionDefineFunction2 also includes six flags to instruct Flash Player to preload variables,
									//and three flags to suppress variables. By setting PreloadParentFlag, PreloadRootFlag,
									//PreloadSuperFlag, PreloadArgumentsFlag, PreloadThisFlag, or
									//PreloadGlobalFlag, common variables can be preloaded into registers before the function
									//executes (_parent, _root, super, arguments, this, or _global, respectively). With flags
									//SuppressSuper, SuppressArguments, and SuppressThis, common variables super,
									//arguments, and this are not created. By using suppress flags, Flash Player avoids preevaluating
									//variables, thus saving time and improving performance.
									//No suppress flags are provided for _parent, _root, or _global because Flash Player always
									//evaluates these variables as needed; no time is ever wasted on pre-evaluating these variables.
									//Specifying both the preload flag and the suppress flag for any variable is not allowed.
									//The body of the function that ActionDefineFunction2 specifies should use ActionPush and
									//ActionStoreRegister for local variables that are assigned to registers. ActionGetVariable and
									//ActionSetVariable cannot be used for variables assigned to registers.
									//Flash Player 6 release 65 and later supports ActionDefineFunction2.
									//Field 				Type 						Comment
									//ActionDefineFunction2	ACTIONRECORDHEADER 			ActionCode = 0x8E
									//FunctionName 			STRING 						Name of function, empty if anonymous
									//NumParams 			UI16 						# of parameters
									//RegisterCount 		UI8 						Number of registers to allocate, up to 255 registers (from 0 to 254)
									//PreloadParentFlag 	UB[1] 						0 = Don't preload _parent into register
									//													1 = Preload _parent into register
									//PreloadRootFlag 		UB[1] 						0 = Don't preload _root into register
									//													1 = Preload _root into register
									//SuppressSuperFlag 	UB[1] 						0 = Create super variable
									//													1 = Don't create super variable
									//PreloadSuperFlag 		UB[1] 						0 = Don't preload super into register
									//													1 = Preload super into register
									//SuppressArgumentsFlag	UB[1] 						0 = Create arguments variable
									//													1 = Don't create arguments variable
									//PreloadArgumentsFlag 	UB[1] 						0 = Don't preload arguments into register
									//													1 = Preload arguments into register
									//SuppressThisFlag 		UB[1] 						0 = Create this variable
									//													1 = Don't create this variable
									//PreloadThisFlag 		UB[1] 						0 = Don't preload this into register
									//													1 = Preload this into register
									//Reserved 				UB[7] 						Always 0
									//PreloadGlobalFlag 	UB[1] 						0 = Don't preload _global into register
									//													1 = Preload _global into register
									//Parameters 			REGISTERPARAM[NumParams]	See REGISTERPARAM, following
									//codeSize 				UI16 						# of bytes of code that follow
									//REGISTERPARAM is defined as follows:
									//Field 				Type 					Comment
									//Register 				UI8 					For each parameter to the function, a register can be specified. If the register specified is zero, the parameter is created as a variable named ParamName in the activation object, which can be referenced with ActionGetVariable and ActionSetVariable. If the register specified is nonzero, the parameter is copied into the register, and it can be referenced with ActionPush and ActionStoreRegister, and no variable is created in the activation object.
									//ParamName 			STRING 					Parameter name
									//The function body following an ActionDefineFunction2 consists of further action codes, just
									//as for ActionDefineFunction.
									//Flash Player selects register numbers by first copying each argument into the register specified
									//in the corresponding REGISTERPARAM record. Next, the preloaded variables are copied
									//into registers starting at 1, and in the order this, arguments, super, _root, _parent,
									//and _global, skipping any that are not to be preloaded. (The SWF file must accurately
									//specify which registers will be used by preloaded variables and ensure that no parameter uses a
									//register number that falls within this range, or else that parameter is overwritten by a
									//preloaded variable.)
									//The value of NumParams should equal the number of parameter registers. The value of
									//RegisterCount should equal NumParams plus the number of preloaded variables and the
									//number of local variable registers desired.
									//For example, if NumParams is 2, RegisterCount is 6, PreloadThisFlag is 1, and
									//PreloadRootFlag is 1, the REGISTERPARAM records will probably specify registers 3 and 4.
									//Register 1 will be this, register 2 will be _root, registers 3 and 4 will be the first and second
									//parameters, and registers 5 and 6 will be for local variables.
									
									subStr="";
									for each(var Parameter:Object in code.value.Parameters){
										subStr+=",r:"+Parameter.Register+"=\""+ComplexString.normal.escape(Parameter.ParamName)+"\"";
									}
									codesStr+="\t\t\t\t\t"+AVM1Ops.opNameV[code.op]+" "+ComplexString.normal.escape(code.value.FunctionName)+"(RegisterCount="+code.value.RegisterCount+")(flags="+(
										(code.value.PreloadParentFlag?"|PRELOAD_PARENT":"")+
										(code.value.PreloadRootFlag?"|PRELOAD_ROOT":"")+
										(code.value.SuppressSuperFlag?"|SUPPRESS_SUPER":"")+
										(code.value.PreloadSuperFlag?"|PRELOAD_SUPER":"")+
										(code.value.SuppressArgumentsFlag?"|SUPPRESS_ARGUMENTS":"")+
										(code.value.PreloadArgumentsFlag?"|PRELOAD_ARGUMENTS":"")+
										(code.value.SuppressThisFlag?"|SUPPRESS_THIS":"")+
										(code.value.PreloadThisFlag?"|PRELOAD_THIS":"")+
										(code.value.PreloadGlobalFlag?",PRELOAD_GLOBAL":"")
										).substr(1)+")("+subStr.substr(1)+")(end label"+code.value.endMark.labelId+")\n";
									
								break;
								
								default:
									throw new Error("未知 op: "+code.op);
								break;
							}
						}else{
							throw new Error("未知 code: "+code);
						}
					}
				}
				
				return new XML("<"+xmlName+" class=\"zero.swf.avm1.ACTIONRECORDs\"><![CDATA[\n"+
					codesStr
					+"\t\t\t\t]]></"+xmlName+">");
			}
			return <{xmlName}/>;
		}
		public function initByXML(xml:XML,_initByXMLOptions:Object/*zero_swf_InitByXMLOptions*/):void{
			var codeStrArr:Array=xml.toString().replace(/^\s*|\s*$/g,"").split(/\s*\n\s*/);
			var codeId:int=-1;
			codeArr=new Array();
			
			var codeStr:String;
			var i:int;
			var labelMarkMark:Object=new Object();
			
			var subStr:String;
			
			var execResult:Array;
			
			var code_value:*;
			
			i=codeStrArr.length;
			while(--i>=0){
				codeStr=codeStrArr[i];
				if(codeStr.indexOf("//")==0){
					//注解
					codeStrArr.splice(i,1);
				}else if(/^label(\d+):$/.test(codeStr)){
					if(labelMarkMark[codeStr]){
						throw new Error("重复的 labelMark: "+codeStr);
					}
					labelMarkMark[codeStr]=new LabelMark(int(codeStr.replace(/^label(\d+):$/,"$1")));
				}
			}
			for each(codeStr in codeStrArr){
				codeId++;
				if(/^label(\d+):$/.test(codeStr)){
					codeArr[codeId]=labelMarkMark[codeStr];
				}else if((codeStr+" ").search(/[0-9a-fA-F]{2}\s+/)==0){
					Outputer.output("使用 ByteArray 进行记录的未知代码："+codeStr,"brown");
					codeArr[codeId]=BytesAndStr16.str162bytes(codeStr);
				}else{
					execResult=/^(\w+)\s*(.*?)$/.exec(codeStr);
					if(AVM1Ops[execResult[1]]>=0){
						var op:int=AVM1Ops[execResult[1]];
						if(op<0x80){
							codeArr[codeId]=op;
						}else{
							switch(op){
								case AVM1Ops.call://0x9e	//
									//ActionCall
									//ActionCall calls a subroutine.
									//Field 				Type 					Comment
									//ActionCall 			ACTIONRECORDHEADER 		ActionCode = 0x9E
									//ActionCall does the following:
									//1. Pops a value off the stack.
									//This value should be either a string that matches a frame label, or a number that indicates
									//a frame number. The value can be prefixed by a target string that identifies the movie clip
									//that contains the frame being called.
									//2. If the frame is successfully located, the actions in the target frame are executed.
									//After the actions in the target frame are executed, execution resumes at the instruction
									//after the ActionCall instruction.
									//3. If the frame cannot be found, nothing happens.
									
									codeArr[codeId]=new Code(op);
								break;
								case AVM1Ops.storeRegister://0x87	//int
									//ActionStoreRegister
									//ActionStoreRegister reads the next object from the stack (without popping it) and stores it in
									//one of four registers. If ActionDefineFunction2 is used, up to 256 registers are available.
									//Field 				Type 					Comment
									//ActionStoreRegister 	ACTIONRECORDHEADER 		ActionCode = 0x87
									//RegisterNumber 		UI8
									//ActionStoreRegister parses register number from the StoreRegister tag.
									
									codeArr[codeId]=new Code(op,int(execResult[2]));
								break;
								case AVM1Ops.gotoFrame://0x81	//int
									//ActionGotoFrame
									//ActionGotoFrame instructs Flash Player to go to the specified（指定） frame in the current file.
									//Field 				Type 					Comment
									//ActionGotoFrame 		ACTIONRECORDHEADER 		ActionCode = 0x81; Length is always 2
									//Frame 				UI16 					Frame index
									
									codeArr[codeId]=new Code(op,int(execResult[2]));
								break;
								case AVM1Ops.gotoFrame2://0x9f	//{Play:Boolean,SceneBias:int}
									//ActionGotoFrame2
									//ActionGotoFrame2 goes to a frame and is stack based.
									//Field 				Type 						Comment
									//ActionGotoFrame2 		ACTIONRECORDHEADER 			ActionCode = 0x9F
									//Reserved 				UB[6] 						Always 0
									//SceneBiasFlag 		UB[1] 						Scene bias flag
									//Play flag 			UB[1] 						0 = Go to frame and stop
									//													1 = Go to frame and play
									//SceneBias 			If SceneBiasFlag = 1, UI16 	Number to be added to frame determined by stack argument
									//ActionGotoFrame2 does the following:
									//1. Pops a frame off the stack.
									//■ If the frame is a number, n, the next frame of the movie to be displayed is the nth
									//frame in the current movie clip.
									//■ If the frame is a string, frame is treated as a frame label. If the specified label exists in
									//the current movie clip, the labeled frame will become the current frame. Otherwise,
									//the action is ignored.
									//2. Either a frame or a number can be prefixed by a target path, for example, /MovieClip:3 or
									///MovieClip:FrameLabel.
									//3. If the Play flag is set, the action goes to the specified frame and begins playing the enclosing
									//movie clip. Otherwise, the action goes to the specified frame and stops.
									
									execResult=/^(PLAY|STOP)(?:\s*,\s*(.*?))?$/.exec(execResult[2]);
									code_value={
										Play:execResult[1]=="PLAY"
									};
									if(execResult[2]){
										code_value.SceneBias=int(execResult[2]);
									}
									codeArr[codeId]=new Code(op,code_value);
								break;
								case AVM1Ops.setTarget://0x8b	//String
									//ActionSetTarget
									//ActionSetTarget instructs Flash Player to change the context of subsequent（随后） actions, so they
									//apply to a named object (TargetName) rather than the current file.
									//For example, the SetTarget action can be used to control the Timeline of a sprite object. The
									//following sequence of actions sends a sprite called "spinner" to the first frame in its
									//Timeline:
									//1. SetTarget "spinner"
									//2. GotoFrame zero
									//3. SetTarget " " (empty string)
									//4. End of actions. (Action code = 0)
									//All actions following SetTarget "spinner" apply to the spinner object until SetTarget "",
									//which sets the action context back to the current file. For a complete discussion of target
									//names see DefineSprite.
									//Field 				Type 					Comment
									//ActionSetTarget 		ACTIONRECORDHEADER 		ActionCode = 0x8B
									//TargetName 			STRING 					Target of action target
								case AVM1Ops.gotoLabel://0x8c	//String
									//ActionGoToLabel
									//ActionGoToLabel instructs Flash Player to go to the frame associated with the specified label.
									//You can attach a label to a frame with the FrameLabel tag.
									//Field 				Type 					Comment
									//ActionGoToLabel 		ACTIONRECORDHEADER 		ActionCode = 0x8C
									//Label 				STRING 					Frame label
									
									execResult=/^("|')(.*)\1$/.exec(execResult[2]);
									codeArr[codeId]=new Code(op,ComplexString.normal.unescape(execResult[2]));
								break;
								
								case AVM1Ops.waitForFrame://0x8a	//{Frame:int,label:LabelMark}
									//ActionWaitForFrame
									//ActionWaitForFrame instructs Flash Player to wait until the specified frame; otherwise skips
									//the specified number of actions.
									//Field 				Type 					Comment
									//ActionWaitForFrame 	ACTIONRECORDHEADER 		ActionCode = 0x8A; Length is always 3
									//Frame 				UI16 					Frame to wait for
									//SkipCount 			UI8 					Number of actions to skip if frame is not loaded
									
									execResult=/^(.*?)\s*,\s*(label\d+)$/.exec(execResult[2]);
									code_value={
										Frame:int(execResult[1]),
										label:labelMarkMark[execResult[2]+":"]
									};
									if(code_value.label){
									}else{
										throw new Error("找不到对应的 labelMark: "+codeStr);
									}
									codeArr[codeId]=new Code(op,code_value);
								break;
								case AVM1Ops.waitForFrame2://0x8d	//LabelMark
									//ActionWaitForFrame2
									//ActionWaitForFrame2 waits for a frame to be loaded and is stack based.
									//Field 				Type 					Comment
									//ActionWaitForFrame2 	ACTIONRECORDHEADER 		ActionCode = 0x8D; Length is always 1
									//SkipCount 			UI8 					The number of actions to skip
									//ActionWaitForFrame2 does the following:
									//1. Pops a frame off the stack.
									//2. If the frame is loaded, skip the next n actions that follow the current action, where n is
									//indicated by SkipCount.
									//The frame is evaluated in the same way as ActionGotoFrame2.
								case AVM1Ops.with_://0x94	//LabelMark
									//ActionWith
									//Defines a With block of script.
									//Field 				Type 					Comment
									//ActionWith 			ACTIONRECORDHEADER 		ActionCode = 0x94
									//Size 					UI16 					# of bytes of code that follow
									//ActionWith does the following:
									//1. Pops the object involved with the With.
									//2. Parses the size (body length) of the With block from the ActionWith tag.
									//3. Checks to see if the depth of calls exceeds the maximum depth, which is 16 for SWF 6 and
									//later, and 8 for SWF 5.
									//If the With depth exceeds the maximum depth, the next Size bytes of data are skipped
									//rather than executed.
									//4. After the ActionWith tag, the next Size bytes of action codes are considered to be the body
									//of the With block.
									//5. Adds the With block to the scope chain.
								case AVM1Ops.jump://0x99	//LabelMark
									//ActionJump
									//ActionJump creates an unconditional branch.
									//Field 				Type 					Comment
									//ActionJump 			ACTIONRECORDHEADER 		ActionCode = 0x99
									//BranchOffset 			SI16 					Offset
									//ActionJump adds BranchOffset bytes to the instruction pointer in the execution stream.
									//The offset is a signed quantity, enabling branches from –32,768 bytes to 32,767 bytes. An
									//offset of 0 points to the action directly after the ActionJump action.
								case AVM1Ops.if_://0x9d		//LabelMark
									//ActionIf
									//ActionIf creates a conditional test and branch.
									//Field 				Type 					Comment
									//ActionIf 				ACTIONRECORDHEADER 		ActionCode = 0x9D
									//BranchOffset 			SI16 					Offset
									//ActionIf does the following:
									//1. Pops Condition, a number, off the stack.
									//2. Converts Condition to a Boolean value.
									//3. Tests if Condition is true.
									//If Condition is true, BranchOffset bytes are added to the instruction pointer in the
									//execution stream.
									//NOTE
									//When playing a SWF 4 file, Condition is not converted to a Boolean value and is
									//instead compared to 0, not true.
									//The offset is a signed quantity, enabling branches from –32768 bytes to 32767 bytes. An
									//offset of 0 points to the action directly after the ActionIf action.
									
									code_value=labelMarkMark[execResult[2]+":"];
									if(code_value){
									}else{
										throw new Error("找不到对应的 labelMark: "+codeStr);
									}
									codeArr[codeId]=new Code(op,code_value);
								break;
								
								case AVM1Ops.getURL://0x83	//{UrlString:String,TargetString:String}
									//ActionGetURL
									//ActionGetURL instructs Flash Player to get the URL that UrlString specifies. The URL can
									//be of any type, including an HTML file, an image or another SWF file. If the file is playing in
									//a browser, the URL is displayed in the frame that TargetString specifies. The "_level0" and
									//"_level1" special target names are used to load another SWF file into levels 0 and 1 respectively.
									//Field 				Type 					Comment
									//ActionGetURL 			ACTIONRECORDHEADER 		ActionCode = 0x83
									//UrlString 			STRING 					Target URL string
									//TargetString 			STRING 					Target string
									
									//execResult=/^("|')(.*)\1\s*,\s*("|')(.*)\3$/.exec(codeStr);//直接操作将对 codeStr="'\"'"+","+'"\\\',"xx"' 出错
									
									execResult=/^("|')(.*)\1\s*,\s*("|')(.*)\3$/.exec(execResult[2].replace(/\\\\/g,"\\x5c").replace(/\\"/g,"\\x22").replace(/\\'/g,"\\x27"));
									codeArr[codeId]=new Code(op,{
										UrlString:ComplexString.normal.unescape(execResult[2]),
										TargetString:ComplexString.normal.unescape(execResult[4])
									});
								break;
								case AVM1Ops.getURL2://0x9a	//{LoadVariablesFlag:Boolean,LoadTargetFlag:Boolean,SendVarsMethod:int}
									//ActionGetURL2
									//ActionGetURL2 gets a URL and is stack based.
									//Field 				Type 				Comment
									//ActionGetURL2 		ACTIONRECORDHEADER 	ActionCode = 0x9A; Length is always 1
									//SendVarsMethod 		UB[2] 				0 = None
									//											1 = GET
									//											2 = POST
									//Reserved 				UB[4] 				Always 0
									//LoadTargetFlag 		UB[1] 				0 = Target is a browser window
									//											1 = Target is a path to a sprite
									//LoadVariablesFlag 	UB[1] 				0 = No variables to load
									//											1 = Load variables
									//ActionGetURL2 does the following:
									//1. Pops target off the stack.
									//■ A LoadTargetFlag value of 0 indicates that the target is a window. The target can be an
									//empty string to indicate the current window.
									//■ A LoadTargetFlag value of 1 indicates that the target is a path to a sprite. The target
									//path can be in slash or dot syntax.
									//2. Pops a URL off the stack; the URL specifies the URL to be retrieved.
									//3. SendVarsMethod specifies the method to use for the HTTP request.
									//■ A SendVarsMethod value of 0 indicates that this is not a form request, so the movie
									//clip's variables should not be encoded and submitted.
									//■ A SendVarsMethod value of 1 specifies a HTTP GET request.
									//■ A SendVarsMethod value of 2 specifies a HTTP POST request.
									//4. If the SendVarsMethod value is 1 (GET) or 2 (POST), the variables in the current movie
									//clip are submitted to the URL by using the standard x-www-form-urlencoded encoding
									//and the HTTP request method specified by method.
									//If the LoadVariablesFlag is set, the server is expected to respond with a MIME type of
									//application/x-www-form-urlencoded and a body in the format
									//var1=value1&var2=value2&...&varx=valuex. This response is used to populate
									//ActionScript variables rather than display a document. The variables populated can be in a
									//timeline (if LoadTargetFlag is 0) or in the specified sprite (if LoadTargetFlag is 1).
									//If the LoadTargetFlag is specified without the LoadVariablesFlag, the server is expected to
									//respond with a MIME type of application/x-shockwave-flash and a body that consists of a
									//SWF file. This response is used to load a subfile into the specified sprite rather than to display
									//an HTML document.
									
									execResult=/^(GET_URL|LOAD_MOVIE|LOAD_VARIABLES_NUM|LOAD_VARIABLES)(?:\s*,\s*(GET|POST))?$/.exec(execResult[2]);
									switch(execResult[1]){
										case "GET_URL":
											code_value={
												LoadVariablesFlag:false,
												LoadTargetFlag:false
											};
										break;
										case "LOAD_MOVIE":
											code_value={
												LoadVariablesFlag:false,
												LoadTargetFlag:true
											};
										break;
										case "LOAD_VARIABLES_NUM":
											code_value={
												LoadVariablesFlag:true,
												LoadTargetFlag:false
											};
										break;
										case "LOAD_VARIABLES":
											code_value={
												LoadVariablesFlag:true,
												LoadTargetFlag:true
											};
										break;
									}
									switch(execResult[2]){
										case "GET":
											code_value.SendVarsMethod=1;
										break;
										case "POST":
											code_value.SendVarsMethod=2;
										break;
										default:
											code_value.SendVarsMethod=0;//0 或 3
										break;
									}
									codeArr[codeId]=new Code(op,code_value);
								break;
								
								case AVM1Ops.constantPool://0x88	//Vector.<String>
									//ActionConstantPool
									//ActionConstantPool creates a new constant pool, and replaces the old constant pool if one
									//already exists.
									//Field 				Type 					Comment
									//ActionConstantPool 	ACTIONRECORDHEADER 		ActionCode = 0x88
									//Count 				UI16 					Number of constants to follow
									//ConstantPool 			STRING[Count] 			String constants
									
									execResult=execResult[2].replace(/\\\\/g,"\\x5c").replace(/\\"/g,"\\x22").replace(/\\'/g,"\\x27").match(/("|').*?\1/g);
									i=-1;
									code_value=new Vector.<String>();
									for each(subStr in execResult){
										i++;
										code_value[i]=ComplexString.normal.unescape(subStr.substr(1,subStr.length-2));
									}
									codeArr[codeId]=new Code(op,code_value);
								break;
								case AVM1Ops.push://0x96	//Vector.<*>
									//ActionPush
									//ActionPush pushes one or more values to the stack.
									//Field 				Type 					Comment
									//ActionPush 			ACTIONRECORDHEADER 		ActionCode = 0x96
									//Type 					UI8 					0 = string literal
									//												1 = floating-point literal
									//												The following types are available in SWF 5 and later:
									//												2 = null
									//												3 = undefined
									//												4 = register
									//												5 = Boolean
									//												6 = double
									//												7 = integer
									//												8 = constant 8
									//												9 = constant 16
									//String 				If Type = 0, STRING 	Null-terminated character string
									//Float 				If Type = 1, FLOAT 		32-bit IEEE single-precision little-endian floating-point value
									//RegisterNumber 		If Type = 4, UI8 		Register number
									//Boolean 				If Type = 5, UI8 		Boolean value
									//Double 				If Type = 6, DOUBLE 	64-bit IEEE double-precision littleendian double value
									//Integer 				If Type = 7, UI32 		32-bit little-endian integer
									//Constant8 			If Type = 8, UI8 		Constant pool index (for indexes < 256) (see ActionConstantPool)
									//Constant16 			If Type = 9, UI16 		Constant pool index (for indexes >= 256) (see ActionConstantPool)
									//ActionPush pushes one or more values onto the stack. The Type field specifies the type of the
									//value to be pushed.
									//If Type = 1, the value to be pushed is specified as a 32-bit IEEE single-precision little-endian
									//floating-point value. 
									
									//PropertyIds are pushed as FLOATs. ActionGetProperty and ActionSetProperty use PropertyIds to access the properties of named objects.
									//ActionGetProperty 和 ActionSetProperty 用浮点数来索引对应的属性名（貌似改成整数了也没事）。
									
									//If Type = 4, the value to be pushed is a register number. Flash Player supports up to 4
									//registers. With the use of ActionDefineFunction2, up to 256 registers can be used.
									
									//In the first field of ActionPush, the length in ACTIONRECORD defines the total number of
									//Type and value bytes that follow the ACTIONRECORD itself. More than one set of Type
									//and value fields may follow the first field, depending on the number of bytes that the length
									//in ACTIONRECORD specifies.
									//ActionPush 可能会 push 一个或多个值，直到到达这个 ActionPush ACTIONRECORD 的结尾。
									
									execResult=(execResult[2].replace(/\\\\/g,"\\x5c").replace(/\\"/g,"\\x22").replace(/\\'/g,"\\x27")+",").match(/("|').*?\1,|[^,]*?,/g);
									i=-1;
									code_value=new Vector.<*>();
									for each(subStr in execResult){
										i++;
										codeStr=subStr.replace(/^\s*|,\s*$/g,"");
										switch(codeStr){
											case "null":
												code_value[i]=null;
											break;
											case "undefined":
												code_value[i]=undefined;
											break;
											case "true":
												code_value[i]=true;
											break;
											case "false":
												code_value[i]=false;
											break;
											case "NaN":
												code_value[i]=NaN;//Number
											break;
											default:
												if(/^("|').*\1$/.test(codeStr)){
													code_value[i]=ComplexString.normal.unescape(codeStr.substr(1,codeStr.length-2));
												}else if(codeStr.indexOf("r:")==0){
													code_value[i]={r:int(codeStr.substr(2))};
												}else{
													code_value[i]=Number(codeStr);
													if(isNaN(code_value[i])){
														throw new Error("未知 codeStr: "+codeStr);
													}
												}
											break;
										}
									}
									codeArr[codeId]=new Code(op,code_value);
								break;
								case AVM1Ops.try_://0x8f	//{CatchRegister:int|CatchName:String,TryBody:LabelMark,CatchBody:LabelMark,FinallyBody:LabelMark}
									//ActionTry
									//ActionTry defines handlers for exceptional conditions, implementing the ActionScript try,
									//catch, and finally keywords.
									//Field 				Type 									Comment
									//ActionTry 			ACTIONRECORDHEADER 						ActionCode = 0x8F
									//Reserved 				UB[5] 									Always zero
									//CatchInRegisterFlag 	UB[1] 									0 - Do not put caught object into register (instead, store in named variable)
									//																1 - Put caught object into register (do not store in named variable)
									//FinallyBlockFlag 		UB[1] 									0 - No finally block
									//																1 - Has finally block
									//CatchBlockFlag 		UB[1] 									0 - No catch block
									//																1 - Has catch block
									//TrySize 				UI16 									Length of the try block
									//CatchSize 			UI16 									Length of the catch block
									//FinallySize 			UI16 									Length of the finally block
									//CatchName 			If CatchInRegisterFlag = 0, STRING		Name of the catch variable
									//CatchRegister 		If CatchInRegisterFlag = 1, UI8 		Register to catch into
									//TryBody 				UI8[TrySize] 							Body of the try block
									//CatchBody 			UI8[CatchSize] 							Body of the catch block, if any
									//FinallyBody 			UI8[FinallySize] 						Body of the finally block, if any
									//NOTE
									//The CatchSize and FinallySize fields always exist, whether or not the CatchBlockFlag or
									//FinallyBlockFlag settings are 1.
									//NOTE
									//The try, catch, and finally blocks do not use end tags to mark the end of their respective
									//blocks. Instead, the length of a block is set by the TrySize, CatchSize, and FinallySize
									//values.
									
									execResult=/^(.*?)\s*\(\s*try\s+end\s+(label\d+)\s*\)\s*(?:\(\s*catch\s+end\s+(label\d+)\s*\))?\s*(?:\(\s*finally\s+end\s+(label\d+)\s*\))?$/.exec(execResult[2]);
									if(execResult[1].indexOf("r:")==0){
										code_value={
											CatchRegister:int(execResult[1].substr(2)),
											TryBody:labelMarkMark[execResult[2]+":"]
										};
									}else{
										code_value={
											CatchName:ComplexString.normal.unescape(execResult[1]),
											TryBody:labelMarkMark[execResult[2]+":"]
										};
									}
									if(code_value.TryBody){
									}else{
										throw new Error("找不到对应的 labelMark: "+codeStr);
									}
									if(execResult[3]){
										code_value.CatchBody=labelMarkMark[execResult[3]+":"];
										if(code_value.CatchBody){
										}else{
											throw new Error("找不到对应的 labelMark: "+codeStr);
										}
									}
									if(execResult[4]){
										code_value.FinallyBody=labelMarkMark[execResult[4]+":"];
										if(code_value.FinallyBody){
										}else{
											throw new Error("找不到对应的 labelMark: "+codeStr);
										}
									}
									codeArr[codeId]=new Code(op,code_value);
								break;
								case AVM1Ops.defineFunction://0x9b	//{FunctionName:String,paramV:Vector.<String>,endMark:LabelMark}
									//ActionDefineFunction
									//NOTE
									//ActionDefineFunction is rarely used as of SWF 7 and later; it was superseded by
									//ActionDefineFunction2.
									//ActionDefineFunction defines a function with a given name and body size.
									//Field 				Type 					Comment
									//ActionDefineFunction 	ACTIONRECORDHEADER 		ActionCode = 0x9B
									//FunctionName 			STRING 					Function name, empty if anonymous
									//NumParams 			UI16 					# of parameters
									//param 1 				STRING 					Parameter name 1
									//param 2 				STRING 					Parameter name 2
									//...
									//param N 				STRING 					Parameter name N
									//codeSize 				UI16 					# of bytes of code that follow
									//ActionDefineFunction parses (in order) FunctionName, NumParams, [param1, param2, …,
									//param N] and then code size.
									//ActionDefineFunction does the following:
									//1. Parses the name of the function (name) from the action tag.
									//2. Skips the parameters in the tag.
									//3. Parses the code size from the tag.
									//After the DefineFunction tag, the next codeSize bytes of action data are considered to be
									//the body of the function.
									//4. Gets the code for the function.
									//ActionDefineFunction can be used in the following ways:
									//Usage 1 Pushes an anonymous function on the stack that does not persist. This function is
									//a function literal that is declared in an expression instead of a statement. An anonymous
									//function can be used to define a function, return its value, and assign it to a variable in one
									//expression, as in the following ActionScript:
									//area = (function () {return Math.PI * radius *radius;})(5);
									//Usage 2 Sets a variable with a given FunctionName and a given function definition. This is
									//the more conventional function definition. For example, in ActionScript:
									//function Circle(radius) {
									//	this.radius = radius;
									//	this.area = Math.PI * radius * radius;
									//}
									
									execResult=/^(.*?)\s*\(\s*(.*)\s*\)\s*\(\s*end\s+(label\d+)\s*\)$/.exec(execResult[2]);
									code_value={
										FunctionName:ComplexString.normal.unescape(execResult[1]),
										paramV:new Vector.<String>(),
										endMark:labelMarkMark[execResult[3]+":"]
									};
									if(code_value.endMark){
									}else{
										throw new Error("找不到对应的 endMark: "+codeStr);
									}
									if(execResult[2]){
										i=-1;
										for each(var param:String in execResult[2].replace(/\\\\/g,"\\x5c").replace(/\\,/g,"\\x2c").split(/\s*,\s*/)){
											i++;
											code_value.paramV[i]=ComplexString.normal.unescape(param);
										}
									}
									codeArr[codeId]=new Code(op,code_value);
								break;
								case AVM1Ops.defineFunction2://0x8e	//?
									//ActionDefineFunction2
									//ActionDefineFunction2 is similar to ActionDefineFunction, with additional features that can
									//help speed up the execution of function calls by preventing the creation of unused variables in
									//the function's activation object and by enabling the replacement of local variables with a
									//variable number of registers. With ActionDefineFunction2, a function can allocate its own
									//private set of up to 256 registers. Parameters or local variables can be replaced with a register,
									//which is loaded with the value instead of the value being stored in the function's activation
									//object. (The activation object is an implicit local scope that contains named arguments and
									//local variables. For further description of the activation object, see the ECMA-262 standard.)
									//ActionDefineFunction2 also includes six flags to instruct Flash Player to preload variables,
									//and three flags to suppress variables. By setting PreloadParentFlag, PreloadRootFlag,
									//PreloadSuperFlag, PreloadArgumentsFlag, PreloadThisFlag, or
									//PreloadGlobalFlag, common variables can be preloaded into registers before the function
									//executes (_parent, _root, super, arguments, this, or _global, respectively). With flags
									//SuppressSuper, SuppressArguments, and SuppressThis, common variables super,
									//arguments, and this are not created. By using suppress flags, Flash Player avoids preevaluating
									//variables, thus saving time and improving performance.
									//No suppress flags are provided for _parent, _root, or _global because Flash Player always
									//evaluates these variables as needed; no time is ever wasted on pre-evaluating these variables.
									//Specifying both the preload flag and the suppress flag for any variable is not allowed.
									//The body of the function that ActionDefineFunction2 specifies should use ActionPush and
									//ActionStoreRegister for local variables that are assigned to registers. ActionGetVariable and
									//ActionSetVariable cannot be used for variables assigned to registers.
									//Flash Player 6 release 65 and later supports ActionDefineFunction2.
									//Field 				Type 						Comment
									//ActionDefineFunction2	ACTIONRECORDHEADER 			ActionCode = 0x8E
									//FunctionName 			STRING 						Name of function, empty if anonymous
									//NumParams 			UI16 						# of parameters
									//RegisterCount 		UI8 						Number of registers to allocate, up to 255 registers (from 0 to 254)
									//PreloadParentFlag 	UB[1] 						0 = Don't preload _parent into register
									//													1 = Preload _parent into register
									//PreloadRootFlag 		UB[1] 						0 = Don't preload _root into register
									//													1 = Preload _root into register
									//SuppressSuperFlag 	UB[1] 						0 = Create super variable
									//													1 = Don't create super variable
									//PreloadSuperFlag 		UB[1] 						0 = Don't preload super into register
									//													1 = Preload super into register
									//SuppressArgumentsFlag	UB[1] 						0 = Create arguments variable
									//													1 = Don't create arguments variable
									//PreloadArgumentsFlag 	UB[1] 						0 = Don't preload arguments into register
									//													1 = Preload arguments into register
									//SuppressThisFlag 		UB[1] 						0 = Create this variable
									//													1 = Don't create this variable
									//PreloadThisFlag 		UB[1] 						0 = Don't preload this into register
									//													1 = Preload this into register
									//Reserved 				UB[7] 						Always 0
									//PreloadGlobalFlag 	UB[1] 						0 = Don't preload _global into register
									//													1 = Preload _global into register
									//Parameters 			REGISTERPARAM[NumParams]	See REGISTERPARAM, following
									//codeSize 				UI16 						# of bytes of code that follow
									//REGISTERPARAM is defined as follows:
									//Field 				Type 					Comment
									//Register 				UI8 					For each parameter to the function, a register can be specified. If the register specified is zero, the parameter is created as a variable named ParamName in the activation object, which can be referenced with ActionGetVariable and ActionSetVariable. If the register specified is nonzero, the parameter is copied into the register, and it can be referenced with ActionPush and ActionStoreRegister, and no variable is created in the activation object.
									//ParamName 			STRING 					Parameter name
									//The function body following an ActionDefineFunction2 consists of further action codes, just
									//as for ActionDefineFunction.
									//Flash Player selects register numbers by first copying each argument into the register specified
									//in the corresponding REGISTERPARAM record. Next, the preloaded variables are copied
									//into registers starting at 1, and in the order this, arguments, super, _root, _parent,
									//and _global, skipping any that are not to be preloaded. (The SWF file must accurately
									//specify which registers will be used by preloaded variables and ensure that no parameter uses a
									//register number that falls within this range, or else that parameter is overwritten by a
									//preloaded variable.)
									//The value of NumParams should equal the number of parameter registers. The value of
									//RegisterCount should equal NumParams plus the number of preloaded variables and the
									//number of local variable registers desired.
									//For example, if NumParams is 2, RegisterCount is 6, PreloadThisFlag is 1, and
									//PreloadRootFlag is 1, the REGISTERPARAM records will probably specify registers 3 and 4.
									//Register 1 will be this, register 2 will be _root, registers 3 and 4 will be the first and second
									//parameters, and registers 5 and 6 will be for local variables.
									
									execResult=/^(.*?)\s*\(\s*RegisterCount\s*=\s*(\d+)\s*\)\(\s*flags\s*=\s*(.*?)\s*\)\s*\(\s*(.*)\s*\)\s*\(\s*end\s+(label\d+)\s*\)$/.exec(execResult[2]);
									
									code_value={
										FunctionName:ComplexString.normal.unescape(execResult[1]),
										RegisterCount:int(execResult[2]),
										Parameters:new Vector.<Object>(),
										endMark:labelMarkMark[execResult[5]+":"]
									};
									if(code_value.endMark){
									}else{
										throw new Error("找不到对应的 endMark: "+codeStr);
									}
									
									for each(var Flag:String in execResult[3].match(/\w+/g)){
										switch(Flag){
											case "PRELOAD_PARENT":
												code_value.PreloadParentFlag=true;
											break;
											case "PRELOAD_ROOT":
												code_value.PreloadRootFlag=true;
											break;
											case "SUPPRESS_SUPER":
												code_value.SuppressSuperFlag=true;
											break;
											case "PRELOAD_SUPER":
												code_value.PreloadSuperFlag=true;
											break;
											case "SUPPRESS_ARGUMENTS":
												code_value.SuppressArgumentsFlag=true;
											break;
											case "PRELOAD_ARGUMENTS":
												code_value.PreloadArgumentsFlag=true;
											break;
											case "SUPPRESS_THIS":
												code_value.SuppressThisFlag=true;
											break;
											case "PRELOAD_THIS":
												code_value.PreloadThisFlag=true;
											break;
											case "PRELOAD_GLOBAL":
												code_value.PreloadGlobalFlag=true;
											break;
											default:
												throw new Error("Flag="+Flag);
											break;
										}
									}
									
									if(execResult[4]){
										i=-1;
										for each(var ParameterStr:String in execResult[4].replace(/\\\\/g,"\\x5c").replace(/\\"/g,"\\x22").replace(/\\'/g,"\\x27").match(/r\:\d+\s*=\s*("|').*?\1/g)){
											execResult=/^r\:(\d+)\s*=\s*("|')(.*)\2$/.exec(ParameterStr);
											i++;
											code_value.Parameters[i]={
												Register:int(execResult[1]),
												ParamName:ComplexString.normal.unescape(execResult[3])
											};
										}
									}
									codeArr[codeId]=new Code(op,code_value);
								break;
								default:
									throw new Error("未知 op: "+op);
								break;
							}
						}
					}else{
						throw new Error("未知 codeStr: "+codeStr);
					}
				}
			}
		}
		}//end of CONFIG::USE_XML
	}
}

