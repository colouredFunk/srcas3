/***
Camera3D 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年2月25日 19:53:21
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.zero3D.cameras{
	import flash.display.*;
	import flash.geom.*;
	import flash.utils.*;
	
	import zero.zero3D.*;
	import zero.zero3D.objs.*;
	public class Camera3D extends Obj3D{
		
		public var scene3D:Scene3D;
		public var dScreen:Number;
		
		override public function clear():void{super.clear();
			scene3D=null;
			cameraMatrix3D=null;
		}
		public function Camera3D(_scene3D:Scene3D,_dScreen:Number=1000){
			scene3D=_scene3D;
			dScreen=_dScreen;
			cameraMatrix3D=new Matrix3D();
			
			matrix3D.rawData=Vector.<Number>([
				0,1,0,0,
				-1,0,0,0,
				0,0,1,0,
				dScreen,0,0,1
			]);//默认摄像机放在 x轴 dScreen 处，正对原点
		}
		public function pointAt(x:Number,y:Number,z:Number):void{
			matrix3D.pointAt(new Vector3D(x,y,z));//发现 Matrix3D.pointAt 是用 y 轴来指向的...不是 z 轴
		}
		public function transform3Ds22Ds(v3Ds:Vector.<Number>,v2Ds:Vector.<Number>,focalLengthV:Vector.<Number>):void{
			var i:int=v3Ds.length/3;
			while(i){
				i--;
				var x:Number=v3Ds[i*3];
				var y:Number=v3Ds[i*3+1];
				var z:Number=v3Ds[i*3+2];
				var k:Number=dScreen/y;
				v2Ds[i*2]=x*k;
				v2Ds[i*2+1]=-z*k;
				if(needFocalLength){
					focalLengthV[i]=Math.sqrt(x*x+y*y+z*z);
					if(k<0){
						focalLengthV[i]*=-1;
					}
				}
			}
		}
		public function output(container:Sprite):void{
			container.graphics.clear();
			
			//trace("output");
			//输出图像到一个容器里
			cameraMatrix3D.rawData=matrix3D.rawData;
			cameraMatrix3D.invert();
			
			scene3D.cameraMatrix3D.rawData=cameraMatrix3D.rawData;
			
			var ruV:Vector.<IRenderUnit>=new Vector.<IRenderUnit>();//渲染列表,用来存储要渲染的单元
			
			//DocClassThis.t=getTimer();
			scene3D.project(this,ruV);
			//DocClassThis.txt.text+="project 耗时: "+(getTimer()-DocClassThis.t)+" 毫秒\n";
			
			if(needFocalLength){
				//DocClassThis.t=getTimer();
				ruV.sort(sortByFocalLength);//按从远到近的顺序排列
				//DocClassThis.txt.text+="sort 耗时: "+(getTimer()-DocClassThis.t)+" 毫秒\n";
			}
			
			//DocClassThis.t=getTimer();
			for each(var ru:IRenderUnit in ruV){
				ru.render(container);//按从远到近的顺序渲染所有要渲染的单元
			}
			//DocClassThis.txt.text+="render 耗时: "+(getTimer()-DocClassThis.t)+" 毫秒\n";
		}
		public function outputByContainerDict(containerDict:Dictionary,graMark:Object=null,containerKeyDict:Dictionary=null):void{
			var obj1:*,obj2:*;
			var container:*;
			for each(container in containerDict){
				var i:int=container.numChildren;
				while(--i>=0){
					container.removeChildAt(i);
				}
			}
			
			var objDict:Dictionary=new Dictionary();
			for(obj1 in containerDict){
				container=containerDict[obj1];
				if(objDict[container]){
				}else{
					objDict[container]=new Array();
				}
				objDict[container].push(obj1);
			}
			
			//DocClassThis.txt.text+="输出前: "+(getTimer()-DocClassThis.t)+"毫秒\n";
			//DocClassThis.t=getTimer();
			
			for(container in objDict){
				for(obj2 in containerDict){
					(obj2 as Obj3D).visible=false;
				}
				for each(obj1 in objDict[container]){
					obj1.visible=true;
				}
				output(container);
				
				//DocClassThis.txt.text+="输出: "+(getTimer()-DocClassThis.t)+"毫秒\n";
				//DocClassThis.t=getTimer();
				
				/*
				if(graMark&&containerKeyDict){
					//记录渲染过的，以便下次直接读取(经实验发现很耗内存...)
					var key:String=containerKeyDict[container];
					if(key){
						var gra:Shape=graMark[key];
						if(gra){
						}else{
							graMark[key]=gra=new Shape();
							output(gra);
						}
						container.addChild(gra);
						continue;
					}
				}
				*/
			}
		}
		private function sortByFocalLength(ru1:IRenderUnit,ru2:IRenderUnit):Number{
			return ru2.focalLength-ru1.focalLength;//把远的放在 ruV 前面
		}
	}
}

