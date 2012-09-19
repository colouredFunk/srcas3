/***
imgDatas2SWFData 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2011年1月16日 07:32:36
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf.funs{
	
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	
	public function imgDatas2SWFData(imgDataOrImgDataArr:*,classNameOrClassNameArr:*):ByteArray{
		//所有的 jpg，png，gif 原数据将直接编码成 DefineBitsJPEG2 到一个 SWF 里，用于解决本地打开仅访问网络的 SWF 又访问 loader.content 时引起 SecurityError: Error #2148 的问题
		var imgDataV:Vector.<ByteArray>;
		var classNameV:Vector.<String>;
		if(imgDataOrImgDataArr is ByteArray){
			imgDataV=new Vector.<ByteArray>();
			imgDataV[0]=imgDataOrImgDataArr;
		}else{
			imgDataV=Vector.<ByteArray>(imgDataOrImgDataArr);
		}
		if(classNameOrClassNameArr is String){
			classNameV=new Vector.<String>();
			classNameV[0]=classNameOrClassNameArr;
		}else{
			classNameV=Vector.<String>(classNameOrClassNameArr);
		}
		var swfData:ByteArray=new ByteArray();
		
		swfData[0]=0x46;
		swfData[1]=0x57;
		swfData[2]=0x53;
		
		swfData[3]=0x0a;
		
		swfData[4]=0x00;
		swfData[5]=0x00;
		swfData[6]=0x00;
		swfData[7]=0x00;
		
		swfData[8]=0x00;
		
		swfData[9]=0x00;
		swfData[10]=0x20;
		
		swfData[11]=0x01;
		swfData[12]=0x00;
		
		swfData[13]=0x44;
		swfData[14]=0x11;
		swfData[15]=0x08;
		swfData[16]=0x00;
		swfData[17]=0x00;
		swfData[18]=0x00;
		
		var i:int=0;
		var currId:int=1;
		
		for each(var imgData:ByteArray in imgDataV){
			var offset:int=swfData.length;
			
			swfData[offset++]=0xbf;
			swfData[offset++]=0x14;
			
			var tagBodyLengthPos:int=offset;
			swfData[offset++]=0x00;
			swfData[offset++]=0x00;
			swfData[offset++]=0x00;
			swfData[offset++]=0x00;
			
			swfData[offset++]=0x01;
			swfData[offset++]=0x00;
			swfData[offset++]=0x00;
			swfData[offset++]=0x00;
			swfData[offset++]=0x00;
			swfData[offset++]=0x10;
			swfData[offset++]=0x00;
			swfData[offset++]=0x2e;
			swfData[offset++]=0x00;
			swfData[offset++]=0x00;
			swfData[offset++]=0x00;
			swfData[offset++]=0x00;
			swfData[offset++]=0x06;
			swfData[offset++]=0x00;
			
			var classNameData:ByteArray=new ByteArray();
			var className:String=classNameV[i];
			
			//classNameData.writeUTFBytes(className);
			
			//20111208
			//if(className){
			//	for each(var c:String in className.split("")){
			//		if(c.charCodeAt(0)>0xff){
			//			classNameData.writeUTFBytes(c);
			//		}else{
			//			classNameData.writeByte(c.charCodeAt(0));
			//		}
			//	}
			//}
			
			//20120413
			if(className){
				if(className.search(/[\xf0-\xff]/)>-1){
					for each(var c:String in className.split("")){
						if(/[\xf0-\xff]/.test(c)){
							classNameData.writeByte(c.charCodeAt(0));//这么写，个别字符能使 asv 显示不出来
						}else{
							classNameData.writeUTFBytes(c);
						}
					}
				}else{
					classNameData.writeUTFBytes(className);
				}
			}
			
			if(classNameData.length>0x7f){
				throw new Error("暂不支持长度超过 0x7f 的 className: "+className);
				return;
			}
			swfData[offset++]=classNameData.length;
			swfData.position=offset;
			swfData.writeBytes(classNameData);
			
			offset=swfData.length;
			
			swfData[offset++]=0x0d;
			swfData[offset++]=0x66;
			swfData[offset++]=0x6c;
			swfData[offset++]=0x61;
			swfData[offset++]=0x73;
			swfData[offset++]=0x68;
			swfData[offset++]=0x2e;
			swfData[offset++]=0x64;
			swfData[offset++]=0x69;
			swfData[offset++]=0x73;
			swfData[offset++]=0x70;
			swfData[offset++]=0x6c;
			swfData[offset++]=0x61;
			swfData[offset++]=0x79;
			swfData[offset++]=0x0a;
			swfData[offset++]=0x42;
			swfData[offset++]=0x69;
			swfData[offset++]=0x74;
			swfData[offset++]=0x6d;
			swfData[offset++]=0x61;
			swfData[offset++]=0x70;
			swfData[offset++]=0x44;
			swfData[offset++]=0x61;
			swfData[offset++]=0x74;
			swfData[offset++]=0x61;
			swfData[offset++]=0x06;
			swfData[offset++]=0x4f;
			swfData[offset++]=0x62;
			swfData[offset++]=0x6a;
			swfData[offset++]=0x65;
			swfData[offset++]=0x63;
			swfData[offset++]=0x74;
			swfData[offset++]=0x04;
			swfData[offset++]=0x16;
			swfData[offset++]=0x01;
			swfData[offset++]=0x16;
			swfData[offset++]=0x03;
			swfData[offset++]=0x18;
			swfData[offset++]=0x02;
			swfData[offset++]=0x00;
			swfData[offset++]=0x04;
			swfData[offset++]=0x07;
			swfData[offset++]=0x01;
			swfData[offset++]=0x02;
			swfData[offset++]=0x07;
			swfData[offset++]=0x02;
			swfData[offset++]=0x04;
			swfData[offset++]=0x07;
			swfData[offset++]=0x01;
			swfData[offset++]=0x05;
			swfData[offset++]=0x03;
			swfData[offset++]=0x00;
			swfData[offset++]=0x00;
			swfData[offset++]=0x00;
			swfData[offset++]=0x00;
			swfData[offset++]=0x00;
			swfData[offset++]=0x00;
			swfData[offset++]=0x00;
			swfData[offset++]=0x00;
			swfData[offset++]=0x00;
			swfData[offset++]=0x00;
			swfData[offset++]=0x00;
			swfData[offset++]=0x00;
			swfData[offset++]=0x00;
			swfData[offset++]=0x01;
			swfData[offset++]=0x01;
			swfData[offset++]=0x02;
			swfData[offset++]=0x09;
			swfData[offset++]=0x03;
			swfData[offset++]=0x00;
			swfData[offset++]=0x01;
			swfData[offset++]=0x00;
			swfData[offset++]=0x00;
			swfData[offset++]=0x00;
			swfData[offset++]=0x01;
			swfData[offset++]=0x02;
			swfData[offset++]=0x01;
			swfData[offset++]=0x01;
			swfData[offset++]=0x04;
			swfData[offset++]=0x01;
			swfData[offset++]=0x00;
			swfData[offset++]=0x03;
			swfData[offset++]=0x00;
			swfData[offset++]=0x01;
			swfData[offset++]=0x01;
			swfData[offset++]=0x04;
			swfData[offset++]=0x05;
			swfData[offset++]=0x03;
			swfData[offset++]=0xd0;
			swfData[offset++]=0x30;
			swfData[offset++]=0x47;
			swfData[offset++]=0x00;
			swfData[offset++]=0x00;
			swfData[offset++]=0x01;
			swfData[offset++]=0x03;
			swfData[offset++]=0x01;
			swfData[offset++]=0x05;
			swfData[offset++]=0x06;
			swfData[offset++]=0x09;
			swfData[offset++]=0xd0;
			swfData[offset++]=0x30;
			swfData[offset++]=0xd0;
			swfData[offset++]=0x24;
			swfData[offset++]=0x00;
			swfData[offset++]=0x2a;
			swfData[offset++]=0x49;
			swfData[offset++]=0x02;
			swfData[offset++]=0x47;
			swfData[offset++]=0x00;
			swfData[offset++]=0x00;
			swfData[offset++]=0x02;
			swfData[offset++]=0x02;
			swfData[offset++]=0x01;
			swfData[offset++]=0x01;
			swfData[offset++]=0x04;
			swfData[offset++]=0x13;
			swfData[offset++]=0xd0;
			swfData[offset++]=0x30;
			swfData[offset++]=0x65;
			swfData[offset++]=0x00;
			swfData[offset++]=0x60;
			swfData[offset++]=0x03;
			swfData[offset++]=0x30;
			swfData[offset++]=0x60;
			swfData[offset++]=0x02;
			swfData[offset++]=0x30;
			swfData[offset++]=0x60;
			swfData[offset++]=0x02;
			swfData[offset++]=0x58;
			swfData[offset++]=0x00;
			swfData[offset++]=0x1d;
			swfData[offset++]=0x1d;
			swfData[offset++]=0x68;
			swfData[offset++]=0x01;
			swfData[offset++]=0x47;
			swfData[offset++]=0x00;
			swfData[offset++]=0x00;
			
			offset=swfData.length;
			
			var tagBodyLength:int=offset-tagBodyLengthPos-4;
			swfData[tagBodyLengthPos]=tagBodyLength;
			swfData[tagBodyLengthPos+1]=tagBodyLength>>8;
			swfData[tagBodyLengthPos+2]=tagBodyLength>>16;
			swfData[tagBodyLengthPos+3]=tagBodyLength>>24;
				
			swfData[offset++]=0x7f;
			swfData[offset++]=0x05;
			
			tagBodyLengthPos=offset;
			swfData[offset++]=0x00;
			swfData[offset++]=0x00;
			swfData[offset++]=0x00;
			swfData[offset++]=0x00;
			
			swfData[offset++]=currId;
			swfData[offset++]=currId>>8;
			
			swfData.position=offset;
			swfData.writeBytes(imgData);
			
			offset=swfData.length;
			
			tagBodyLength=offset-tagBodyLengthPos-4;
			swfData[tagBodyLengthPos]=tagBodyLength;
			swfData[tagBodyLengthPos+1]=tagBodyLength>>8;
			swfData[tagBodyLengthPos+2]=tagBodyLength>>16;
			swfData[tagBodyLengthPos+3]=tagBodyLength>>24;
			
			i++;
			currId++;
		}
		
		offset=swfData.length;
		
		swfData[offset++]=0x3f;
		swfData[offset++]=0x13;
		
		tagBodyLengthPos=offset;
		swfData[offset++]=0x00;
		swfData[offset++]=0x00;
		swfData[offset++]=0x00;
		swfData[offset++]=0x00;
		
		swfData[offset++]=classNameV.length;
		swfData[offset++]=classNameV.length>>8;
		
		currId=1;
		for each(className in classNameV){
			swfData[offset++]=currId;
			swfData[offset++]=currId>>8;
			
			swfData.position=offset;
			
			//swfData.writeUTFBytes(className+"\x00");
			
			//20111208
			//if(className){
			//	for each(c in className.split("")){
			//		if(c.charCodeAt(0)>0xff){
			//			swfData.writeUTFBytes(c);
			//		}else{
			//			swfData.writeByte(c.charCodeAt(0));
			//		}
			//	}
			//}
			//swfData.writeByte(0x00);
			
			//20120413
			if(className){
				if(className.search(/[\xf0-\xff]/)>-1){
					for each(c in className.split("")){
						if(/[\xf0-\xff]/.test(c)){
							swfData.writeByte(c.charCodeAt(0));//这么写，个别字符能使 asv 显示不出来
						}else{
							swfData.writeUTFBytes(c);
						}
					}
					swfData.writeByte(0x00);
				}else{
					swfData.writeUTFBytes(className+"\x00");
				}
			}else{
				swfData.writeByte(0x00);
			}
			
			
			offset=swfData.length;
			
			currId++;
		}
		
		offset=swfData.length;
		
		tagBodyLength=offset-tagBodyLengthPos-4;
		swfData[tagBodyLengthPos]=tagBodyLength;
		swfData[tagBodyLengthPos+1]=tagBodyLength>>8;
		swfData[tagBodyLengthPos+2]=tagBodyLength>>16;
		swfData[tagBodyLengthPos+3]=tagBodyLength>>24;
		
		swfData[offset++]=0x40;
		swfData[offset++]=0x00;
		swfData[offset++]=0x00;
		swfData[offset++]=0x00;
		
		var swfDataSize:int=swfData.length;
		swfData[4]=swfDataSize;
		swfData[5]=swfDataSize>>8;
		swfData[6]=swfDataSize>>16;
		swfData[7]=swfDataSize>>24;
		
		return swfData;
	}
}

/*
	//imgDatas2SWFData(new ZeroGIFData(),"Bmd");
  <SWF type="FWS" Version="10" FileLength="568" width="0" height="0" FrameRate="32" FrameCount="1">
	<tags count="6">
	  <FileAttributes length="4" value="08 00 00 00"/>
	  <DoABC length="155" value="01 00 00 00 00 10 00 2e 00 00 00 00 06 00 03 42 6d 64 0d 66 6c 61 73 68 2e 64 69 73 70 6c 61 79 0a 42 69 74 6d 61 70 44 61 74 61 06 4f 62 6a 65 63 74 04 16 01 16 03 18 02 00 04 07 01 02 07 02 04 07 01 05 03 00 00 00 00 00 00 00 00 00 00 00 00 00 01 01 02 09 03 00 01 00 00 00 01 02 01 01 04 01 00 03 00 01 01 04 05 03 d0 30 47 00 00 01 03 01 05 06 09 d0 30 d0 24 00 2a 49 02 47 00 00 02 02 01 01 04 13 d0 30 65 00 60 03 30 60 02 30 60 02 58 00 1d 1d 68 01 47 00 00"/>
	  <DefineBitsJPEG2 length="364" value="01 00 47 49 46 38 39 61 28 00 28 00 a2 00 00 00 00 00 ff ff ff cc cc cc 99 99 99 66 66 66 33 33 33 00 00 00 00 00 00 2c 00 00 00 00 28 00 28 00 00 03 ff 18 21 a2 fe 30 ca e9 80 2d 83 b1 51 0a a0 e0 64 8d e4 38 84 e8 e3 95 65 93 a6 1e 11 b0 e3 0b 03 2e 6d b9 f6 e4 09 a7 81 ce 42 38 f5 20 bf dd b0 54 20 30 7a 3f cf 4c 57 84 0c 08 80 2a 4a 5a 68 b0 ba 21 c1 2f b4 c2 4d 47 bc 07 a1 68 54 08 00 05 d0 45 81 ad 49 76 6f b3 03 3b 11 c6 15 24 32 11 65 24 48 7f 48 6d 84 82 10 54 8c 87 22 81 77 34 8b 15 69 56 2c 12 75 25 6d 0e 6f 14 84 3b 11 79 24 8f 0f 59 90 25 94 0e a0 14 42 12 a3 25 7d 6b 9c 77 b4 0b 3a 46 04 1d 47 4d 83 43 42 85 36 70 be 68 a0 24 96 74 60 7b 7a 2a 23 18 01 c6 a1 8c ce 0a bb 12 2b 6d 9a 2d d3 38 a3 a5 cd a7 d5 34 b4 26 80 c3 9f 68 40 5f 96 2b 82 16 b6 10 da 3a c4 32 79 52 20 b0 b8 e0 32 58 5d 16 28 4b ec 00 03 70 22 46 32 14 f2 74 ac 88 e3 8d 5a 98 80 ce 18 d0 70 73 63 89 13 31 43 16 38 79 38 a9 37 01 c6 25 2b 52 b0 a8 e7 21 da 97 0f 22 3b e6 a3 01 a4 09 4a 7c 81 f2 48 1c f2 a7 43 07 55 ad dc 9c 4a 38 02 e7 91 3d ed 06 5e 40 f6 33 c2 89 3c 3e 8b 82 08 d9 23 01 00 3b"/>
	  <SymbolClass length="8" value="01 00 01 00 42 6d 64 00"/>
	  <ShowFrame frameId="0"/>
	  <End/>
	</tags>
  </SWF>
*/
/*
	//var swfData:ByteArray=imgDatas2SWFData([new ZeroGIFData(),new ZeroGIFData()],["Bmd1","Bmd2"]);
  <SWF type="FWS" Version="10" FileLength="1109" width="0" height="0" FrameRate="32" FrameCount="1">
	<tags count="8">
	  <FileAttributes length="4" value="08 00 00 00"/>
	  <DoABC length="156" value="01 00 00 00 00 10 00 2e 00 00 00 00 06 00 04 42 6d 64 31 0d 66 6c 61 73 68 2e 64 69 73 70 6c 61 79 0a 42 69 74 6d 61 70 44 61 74 61 06 4f 62 6a 65 63 74 04 16 01 16 03 18 02 00 04 07 01 02 07 02 04 07 01 05 03 00 00 00 00 00 00 00 00 00 00 00 00 00 01 01 02 09 03 00 01 00 00 00 01 02 01 01 04 01 00 03 00 01 01 04 05 03 d0 30 47 00 00 01 03 01 05 06 09 d0 30 d0 24 00 2a 49 02 47 00 00 02 02 01 01 04 13 d0 30 65 00 60 03 30 60 02 30 60 02 58 00 1d 1d 68 01 47 00 00"/>
	  <DefineBitsJPEG2 length="364" value="01 00 47 49 46 38 39 61 28 00 28 00 a2 00 00 00 00 00 ff ff ff cc cc cc 99 99 99 66 66 66 33 33 33 00 00 00 00 00 00 2c 00 00 00 00 28 00 28 00 00 03 ff 18 21 a2 fe 30 ca e9 80 2d 83 b1 51 0a a0 e0 64 8d e4 38 84 e8 e3 95 65 93 a6 1e 11 b0 e3 0b 03 2e 6d b9 f6 e4 09 a7 81 ce 42 38 f5 20 bf dd b0 54 20 30 7a 3f cf 4c 57 84 0c 08 80 2a 4a 5a 68 b0 ba 21 c1 2f b4 c2 4d 47 bc 07 a1 68 54 08 00 05 d0 45 81 ad 49 76 6f b3 03 3b 11 c6 15 24 32 11 65 24 48 7f 48 6d 84 82 10 54 8c 87 22 81 77 34 8b 15 69 56 2c 12 75 25 6d 0e 6f 14 84 3b 11 79 24 8f 0f 59 90 25 94 0e a0 14 42 12 a3 25 7d 6b 9c 77 b4 0b 3a 46 04 1d 47 4d 83 43 42 85 36 70 be 68 a0 24 96 74 60 7b 7a 2a 23 18 01 c6 a1 8c ce 0a bb 12 2b 6d 9a 2d d3 38 a3 a5 cd a7 d5 34 b4 26 80 c3 9f 68 40 5f 96 2b 82 16 b6 10 da 3a c4 32 79 52 20 b0 b8 e0 32 58 5d 16 28 4b ec 00 03 70 22 46 32 14 f2 74 ac 88 e3 8d 5a 98 80 ce 18 d0 70 73 63 89 13 31 43 16 38 79 38 a9 37 01 c6 25 2b 52 b0 a8 e7 21 da 97 0f 22 3b e6 a3 01 a4 09 4a 7c 81 f2 48 1c f2 a7 43 07 55 ad dc 9c 4a 38 02 e7 91 3d ed 06 5e 40 f6 33 c2 89 3c 3e 8b 82 08 d9 23 01 00 3b"/>
	  <DoABC length="156" value="01 00 00 00 00 10 00 2e 00 00 00 00 06 00 04 42 6d 64 32 0d 66 6c 61 73 68 2e 64 69 73 70 6c 61 79 0a 42 69 74 6d 61 70 44 61 74 61 06 4f 62 6a 65 63 74 04 16 01 16 03 18 02 00 04 07 01 02 07 02 04 07 01 05 03 00 00 00 00 00 00 00 00 00 00 00 00 00 01 01 02 09 03 00 01 00 00 00 01 02 01 01 04 01 00 03 00 01 01 04 05 03 d0 30 47 00 00 01 03 01 05 06 09 d0 30 d0 24 00 2a 49 02 47 00 00 02 02 01 01 04 13 d0 30 65 00 60 03 30 60 02 30 60 02 58 00 1d 1d 68 01 47 00 00"/>
	  <DefineBitsJPEG2 length="364" value="02 00 47 49 46 38 39 61 28 00 28 00 a2 00 00 00 00 00 ff ff ff cc cc cc 99 99 99 66 66 66 33 33 33 00 00 00 00 00 00 2c 00 00 00 00 28 00 28 00 00 03 ff 18 21 a2 fe 30 ca e9 80 2d 83 b1 51 0a a0 e0 64 8d e4 38 84 e8 e3 95 65 93 a6 1e 11 b0 e3 0b 03 2e 6d b9 f6 e4 09 a7 81 ce 42 38 f5 20 bf dd b0 54 20 30 7a 3f cf 4c 57 84 0c 08 80 2a 4a 5a 68 b0 ba 21 c1 2f b4 c2 4d 47 bc 07 a1 68 54 08 00 05 d0 45 81 ad 49 76 6f b3 03 3b 11 c6 15 24 32 11 65 24 48 7f 48 6d 84 82 10 54 8c 87 22 81 77 34 8b 15 69 56 2c 12 75 25 6d 0e 6f 14 84 3b 11 79 24 8f 0f 59 90 25 94 0e a0 14 42 12 a3 25 7d 6b 9c 77 b4 0b 3a 46 04 1d 47 4d 83 43 42 85 36 70 be 68 a0 24 96 74 60 7b 7a 2a 23 18 01 c6 a1 8c ce 0a bb 12 2b 6d 9a 2d d3 38 a3 a5 cd a7 d5 34 b4 26 80 c3 9f 68 40 5f 96 2b 82 16 b6 10 da 3a c4 32 79 52 20 b0 b8 e0 32 58 5d 16 28 4b ec 00 03 70 22 46 32 14 f2 74 ac 88 e3 8d 5a 98 80 ce 18 d0 70 73 63 89 13 31 43 16 38 79 38 a9 37 01 c6 25 2b 52 b0 a8 e7 21 da 97 0f 22 3b e6 a3 01 a4 09 4a 7c 81 f2 48 1c f2 a7 43 07 55 ad dc 9c 4a 38 02 e7 91 3d ed 06 5e 40 f6 33 c2 89 3c 3e 8b 82 08 d9 23 01 00 3b"/>
	  <SymbolClass length="16" value="02 00 01 00 42 6d 64 31 00 02 00 42 6d 64 32 00"/>
	  <ShowFrame frameId="0"/>
	  <End/>
	</tags>
  </SWF>
*/