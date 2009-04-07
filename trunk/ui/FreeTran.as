/***
FreeTran 版本:v1.0
简要说明:这家伙很懒什么都没写
创建时间:2009年2月4日 09:09:29
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚;最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
package ui{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	import flash.geom.*;
	
	import flash.ui.*;
	
	public class FreeTran extends Sprite{
		
		public static const TWEEN_MODE_NORMAL:String="正常";
		public static const TWEEN_MODE_NO:String="没有";
		public static const TWEEN_MODE_TWEEN:String="缓动";
		[Inspectable(enumeration="正常,没有,缓动",defaultValue="正常",name="缓动类型")]
		public var tweenMode:String;
		
		[Inspectable(defaultValue="",type="string",name="变形对象")]
		public function set picName(_pic:*):void{
			if(_pic is DisplayObject){
				pic=_pic;
				return;
			}
			try{
				pic=this.parent.getChildByName(_pic);
				if(pic){
					return;
				}
			}catch(e){
			}
			trace("找不到 "+_pic);
		}
		
		[Inspectable(defaultValue=true,name="旋转")]
		public function set canRotate(_canRotate:Boolean):void{
			dot211.visible=dot221.visible=dot212.visible=dot222.visible=_canRotate;
		}
		
		[Inspectable(defaultValue=true,name="缩放")]
		public function set canScale(_canScale:Boolean):void{
			dot111.visible=dot101.visible=dot121.visible=dot110.visible=dot120.visible=dot112.visible=dot102.visible=dot122.visible==_canScale;
		}
		
		[Inspectable(defaultValue=true,name="倾斜或剪切")]
		public function set canSkew(_canScale:Boolean):void{
			dot201.visible=dot210.visible=dot220.visible=dot202.visible=_canScale;
		}
		
		[Inspectable(defaultValue=false,name="四角等比缩放")]
		public var lockScale:Boolean;
		
		
		private var dot1Arr:Array;
		private var dot2Arr:Array;
		private var currDot:FreeTranDot;
		private var isMoving:Boolean;
		private var isRotating:Boolean;
		private var isSkewing:Boolean;
		private var currRota:Number;
		private var currM:Matrix;
		public function FreeTran(){
			this.addEventListener(Event.ADDED_TO_STAGE,added);
			pic=null;
			tweenMode=TWEEN_MODE_NORMAL;
			//tweenMode=TWEEN_MODE_NO;
			//tweenMode=TWEEN_MODE_TWEEN;
			showUserMouse();
			userMouse.mouseEnabled=userMouse.mouseChildren=false;
			
			dot1Arr=[dot111,dot101,dot121,dot110,dot120,dot112,dot102,dot122];
			dot2Arr=[dot211,dot201,dot221,dot210,dot220,dot212,dot202,dot222];
			//111	101	121
			//110		120
			//112	102	122
			
			//211	201	221
			//210		220
			//212	202	222
		}
		private function added(event:Event):void{
			this.removeEventListener(Event.ADDED_TO_STAGE,added);
			this.addEventListener(Event.REMOVED_FROM_STAGE,removed);
			stage.addEventListener(MouseEvent.MOUSE_UP,mouseUp);
			stage.addEventListener(MouseEvent.MOUSE_MOVE,mouseMove);
			//stage.addEventListener(Event.MOUSE_LEAVE ,mouseLeave);
			dragArea.addEventListener(MouseEvent.MOUSE_OVER,rollOverDragArea);
			dragArea.addEventListener(MouseEvent.MOUSE_OUT,rollOutArea);
			dragArea.addEventListener(MouseEvent.MOUSE_DOWN,pressDragArea);
		}
		/*private function mouseLeave(event:Event):void{
			mouseUp(null);
			showUserMouse();
		}*/
		private function removed(event:Event):void{
			this.removeEventListener(Event.REMOVED_FROM_STAGE,removed);
			stage.removeEventListener(MouseEvent.MOUSE_UP,mouseUp);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE,mouseMove);
			//stage.removeEventListener(Event.MOUSE_LEAVE ,mouseLeave);
			dragArea.removeEventListener(MouseEvent.MOUSE_OVER,rollOverDragArea);
			dragArea.removeEventListener(MouseEvent.MOUSE_OUT,rollOutArea);
			dragArea.removeEventListener(MouseEvent.MOUSE_DOWN,pressDragArea);
			this.removeEventListener(Event.ENTER_FRAME,enterFrame);
			
			dot1Arr=null;
			dot2Arr=null;
			currDot=null;
			pic=null;
			
			currM=null;
			
			Mouse.show();
		}
		private function setDot1sByCurrDot(x:Number,y:Number):void{
			var dot:FreeTranDot;
			if(currDot.xId){
				var dx:Number=(x-currDot.x)*currDot.xId;
				for each(dot in dot1Arr){
					dot.x+=dx*dot.xId;
				}
			}
			if(currDot.yId){
				var dy:Number=(y-currDot.y)*currDot.yId;
				for each(dot in dot1Arr){
					dot.y+=dy*dot.yId;
				}
			}
		}
		private function mouseMove(event:MouseEvent):void{
			userMouse.x=this.mouseX;
			userMouse.y=this.mouseY;
			if(currDot){
				var dot:FreeTranDot,dot1:FreeTranDot1,dot2:FreeTranDot2;
				var dx:Number,dy:Number;
				var dotId:int,i:int;
				var dp:Point;
				if(currDot is FreeTranDot1){
					if(lockScale&&currDot.xId&&currDot.yId){
						//四角等比缩放
						dp=getDpByDotAndMouse(currDot,currDot,this["dot1"+(3-int(currDot.name.charAt(4)))+(3-int(currDot.name.charAt(5)))]);
						setDot1sByCurrDot(currDot.x+dp.x,currDot.y+dp.y);
					}else{
						setDot1sByCurrDot(this.mouseX,this.mouseY);
					}
				}else{//FreeTranDot2	倾斜或剪切
					if(currDot.xId){//dot210
						dotId=int(currDot.name.charAt(4));
						dp=getDpByDotAndMouse(currDot,this["dot2"+dotId+"1"],this["dot2"+dotId+"2"]);
						for(i=0;i<3;i++){
							dot=this["dot2"+dotId+i];
							dot.x+=dp.x;
							dot.y+=dp.y;
						}
						dotId=3-dotId;
						for(i=0;i<3;i++){
							dot=this["dot2"+dotId+i];
							dot.x-=dp.x;
							dot.y-=dp.y;
						}
					}else{
						dotId=int(currDot.name.charAt(5));
						dp=getDpByDotAndMouse(currDot,this["dot21"+dotId],this["dot22"+dotId]);
						for(i=0;i<3;i++){
							dot=this["dot2"+i+dotId];
							dot.x+=dp.x;
							dot.y+=dp.y;
						}
						dotId=3-dotId;
						for(i=0;i<3;i++){
							dot=this["dot2"+i+dotId];
							dot.x-=dp.x;
							dot.y-=dp.y;
						}
					}
					i=0;
					for each(dot1 in dot1Arr){
						dot2=dot2Arr[i];
						dot1.x=dot2.x;
						dot1.y=dot2.y;
						i++;
					}
						
				}
				var sMat:Matrix=new Matrix();
				sMat.a = (dot121.x-dot111.x)/dragArea.body.width;
				sMat.b = (dot121.y-dot111.y)/dragArea.body.width;
				sMat.c = (dot112.x-dot111.x)/dragArea.body.height;
				sMat.d = (dot112.y-dot111.y)/dragArea.body.height;
				dragArea.transform.matrix=sMat;
				var rect:Rectangle=dragArea.body.getBounds(this);
				dragArea.x-=rect.x+rect.width*0.5;
				dragArea.y-=rect.y+rect.height*0.5;
				moving(0);
			}else if(isRotating){
				moving(1);
				this.rotation+=(Math.atan2(this.mouseY,this.mouseX)-currRota)*(180/Math.PI);
			}else if(isMoving||isSkewing){
				moving(2);
			}else{
				return;
			}
			
			updateDotsByDragArea();
			if(tweenMode==TWEEN_MODE_NORMAL){
				setTransform(pic,dragArea);
			}
		}
		public var moving:Function;
		private function getDpByDotAndMouse(dot:FreeTranDot,dot0:FreeTranDot,dot1:FreeTranDot):Point{
			//把dot的位置调整到Mouse在直线dot0-dot1的投影上
			var x0:Number=dot0.x;
			var y0:Number=dot0.y;
			var x1:Number=dot1.x;
			var y1:Number=dot1.y;
			var xm:Number=this.mouseX;
			var ym:Number=this.mouseY;
			
			var dx:Number=x1-x0;
			var dy:Number=y1-y0;
			var num:Number=dx*dx+dy*dy;
			return new Point(
				(xm*dx*dx+x0*dy*dy+(ym-y0)*dy*dx)/num-dot.x,
				(ym*dy*dy+y0*dx*dx+(xm-x0)*dx*dy)/num-dot.y
			);
		}
		public function rollOverDot(event:MouseEvent):void{
			var dot:FreeTranDot=event.target as FreeTranDot;
			switch(dot){
				case dot111:
				case dot122:
					showUserMouse("f11");
				break;
				case dot110:
				case dot120:
					showUserMouse("f10");
				break;
				case dot101:
				case dot102:
					showUserMouse("f01");
				break;
				case dot112:
				case dot121:
					showUserMouse("f00");
				break;
				
				case dot211:
				case dot212:
				case dot221:
				case dot222:
					showUserMouse("rota");
				break;
				
				case dot201:
				case dot202:
					showUserMouse("t1");
				break;
				case dot210:
				case dot220:
					showUserMouse("t2");
				break;
			}
		}
		public function pressDot(event:MouseEvent):void{
			if(event.target is FreeTranDot1){
				currDot=event.target as FreeTranDot1;
			}else if(event.target is FreeTranDot2){
				switch(event.target){
					case dot211:
					case dot212:
					case dot221:
					case dot222:
						isRotating=true;
						currRota=Math.atan2(this.mouseY,this.mouseX);
					break;
					case dot201:
					case dot202:
					case dot210:
					case dot220:
						isSkewing=true;
						currDot=event.target as FreeTranDot2;
					break;
				}
			}
		}
		
		private function rollOverDragArea(event:MouseEvent):void{
			showUserMouse("drag");
		}
		private function pressDragArea(event:MouseEvent):void{
			isMoving=true;
			this.startDrag();
		}
		
		private function showUserMouse(label:String="blank"):void{
			if(currDot||isRotating||isSkewing){
				return;
			}
			if(label=="blank"){
				Mouse.show();
			}else{
				Mouse.hide();
			}
			userMouse.gotoAndStop(label);
		}
		
		public function rollOutArea(event:Event):void{
			showUserMouse(isMoving?"drag":"blank");
		}
		private function mouseUp(event:MouseEvent):void{
			if(!(isMoving||currDot||isRotating||isSkewing)){
				return;
			}
			if(isMoving){
				isMoving=false;
				stopDrag();
			}
			currDot=null;
			isRotating=false;
			isSkewing=false;
			
			
			userMouse.x+=-1000000;//因为下面的hitTest不希望碰到userMouse
			if(dragArea.hitTestPoint(root.mouseX,root.mouseY,true)){
				showUserMouse("drag");
			}else if(!this.hitTestPoint(root.mouseX,root.mouseY,true)){
				showUserMouse();
			}
			userMouse.x+=1000000;
			
			switch(tweenMode){
				case TWEEN_MODE_TWEEN:
					this.removeEventListener(Event.ENTER_FRAME,enterFrame);
					this.addEventListener(Event.ENTER_FRAME,enterFrame);
			
					currM=getM(pic,dragArea);
				break;
				case TWEEN_MODE_NO:
					setTransform(pic,dragArea);
				break;
			}
		}
		private function enterFrame(event:Event):void{
			var m:Matrix=pic.transform.matrix;
			var da:Number=currM.a-m.a;
			var db:Number=currM.b-m.b;
			var dc:Number=currM.c-m.c;
			var dd:Number=currM.d-m.d;
			var dx:Number=currM.tx-m.tx;
			var dy:Number=currM.ty-m.ty;
			if((da*da+db*db+dc*dc+dd*dd)*100+dx*dx+dy*dy<1){
				pic.transform.matrix=currM;
				this.removeEventListener(Event.ENTER_FRAME,enterFrame);
			}else{
				m.a+=da*0.4;
				m.b+=db*0.4;
				m.c+=dc*0.4;
				m.d+=dd*0.4;
				m.tx+=dx*0.4;
				m.ty+=dy*0.4;
				pic.transform.matrix=m;
			}
		}
		
		private var __pic:DisplayObject;
		public function get pic():DisplayObject{
			return __pic;
		}
		public function set pic(_pic:DisplayObject):void{
			if(_pic&&_pic==__pic)return;
			__pic=_pic;
			if(__pic){
				var _depthOff:int;
				_depthOff=parent.getChildIndex(this)>parent.getChildIndex(__pic)?1:0;
				
				parent.setChildIndex(this,parent.getChildIndex(__pic)+_depthOff);
				this.transform.matrix=new Matrix();
				dragArea.transform.matrix=new Matrix();
				dragArea.body.transform.matrix=new Matrix();
				var wid2:Number=dragArea.body.width/2;
				var hei2:Number=dragArea.body.height/2;
				
				var rect:Rectangle=__pic.getBounds(__pic);
				
				//让 dragArea.body 变成 __pic的内部结构 的形状和位置
				//这样子 dragArea 就和 __pic "平衡"了
				dragArea.body.x=rect.x;
				dragArea.body.y=rect.y;
				dragArea.body.width=rect.width;
				dragArea.body.height=rect.height;
				
				//让 dragArea 和 __pic 看起来形状和位置一样
				setTransform(dragArea,__pic);
				
				//使 dragArea 在 this 里居中,并保持 dragArea 和 __pic 看起来形状和位置一样
				var rectDragArea:Rectangle=dragArea.body.getBounds(this);
				this.x+=rectDragArea.x+rectDragArea.width/2;
				this.y+=rectDragArea.y+rectDragArea.height/2;
				this.rotation=dragArea.rotation;
				setTransform(dragArea,__pic);
				
				//更新控制点的位置
				updateDotsByDragArea();
				
				mouseMove(null);
				//pressDragArea(null);
				
				this.visible=true;
			}else{
				this.visible=false;
			}
		}
		public function setPicByMouse(_pic:DisplayObject):void{
			pic=_pic;
			if(__pic){
				pressDragArea(null);
			}
		}
		private function updateDotsByDragArea():void{
			var m:Matrix=dragArea.body.transform.matrix;
			m.concat(dragArea.transform.matrix);
			
			var i:int=0;
			for each(var dot1:FreeTranDot1 in dot1Arr){
				var dot2:FreeTranDot2=dot2Arr[i];
				var p:Point=m.transformPoint(new Point(50+50*dot1.xId,50+50*dot1.yId));
				dot1.x=dot2.x=p.x;
				dot1.y=dot2.y=p.y;
				i++;
			}
		}
		public function update():void{
			updateDotsByDragArea();
			setTransform(pic,dragArea);
		}
		
		private static function setTransform(dspObj0:DisplayObject,dspObj1:DisplayObject):void{
			dspObj0.transform.matrix=getM(dspObj0,dspObj1);
		}
		private static function getM(dspObj0:DisplayObject,dspObj1:DisplayObject):Matrix{
			var m:Matrix=dspObj1.transform.concatenatedMatrix;
			var m1:Matrix=dspObj0.parent.transform.concatenatedMatrix;
			m1.invert();
			m.concat(m1);
			
			return m;
		}
	
	}
}