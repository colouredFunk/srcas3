/***
IDManager
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年8月16日 14:36:13
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.swf{
	import zero.swf.records.shapes.*;
	import zero.swf.records.texts.TEXTRECORD;
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
			for each(var tag:Tag in tagV){
				switch(tag.type){
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
					//zase TagTypes.End://0x00
					//case TagTypes.ShowFrame://0x01
					//case TagTypes.JPEGTables://0x08
					//case TagTypes.SetBackgroundColor://0x09
					case TagTypes.DoAction://0x0c
					case TagTypes.DefineSound://0x0e
					case TagTypes.StartSound://0x0f
					//0x10
					case TagTypes.DefineButtonSound://0x11
					case TagTypes.SoundStreamHead://0x12
					case TagTypes.SoundStreamBlock://0x13
					case TagTypes.DefineButtonCxform://0x17
					case TagTypes.Protect://0x18
					//0x19
					//0x1b
					case TagTypes.RemoveObject2://0x1c
					//0x1d
					//0x1e
					//0x1f
					case TagTypes.DefineText2://0x21
					case TagTypes.DefineButton2://0x22
					case TagTypes.DefineEditText://0x25
					//0x26
					//0x28
					case TagTypes.ProductInfo://0x29
					//0x2a
					case TagTypes.FrameLabel_://0x2b
					//0x2c
					case TagTypes.SoundStreamHead2://0x2d
					case TagTypes.DefineMorphShape://0x2e
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
					case TagTypes.EnableDebugger://0x3a
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
					case TagTypes.DoABCWithoutFlagsAndName://0x48
					case TagTypes.SymbolClass://0x4c
					case TagTypes.Metadata://0x4d
					case TagTypes.DefineScalingGrid://0x4e
					//0x4f
					//0x50
					//0x51
					case TagTypes.DoABC://0x52
					case TagTypes.DefineMorphShape2://0x54
					//0x55
					case TagTypes.DefineSceneAndFrameLabelData://0x56
					case TagTypes.DefineBinaryData://0x57
					case TagTypes.StartSound2://0x59
					break;
				}
			}
		}
	}
}