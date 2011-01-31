/***
AddFWAd 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2011年1月28日 17:41:17
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf.funs{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	
	import riaidea.utils.zip.*;
	
	import zero.*;
	import zero.swf.*;
	import zero.swf.avm1.Op;
	import zero.swf.avm2.*;
	import zero.swf.avm2.advances.*;
	import zero.swf.funs.*;
	import zero.swf.records.MATRIX;
	import zero.swf.tagBodys.*;
	import zero.swf.vmarks.*;
	
	public class AddFWAd{
		public static var swf:SWF2;
		public static var prevLoaderSWF:SWF2;
		public static var gameSWF:SWF2;
		
		private static var ranStr_Shell:String;
		private static var ranStr_siage:String;
		private static var prevLoaderBytesData:BytesData;
		private static var prevLoaderBgBytesData:BytesData;
		private static var gameBytesData:BytesData;
		
		public static var prevLoaderBgData:ByteArray;	
		public static var swfData:ByteArray;	
		public static var zipData:ByteArray;
		public static var swfPath:String;
		
		private static var codeSegss:Object;
		
		public static function removeFWAd_AS2():void{
			var doInitActionTagArr:Array=new Array();
			var FWAd_AS2SpriteID1:int=-1;
			var FWAd_AS2SpriteID2:int=-1;
			var i:int=gameSWF.tagV.length;
			while(--i>=0){
				var tag:Tag=gameSWF.tagV[i];
				switch(tag.type){
					case TagType.DoInitAction:
						doInitActionTagArr[(tag.getBody() as DoInitAction).SpriteID]=tag;
					break;
					case TagType.ExportAssets:
						var exportAssets:ExportAssets=tag.getBody() as ExportAssets;
						if(exportAssets.NameV[0]=="FWAd_AS2"){
							FWAd_AS2SpriteID1=exportAssets.TagV[0];
							gameSWF.tagV.splice(i,1);
						}else if(exportAssets.NameV[0]=="__Packages.FWAd_AS2"){
							FWAd_AS2SpriteID2=exportAssets.TagV[0];
							gameSWF.tagV.splice(i,1);
						}
					break;
				}
			}
			if(FWAd_AS2SpriteID1>0){
				if(doInitActionTagArr[FWAd_AS2SpriteID1]){
					gameSWF.tagV.splice(gameSWF.tagV.indexOf(doInitActionTagArr[FWAd_AS2SpriteID1]),1);
				}
			}
			if(FWAd_AS2SpriteID2>0){
				if(doInitActionTagArr[FWAd_AS2SpriteID2]){
					gameSWF.tagV.splice(gameSWF.tagV.indexOf(doInitActionTagArr[FWAd_AS2SpriteID2]),1);
				}
			}
		}
		
		public static function decodeGameSWF(gameSWFData:ByteArray):void{
			gameSWF=new SWF2();
			
			try{
				gameSWF.initBySWFData(gameSWFData);
			}catch(e:Error){
				gameSWF=null;
				return;
			}
			
			if(gameSWF.isAS3){
			}else{
				removeFWAd_AS2();
			}
		}
		
		
		
		private static function removeTraits_infos(
			clazz:AdvanceClass,
			traits_infoV:Vector.<AdvanceTraits_info>,
			id:int,
			traitsName:String
		):void{
			traits_infoV.splice(id,1);
		}
		
		
		
		public static function encode(
			FWAd_ID:String,
			
			b_addShell:Boolean,
			
			b_addStage:Boolean,
			bgColor:int=-1,
			
			bgWid:int=0,
			bgHei:int=0,
			bgName:String=null
		):Boolean{
			if(b_addShell){
				encode_addShell(FWAd_ID,b_addStage,bgColor);
			}else{
				encode_noAddShell(FWAd_ID,bgWid,bgHei,bgName,bgColor);
			}
			return true;
		}
		private static function encode_noAddShell(
			FWAd_ID:String,
			bgWid:int,
			bgHei:int,
			bgName:String,
			bgColor:int
		):void{
			swf=new SWF2();
			swf.initBySWFData(gameSWF.toSWFData());//- -
			
			if(swf.Version<6){
				/*
				statusTxt.text=
					xmlloader.xml.labels[0].@playerVersionError.toString().split("|")[languageId]
					.replace(/\$\{PlayerVersion\}/g,swf.Version);
				*/
				swf.Version=6;
			}
			
			prevLoaderSWF=new SWF2();
			prevLoaderSWF.initBySWFData(new PrevLoaderSWFData_AS1());
			
			var fwAdAS1Tag:Tag=null;
			var tag:Tag;
			for each(tag in prevLoaderSWF.tagV){
				if(tag.type==TagType.DefineSprite){
					fwAdAS1Tag=tag;
					break;
				}
			}
			if(fwAdAS1Tag){
			}else{
				throw new Error("找不到 fwAdAS1Tag");
			}
			for each(tag in (fwAdAS1Tag.getBody() as DefineSprite).dataAndTags.tagV){
				if(tag.type==TagType.DoAction){
					if(
						ReplaceDoActionConstant.replace(
							tag,
							["${id}","${wid}","${hei}"],
							[FWAd_ID,swf.width.toString(),swf.height.toString()]
						)
					){
						
					}else{
						throw new Error("这只是简单处理一下 DoAction，请不要放太复杂的东西 ^_^");
					}
					break;
				}
			}
			
			var avalibleDefineObjIdV:Vector.<int>=GetAvalibleDefineObjIdV.getAvalibleDefineObjIdV(swf.tagV);
			
			var fwAdAS1Sprite:DefineSprite=fwAdAS1Tag.getBody() as DefineSprite;
			
			var placeObject:PlaceObject=new PlaceObject();
			placeObject.Depth=0x3fff;
			placeObject.Matrix=new MATRIX();
			
			//var placeObject:PlaceObject3=new PlaceObject3();
			//placeObject.Depth=0x3fff;
			//placeObject.PlaceFlagHasCharacter=1;
			
			fwAdAS1Sprite.id=placeObject.CharacterId=avalibleDefineObjIdV.shift();
			
			var placeObjectTag:Tag=new Tag();
			placeObjectTag.setBody(placeObject);
			
			var insertPos:int=getDoActionInsertPos(swf.tagV);
			if(prevLoaderBgData){
				var placeObject2:PlaceObject2=new PlaceObject2();
				placeObject2.PlaceFlagHasCharacter=1;
				placeObject2.Depth=1;
				if(bgWid==swf.width&&bgHei==swf.height){
				}else{
					placeObject2.PlaceFlagHasMatrix=1;
					placeObject2.Matrix=new MATRIX();
					placeObject2.Matrix.TranslateX=(swf.width-bgWid)/2*20
					placeObject2.Matrix.TranslateY=(swf.height-bgHei)/2*20
				}
				var placeBgTag:Tag=new Tag();
				placeBgTag.setBody(placeObject2);
				
				var fileType:String=FileTypes.getType(prevLoaderBgData,bgName);
				switch(fileType){
					case FileTypes.SWF:
						var prevLoaderBgSWF:SWF=new SWF2();
						prevLoaderBgSWF.initBySWFData(prevLoaderBgData);
						
						//MoveIDs.move(
						//	prevLoaderBgSWF,
						//	avalibleDefineObjIdV,
						//	true
						//);
						
						var defineSprite:DefineSprite=new DefineSprite();
						defineSprite.dataAndTags=new DataAndTags();
						defineSprite.id=avalibleDefineObjIdV.shift();
						defineSprite.dataAndTags.tagV=Za7Za8.getUsefulTags(prevLoaderBgSWF.tagV);
						
						var defineSpriteTag:Tag=new Tag();
						defineSpriteTag.setBody(defineSprite);
						swf.tagV.splice(insertPos++,0,defineSpriteTag);
						
						placeObject2.CharacterId=defineSprite.id;
						
						swf.tagV.splice(insertPos++,0,defineSpriteTag);
						
						break;
					case FileTypes.JPG:
					case FileTypes.PNG:
					case FileTypes.GIF:
						var defineBitsJPEG2Tag:Tag=new Tag();
						
						var defineBitsJPEG2:DefineBitsJPEG2=new DefineBitsJPEG2();
						defineBitsJPEG2.id=avalibleDefineObjIdV.shift();
						defineBitsJPEG2.ImageData=new BytesData();
						defineBitsJPEG2.ImageData.initByData(prevLoaderBgData,0,prevLoaderBgData.length);
						defineBitsJPEG2Tag.setBody(defineBitsJPEG2);
						
						var defineShapeTag:Tag=new Tag();
						defineShapeTag.setBody(BitsFillShapeGetter.getBitsFillShape(avalibleDefineObjIdV.shift(),defineBitsJPEG2.id,bgWid,bgHei));
						swf.tagV.splice(insertPos++,0,defineShapeTag);
						
						placeObject2.CharacterId=defineShapeTag.getDefId();
						
						swf.tagV.splice(insertPos++,0,defineBitsJPEG2Tag);
						break;
					default:
						throw new Error("不支持的文件类型："+fileType);
						break;
				}
				
				fwAdAS1Sprite.dataAndTags.tagV.splice(fwAdAS1Sprite.dataAndTags.tagV.length-2,0,placeBgTag);
			}
			
			
			swf.tagV.splice(insertPos++,0,fwAdAS1Tag);
			swf.tagV.splice(insertPos++,0,placeObjectTag);
			
			swf.accessNetworkOnly=true;
			
			if(bgColor>=0){
				swf.setValue("bgColor",bgColor);
			}
			
			swfData=swf.toSWFData();
		}
		private static function getDoActionInsertPos(tagV:Vector.<Tag>):int{
			var i:int=0;
			for each(var tag:Tag in tagV){
				switch(tag.type){
					case TagType.DoAction:
					case TagType.DoInitAction:
					case TagType.ShowFrame:
					case TagType.ExportAssets:
					case TagType.ImportAssets:
					case TagType.ImportAssets2:
						return i;
						break;
				}
				i++;
			}
			throw new Error("找不到 insertPos");
			return -1;
		}
		private static function encode_addShell(
			FWAd_ID:String,
			b_addStage:Boolean,
			bgColor:int
		):void{
			//RandomStrs.initSeed("原创光荣破解可耻！\n破解人家游戏的生孩子没屁眼！\n改人家Logo的生孩子俩屁眼！");
			RandomStrs.initSeed("SWFShellAdderOnline");
			
			ranStr_Shell=RandomStrs.getRan();
			ranStr_siage=RandomStrs.getRan();
			
			getCodeSegss();
			
			swf=new SWF2();
			swf.initBySWFData(new ShellSWFData());
			
			Za7Za8.addPlayerVersionSWF(swf,new PlayerVersionSWFData());
			
			var resInserter:ResInserter=new ResInserter(swf.tagV);
			
			if(prevLoaderBgData){
				prevLoaderBgBytesData=resInserter.insert(prevLoaderBgData,"PrevLoaderBgData",ResInserter.DATA,2);
			}else{
				prevLoaderBgBytesData=null;
			}
			
			if(gameSWF.isAS3){
				//强制添加 stage
				PutInSceneObjs.init(gameSWF);
				putInSceneClassV=new Vector.<AdvanceClass>();
				putInSceneClassMark=new Object();
				Za7Za8.forEachClasses(gameSWF,PutInSceneObjs.classNameMark,getPutInSceneClassCinits);
				if(b_addStage){
					Za7Za8.forEachClasses(gameSWF,PutInSceneObjs.classNameMark,addStage);
				}
			}
			
			gameBytesData=resInserter.insert(gameSWF.toSWFData(),"GameArtworksSWFData",ResInserter.DATA,4);
			
			prevLoaderSWF=new SWF2();
			prevLoaderSWF.initBySWFData(ReplaceStrs.replace(
				new PrevLoaderSWFData(),
				["${id}","${noShowLogo}","${noShowForbidden}"],
				[FWAd_ID,"",""]
			));
			prevLoaderBytesData=resInserter.insert(prevLoaderSWF.toSWFData(),"PrevLoaderSWFData",ResInserter.DATA,1);
			
			resInserter.getTagVAndReset();//把插入的 datas 插入到 swf.tagV 里
			
			Za7Za8.forEachTraits(
				swf,
				["Shell"],
				["_4399_function_ad_id","serviceHold","setHold","willBeRemoved"],
				removeTraits_infos
			);
			
			Za7Za8.clearTraceMarkNames(
				swf,
				"###runFirstInit()###"
			);
			Za7Za8.clearTraceMarkNames(
				swf,
				"###decodeSWFData(将被汇编码替换)###"
			);
			
			DoABCWithoutFlagsAndName.setDecodeABC(AdvanceABC);
			Mixer.mix(
				[swf,prevLoaderSWF],//必须混淆，免的和 gameCodesSWF 里的任何类同名
				["init","setProgress","setComplete","_4399_function_ad_id","serviceHold","setHold"],//几个不能混淆的字符串
				["FWAd_AS3"],
				["Shell","siage"],
				[ranStr_Shell,ranStr_siage]
			);
			DoABCWithoutFlagsAndName.setDecodeABC(null);
			
			//从 gameArtworksSWF 中获取宽高等信息到 swf:
			swf.copyBaseInfo(gameSWF);
			if(bgColor>=0){
				//swf.setValue("bgColor",gameSWF.getValue("bgColor"));
				swf.setValue("bgColor",bgColor);
			}
			//设置一些值
			//swf.type="CWS";
			if(swf.Version<10){
				swf.Version=10;
			}
			swf.isAS3=true;
			swf.accessNetworkOnly=true;
			
			swfData=swf.toSWFData();
		}
		
		private static var putInSceneClassV:Vector.<AdvanceClass>;
		private static var putInSceneClassMark:Object;
		private static function getPutInSceneClassCinits(advanceABC:AdvanceABC,clazzV:Vector.<AdvanceClass>,i:int,className:String):void{
			putInSceneClassV.push(clazzV[i]);
			putInSceneClassMark["~"+className]=clazzV[i];
		}
		
		private static function addStage(advanceABC:AdvanceABC,clazzV:Vector.<AdvanceClass>,i:int,className:String):void{
			//trace("className="+className);
			for each(var traits_info:AdvanceTraits_info in clazzV[i].itraits_infoV){
				if(traits_info.name.name=="stage"){
					return;
				}
			}
			clazzV[i].itraits_infoV.push(codeSegss.OverrideStage.stage.cloneAsMethodTrait());
		}
		
		private static function getCodeSegss():void{
			codeSegss={
				infoMark:new InfoMark()
			}
			var traits_info:AdvanceTraits_info;
			var traits_infoXML:XML;
			var codeSegsSWF:SWF2=new SWF2();
			codeSegsSWF.initBySWFData(
				ReplaceStrs.replace(
					new CodeSegsSWFData(),
					["Shell","siage"],
					[ranStr_Shell,ranStr_siage]
				)
			);
			DoABCWithoutFlagsAndName.setDecodeABC(AdvanceABC);
			codeSegss.OverrideStage=new Object();
			//trace("--------------------"+codeSegsFolder.name);
			for each(var tag:Tag in codeSegsSWF.tagV){
				switch(tag.type){
					case TagType.DoABC:
					case TagType.DoABCWithoutFlagsAndName:
						for each(var clazz:AdvanceClass in ((tag.getBody() as DoABCWithoutFlagsAndName).abc as AdvanceABC).clazzV){
						for each(traits_info in clazz.itraits_infoV){
							//trace(TraitTypes.typeV[traits_info.kind_trait_type]);
							switch(traits_info.kind_trait_type){
								case TraitTypes.Slot:
								case TraitTypes.Const:
									break;
								case TraitTypes.Method:
								case TraitTypes.Getter:
								case TraitTypes.Setter:
									//trace("----------"+traits_info.name.name);
									traits_info.disp_id=0;//否则可能会出错
									codeSegss.OverrideStage[traits_info.name.name]=traits_info;
									break;
								case TraitTypes.Function:
								case TraitTypes.Clazz:
									break;
							}
						}
					}
						break;
				}
			}
			DoABCWithoutFlagsAndName.setDecodeABC(null);
		}
		
		private static function addDataInZip(
			zipArchive:ZipArchive,
			swfName:String,
			wid:int,
			hei:int,
			swfData:ByteArray
		):void{
			if(swfName.toLowerCase().substr(swfName.length-4)==".swf"){
				swfName=swfName.substr(0,swfName.length-4);
			}
			var htmlData:ByteArray=new ByteArray();
			htmlData.writeUTFBytes(
				'<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">\r\n'+
				'<html xmlns="http://www.w3.org/1999/xhtml">\r\n'+
				'<head>\r\n'+
				'<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />\r\n'+
				'<title>'+swfName+'.swf</title>\r\n'+
				'</head>\r\n'+
				'<body>\r\n'+
				'<br />\r\n'+
				'<br />\r\n'+
				'<object id="object_id" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=10,0,0,0"'+
				' width="'+wid+'"'+
				' height="'+hei+'"'+
				'>\r\n'+
				'  <param name="allowScriptAccess" value="always"/>\r\n'+
				'  <param name="movie" value="'+swfName+'.swf" />\r\n'+
				'  <param name="quality" value="high" />\r\n'+
				'  <embed name="embed_name" src="'+swfName+'.swf" quality="high" pluginspage="http://www.adobe.com/shockwave/download/download.cgi?P1_Prod_Version=ShockwaveFlash" type="application/x-shockwave-flash"'+
				' width="'+wid+'"'+
				' height="'+hei+'"'+
				' allowScriptAccess="always"></embed>\r\n'+
				'</object>\r\n'+
				'</body>\r\n'+
				'</html>\r\n'
			);
			
			zipArchive.addFileFromBytes(swfName+".htm",htmlData);
			
			zipArchive.addFileFromBytes(swfName+".swf",swfData);
		}
		public static function getGameZipData(
			swfName:String,
			wid:int,
			hei:int,
			swfData:ByteArray
		):ByteArray{
			var zipArchive:ZipArchive=new ZipArchive();
			
			addDataInZip(zipArchive,swfName,wid,hei,swfData);
			
			return zipArchive.output();
		}
		public static function getGamesZipData(swfNameAndDataArr:Array):ByteArray{
			var zipArchive:ZipArchive=new ZipArchive();
			
			for each(var swfNameAndData:Array in swfNameAndDataArr){
				addDataInZip(zipArchive,swfNameAndData[0],swfNameAndData[1],swfNameAndData[2],swfNameAndData[3]);
			}
			
			return zipArchive.output();
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