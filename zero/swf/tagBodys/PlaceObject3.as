/***
PlaceObject3
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年7月22日 16:42:10
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.swf.tagBodys{
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;
	import zero.swf.BytesData;
	import zero.swf.records.BlendModes;
	import zero.swf.records.CXFORMWITHALPHA;
	import zero.swf.records.MATRIX;
	import zero.swf.records.Filter;
	import zero.swf.records.FilterIDs;
	public class PlaceObject3{//implements I_zero_swf_CheckCodesRight{
		public var PlaceFlagMove:Boolean;
		public var PlaceFlagHasImage:Boolean;
		public var Depth:int;							//UI16
		public var ClassName:String;					//STRING
		public var CharacterId:int;						//UI16
		public var Matrix:*;
		public var ColorTransform:*;
		public var Ratio:int;							//UI16
		public var Name:String;							//STRING
		public var ClipDepth:int;						//UI16
		public var SurfaceFilterV:Vector.<*>;
		public var BlendMode:int;						//UI8
		public var BitmapCache:int;						//UI8
		public var ClipActions:*;
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object/*zero_swf_InitByDataOptions*/):int{
			var flags:int=data[offset++];
			PlaceFlagMove=((flags&0x01)?true:false);						//00000001
			var flags2:int=data[offset++];
			//Reserved=flags2&0xe0;											//11100000
			PlaceFlagHasImage=((flags2&0x10)?true:false);					//00010000
			Depth=data[offset++]|(data[offset++]<<8);
			if(flags2&0x08){//PlaceFlagHasClassName							//00001000
				var get_str_size:int=0;
				while(data[offset+(get_str_size++)]){}
				data.position=offset;
				ClassName=data.readUTFBytes(get_str_size);
				offset+=get_str_size;
			}else{
				ClassName=null;
			}
			if(flags&0x02){//PlaceFlagHasCharacter							//00000010
				CharacterId=data[offset++]|(data[offset++]<<8);
			}else{
				CharacterId=-1;
			}
			if(flags&0x04){//PlaceFlagHasMatrix								//00000100
				Matrix=new (_initByDataOptions&&_initByDataOptions.classes&&_initByDataOptions.classes["zero.swf.records.MATRIX"]||MATRIX)();
				offset=Matrix.initByData(data,offset,endOffset,_initByDataOptions);
			}else{
				Matrix=null;
			}
			if(flags&0x08){//PlaceFlagHasColorTransform						//00001000
				ColorTransform=new (_initByDataOptions&&_initByDataOptions.classes&&_initByDataOptions.classes["zero.swf.records.CXFORMWITHALPHA"]||CXFORMWITHALPHA)();
				offset=ColorTransform.initByData(data,offset,endOffset,_initByDataOptions);
			}else{
				ColorTransform=null;
			}
			if(flags&0x10){//PlaceFlagHasRatio								//00010000
				Ratio=data[offset++]|(data[offset++]<<8);
			}else{
				Ratio=-1;
			}
			if(flags&0x20){//PlaceFlagHasName								//00100000
				get_str_size=0;
				while(data[offset+(get_str_size++)]){}
				data.position=offset;
				Name=data.readUTFBytes(get_str_size);
				offset+=get_str_size;
			}else{
				Name=null;
			}
			if(flags&0x40){//PlaceFlagHasClipDepth							//01000000
				ClipDepth=data[offset++]|(data[offset++]<<8);
			}else{
				ClipDepth=-1;
			}
			if(flags2&0x01){//PlaceFlagHasFilterList						//00000001
				var NumberOfFilters:int=data[offset++];
				if(NumberOfFilters){
					SurfaceFilterV=new Vector.<*>();
					for(var i:int=0;i<NumberOfFilters;i++){
						SurfaceFilterV[i]=new (_initByDataOptions&&_initByDataOptions.classes&&_initByDataOptions.classes["zero.swf.records.Filter"]||Filter)();
						offset=SurfaceFilterV[i].initByData(data,offset,endOffset,_initByDataOptions);
					}
				}else{
					SurfaceFilterV=null;
				}
			}else{
				SurfaceFilterV=null;
			}
			if(flags2&0x02){//PlaceFlagHasBlendMode							//00000010
				BlendMode=data[offset++];
			}else{
				BlendMode=-1;
			}
			if(flags2&0x04){//PlaceFlagHasCacheAsBitmap						//00000100
				BitmapCache=data[offset++];
			}else{
				BitmapCache=-1;
			}
			if(flags&0x80){//PlaceFlagHasClipActions						//10000000
				ClipActions=new (_initByDataOptions&&(_initByDataOptions.classes&&_initByDataOptions.classes["zero.swf.BytesData"]||_initByDataOptions.ClipActionsClass)||BytesData)();
				offset=ClipActions.initByData(data,offset,endOffset,_initByDataOptions);
			}else{
				ClipActions=null;
			}
			return offset;
		}
		public function toData(_toDataOptions:Object/*zero_swf_ToDataOptions*/):ByteArray{
			var data:ByteArray=new ByteArray();
			var flags:int=0;
			if(PlaceFlagMove){
				flags|=0x01;										//00000001
			}
			var flags2:int=0;
			//flags2|=Reserved										//11100000
			if(PlaceFlagHasImage){
				flags2|=0x10;										//00010000
			}
			data[2]=Depth;
			data[3]=Depth>>8;
			var offset:int=4;
			if(ClassName is String){
				data.position=offset;
				data.writeUTFBytes(ClassName+"\x00");
				offset=data.length;
			}
			if(CharacterId>-1){
				flags|=0x02;//PlaceFlagHasCharacter					//00000010
				data[offset++]=CharacterId;
				data[offset++]=CharacterId>>8;
			}
			if(Matrix){
				flags|=0x04;//PlaceFlagHasMatrix					//00000100
				data.position=offset;
				data.writeBytes(Matrix.toData(_toDataOptions));
				offset=data.length;
			}
			if(ColorTransform){
				flags|=0x08;//PlaceFlagHasColorTransform			//00001000
				data.position=offset;
				data.writeBytes(ColorTransform.toData(_toDataOptions));
				offset=data.length;
			}
			if(Ratio>-1){
				flags|=0x10;//PlaceFlagHasRatio						//00010000
				data[offset++]=Ratio;
				data[offset++]=Ratio>>8;
			}
			if(Name is String){
				flags|=0x20;//PlaceFlagHasName						//00100000
				data.position=offset;
				data.writeUTFBytes(Name+"\x00");
				offset=data.length;
			}
			if(ClipDepth>-1){
				flags|=0x40;//PlaceFlagHasClipDepth					//01000000
				data[offset++]=ClipDepth;
				data[offset++]=ClipDepth>>8;
			}
			if(SurfaceFilterV){
				var NumberOfFilters:int=SurfaceFilterV.length;
				if(NumberOfFilters){
					flags2|=0x01;//PlaceFlagHasFilterList			//00000001
					data[offset++]=NumberOfFilters;
					data.position=offset;
					for each(var SurfaceFilter:* in SurfaceFilterV){
						data.writeBytes(SurfaceFilter.toData(_toDataOptions));
					}
					offset=data.length;
				}
			}
			if(BlendMode>-1){
				flags2|=0x02;//1PlaceFlagHasBlendMode				//00000010
				data[offset++]=BlendMode;
			}
			if(BitmapCache>-1){
				flags2|=0x04;//PlaceFlagHasCacheAsBitmap			//00000100
				data[offset++]=BitmapCache;
			}
			if(ClipActions){
				flags|=0x80;//PlaceFlagHasClipActions				//10000000
				data.position=offset;
				data.writeBytes(ClipActions.toData(_toDataOptions));
				offset=data.length;
			}
			data[0]=flags;
			data[1]=flags2;
			return data;
		}
		
		////
		CONFIG::USE_XML{
		public function toXML(xmlName:String,_toXMLOptions:Object/*zero_swf_ToXMLOptions*/):XML{
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
					var SurfaceFilterListXML:XML=<SurfaceFilterList count={SurfaceFilterV.length}/>
					for each(var SurfaceFilter:* in SurfaceFilterV){
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
		public function initByXML(xml:XML,_initByXMLOptions:Object/*zero_swf_InitByXMLOptions*/):void{
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
				Matrix=new (_initByXMLOptions&&_initByXMLOptions.customClasses&&_initByXMLOptions.customClasses[MatrixXML["@class"].toString()]||MATRIX)();
				Matrix.initByXML(MatrixXML,_initByXMLOptions);
			}else{
				Matrix=null;
			}
			var ColorTransformXML:XML=xml.ColorTransform[0];
			if(ColorTransformXML){
				ColorTransform=new (_initByXMLOptions&&_initByXMLOptions.customClasses&&_initByXMLOptions.customClasses[ColorTransformXML["@class"].toString()]||CXFORMWITHALPHA)();
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
				var i:int=-1;
				SurfaceFilterV=new Vector.<*>();
				for each(var SurfaceFilterXML:XML in SurfaceFilterXMLList){
					i++;
					SurfaceFilterV[i]=new (_initByXMLOptions&&_initByXMLOptions.customClasses&&_initByXMLOptions.customClasses[SurfaceFilterXML["@class"].toString()]||Filter)();
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
						ClipActionsClass=getDefinitionByName(classStr) as Class;
					}catch(e:Error){
						ClipActionsClass=null;
					}
				}
				if(ClipActionsClass){
				}else{
					ClipActionsClass=BytesData;
				}
				ClipActions=new ClipActionsClass();
				ClipActions.initByXML(ClipActionsXML,_initByXMLOptions);
			}
		}
		}//end of CONFIG::USE_XML
	}
}