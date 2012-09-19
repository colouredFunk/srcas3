/***
getImgSpriteTag
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年8月30日 12:27:20
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.swf.funs{
	
	import flash.display.BitmapData;
	import flash.utils.ByteArray;
	
	import zero.swf.*;
	import zero.swf.records.*;
	import zero.swf.records.shapes.*;
	import zero.swf.tagBodys.*;
	
	public function getImgSpriteTag(
		x:Number,
		y:Number,
		width:Number,
		height:Number,
		imgData:ByteArray,
		jpegId:int,
		spriteId:int,
		shapeId:int
	):Tag{
		
		var x_in_twips:int=Math.round(x*20);
		var y_in_twips:int=Math.round(y*20);
		var width_in_twips:int=Math.round(width*20);
		var height_in_twips:int=Math.round(height*20);
		
		var defineBitsJPEG2:DefineBitsJPEG2=new DefineBitsJPEG2();
		defineBitsJPEG2.id=jpegId;
		defineBitsJPEG2.ImageData=new BytesData();
		defineBitsJPEG2.ImageData.initByData(imgData,0,imgData.length,null);
		var defineBitsJPEG2Tag:Tag=new Tag();
		defineBitsJPEG2Tag.setBody(defineBitsJPEG2);
		
		var defineSprite:DefineSprite=new DefineSprite();
		defineSprite.id=spriteId;
		var defineSpriteTag:Tag=new Tag();
		defineSpriteTag.setBody(defineSprite);
		
		var defineShape:DefineShape=new DefineShape();
		defineShape.id=shapeId;
		defineShape.ShapeBounds=new RECT();
		defineShape.ShapeBounds.Xmin=0;
		defineShape.ShapeBounds.Xmax=width_in_twips;
		defineShape.ShapeBounds.Ymin=0;
		defineShape.ShapeBounds.Ymax=height_in_twips;
		var defineShape_Shapes:SHAPEWITHSTYLE=new SHAPEWITHSTYLE();
		defineShape_Shapes.FillStyleV=new Vector.<FILLSTYLE>();
		defineShape_Shapes.FillStyleV[0]=new FILLSTYLE();
		defineShape_Shapes.FillStyleV[0].FillStyleType=0x41;
		defineShape_Shapes.FillStyleV[0].BitmapId=defineBitsJPEG2.id;
		var BitmapMatrix:MATRIX=new MATRIX();
		BitmapMatrix.HasScale=true;
		BitmapMatrix.ScaleX=1310720;
		BitmapMatrix.ScaleY=1310720;
		defineShape_Shapes.FillStyleV[0].BitmapMatrix=BitmapMatrix;
		defineShape_Shapes.ShapeRecordV=new Vector.<SHAPERECORD>();
		var ShapeRecord:SHAPERECORD=new SHAPERECORD();
		defineShape_Shapes.ShapeRecordV[0]=ShapeRecord;
		ShapeRecord.type=ShapeRecordTypes.STYLECHANGERECORD;
		ShapeRecord.FillStyle1=1;
		defineShape_Shapes.ShapeRecordV[1]=ShapeRecord=new SHAPERECORD();
		ShapeRecord.type=ShapeRecordTypes.STRAIGHTEDGERECORD;
		ShapeRecord.DeltaX=width_in_twips;
		defineShape_Shapes.ShapeRecordV[2]=ShapeRecord=new SHAPERECORD();
		ShapeRecord.type=ShapeRecordTypes.STRAIGHTEDGERECORD;
		ShapeRecord.DeltaY=height_in_twips;
		defineShape_Shapes.ShapeRecordV[3]=ShapeRecord=new SHAPERECORD();
		ShapeRecord.type=ShapeRecordTypes.STRAIGHTEDGERECORD;
		ShapeRecord.DeltaX=-width_in_twips;
		defineShape_Shapes.ShapeRecordV[4]=ShapeRecord=new SHAPERECORD();
		ShapeRecord.type=ShapeRecordTypes.STRAIGHTEDGERECORD;
		ShapeRecord.DeltaY=-height_in_twips;
		defineShape_Shapes.ShapeRecordV[5]=ShapeRecord=new SHAPERECORD();
		ShapeRecord.type=ShapeRecordTypes.ENDSHAPERECORD;
		defineShape.Shapes=defineShape_Shapes;
		var defineShapeTag:Tag=new Tag();
		defineShapeTag.setBody(defineShape);
		var placeObject2:PlaceObject2=new PlaceObject2();
		placeObject2.PlaceFlagMove=false;
		placeObject2.Depth=1;
		placeObject2.CharacterId=defineShape.id;
		if(x_in_twips||y_in_twips){
			placeObject2.Matrix=new MATRIX();
			placeObject2.Matrix.TranslateX=x_in_twips;
			placeObject2.Matrix.TranslateY=y_in_twips;
		}
		var placeObject2Tag:Tag=new Tag();
		placeObject2Tag.setBody(placeObject2);
		
		defineSprite.tagV=new <Tag>[
			defineBitsJPEG2Tag,
			defineShapeTag,
			placeObject2Tag,
			new Tag(TagTypes.ShowFrame),
			new Tag(TagTypes.End)
		];
		
		return defineSpriteTag;
		
	}
}