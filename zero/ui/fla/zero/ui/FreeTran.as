/***
FreeTran 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2009年11月23日 13:22:02
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.ui{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	import flash.geom.*;
	import flash.ui.*;
	public class FreeTran extends Sprite{
		private static const TYPE_ROTATE:String="rotate";
		private static const TYPE_SKEW:String="skew";
		private static const TYPE_SCALE:String="scale";
		private static const TYPE_DRAG:String="drag";
		
		private var rotateArea:Sprite;
		private var skewArea:Sprite;
		private var dragArea:MovieClip;
		private var scaleArea:Sprite;
		private var userMouse:MovieClip;
		private var currTarget:MovieClip;
		
		private var oldMouseX:Number;
		private var oldMouseY:Number;
		
		private var rotateDotArr:Array;
		private var skewDotArr:Array;
		private var scaleDotArr:Array;
		
		public var minScale:Number=NaN;
		public var maxScale:Number=NaN;
		
		public var onTran:Function;
		public var onStartTran:Function;
		public var onStopTran:Function;
		
		public function FreeTran(){
			rotateArea=this.getChildAt(0) as Sprite;
			skewArea=this.getChildAt(1) as Sprite;
			dragArea=this.getChildAt(2) as MovieClip;
			scaleArea=this.getChildAt(3) as Sprite;
			userMouse=this.getChildAt(4) as MovieClip;
			updateUserMouse("");
			this.visible=false;
			this.addEventListener(Event.ADDED_TO_STAGE,added);
		}
		private function added(event:Event):void{
			this.removeEventListener(Event.ADDED_TO_STAGE,added);
			this.addEventListener(Event.REMOVED_FROM_STAGE,removed);
			
			stage.addEventListener(MouseEvent.MOUSE_MOVE,mouseMove);
			stage.addEventListener(MouseEvent.MOUSE_UP,mouseUp);
			userMouse.mouseEnabled=userMouse.mouseChildren=false;
			
			rotateDotArr=new Array();
			initArea(rotateArea,TYPE_ROTATE,rotateDotArr);
			
			skewDotArr=new Array();
			initArea(skewArea,TYPE_SKEW,skewDotArr);
			
			scaleDotArr=new Array();
			initArea(scaleArea,TYPE_SCALE,scaleDotArr);
			
			initTarget(dragArea,TYPE_DRAG);
		}
		private function removed(event:Event):void{
			this.removeEventListener(Event.REMOVED_FROM_STAGE,removed);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE,mouseMove);
			stage.removeEventListener(MouseEvent.MOUSE_UP,mouseUp);
			
			clearTarget(dragArea);
			
			clearArea(rotateArea);
			clearArea(scaleArea);
			
			rotateArea=null;
			skewArea=null;
			dragArea=null;
			scaleArea=null;
			userMouse=null;
			currTarget=null;
			
			rotateDotArr=null;
			skewDotArr=null;
			scaleDotArr=null;
			
			onTran=null;
			onStartTran=null;
			onStopTran=null;
			
			Mouse.show();
		}
		
		private var __pic:DisplayObject;
		public function setPic(_pic:DisplayObject,drag:Boolean=false):void{
			__pic=_pic;
			if(__pic){
				updateByPic();
				
				this.visible=true;
				if(drag){
					currTarget=dragArea;
					updateUserMouse(currTarget.type);
					oldMouseX=this.parent.mouseX;
					oldMouseY=this.parent.mouseY;
				}
			}else{
				this.visible=false;
			}
		}
		
		public function set rotateEnabled(_rotateEnabled:Boolean):void{
			rotateArea.visible=_rotateEnabled;
		}
		public function set skewEnabled(_skewEnabled:Boolean):void{
			skewArea.visible=_skewEnabled;
		}
		public function set scaleEnabled(_scaleEnabled:Boolean):void{
			scaleArea.visible=_scaleEnabled;
		}
		public function set dragEnabled(_dragEnabled:Boolean):void{
			dragArea.visible=_dragEnabled;
		}
		public var lockScale:Boolean;
		
		private function clearArea(area:Sprite):void{
			var i:int=area.numChildren;
			while(--i>=0){
				clearTarget(area.getChildAt(i) as MovieClip);
			}
		}
		private function clearTarget(target:Sprite):void{
			target.removeEventListener(MouseEvent.MOUSE_OVER,mouseOver);
			target.removeEventListener(MouseEvent.MOUSE_OUT,mouseOut);
			target.removeEventListener(MouseEvent.MOUSE_DOWN,mouseDown);
		}
		private function initArea(area:Sprite,type:String,dotArr:Array):void{
			var i:int=area.numChildren;
			while(--i>=0){
				var dot:MovieClip=area.getChildAt(i) as MovieClip;
				if(dot.x<-1){
					dot.dx=-1;
				}else if(dot.x>1){
					dot.dx=1;
				}else{
					dot.dx=0;
				}
				if(dot.y<-1){
					dot.dy=-1;
				}else if(dot.y>1){
					dot.dy=1;
				}else{
					dot.dy=0;
				}
				initTarget(dot,type);
				
				area["dot"+dot.dx+dot.dy]=dot;
				if(dotArr){
					dotArr[dotArr.length]=dot;
				}
			}
		}
		private function initTarget(target:MovieClip,type:String):void{
			target.addEventListener(MouseEvent.MOUSE_OVER,mouseOver);
			target.addEventListener(MouseEvent.MOUSE_OUT,mouseOut);
			target.addEventListener(MouseEvent.MOUSE_DOWN,mouseDown);
			target.type=type;
		}
		private function mouseMove(event:MouseEvent):void{
			userMouse.x=this.mouseX;
			userMouse.y=this.mouseY;
			if(currTarget){
				var oldPicMatrix:Matrix=null;
				switch(currTarget.type){
					case TYPE_ROTATE:
						this.rotation+=(Math.atan2(this.parent.mouseY-this.y,this.parent.mouseX-this.x)-Math.atan2(oldMouseY-this.y,oldMouseX-this.x))*(180/Math.PI);
					break;
					case TYPE_SCALE:
						if(lockScale){
							oldPicMatrix=__pic.transform.matrix;//防止 __pic 的 matrix 跳变的
							switch(currTarget){
								case scaleArea["dot-1-1"]:
								case scaleArea["dot1-1"]:
								case scaleArea["dot11"]:
								case scaleArea["dot-11"]:
									var otherTarget:Sprite=scaleArea["dot"+(-currTarget.dx)+(-currTarget.dy)];
									var x1:Number=otherTarget.x;
									var y1:Number=otherTarget.y;
									
									var x21:Number=currTarget.x-x1;
									var y21:Number=currTarget.y-y1;
									var xm1:Number=this.mouseX-x1;
									var ym1:Number=this.mouseY-y1;
									
									var k:Number=(x21*xm1+y21*ym1)/(x21*x21+y21*y21);
									
									//if(k>0.1||k<-0.1){
										//trace("k="+k);
										currTarget.x=x1+x21*k;
										currTarget.y=y1+y21*k;
									//}
								break;
								default:
									currTarget.x=this.mouseX;
									currTarget.y=this.mouseY;
								break;
							}
						}else{
							currTarget.x=this.mouseX;
							currTarget.y=this.mouseY;
						}
						updateDotsByCurrDot(currTarget);
						updateDragAreaByDots();
					break;
					case TYPE_DRAG:
						this.x+=this.parent.mouseX-oldMouseX;
						this.y+=this.parent.mouseY-oldMouseY;
					break;
				}
				if(__pic){
					updatePic();
				}
				
				var adjustScale:Boolean=false;
				var pic_scaleX:Number=Math.round(__pic.scaleX*1000)/1000;
				var pic_scaleY:Number=Math.round(__pic.scaleY*1000)/1000;
				if(!isNaN(minScale)){
					/*
					if(pic_scaleX<0&&pic_scaleX>-minScale){
						pic_scaleX=-minScale;
						adjustScale=true;
					}else if(pic_scaleX>=0&&pic_scaleX<minScale){
						pic_scaleX=minScale;
						adjustScale=true;
					}
					if(pic_scaleY<0&&pic_scaleY>-minScale){
						pic_scaleY=-minScale;
						adjustScale=true;
					}else if(pic_scaleY>=0&&pic_scaleY<minScale){
						pic_scaleY=minScale;
						adjustScale=true;
					}
					*/
					if(pic_scaleX<minScale){
						pic_scaleX=minScale;
						adjustScale=true;
					}
					if(pic_scaleY<minScale){
						pic_scaleY=minScale;
						adjustScale=true;
					}
				}
				if(!isNaN(maxScale)){
					if(pic_scaleX<-maxScale){
						pic_scaleX=-maxScale;
						adjustScale=true;
					}else if(pic_scaleX>maxScale){
						pic_scaleX=maxScale;
						adjustScale=true;
					}
					if(pic_scaleY<-maxScale){
						pic_scaleY=-maxScale;
						adjustScale=true;
					}else if(pic_scaleY>maxScale){
						pic_scaleY=maxScale;
						adjustScale=true;
					}
				}
				if(adjustScale){
					__pic.scaleX=pic_scaleX;
					__pic.scaleY=pic_scaleY;
				}
				if(oldPicMatrix){
					var m:Matrix=__pic.transform.matrix;
					if(
						  m.a*oldPicMatrix.a<=0
						  ||
						  m.d*oldPicMatrix.d<=0
					){
						trace("防跳变");
						adjustScale=true;
						__pic.transform.matrix=oldPicMatrix;
						(onTran==null)||onTran(__pic,oldPicMatrix);
					}
				}
				if(adjustScale){
					var x0:Number=this.x;
					var y0:Number=this.y;
					updateByPic();
					this.x=x0;
					this.y=y0;
					updatePic();
				}
				
				oldMouseX=this.parent.mouseX;
				oldMouseY=this.parent.mouseY;
			}
		}
		private function mouseOver(event:MouseEvent):void{
			if(currTarget){
				return;
			}
			var target:MovieClip=event.target as MovieClip;
			switch(target.type){
				case TYPE_ROTATE:
				case TYPE_SCALE:
				case TYPE_DRAG:
					updateUserMouse(target.type);
				break;
			}
		}
		private function mouseOut(event:MouseEvent):void{
			if(currTarget){
				return;
			}
			updateUserMouse("");
		}
		private function mouseDown(event:MouseEvent):void{
			currTarget=event.target as MovieClip;
			switch(currTarget.type){
				case TYPE_ROTATE:
				case TYPE_SCALE:
				case TYPE_DRAG:
					oldMouseX=this.parent.mouseX;
					oldMouseY=this.parent.mouseY;
					(onStartTran==null)||onStartTran(__pic,__pic.transform.matrix);
				break;
			}
		}
		private function mouseUp(event:MouseEvent):void{
			var target:MovieClip=event.target as MovieClip;
			if(target){
				if(target==dragArea){
					updateUserMouse(TYPE_DRAG);
				}else if(target.parent==rotateArea){
					updateUserMouse(TYPE_ROTATE);
				}else if(target.parent==scaleArea){
					updateUserMouse(TYPE_SCALE);
				}else{
					updateUserMouse("");
				}
			}else{
				updateUserMouse("");
			}
			if(currTarget){
				(onStopTran==null)||onStopTran(__pic,__pic.transform.matrix);
				currTarget=null;
			}
		}
		private function updateDotsByCurrDot(currDot:MovieClip):void{
			var dot:MovieClip;
			if(currDot.dx){
				var x:Number=currDot.x*currDot.dx;
				for each(dot in scaleDotArr){
					dot.x=dot.dx*x;
				}
			}
			if(currDot.dy){
				var y:Number=currDot.y*currDot.dy;
				for each(dot in scaleDotArr){
					dot.y=dot.dy*y;
				}
			}
			switch(currDot){
				case scaleArea["dot0-1"]:
					//上面的点调节成左上的点和右上的点中间
					setMidIn2Dot(currDot,scaleArea["dot-1-1"],scaleArea["dot1-1"]);
				break;
				case scaleArea["dot01"]:
					//下面的点调节成左下的点和右下的点中间
					setMidIn2Dot(currDot,scaleArea["dot-11"],scaleArea["dot11"]);
				break;
				case scaleArea["dot-10"]:
					//左面的点调节成左上的点和左下的点中间
					setMidIn2Dot(currDot,scaleArea["dot-1-1"],scaleArea["dot-11"]);
				break;
				case scaleArea["dot10"]:
					//右面的点调节成右上的点和右下的点中间
					setMidIn2Dot(currDot,scaleArea["dot1-1"],scaleArea["dot11"]);
				break;
			}
			updateOtherDotsByScaleDots();
		}
		private function updateOtherDotsByScaleDots():void{
			var dot:MovieClip;
			var scaleDot:MovieClip;
			for each(dot in rotateDotArr){
				scaleDot=scaleArea["dot"+dot.dx+dot.dy];
				dot.x=scaleDot.x;
				dot.y=scaleDot.y;
			}
			for each(dot in skewDotArr){
				scaleDot=scaleArea["dot"+dot.dx+dot.dy];
				dot.x=scaleDot.x;
				dot.y=scaleDot.y;
			}
		}
		private function setMidIn2Dot(dot0:MovieClip,dot1:MovieClip,dot2:MovieClip):void{
			dot0.x=(dot1.x+dot2.x)/2;
			dot0.y=(dot1.y+dot2.y)/2;
		}
		private function updateDragAreaByDots():void{
			var dot0:MovieClip=scaleArea["dot-1-1"];
			var dotx:MovieClip=scaleArea["dot1-1"];
			var doty:MovieClip=scaleArea["dot-11"];
			dragArea.transform.matrix=new Matrix((dotx.x-dot0.x)/100,(dotx.y-dot0.y)/100,(doty.x-dot0.x)/100,(doty.y-dot0.y)/100,dot0.x,dot0.y);
		}
		private static function getM(dspObj0:DisplayObject,dspObj1:DisplayObject):Matrix{
			var m:Matrix=dspObj1.transform.concatenatedMatrix;
			var m1:Matrix=dspObj0.parent.transform.concatenatedMatrix;
			m1.invert();
			m.concat(m1);
			
			return m;
		}
		private function updateDotsByDragArea():void{
			var m:Matrix=dragArea.transform.matrix;
			
			var dot:MovieClip;
			for each(dot in scaleDotArr){
				var p:Point=m.transformPoint(new Point(50+50*dot.dx,50+50*dot.dy));
				dot.x=p.x;
				dot.y=p.y;
			}
			updateOtherDotsByScaleDots();
		}
		private function updateUserMouse(type:String):void{
			if(type){
				if(type==TYPE_DRAG){
					userMouse.rotation=0;
				}else{
					userMouse.rotation=Math.atan2(this.mouseY,this.mouseX)*(180/Math.PI);
				}
				userMouse.x=this.mouseX;
				userMouse.y=this.mouseY;
				Mouse.hide();
				userMouse.gotoAndStop(type);
			}else{
				Mouse.show();
				userMouse.gotoAndStop(1);
			}
		}
		private function updateByPic():void{
			var p:Point=getPicMidP();
			this.transform.matrix=new Matrix(1,0,0,1,p.x,p.y);//把 this 移至 __pic 中点
			
			this.rotation=__pic.rotation;
			
			var rect:Rectangle=__pic.getBounds(__pic);
			var m:Matrix=new Matrix(rect.width/100,0,0,rect.height/100,rect.x,rect.y);
			m.concat(getM(dragArea,__pic));
			dragArea.transform.matrix=m;
			
			updateDotsByDragArea();
		}
		private function updatePic():void{
			var rect:Rectangle=__pic.getBounds(__pic);
			var m:Matrix=new Matrix(rect.width/100,0,0,rect.height/100,rect.x,rect.y);
			m.invert();
			m.concat(getM(__pic,dragArea));
			__pic.transform.matrix=m;
			(onTran==null)||onTran(__pic,m);
		}
		private function getPicMidP():Point{
			var rect:Rectangle=__pic.getBounds(__pic);
			var p:Point=new Point(rect.x+rect.width/2,rect.y+rect.height/2);
			p=__pic.localToGlobal(p);
			return this.parent.globalToLocal(p);
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