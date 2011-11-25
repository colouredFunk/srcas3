/***
Obj3D 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年2月25日 19:52:32
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.zero3D{
	import zero.zero3D.cameras.*;
	import zero.zero3D.objs.*;
	
	import flash.geom.*;
	public class Obj3D{
		public static var needHighLight:Boolean=false;
		public static var needFocalLength:Boolean=true;
		
		public var matrix3D:Matrix3D;//点或向量(Vector3D)转到父系统(parent)的转换矩阵
		public var cameraMatrix3D:Matrix3D;//点或向量(Vector3D)转到摄像机系统(Camera3D)的转换矩阵
		public var visible:Boolean=true;//主要用于标记是否渲染该系统的
		public function clear():void{
			matrix3D=null;
			cameraMatrix3D=null;
		}
		public function Obj3D(){
			matrix3D=new Matrix3D();
			cameraMatrix3D=new Matrix3D();
		}
		public function project(camera3D:Camera3D,ruV:Vector.<IRenderUnit>):void{
			//渲染前的计算,把模型坐标转成摄像机坐标,计算要显示的面等
			trace("请 override 来使用");
		}
		
		public function setXYZ(x:Number,y:Number,z:Number):void{
			//更新位置
			/*var rawData:Vector.<Number>=matrix3D.rawData;
			rawData[12]=x;
			rawData[13]=y;
			rawData[14]=z;
			matrix3D.rawData=rawData;*/
			matrix3D.position=new Vector3D(x,y,z);
		}
		public function get x():Number{
			//return matrix3D.position.x;
			return matrix3D.rawData[12];
		}
		public function get y():Number{
			//return matrix3D.position.y;
			return matrix3D.rawData[13];
		}
		public function get z():Number{
			//return matrix3D.position.z;
			return matrix3D.rawData[14];
		}
		
		public function set x(_x:Number):void{
			//matrix3D.position=new Vector3D(_x,y,z);
			var rawData:Vector.<Number>=matrix3D.rawData;
			rawData[12]=_x;
			matrix3D.rawData=rawData;
		}
		public function set y(_y:Number):void{
			//matrix3D.position=new Vector3D(x,_y,z);
			var rawData:Vector.<Number>=matrix3D.rawData;
			rawData[13]=_y;
			matrix3D.rawData=rawData;
		}
		public function set z(_z:Number):void{
			//matrix3D.position=new Vector3D(x,y,_z);
			var rawData:Vector.<Number>=matrix3D.rawData;
			rawData[14]=_z;
			matrix3D.rawData=rawData;
		}
		
		//设置比例
		public function setScaleXYZ(scaleX:Number,scaleY:Number,scaleZ:Number):void{
			var rawData:Vector.<Number>=matrix3D.rawData;
			rawData[0]=scaleX;
			rawData[5]=scaleY;
			rawData[10]=scaleZ;
			matrix3D.rawData=rawData;
		}
		
		//绕轴旋转
		public function rotatex(degrees:Number):void {
			//自绕x轴转degrees角度
			matrix3D.appendRotation(
				degrees,
				new Vector3D(
					matrix3D.rawData[0],
					matrix3D.rawData[1],
					matrix3D.rawData[2]
				)
			);
		}
		public function rotatey(degrees:Number):void {
			//自绕y轴转degrees角度
			matrix3D.appendRotation(
				degrees,
				new Vector3D(
					matrix3D.rawData[4],
					matrix3D.rawData[5],
					matrix3D.rawData[6]
				)
			);
		}
		public function rotatez(degrees:Number):void {
			//自绕z轴转degrees角度
			matrix3D.appendRotation(
				degrees,
				new Vector3D(
					matrix3D.rawData[8],
					matrix3D.rawData[9],
					matrix3D.rawData[10]
				)
			);
		}
		
		public function setRotaX(degrees:Number):void{
			var rad:Number=degrees*Math.PI/180;
			var c:Number=Math.cos(rad);
			var s:Number=Math.sin(rad);
			matrix3D.rawData=Vector.<Number>([
				1,0,0,0,
				0,c,s,0,
				0,-s,c,0,
				0,0,0,1
			]);
		}
		
		public function setRotaY(degrees:Number):void{
			var rad:Number=degrees*Math.PI/180;
			var c:Number=Math.cos(rad);
			var s:Number=Math.sin(rad);
			matrix3D.rawData=Vector.<Number>([
				c,0,-s,0,
				0,1,0,0,
				s,0,c,0,
				0,0,0,1
			]);
		}
		
		public function setRotaZ(degrees:Number):void{
			var rad:Number=degrees*Math.PI/180;
			var c:Number=Math.cos(rad);
			var s:Number=Math.sin(rad);
			matrix3D.rawData=Vector.<Number>([
				c,s,0,0,
				-s,c,0,0,
				0,0,1,0,
				0,0,0,1
			]);
		}
		
		public function checkMatrix3D():String{
			var rawData:Vector.<Number>=matrix3D.rawData;
			return "-----------------------------------\n"+
					normalizeNum(rawData[0])+"\t"+normalizeNum(rawData[4])+"\t"+normalizeNum(rawData[8])+"\t"+normalizeNum(rawData[12])+"\n"+
					normalizeNum(rawData[1])+"\t"+normalizeNum(rawData[5])+"\t"+normalizeNum(rawData[9])+"\t"+normalizeNum(rawData[13])+"\n"+
					normalizeNum(rawData[2])+"\t"+normalizeNum(rawData[6])+"\t"+normalizeNum(rawData[10])+"\t"+normalizeNum(rawData[14])+"\n"+
					normalizeNum(rawData[3])+"\t"+normalizeNum(rawData[7])+"\t"+normalizeNum(rawData[11])+"\t"+normalizeNum(rawData[15])+"\n"+
					"-----------------------------------\n";
		}
		private function normalizeNum(num:Number):String{
			var num:Number=Math.round(num*1000)/1000;
			var str:String=num.toString();
			if(str.indexOf(".")>0){
				return str;
			}
			return str+=".000";
		}
	}
}

