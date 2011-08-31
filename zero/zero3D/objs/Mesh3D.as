/***
Mesh3D 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年2月26日 15:09:07
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.zero3D.objs{
	import zero.zero3D.*;
	import zero.zero3D.cameras.*;
	
	import flash.display.*;
	import flash.utils.Dictionary;

	public class Mesh3D extends VerticesObj3D implements IRenderUnit{
		private static const markLine:Boolean=true;
		
		public static var needTriangles:Boolean=true;
		public static var fastRender:Boolean=false;
		public var fastRenderVertexV:Vector.<Number>;
		
		public var vertexIdV:Vector.<int>;//目前主要用在 needTriangles==false 时
		
		private var bmd:BitmapData;
		
		public var lineThickness:int=1;
		public var lineColor:int=-1;
		public var lineAlpha:Number=1;
		
		public var fillColor:int=-1;
		public var fillAlpha:Number=1;
		
		private var bmdArr:Array;
		private var currBmdId:int;
		public var triangleV:Vector.<Triangle>;
		override public function clear():void{super.clear();
			bmd=null;
			bmdArr=null;
			for each(var triangle:Triangle in triangleV){
				triangle.clear();
			}
			triangleV=null;
		}
		public function Mesh3D(
			bmdOrBmdArr:*,
			vertexV:Vector.<Number>,
			uvV:Vector.<Number>,
			_vertexIdV:Vector.<int>,
			uvIdV:Vector.<int>,
			needOwnContainer:Boolean
		){
			//三角面片组成的3d物体
			super(vertexV);
			
			if(uvIdV==null){
				uvIdV=vertexIdV;
			}
			
			if(bmdOrBmdArr is Array){
				bmdArr=bmdOrBmdArr;
			}else{
				bmd=bmdOrBmdArr;
			}
			currBmdId=-1;
			var i:int=_vertexIdV.length;
			triangleV=new Vector.<Triangle>(i/3);
			var idId:int=0;
			while((i-=3)>=0){
				var triangle:Triangle=triangleV[i/3]=new Triangle(i,i+1,i+2,vertexV,_vertexIdV,uvV,uvIdV,needOwnContainer);
			}
			vertexIdV=_vertexIdV;
		}
		public function get focalLength():Number{
			throw new Error("未处理");
			return -1;
		}
		public function render(container:*):void{
			if(bmd||bmdArr){
				throw new Error("未处理");
			}else{
				if(lineColor>=0||fillColor>=0){
				}else{
					throw new Error("请设置贴图或线型或填充");
				}
				var g:Graphics=container.graphics;
				if(lineColor>=0){
					g.lineStyle(lineThickness,lineColor,lineAlpha);
				}
				if(fillColor>=0){
					g.beginFill(fillColor,fillAlpha);
				}
				if(fastRender){
					if(markLine){
						var i:int=fastRenderVertexV.length;
						if(i%4){
							throw new Error("未处理");
						}else{
							while(i){
								i-=4;
								g.moveTo(fastRenderVertexV[i],fastRenderVertexV[i+1]);
								g.lineTo(fastRenderVertexV[i+2],fastRenderVertexV[i+3]);
							}
						}
					}else{
						g.drawTriangles(fastRenderVertexV);
					}
				}else{
					g.drawTriangles(screenVertexV,vertexIdV,null,TriangleCulling.POSITIVE);
				}
			}
		}
		override public function project(camera3D:Camera3D,ruV:Vector.<IRenderUnit>):void{
			var _bmd:BitmapData;
			if(bmd){
				_bmd=bmd;
			}else if(bmdArr){
				if(++currBmdId>=bmdArr.length){
					currBmdId=0;
				}
				_bmd=bmdArr[currBmdId];
			}else{
				_bmd=null;
			}
			updateVertexVs(camera3D);
			var triangle:Triangle;
			if(needTriangles){
				for each(triangle in triangleV){
					triangle.vertexV[0]=screenVertexV[triangle.meshVertexId1*2];
					triangle.vertexV[1]=screenVertexV[triangle.meshVertexId1*2+1];
					triangle.vertexV[2]=screenVertexV[triangle.meshVertexId2*2];
					triangle.vertexV[3]=screenVertexV[triangle.meshVertexId2*2+1];
					triangle.vertexV[4]=screenVertexV[triangle.meshVertexId3*2];
					triangle.vertexV[5]=screenVertexV[triangle.meshVertexId3*2+1];
					
					if(triangle.isFront){
						triangle.__focalLength=(focalLengthV[triangle.meshVertexId1]+focalLengthV[triangle.meshVertexId2]+focalLengthV[triangle.meshVertexId3])/3;
						if(triangle.__focalLength>0){
							if(needHighLight){
								triangle.getHighLight(cameraMatrix3D);
							}
							if(lineColor>=0){
								triangle.lineThickness=lineThickness;
								triangle.lineColor=lineColor;
								triangle.lineAlpha=lineAlpha;
							}
							if(_bmd){
								triangle.bmd=_bmd;
							}else if(fillColor>=0){
								triangle.fillColor=fillColor;
								triangle.fillAlpha=fillAlpha;
							}
							ruV[ruV.length]=triangle;//添加到渲染列表
							continue;
						}
					}
					triangle.clearGraphics();
				}
			}else{
				//如果不用贴图，这样应该会快点？
				ruV[ruV.length]=this;//添加到渲染列表
				if(fastRender){
					if(markLine){
						var lineMark:Object=new Object();
					}
					fastRenderVertexV=new Vector.<Number>();
					var vertex0_x:int;
					var vertex0_y:int;
					var vertex1_x:int;
					var vertex1_y:int;
					var vertex2_x:int;
					var vertex2_y:int;
					var dx:Number;
					var dy:Number;
					var i:int=0;
					for each(triangle in triangleV){
						triangle.vertexV[0]=vertex0_x=Math.round(screenVertexV[triangle.meshVertexId1*2]*10);
						triangle.vertexV[1]=vertex0_y=Math.round(screenVertexV[triangle.meshVertexId1*2+1]*10);
						triangle.vertexV[2]=vertex1_x=Math.round(screenVertexV[triangle.meshVertexId2*2]*10);
						triangle.vertexV[3]=vertex1_y=Math.round(screenVertexV[triangle.meshVertexId2*2+1]*10);
						triangle.vertexV[4]=vertex2_x=Math.round(screenVertexV[triangle.meshVertexId3*2]*10);
						triangle.vertexV[5]=vertex2_y=Math.round(screenVertexV[triangle.meshVertexId3*2+1]*10);
						if(triangle.isFront){
							continue;
						}
						
						if(markLine){
							//好像把一些双面去掉了
							var key:String;
							
							key=getKeyAndCheckDistance(vertex0_x,vertex0_y,vertex1_x,vertex1_y);
							if(key){
								if(lineMark[key]){
								}else{
									lineMark[key]=true;
									fastRenderVertexV[i++]=vertex0_x/10;
									fastRenderVertexV[i++]=vertex0_y/10;
									fastRenderVertexV[i++]=vertex1_x/10;
									fastRenderVertexV[i++]=vertex1_y/10;
								}
							}
							
							key=getKeyAndCheckDistance(vertex1_x,vertex1_y,vertex2_x,vertex2_y);
							if(key){
								if(lineMark[key]){
								}else{
									lineMark[key]=true;
									fastRenderVertexV[i++]=vertex1_x/10;
									fastRenderVertexV[i++]=vertex1_y/10;
									fastRenderVertexV[i++]=vertex2_x/10;
									fastRenderVertexV[i++]=vertex2_y/10;
								}	
							}
							
							key=getKeyAndCheckDistance(vertex0_x,vertex0_y,vertex2_x,vertex2_y);
							if(key){
								if(lineMark[key]){
								}else{
									lineMark[key]=true;
									fastRenderVertexV[i++]=vertex0_x/10;
									fastRenderVertexV[i++]=vertex0_y/10;
									fastRenderVertexV[i++]=vertex2_x/10;
									fastRenderVertexV[i++]=vertex2_y/10;
								}	
							}
						}else{
							fastRenderVertexV[i++]=vertex0_x/10;
							fastRenderVertexV[i++]=vertex0_y/10;
							fastRenderVertexV[i++]=vertex1_x/10;
							fastRenderVertexV[i++]=vertex1_y/10;
							fastRenderVertexV[i++]=vertex2_x/10;
							fastRenderVertexV[i++]=vertex2_y/10;
						}
					}
				}
			}
		}
		private function getKeyAndCheckDistance(x0:int,y0:int,x1:int,y1:int):String{
			var dx:Number=x0-x1;
			var dy:Number=y0-y1;
			if(dx*dx+dy*dy<100){
				return null;
			}
			if(x0<x1){
				return x0+","+y0+","+x1+","+y1;
			}
			return x1+","+y1+","+x0+","+y0;
		}
	}
}

