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
			var labelMarkArr:Array=new Array();
			var codeByOffsetArr:Array=new Array();
			if(_initByDataOptions&&_initByDataOptions.ActionsGetHexArr){
				var hexByOffsetArr:Array=new Array();
			}
			
			//var code:*;
			var Length:int;
			
			var jumpOffset:int,jumpPos:int,i:int;
			var skipId:int;
			
			var get_str_size:int;
			
			var constStrV:Vector.<String>;
			
			var flags:int;
			var NumParams:int;
			
			var startOffset:int=offset;
			
			while(offset<endOffset){
				var pos:int=offset;
				var op:int=data[offset++];
				
				if(op<0x80){
					codeByOffsetArr[pos]=op;
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
							codeByOffsetArr[pos]=new Code(op);
							
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
							codeByOffsetArr[pos]=new Code(op,data[offset++]);
							
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
							codeByOffsetArr[pos]=new Code(op,data[offset++]|(data[offset++]<<8));
							
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
							codeByOffsetArr[pos]=new Code(op,{
								Play:((flags&0x01)?true:false)				//00000001
							});
							//code.value.Reserved=flags&0xfc;				//11111100
							if(flags&0x02){//SceneBiasFlag					//00000010
								codeByOffsetArr[pos].value.SceneBias=data[offset++]|(data[offset++]<<8);
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
							
							///
							Length=data[offset++]|(data[offset++]<<8);
							
							///
							data.position=offset;
							codeByOffsetArr[pos]=new Code(op,data.readUTFBytes(Length));
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
							codeByOffsetArr[pos]=new Code(op,{
								Frame:data[offset++]|(data[offset++]<<8)
							});
							
							skipId=data[offset++];
							jumpPos=offset;
							while(--skipId>=0){
								if(data[jumpPos++]<0x80){//skipOp
								}else{
									jumpPos+=data[jumpPos++]|(data[jumpPos++]<<8);//skipLength
								}
							}
							if(jumpPos<0||jumpPos>endOffset){
								jumpPos=endOffset;
								Outputer.output("jumpPos 已修正为: "+jumpPos,"brown");
							}
							codeByOffsetArr[pos].value.label=(labelMarkArr[jumpPos]||(labelMarkArr[jumpPos]=new LabelMark(++labelId)));
							
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
									jumpPos+=data[jumpPos++]|(data[jumpPos++]<<8);//skipLength
								}
							}
							if(jumpPos<0||jumpPos>endOffset){
								jumpPos=endOffset;
								Outputer.output("jumpPos 已修正为: "+jumpPos,"brown");
							}
							codeByOffsetArr[pos]=new Code(op,labelMarkArr[jumpPos]||(labelMarkArr[jumpPos]=new LabelMark(++labelId)));
							
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
							codeByOffsetArr[pos]=new Code(op,labelMarkArr[jumpPos]||(labelMarkArr[jumpPos]=new LabelMark(++labelId)));
							
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
							codeByOffsetArr[pos]=new Code(op,labelMarkArr[jumpPos]||(labelMarkArr[jumpPos]=new LabelMark(++labelId)));
							
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
							codeByOffsetArr[pos]=new Code(op,{
								UrlString:data.readUTFBytes(get_str_size)
							});
							offset+=get_str_size;
							get_str_size=0;
							while(data[offset+(get_str_size++)]){}
							data.position=offset;
							codeByOffsetArr[pos].value.TargetString=data.readUTFBytes(get_str_size);
							offset+=get_str_size;
							
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
							codeByOffsetArr[pos]=new Code(op,{
								LoadVariablesFlag:((flags&0x80)?true:false)							//10000000
							});
							codeByOffsetArr[pos].value.LoadTargetFlag=((flags&0x40)?true:false);		//01000000
							//codeByOffsetArr[pos].value.Reserved=flags&0x3c;							//00111100
							codeByOffsetArr[pos].value.SendVarsMethod=flags&0x03;						//00000011
						
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
							codeByOffsetArr[pos]=new Code(op,constStrV);
							
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
							codeByOffsetArr[pos]=new Code(op,pushValueV);
							
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
							//codeByOffsetArr[pos].value.Reserved=flags&0xf8;		//11111000
							
							var TrySize:int=data[offset++]|(data[offset++]<<8);//其实不是 jump
							var CatchSize:int=data[offset++]|(data[offset++]<<8);//其实不是 jump
							var FinallySize:int=data[offset++]|(data[offset++]<<8);//其实不是 jump
							if(flags&0x04){//CatchInRegisterFlag					//00000100
								codeByOffsetArr[pos]=new Code(op,{
									CatchRegister:data[offset++]
								});
							}else{
								get_str_size=0;
								while(data[offset+(get_str_size++)]){}
								data.position=offset;
								codeByOffsetArr[pos]=new Code(op,{
									CatchName:data.readUTFBytes(get_str_size)
								});
								offset+=get_str_size;
							}
							jumpPos=offset+TrySize;
							if(jumpPos<0||jumpPos>endOffset){
								jumpPos=endOffset;
								Outputer.output("jumpPos 已修正为: "+jumpPos,"brown");
							}
							codeByOffsetArr[pos].value.TryBody=(labelMarkArr[jumpPos]||(labelMarkArr[jumpPos]=new LabelMark(++labelId)));
							if(flags&0x01){//CatchBlockFlag							//00000001
								jumpPos=offset+TrySize+CatchSize;
								if(jumpPos<0||jumpPos>endOffset){
									jumpPos=endOffset;
									Outputer.output("jumpPos 已修正为: "+jumpPos,"brown");
								}
								codeByOffsetArr[pos].value.CatchBody=(labelMarkArr[jumpPos]||(labelMarkArr[jumpPos]=new LabelMark(++labelId)));
							}
							
							if(flags&0x02){//FinallyBlockFlag						//00000010
								jumpPos=offset+TrySize+CatchSize+FinallySize;
								if(jumpPos<0||jumpPos>endOffset){
									jumpPos=endOffset;
									Outputer.output("jumpPos 已修正为: "+jumpPos,"brown");
								}
								codeByOffsetArr[pos].value.FinallyBody=(labelMarkArr[jumpPos]||(labelMarkArr[jumpPos]=new LabelMark(++labelId)));
							}
							
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
							
							get_str_size=0;
							while(data[offset+(get_str_size++)]){}
							data.position=offset;
							codeByOffsetArr[pos]=new Code(op,{
								FunctionName:data.readUTFBytes(get_str_size),
								paramV:new Vector.<String>()
							});
							offset+=get_str_size;
							
							NumParams=data[offset++]|(data[offset++]<<8);
							for(i=0;i<NumParams;i++){
								get_str_size=0;
								while(data[offset+(get_str_size++)]){}
								data.position=offset;
								codeByOffsetArr[pos].value.paramV[i]=data.readUTFBytes(get_str_size);
								offset+=get_str_size;
							}
							
							jumpOffset=data[offset++]|(data[offset++]<<8);//其实不是 jump
							jumpPos=offset+jumpOffset;//offset+codeSize
							if(jumpPos<0||jumpPos>endOffset){
								jumpPos=endOffset;
								Outputer.output("jumpPos 已修正为: "+jumpPos,"brown");
							}
							codeByOffsetArr[pos].value.endMark=(labelMarkArr[jumpPos]||(labelMarkArr[jumpPos]=new LabelMark(++labelId)));
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
							
							get_str_size=0;
							while(data[offset+(get_str_size++)]){}
							data.position=offset;
							codeByOffsetArr[pos]=new Code(op,{
								FunctionName:data.readUTFBytes(get_str_size),
								Parameters:new Vector.<Object>()
							});
							offset+=get_str_size;
							
							NumParams=data[offset++]|(data[offset++]<<8);
							
							codeByOffsetArr[pos].value.RegisterCount=data[offset++];
							
							flags=data[offset++];
							code.value.PreloadParentFlag=(flags<<24)>>>31;					//10000000
							code.value.PreloadRootFlag=(flags<<25)>>>31;					//01000000
							code.value.SuppressSuperFlag=(flags<<26)>>>31;					//00100000
							code.value.PreloadSuperFlag=(flags<<27)>>>31;					//00010000
							code.value.SuppressArgumentsFlag=(flags<<28)>>>31;				//00001000
							code.value.PreloadArgumentsFlag=(flags<<29)>>>31;				//00000100
							code.value.SuppressThisFlag=(flags<<30)>>>31;					//00000010
							code.value.PreloadThisFlag=flags&0x01;							//00000001
							
							code.value.PreloadGlobalFlag=data[offset++]&0x01;				//00000001
							
							for(i=0;i<NumParams;i++){
								code.value.Parameters[i]={Register:data[offset++]};
								get_str_size=0;
								while(data[offset+(get_str_size++)]){}
								data.position=offset;
								codeByOffsetArr[pos].value.Parameters[i].ParamName=data.readUTFBytes(get_str_size);
								offset+=get_str_size;
							}
							
							jumpOffset=data[offset++]|(data[offset++]<<8);//其实不是 jump
							jumpPos=offset+jumpOffset;//offset+codeSize
							if(jumpPos<0||jumpPos>endOffset){
								jumpPos=endOffset;
								Outputer.output("jumpPos 已修正为: "+jumpPos,"brown");
							}
							codeByOffsetArr[pos].value.endMark=(labelMarkArr[jumpPos]||(labelMarkArr[jumpPos]=new LabelMark(++labelId)));
						break;
						
						default:
							codeByOffsetArr[pos]=new ByteArray();
							codeByOffsetArr[pos].writeBytes(data,pos,3+Length);
							Outputer.output("对未知代码使用 ByteArray 进行记录："+BytesAndStr16.bytes2str16(codeByOffsetArr[pos],0,codeByOffsetArr[pos].length),"brown");
							Outputer.outputError("未知 op: "+op);
						break;
					}
				}
				if(hexByOffsetArr){
					hexByOffsetArr[pos]=BytesAndStr16.bytes2str16(data,pos,offset-pos);
				}
			}
			
			if(offset==endOffset){
			}else{
				trace("offset="+offset+",endOffset="+endOffset);
			}
			
			if(hexByOffsetArr){
				hexArr=new Array();
			}
			codeArr=new Array();
			var codeId:int=-1;
			
			for(offset=startOffset;offset<=endOffset;offset++){
				if(labelMarkArr[offset]){
					codeId++;
					codeArr[codeId]=labelMarkArr[offset];
				}
				if(codeByOffsetArr[offset]==null){
				}else{
					codeId++;
					if(hexArr){
						hexArr[codeId]=hexByOffsetArr[offset];
					}
					codeArr[codeId]=codeByOffsetArr[offset];
				}
			}
			
			return endOffset;
		}
		public function toData(_toDataOptions:Object/*zero_swf_ToDataOptions*/):ByteArray{
			var data:ByteArray=new ByteArray();
			//data.endian=Endian.LITTLE_ENDIAN;
			
			var posMarkArr:Array=new Array();//记录 branch, branchIfTrue, function_, function2 的位置及相关的 label 位置
			
			var offset:int=0,pos:int,Length:int;
			
			var jumpOffset:int,i:int;
			
			var pushValue:*;
			
			var code:*;
			
			//统计需要放 const 里的字符串
			var constStrMark:Object=new Object();
			var constStrV:Vector.<String>=new Vector.<String>();
			var constCode:Code=null;
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
											constStrV.push(pushValue);
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
				for each(pushValue in constStrV){
					if(constStrMark["~"+pushValue]>1){//使用2次或以上的字符串才有需要放常量池里
						constCode.value.push(pushValue);
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
				
				pos=offset;
				
				data[offset++]=AVM1Ops.constantPool;
				
				offset+=2;//Length
				
				var Count:int=constStrV.length;
				data[offset++]=Count;
				data[offset++]=Count>>8;
				data.position=offset;
				for each(pushValue in constStrV){
					data.writeUTFBytes(pushValue+"\x00");
				}
				offset=data.length;
				
				Length=offset-pos-3;
				data[pos+1]=Length;
				data[pos+2]=Length>>8;
			}else{
				constCode=null;
				constStrV=null;
				constStrMark=null;
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
						if(code.op<0x80){
							throw new Error("请直接用 int");
						}else if(code.op==AVM1Ops.constantPool){
							if(constCode){
								if(constCode==code){
								}else{
									throw new Error("constCode!=code");
								}
							}
						}else{
							pos=offset;
							
							data[offset++]=code.op;
							
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
									data[offset++]=0x00;
									data[offset++]=0x01;//Length==1
									
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
									data[offset++]=0x00;
									data[offset++]=0x02;//Length==2
									
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
									flags=0;
									//flags|=code.value.Reserved;				//11111100
									if(code.value.SceneBias>-1){
										flags|=0x02;//SceneBiasFlag				//00000010
										
										///
										data[offset++]=0x00;
										data[offset++]=0x03;//Length==3
									}else{
										///
										data[offset++]=0x00;
										data[offset++]=0x01;//Length==1
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
									
									///
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
									data[offset++]=0x00;
									data[offset++]=0x03;//Length==3
									
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
									data[offset++]=0x00;
									data[offset++]=0x01;//Length==1
									
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
									data[offset++]=0x00;
									data[offset++]=0x02;//Length==2
									
									///
									offset+=2;//SkipCount
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
									
									///
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
									data[offset++]=0x00;
									data[offset++]=0x01;//Length==1
									
									///
									flags=0;
									if(code.value.LoadVariablesFlag){
										flags|=0x80;								//10000000
									}
									if(code.value.LoadTargetFlag){
										flags|=0x40;								//01000000
									}
									flags|=code.value.Reserved;						//00111100
									flags|=code.value.SendVarsMethod;				//00000011
									data[offset++]=flags;
									
									///
								
								break;
								
								//case AVM1Ops.constantPool://0x88	//UI16,STRING[Count]
									//ActionConstantPool
									//ActionConstantPool creates a new constant pool, and replaces the old constant pool if one
									//already exists.
									//Field 				Type 					Comment
									//ActionConstantPool 	ACTIONRECORDHEADER 		ActionCode = 0x88
									//Count 				UI16 					Number of constants to follow
									//ConstantPool 			STRING[Count] 			String constants
									//
								//break;
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
									
									///
									offset+=2;//Length
									
									///
									var flags:int=0;
									if(code.value.CatchRegister>-1){
										flags|=0x04;//CatchInRegisterFlag		//00001000
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
									
									///
									offset+=2;//Length
									
									///
									data.position=offset;
									data.writeUTFBytes(code.value.FunctionName+"\x00");
									offset=data.length;
									data[offset++]=code.value.paramV.length;
									data[offset++]=code.value.paramV.length>>8;
									data.position=offset;
									for each(var param:String in code.value.paramV){
										data.writeUTFBytes(param+"\x00");
									}
									offset=data.length;
									//先用 0 占位，后面一次性写入
									data[offset++]=0x00;
									data[offset++]=0x00;
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
									
									data.position=offset;
									data.writeUTFBytes(code.value.FunctionName+"\x00");
									offset=data.length;
									
									data[offset++]=code.value.Parameters.length;
									data[offset++]=code.value.Parameters.length>>8;
									
									data[offset++]=code.value.RegisterCount;
									
									data[offset++]=
										(code.value.PreloadParentFlag<<7)
										|
										(code.value.PreloadRootFlag<<6)
										|
										(code.value.SuppressSuperFlag<<5)
										|
										(code.value.PreloadSuperFlag<<4)
										|
										(code.value.SuppressArgumentsFlag<<3)
										|
										(code.value.PreloadArgumentsFlag<<2)
										|
										(code.value.SuppressThisFlag<<1)
										|
										code.value.PreloadThisFlag;
										
									data[offset++]=code.value.PreloadGlobalFlag;
									
									for each(var Parameter:Object in code.value.Parameters){
										data[offset++]=Parameter.Register;
										data.position=offset;
										data.writeUTFBytes(Parameter.ParamName+"\x00");
										offset=data.length;
									}
									//先用 0 占位，后面一次性写入
									data[offset++]=0x00;
									data[offset++]=0x00;
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
			}
			
			var skipId:int,jumpPos:int,skipOp:int,skipLength:int;
			
			var endOffset:int=data.length;
			for(offset=0;offset<=endOffset;offset++){
				if(posMarkArr[offset]){
					if(posMarkArr[offset] is LabelMark){
						jumpOffset=posMarkArr[offset].pos-offset;
						data[offset-2]=jumpOffset;
						data[offset-1]=jumpOffset>>8;
					}else{
						code=posMarkArr[offset];
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
									skipOp=data[jumpPos++];
									if(skipOp<0x80){
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
									skipOp=data[jumpPos++];
									if(skipOp<0x80){
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
							codesStr+="\t\t\t\t\t"+AVM1Ops.opNameV[code];
						}else if(code is Code){
							if(code.op==AVM1Ops.constantPool){
								codesStr+="\t\t\t\t\t//"+AVM1Ops.opNameV[code.op];//- -
								//codesStr+="\t\t\t\t\t"+AVM1Ops.opNameV[code.op];trace("暂时不使用自动注解");
							}else{
								codesStr+="\t\t\t\t\t"+AVM1Ops.opNameV[code.op];
							}
							if(code.op<0x80){
								throw new Error("请直接用 int");
							}else{
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
									
									break;
									case AVM1Ops.storeRegister://0x87	//int
										//ActionStoreRegister
										//ActionStoreRegister reads the next object from the stack (without popping it) and stores it in
										//one of four registers. If ActionDefineFunction2 is used, up to 256 registers are available.
										//Field 				Type 					Comment
										//ActionStoreRegister 	ACTIONRECORDHEADER 		ActionCode = 0x87
										//RegisterNumber 		UI8
										//ActionStoreRegister parses register number from the StoreRegister tag.
										
										codesStr+=" "+code.value;
									break;
									case AVM1Ops.gotoFrame://0x81	//int
										//ActionGotoFrame
										//ActionGotoFrame instructs Flash Player to go to the specified（指定） frame in the current file.
										//Field 				Type 					Comment
										//ActionGotoFrame 		ACTIONRECORDHEADER 		ActionCode = 0x81; Length is always 2
										//Frame 				UI16 					Frame index
										
										codesStr+=" "+code.value;
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
										
										codesStr+=" "+(code.value.Play?"PLAY":"STOP")
										if(code.value.SceneBias>-1){
											codesStr+=","+code.value.SceneBias;
										}
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
										
										codesStr+=" \""+ComplexString.escape(code.value)+"\"";
									break;
									
									case AVM1Ops.waitForFrame://0x8a	//{Frame:int,label:LabelMark}
										//ActionWaitForFrame
										//ActionWaitForFrame instructs Flash Player to wait until the specified frame; otherwise skips
										//the specified number of actions.
										//Field 				Type 					Comment
										//ActionWaitForFrame 	ACTIONRECORDHEADER 		ActionCode = 0x8A; Length is always 3
										//Frame 				UI16 					Frame to wait for
										//SkipCount 			UI8 					Number of actions to skip if frame is not loaded
										
										codesStr+=" "+code.value.Frame+",label"+code.value.label.labelId;
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
										
										codesStr+=" label"+code.value.labelId;
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
										
										codesStr+=" \""+ComplexString.escape(code.value.UrlString)+"\",\""+ComplexString.escape(code.value.TargetString)+"\"";
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
											subStr+=",\""+ComplexString.escape(pushValue)+"\"";
										}
										codesStr+=" "+subStr.substr(1);
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
												subStr+=",\""+ComplexString.escape(pushValue)+"\"";
											}else if(pushValue is Number){
												subStr+=","+pushValue;
											}else if(pushValue){
												subStr+=",r:"+pushValue.r;
											}else{
												subStr+=","+pushValue;
											}
										}
										codesStr+=" "+subStr.substr(1);
									break;
									case AVM1Ops.try_://0x8f	//?
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
										
										if(code.value.CatchRegister>-1){
											codesStr+=" r:"+code.value.CatchRegister;
										}else{
											codesStr+=" "+ComplexString.escape(code.value.CatchName);
										}
										codesStr+="(try end label"+code.value.TryBody.labelId+")";
										if(code.value.CatchBody){
											codesStr+="(catch end label"+code.value.CatchBody.labelId+")";
										}
										if(code.value.FinallyBody){
											codesStr+="(finally end label"+code.value.FinallyBody.labelId+")";
										}
									break;
									case AVM1Ops.defineFunction://0x9b	//?
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
											subStr+=","+ComplexString.escape(param);
										}
										codesStr+=" "+ComplexString.escape(code.value.FunctionName)+"("+subStr.substr(1)+")(end label"+code.value.endMark.labelId+")";
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
										
										subStr="";
										for each(var Parameter:Object in code.value.Parameters){
											subStr+=",r:"+Parameter.Register+"=\""+ComplexString.escape(Parameter.ParamName)+"\"";
										}
										codesStr+=" "+ComplexString.escape(code.value.FunctionName)+"(RegisterCount="+code.value.RegisterCount+")(flags="+(
											(code.value.PreloadParentFlag?"|PRELOAD_PARENT":"")+
											(code.value.PreloadRootFlag?"|PRELOAD_ROOT":"")+
											(code.value.SuppressSuperFlag?"|SUPPRESS_SUPER":"")+
											(code.value.PreloadSuperFlag?"|PRELOAD_SUPER":"")+
											(code.value.SuppressArgumentsFlag?"|SUPPRESS_ARGUMENTS":"")+
											(code.value.PreloadArgumentsFlag?"|PRELOAD_ARGUMENTS":"")+
											(code.value.SuppressThisFlag?"|SUPPRESS_THIS":"")+
											(code.value.PreloadThisFlag?"|PRELOAD_THIS":"")+
											(code.value.PreloadGlobalFlag?",PRELOAD_GLOBAL":"")
											).substr(1)+")("+subStr.substr(1)+")(end label"+code.value.endMark.labelId+")";
										
									break;
									
									default:
										throw new Error("未知 op: "+code.op);
									break;
								}
							}
						}else{
							throw new Error("未知 code: "+code);
						}
						codesStr+="\n";
					}
				}
				
				return new XML("<"+xmlName+" class=\"zero.swf.avm1.ACTIONRECORDs\"><![CDATA[\n"+
					codesStr
					+"\t\t\t\t]]></"+xmlName+">");
			}
			return <{xmlName}/>;
		}
		public function initByXML(xml:XML,_initByXMLOptions:Object/*zero_swf_InitByXMLOptions*/):void{
			codeStr=xml.toString().replace(/^\s*|\s*$/g,"");
			var codeStrArr:Array=codeStr.split("\n");
			var codeId:int=-1;
			codeArr=new Array();
			
			var codeStr:String;
			var i:int=codeStrArr.length;
			var labelMarkMark:Object=new Object();
			
			var subStr:*;
			
			var execResult:Array;
			
			while(--i>=0){
				codeStrArr[i]=codeStr=codeStrArr[i].replace(/^\s*|\s*$/g,"");
				if(codeStr){
					if(codeStr.indexOf("//")==0){
						//注解
						codeStrArr.splice(i,1);
					}
				}else{
					//空白
					codeStrArr.splice(i,1);
				}
				if(/^label(\d+):$/.test(codeStr)){
					if(labelMarkMark[codeStr]){
						throw new Error("重复的 labelMark: "+codeStr);
					}
					labelMarkMark[codeStr]=new LabelMark(int(codeStr.replace(/label(\d+):/,"$1")));
				}
			}
			for each(codeStr in codeStrArr){
				
				//trace("codeStr="+codeStr);
				
				codeId++;
				if(/^label(\d+):$/.test(codeStr)){
					codeArr[codeId]=labelMarkMark[codeStr];
				}else if((codeStr+" ").search(/[0-9a-fA-F]{2}\s+/)==0){
					Outputer.output("使用 ByteArray 进行记录的未知代码："+codeStr,"brown");
					codeArr[codeId]=BytesAndStr16.str162bytes(codeStr);
				}else{
					var pos:int=codeStr.search(/\s+/);
					var opStr:String;
					if(pos==-1){
						opStr=codeStr;
					}else{
						opStr=codeStr.substr(0,pos);
					}
					
					if(AVM1Ops[opStr]>=0){
						var op:int=AVM1Ops[opStr];
						
						codeStr=codeStr.substr(pos).replace(/^\s*|\s*$/g,"");
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
									
									codeArr[codeId]=new Code(op,int(codeStr));
								break;
								case AVM1Ops.gotoFrame://0x81	//int
									//ActionGotoFrame
									//ActionGotoFrame instructs Flash Player to go to the specified（指定） frame in the current file.
									//Field 				Type 					Comment
									//ActionGotoFrame 		ACTIONRECORDHEADER 		ActionCode = 0x81; Length is always 2
									//Frame 				UI16 					Frame index
									
									codeArr[codeId]=new Code(op,int(codeStr));
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
									
									execResult=/^(PLAY|STOP)\s*,\s*(.*?)$/.exec(codeStr);
									codeArr[codeId]=new Code(op,{
										Play:execResult[1]=="PLAY"
									});
									if(execResult[2]){
										codeArr[codeId].value.SceneBias=int(execResult[2]);
									}
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
									
									execResult=/^("|')(.*)\1$/.exec(codeStr);
									codeArr[codeId]=new Code(op,ComplexString.unescape(execResult[2]));
								break;
								
								case AVM1Ops.waitForFrame://0x8a	//{Frame:int,label:LabelMark}
									//ActionWaitForFrame
									//ActionWaitForFrame instructs Flash Player to wait until the specified frame; otherwise skips
									//the specified number of actions.
									//Field 				Type 					Comment
									//ActionWaitForFrame 	ACTIONRECORDHEADER 		ActionCode = 0x8A; Length is always 3
									//Frame 				UI16 					Frame to wait for
									//SkipCount 			UI8 					Number of actions to skip if frame is not loaded
									
									execResult=/^(.*?)\s*,\s*(label\d+)$/.exec(codeStr);
									codeArr[codeId]=new Code(op,{
										Frame:int(execResult[1]),
										label:labelMarkMark[execResult[2]+":"]
									});
									if(codeArr[codeId].value.label){
									}else{
										throw new Error("找不到对应的 labelMark: "+codeStr);
									}
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
									
									codeArr[codeId]=new Code(op,labelMarkMark[codeStr+":"]);
									if(codeArr[codeId].value){
									}else{
										throw new Error("找不到对应的 labelMark: "+codeStr);
									}
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
									
									var str_c_arr:Array=codeStr.split("");
									var str_c_count:int=codeStr.length;
									var str_c_i:int=-1;
									codeStr="";
									while(++str_c_i<str_c_count){
										var str_c:String=codeStr[str_c_i];
										if(str_c=="\\"){
											switch(codeStr[str_c_i+1]){
												case '"':
													codeStr+="\\x22";
													str_c_i++;
												break;
												case "'":
													codeStr+="\\x27";
													str_c_i++;
												break;
												case "\\":
													codeStr+="\\\\";
													str_c_i++;
												break;
												default:
													codeStr+="\\";
												break;
											}
										}else{
											codeStr+=str_c;
										}
									}
									execResult=/^("|')(.*)\1\s*,\s*("|')(.*)\3$/.exec(codeStr);
									codeArr[codeId]=new Code(op,{
										UrlString:ComplexString.unescape(execResult[2]),
										TargetString:ComplexString.unescape(execResult[4])
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
									
									execResult=/^(GET_URL|LOAD_MOVIE|LOAD_VARIABLES_NUM|LOAD_VARIABLES)(?:\s*,\s*(GET|POST))$/.exec(codeStr);
									switch(execResult[1]){
										case "GET_URL":
											codeArr[codeId]=new Code(op,{
												LoadVariablesFlag:false,
												LoadTargetFlag:false
											});
										break;
										case "LOAD_MOVIE":
											codeArr[codeId]=new Code(op,{
												LoadVariablesFlag:false,
												LoadTargetFlag:true
											});
										break;
										case "LOAD_VARIABLES_NUM":
											codeArr[codeId]=new Code(op,{
												LoadVariablesFlag:true,
												LoadTargetFlag:false
											});
										break;
										case "LOAD_VARIABLES":
											codeArr[codeId]=new Code(op,{
												LoadVariablesFlag:true,
												LoadTargetFlag:true
											});
										break;
									}
									switch(execResult[2]){
										case "GET":
											codeArr[codeId].value.SendVarsMethod=1;
										break;
										case "POST":
											codeArr[codeId].value.SendVarsMethod=2;
										break;
										default:
											codeArr[codeId].value.SendVarsMethod=0;//0 或 3
										break;
									}
								break;
								
								case AVM1Ops.constantPool://0x88	//Vector.<String>
									//ActionConstantPool
									//ActionConstantPool creates a new constant pool, and replaces the old constant pool if one
									//already exists.
									//Field 				Type 					Comment
									//ActionConstantPool 	ACTIONRECORDHEADER 		ActionCode = 0x88
									//Count 				UI16 					Number of constants to follow
									//ConstantPool 			STRING[Count] 			String constants
									
									var str_c_arr:Array=codeStr.split("");
									var str_c_count:int=codeStr.length;
									var str_c_i:int=-1;
									codeStr="";
									while(++str_c_i<str_c_count){
										var str_c:String=codeStr[str_c_i];
										if(str_c=="\\"){
											switch(codeStr[str_c_i+1]){
												case '"':
													codeStr+="\\x22";
													str_c_i++;
												break;
												case "'":
													codeStr+="\\x27";
													str_c_i++;
												break;
												case "\\":
													codeStr+="\\\\";
													str_c_i++;
												break;
												default:
													codeStr+="\\";
												break;
											}
										}else{
											codeStr+=str_c;
										}
									}
									execResult=codeStr.match(/("|').*?\1/g);
									codeArr[codeId]=new Code(op,new Vector.<String>());
									for each(subStr in execResult){
										codeArr[codeId].value.push(ComplexString.unescape(subStr.substr(1,subStr.length-2)));
									}
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
									
									var str_c_arr:Array=codeStr.split("");
									var str_c_count:int=codeStr.length;
									var str_c_i:int=-1;
									codeStr="";
									while(++str_c_i<str_c_count){
										var str_c:String=codeStr[str_c_i];
										if(str_c=="\\"){
											switch(codeStr[str_c_i+1]){
												case '"':
													codeStr+="\\x22";
													str_c_i++;
												break;
												case "'":
													codeStr+="\\x27";
													str_c_i++;
												break;
												case "\\":
													codeStr+="\\\\";
													str_c_i++;
												break;
												default:
													codeStr+="\\";
												break;
											}
										}else{
											codeStr+=str_c;
										}
									}
									codeArr[codeId]=new Code(op,new Vector.<*>());
									while(codeStr){
										switch(codeStr.charAt(0)){
											case '"':
											case "'":
												var nextQuotPos:int=codeStr.indexOf(codeStr.charAt(0),1);
												if(nextQuotPos>-1){
													codeArr[codeId].value.push(ComplexString.unescape(codeStr.substr(1,nextQuotPos-1)));
												}else{
													throw new Error("找不到配对的 "+codeStr.charAt(0));
												}
												codeStr=codeStr.substr(nextQuotPos+1).replace(/^\s*,\s*/,"");
											break;
											default:
												var nextCommaPos:int=codeStr.search(/\s*,\s*/);
												if(nextCommaPos>-1){
												}else{
													nextCommaPos=codeStr.length;
												}
												subStr=codeStr.substr(0,nextCommaPos);
												switch(subStr){
													case "null":
														codeArr[codeId].value.push(null);
													break;
													case "undefined":
														codeArr[codeId].value.push(undefined);
													break;
													case "true":
														codeArr[codeId].value.push(true);
													break;
													case "false":
														codeArr[codeId].value.push(false);
													break;
													default:
														if(isNaN(subStr)){
															if(subStr.indexOf("r:")==0){
																codeArr[codeId].value.push({r:int(subStr.substr(2))});
															}else{
																throw new Error("未知 subStr: "+subStr);
															}
														}else{
															codeArr[codeId].value.push(Number(subStr));
														}
													break;
												}
												codeStr=codeStr.substr(nextCommaPos+1).replace(/^\s*,\s*/,"");
											break;
										}
									}
									//trace("code.value="+code.value.join("\n--------\n"));
								break;
								case AVM1Ops.try_://0x8f	//?
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
									
									codeArr[codeId]=new Code(op,{});
									execResult=/(.*?)\s*\[/.exec(codeStr);
									//trace("execResult[1]="+execResult[1]);
									if(execResult[1].indexOf("r:")==0){
										codeArr[codeId].value.CatchRegister=int(execResult[1].substr(2));
									}else{
										codeArr[codeId].value.CatchName=execResult[1];
									}
									for each(subStr in codeStr.match(/\[.*?\]/g)){
										execResult=/\[\s*end\s+(.*?)\s+with\s+(label\d+)\s*\]/.exec(subStr);
										if(labelMarkMark[execResult[2]+":"]){
										}else{
											throw new Error("找不到对应的 labelMark: "+subStr);
										}
										switch(execResult[1]){
											case "try":
												codeArr[codeId].value.TryBody=labelMarkMark[execResult[2]+":"];
											break;
											case "catch":
												codeArr[codeId].value.CatchBody=labelMarkMark[execResult[2]+":"];
											break;
											case "finally":
												codeArr[codeId].value.FinallyBody=labelMarkMark[execResult[2]+":"];
											break;
										}
									}
								break;
								case AVM1Ops.defineFunction://0x9b	//?
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
									
									execResult=/(.*?)\s*\(\s*(.*?)\s*\)\s*\[\s*end\s+with\s+(label\d+)\s*\]/.exec(codeStr);
									codeArr[codeId]=new Code(op,{
										FunctionName:ComplexString.unescape(execResult[1]),
										paramV:new Vector.<String>()
									});
									if(execResult[2]){
										for each(var param:String in execResult[2].split(/\s*,\s*/)){
											//trace("param="+param);
											codeArr[codeId].value.paramV.push(param);
										}
									}
									codeArr[codeId].value.endMark=labelMarkMark[execResult[3]+":"];
									if(codeArr[codeId].value.endMark){
									}else{
										throw new Error("找不到对应的 endMark: "+codeStr);
									}
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
									
									execResult=/(.*?)\s*\[\s*RegisterCount\s+(\d+)\s*\]\[\s*(.*?)\s*\]\(\s*(.*?)\s*\)\s*\[\s*end\s+with\s+(label\d+)\s*\]/.exec(codeStr);
									
									code=new Code(op,{
										FunctionName:ComplexString.unescape(execResult[1]),
										Parameters:new Vector.<Object>()
									});
									
									code.value.RegisterCount=int(execResult[2]);
									
									code.value.PreloadParentFlag=0;
									code.value.PreloadRootFlag=0;
									code.value.SuppressSuperFlag=0;
									code.value.PreloadSuperFlag=0;
									code.value.SuppressArgumentsFlag=0;
									code.value.PreloadArgumentsFlag=0;
									code.value.SuppressThisFlag=0;
									code.value.PreloadThisFlag=0;
									
									code.value.PreloadGlobalFlag=0;
									
									for each(var Flag:String in execResult[3].split(/\s*,\s*/)){
										code.value[Flag+"Flag"]=1;
									}
									
									codeArr[codeId].value.endMark=labelMarkMark[execResult[5]+":"];
									if(codeArr[codeId].value.endMark){
									}else{
										throw new Error("找不到对应的 endMark: "+codeStr);
									}
									
									if(execResult[4]){
										for each(var ParameterStr:String in execResult[4].match(/r\:\d+\s*=\s*".*?"/g)){
											execResult=/r\:(\d+)\s*=\s*"(.*?)"/.exec(ParameterStr);
											codeArr[codeId].value.Parameters.push({
												Register:int(execResult[1]),
												ParamName:ComplexString.unescape(execResult[2])
											});
										}
									}
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
				
				//trace("code="+codeArr[codeId]);
				//trace("--------------------------------------");
			}
		}
		}//end of CONFIG::USE_XML
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