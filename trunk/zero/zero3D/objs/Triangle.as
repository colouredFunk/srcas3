/***
Triangle 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年2月26日 16:46:05
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.zero3D.objs{
	import zero.zero3D.*;
	
	import flash.display.*;
	import flash.geom.*;
	public class Triangle implements IRenderUnit{
		public var needOwnContainer:Boolean;
		
		public var bmd:BitmapData;
		
		public var lineThickness:int=1;
		public var lineColor:int=-1;
		public var lineAlpha:Number=1;
		
		public var fillColor:int=-1;
		public var fillAlpha:Number=1;
		
		public var vertexV:Vector.<Number>;
		public var uvV:Vector.<Number>;
		
		public var mv:Vector3D;//法向量
		public var p0:Vector3D;//重心
		
		public var meshVertexId1:int;
		public var meshVertexId2:int;
		public var meshVertexId3:int;
		
		public var highlight:Number;
		
		private var sp:Sprite;
		
		public function clear():void{
			bmd=null;
			vertexV=null;
			uvV=null;
			mv=null;
			p0=null;
		}
		public function Triangle(
			id1:int,id2:int,id3:int,
			meshVertexV:Vector.<Number>,
			meshVertexIdV:Vector.<int>,
			meshUvV:Vector.<Number>,
			meshUvIdV:Vector.<int>,
			_needOwnContainer:Boolean
		){
			//三角面
			meshVertexId1=meshVertexIdV[id1];
			meshVertexId2=meshVertexIdV[id2];
			meshVertexId3=meshVertexIdV[id3];
			
			var x1:Number=meshVertexV[meshVertexId1*3];
			var y1:Number=meshVertexV[meshVertexId1*3+1];
			var z1:Number=meshVertexV[meshVertexId1*3+2];
			
			var x2:Number=meshVertexV[meshVertexId2*3];
			var y2:Number=meshVertexV[meshVertexId2*3+1];
			var z2:Number=meshVertexV[meshVertexId2*3+2];
			
			var x3:Number=meshVertexV[meshVertexId3*3];
			var y3:Number=meshVertexV[meshVertexId3*3+1];
			var z3:Number=meshVertexV[meshVertexId3*3+2];
			
			mv=new Vector3D(x1-x2,y1-y2,z1-z2).crossProduct(new Vector3D(x2-x3,y2-y3,z2-z3));
			mv.normalize();
			
			p0=new Vector3D((x1+x2+x3)/3,(y1+y2+y3)/3,(z1+z2+z3)/3);
			
			vertexV=new Vector.<Number>(6);
			
			if(meshUvV){
				var meshUvId1:int=meshUvIdV[id1]*2;
				var meshUvId2:int=meshUvIdV[id2]*2;
				var meshUvId3:int=meshUvIdV[id3]*2;
				
				uvV=Vector.<Number>([
					meshUvV[meshUvId1],
					meshUvV[meshUvId1+1],
					meshUvV[meshUvId2],
					meshUvV[meshUvId2+1],
					meshUvV[meshUvId3],
					meshUvV[meshUvId3+1]
				]);
			}else{
				//如果是线框模型可以不用uv
				uvV=null;
			}
			
			needOwnContainer=_needOwnContainer;
			
			if(needOwnContainer){
				sp=new Sprite();//渲染用
			}
		}
		public function get isFront():Boolean{
			return (vertexV[0]-vertexV[2])*(vertexV[1]-vertexV[5])-(vertexV[1]-vertexV[3])*(vertexV[0]-vertexV[4])<0;//三角形三个顶点投影到屏幕后为逆时针方向的为正面
		}
		public function getHighLight(cameraMatrix3D:Matrix3D):void{
			//计算高光值
			var cameraSv:Vector3D=cameraMatrix3D.transformVector(p0);
			cameraSv.normalize();//摄像机指向该三角面重心的单位向量
			var cameraMv:Vector3D=cameraMatrix3D.deltaTransformVector(mv);//转到摄像机中描述的该三角面的法向量
			
			highlight=-cameraMv.dotProduct(cameraSv);
			if(highlight<0.5){
				highlight=0.5;
			}else if(highlight>1){
				highlight=1;
			}
		}
		
		
		public var __focalLength:Number;
		public function get focalLength():Number{
			return __focalLength;
		}
		
		public function render(container:*):void{
			var g:Graphics;
			if(needOwnContainer){
				container.addChild(sp);
				g=sp.graphics;
				g.clear();
			}else{
				g=container.graphics;
			}
			
			if(lineColor>=0){
				g.lineStyle(lineThickness,lineColor,lineAlpha);
			}
			if(bmd){
				g.beginBitmapFill(bmd);
			}else if(fillColor>=0){
				g.beginFill(fillColor,fillAlpha);
			}
			g.drawTriangles(vertexV,null,uvV);
			if(bmd){
				g.endFill();
			}
			
			if(needOwnContainer){
				if(Obj3D.needHighLight){
					sp.transform.colorTransform=new ColorTransform(highlight,highlight,highlight,1,0,0,0,0);
				}
			}
		}
		
		public function clearGraphics():void{
			if(sp){
				sp.graphics.clear();
			}
		}
	}
}

