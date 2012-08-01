/***
Shapes2Ani
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年9月27日 17:34:09
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.swf.funs{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	import zero.swf.*;
	import zero.swf.records.shapes.*;
	
	public class Shapes2Ani{
		
		private var drawArea:Sprite;
		private var tag_type:int;
		private var Shapes:SHAPEWITHSTYLE;
		private var complete:Function;
		private var recordId:int;
		
		private var intervalId:int;
		
		public function Shapes2Ani(){
		}
		public function start(_drawArea:Sprite,_tag_type:int,_Shapes:SHAPEWITHSTYLE,_complete:Function):void{
			
			drawArea=_drawArea;
			tag_type=_tag_type;
			Shapes=_Shapes;
			complete=_complete;
			
			//分组
			for each(var ShapeRecord:SHAPERECORD in Shapes.ShapeRecordV){
				
			}
			
			//recordId=-1;
			//intervalId=setInterval(step,30);
		}
		public function clear():void{
			clearInterval(intervalId);
			complete=null;
		}
		private function step():void{
			
			if(++recordId>=Shapes.ShapeRecordV.length){
				clearInterval(intervalId);
				if(complete==null){
				}else{
					complete();
					complete=null;
				}
				return;
			}
			
			var LineStyle:LINESTYLE,LineStyle2:LINESTYLE2,FillStyle:FILLSTYLE;
			
			drawArea.graphics.clear();
			
			var currX:int=0;
			var currY:int=0;
			
			var currFillStyleV:Vector.<FILLSTYLE>=Shapes.FillStyleV;
			var currLineStyle2V:Vector.<LINESTYLE2>=Shapes.LineStyle2V;
			var currLineStyleV:Vector.<LINESTYLE>=Shapes.LineStyleV;
			
			for(var i:int=0;i<=recordId;i++){
				var ShapeRecord:SHAPERECORD=Shapes.ShapeRecordV[i];
				switch(ShapeRecord.type){
					case ShapeRecordTypes.STRAIGHTEDGERECORD:
						currX+=ShapeRecord.DeltaX;
						currY+=ShapeRecord.DeltaY;
						drawArea.graphics.lineTo(currX/20,currY/20);
					break;
					case ShapeRecordTypes.CURVEDEDGERECORD:
						var controlX:int=currX+ShapeRecord.ControlDeltaX;
						var controlY:int=currY+ShapeRecord.ControlDeltaY;
						currX=controlX+ShapeRecord.AnchorDeltaX;
						currY=controlY+ShapeRecord.AnchorDeltaY;
						drawArea.graphics.curveTo(controlX/20,controlY/20,currX/20,currY/20);
					break;
					case ShapeRecordTypes.STYLECHANGERECORD:
						
						if(ShapeRecord.MoveDeltaXY){
							currX=ShapeRecord.MoveDeltaXY[0];
							currY=ShapeRecord.MoveDeltaXY[1];
							drawArea.graphics.moveTo(currX/20,currY/20);
						}
						if(ShapeRecord.FillStyle0>-1){
							
							drawArea.graphics.endFill();
							
							if(ShapeRecord.FillStyle0){
								FillStyle=currFillStyleV[ShapeRecord.FillStyle0-1];
								if(FillStyle.FillStyleType==0x00){
									switch(tag_type){
										case TagTypes.DefineShape:
										case TagTypes.DefineShape2:
											drawArea.graphics.beginFill(FillStyle.Color);
										break;
										case TagTypes.DefineShape3:
										case TagTypes.DefineShape4:
											drawArea.graphics.beginFill(FillStyle.Color&0x00ffffff,(FillStyle.Color>>>24)/0xff);
										break;
									}
								}else{
									trace("暂不支持 FillStyle.FillStyleType："+FillStyle.FillStyleType);
									drawArea.graphics.beginFill(0xff0000);
								}
							}
						}
						if(ShapeRecord.FillStyle1>-1){
							
							drawArea.graphics.endFill();
							
							if(ShapeRecord.FillStyle1){
								FillStyle=currFillStyleV[ShapeRecord.FillStyle1-1];
								if(FillStyle.FillStyleType==0x00){
									switch(tag_type){
										case TagTypes.DefineShape:
										case TagTypes.DefineShape2:
											drawArea.graphics.beginFill(FillStyle.Color);
										break;
										case TagTypes.DefineShape3:
										case TagTypes.DefineShape4:
											drawArea.graphics.beginFill(FillStyle.Color&0x00ffffff,(FillStyle.Color>>>24)/0xff);
										break;
									}
								}else{
									trace("暂不支持 FillStyle.FillStyleType："+FillStyle.FillStyleType);
									drawArea.graphics.beginFill(0xff0000);
								}
							}
						}
						if(ShapeRecord.LineStyle>-1){
							
							drawArea.graphics.lineStyle(0,0,0);
							
							if(ShapeRecord.LineStyle){
								switch(tag_type){
									case TagTypes.DefineShape:
									case TagTypes.DefineShape2:
										LineStyle=currLineStyleV[ShapeRecord.LineStyle-1];
										drawArea.graphics.lineStyle(LineStyle.Width/20,LineStyle.Color,1);
									break;
									case TagTypes.DefineShape3:
										LineStyle=currLineStyleV[ShapeRecord.LineStyle-1];
										drawArea.graphics.lineStyle(LineStyle.Width/20,LineStyle.Color&0x00ffffff,(LineStyle.Color>>>24)/0xff);
									break;
									case TagTypes.DefineShape4:
										LineStyle2=currLineStyle2V[ShapeRecord.LineStyle-1];
										if(LineStyle2.FillType){
											trace("暂不支持 LineStyle2.FillType："+LineStyle2.FillType);
											drawArea.graphics.lineStyle(LineStyle2.Width/20,0xff0000);
										}else{
											drawArea.graphics.lineStyle(LineStyle2.Width/20,LineStyle2.Color&0x00ffffff,(LineStyle2.Color>>>24)/0xff);
										}
									break;
								}
							}
						}
						if(ShapeRecord.FillStyleV&&ShapeRecord.FillStyleV.length){
							currFillStyleV=ShapeRecord.FillStyleV;
						}
						if(ShapeRecord.LineStyle2V&&ShapeRecord.LineStyle2V.length){
							currLineStyle2V=ShapeRecord.LineStyle2V;
						}
						if(ShapeRecord.LineStyleV&&ShapeRecord.LineStyleV.length){
							currLineStyleV=ShapeRecord.LineStyleV;
						}
					break;
					case ShapeRecordTypes.ENDSHAPERECORD:
						recordId=Shapes.ShapeRecordV.length;//- -
						return;
					break;
				}
			}
		}
	}
}