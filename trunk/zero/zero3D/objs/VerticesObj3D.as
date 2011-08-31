/***
VerticesObj3D 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年2月26日 15:14:16
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.zero3D.objs{
	import zero.zero3D.*;
	import zero.zero3D.cameras.*;
	public class VerticesObj3D extends Obj3D{
		public var vertexV:Vector.<Number>;//模型空间中描述的顶点列表
		public var cameraVertexV:Vector.<Number>;//到到到到到的顶点列表
		public var screenVertexV:Vector.<Number>;//屏幕上描述的顶点列表,每两个作为一个顶点,分别是 x,y;
		public var focalLengthV:Vector.<Number>;//每对 screenVertexV 中的顶点都有一个对应的 focalLength
		override public function clear():void{super.clear();
			vertexV=null;
			cameraVertexV=null;
			screenVertexV=null;
			focalLengthV=null;
		}
		public function VerticesObj3D(_vertexV:Vector.<Number>){
			vertexV=_vertexV;
			cameraVertexV=new Vector.<Number>(vertexV.length);
			screenVertexV=new Vector.<Number>(vertexV.length*2/3);
			focalLengthV=new Vector.<Number>(vertexV.length/3);
			//由若干个顶点组成的3d物体
		}
		public function updateVertexVs(camera3D:Camera3D):void{
			cameraMatrix3D.transformVectors(vertexV,cameraVertexV);//模型空间中描述的顶点转换到模型空间中描述
			camera3D.transform3Ds22Ds(cameraVertexV,screenVertexV,focalLengthV);//模型空间中描述的顶点转换到屏幕上描述
		}
		/*
		public function getFocalLengthByScreenVertexV():Number{
			//取所有顶点的 focalLength 的平均值
			var sum:Number=0;
			var i:int=focalLengthV.length;
			while(--i>=0){
				sum+=focalLengthV[i];
			}
			return sum/focalLengthV.length;
		}
		//*/
	}
}

