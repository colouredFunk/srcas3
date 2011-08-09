/***
Obj3DContainer 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年2月25日 19:53:07
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.zero3D{
	import zero.zero3D.cameras.*;
	import zero.zero3D.objs.*;
	public class Obj3DContainer extends Obj3D{
		public var obj3DV:Vector.<Obj3D>;//所有的子系统
		override public function clear():void{super.clear();
			for each(var obj3D:Obj3D in obj3DV){
				obj3D.clear();
			}
			obj3DV=null;
		}
		public function Obj3DContainer(){
			obj3DV=new Vector.<Obj3D>();
		}
		override public function project(camera3D:Camera3D,ruV:Vector.<IRenderUnit>):void{
			for each(var obj3D:Obj3D in obj3DV){
				if(obj3D.visible){
					obj3D.cameraMatrix3D.rawData=obj3D.matrix3D.rawData;
					obj3D.cameraMatrix3D.append(cameraMatrix3D);//obj3D 连接上 obj3D父级(也就是 this) 的 cameraMatrix3D
					obj3D.project(camera3D,ruV);
				}
			}
		}
		
		public function addChild(obj3D:Obj3D):void{
			//添加子系统
			var id:int=obj3DV.indexOf(obj3D);
			if(id>=0){
				throw new Error("重复的 obj3D : "+obj3D);
			}else{
				obj3DV[obj3DV.length]=obj3D;
			}
		}
		public function removeChild(obj3D:Obj3D):void{
			//删除子系统
			var id:int=obj3DV.indexOf(obj3D);
			if(id>=0){
				obj3DV.splice(id,1);
			}else{
				throw new Error("找不到 obj3D : "+obj3D);
			}
		}
		public function removeAll():void{
			obj3DV=new Vector.<Obj3D>();
		}
	}
}

