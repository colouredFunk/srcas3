/***
DefineEditText
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月15日 13:32:47（代码生成器 V1.1.0 F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/
//The DefineEditText tag defines a dynamic text object, or text field.
//A text field is associated with an ActionScript variable name where the contents of the text
//field are stored. The SWF file can read and write the contents of the variable, which is always
//kept in sync with the text being displayed. If the ReadOnly flag is not set, users may change
//the value of a text field interactively.
//Fonts used by DefineEditText must be defined using DefineFont2, not DefineFont.
//
//The minimum file format version is SWF 4.
//
//DefineEditText
//Field 			Type 						Comment
//Header 			RECORDHEADER 				Tag type = 37.
//CharacterID 		UI16 						ID for this dynamic text character.
//Bounds 			RECT 						Rectangle that completely encloses the text field.
//HasText 			UB[1] 						0 = text field has no default text.
//												1 = text field initially displays the string specified by InitialText.
//WordWrap 			UB[1] 						0 = text will not wrap and will scroll sideways.
//												1 = text will wrap automatically when the end of line is reached.
//Multiline 		UB[1] 						0 = text field is one line only.
//												1 = text field is multi-line and scrollable.
//Password 			UB[1] 						0 = characters are displayed as typed.
//												1 = all characters are displayed as an asterisk.
//ReadOnly 			UB[1] 						0 = text editing is enabled.
//												1 = text editing is disabled.
//HasTextColor 		UB[1] 						0 = use default color.
//												1 = use specified color (TextColor).
//HasMaxLength 		UB[1] 						0 = length of text is unlimited.
//												1 = maximum length of string is specified by MaxLength.
//HasFont 			UB[1] 						0 = use default font.
//												1 = use specified font (FontID) and height (FontHeight). (Can't be true if HasFontClass is true).
//HasFontClass 		UB[1] 						0 = no fontClass, 1 = fontClass and Height specified for this text. (can't be true if HasFont is true). Supported in Flash Player 9.0.45.0 and later.
//AutoSize 			UB[1] 						0 = fixed size.
//												1 = sizes to content (SWF 6 or later only).
//HasLayout 		UB[1] 						Layout information provided.
//NoSelect 			UB[1] 						Enables or disables interactive text selection.
//Border 			UB[1] 						Causes a border to be drawn around the text field.
//WasStatic 		UB[1] 						0 = Authored as dynamic text
//												1 = Authored as static text
//HTML 				UB[1] 						0 = plaintext content.
//												1 = HTML content (see following).
//UseOutlines 		UB[1] 						0 = use device font.
//												1 = use glyph font.
//FontID 			If HasFont, UI16 			ID of font to use.
//FontClass 		If HasFontClass, STRING 	Class name of font to be loaded from another SWF and used for this text.
//FontHeight 		If HasFont, UI16 			Height of font in twips.
//TextColor 		If HasTextColor, RGBA 		Color of text.
//MaxLength 		If HasMaxLength, UI16 		Text is restricted to this length.
//Align 			If HasLayout, UI8 			0 = Left
//												1 = Right
//												2 = Center
//												3 = Justify
//LeftMargin 		If HasLayout, UI16 			Left margin in twips.
//RightMargin 		If HasLayout, UI16 			Right margin in twips.
//Indent 			If HasLayout, UI16 			Indent in twips.
//Leading 			If HasLayout, SI16 			Leading in twips (vertical distance between bottom of descender of one line and top of ascender of the next).
//VariableName 		STRING 						Name of the variable where the contents of the text field are stored. May be qualified with dot syntax or slash syntax for non-global variables.
//InitialText 		If HasText STRING 			Text that is initially displayed.
package zero.swf.tagBodys{
	import zero.swf.records.RECT;
	import zero.BytesAndStr16;
	import flash.utils.ByteArray;
	public class DefineEditText/*{*/implements I_zero_swf_CheckCodesRight{
		public var id:int;								//UI16
		public var Bounds:RECT;
		public var HasText:int;
		public var WordWrap:int;
		public var Multiline:int;
		public var Password:int;
		public var ReadOnly:int;
		public var HasTextColor:int;
		public var HasMaxLength:int;
		public var HasFont:int;
		public var HasFontClass:int;
		public var AutoSize:int;
		public var HasLayout:int;
		public var NoSelect:int;
		public var Border:int;
		public var WasStatic:int;
		public var HTML:int;
		public var UseOutlines:int;
		public var FontID:int;							//UI16
		public var FontClass:String;					//STRING
		public var FontHeight:int;						//UI16
		public var TextColor:uint;						//RGBA
		public var MaxLength:int;						//UI16
		public var Align:int;							//UI8
		public var LeftMargin:int;						//UI16
		public var RightMargin:int;						//UI16
		public var Indent:int;							//UI16
		public var Leading:int;							//SI16
		public var VariableName:String;					//STRING
		public var InitialText:String;					//STRING
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:zero_swf_InitByDataOptions):int{
			id=data[offset]|(data[offset+1]<<8);
			offset+=2;
			Bounds=new RECT();
			offset=Bounds.initByData(data,offset,endOffset,_initByDataOptions);
			var flags:int=data[offset++];
			HasText=(flags<<24)>>>31;					//10000000
			WordWrap=(flags<<25)>>>31;					//01000000
			Multiline=(flags<<26)>>>31;					//00100000
			Password=(flags<<27)>>>31;					//00010000
			ReadOnly=(flags<<28)>>>31;					//00001000
			HasTextColor=(flags<<29)>>>31;				//00000100
			HasMaxLength=(flags<<30)>>>31;				//00000010
			HasFont=flags&0x01;							//00000001
			flags=data[offset++];
			HasFontClass=(flags<<24)>>>31;				//10000000
			AutoSize=(flags<<25)>>>31;					//01000000
			HasLayout=(flags<<26)>>>31;					//00100000
			NoSelect=(flags<<27)>>>31;					//00010000
			Border=(flags<<28)>>>31;					//00001000
			WasStatic=(flags<<29)>>>31;					//00000100
			HTML=(flags<<30)>>>31;						//00000010
			UseOutlines=flags&0x01;						//00000001
			
			if(HasFont){
				FontID=data[offset++]|(data[offset++]<<8);
			}
			
			if(HasFontClass){
			
				var get_str_size:int=0;
				while(data[offset+(get_str_size++)]){}
				data.position=offset;
				FontClass=data.readUTFBytes(get_str_size);
				offset+=get_str_size;
			}
			
			if(HasFont){
				FontHeight=data[offset++]|(data[offset++]<<8);
			}
			
			if(HasTextColor){
				TextColor=(data[offset++]<<16)|(data[offset++]<<8)|data[offset++]|(data[offset++]<<24);
			}
			
			if(HasMaxLength){
				MaxLength=data[offset++]|(data[offset++]<<8);
			}
			
			if(HasLayout){
				Align=data[offset++];
			}
			
			if(HasLayout){
				LeftMargin=data[offset++]|(data[offset++]<<8);
			}
			
			if(HasLayout){
				RightMargin=data[offset++]|(data[offset++]<<8);
			}
			
			if(HasLayout){
				Indent=data[offset++]|(data[offset++]<<8);
			}
			
			if(HasLayout){
				Leading=data[offset++]|(data[offset++]<<8);
				if(Leading&0x00008000){Leading|=0xffff0000}//最高位为1,表示负数
			}
			
			get_str_size=0;
			while(data[offset+(get_str_size++)]){}
			data.position=offset;
			VariableName=data.readUTFBytes(get_str_size);
			offset+=get_str_size;
			
			if(HasText){
			
				get_str_size=0;
				while(data[offset+(get_str_size++)]){}
				data.position=offset;
				InitialText=data.readUTFBytes(get_str_size);
				offset+=get_str_size;
			}
			return offset;
		}
		public function toData(_toDataOptions:zero_swf_ToDataOptions):ByteArray{
			var data:ByteArray=new ByteArray();
			data[0]=id;
			data[1]=id>>8;
			data.position=2;
			data.writeBytes(Bounds.toData(_toDataOptions));
			var offset:int=data.length;
			var flags:int=0;
			flags|=HasText<<7;							//10000000
			flags|=WordWrap<<6;							//01000000
			flags|=Multiline<<5;						//00100000
			flags|=Password<<4;							//00010000
			flags|=ReadOnly<<3;							//00001000
			flags|=HasTextColor<<2;						//00000100
			flags|=HasMaxLength<<1;						//00000010
			flags|=HasFont;								//00000001
			data[offset]=flags;
			
			flags=0;
			flags|=HasFontClass<<7;						//10000000
			flags|=AutoSize<<6;							//01000000
			flags|=HasLayout<<5;						//00100000
			flags|=NoSelect<<4;							//00010000
			flags|=Border<<3;							//00001000
			flags|=WasStatic<<2;						//00000100
			flags|=HTML<<1;								//00000010
			flags|=UseOutlines;							//00000001
			data[offset+1]=flags;
			
			offset+=2;
			if(HasFont){
				data[offset++]=FontID;
				data[offset++]=FontID>>8;
			}
			
			if(HasFontClass){
				data.position=offset;
				data.writeUTFBytes(FontClass+"\x00");
				offset=data.length;
			}
			
			if(HasFont){
				data[offset++]=FontHeight;
				data[offset++]=FontHeight>>8;
			}
			
			if(HasTextColor){
				data[offset++]=TextColor>>16;
				data[offset++]=TextColor>>8;
				data[offset++]=TextColor;
				data[offset++]=TextColor>>24;
			}
			
			if(HasMaxLength){
				data[offset++]=MaxLength;
				data[offset++]=MaxLength>>8;
			}
			
			if(HasLayout){
				data[offset++]=Align;
			}
			
			if(HasLayout){
				data[offset++]=LeftMargin;
				data[offset++]=LeftMargin>>8;
			}
			
			if(HasLayout){
				data[offset++]=RightMargin;
				data[offset++]=RightMargin>>8;
			}
			
			if(HasLayout){
				data[offset++]=Indent;
				data[offset++]=Indent>>8;
			}
			
			if(HasLayout){
				data[offset++]=Leading;
				data[offset++]=Leading>>8;
			}
			data.position=offset;
			data.writeUTFBytes(VariableName+"\x00");
			offset=data.length;
			if(HasText){
				data.position=offset;
				data.writeUTFBytes(InitialText+"\x00");
				offset=data.length;
			}
			return data;
		}

		////
		CONFIG::USE_XML{
		public function toXML(xmlName:String,_toXMLOptions:zero_swf_ToXMLOptions):XML{
			var xml:XML=<{xmlName} class="DefineEditText"
				id={id}
				HasText={HasText}
				WordWrap={WordWrap}
				Multiline={Multiline}
				Password={Password}
				ReadOnly={ReadOnly}
				HasTextColor={HasTextColor}
				HasMaxLength={HasMaxLength}
				HasFont={HasFont}
				HasFontClass={HasFontClass}
				AutoSize={AutoSize}
				HasLayout={HasLayout}
				NoSelect={NoSelect}
				Border={Border}
				WasStatic={WasStatic}
				HTML={HTML}
				UseOutlines={UseOutlines}
				FontID={FontID}
				FontClass={FontClass}
				FontHeight={FontHeight}
				TextColor={"0x"+BytesAndStr16._16V[(TextColor>>24)&0xff]+BytesAndStr16._16V[(TextColor>>16)&0xff]+BytesAndStr16._16V[(TextColor>>8)&0xff]+BytesAndStr16._16V[TextColor&0xff]}
				MaxLength={MaxLength}
				Align={Align}
				LeftMargin={LeftMargin}
				RightMargin={RightMargin}
				Indent={Indent}
				Leading={Leading}
				VariableName={VariableName}
				InitialText={InitialText}
			/>;
			xml.appendChild(Bounds.toXML("Bounds",_toXMLOptions));
			if(HasFont){
				
			}else{
				delete xml.@FontID;
			}
			if(HasFontClass){
				
			}else{
				delete xml.@FontClass;
			}
			if(HasFont){
				
			}else{
				delete xml.@FontHeight;
			}
			if(HasTextColor){
				
			}else{
				delete xml.@TextColor;
			}
			if(HasMaxLength){
				
			}else{
				delete xml.@MaxLength;
			}
			if(HasLayout){
				
			}else{
				delete xml.@Align;
			}
			if(HasLayout){
				
			}else{
				delete xml.@LeftMargin;
			}
			if(HasLayout){
				
			}else{
				delete xml.@RightMargin;
			}
			if(HasLayout){
				
			}else{
				delete xml.@Indent;
			}
			if(HasLayout){
				
			}else{
				delete xml.@Leading;
			}
			if(HasText){
				
			}else{
				delete xml.@InitialText;
			}
			return xml;
		}
		public function initByXML(xml:XML,_initByXMLOptions:zero_swf_InitByXMLOptions):void{
			id=int(xml.@id.toString());
			Bounds=new RECT();
			Bounds.initByXML(xml.Bounds[0],_initByXMLOptions);
			HasText=int(xml.@HasText.toString());
			WordWrap=int(xml.@WordWrap.toString());
			Multiline=int(xml.@Multiline.toString());
			Password=int(xml.@Password.toString());
			ReadOnly=int(xml.@ReadOnly.toString());
			HasTextColor=int(xml.@HasTextColor.toString());
			HasMaxLength=int(xml.@HasMaxLength.toString());
			HasFont=int(xml.@HasFont.toString());
			HasFontClass=int(xml.@HasFontClass.toString());
			AutoSize=int(xml.@AutoSize.toString());
			HasLayout=int(xml.@HasLayout.toString());
			NoSelect=int(xml.@NoSelect.toString());
			Border=int(xml.@Border.toString());
			WasStatic=int(xml.@WasStatic.toString());
			HTML=int(xml.@HTML.toString());
			UseOutlines=int(xml.@UseOutlines.toString());
			if(HasFont){
				FontID=int(xml.@FontID.toString());
			}
			if(HasFontClass){
				FontClass=xml.@FontClass.toString();
			}
			if(HasFont){
				FontHeight=int(xml.@FontHeight.toString());
			}
			if(HasTextColor){
				TextColor=uint(xml.@TextColor.toString());
			}
			if(HasMaxLength){
				MaxLength=int(xml.@MaxLength.toString());
			}
			if(HasLayout){
				Align=int(xml.@Align.toString());
			}
			if(HasLayout){
				LeftMargin=int(xml.@LeftMargin.toString());
			}
			if(HasLayout){
				RightMargin=int(xml.@RightMargin.toString());
			}
			if(HasLayout){
				Indent=int(xml.@Indent.toString());
			}
			if(HasLayout){
				Leading=int(xml.@Leading.toString());
			}
			VariableName=xml.@VariableName.toString();
			if(HasText){
				InitialText=xml.@InitialText.toString();
			}
		}
		}//end of CONFIG::USE_XML
	}
}
