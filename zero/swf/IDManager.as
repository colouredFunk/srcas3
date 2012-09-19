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
		public static function getAvalibleDefineObjIdV(...swfs):Vector.<int>{
			
			var mark:Array=new Array();
			for each(var swf:SWF in swfs){
				var arr:Array=new Array();
				product(swf.tagV,arr);
				for each(var subArr:Array in arr){
					mark[subArr[2]]=true;
				}
			}
			
			var avalibleDefineObjIdV:Vector.<int>=new Vector.<int>();
			for(var id:int=1;id<0x7fff;id++){
				if(mark[id]){
				}else{
					avalibleDefineObjIdV.push(id);
				}
			}
			return avalibleDefineObjIdV;
		}
		
		public static function moveIds(cankaoSWF:SWF,swf:SWF):void{
			//移动 swf 的 id 以便插入到 cankaoSWF 中
			moveIdsByAvalibleDefineObjIdV(swf,getAvalibleDefineObjIdV(cankaoSWF));
		}
		public static function moveIdsByAvalibleDefineObjIdV(swf:SWF,avalibleDefineObjIdV:Vector.<int>):void{
			
			var arr:Array=new Array();
			product(swf.tagV,arr);
			
			var mark:Array=new Array();
			var i:int=-1;
			var idArr:Array=new Array();
			for each(var subArr:Array in arr){
				var id:int=subArr[2];
				if(mark[id]){
				}else{
					mark[id]=true;
					i++;
					idArr[i]=avalibleDefineObjIdV.shift();
				}
			}
			
			mark=new Array();
			i=-1;
			for each(subArr in arr){
				id=subArr[2];
				if(id>0){
					if(mark[id]){
					}else{
						i++;
						mark[id]=idArr[i];
					}
					subArr[0][subArr[1]]=mark[id];
				}else{
					throw new Error("subArr="+subArr+",id="+id+",mark["+id+"]="+mark[id]);
				}
			}
		}
		public static function moveIdsToHead(swf:SWF):void{
			var arr:Array=new Array();
			product(swf.tagV,arr);
			
			var mark:Array=new Array();
			var i:int=-1;
			var idArr:Array=new Array();
			for each(var subArr:Array in arr){
				var id:int=subArr[2];
				if(mark[id]){
				}else{
					mark[id]=true;
					i++;
					idArr[i]=i+1;//从 1 开始
				}
			}
			
			mark=new Array();
			i=-1;
			for each(subArr in arr){
				id=subArr[2];
				if(id>0){
					if(mark[id]){
					}else{
						i++;
						mark[id]=idArr[i];
					}
					subArr[0][subArr[1]]=mark[id];
				}else{
					throw new Error("subArr="+subArr+",id="+id+",mark["+id+"]="+mark[id]);
				}
			}
		}
		public static function moveIdsToTail(swf:SWF):void{
			var arr:Array=new Array();
			product(swf.tagV,arr);
			
			var mark:Array=new Array();
			var i:int=-1;
			var idArr:Array=new Array();
			for each(var subArr:Array in arr){
				var id:int=subArr[2];
				if(mark[id]){
				}else{
					mark[id]=true;
					i++;
					idArr[i]=0x7fff-i;//从 0x7fff 开始
				}
			}
			
			mark=new Array();
			i=-1;
			for each(subArr in arr){
				id=subArr[2];
				if(id>0){
					if(mark[id]){
					}else{
						i++;
						mark[id]=idArr[i];
					}
					subArr[0][subArr[1]]=mark[id];
				}else{
					throw new Error("subArr="+subArr+",id="+id+",mark["+id+"]="+mark[id]);
				}
			}
		}
		public static function disorderIds(swf:SWF):void{
			var arr:Array=new Array();
			product(swf.tagV,arr);
			
			var mark:Array=new Array();
			var i:int=-1;
			var idArr:Array=new Array();
			for each(var subArr:Array in arr){
				var id:int=subArr[2];
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
				if(id>0){
					if(mark[id]){
					}else{
						i++;
						mark[id]=idArr[i];
					}
					subArr[0][subArr[1]]=mark[id];
				}else{
					throw new Error("subArr="+subArr+",id="+id+",mark["+id+"]="+mark[id]);
				}
			}
		}
		public static function getIdTagArr(swf:SWF):Array{
			var tagArrArr:Array=new Array();
			_getIdTagArr(swf.tagV,tagArrArr);
			return tagArrArr;
		}
		private static function _getIdTagArr(tagV:Vector.<Tag>,tagArrArr:Array):void{
			for each(var tag:Tag in tagV){
				switch(tag.type){
					//case TagTypes.End://0x00
					//case TagTypes.ShowFrame://0x01
					case TagTypes.DefineShape://0x02
						if(tagArrArr[tag.UI16Id]){
							tagArrArr[tag.UI16Id].push(tag);
						}else{
							tagArrArr[tag.UI16Id]=[tag];
						}
					break;
					////0x03
					case TagTypes.PlaceObject://0x04
						var placeObject:PlaceObject=tag.getBody(PlaceObject,null);
						if(tagArrArr[placeObject.CharacterId]){
							tagArrArr[placeObject.CharacterId].push(tag);
						}else{
							tagArrArr[placeObject.CharacterId]=[tag];
						}
					break;
					case TagTypes.RemoveObject://0x05
						var removeObject:RemoveObject=tag.getBody(RemoveObject,null);
						if(tagArrArr[placeObject.CharacterId]){
							tagArrArr[removeObject.CharacterId].push(tag);
						}else{
							tagArrArr[removeObject.CharacterId]=[tag];
						}
					break;
					case TagTypes.DefineBits://0x06
						if(tagArrArr[tag.UI16Id]){
							tagArrArr[tag.UI16Id].push(tag);
						}else{
							tagArrArr[tag.UI16Id]=[tag];
						}
					break;
					case TagTypes.DefineButton://0x07
						trace("不太支持 DefineButton");
						if(tagArrArr[tag.UI16Id]){
							tagArrArr[tag.UI16Id].push(tag);
						}else{
							tagArrArr[tag.UI16Id]=[tag];
						}
					break;
					//case TagTypes.JPEGTables://0x08
					//case TagTypes.SetBackgroundColor://0x09
					case TagTypes.DefineFont://0x0a
						if(tagArrArr[tag.UI16Id]){
							tagArrArr[tag.UI16Id].push(tag);
						}else{
							tagArrArr[tag.UI16Id]=[tag];
						}
					break;
					case TagTypes.DefineText://0x0b
						if(tagArrArr[tag.UI16Id]){
							tagArrArr[tag.UI16Id].push(tag);
						}else{
							tagArrArr[tag.UI16Id]=[tag];
						}
					break;
					//case TagTypes.DoAction://0x0c
					case TagTypes.DefineFontInfo://0x0d
						var defineFontInfo:DefineFontInfo=tag.getBody(DefineFontInfo,null);
						if(tagArrArr[defineFontInfo.FontID]){
							tagArrArr[defineFontInfo.FontID].push(tag);
						}else{
							tagArrArr[defineFontInfo.FontID]=[tag];
						}
					break;
					case TagTypes.DefineSound://0x0e
						if(tagArrArr[tag.UI16Id]){
							tagArrArr[tag.UI16Id].push(tag);
						}else{
							tagArrArr[tag.UI16Id]=[tag];
						}
					break;
					case TagTypes.StartSound://0x0f
						var startSound:StartSound=tag.getBody(StartSound,null);
						if(tagArrArr[startSound.SoundId]){
							tagArrArr[startSound.SoundId].push(tag);
						}else{
							tagArrArr[startSound.SoundId]=[tag];
						}
					break;
					////0x10
					case TagTypes.DefineButtonSound://0x11
						var defineButtonSound:DefineButtonSound=tag.getBody(DefineButtonSound,null);
						if(tagArrArr[defineButtonSound.ButtonId]){
							tagArrArr[defineButtonSound.ButtonId].push(tag);
						}else{
							tagArrArr[defineButtonSound.ButtonId]=[tag];
						}
					break;
					//case TagTypes.SoundStreamHead://0x12
					//case TagTypes.SoundStreamBlock://0x13
					case TagTypes.DefineBitsLossless://0x14
						if(tagArrArr[tag.UI16Id]){
							tagArrArr[tag.UI16Id].push(tag);
						}else{
							tagArrArr[tag.UI16Id]=[tag];
						}
					break;
					case TagTypes.DefineBitsJPEG2://0x15
						if(tagArrArr[tag.UI16Id]){
							tagArrArr[tag.UI16Id].push(tag);
						}else{
							tagArrArr[tag.UI16Id]=[tag];
						}
					break;
					case TagTypes.DefineShape2://0x16
						if(tagArrArr[tag.UI16Id]){
							tagArrArr[tag.UI16Id].push(tag);
						}else{
							tagArrArr[tag.UI16Id]=[tag];
						}
					break;
					case TagTypes.DefineButtonCxform://0x17
						var defineButtonCxform:DefineButtonCxform=tag.getBody(DefineButtonCxform,null);
						if(tagArrArr[defineButtonCxform.ButtonId]){
							tagArrArr[defineButtonCxform.ButtonId].push(tag);
						}else{
							tagArrArr[defineButtonCxform.ButtonId]=[tag];
						}
					break;
					//case TagTypes.Protect://0x18
					////0x19
					case TagTypes.PlaceObject2://0x1a
						var placeObject2:PlaceObject2=tag.getBody(PlaceObject2,null);
						if(placeObject2.CharacterId>0){
							if(tagArrArr[placeObject2.CharacterId]){
								tagArrArr[placeObject2.CharacterId].push(tag);
							}else{
								tagArrArr[placeObject2.CharacterId]=[tag];
							}
						}
					break;
					////0x1b
					//case TagTypes.RemoveObject2://0x1c
					////0x1d
					////0x1e
					////0x1f
					case TagTypes.DefineShape3://0x20
						if(tagArrArr[tag.UI16Id]){
							tagArrArr[tag.UI16Id].push(tag);
						}else{
							tagArrArr[tag.UI16Id]=[tag];
						}
					break;
					case TagTypes.DefineText2://0x21
						if(tagArrArr[tag.UI16Id]){
							tagArrArr[tag.UI16Id].push(tag);
						}else{
							tagArrArr[tag.UI16Id]=[tag];
						}
					break;
					case TagTypes.DefineButton2://0x22
						if(tagArrArr[tag.UI16Id]){
							tagArrArr[tag.UI16Id].push(tag);
						}else{
							tagArrArr[tag.UI16Id]=[tag];
						}
					break;
					case TagTypes.DefineBitsJPEG3://0x23
						if(tagArrArr[tag.UI16Id]){
							tagArrArr[tag.UI16Id].push(tag);
						}else{
							tagArrArr[tag.UI16Id]=[tag];
						}
					break;
					case TagTypes.DefineBitsLossless2://0x24
						if(tagArrArr[tag.UI16Id]){
							tagArrArr[tag.UI16Id].push(tag);
						}else{
							tagArrArr[tag.UI16Id]=[tag];
						}
					break;
					case TagTypes.DefineEditText://0x25
						if(tagArrArr[tag.UI16Id]){
							tagArrArr[tag.UI16Id].push(tag);
						}else{
							tagArrArr[tag.UI16Id]=[tag];
						}
					break;
					////0x26
					case TagTypes.DefineSprite://0x27
						var defineSprite:DefineSprite=tag.getBody(DefineSprite,null);
						_getIdTagArr(defineSprite.tagV,tagArrArr);
						if(tagArrArr[tag.UI16Id]){
							tagArrArr[tag.UI16Id].push(tag);
						}else{
							tagArrArr[tag.UI16Id]=[tag];
						}
					break;
					////0x28
					//case TagTypes.ProductInfo://0x29
					////0x2a
					//case TagTypes.FrameLabel_://0x2b
					////0x2c
					//case TagTypes.SoundStreamHead2://0x2d
					case TagTypes.DefineMorphShape://0x2e
						if(tagArrArr[tag.UI16Id]){
							tagArrArr[tag.UI16Id].push(tag);
						}else{
							tagArrArr[tag.UI16Id]=[tag];
						}
					break;
					////0x2f
					case TagTypes.DefineFont2://0x30
						if(tagArrArr[tag.UI16Id]){
							tagArrArr[tag.UI16Id].push(tag);
						}else{
							tagArrArr[tag.UI16Id]=[tag];
						}
					break;
					////0x31
					////0x32
					////0x33
					////0x34
					////0x35
					////0x36
					////0x37
					case TagTypes.ExportAssets://0x38
						var exportAssets:ExportAssets=tag.getBody(ExportAssets,null);
						var i:int=-1;
						for each(var Tag_:int in exportAssets.TagV){
							i++;
							if(Tag_>0){
								if(tagArrArr[Tag_]){
									tagArrArr[Tag_].push(tag);
								}else{
									tagArrArr[Tag_]=[tag];
								}
							}
						}
					break;
					case TagTypes.ImportAssets://0x39
						var importAssets:ImportAssets=tag.getBody(ImportAssets,null);
						i=-1;
						for each(Tag_ in importAssets.TagV){
							i++;
							if(Tag_>0){
								if(tagArrArr[Tag_]){
									tagArrArr[Tag_].push(tag);
								}else{
									tagArrArr[Tag_]=[tag];
								}
							}
						}
					break;
					//case TagTypes.EnableDebugger://0x3a
					case TagTypes.DoInitAction://0x3b
						var doInitAction:DoInitAction=tag.getBody(DoInitAction,null);
						if(tagArrArr[doInitAction.SpriteID]){
							tagArrArr[doInitAction.SpriteID].push(tag);
						}else{
							tagArrArr[doInitAction.SpriteID]=[tag];
						}
					break;
					case TagTypes.DefineVideoStream://0x3c
						if(tagArrArr[tag.UI16Id]){
							tagArrArr[tag.UI16Id].push(tag);
						}else{
							tagArrArr[tag.UI16Id]=[tag];
						}
					break;
					case TagTypes.VideoFrame://0x3d
						var videoFrame:VideoFrame=tag.getBody(VideoFrame,null);
						if(tagArrArr[videoFrame.StreamID]){
							tagArrArr[videoFrame.StreamID].push(tag);
						}else{
							tagArrArr[videoFrame.StreamID]=[tag];
						}
					break;
					case TagTypes.DefineFontInfo2://0x3e
						var defineFontInfo2:DefineFontInfo2=tag.getBody(DefineFontInfo2,null);
						if(tagArrArr[defineFontInfo2.FontID]){
							tagArrArr[defineFontInfo2.FontID].push(tag);
						}else{
							tagArrArr[defineFontInfo2.FontID]=[tag];
						}
					break;
					//case TagTypes.DebugID://0x3f
					//case TagTypes.EnableDebugger2://0x40
					//case TagTypes.ScriptLimits://0x41
					//case TagTypes.SetTabIndex://0x42
					////0x43
					////0x44
					//case TagTypes.FileAttributes://0x45
					case TagTypes.PlaceObject3://0x46
						var placeObject3:PlaceObject3=tag.getBody(PlaceObject3,null);
						if(placeObject3.CharacterId>0){
							if(tagArrArr[placeObject3.CharacterId]){
								tagArrArr[placeObject3.CharacterId].push(tag);
							}else{
								tagArrArr[placeObject3.CharacterId]=[tag];
							}
						}
					break;
					case TagTypes.ImportAssets2://0x47
						var importAssets2:ImportAssets2=tag.getBody(ImportAssets2,null);
						i=-1;
						for each(Tag_ in importAssets2.TagV){
							i++;
							if(Tag_>0){
								if(tagArrArr[Tag_]){
									tagArrArr[Tag_].push(tag);
								}else{
									tagArrArr[Tag_]=[tag];
								}
							}
						}
					break;
					//case TagTypes.DoABCWithoutFlagsAndName://0x48
					case TagTypes.DefineFontAlignZones://0x49
						var defineFontAlignZones:DefineFontAlignZones=tag.getBody(DefineFontAlignZones,null);
						if(tagArrArr[defineFontAlignZones.FontID]){
							tagArrArr[defineFontAlignZones.FontID].push(tag);
						}else{
							tagArrArr[defineFontAlignZones.FontID]=[tag];
						}
					break;
					case TagTypes.CSMTextSettings://0x4a
						var csmTextSettings:CSMTextSettings=tag.getBody(CSMTextSettings,null);
						if(tagArrArr[csmTextSettings.TextID]){
							tagArrArr[csmTextSettings.TextID].push(tag);
						}else{
							tagArrArr[csmTextSettings.TextID]=[tag];
						}
					break;
					case TagTypes.DefineFont3://0x4b
						if(tagArrArr[tag.UI16Id]){
							tagArrArr[tag.UI16Id].push(tag);
						}else{
							tagArrArr[tag.UI16Id]=[tag];
						}
					break;
					case TagTypes.SymbolClass://0x4c
						var symbolClass:SymbolClass=tag.getBody(SymbolClass,null);
						i=-1;
						for each(Tag_ in symbolClass.TagV){
							i++;
							//if(Tag_>0){
								if(tagArrArr[Tag_]){
									tagArrArr[Tag_].push(tag);
								}else{
									tagArrArr[Tag_]=[tag];
								}
							//}
						}
					break;
					//case TagTypes.Metadata://0x4d
					case TagTypes.DefineScalingGrid://0x4e
						var defineScalingGrid:DefineScalingGrid=tag.getBody(DefineScalingGrid,null);
						if(tagArrArr[defineScalingGrid.CharacterId]){
							tagArrArr[defineScalingGrid.CharacterId].push(tag);
						}else{
							tagArrArr[defineScalingGrid.CharacterId]=[tag];
						}
					break;
					////0x4f
					////0x50
					////0x51
					//case TagTypes.DoABC://0x52
					case TagTypes.DefineShape4://0x53
						if(tagArrArr[tag.UI16Id]){
							tagArrArr[tag.UI16Id].push(tag);
						}else{
							tagArrArr[tag.UI16Id]=[tag];
						}
					break;
					case TagTypes.DefineMorphShape2://0x54
						if(tagArrArr[tag.UI16Id]){
							tagArrArr[tag.UI16Id].push(tag);
						}else{
							tagArrArr[tag.UI16Id]=[tag];
						}
					break;
					////0x55
					//case TagTypes.DefineSceneAndFrameLabelData://0x56
					case TagTypes.DefineBinaryData://0x57
						if(tagArrArr[tag.UI16Id]){
							tagArrArr[tag.UI16Id].push(tag);
						}else{
							tagArrArr[tag.UI16Id]=[tag];
						}
					break;
					case TagTypes.DefineFontName://0x58
						var defineFontName:DefineFontName=tag.getBody(DefineFontName,null);
						if(tagArrArr[defineFontName.FontID]){
							tagArrArr[defineFontName.FontID].push(tag);
						}else{
							tagArrArr[defineFontName.FontID]=[tag];
						}
					break;
					case TagTypes.DefineBitsJPEG4://0x5a
						if(tagArrArr[tag.UI16Id]){
							tagArrArr[tag.UI16Id].push(tag);
						}else{
							tagArrArr[tag.UI16Id]=[tag];
						}
					break;
					case TagTypes.DefineFont4://0x5b
						if(tagArrArr[tag.UI16Id]){
							tagArrArr[tag.UI16Id].push(tag);
						}else{
							tagArrArr[tag.UI16Id]=[tag];
						}
					break;
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
				}
			}
		}
		private static function productShapes(Shapes:SHAPEWITHSTYLE,arr:Array):void{;
			for each(var FillStyle:FILLSTYLE in Shapes.FillStyleV){
				if(FillStyle.BitmapId){
					if(FillStyle.BitmapId==65535){
						//trace("奇怪的 BitmapId："+FillStyle.BitmapId);
					}else{
						arr.push([FillStyle,"BitmapId",FillStyle.BitmapId]);
					}
				}
			}
			if(Shapes.LineStyle2V){
				for each(var LineStyle2:LINESTYLE2 in Shapes.LineStyle2V){
					if(LineStyle2.FillType){
						if(LineStyle2.FillType.BitmapId){
							if(LineStyle2.FillType.BitmapId==65535){
								//trace("奇怪的 BitmapId："+LineStyle2.FillType.BitmapId);
							}else{
								arr.push([LineStyle2.FillType,"BitmapId",LineStyle2.FillType.BitmapId]);
							}
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
							if(LineStyle2.FillType.BitmapId){
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
		}
		public static function product(tagV:Vector.<Tag>,arr:Array):void{
			
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
						for each(var textRecord:TEXTRECORD in defineText.TextRecordV){
							if(textRecord.FontID>0){
								arr.push([textRecord,"FontID",textRecord.FontID]);
							}
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
							if(textRecord.FontID>0){
								arr.push([textRecord,"FontID",textRecord.FontID]);
							}
						}
					break;
					case TagTypes.DefineButton2://0x22
						var defineButton2:DefineButton2=tag.getBody(DefineButton2,null);
						arr.push([defineButton2,"id",defineButton2.id]);
						for each(var Character:BUTTONRECORD in defineButton2.CharacterV){
							arr.push([Character,"CharacterId",Character.CharacterId]);
						}
					break;
					case TagTypes.DefineBitsJPEG3://0x23
						arr.push([tag,"UI16Id",tag.UI16Id]);
					break;
					case TagTypes.DefineBitsLossless2://0x24
						arr.push([tag,"UI16Id",tag.UI16Id]);
					break;
					case TagTypes.DefineEditText://0x25
						var defineEditText:DefineEditText=tag.getBody(DefineEditText,null);
						arr.push([defineEditText,"id",defineEditText.id]);
						if(defineEditText.FontID>0){
							arr.push([defineEditText,"FontID",defineEditText.FontID]);
						}
					break;
					////0x26
					case TagTypes.DefineSprite://0x27
						var defineSprite:DefineSprite=tag.getBody(DefineSprite,null);
						arr.push([defineSprite,"id",defineSprite.id]);
						product(defineSprite.tagV,arr);
					break;
					////0x28
					//case TagTypes.ProductInfo://0x29
					////0x2a
					//case TagTypes.FrameLabel_://0x2b
					////0x2c
					//case TagTypes.SoundStreamHead2://0x2d
					case TagTypes.DefineMorphShape://0x2e
						var defineMorphShape:DefineMorphShape=tag.getBody(DefineMorphShape,null);
						arr.push([defineMorphShape,"id",defineMorphShape.id]);
						for each(var MorphFillStyle:MORPHFILLSTYLE in defineMorphShape.MorphFillStyleV){
							if(MorphFillStyle.BitmapId){
								if(MorphFillStyle.BitmapId==65535){
									//trace("奇怪的 BitmapId："+MorphFillStyle.BitmapId);
								}else{
									arr.push([MorphFillStyle,"BitmapId",MorphFillStyle.BitmapId]);
								}
							}
						}
					break;
					////0x2f
					case TagTypes.DefineFont2://0x30
						arr.push([tag,"UI16Id",tag.UI16Id]);
					break;
					////0x31
					////0x32
					////0x33
					////0x34
					////0x35
					////0x36
					////0x37
					case TagTypes.ExportAssets://0x38
						var exportAssets:ExportAssets=tag.getBody(ExportAssets,null);
						var i:int=-1;
						for each(var Tag_:int in exportAssets.TagV){
							i++;
							if(Tag_>0){
								arr.push([exportAssets.TagV,i,Tag_]);
							}
						}
					break;
					case TagTypes.ImportAssets://0x39
						var importAssets:ImportAssets=tag.getBody(ImportAssets,null);
						i=-1;
						for each(Tag_ in importAssets.TagV){
							i++;
							if(Tag_>0){
								arr.push([importAssets.TagV,i,Tag_]);
							}
						}
					break;
					//case TagTypes.EnableDebugger://0x3a
					case TagTypes.DoInitAction://0x3b
						var doInitAction:DoInitAction=tag.getBody(DoInitAction,null);
						arr.push([doInitAction,"SpriteID",doInitAction.SpriteID]);
					break;
					case TagTypes.DefineVideoStream://0x3c
						arr.push([tag,"UI16Id",tag.UI16Id]);
					break;
					case TagTypes.VideoFrame://0x3d
						var videoFrame:VideoFrame=tag.getBody(VideoFrame,null);
						arr.push([videoFrame,"StreamID",videoFrame.StreamID]);
					break;
					case TagTypes.DefineFontInfo2://0x3e
						var defineFontInfo2:DefineFontInfo2=tag.getBody(DefineFontInfo2,null);
						arr.push([defineFontInfo2,"FontID",defineFontInfo2.FontID]);
					break;
					//case TagTypes.DebugID://0x3f
					//case TagTypes.EnableDebugger2://0x40
					//case TagTypes.ScriptLimits://0x41
					//case TagTypes.SetTabIndex://0x42
					////0x43
					////0x44
					//case TagTypes.FileAttributes://0x45
					case TagTypes.PlaceObject3://0x46
						var placeObject3:PlaceObject3=tag.getBody(PlaceObject3,null);
						if(placeObject3.CharacterId>0){
							arr.push([placeObject3,"CharacterId",placeObject3.CharacterId]);
						}
					break;
					case TagTypes.ImportAssets2://0x47
						var importAssets2:ImportAssets2=tag.getBody(ImportAssets2,null);
						i=-1;
						for each(Tag_ in importAssets2.TagV){
							i++;
							if(Tag_>0){
								arr.push([importAssets2.TagV,i,Tag_]);
							}
						}
					break;
					//case TagTypes.DoABCWithoutFlagsAndName://0x48
					case TagTypes.DefineFontAlignZones://0x49
						var defineFontAlignZones:DefineFontAlignZones=tag.getBody(DefineFontAlignZones,null);
						arr.push([defineFontAlignZones,"FontID",defineFontAlignZones.FontID]);
					break;
					case TagTypes.CSMTextSettings://0x4a
						var csmTextSettings:CSMTextSettings=tag.getBody(CSMTextSettings,null);
						arr.push([csmTextSettings,"TextID",csmTextSettings.TextID]);
					break;
					case TagTypes.DefineFont3://0x4b
						arr.push([tag,"UI16Id",tag.UI16Id]);
					break;
					case TagTypes.SymbolClass://0x4c
						var symbolClass:SymbolClass=tag.getBody(SymbolClass,null);
						i=-1;
						for each(Tag_ in symbolClass.TagV){
							i++;
							if(Tag_>0){
								arr.push([symbolClass.TagV,i,Tag_]);
							}
						}
					break;
					//case TagTypes.Metadata://0x4d
					case TagTypes.DefineScalingGrid://0x4e
						var defineScalingGrid:DefineScalingGrid=tag.getBody(DefineScalingGrid,null);
						arr.push([defineScalingGrid,"CharacterId",defineScalingGrid.CharacterId]);
					break;
					////0x4f
					////0x50
					////0x51
					//case TagTypes.DoABC://0x52
					case TagTypes.DefineShape4://0x53
						var defineShape4:DefineShape4=tag.getBody(DefineShape4,null);
						arr.push([defineShape4,"id",defineShape4.id]);
						productShapes(defineShape4.Shapes,arr);
					break;
					case TagTypes.DefineMorphShape2://0x54
						var defineMorphShape2:DefineMorphShape2=tag.getBody(DefineMorphShape2,null);
						arr.push([defineMorphShape2,"id",defineMorphShape2.id]);
						for each(MorphFillStyle in defineMorphShape2.MorphFillStyleV){
							if(MorphFillStyle.BitmapId){
								if(MorphFillStyle.BitmapId==65535){
									//trace("奇怪的 BitmapId："+MorphFillStyle.BitmapId);
								}else{
									arr.push([MorphFillStyle,"BitmapId",MorphFillStyle.BitmapId]);
								}
							}
						}
						for each(var MorphLineStyle2:MORPHLINESTYLE2 in defineMorphShape2.MorphLineStyle2V){
							if(MorphLineStyle2.FillType){
								if(MorphLineStyle2.FillType.BitmapId){
									if(MorphLineStyle2.FillType.BitmapId==65535){
										//trace("奇怪的 BitmapId："+MorphLineStyle2.FillType.BitmapId);
									}else{
										arr.push([MorphLineStyle2.FillType,"BitmapId",MorphLineStyle2.FillType.BitmapId]);
									}
								}
							}
						}
					break;
					////0x55
					//case TagTypes.DefineSceneAndFrameLabelData://0x56
					case TagTypes.DefineBinaryData://0x57
						arr.push([tag,"UI16Id",tag.UI16Id]);
					break;
					case TagTypes.DefineFontName://0x58
						var defineFontName:DefineFontName=tag.getBody(DefineFontName,null);
						arr.push([defineFontName,"FontID",defineFontName.FontID]);
					break;
					case TagTypes.DefineBitsJPEG4://0x5a
						arr.push([tag,"UI16Id",tag.UI16Id]);
					break;
					case TagTypes.DefineFont4://0x5b
						arr.push([tag,"UI16Id",tag.UI16Id]);
					break;
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
				}
			}
		}
	}
}