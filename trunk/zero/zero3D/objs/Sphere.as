/***
Sphere 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年12月29日 16:37:21
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.zero3D.objs{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	
	import zero.ZeroGIFBmd;
	
	public class Sphere extends Mesh3D{
		
		private var r:Number;
		
		private var segW:int=24;
		private var segH:int=24;
		
		public function Sphere(_r:Number,bmd:BitmapData){
			var vertexV:Vector.<Number>=new Vector.<Number>();
			var uvV:Vector.<Number>=new Vector.<Number>();
			var vertexIdV:Vector.<int>=new Vector.<int>();
			var uvIdV:Vector.<int>=new Vector.<int>();
			
			/*
			vertexV[0]=0;
			vertexV[1]=0;
			vertexV[2]=0;
			
			vertexV[3]=100;
			vertexV[4]=0;
			vertexV[5]=0;
			
			vertexV[6]=100;
			vertexV[7]=100;
			vertexV[8]=0;
			
			uvV[0]=0;
			uvV[1]=0;
			
			uvV[2]=1;
			uvV[3]=0;
			
			uvV[4]=1;
			uvV[5]=1;
			
			vertexIdV[0]=0;
			vertexIdV[1]=1;
			vertexIdV[2]=2;
			
			uvIdV=vertexIdV;
			*/
			
			r=_r;
			var i:int,j:int;
			for(i=0;i<=segH;i++){
				var v:Number=i/segH;
				var radH:Number=Math.PI*v;
				var z:Number=r*Math.cos(radH);
				var rw:Number=r*Math.sin(radH);//纬圆半径
				for(j=0;j<=segW;j++){
					var u:Number=j/segW;
					var radW:Number=Math.PI*2*u;
					var x:Number=rw*Math.cos(radW);
					var y:Number=rw*Math.sin(radW);
					vertexV.push(x,y,z);
					uvV.push(u,v);
				}
			}
			for(i=0;i<segH;i++){
				for(j=0;j<segW;j++){
					var id0:int=(segW+1)*i+j;
					var id1:int=(segW+1)*i+(1+j)%(segW+1);
					var id2:int=(segW+1)*(i+1)+(1+j)%(segW+1);
					var id3:int=(segW+1)*(i+1)+j;
					//trace(id0,id1,id2,id3);
					if(i==0){
					}else{
						vertexIdV.push(id1,id0,id3);
					}
					if(i==segH-1){
					}else{
						vertexIdV.push(id3,id2,id1);
					}
					//trace(vertexV[id1*3],vertexV[id1*3+1],vertexV[id1*3+2]);
					//trace(vertexV[id0*3],vertexV[id0*3+1],vertexV[id0*3+2]);
					//trace(vertexV[id3*3],vertexV[id3*3+1],vertexV[id3*3+2]);
				}
			}
			
			uvIdV=vertexIdV;
			
			super(
				bmd,
				vertexV,
				uvV,
				vertexIdV,
				uvIdV
			);
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