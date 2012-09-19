/***
getPlaceObjectTag
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年8月30日 13:02:32
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.swf.funs{
	
	import flash.geom.Matrix;
	
	import zero.swf.*;
	import zero.swf.records.*;
	import zero.swf.records.shapes.*;
	import zero.swf.tagBodys.*;
	
	public function getPlaceObjectTag(CharacterId:int,Depth:int,matrix:Matrix=null):Tag{
		var placeObject:PlaceObject=new PlaceObject();
		placeObject.Depth=Depth;
		placeObject.CharacterId=CharacterId;
		if(matrix){
			placeObject.Matrix=new MATRIX();
			if(
				matrix.a==1
				&&
				matrix.b==0
				&&
				matrix.c==0
				&&
				matrix.d==1
			){
				placeObject.Matrix.HasScale=false;
				placeObject.Matrix.HasRotate=false;
			}else{
				placeObject.Matrix.HasScale=true;
				placeObject.Matrix.ScaleX=matrix.a*65536;
				placeObject.Matrix.ScaleY=matrix.d*65536;
				placeObject.Matrix.HasRotate=true;
				placeObject.Matrix.RotateSkew0=matrix.b*65536;
				placeObject.Matrix.RotateSkew1=matrix.c*65536;
			}
			placeObject.Matrix.TranslateX=matrix.tx*20;
			placeObject.Matrix.TranslateY=matrix.ty*20;
		}
		
		var placeObjectTag:Tag=new Tag();
		placeObjectTag.setBody(placeObject);
		return placeObjectTag;
	}
}