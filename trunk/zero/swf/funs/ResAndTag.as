/***
ResAndTag 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年11月3日 21:13:25
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf.funs{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.Rectangle;
	import flash.utils.*;
	
	import mx.graphics.codec.PNGEncoder;
	
	import zero.FileTypes;
	import zero.Outputer;
	import zero.swf.DefineObjs;
	import zero.swf.SWF2;
	import zero.swf.Tag;
	import zero.swf.TagType;
	import zero.swf.records.BUTTONRECORD;
	import zero.swf.records.BUTTONRECORD_within_DefineButton;
	import zero.swf.records.FILLSTYLE;
	import zero.swf.records.SHAPEWITHSTYLE;
	import zero.swf.records.TEXTRECORD;
	import zero.swf.records.lineStyles.BaseLineStyle;
	import zero.swf.records.lineStyles.LINESTYLE2;
	import zero.swf.records.shapeRecords.SHAPERECORD;
	import zero.swf.records.shapeRecords.STYLECHANGERECORD;
	import zero.swf.tagBodys.DefineBits;
	import zero.swf.tagBodys.DefineBitsJPEG2;
	import zero.swf.tagBodys.DefineBitsJPEG3;
	import zero.swf.tagBodys.DefineBitsJPEG4;
	import zero.swf.tagBodys.DefineButton;
	import zero.swf.tagBodys.DefineButton2;
	import zero.swf.tagBodys.DefineShape;
	import zero.swf.tagBodys.DefineShape2;
	import zero.swf.tagBodys.DefineShape3;
	import zero.swf.tagBodys.DefineShape4;
	import zero.swf.tagBodys.DefineSprite;
	import zero.swf.tagBodys.DefineText;
	import zero.swf.tagBodys.PlaceObject;
	import zero.swf.tagBodys.PlaceObject2;
	import zero.swf.tagBodys.PlaceObject3;
	
	public class ResAndTag{
		public static var tag2ResData_usedPNGEncoder:Boolean;
		//public static var tag2ResData_x:Number;
		//public static var tag2ResData_y:Number;
		public static var tag2ResData_wid:Number;
		public static var tag2ResData_hei:Number;
		
		
		private static var defineTagV:Vector.<Tag>;
		private static var relatedTagArr:Array;
		
		public static function tag2SWFResData(
			tag:Tag,
			_defineTagV:Vector.<Tag>,
			x:Number,y:Number,width:Number,height:Number,
			JPEGTablesData:ByteArray=null
		):ByteArray{
			
			defineTagV=_defineTagV;
			
			relatedTagArr=new Array();
			
			getRelatedTags(tag);
			
			var resSWF:SWF2=new SWF2();
			resSWF.x=x;
			resSWF.y=y;
			resSWF.width=width;
			resSWF.height=height;
			
			for each(var relatedTag:Tag in relatedTagArr){
				if(relatedTag){
					resSWF.tagV.push(relatedTag);
				}
			}
			resSWF.tagV.push(tag);
			resSWF.tagV.push(getPlaceObjectTag(tag.getDefId(),1));
			resSWF.tagV.push(new Tag(TagType.ShowFrame));
			resSWF.tagV.push(new Tag(TagType.End));
			
			if(JPEGTablesData){
				for each(tag in resSWF.tagV){
					if(tag.type==TagType.DefineBits){
						tag=new Tag(TagType.JPEGTables);
						tag.setBodyData(JPEGTablesData);
						resSWF.tagV.unshift(tag);
						break;
					}
				}
			}
			
			return resSWF.toSWFData();
		}
		private static function getRelatedTag(tagId:int):void{
			if(tagId>0){
				if(relatedTagArr[tagId]){
				}else if(tagId<defineTagV.length){
					relatedTagArr[tagId]=defineTagV[tagId];
					getRelatedTags(defineTagV[tagId]);
				}else{
					if(tagId==65535){
						Outputer.output("超出范围的 tagId: "+tagId+", 可能是奇怪的 fillStyle.BitmapId","brown");
					}else{
						Outputer.output("超出范围的 tagId: "+tagId,"brown");
					}
				}
			}
		}
		public static function getRelatedTags(tag:Tag):void{
			switch(tag.type){
				case TagType.DefineShape:
					getImgTagsByShapes((tag.getBody() as DefineShape).Shapes);
				break;
				case TagType.DefineShape2:
					getImgTagsByShapes((tag.getBody() as DefineShape2).Shapes);
				break;
				case TagType.DefineShape3:
					getImgTagsByShapes((tag.getBody() as DefineShape3).Shapes);
				break;
				case TagType.DefineShape4:
					getImgTagsByShapes((tag.getBody() as DefineShape4).Shapes);
				break;
				case TagType.DefineButton:
					//throw new Error("暂不支持导出 DefineButton");
					for each(var buttonRecord_within_DefineButton:BUTTONRECORD_within_DefineButton in (tag.getBody() as DefineButton).CharacterV){
						getRelatedTag(buttonRecord_within_DefineButton.CharacterID);
					}
				break;
				case TagType.DefineButton2:
					for each(var buttonRecord:BUTTONRECORD in (tag.getBody() as DefineButton2).CharacterV){
						getRelatedTag(buttonRecord.CharacterID);
					}
				break;
				case TagType.DefineSprite:
					///*
					for each(var childTag:Tag in (tag.getBody() as DefineSprite).dataAndTags.tagV){
						switch(childTag.type){
							case TagType.PlaceObject:
								getRelatedTag((childTag.getBody() as PlaceObject).CharacterId);
							break;
							case TagType.PlaceObject2:
								getRelatedTag((childTag.getBody() as PlaceObject2).CharacterId);
							break;
							case TagType.PlaceObject3:
								getRelatedTag((childTag.getBody() as PlaceObject3).CharacterId);
							break;
						}
					}
					//*/
				break;
				case TagType.DefineText:
					//Outputer.outputError("暂不太支持 DefineText");
					for each(var TextRecord:TEXTRECORD in (tag.getBody() as DefineText).TextRecordV){
						getRelatedTag(TextRecord.FontID);
					}
				break;
				case TagType.DefineText2:
					Outputer.outputError("暂不太支持 DefineText2");
				break;
				case TagType.DefineEditText:
					Outputer.outputError("暂不太支持 DefineEditText");
				break;
			}
		}
		public static function getImgTagsByShapes(shapes:SHAPEWITHSTYLE):void{
			var fillStyle:FILLSTYLE;
			for each(fillStyle in shapes.fillAndLineStyles.FillStyleV){
				getRelatedTag(fillStyle.BitmapId);
			}
			for each(var lineStyle:BaseLineStyle in shapes.fillAndLineStyles.LineStyleV){
				if(lineStyle is LINESTYLE2){
					var lineStyle2:LINESTYLE2=lineStyle as LINESTYLE2;
					if(lineStyle2.FillType){
						getRelatedTag(lineStyle2.FillType.BitmapId);
					}
				}
			}
			for each(var shapeRecord:SHAPERECORD in shapes.ShapeRecordV){
				if(shapeRecord is STYLECHANGERECORD){
					for each(fillStyle in (shapeRecord as STYLECHANGERECORD).NewStyles){
						getRelatedTag(fillStyle.BitmapId);
					}
				}
			}
		}
		
		public static function tag2ResData(
			resInstance:*,
			tag:Tag,
			_defineTagV:Vector.<Tag>,
			JPEGTablesData:ByteArray=null
		):ByteArray{
			tag2ResData_usedPNGEncoder=false;
			var typeName:String=TagType.typeNameArr[tag.type];
			//trace("typeName="+typeName);
			var resType:String=DefineObjs[typeName];
			//trace("resType="+resType);
			var defId:int=tag.getDefId();
				
			//trace("typeName="+typeName,"resType="+resType);
			switch(resType){
				case DefineObjs.SWF:
					var rect:Rectangle=resInstance.getBounds(resInstance);
					
					//tag2ResData_x=rect.x;
					//tag2ResData_y=rect.y;
					tag2ResData_wid=rect.width;
					tag2ResData_hei=rect.height;
					
					return tag2SWFResData(tag,_defineTagV,rect.x,rect.y,rect.width,rect.height,JPEGTablesData);
				break;
				case DefineObjs.IMG:
					
					//tag2ResData_x=0;
					//tag2ResData_y=0;
					tag2ResData_wid=resInstance.width;
					tag2ResData_hei=resInstance.height;
					
					switch(tag.type){
						case TagType.DefineBits:
							//jpg
							if(JPEGTablesData){
								var jpgData:ByteArray=(tag.getBody() as DefineBits).JPEGData.toData();
								
								import zero.encoder.SimpleJPG;
								var SOF0EndOffset:int=SimpleJPG.getSOF0EndOffset(jpgData);
								
								if(SOF0EndOffset<0){
									throw new Error("SOF0EndOffset="+SOF0EndOffset);
								}else{
									var resData:ByteArray=new ByteArray();
									resData.writeBytes(jpgData,0,SOF0EndOffset);
									resData.writeBytes(JPEGTablesData);
									resData.writeBytes(jpgData,SOF0EndOffset);
									return resData;
								}
							}else{
								//resourceData=DefineBitsData;
								throw new Error("需要 JPEGTablesData");
							}
						break;
						case TagType.DefineBitsJPEG2:
							//jpg, png, 或gif
							return (tag.getBody() as DefineBitsJPEG2).ImageData.toData();
						break;
						case TagType.DefineBitsJPEG3:
							//jpg, png, 或gif
							var defineBitsJPEG3:DefineBitsJPEG3=tag.getBody() as DefineBitsJPEG3;
							switch(FileTypes.getType(defineBitsJPEG3.ImageData.ownData,null,defineBitsJPEG3.ImageData.dataOffset)){
								case FileTypes.JPG:
									tag2ResData_usedPNGEncoder=true;
									return new PNGEncoder().encode(resInstance);
								break;
								case FileTypes.PNG:
								case FileTypes.GIF:
									return defineBitsJPEG3.ImageData.toData();
								break;
							}
						break;
						case TagType.DefineBitsJPEG4:
							//jpg, png, 或gif
							var defineBitsJPEG4:DefineBitsJPEG4=tag.getBody() as DefineBitsJPEG4;
							switch(FileTypes.getType(defineBitsJPEG4.ImageData.ownData,null,defineBitsJPEG4.ImageData.dataOffset)){
								case FileTypes.JPG:
									tag2ResData_usedPNGEncoder=true;
									return new PNGEncoder().encode(resInstance);
								break;
								case FileTypes.PNG:
								case FileTypes.GIF:
									return defineBitsJPEG4.ImageData.toData();
								break;
							}
						break;
						case TagType.DefineBitsLossless:
						case TagType.DefineBitsLossless2:
							tag2ResData_usedPNGEncoder=true;
							return new PNGEncoder().encode(resInstance);
						break;
						default:
							throw new Error("暂不支持: typeName="+typeName);
						break;
					}
				break;
				default:
					throw new Error("暂不支持: resType="+resType);
				break;
			}
			return null;
		}
		
		public static function getPlaceObjectTag(CharacterId:int,Depth:int):Tag{
			var PlaceObjectTag:Tag=new Tag(TagType.PlaceObject);
			
			var data:ByteArray=new ByteArray();
			data[0]=CharacterId;
			data[1]=CharacterId>>8;
			data[2]=Depth;
			data[3]=Depth>>8;
			data[4]=0x00;
			
			PlaceObjectTag.setBodyData(data);
			
			return PlaceObjectTag;
		}
		
		public static function getJPEGTablesTag(tagV:Vector.<Tag>):Tag{
			for each(var tag:Tag in tagV){
				if(tag.type==TagType.JPEGTables){
					//trace("tag.bodyLength="+tag.bodyLength);
					//if(tag.bodyLength>4){
					return tag;
					//}
					//break;
				}
			}
			return null;
		}
		
		public static function swfResData2Tag(swfData:ByteArray):Tag{
			var resSWF:SWF2=new SWF2();
			resSWF.initBySWFData(swfData);
			var CharacterId:int=-1;
			var defineTagArr:Array=new Array();
			loop:for each(var tag:Tag in resSWF.tagV){
				switch(tag.type){
					case TagType.PlaceObject:
						//最接近第一个 ShowFrame 的 PlaceObject
						CharacterId=(tag.getBody() as PlaceObject).CharacterId;
						break;
					case TagType.PlaceObject2:
						//最接近第一个 ShowFrame 的 PlaceObject2
						CharacterId=(tag.getBody() as PlaceObject2).CharacterId;
					break;
					case TagType.PlaceObject3:
						//最接近第一个 ShowFrame 的 PlaceObject3
						CharacterId=(tag.getBody() as PlaceObject3).CharacterId;
					break;
					case TagType.ShowFrame://第一个 ShowFrame
						break loop;
					break;
					default:
						if(DefineObjs[TagType.typeNameArr[tag.type]]){
							defineTagArr[tag.getDefId()]=tag;
						}
					break;
				}
			}
			
			if(CharacterId>=0){
				tag=defineTagArr[CharacterId];
				if(tag){
					return tag;
				}
			}
			
			throw new Error("找不到 define tag");
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