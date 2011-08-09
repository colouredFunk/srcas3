/***
Axiss 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年2月25日 21:00:23
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.zero3D.objs{
	import zero.zero3D.*;
	import zero.zero3D.cameras.*;
	
	import flash.display.*;
	public class Axiss extends VerticesObj3D implements IRenderUnit{
		private var sprite:Sprite;
		public function Axiss(len:Number){
			//用红绿蓝三色绘制的坐标轴,主要用来显示坐标系的状态
			sprite=new Sprite();
			super(Vector.<Number>([
				0,0,0,
				len,0,0,
				0,len,0,
				0,0,len
			]));
		}
		override public function project(camera3D:Camera3D,ruV:Vector.<IRenderUnit>):void{
			updateVertexVs(camera3D);
			if(needFocalLength){
				if(focalLength>0){
					ruV[ruV.length]=this;//添加到渲染列表
				}
			}else{
				ruV[ruV.length]=this;//添加到渲染列表
			}
		}
		public function get focalLength():Number{
			return focalLengthV[0];//以原点的 focalLength 作为 focalLength
		}
		
		public function render(container:*):void{
			container.addChild(sprite);
			var g:Graphics=sprite.graphics;
			
			g.clear();
			g.lineStyle(1,0xff0000);
			g.moveTo(screenVertexV[0],screenVertexV[1]);
			g.lineTo(screenVertexV[2],screenVertexV[3]);
			g.lineStyle(1,0x00ff00);
			g.moveTo(screenVertexV[0],screenVertexV[1]);
			g.lineTo(screenVertexV[4],screenVertexV[5]);
			g.lineStyle(1,0x0000ff);
			g.moveTo(screenVertexV[0],screenVertexV[1]);
			g.lineTo(screenVertexV[6],screenVertexV[7]);
		}
	}
}

