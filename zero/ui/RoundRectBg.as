/***
RoundRectBg 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年4月9日 09:41:27
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.ui{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.utils.*;
	
	import mx.events.*;
	
	public class RoundRectBg extends Sprite{
		public static var bottomBg:RoundRectBg;
		public static var bgV:Vector.<RoundRectBg>=new Vector.<RoundRectBg>();
		private static const bmd0:BitmapData=new BitmapData(1,1,false,0x003300);
		public var bmd:BitmapData;
		public var wid:int=200;
		public var hei:int=200;
		private var ellipseWidth:Number=10;
		private var ellipseHeight:Number=10;
		
		
		private var holeContainer:Sprite;
		
		public function RoundRectBg(){
			holeContainer=new Sprite();
			holeContainer.blendMode=BlendMode.ERASE;
			this.addChild(holeContainer);
			this.addEventListener(Event.ADDED_TO_STAGE,added);
		}
		private function added(event:Event):void{
			this.removeEventListener(Event.ADDED_TO_STAGE,added);
			this.addEventListener(Event.REMOVED_FROM_STAGE,removed);
			bgV.push(this);
			//trace("bgV="+bgV.length);
			
			this.blendMode=BlendMode.LAYER;//方便挖孔
		}
		private function removed(event:Event):void{
			this.removeEventListener(Event.REMOVED_FROM_STAGE,removed);
			if(bmd){
				bmd.dispose();
			}
			bgV.splice(bgV.indexOf(this),1);
			holeContainer=null;
		}
		public function updateByValues(valueObj:Object):void{
			for(var valueName:String in valueObj){
				this[valueName]=valueObj[valueName];
			}
			var g:Graphics=this.graphics;
			g.clear();
			g.beginBitmapFill(bmd||bmd0);
			//trace(wid,hei,ellipseWidth,ellipseHeight);
			g.drawRoundRect(0,0,wid,hei,ellipseWidth,ellipseHeight);
			g.endFill();
			//trace("updateByValues wid="+wid+",hei="+hei);
		}
		public function addHole(valueObjOrSp:*):Sprite{
			//挖孔
			//trace("addHole");
			var sp:Sprite;
			if(valueObjOrSp is Sprite){
				sp=valueObjOrSp;
			}else{
				sp=new Sprite();
				var g:Graphics=sp.graphics;
				g.clear();
				g.beginFill(0xff0000);
				g[valueObjOrSp.funName].apply(g,valueObjOrSp.args);
				g.endFill();
			}
			holeContainer.addChild(sp);
			return sp;
		}
		
		private static var holeAtBottom_dict:Dictionary=new Dictionary();
		public static function addHoleAtBottom(
			obj:Object,
			bgHoleD:int,
			bg:RoundRectBg,
			addEvent:Boolean
		):Sprite{
			if(addEvent){
				obj.addEventListener(Event.REMOVED_FROM_STAGE,holeAtBottom_removed);
				obj.addEventListener(MoveEvent.MOVE,holeAtBottom_move);
				obj.addEventListener(ResizeEvent.RESIZE,holeAtBottom_move);
			}
			var bgHole:Sprite=new Sprite();
			bg||(bg=bottomBg);
			bg.addHole(bgHole);
			holeAtBottom_dict[obj]={bg:bg,bgHole:bgHole,bgHoleD:bgHoleD};
			holeAtBottom_move_obj(obj);
			return bgHole;
		}
		private static function holeAtBottom_removed(event:Event):void{
			var obj:Object=event.target;
			obj.removeEventListener(Event.REMOVED_FROM_STAGE,holeAtBottom_removed);
			obj.removeEventListener(MoveEvent.MOVE,holeAtBottom_move);
			obj.removeEventListener(ResizeEvent.RESIZE,holeAtBottom_move);
			var dict_obj:Object=holeAtBottom_dict[obj];
			dict_obj.bgHole.parent.removeChild(dict_obj.bgHole);
			delete holeAtBottom_dict[obj];
		}
		public static function holeAtBottom_updateHole(hole:Sprite,x:Number,y:Number,wid:Number,hei:Number,d:Number):void{
			var g:Graphics=hole.graphics;
			g.clear();
			g.beginFill(0xff0000);
			g.drawRoundRect(x-d,y-d,wid+d*2,hei+d*2,d);
			g.endFill();
		}
		private static function holeAtBottom_move(event:Event):void{
			holeAtBottom_move_obj(event.target);
		}
		private static function holeAtBottom_move_obj(obj:Object):void{
			var dict_obj:Object=holeAtBottom_dict[obj];
			holeAtBottom_updateHole(
				dict_obj.bgHole,
				obj.x,
				obj.y,
				obj.width,
				obj.height,
				dict_obj.bgHoleD
			);
			
			/*
			var b:Rectangle=obj.getBounds(dict_obj.bg);
			trace("b="+b);
			holeAtBottom_updateHole(
				dict_obj.bgHole,
				b.x,
				b.y,
				b.width,
				b.height,
				dict_obj.bgHoleD
			);
			*/
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