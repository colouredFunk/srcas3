/***
DAEAdvance 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年9月14日 15:55:09
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.zero3D.objs{
	import zero.zero3D.Obj3DContainer;
	
	import flash.geom.Matrix3D;

	public class DAEAdvance extends Obj3DContainer{
		public function setDrawValues(
			lineColor:int,
			lineThickness:int,
			lineAlpha:Number,
			fillColor:int,
			fillAlpha:Number
		):void{
			for each(var mesh3D:Mesh3D in obj3DV){
				mesh3D.lineColor=lineColor;
				mesh3D.lineThickness=lineThickness;
				mesh3D.lineAlpha=lineAlpha;
				
				mesh3D.fillColor=fillColor;
				mesh3D.fillAlpha=fillAlpha;
			}
		}
		public var meshMark:Object;
		public function DAEAdvance(){
		}
		public function initByXML(
			daeAdvanceXML:XML,
			bmds:Object=null
		):void{
			meshMark=new Object();
			var geomMeshV:Vector.<Mesh3D>;
			for each(var geometryXML:XML in daeAdvanceXML.children()){
				meshMark[geometryXML.name().toString()]=geomMeshV=new Vector.<Mesh3D>();
				var matrix_str_arr:Array=geometryXML.@matrix.toString().split(",");
				var matrix3D:Matrix3D;
				if(matrix_str_arr.length==12){
					matrix3D=new Matrix3D(Vector.<Number>([
						Number(matrix_str_arr[0]),Number(matrix_str_arr[1]),Number(matrix_str_arr[2]),0,
						Number(matrix_str_arr[3]),Number(matrix_str_arr[4]),Number(matrix_str_arr[5]),0,
						Number(matrix_str_arr[6]),Number(matrix_str_arr[7]),Number(matrix_str_arr[8]),0,
						Number(matrix_str_arr[9]),Number(matrix_str_arr[10]),Number(matrix_str_arr[11]),1
					]));
				}else{
					matrix3D=new Matrix3D();
				}
				
				
				for each(var meshXML:XML in geometryXML.mesh){
					var vertexVXML:XML=meshXML.vertexV[0];
					var uvVXML:XML=meshXML.uvV[0];
					
					var vertexV:Vector.<Number>;
					var vertexIdV:Vector.<int>;
					
					var uvV:Vector.<Number>;
					var uvIdV:Vector.<int>;
					
					var i:int,str:String;
					
					if(vertexVXML){
						var vertexDivisor:int=int(vertexVXML.@divisor.toString());
						if(vertexDivisor>0){
						}else{
							vertexDivisor=1;
						}
						
						vertexV=new Vector.<Number>();
						vertexIdV=new Vector.<int>();
						
						i=0;
						for each(str in vertexVXML.toString().split(",")){
							vertexV[i++]=int(str)/vertexDivisor;
						}
						i=0;
						for each(str in meshXML.vertexIdV[0].toString().split(",")){
							vertexIdV[i++]=int(str);
						}
					}else{
						vertexV=null;
						vertexIdV=null;
						throw new Error("顶点列表不能为空");
					}
					
					if(uvVXML){
						var uvDivisor:int=int(uvVXML.@divisor.toString());
						if(uvDivisor>0){
						}else{
							uvDivisor=1;
						}
						
						uvV=new Vector.<Number>();
						uvIdV=new Vector.<int>();
						
						i=0;
						for each(str in uvVXML.toString().split(",")){
							uvV[i++]=int(str)/uvDivisor;
						}
						i=0;
						for each(str in meshXML.uvIdV[0].toString().split(",")){
							uvIdV[i++]=int(str);
						}
					}else{
						uvV=null;
						uvIdV=null;
					}
						
					var mesh3D:Mesh3D;
					if(bmds){
						mesh3D=new Mesh3D(bmds[meshXML.@materialId.toString()],vertexV,uvV,vertexIdV,uvIdV);
					}else{
						mesh3D=new Mesh3D(null,vertexV,uvV,vertexIdV,uvIdV);
						var lineColorStr:String=meshXML.@lineColor.toString();
						if(lineColorStr){
						}else{
							lineColorStr=geometryXML.@lineColor.toString();
						}
						if(lineColorStr){
							mesh3D.lineColor=int(lineColorStr);
						}else{
							//mesh3D.lineColor=int(Math.random()*0x1000000);
							//mesh3D.lineColor=0xffffff;
						}
					}
					
					mesh3D.matrix3D=matrix3D;
					geomMeshV[geomMeshV.length]=mesh3D;
					addChild(mesh3D);
				}
			}
		}
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