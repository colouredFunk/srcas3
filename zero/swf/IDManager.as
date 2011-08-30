/***
IDManager
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年8月16日 14:36:13
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.swf{
	
	import zero.swf.records.buttons.*;
	import zero.swf.records.shapes.*;
	import zero.swf.records.texts.*;
	import zero.swf.tagBodys.*;
	
	import zero.utils.disorder;

	public class IDManager{
		public static function disorderIds(swf:SWF):void{
			var arr:Array=new Array();
			product(swf.tagV,arr);
			
			var i:int,id:int,subArr:Array,mark:Array;;
			
			mark=new Array();
			i=-1;
			var idArr:Array=new Array();
			for each(subArr in arr){
				id=subArr[2];
				if(mark[id]){
				}else{
					mark[id]=true;
					i++;
					idArr[i]=i+1;//从 1 开始
				}
			}
			
			disorder(idArr);
			
			mark=new Array();
			i=-1;
			for each(subArr in arr){
				id=subArr[2];
				if(mark[id]){
				}else{
					i++;
					mark[id]=idArr[i];
				}
				//trace("id="+id+",mark["+id+"]="+mark[id]);
				subArr[0][subArr[1]]=mark[id];
			}
		}
		private static function productShapes(Shapes:SHAPEWITHSTYLE,arr:Array):void{
			var FillStyle:FILLSTYLE;
			var LineStyle2:LINESTYLE2;
			for each(FillStyle in Shapes.FillStyleV){
				if(FillStyle.BitmapId){
					if(FillStyle.BitmapId==65535){
						//trace("奇怪的 BitmapId："+FillStyle.BitmapId);
					}else{
						arr.push([FillStyle,"BitmapId",FillStyle.BitmapId]);
					}
				}
			}
			if(Shapes.LineStyle2V){
				for each(LineStyle2 in Shapes.LineStyle2V){
					if(LineStyle2.FillType){
						if(LineStyle2.FillType.BitmapId==65535){
							//trace("奇怪的 BitmapId："+LineStyle2.FillType.BitmapId);
						}else{
							arr.push([LineStyle2.FillType,"BitmapId",LineStyle2.FillType.BitmapId]);
						}
					}
				}
			}
			for each(var ShapeRecord:SHAPERECORD in Shapes.ShapeRecordV){
				if(ShapeRecord.FillStyleV){
					for each(FillStyle in ShapeRecord.FillStyleV){
						if(FillStyle.BitmapId){
							if(FillStyle.BitmapId==65535){
								//trace("奇怪的 BitmapId："+FillStyle.BitmapId);
							}else{
								arr.push([FillStyle,"BitmapId",FillStyle.BitmapId]);
							}
						}
					}
				}
				if(ShapeRecord.LineStyle2V){
					for each(LineStyle2 in ShapeRecord.LineStyle2V){
						if(LineStyle2.FillType){
							if(LineStyle2.FillType.BitmapId==65535){
								//trace("奇怪的 BitmapId："+LineStyle2.FillType.BitmapId);
							}else{
								arr.push([LineStyle2.FillType,"BitmapId",LineStyle2.FillType.BitmapId]);
							}
						}
					}
				}
			}
		}
		private static function product(tagV:Vector.<Tag>,arr:Array):void{
			
			var textRecord:TEXTRECORD;
			
			for each(var tag:Tag in tagV){
				switch(tag.type){
					//case TagTypes.End://0x00
					//case TagTypes.ShowFrame://0x01
					case TagTypes.DefineShape://0x02
						var defineShape:DefineShape=tag.getBody(DefineShape,null);
						arr.push([defineShape,"id",defineShape.id]);
						productShapes(defineShape.Shapes,arr);
					break;
					////0x03
					case TagTypes.PlaceObject://0x04
						var placeObject:PlaceObject=tag.getBody(PlaceObject,null);
						arr.push([placeObject,"CharacterId",placeObject.CharacterId]);
					break;
					case TagTypes.RemoveObject://0x05
						var removeObject:RemoveObject=tag.getBody(RemoveObject,null);
						arr.push([removeObject,"CharacterId",removeObject.CharacterId]);
					break;
					case TagTypes.DefineBits://0x06
						arr.push([tag,"UI16Id",tag.UI16Id]);
					break;
					case TagTypes.DefineButton://0x07
						trace("不太支持 DefineButton");
						arr.push([tag,"UI16Id",tag.UI16Id]);
					break;
					//case TagTypes.JPEGTables://0x08
					//case TagTypes.SetBackgroundColor://0x09
					case TagTypes.DefineFont://0x0a
						arr.push([tag,"UI16Id",tag.UI16Id]);
					break;
					case TagTypes.DefineText://0x0b
						var defineText:DefineText=tag.getBody(DefineText,null);
						arr.push([defineText,"id",defineText.id]);
						for each(textRecord in defineText.TextRecordV){
							arr.push([textRecord,"FontID",textRecord.FontID]);
						}
					break;
					//case TagTypes.DoAction://0x0c
					case TagTypes.DefineFontInfo://0x0d
						var defineFontInfo:DefineFontInfo=tag.getBody(DefineFontInfo,null);
						arr.push([defineFontInfo,"FontID",defineFontInfo.FontID]);
					break;
					case TagTypes.DefineSound://0x0e
						arr.push([tag,"UI16Id",tag.UI16Id]);
					break;
					case TagTypes.StartSound://0x0f
						var startSound:StartSound=tag.getBody(StartSound,null);
						arr.push([startSound,"SoundId",startSound.SoundId]);
					break;
					////0x10
					case TagTypes.DefineButtonSound://0x11
						var defineButtonSound:DefineButtonSound=tag.getBody(DefineButtonSound,null);
						arr.push([defineButtonSound,"ButtonId",defineButtonSound.ButtonId]);
						if(defineButtonSound.ButtonSoundChar0>0){
							arr.push([defineButtonSound,"ButtonSoundChar0",defineButtonSound.ButtonSoundChar0]);
						}
						if(defineButtonSound.ButtonSoundChar1>0){
							arr.push([defineButtonSound,"ButtonSoundChar1",defineButtonSound.ButtonSoundChar1]);
						}
						if(defineButtonSound.ButtonSoundChar2>0){
							arr.push([defineButtonSound,"ButtonSoundChar2",defineButtonSound.ButtonSoundChar2]);
						}
						if(defineButtonSound.ButtonSoundChar3>0){
							arr.push([defineButtonSound,"ButtonSoundChar3",defineButtonSound.ButtonSoundChar3]);
						}
					break;
					//case TagTypes.SoundStreamHead://0x12
					//case TagTypes.SoundStreamBlock://0x13
					case TagTypes.DefineBitsLossless://0x14
						arr.push([tag,"UI16Id",tag.UI16Id]);
					break;
					case TagTypes.DefineBitsJPEG2://0x15
						arr.push([tag,"UI16Id",tag.UI16Id]);
					break;
					case TagTypes.DefineShape2://0x16
						var defineShape2:DefineShape2=tag.getBody(DefineShape2,null);
						arr.push([defineShape2,"id",defineShape2.id]);
						productShapes(defineShape2.Shapes,arr);
					break;
					case TagTypes.DefineButtonCxform://0x17
						var defineButtonCxform:DefineButtonCxform=tag.getBody(DefineButtonCxform,null);
						arr.push([defineButtonCxform,"ButtonId",defineButtonCxform.ButtonId]);
					break;
					//case TagTypes.Protect://0x18
					////0x19
					case TagTypes.PlaceObject2://0x1a
						var placeObject2:PlaceObject2=tag.getBody(PlaceObject2,null);
						if(placeObject2.CharacterId>0){
							arr.push([placeObject2,"CharacterId",placeObject2.CharacterId]);
						}
					break;
					////0x1b
					//case TagTypes.RemoveObject2://0x1c
					////0x1d
					////0x1e
					////0x1f
					case TagTypes.DefineShape3://0x20
						var defineShape3:DefineShape3=tag.getBody(DefineShape3,null);
						arr.push([defineShape3,"id",defineShape3.id]);
						productShapes(defineShape3.Shapes,arr);
					break;
					case TagTypes.DefineText2://0x21
						var defineText2:DefineText2=tag.getBody(DefineText2,null);
						arr.push([defineText2,"id",defineText2.id]);
						for each(textRecord in defineText2.TextRecordV){
							arr.push([textRecord,"FontID",textRecord.FontID]);
						}
					break;
					case TagTypes.DefineButton2://0x22
						var defineButton2:DefineButton2=tag.getBody(DefineButton2,null);
						arr.push([defineButton2,"id",defineButton2.id]);
						for each(var Character:BUTTONRECORD in defineButton2.CharacterV){
							Character.CharacterID
						}
					break;
					//case TagTypes.DefineBitsJPEG3://0x23
					//case TagTypes.DefineBitsLossless2://0x24
					//case TagTypes.DefineEditText://0x25
					////0x26
					//case TagTypes.DefineSprite://0x27
					////0x28
					//case TagTypes.ProductInfo://0x29
					////0x2a
					//case TagTypes.FrameLabel_://0x2b
					////0x2c
					//case TagTypes.SoundStreamHead2://0x2d
					//case TagTypes.DefineMorphShape://0x2e
					////0x2f
					//case TagTypes.DefineFont2://0x30
					////0x31
					////0x32
					////0x33
					////0x34
					////0x35
					////0x36
					////0x37
					//case TagTypes.ExportAssets://0x38
					//case TagTypes.ImportAssets://0x39
					//case TagTypes.EnableDebugger://0x3a
					//case TagTypes.DoInitAction://0x3b
					//case TagTypes.DefineVideoStream://0x3c
					//case TagTypes.VideoFrame://0x3d
					//case TagTypes.DefineFontInfo2://0x3e
					//case TagTypes.DebugID://0x3f
					//case TagTypes.EnableDebugger2://0x40
					//case TagTypes.ScriptLimits://0x41
					//case TagTypes.SetTabIndex://0x42
					////0x43
					////0x44
					//case TagTypes.FileAttributes://0x45
					//case TagTypes.PlaceObject3://0x46
					//case TagTypes.ImportAssets2://0x47
					//case TagTypes.DoABCWithoutFlagsAndName://0x48
					//case TagTypes.DefineFontAlignZones://0x49
					//case TagTypes.CSMTextSettings://0x4a
					//case TagTypes.DefineFont3://0x4b
					//case TagTypes.SymbolClass://0x4c
					//case TagTypes.Metadata://0x4d
					//case TagTypes.DefineScalingGrid://0x4e
					////0x4f
					////0x50
					////0x51
					//case TagTypes.DoABC://0x52
					//case TagTypes.DefineShape4://0x53
					//case TagTypes.DefineMorphShape2://0x54
					////0x55
					//case TagTypes.DefineSceneAndFrameLabelData://0x56
					//case TagTypes.DefineBinaryData://0x57
					//case TagTypes.DefineFontName://0x58
					//case TagTypes.StartSound2://0x59
					//case TagTypes.DefineBitsJPEG4://0x5a
					//case TagTypes.DefineFont4://0x5b
					////0x5c
					////0x5d
					////0x5e
					////0x5f
					////0x60
					////0x61
					////0x62
					////0x63
					////0x64
					////0x65
					////0x66
					////0x67
					////0x68
					////0x69
					////0x6a
					////0x6b
					////0x6c
					////0x6d
					////0x6e
					////0x6f
					////0x70
					////0x71
					////0x72
					////0x73
					////0x74
					////0x75
					////0x76
					////0x77
					////0x78
					////0x79
					////0x7a
					////0x7b
					////0x7c
					////0x7d
					////0x7e
					////0x7f
					////0x80
					////0x81
					////0x82
					////0x83
					////0x84
					////0x85
					////0x86
					////0x87
					////0x88
					////0x89
					////0x8a
					////0x8b
					////0x8c
					////0x8d
					////0x8e
					////0x8f
					////0x90
					////0x91
					////0x92
					////0x93
					////0x94
					////0x95
					////0x96
					////0x97
					////0x98
					////0x99
					////0x9a
					////0x9b
					////0x9c
					////0x9d
					////0x9e
					////0x9f
					////0xa0
					////0xa1
					////0xa2
					////0xa3
					////0xa4
					////0xa5
					////0xa6
					////0xa7
					////0xa8
					////0xa9
					////0xaa
					////0xab
					////0xac
					////0xad
					////0xae
					////0xaf
					////0xb0
					////0xb1
					////0xb2
					////0xb3
					////0xb4
					////0xb5
					////0xb6
					////0xb7
					////0xb8
					////0xb9
					////0xba
					////0xbb
					////0xbc
					////0xbd
					////0xbe
					////0xbf
					////0xc0
					////0xc1
					////0xc2
					////0xc3
					////0xc4
					////0xc5
					////0xc6
					////0xc7
					////0xc8
					////0xc9
					////0xca
					////0xcb
					////0xcc
					////0xcd
					////0xce
					////0xcf
					////0xd0
					////0xd1
					////0xd2
					////0xd3
					////0xd4
					////0xd5
					////0xd6
					////0xd7
					////0xd8
					////0xd9
					////0xda
					////0xdb
					////0xdc
					////0xdd
					////0xde
					////0xdf
					////0xe0
					////0xe1
					////0xe2
					////0xe3
					////0xe4
					////0xe5
					////0xe6
					////0xe7
					////0xe8
					////0xe9
					////0xea
					////0xeb
					////0xec
					////0xed
					////0xee
					////0xef
					////0xf0
					////0xf1
					////0xf2
					////0xf3
					////0xf4
					////0xf5
					////0xf6
					////0xf7
					////0xf8
					////0xf9
					////0xfa
					////0xfb
					////0xfc
					////0xfd
					////0xfe
					////0xff
					/*
					case TagTypes.DefineSprite://0x27
						arr.push([tag,"UI16Id",tag.UI16Id]);
						product(tag.getBody(DefineSprite,null).tagV,arr);
					break;
					case TagTypes.DefineShape://0x02
						arr.push([tag,"UI16Id",tag.UI16Id]);
						productShapes(tag.getBody(DefineShape,null).Shapes,arr);
					break;
					case TagTypes.DefineShape2://0x16
						arr.push([tag,"UI16Id",tag.UI16Id]);
						productShapes(tag.getBody(DefineShape2,null).Shapes,arr);
					break;
					case TagTypes.DefineShape3://0x20
						arr.push([tag,"UI16Id",tag.UI16Id]);
						productShapes(tag.getBody(DefineShape3,null).Shapes,arr);
					break;
					case TagTypes.DefineShape4://0x53
						arr.push([tag,"UI16Id",tag.UI16Id]);
						productShapes(tag.getBody(DefineShape4,null).Shapes,arr);
					break;
					case TagTypes.PlaceObject://0x04
						var placeObject:PlaceObject=tag.getBody(PlaceObject,null);
						arr.push([placeObject,"CharacterId",placeObject.CharacterId]);
					break;
					case TagTypes.PlaceObject2://0x1a
						var placeObject2:PlaceObject2=tag.getBody(PlaceObject2,null);
						if(placeObject2.CharacterId>0){
							arr.push([placeObject2,"CharacterId",placeObject2.CharacterId]);
						}
					break;
					case TagTypes.PlaceObject3://0x46
						var placeObject3:PlaceObject3=tag.getBody(PlaceObject3,null);
						if(placeObject3.CharacterId>0){
							arr.push([placeObject3,"CharacterId",placeObject3.CharacterId]);
						}
					break;
					case TagTypes.RemoveObject://0x05
						var removeObject:RemoveObject=tag.getBody(RemoveObject,null);
						arr.push([removeObject,"CharacterId",removeObject.CharacterId]);
					break;
					case TagTypes.DefineBits://0x06
					case TagTypes.DefineBitsJPEG2://0x15
					case TagTypes.DefineBitsJPEG3://0x23
					case TagTypes.DefineBitsJPEG4://0x5a
					case TagTypes.DefineBitsLossless://0x14
					case TagTypes.DefineBitsLossless2://0x24
					case TagTypes.DefineFont://0x0a
					case TagTypes.DefineFont2://0x30
					case TagTypes.DefineFont3://0x4b
					case TagTypes.DefineFont4://0x5b
					case TagTypes.DefineFontInfo://0x0d
					case TagTypes.DefineFontInfo2://0x3e
					case TagTypes.DefineFontName://0x58
					case TagTypes.DefineFontAlignZones://0x49
					case TagTypes.CSMTextSettings://0x4a
					case TagTypes.DefineSound://0x0e
					case TagTypes.StartSound://0x0f
					case TagTypes.DefineButtonCxform://0x17
					case TagTypes.DefineText2://0x21
					case TagTypes.DefineButton2://0x22
					case TagTypes.DefineEditText://0x25
					case TagTypes.DefineMorphShape://0x2e
					case TagTypes.StartSound2://0x59
					case TagTypes.DefineBinaryData://0x57
					case TagTypes.DefineMorphShape2://0x54
						arr.push([tag,"UI16Id",tag.UI16Id]);
					break;
					case TagTypes.DefineButton://0x07
						throw new Error("不支持 DefineButton");
					break;
					case TagTypes.DefineText://0x0b
						arr.push([tag,"UI16Id",tag.UI16Id]);
						var defineText:DefineText=tag.getBody(DefineText,null);
						for each(var textRecord:TEXTRECORD in defineText.TextRecordV){
							arr.push([textRecord,"FontID",textRecord.FontID]);
						}
					break;
					case TagTypes.DefineButtonSound://0x11
						arr.push([tag,"UI16Id",tag.UI16Id]);
						var defineButtonSound:DefineButtonSound=tag.getBody(DefineButtonSound,null);
						if(defineButtonSound.ButtonSoundChar0>0){
							arr.push([defineButtonSound,"ButtonSoundChar0",defineButtonSound.ButtonSoundChar0]);
						}
						if(defineButtonSound.ButtonSoundChar1>0){
							arr.push([defineButtonSound,"ButtonSoundChar1",defineButtonSound.ButtonSoundChar1]);
						}
						if(defineButtonSound.ButtonSoundChar2>0){
							arr.push([defineButtonSound,"ButtonSoundChar2",defineButtonSound.ButtonSoundChar2]);
						}
						if(defineButtonSound.ButtonSoundChar3>0){
							arr.push([defineButtonSound,"ButtonSoundChar3",defineButtonSound.ButtonSoundChar3]);
						}
					break;
					//zase TagTypes.End://0x00
					//case TagTypes.ShowFrame://0x01
					//case TagTypes.JPEGTables://0x08
					//case TagTypes.SetBackgroundColor://0x09
					//case TagTypes.DoAction://0x0c
					//0x10
					//case TagTypes.SoundStreamHead://0x12
					//case TagTypes.SoundStreamBlock://0x13
					//case TagTypes.Protect://0x18
					//0x19
					//0x1b
					//case TagTypes.RemoveObject2://0x1c
					//0x1d
					//0x1e
					//0x1f
					//0x26
					//0x28
					//case TagTypes.ProductInfo://0x29
					//0x2a
					//case TagTypes.FrameLabel_://0x2b
					//0x2c
					//case TagTypes.SoundStreamHead2://0x2d
					//0x2f
					//0x31
					//0x32
					//0x33
					//0x34
					//0x35
					//0x36
					//0x37
					case TagTypes.ExportAssets://0x38
					case TagTypes.ImportAssets://0x39
					//case TagTypes.EnableDebugger://0x3a
					case TagTypes.DoInitAction://0x3b
					case TagTypes.DefineVideoStream://0x3c
					case TagTypes.VideoFrame://0x3d
					case TagTypes.DebugID://0x3f
					case TagTypes.EnableDebugger2://0x40
					case TagTypes.ScriptLimits://0x41
					case TagTypes.SetTabIndex://0x42
					//0x43
					//0x44
					case TagTypes.FileAttributes://0x45
					case TagTypes.ImportAssets2://0x47
					//case TagTypes.DoABCWithoutFlagsAndName://0x48
					case TagTypes.SymbolClass://0x4c
					case TagTypes.Metadata://0x4d
					case TagTypes.DefineScalingGrid://0x4e
					//0x4f
					//0x50
					//0x51
					//case TagTypes.DoABC://0x52
					//0x55
					//case TagTypes.DefineSceneAndFrameLabelData://0x56
					break;
					*/
				}
			}
		}
	}
}