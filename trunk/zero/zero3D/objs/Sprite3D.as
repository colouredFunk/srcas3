/***
Sprite3D 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年3月25日 18:12:02
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.zero3D.objs{
	import zero.zero3D.cameras.*;
	import flash.display.*;
	public class Sprite3D extends VerticesObj3D implements IRenderUnit{
		public var sprite:Sprite;
		public function Sprite3D(_sprite:Sprite){
			//3d 场景中的 Sprite
			sprite=_sprite;
			super(Vector.<Number>([
				0,0,0,
				0,
			]));
		}
		override public function project(camera3D:Camera3D,ruV:Vector.<IRenderUnit>):void{
			updateVertexVs(camera3D);
			//if(needFocalLength){
				var scale:Number=camera3D.dScreen/focalLength;
				if(scale>0&&scale<10){
					ruV[ruV.length]=this;//添加到渲染列表
					sprite.scaleX=sprite.scaleY=scale;
				}
			//}else{
				//throw new Error("needFocalLength="+needFocalLength);
			//}
		}
		public function get focalLength():Number{
			return focalLengthV[0];//以原点的 focalLength 作为 focalLength
		}
		public function render(container:Sprite):void{
			container.addChild(sprite);
			sprite.x=screenVertexV[0];
			sprite.y=screenVertexV[1];
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