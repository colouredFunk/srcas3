/***
FileAttributes
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年08月26日 20:34:25（代码生成器 V2.0.0 F:/airs/program files2/CodesGenerater2/bin-debug/CodesGenerater2.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

//The FileAttributes tag defines characteristics of the SWF file. This tag is required for SWF 8
//and later and must be the first tag in the SWF file. Additionally, the FileAttributes tag can
//optionally be included in all SWF file versions.
//The HasMetadata flag identifies whether the SWF file contains the Metadata tag. Flash Player
//does not care about this bit field or the related tag but it is useful for search engines.
//The UseNetwork flag signifies whether Flash Player should grant the SWF file local or
//network file access if the SWF file is loaded locally. The default behavior is to allow local SWF
//files to interact with local files only, and not with the network. However, by setting the
//UseNetwork flag, the local SWF can forfeit its local file system access in exchange for access to
//the network. Any version of SWF can use the UseNetwork flag to set the file access for locally
//loaded SWF files that are running in Flash Player 8 or later.
//The minimum file format version is SWF 8.

//FileAttributes
//Field 									Type 			Comment
//Header 									RECORDHEADER 	Tag type = 69
//Reserved 									UB[1] 			Must be 0
//UseDirectBlit(see note following table)	UB[1] 			If 1, the SWF file uses hardware acceleration to blit(位块传送) graphics to the screen, where such acceleration is available.
//															If 0, the SWF file will not use hardware accelerated graphics facilities.
//															Minimum file version is 10.
//UseGPU(see note following table)			UB[1] 			If 1, the SWF file uses GPU compositing features when drawing graphics, where such acceleration is available.
//															If 0, the SWF file will not use hardware accelerated graphics facilities.
//															Minimum file version is 10.
//HasMetadata 								UB[1] 			If 1, the SWF file contains the Metadata tag.
//															If 0, the SWF file does not contain the Metadata tag.
//ActionScript3 							UB[1] 			If 1, this SWF uses ActionScript 3.0.
//															If 0, this SWF uses ActionScript 1.0 or 2.0.
//															Minimum file format version is 9.
//Reserved 									UB[2] 			Must be 0
//UseNetwork 								UB[1] 			If 1, this SWF file is given network file access when loaded locally.
//															If 0, this SWF file is given local file access when loaded locally.
//Reserved 									UB[24] 			Must be 0

//NOTE
//The UseDirectBlit and UseGPU flags are relevant only when a SWF file is playing in the
//standalone Flash Player. When a SWF file plays in a web browser plug-in, UseDirectBlit
//is equivalent to specifying a wmode of "direct" in the tags that embed the SWF inside
//the HTML page, while UseGPU is equivalent to a wmode of "gpu".

package zero.swf.tagBodys{
	
	import flash.utils.ByteArray;
	
	public class FileAttributes{
		
		//public var Reserved:int;//10000000
		public var UseDirectBlit:Boolean;//01000000
		public var UseGPU:Boolean;//00100000
		public var HasMetadata:Boolean;//00010000
		public var ActionScript3:Boolean;//00001000
		//public var Reserved:int;//00000110
		public var UseNetwork:Boolean;//00000001
		//public var Reserved:int;//UB[24]
		
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object):int{
			
			var flags:int;
			
			flags=data[offset++];
			//Reserved=flags&0x80;//10000000
			UseDirectBlit=((flags&0x40)?true:false);//01000000
			UseGPU=((flags&0x20)?true:false);//00100000
			HasMetadata=((flags&0x10)?true:false);//00010000
			ActionScript3=((flags&0x08)?true:false);//00001000
			//Reserved=flags&0x06;//00000110
			UseNetwork=((flags&0x01)?true:false);//00000001
			
			//Reserved=data[offset++]|(data[offset++]<<8)|(data[offset++]<<16);
			return offset+3;
			
		}
		public function toData(_toDataOptions:Object):ByteArray{
			
			var flags:int;
			
			var data:ByteArray=new ByteArray();
			
			flags=0;
			//flags|=Reserved;//10000000
			if(UseDirectBlit){
				flags|=0x40;//01000000
			}
			if(UseGPU){
				flags|=0x20;//00100000
			}
			if(HasMetadata){
				flags|=0x10;//00010000
			}
			if(ActionScript3){
				flags|=0x08;//00001000
			}
			//flags|=Reserved;//00000110
			if(UseNetwork){
				flags|=0x01;//00000001
			}
			data[0]=flags;
			
			data[1]=0x00;
			data[2]=0x00;
			data[3]=0x00;
			
			return data;
			
		}
		
		CONFIG::USE_XML{
			public function toXML(xmlName:String,_toXMLOptions:Object):XML{
				
				return <{xmlName} class="zero.swf.tagBodys.FileAttributes"
					UseDirectBlit={UseDirectBlit}
					UseGPU={UseGPU}
					HasMetadata={HasMetadata}
					ActionScript3={ActionScript3}
					UseNetwork={UseNetwork}
				/>;
				
			}
			public function initByXML(xml:XML,_initByXMLOptions:Object):void{
				
				UseDirectBlit=(xml.@UseDirectBlit.toString()=="true");
				UseGPU=(xml.@UseGPU.toString()=="true");
				HasMetadata=(xml.@HasMetadata.toString()=="true");
				ActionScript3=(xml.@ActionScript3.toString()=="true");
				UseNetwork=(xml.@UseNetwork.toString()=="true");
				
			}
		}
	}
}