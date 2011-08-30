/***
PlaceObject3
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年08月25日 14:56:36（代码生成器 V2.0.0 F:/airs/program files2/CodesGenerater2/bin-debug/CodesGenerater2.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

//The PlaceObject3 tag extends the functionality of the PlaceObject3 tag. PlaceObject3 adds
//the following new features:
//■ The PlaceFlagHasClassName field indicates that a class name will be specified, indicating
//the type of object to place. Because we no longer use ImportAssets2 in ActionScript 3.0,
//there needed to be some way to place a Timeline object using a class imported from
//another SWF, which does not have a 16-bit character ID in the instantiating SWF.
//Supported in Flash Player 9.0.45.0 and later.

//■ The PlaceFlagHasImage field indicates the creation of native Bitmap objects on the display list.
//PlaceFlagHasImage 字段表示在显示列表上放置(创建)(native 本机)位图对象.

//When PlaceFlagHasClassName and PlaceFlagHasImage are both defined, this indicates a Bitmap class to be loaded from another SWF.
//如果 PlaceFlagHasClassName 和 PlaceFlagHasImage 同时为 1, 表示从另一个SWF加载一个位图类.

//Immediately following the flags is the class name (as above) for the BitmapData class in the loaded SWF.
//A Bitmap object will be placed with the named BitmapData class as it's internal data.

//When PlaceFlagHasCharacter and PlaceFlagHasImage are both defined, this indicates a Bitmap from the current SWF.
//如果 PlaceFlagHasCharacter 和 PlaceFlagHasImage 同时为 1, 表示(从当前SWF加载)一个位图.

//The BitmapData to be used as its internal data will be defined by the following characterID.

//This only occurs when the BitmapData has a class associated with it.
//这个位图必须得有链接类名.

//好像描述的不太正确...
//具体试验:
//打开flash cs4，新建一fla，导入一张位图，设置类名为 "Img"，拖位图到场景上，导出，查看结构，发现生成了 PlaceFlagHasImage=1 的 PlaceObject3，但是 ClassName=null
//所以这里设置类名只是为了在拖放位图元件到场景时能生成 PlaceObject3(如果不设置类名，将生成一个 DefineShape2，然后生成一个 PlaceObject2)

//If there is no class associated with the BitmapData, DefineShape should be used with a Bitmap fill.
//Supported in Flash Player 9.0.45.0 and later.

//■ The PlaceFlagHasCacheAsBitmap field specifies whether Flash Player should internally
//cache a display object as a bitmap. Caching can speed up rendering when the object does
//not change frequently.
//■ A number of different blend modes can be specified as an alternative to normal alpha
//compositing. The following blend modes are supported:
//■ A number of bitmap filters can be applied to the display object. Adding filters implies that
//the display object will be cached as a bitmap. The following bitmap filters are supported:
//Add Layer
//Alpha Lighten
//Darken Overlay
//Difference Multiply
//Erase Screen
//Hardlight Subtract
//Invert
//Bevel Drop shadow
//Blur Glow
//Color matrix Gradient bevel
//Convolution Gradient glow

//Field 							Type 																					Comment
//Header 							RECORDHEADER 																			Tag type = 70
//PlaceFlagHasClipActions 			UB[1] 																					SWF 5 and later: has clip actions (sprite characters only) Otherwise: always 0
//PlaceFlagHasClipDepth 			UB[1] 																					Has clip depth
//PlaceFlagHasName 					UB[1] 																					Has name
//PlaceFlagHasRatio 				UB[1] 																					Has ratio
//PlaceFlagHasColorTransform		UB[1] 																					Has color transform
//PlaceFlagHasMatrix 				UB[1] 																					Has matrix
//PlaceFlagHasCharacter 			UB[1] 																					Places a character
//PlaceFlagMove 					UB[1] 																					Defines a character to be moved

//Reserved 							UB[3] 																					Must be 0
//PlaceFlagHasImage 				UB[1] 																					Has class name or character ID of bitmap to place. If PlaceFlagHasClassName, use ClassName. If PlaceFlagHasCharacter, use CharacterId
//PlaceFlagHasClassName 			UB[1] 																					Has class name of object to place
//PlaceFlagHasCacheAsBitmap			UB[1] 																					Enables bitmap caching
//PlaceFlagHasBlendMode 			UB[1] 																					Has blend mode
//PlaceFlagHasFilterList 			UB[1] 																					Has filter list

//Depth 							UI16 																					Depth of character
//ClassName 						If PlaceFlagHasClassName or (PlaceFlagHasImage and PlaceFlagHasCharacter 描述的不正确), String		Name of the class to place
//CharacterId 						If PlaceFlagHasCharacter, UI16 															ID of character to place
//Matrix 							If PlaceFlagHasMatrix, MATRIX 															Transform matrix data
//ColorTransform 					If PlaceFlagHasColorTransform, CXFORMWITHALPHA											Color transform data
//Ratio 							If PlaceFlagHasRatio, UI16
//Name 								If PlaceFlagHasName, 																	STRING Name of character
//ClipDepth 						If PlaceFlagHasClipDepth, UI16 															Clip depth (see Clipping layers)
//SurfaceFilterList 				If PlaceFlagHasFilterList, FILTERLIST													List of filters on this object
//BlendMode 						If PlaceFlagHasBlendMode, UI8 															0 or 1 = normal
//																															2 = layer
//																															3 = multiply
//																															4 = screen
//																															5 = lighten
//																															6 = darken
//																															7 = difference
//																															8 = add
//																															9 = subtract
//																															10 = invert
//																															11 = alpha
//																															12 = erase
//																															13 = overlay
//																															14 = hardlight
//																															Values 15 to 255 are reserved.
//BitmapCache 						If PlaceFlagHasCacheAsBitmap, UI8														0 = Bitmap cache disabled
//																															1-255 = Bitmap cache enabled
//ClipActions 						If PlaceFlagHasClipActions, CLIPACTIONS	

package zero.swf.tagBodys{
	
	import flash.utils.ByteArray;
	import zero.swf.records.MATRIX;
	import zero.swf.records.CXFORMWITHALPHA;
	import zero.swf.records.Filter;
	import zero.swf.records.BlendModes;
	import zero.swf.BytesData;
	
	public class PlaceObject3{
		
		public var PlaceFlagMove:Boolean;//00000001
		//public var Reserved:int;//11100000
		public var PlaceFlagHasImage:Boolean;//00010000
		public var Depth:int;//UI16
		public var ClassName:String;//STRING
		public var CharacterId:int;//UI16
		public var Matrix:MATRIX;
		public var ColorTransform:CXFORMWITHALPHA;
		public var Ratio:int;//UI16
		public var Name:String;//STRING
		public var ClipDepth:int;//UI16
		public var SurfaceFilterV:Vector.<Filter>;
		public var BlendMode:int;//UI8
		public var BitmapCache:int;//UI8
		public var ClipActions:*;
		
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object):int{
			
			var flags:int;
			var get_str_size:int;
			var i:int;
			
			flags=data[offset++];
			var PlaceFlagHasClipActions:Boolean=((flags&0x80)?true:false);//10000000
			var PlaceFlagHasClipDepth:Boolean=((flags&0x40)?true:false);//01000000
			var PlaceFlagHasName:Boolean=((flags&0x20)?true:false);//00100000
			var PlaceFlagHasRatio:Boolean=((flags&0x10)?true:false);//00010000
			var PlaceFlagHasColorTransform:Boolean=((flags&0x08)?true:false);//00001000
			var PlaceFlagHasMatrix:Boolean=((flags&0x04)?true:false);//00000100
			var PlaceFlagHasCharacter:Boolean=((flags&0x02)?true:false);//00000010
			PlaceFlagMove=((flags&0x01)?true:false);//00000001
			
			flags=data[offset++];
			//Reserved=flags&0xe0;//11100000
			PlaceFlagHasImage=((flags&0x10)?true:false);//00010000
			var PlaceFlagHasClassName:Boolean=((flags&0x08)?true:false);//00001000
			var PlaceFlagHasCacheAsBitmap:Boolean=((flags&0x04)?true:false);//00000100
			var PlaceFlagHasBlendMode:Boolean=((flags&0x02)?true:false);//00000010
			var PlaceFlagHasFilterList:Boolean=((flags&0x01)?true:false);//00000001
			
			Depth=data[offset++]|(data[offset++]<<8);
			
			if(PlaceFlagHasClassName){
				get_str_size=0;
				while(data[offset+(get_str_size++)]){}
				data.position=offset;
				ClassName=data.readUTFBytes(get_str_size);
				offset+=get_str_size;
			}else{
				ClassName=null;
			}
			
			if(PlaceFlagHasCharacter){
				CharacterId=data[offset++]|(data[offset++]<<8);
			}else{
				CharacterId=-1;
			}
			
			if(PlaceFlagHasMatrix){
				Matrix=new MATRIX();
				offset=Matrix.initByData(data,offset,endOffset,_initByDataOptions);
			}else{
				Matrix=null;
			}
			
			if(PlaceFlagHasColorTransform){
				ColorTransform=new CXFORMWITHALPHA();
				offset=ColorTransform.initByData(data,offset,endOffset,_initByDataOptions);
			}else{
				ColorTransform=null;
			}
			
			if(PlaceFlagHasRatio){
				Ratio=data[offset++]|(data[offset++]<<8);
			}else{
				Ratio=-1;
			}
			
			if(PlaceFlagHasName){
				get_str_size=0;
				while(data[offset+(get_str_size++)]){}
				data.position=offset;
				Name=data.readUTFBytes(get_str_size);
				offset+=get_str_size;
			}else{
				Name=null;
			}
			
			if(PlaceFlagHasClipDepth){
				ClipDepth=data[offset++]|(data[offset++]<<8);
			}else{
				ClipDepth=-1;
			}
			
			if(PlaceFlagHasFilterList){
				var NumberOfFilters:int=data[offset++];
				if(NumberOfFilters){
					SurfaceFilterV=new Vector.<Filter>();
					for(i=0;i<NumberOfFilters;i++){
						
						SurfaceFilterV[i]=new Filter();
						offset=SurfaceFilterV[i].initByData(data,offset,endOffset,_initByDataOptions);
						
					}
				}else{
					SurfaceFilterV=null;
				}
			}else{
				SurfaceFilterV=null;
			}
			
			if(PlaceFlagHasBlendMode){
				BlendMode=data[offset++];
			}else{
				BlendMode=-1;
			}
			
			if(PlaceFlagHasCacheAsBitmap){
				BitmapCache=data[offset++];
			}else{
				BitmapCache=-1;
			}
			
			if(PlaceFlagHasClipActions){
				var ClipActionsClass:Class;
				if(_initByDataOptions){
					if(_initByDataOptions.classes){
						ClipActionsClass=_initByDataOptions.classes["zero.swf.records.clips.CLIPACTIONs"];
					}
					if(ClipActionsClass){
					}else{
						ClipActionsClass=_initByDataOptions.ClipActionsClass;
					}
				}
				ClipActions=new (ClipActionsClass||BytesData)();
				offset=ClipActions.initByData(data,offset,endOffset,_initByDataOptions);
			}else{
				ClipActions=null;
			}
			
			return offset;
			
		}
		public function toData(_toDataOptions:Object):ByteArray{
			
			var flags:int;
			
			var data:ByteArray=new ByteArray();
			
			flags=0;
			if(ClipActions){
				flags|=0x80;//PlaceFlagHasClipActions//10000000
			}
			if(ClipDepth>-1){
				flags|=0x40;//PlaceFlagHasClipDepth//01000000
			}
			if(Name is String){
				flags|=0x20;//PlaceFlagHasName//00100000
			}
			if(Ratio>-1){
				flags|=0x10;//PlaceFlagHasRatio//00010000
			}
			if(ColorTransform){
				flags|=0x08;//PlaceFlagHasColorTransform//00001000
			}
			if(Matrix){
				flags|=0x04;//PlaceFlagHasMatrix//00000100
			}
			if(CharacterId>-1){
				flags|=0x02;//PlaceFlagHasCharacter//00000010
			}
			if(PlaceFlagMove){
				flags|=0x01;//00000001
			}
			data[0]=flags;
			
			flags=0;
			//flags|=Reserved;//11100000
			if(PlaceFlagHasImage){
				flags|=0x10;//00010000
			}
			if(ClassName is String){
				flags|=0x08;//PlaceFlagHasClassName//00001000
			}
			if(BitmapCache>-1){
				flags|=0x04;//PlaceFlagHasCacheAsBitmap//00000100
			}
			if(BlendMode>-1){
				flags|=0x02;//PlaceFlagHasBlendMode//00000010
			}
			if(SurfaceFilterV&&SurfaceFilterV.length){
				flags|=0x01;//PlaceFlagHasFilterList//00000001
			}
			data[1]=flags;
			
			data[2]=Depth;
			data[3]=Depth>>8;
			
			if(ClassName is String){
				data.position=4;
				data.writeUTFBytes(ClassName+"\x00");
			}
			
			if(CharacterId>-1){
				data[data.length]=CharacterId;
				data[data.length]=CharacterId>>8;
			}
			
			if(Matrix){
				data.position=data.length;
				data.writeBytes(Matrix.toData(_toDataOptions));
			}
			
			if(ColorTransform){
				data.position=data.length;
				data.writeBytes(ColorTransform.toData(_toDataOptions));
			}
			
			if(Ratio>-1){
				data[data.length]=Ratio;
				data[data.length]=Ratio>>8;
			}
			
			if(Name is String){
				data.position=data.length;
				data.writeUTFBytes(Name+"\x00");
			}
			
			if(ClipDepth>-1){
				data[data.length]=ClipDepth;
				data[data.length]=ClipDepth>>8;
			}
			
			if(SurfaceFilterV){
				var NumberOfFilters:int=SurfaceFilterV.length;
				if(NumberOfFilters){
					
					data[data.length]=NumberOfFilters;
					
					data.position=data.length;
					for each(var SurfaceFilter:Filter in SurfaceFilterV){
						
						data.writeBytes(SurfaceFilter.toData(_toDataOptions));
						
					}
				}
			}
			
			if(BlendMode>-1){
				data[data.length]=BlendMode;
			}
			
			if(BitmapCache>-1){
				data[data.length]=BitmapCache;
			}
			
			if(ClipActions){
				data.position=data.length;
				data.writeBytes(ClipActions.toData(_toDataOptions));
			}
			
			return data;
			
		}
		
		CONFIG::USE_XML{
			public function toXML(xmlName:String,_toXMLOptions:Object):XML{
				
				var xml:XML=<{xmlName} class="zero.swf.tagBodys.PlaceObject3"
					PlaceFlagMove={PlaceFlagMove}
					PlaceFlagHasImage={PlaceFlagHasImage}
					Depth={Depth}
				/>;
				
				if(ClassName is String){
					xml.@ClassName=ClassName;
				}
				
				if(CharacterId>-1){
					xml.@CharacterId=CharacterId;
				}
				
				if(Matrix){
					xml.appendChild(Matrix.toXML("Matrix",_toXMLOptions));
				}
				
				if(ColorTransform){
					xml.appendChild(ColorTransform.toXML("ColorTransform",_toXMLOptions));
				}
				
				if(Ratio>-1){
					xml.@Ratio=Ratio;
				}
				
				if(Name is String){
					xml.@Name=Name;
				}
				
				if(ClipDepth>-1){
					xml.@ClipDepth=ClipDepth;
				}
				
				if(SurfaceFilterV){
					if(SurfaceFilterV.length){
						var SurfaceFilterListXML:XML=<SurfaceFilterList count={SurfaceFilterV.length}/>;
						for each(var SurfaceFilter:Filter in SurfaceFilterV){
							
							SurfaceFilterListXML.appendChild(SurfaceFilter.toXML("SurfaceFilter",_toXMLOptions));
							
						}
						xml.appendChild(SurfaceFilterListXML);
					}
				}
				
				if(BlendMode>-1){
					xml.@BlendMode=BlendModes.blendModeV[BlendMode];
				}
				
				if(BitmapCache>-1){
					xml.@BitmapCache=BitmapCache;
				}
				
				if(ClipActions){
					xml.appendChild(ClipActions.toXML("ClipActions",_toXMLOptions));
				}
				
				return xml;
				
			}
			public function initByXML(xml:XML,_initByXMLOptions:Object):void{
				
				var i:int;
				
				PlaceFlagMove=(xml.@PlaceFlagMove.toString()=="true");
				
				PlaceFlagHasImage=(xml.@PlaceFlagHasImage.toString()=="true");
				
				Depth=int(xml.@Depth.toString());
				
				var ClassNameXML:XML=xml.@ClassName[0];
				if(ClassNameXML){
					ClassName=ClassNameXML.toString();
				}else{
					ClassName=null;
				}
				
				var CharacterIdXML:XML=xml.@CharacterId[0];
				if(CharacterIdXML){
					CharacterId=int(CharacterIdXML.toString());
				}else{
					CharacterId=-1;
				}
				
				var MatrixXML:XML=xml.Matrix[0];
				if(MatrixXML){
					Matrix=new MATRIX();
					Matrix.initByXML(MatrixXML,_initByXMLOptions);
				}else{
					Matrix=null;
				}
				
				var ColorTransformXML:XML=xml.ColorTransform[0];
				if(ColorTransformXML){
					ColorTransform=new CXFORMWITHALPHA();
					ColorTransform.initByXML(ColorTransformXML,_initByXMLOptions);
				}else{
					ColorTransform=null;
				}
				
				var RatioXML:XML=xml.@Ratio[0];
				if(RatioXML){
					Ratio=int(RatioXML.toString());
				}else{
					Ratio=-1;
				}
				
				var NameXML:XML=xml.@Name[0];
				if(NameXML){
					Name=NameXML.toString();
				}else{
					Name=null;
				}
				
				var ClipDepthXML:XML=xml.@ClipDepth[0];
				if(ClipDepthXML){
					ClipDepth=int(ClipDepthXML.toString());
				}else{
					ClipDepth=-1;
				}
				
				var SurfaceFilterXMLList:XMLList=xml.SurfaceFilterList.SurfaceFilter;
				if(SurfaceFilterXMLList.length()){
					i=-1;
					SurfaceFilterV=new Vector.<Filter>();
					for each(var SurfaceFilterXML:XML in SurfaceFilterXMLList){
						i++;
						
						SurfaceFilterV[i]=new Filter();
						SurfaceFilterV[i].initByXML(SurfaceFilterXML,_initByXMLOptions);
						
					}
				}else{
					SurfaceFilterV=null;
				}
				
				var BlendModeXML:XML=xml.@BlendMode[0];
				if(BlendModeXML){
					BlendMode=BlendModes[BlendModeXML.toString()];
				}else{
					BlendMode=-1;
				}
				
				var BitmapCacheXML:XML=xml.@BitmapCache[0];
				if(BitmapCacheXML){
					BitmapCache=int(BitmapCacheXML.toString());
				}else{
					BitmapCache=-1;
				}
				
				var ClipActionsXML:XML=xml.ClipActions[0];
				if(ClipActionsXML){
					var classStr:String=ClipActionsXML["@class"].toString();
					var ClipActionsClass:Class=null;
					if(_initByXMLOptions&&_initByXMLOptions.customClasses){
						ClipActionsClass=_initByXMLOptions.customClasses[classStr];
					}
					if(ClipActionsClass){
					}else{
						try{
							import flash.utils.getDefinitionByName;
							ClipActionsClass=getDefinitionByName(classStr) as Class;
						}catch(e:Error){
							ClipActionsClass=null;
						}
					}
					ClipActions=new (ClipActionsClass||BytesData)();
					ClipActions.initByXML(ClipActionsXML,_initByXMLOptions);
				}else{
					ClipActions=null;
				}
				
			}
		}
	}
}