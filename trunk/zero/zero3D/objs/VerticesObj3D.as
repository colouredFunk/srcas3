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

//

// 常忘正则表达式
// /^\s*|\s*$/					//前后空白						"\nabc d  e 哈 哈\t \r".replace(/^\s*|\s*$/g,"") === "abc d  e 哈 哈"
// /[\\\/:*?\"<>|]/				//不合法的windows文件名字符集		"\\\/:*?\"<>|\\\/:*哈 哈?\"<>|\\哈 \/:*?\"<>|".replace(/[\\\/:*?\"<>|]/g,"") === "哈 哈哈 "
// /[a-zA-Z_][a-zA-Z0-9_]*/		//合法的变量名(不考虑中文)
// value=value.replace(/[^a-zA-Z0-9_]/g,"").replace(/^[0-9]*/,"");//替换不合法的变量名
// 先把除字母数字下划线的字符去掉,再把开头的数字去掉
// 想不到怎样能用一个正则表达式搞定...

//正则表达式30分钟入门教程		http://www.unibetter.com/deerchao/zhengzhe-biaodashi-jiaocheng-se.htm
//正则表达式用法及实例			http://eskimo.blogbus.com/logs/29095458.html
//常用正则表达式					http://www.williamlong.info/archives/433.html

/*

//常用值

//常用语句块

*/