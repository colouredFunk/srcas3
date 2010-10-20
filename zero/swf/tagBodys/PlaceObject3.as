/***
PlaceObject3 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月18日 12:16:58 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
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
//打开flash cs4，新建一fla，导入一张位图，设置类名为 “Img”，拖位图到场景上，导出，查看结构，发现生成了 PlaceFlagHasImage=1 的 PlaceObject3，但是 ClassName=null
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
	import zero.swf.records.MATRIX;
	import zero.swf.records.CXFORMWITHALPHA;
	import zero.swf.records.FILTERLIST;
	import zero.swf.vmarks.BlendModes;
	import zero.swf.records.CLIPACTIONS;
	import flash.utils.ByteArray;
	public class PlaceObject3 extends TagBody{
		public var PlaceFlagHasClipActions:int;
		public var PlaceFlagHasClipDepth:int;
		public var PlaceFlagHasName:int;
		public var PlaceFlagHasRatio:int;
		public var PlaceFlagHasColorTransform:int;
		public var PlaceFlagHasMatrix:int;
		public var PlaceFlagHasCharacter:int;
		public var PlaceFlagMove:int;
		public var PlaceFlagHasImage:int;
		public var PlaceFlagHasClassName:int;
		public var PlaceFlagHasCacheAsBitmap:int;
		public var PlaceFlagHasBlendMode:int;
		public var PlaceFlagHasFilterList:int;
		public var Depth:int;							//UI16
		public var ClassName:String;					//STRING
		public var CharacterId:int;						//UI16
		public var Matrix:MATRIX;
		public var ColorTransform:CXFORMWITHALPHA;
		public var Ratio:int;							//UI16
		public var Name:String;							//STRING
		public var ClipDepth:int;						//UI16
		public var SurfaceFilterList:FILTERLIST;
		public var BlendMode:int;						//UI8
		public var BitmapCache:int;						//UI8
		public var ClipActions:CLIPACTIONS;
		//
		override public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			var flags:int=data[offset];
			PlaceFlagHasClipActions=(flags<<24)>>>31;	//10000000
			PlaceFlagHasClipDepth=(flags<<25)>>>31;		//01000000
			PlaceFlagHasName=(flags<<26)>>>31;			//00100000
			PlaceFlagHasRatio=(flags<<27)>>>31;			//00010000
			PlaceFlagHasColorTransform=(flags<<28)>>>31;//00001000
			PlaceFlagHasMatrix=(flags<<29)>>>31;		//00000100
			PlaceFlagHasCharacter=(flags<<30)>>>31;		//00000010
			PlaceFlagMove=flags&0x01;					//00000001
			flags=data[offset+1];
			//Reserved=(flags<<24)>>>29;				//11100000
			PlaceFlagHasImage=(flags<<27)>>>31;			//00010000
			PlaceFlagHasClassName=(flags<<28)>>>31;		//00001000
			PlaceFlagHasCacheAsBitmap=(flags<<29)>>>31;	//00000100
			PlaceFlagHasBlendMode=(flags<<30)>>>31;		//00000010
			PlaceFlagHasFilterList=flags&0x01;			//00000001
			Depth=data[offset+2]|(data[offset+3]<<8);
			//#offsetpp
			offset+=4;
			if(PlaceFlagHasClassName){
				//#offsetpp
			
				var get_str_size:int=0;
				while(data[offset+(get_str_size++)]){}
				data.position=offset;
				ClassName=data.readUTFBytes(get_str_size);
				offset+=get_str_size;
			}
			//#offsetpp
			
			if(PlaceFlagHasCharacter){
				CharacterId=data[offset++]|(data[offset++]<<8);
			}
			//#offsetpp
			
			if(PlaceFlagHasMatrix){
				//#offsetpp
			
				Matrix=new MATRIX();
				offset=Matrix.initByData(data,offset,endOffset);
			}
			//#offsetpp
			
			if(PlaceFlagHasColorTransform){
				//#offsetpp
			
				ColorTransform=new CXFORMWITHALPHA();
				offset=ColorTransform.initByData(data,offset,endOffset);
			}
			//#offsetpp
			
			if(PlaceFlagHasRatio){
				Ratio=data[offset++]|(data[offset++]<<8);
			}
			//#offsetpp
			
			if(PlaceFlagHasName){
				//#offsetpp
			
				get_str_size=0;
				while(data[offset+(get_str_size++)]){}
				data.position=offset;
				Name=data.readUTFBytes(get_str_size);
				offset+=get_str_size;
			}
			//#offsetpp
			
			if(PlaceFlagHasClipDepth){
				ClipDepth=data[offset++]|(data[offset++]<<8);
			}
			//#offsetpp
			
			if(PlaceFlagHasFilterList){
				//#offsetpp
			
				SurfaceFilterList=new FILTERLIST();
				offset=SurfaceFilterList.initByData(data,offset,endOffset);
			}
			//#offsetpp
			
			if(PlaceFlagHasBlendMode){
				BlendMode=data[offset++];
			}
			//#offsetpp
			
			if(PlaceFlagHasCacheAsBitmap){
				BitmapCache=data[offset++];
			}
			//#offsetpp
			
			if(PlaceFlagHasClipActions){
				//#offsetpp
			
				ClipActions=new CLIPACTIONS();
				offset=ClipActions.initByData(data,offset,endOffset);
			}
			return offset;
		}
		override public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			//var offset:int=0;//测试
			var flags:int=0;
			flags|=PlaceFlagHasClipActions<<7;			//10000000
			flags|=PlaceFlagHasClipDepth<<6;			//01000000
			flags|=PlaceFlagHasName<<5;					//00100000
			flags|=PlaceFlagHasRatio<<4;				//00010000
			flags|=PlaceFlagHasColorTransform<<3;		//00001000
			flags|=PlaceFlagHasMatrix<<2;				//00000100
			flags|=PlaceFlagHasCharacter<<1;			//00000010
			flags|=PlaceFlagMove;						//00000001
			data[0]=flags;
			
			flags=0;
			//flags|=Reserved<<5;						//11100000
			flags|=PlaceFlagHasImage<<4;				//00010000
			flags|=PlaceFlagHasClassName<<3;			//00001000
			flags|=PlaceFlagHasCacheAsBitmap<<2;		//00000100
			flags|=PlaceFlagHasBlendMode<<1;			//00000010
			flags|=PlaceFlagHasFilterList;				//00000001
			data[1]=flags;
			
			data[2]=Depth;
			data[3]=Depth>>8;
			//#offsetpp
			var offset:int=4;
			if(PlaceFlagHasClassName){
				data.position=offset;
				data.writeUTFBytes(ClassName+"\x00");
				offset=data.length;
			}
			//#offsetpp
			
			if(PlaceFlagHasCharacter){
				data[offset++]=CharacterId;
				data[offset++]=CharacterId>>8;
			}
			//#offsetpp
			
			if(PlaceFlagHasMatrix){
				data.position=offset;
				data.writeBytes(Matrix.toData());
				offset=data.length;
			}
			//#offsetpp
			
			if(PlaceFlagHasColorTransform){
				data.position=offset;
				data.writeBytes(ColorTransform.toData());
				offset=data.length;
			}
			//#offsetpp
			
			if(PlaceFlagHasRatio){
				data[offset++]=Ratio;
				data[offset++]=Ratio>>8;
			}
			//#offsetpp
			
			if(PlaceFlagHasName){
				data.position=offset;
				data.writeUTFBytes(Name+"\x00");
				offset=data.length;
			}
			//#offsetpp
			
			if(PlaceFlagHasClipDepth){
				data[offset++]=ClipDepth;
				data[offset++]=ClipDepth>>8;
			}
			//#offsetpp
			
			if(PlaceFlagHasFilterList){
				data.position=offset;
				data.writeBytes(SurfaceFilterList.toData());
				offset=data.length;
			}
			//#offsetpp
			
			if(PlaceFlagHasBlendMode){
				data[offset++]=BlendMode;
			}
			//#offsetpp
			
			if(PlaceFlagHasCacheAsBitmap){
				data[offset++]=BitmapCache;
			}
			if(PlaceFlagHasClipActions){
				data.position=offset;
				data.writeBytes(ClipActions.toData());
			}
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		override public function toXML():XML{
			var xml:XML=<PlaceObject3
				PlaceFlagHasClipActions={PlaceFlagHasClipActions}
				PlaceFlagHasClipDepth={PlaceFlagHasClipDepth}
				PlaceFlagHasName={PlaceFlagHasName}
				PlaceFlagHasRatio={PlaceFlagHasRatio}
				PlaceFlagHasColorTransform={PlaceFlagHasColorTransform}
				PlaceFlagHasMatrix={PlaceFlagHasMatrix}
				PlaceFlagHasCharacter={PlaceFlagHasCharacter}
				PlaceFlagMove={PlaceFlagMove}
				PlaceFlagHasImage={PlaceFlagHasImage}
				PlaceFlagHasClassName={PlaceFlagHasClassName}
				PlaceFlagHasCacheAsBitmap={PlaceFlagHasCacheAsBitmap}
				PlaceFlagHasBlendMode={PlaceFlagHasBlendMode}
				PlaceFlagHasFilterList={PlaceFlagHasFilterList}
				Depth={Depth}
				ClassName={ClassName}
				CharacterId={CharacterId}
				Ratio={Ratio}
				Name={Name}
				ClipDepth={ClipDepth}
				BlendMode={BlendModes.blendModeV[BlendMode]}
				BitmapCache={BitmapCache}
			>
				<Matrix/>
				<ColorTransform/>
				<SurfaceFilterList/>
				<ClipActions/>
			</PlaceObject3>;
			if(PlaceFlagHasClassName){
				
			}else{
				delete xml.@ClassName;
			}
			if(PlaceFlagHasCharacter){
				
			}else{
				delete xml.@CharacterId;
			}
			if(PlaceFlagHasMatrix){
				xml.Matrix.appendChild(Matrix.toXML());
			}else{
				delete xml.Matrix;
			}
			if(PlaceFlagHasColorTransform){
				xml.ColorTransform.appendChild(ColorTransform.toXML());
			}else{
				delete xml.ColorTransform;
			}
			if(PlaceFlagHasRatio){
				
			}else{
				delete xml.@Ratio;
			}
			if(PlaceFlagHasName){
				
			}else{
				delete xml.@Name;
			}
			if(PlaceFlagHasClipDepth){
				
			}else{
				delete xml.@ClipDepth;
			}
			if(PlaceFlagHasFilterList){
				xml.SurfaceFilterList.appendChild(SurfaceFilterList.toXML());
			}else{
				delete xml.SurfaceFilterList;
			}
			if(PlaceFlagHasBlendMode){
				
			}else{
				delete xml.@BlendMode;
			}
			if(PlaceFlagHasCacheAsBitmap){
				
			}else{
				delete xml.@BitmapCache;
			}
			if(PlaceFlagHasClipActions){
				xml.ClipActions.appendChild(ClipActions.toXML());
			}else{
				delete xml.ClipActions;
			}
			return xml;
		}
		override public function initByXML(xml:XML):void{
			PlaceFlagHasClipActions=int(xml.@PlaceFlagHasClipActions.toString());
			PlaceFlagHasClipDepth=int(xml.@PlaceFlagHasClipDepth.toString());
			PlaceFlagHasName=int(xml.@PlaceFlagHasName.toString());
			PlaceFlagHasRatio=int(xml.@PlaceFlagHasRatio.toString());
			PlaceFlagHasColorTransform=int(xml.@PlaceFlagHasColorTransform.toString());
			PlaceFlagHasMatrix=int(xml.@PlaceFlagHasMatrix.toString());
			PlaceFlagHasCharacter=int(xml.@PlaceFlagHasCharacter.toString());
			PlaceFlagMove=int(xml.@PlaceFlagMove.toString());
			PlaceFlagHasImage=int(xml.@PlaceFlagHasImage.toString());
			PlaceFlagHasClassName=int(xml.@PlaceFlagHasClassName.toString());
			PlaceFlagHasCacheAsBitmap=int(xml.@PlaceFlagHasCacheAsBitmap.toString());
			PlaceFlagHasBlendMode=int(xml.@PlaceFlagHasBlendMode.toString());
			PlaceFlagHasFilterList=int(xml.@PlaceFlagHasFilterList.toString());
			Depth=int(xml.@Depth.toString());
			if(PlaceFlagHasClassName){
				ClassName=xml.@ClassName.toString();
			}
			if(PlaceFlagHasCharacter){
				CharacterId=int(xml.@CharacterId.toString());
			}
			if(PlaceFlagHasMatrix){
				Matrix=new MATRIX();
				Matrix.initByXML(xml.Matrix.children()[0]);
			}
			if(PlaceFlagHasColorTransform){
				ColorTransform=new CXFORMWITHALPHA();
				ColorTransform.initByXML(xml.ColorTransform.children()[0]);
			}
			if(PlaceFlagHasRatio){
				Ratio=int(xml.@Ratio.toString());
			}
			if(PlaceFlagHasName){
				Name=xml.@Name.toString();
			}
			if(PlaceFlagHasClipDepth){
				ClipDepth=int(xml.@ClipDepth.toString());
			}
			if(PlaceFlagHasFilterList){
				SurfaceFilterList=new FILTERLIST();
				SurfaceFilterList.initByXML(xml.SurfaceFilterList.children()[0]);
			}
			if(PlaceFlagHasBlendMode){
				BlendMode=BlendModes[xml.@BlendMode.toString()];
			}
			if(PlaceFlagHasCacheAsBitmap){
				BitmapCache=int(xml.@BitmapCache.toString());
			}
			if(PlaceFlagHasClipActions){
				ClipActions=new CLIPACTIONS();
				ClipActions.initByXML(xml.ClipActions.children()[0]);
			}
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
