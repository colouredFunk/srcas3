/***
ItemUnit 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年12月23日 09:32:02
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.guochang3ds{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.utils.*;
	
	public class ItemUnit{
		private var sp:Sprite;
		
		private var matrix3D_o:Matrix3D;
		private var matrix3D_x:Matrix3D;
		private var matrix3D_y:Matrix3D;
		private var matrix3D_z:Matrix3D;
		
		private var matrix3D_o_rawData:Vector.<Number>;
		private var matrix3D_x_rawData:Vector.<Number>;
		private var matrix3D_y_rawData:Vector.<Number>;
		private var matrix3D_z_rawData:Vector.<Number>;
		
		public function ItemUnit(_sp:Sprite){
			sp=_sp;
			
			//原始状态:
			matrix3D_o=new Matrix3D();
			matrix3D_x=new Matrix3D();
			matrix3D_y=new Matrix3D();
			matrix3D_z=new Matrix3D();
			
			matrix3D_o_rawData=matrix3D_o.rawData;
			matrix3D_x_rawData=matrix3D_x.rawData;
			matrix3D_y_rawData=matrix3D_y.rawData;
			matrix3D_z_rawData=matrix3D_z.rawData;
			
			x=sp.x;
			y=sp.y;
			z=0;
			rotationX=0;
			rotationY=0;
			rotationZ=0;
			//
			
			update();
		}
		
		//
		private var __x:Number;
		public function get x():Number{
			return __x;
		}
		public function set x(_x:Number):void{
			__x=_x;
			matrix3D_o_rawData[12]=_x;
			matrix3D_o.rawData=matrix3D_o_rawData;
		}
		
		//
		private var __y:Number;
		public function get y():Number{
			return __y;
		}
		public function set y(_y:Number):void{
			__y=_y;
			matrix3D_o_rawData[13]=_y;
			matrix3D_o.rawData=matrix3D_o_rawData;
		}
		
		//
		private var __z:Number;
		public function get z():Number{
			return __z;
		}
		public function set z(_z:Number):void{
			__z=_z;
			matrix3D_o_rawData[14]=_z;
			matrix3D_o.rawData=matrix3D_o_rawData;
		}
		
		//初始状态为原始状态，绕 x 轴自转 _rotationX 角度
		private var __rotationX:Number;
		public function get rotationX():Number{
			return __rotationX;
		}
		public function set rotationX(_rotationX:Number):void{
			__rotationX=_rotationX;
			var rad:Number=_rotationX*Math.PI/180;
			var c:Number=Math.cos(rad);
			var s:Number=Math.sin(rad);
			
			matrix3D_x_rawData[5]=c;
			matrix3D_x_rawData[6]=s;
			matrix3D_x_rawData[9]=-s;
			matrix3D_x_rawData[10]=c;
			matrix3D_x.rawData=matrix3D_x_rawData;
		}
		////
		
		//初始状态为原始状态，绕 y 轴自转 _rotationY 角度
		private var __rotationY:Number;
		public function get rotationY():Number{
			return __rotationY;
		}
		public function set rotationY(_rotationY:Number):void{
			__rotationY=_rotationY;
			var rad:Number=_rotationY*Math.PI/180;
			var c:Number=Math.cos(rad);
			var s:Number=Math.sin(rad);
			
			matrix3D_y_rawData[10]=c;
			matrix3D_y_rawData[8]=s;
			matrix3D_y_rawData[2]=-s;
			matrix3D_y_rawData[0]=c;
			matrix3D_y.rawData=matrix3D_y_rawData;
		}
		////
		
		//初始状态为原始状态，绕 z 轴自转 _rotationZ 角度
		private var __rotationZ:Number;
		public function get rotationZ():Number{
			return __rotationZ;
		}
		public function set rotationZ(_rotationZ:Number):void{
			__rotationZ=_rotationZ;
			var rad:Number=_rotationZ*Math.PI/180;
			var c:Number=Math.cos(rad);
			var s:Number=Math.sin(rad);
			
			matrix3D_z_rawData[0]=c;
			matrix3D_z_rawData[1]=s;
			matrix3D_z_rawData[4]=-s;
			matrix3D_z_rawData[5]=c;
			matrix3D_z.rawData=matrix3D_z_rawData;
		}
		////
		
		public function update():void{
			var matrix3D:Matrix3D=matrix3D_x.clone();//最里面是 z 矩阵
			matrix3D.append(matrix3D_y);
			matrix3D.append(matrix3D_z);
			matrix3D.append(matrix3D_o);//最外面是 o 矩阵
			
			sp.transform.matrix3D=matrix3D;
			
			//
			//x++;
			//rotationX++;
			//update();
			//这样就可以一边绕 x 轴自转一边向右平移了
		}
	}
}

