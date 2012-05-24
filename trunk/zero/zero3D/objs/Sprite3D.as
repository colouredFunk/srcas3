/***
Sprite3D 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年3月25日 18:12:02
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.zero3D.objs{
	import flash.display.*;
	
	import zero.zero3D.cameras.*;
	public class Sprite3D extends VerticesObj3D implements IRenderUnit{
		public var sprite:Sprite;
		private var needScale:Boolean;
		public function Sprite3D(_sprite:Sprite,_needScale:Boolean=true){
			needScale=_needScale;
			//3d 场景中的 Sprite
			sprite=_sprite;
			super(new <Number>[
				0,0,0
			]);
		}
		override public function project(camera3D:Camera3D,ruV:Vector.<IRenderUnit>):void{
			updateVertexVs(camera3D);
			
			var scale:Number=camera3D.dScreen/focalLength;
			if(scale>0&&scale<10){
				ruV[ruV.length]=this;//添加到渲染列表
				if(needScale){
					sprite.scaleX=sprite.scaleY=scale;
				}
			}
		}
		public function get focalLength():Number{
			return focalLengthV[0];//以原点的 focalLength 作为 focalLength
		}
		public function render(container:*):void{
			(container as Sprite).addChild(sprite);
			sprite.x=screenVertexV[0];
			sprite.y=screenVertexV[1];
		}
	}
}

