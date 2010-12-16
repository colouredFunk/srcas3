/***
MoveIDs 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年12月12日 03:12:01
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf.funs{
	import flash.utils.Dictionary;
	
	import zero.swf.*;
	import zero.swf.records.*;
	import zero.swf.records.fillStyles.*;
	import zero.swf.records.lineStyles.*;
	import zero.swf.records.shapeRecords.*;
	import zero.swf.tagBodys.*;

	public class MoveIDs{
		private static var objAndValIdV:Vector.<Array>;
		private static var idArr:Array;
		public static function move(swf:SWF2,idV:Vector.<int>=null,modifyIdV:Boolean=false):void{
			if(modifyIdV){
			}else if(idV){
				idV=idV.slice();
			}
			
			objAndValIdV=new Vector.<Array>();
			idArr=new Array();
			
			getIdVByTagV(swf.tagV);
			
			var L:int=idArr.length;
			var i:int=1;
			var objAndValId:Array,obj:*;
			if(idV){
				while(i<L){
					if(objAndValIdV[i]){
						idArr[i]=idV.shift();
					}
					i++;
				}
				
				idArr[0]=0;
				
				for each(objAndValId in objAndValIdV){
					obj=objAndValId[0];
					if(obj is Tag){
						(obj as Tag).setDefId(idArr[objAndValId[1]]);
					}else{
						obj[objAndValId[2]]=idArr[objAndValId[1]];
					}
				}
			}else{
				idArr[0]=0;
				var newId:int=0;
				var newOrderArr:Array=new Array();
				for each(objAndValId in objAndValIdV){
					obj=objAndValId[0];
					
					var id:int=idArr[objAndValId[1]];
					if(newOrderArr[id]==undefined){
						newOrderArr[id]=++newId;
					}
					if(obj is Tag){
						(obj as Tag).setDefId(newOrderArr[id]);
					}else{
						obj[objAndValId[2]]=newOrderArr[id];
					}
				}
			}
		}
		private static function getIdVByTagV(tagV:Vector.<Tag>):void{
			var TextRecord:TEXTRECORD,Shapes:SHAPEWITHSTYLE;
			for each(var tag:Tag in tagV){
				if(DefineObjs[TagType.typeNameArr[tag.type]]){
					markDefTag(tag);
				}
				switch(tag.type){
					//case TagType.End:
					//break;
					//case TagType.ShowFrame:
					//break;
					case TagType.DefineShape:						//id,BitmapId
						Shapes=(tag.getBody() as DefineShape).Shapes;
						getObjAndValIdByFillAndLines(Shapes.FillStyleV,Shapes.LineStyleV);
						getObjAndValIdByShapes(Shapes.ShapeRecordV);
					break;
					case TagType.PlaceObject:						//CharacterId
						getObjAndValId(tag.getBody() as PlaceObject,"CharacterId");
					break;
					case TagType.RemoveObject:						//CharacterId
						getObjAndValId(tag.getBody() as RemoveObject,"CharacterId");
					break;
					//case TagType.DefineBits:						//id
					//break;
					case TagType.DefineButton:						//id,CharacterId
						for each(var Character:BUTTONRECORD_within_DefineButton in (tag.getBody() as DefineButton).CharacterV){
							getObjAndValId(Character,"CharacterID");
						}
					break;
					//case TagType.JPEGTables:
					//break;
					//case TagType.SetBackgroundColor:
					//break;
					//case TagType.DefineFont:						//id
						//貌似 SHAPE 里的 SHAPERECORD 可能包含 BitmapId
					//break;
					case TagType.DefineText:						//id,FontId
						for each(TextRecord in (tag.getBody() as DefineText).TextRecordV){
							getObjAndValId(TextRecord,"FontID");
						}
					break;
					//case TagType.DoAction:
					//break;
					case TagType.DefineFontInfo:					//FontId
						getObjAndValId(tag.getBody() as DefineFontInfo,"FontID");
					break;
					//case TagType.DefineSound:						//id
					//break;
					case TagType.StartSound:						//SoundId
						getObjAndValId(tag.getBody() as StartSound,"SoundId");
					break;
					case TagType.DefineButtonSound:					//ButtonId,SoundId
						var defineButtonSound:DefineButtonSound=tag.getBody() as DefineButtonSound;
						getObjAndValId(defineButtonSound,"ButtonId");
						getObjAndValId(defineButtonSound,"ButtonSoundChar0");
						getObjAndValId(defineButtonSound,"ButtonSoundChar1");
						getObjAndValId(defineButtonSound,"ButtonSoundChar2");
						getObjAndValId(defineButtonSound,"ButtonSoundChar3");
					break;
					//case TagType.SoundStreamHead:
					//break;
					//case TagType.SoundStreamBlock:
					//break;
					//case TagType.DefineBitsLossless:				//id
					//break;
					//case TagType.DefineBitsJPEG2:					//id
					//break;
					case TagType.DefineShape2:						//id,BitmapId
						Shapes=(tag.getBody() as DefineShape2).Shapes;
						getObjAndValIdByFillAndLines(Shapes.FillStyleV,Shapes.LineStyleV);
						getObjAndValIdByShapes(Shapes.ShapeRecordV);
					break;
					case TagType.DefineButtonCxform:				//ButtonId
						getObjAndValId(tag.getBody() as DefineButtonCxform,"ButtonId");
					break;
					//case TagType.Protect:
					//break;
					case TagType.PlaceObject2:						//CharacterId
						getObjAndValId(tag.getBody() as PlaceObject2,"CharacterId");
					break;
					//case TagType.RemoveObject2:
					//break;
					case TagType.DefineShape3:						//id,BitmapId
						Shapes=(tag.getBody() as DefineShape3).Shapes;
						getObjAndValIdByFillAndLines(Shapes.FillStyleV,Shapes.LineStyleV);
						getObjAndValIdByShapes(Shapes.ShapeRecordV);
					break;
					case TagType.DefineText2:						//id,FontId
						for each(TextRecord in (tag.getBody() as DefineText2).TextRecordV){
							getObjAndValId(TextRecord,"FontID");
						}
					break;
					case TagType.DefineButton2:						//id,CharacterId
						for each(var Character2:BUTTONRECORD in (tag.getBody() as DefineButton2).CharacterV){
							getObjAndValId(Character2,"CharacterID");
						}
					break;
					//case TagType.DefineBitsJPEG3:					//id
					//break;
					//case TagType.DefineBitsLossless2:				//id
					//break;
					case TagType.DefineEditText:					//id,FontId
						getObjAndValId(tag.getBody() as DefineEditText,"FontID");
					break;
					case TagType.DefineSprite:						//id,tagV
						getIdVByTagV((tag.getBody() as DefineSprite).dataAndTags.tagV);
					break;
					//case TagType.FrameLabel:
					//break;
					//case TagType.SoundStreamHead2:
					//break;
					case TagType.DefineMorphShape:					//id,BitmapId
						var defineMorphShape:DefineMorphShape=tag.getBody() as DefineMorphShape;
						getObjAndValIdByFillAndLines(defineMorphShape.MorphFillStyleV,defineMorphShape.MorphLineStyleV);
						getObjAndValIdByShapes(defineMorphShape.StartEdges.ShapeRecordV);
						getObjAndValIdByShapes(defineMorphShape.EndEdges.ShapeRecordV);
					break;
					//case TagType.DefineFont2:						//id
					//break;
					case TagType.ExportAssets:						//Tag
						getObjAndValIdsByIdV((tag.getBody() as ExportAssets).TagV);
					break;
					case TagType.ImportAssets:						//Tag
						getObjAndValIdsByIdV((tag.getBody() as ImportAssets).TagV);
					break;
					//case TagType.EnableDebugger:
					//break;
					case TagType.DoInitAction:						//SpriteId
						getObjAndValId(tag.getBody() as DoInitAction,"SpriteID");
					break;
					//case TagType.DefineVideoStream:					//id
					//break;
					case TagType.VideoFrame:						//StreamId
						getObjAndValId(tag.getBody() as VideoFrame,"StreamID");
					break;
					case TagType.DefineFontInfo2:					//FontId
						getObjAndValId(tag.getBody() as DefineFontInfo2,"FontID");
					break;
					//case TagType.EnableDebugger2:
					//break;
					//case TagType.ScriptLimits:
					//break;
					//case TagType.SetTabIndex:
					//break;
					//case TagType.FileAttributes:
					//break;
					case TagType.PlaceObject3:						//CharacterId
						getObjAndValId(tag.getBody() as PlaceObject3,"CharacterId");
					break;
					case TagType.ImportAssets2:						//Tag
						getObjAndValIdsByIdV((tag.getBody() as ImportAssets2).TagV);
					break;
					case TagType.DefineFontAlignZones:				//FontId
						getObjAndValId(tag.getBody() as DefineFontAlignZones,"FontID");
					break;
					case TagType.CSMTextSettings:					//TextId
						getObjAndValId(tag.getBody() as CSMTextSettings,"TextID");
					break;
					//case TagType.DefineFont3:						//id
					//break;
					case TagType.SymbolClass:						//Tag
						getObjAndValIdsByIdV((tag.getBody() as SymbolClass).TagV);
					break;
					//case TagType.Metadata:
					//break;
					case TagType.DefineScalingGrid:					//CharacterId
						getObjAndValId(tag.getBody() as DefineScalingGrid,"CharacterId");
					break;
					//case TagType.DoABC:
					//break;
					case TagType.DefineShape4:						//id,BitmapId
						Shapes=(tag.getBody() as DefineShape4).Shapes;
						getObjAndValIdByFillAndLines(Shapes.FillStyleV,Shapes.LineStyleV);
						getObjAndValIdByShapes(Shapes.ShapeRecordV);
					break;
					case TagType.DefineMorphShape2:					//id,BitmapId
						var defineMorphShape2:DefineMorphShape2=tag.getBody() as DefineMorphShape2;
						getObjAndValIdByFillAndLines(defineMorphShape2.MorphFillStyleV,defineMorphShape2.MorphLineStyleV);
						getObjAndValIdByShapes(defineMorphShape2.StartEdges.ShapeRecordV);
						getObjAndValIdByShapes(defineMorphShape2.EndEdges.ShapeRecordV);
					break;
					//case TagType.DefineSceneAndFrameLabelData:
					//break;
					//case TagType.DefineBinaryData:					//id
					//break;
					case TagType.DefineFontName:					//FontId
						getObjAndValId(tag.getBody() as DefineFontName,"FontID");
					break;
					//case TagType.StartSound2:
					//break;
					//case TagType.DefineBitsJPEG4:					//id
					//break;
					//case TagType.DefineFont4:						//id
					//break;
				}
			}
		}
		private static function markDefTag(defTag:Tag):void{
			var id:int=defTag.getDefId();
			objAndValIdV.push([defTag,id]);
			idArr[id]=id;
		}
		private static function getObjAndValId(obj:*,valId:*):void{
			var id:int=obj[valId];
			objAndValIdV.push([obj,id,valId]);
			idArr[id]=id;
		}
		private static function getObjAndValIdsByIdV(idV:Vector.<int>):void{
			var i:int=0;
			for each(var id:int in idV){
				getObjAndValId(idV,i);
				i++;
			}
		}
		private static function getObjAndValIdByFillAndLines(
			FillStyleV:*,
			LineStyleV:*
		):void{
			for each(var fillStyle:* in FillStyleV){
				if(fillStyle.BitmapId==65535){
				}else{
					getObjAndValId(fillStyle,"BitmapId");
				}
			}
			for each(var lineStyle:BaseLineStyle in LineStyleV){
				if(lineStyle is LINESTYLE2){
					var lineStyle2:LINESTYLE2=lineStyle as LINESTYLE2;
					if(lineStyle2.FillType){
						if(lineStyle2.FillType.BitmapId==65535){
						}else{
							getObjAndValId(lineStyle2.FillType,"BitmapId");
						}
					}
				}
			}
		}
		private static function getObjAndValIdByShapes(ShapeRecordV:Vector.<SHAPERECORD>):void{
			for each(var shapeRecord:SHAPERECORD in ShapeRecordV){
				if(shapeRecord is STYLECHANGERECORD){
					for each(var fillStyle:FILLSTYLE in (shapeRecord as STYLECHANGERECORD).FillStyleV){
						if(fillStyle.BitmapId==65535){
						}else{
							getObjAndValId(fillStyle,"BitmapId");
						}
					}
				}
			}
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