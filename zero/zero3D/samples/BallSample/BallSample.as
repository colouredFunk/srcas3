/***
BallSample 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年12月29日 16:23:55
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	
	import zero.zero3D.*;
	import zero.zero3D.cameras.*;
	import zero.zero3D.objs.*;
	
	public class BallSample extends Sprite{
		public var scene:Scene3D;
		public var room:Obj3DContainer;
		public var camera:Camera3D;
		
		public var ball_container:Sprite;
		public var front_container:Sprite;
		public var back_container:Sprite;
		
		private var ball:Sphere;
		private var star1:Sprite3D;
		private var star2:Sprite3D;
		
		private var dScreen:int;
		
		public function BallSample(){
			this.addEventListener(Event.ADDED_TO_STAGE,added);
		}
		public function added(event:Event):void{
			this.removeEventListener(Event.ADDED_TO_STAGE,added);
			this.addEventListener(Event.REMOVED_FROM_STAGE,removed);
			
			scene=new Scene3D();
			scene.addChild(room=new Obj3DContainer());
			
			dScreen=1000;
			camera=new Camera3D(scene,dScreen);
			
			ball=new Sphere(250,new WorldMapBmd().bitmapData);
			room.addChild(ball);
			
			star1=new Sprite3D(new Star());
			star1.x=250;
			star1.y=100;
			star1.z=0;
			room.addChild(star1);
			
			star2=new Sprite3D(new Star());
			star2.x=250;
			star2.y=-100;
			star2.z=0;
			room.addChild(star2);
			
			enterFrame(null);
			this.addEventListener(Event.ENTER_FRAME,enterFrame);
		}
		public function removed(event:Event):void{
			this.removeEventListener(Event.REMOVED_FROM_STAGE,removed);
			this.removeEventListener(Event.ENTER_FRAME,enterFrame);
		}
		public function enterFrame(event:Event):void{
			room.rotatey(2);
			
			var containerDict:Dictionary=new Dictionary();
			containerDict[ball]=ball_container;
			if(star1.focalLength>dScreen){
				containerDict[star1]=back_container;
			}else{
				containerDict[star1]=front_container;
			}
			if(star2.focalLength>dScreen){
				containerDict[star2]=back_container;
			}else{
				containerDict[star2]=front_container;
			}
			
			camera.outputByContainerDict(containerDict);
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