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
		
		public var rotateArea:Sprite;
		public var skewArea:Sprite;
		public var dragArea:Sprite;
		private var dragArea_shape:Shape;
		public var scaleArea:Sprite;
		private var userMouse:MovieClip;
		private var currTarget:Sprite;
		
		private var oldMouseX:Number;
		private var oldMouseY:Number;
		
		private var rotateDotArr:Array;
		private var skewDotArr:Array;
		private var scaleDotArr:Array;
		
		private var __minScaleX:Number=-1;
		private var __minScaleY:Number=-1;
		public function set minScaleX(_minScaleX:Number):void{
			if(_minScaleX>=0){
				__minScaleX=_minScaleX;
			}else{
				throw new Error("不合法的 _minScaleX："+_minScaleX);
			}
		}
		public function set minScaleY(_minScaleY:Number):void{
			if(_minScaleY>=0){
				__minScaleY=_minScaleY;
			}else{
				throw new Error("不合法的 _minScaleY："+_minScaleY);
			}
		}
		
		public function set minScale(_minScale:Number):void{
			if(_minScale>=0){
				minScaleX=_minScale;
				minScaleY=_minScale
			}else{
				throw new Error("不合法的 _minScale："+_minScale);
			}
		}
		
		private var __minWid:Number=-1;
		public function set minWid(_minWid:Number):void{
			if(_minWid>=0){
				__minWid=_minWid;
			}else{
				throw new Error("不合法的 _minWid："+_minWid);
			}
		}
		private var __minHei:Number=-1;
		public function set minHei(_minHei:Number):void{
			if(_minHei>=0){
				__minHei=_minHei;
			}else{
				throw new Error("不合法的 _minHei："+_minHei);
			}
		}
		
		private var __maxScaleX:Number=-1;
		private var __maxScaleY:Number=-1;
		public function set maxScaleX(_maxScaleX:Number):void{
			if(_maxScaleX>=0){
				__maxScaleX=_maxScaleX;
			}else{
				throw new Error("不合法的 _maxScaleX："+_maxScaleX);
			}
		}
		public function set maxScaleY(_maxScaleY:Number):void{
			if(_maxScaleY>=0){
				__maxScaleY=_maxScaleY;
			}else{
				throw new Error("不合法的 _maxScaleY："+_maxScaleY);
			}
		}
		
		public function set maxScale(_maxScale:Number):void{
			if(_maxScale>=0){
				maxScaleX=_maxScale;
				maxScaleY=_maxScale
			}else{
				throw new Error("不合法的 _maxScale："+_maxScale);
			}
		}
		
		private var __maxWid:Number=-1;
		public function set maxWid(_maxWid:Number):void{
			if(_maxWid>=0){
				__maxWid=_maxWid;
			}else{
				throw new Error("不合法的 _maxWid："+_maxWid);
			}
		}
		private var __maxHei:Number=-1;
		public function set maxHei(_maxHei:Number):void{
			if(_maxHei>=0){
				__maxHei=_maxHei;
			}else{
				throw new Error("不合法的 _maxHei："+_maxHei);
			}
		}
		
		private var __realMinWid2:Number=-1;
		private var __realMinHei2:Number=-1;
		private var __realMaxWid2:Number=-1;
		private var __realMaxHei2:Number=-1;
		
		public var onTran:Function;
		public var onStartTran:Function;
		public var onStopTran:Function;
		
		private var midP:Point;
		
		public function FreeTran(){
			rotateArea=this.getChildAt(0) as Sprite;
			skewArea=this.getChildAt(1) as Sprite;
			
			dragArea=this.getChildAt(2) as Sprite;
			
			var dragArea_sp:Sprite=new Sprite();
			dragArea_shape=dragArea.getChildAt(0) as Shape;
			dragArea_sp.addChild(dragArea_shape);
			dragArea_sp.mouseEnabled=dragArea_sp.mouseChildren=false;
			dragArea.addChild(dragArea_sp);
			
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
			dragArea_shape=null;
			scaleArea=null;
			userMouse=null;
			currTarget=null;
			
			rotateDotArr=null;
			skewDotArr=null;
			scaleDotArr=null;
			
			onTran=null;
			onStartTran=null;
			onStopTran=null;
			
			midP=null;
			
			Mouse.show();
		}
		
		private var __pic:DisplayObject;
		public function setPic(_pic:DisplayObject,drag:Boolean=false):void{
			__pic=_pic;
			if(__pic){
				var pic_rect:Rectangle=__pic.getBounds(__pic);
				midP=new Point(pic_rect.x+pic_rect.width/2,pic_rect.y+pic_rect.height/2);
				dragArea_shape.x=pic_rect.x;
				dragArea_shape.y=pic_rect.y;
				dragArea_shape.width=pic_rect.width;
				dragArea_shape.height=pic_rect.height;
				dragArea_shape.parent.width=100;
				dragArea_shape.parent.height=100;
				var dragArea_shape_rect:Rectangle=dragArea_shape.parent.getBounds(dragArea);
				dragArea_shape.parent.x-=dragArea_shape_rect.x;
				dragArea_shape.parent.y-=dragArea_shape_rect.y;
				
				trace(pic_rect);
				
				if(__minScaleX>=0||__minWid>=0){
					//计算 __realMinWid2，如果 __minScaleX 和 __minWid 同时被设置，取大的那个
					__realMinWid2=-Infinity;
					if(__minScaleX>=0){
						var _minWid:Number=pic_rect.width*__minScaleX;
						if(__realMinWid2<_minWid){
							__realMinWid2=_minWid;
						}
					}
					if(__minWid>=0){
						if(__realMinWid2<__minWid){
							__realMinWid2=__minWid;
						}
					}
					
					__realMinWid2/=2;
				}else{
					__realMinWid2=-1;
				}
				trace("__realMinWid2="+__realMinWid2);
				
				if(__maxScaleX>=0||__maxWid>=0){
					//计算 __realMaxWid2，如果 __maxScaleX 和 __maxWid 同时被设置，取小的那个
					__realMaxWid2=Infinity;
					if(__maxScaleX>=0){
						var _maxWid:Number=pic_rect.width*__maxScaleX;
						if(__realMaxWid2>_maxWid){
							__realMaxWid2=_maxWid;
						}
					}
					if(__maxWid>=0){
						if(__realMaxWid2>__maxWid){
							__realMaxWid2=__maxWid;
						}
					}
					
					__realMaxWid2/=2;
				}else{
					__realMaxWid2=-1;
				}
				trace("__realMaxWid2="+__realMaxWid2);
				
				if(__minScaleY>=0||__minHei>=0){
					//计算 __realMinHei2，如果 __minScaleY 和 __minHei 同时被设置，取大的那个
					__realMinHei2=-Infinity;
					if(__minScaleY>=0){
						var _minHei:Number=pic_rect.height*__minScaleY;
						if(__realMinHei2<_minHei){
							__realMinHei2=_minHei;
						}
					}
					if(__minHei>=0){
						if(__realMinHei2<__minHei){
							__realMinHei2=__minHei;
						}
					}
					
					__realMinHei2/=2;
				}else{
					__realMinHei2=-1;
				}
				trace("__realMinHei2="+__realMinHei2);
				
				if(__maxScaleY>=0||__maxHei>=0){
					//计算 __realMaxHei2，如果 __maxScaleY 和 __maxHei 同时被设置，取小的那个
					__realMaxHei2=Infinity;
					if(__maxScaleY>=0){
						var _maxHei:Number=pic_rect.height*__maxScaleY;
						if(__realMaxHei2>_maxHei){
							__realMaxHei2=_maxHei;
						}
					}
					if(__maxHei>=0){
						if(__realMaxHei2>__maxHei){
							__realMaxHei2=__maxHei;
						}
					}
					
					__realMaxHei2/=2;
				}else{
					__realMaxHei2=-1;
				}
				trace("__realMaxHei2="+__realMaxHei2);
				
				updateByPic();
				
				this.visible=true;
				if(drag){
					currTarget=dragArea;
					updateUserMouse(currTarget["type"]);
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
				clearTarget(area.getChildAt(i) as Sprite);
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
				var dot:Sprite=area.getChildAt(i) as Sprite;
				if(dot.x<-1){
					dot["dx"]=-1;
				}else if(dot.x>1){
					dot["dx"]=1;
				}else{
					dot["dx"]=0;
				}
				if(dot.y<-1){
					dot["dy"]=-1;
				}else if(dot.y>1){
					dot["dy"]=1;
				}else{
					dot["dy"]=0;
				}
				initTarget(dot,type);
				
				area["dot"+dot["dx"]+dot["dy"]]=dot;
				if(dotArr){
					dotArr[dotArr.length]=dot;
				}
			}
		}
		private function initTarget(target:Sprite,type:String):void{
			target.addEventListener(MouseEvent.MOUSE_OVER,mouseOver);
			target.addEventListener(MouseEvent.MOUSE_OUT,mouseOut);
			target.addEventListener(MouseEvent.MOUSE_DOWN,mouseDown);
			target["type"]=type;
		}
		private function mouseMove(event:MouseEvent):void{
			if(currTarget){
				switch(currTarget["type"]){
					case TYPE_ROTATE:
						this.rotation+=(Math.atan2(this.parent.mouseY-this.y,this.parent.mouseX-this.x)-Math.atan2(oldMouseY-this.y,oldMouseX-this.x))*(180/Math.PI);
						updatePic();
					break;
					case TYPE_SCALE:
						var dot:Sprite;
						var currDx:int=currTarget["dx"];
						var currDy:int=currTarget["dy"];
						
						var currX:Number;
						var currY:Number;
						if(currDx){
							currX=this.mouseX*currDx;
						}else{
							currX=0;
						}
						if(currDy){
							currY=this.mouseY*currDy;
						}else{
							currY=0;
						}
						
						/*
						if(lockScale){
							if(currDx&&currDy){
								//等比缩放
								var k:Number=dragArea.scaleX/dragArea.scaleY;
								if(currX/currY<k){
									currX=currY*k;
								}else{
									currY=currX/k;
								}
							}
						}
						*/
						
						if(currDx){
							if(__realMinWid2>=0){
								//如果小于最小宽度
								if(currX<__realMinWid2){
									currX=__realMinWid2;
								}
							}
							if(__realMaxWid2>=0){
								//如果大于最大宽度
								if(currX>__realMaxWid2){
									currX=__realMaxWid2;
								}
							}
							
							//如果被拖的很接近0，调成1
							if(currX>1||currX<-1){
							}else if(currX<0){
								currX=-1;
							}else{
								currX=1;
							}
						}
						if(currDy){
							if(__realMinHei2>=0){
								//如果小于最小高度
								if(currY<__realMinHei2){
									currY=__realMinHei2;
								}
							}
							if(__realMaxHei2>=0){
								//如果大于最大高度
								if(currY>__realMaxHei2){
									currY=__realMaxHei2;
								}
							}
							
							//如果被拖的很接近0，调成1
							if(currY>1||currY<-1){
							}else if(currY<0){
								currY=-1;
							}else{
								currY=1;
							}
						}
						
						if(currDx){
							for each(dot in scaleDotArr){
								dot.x=dot["dx"]*currX;
							}
						}
						if(currDy){
							for each(dot in scaleDotArr){
								dot.y=dot["dy"]*currY;
							}
						}
						
						updateOtherDotsByScaleDots();
						updateDragAreaByDots();
						updatePic();
						
						trace(dragArea.scaleX,dragArea.scaleY);
						
						/*
						var oldPicMatrix:Matrix=null;
						if(lockScale){
							oldPicMatrix=__pic.transform.matrix;//防止 __pic 的 matrix 跳变的
							switch(currTarget){
								case scaleArea["dot-1-1"]:
								case scaleArea["dot1-1"]:
								case scaleArea["dot11"]:
								case scaleArea["dot-11"]:
									//trace(currTarget.x,currTarget.y,otherTarget.x,otherTarget.y);
									
									var otherTarget:Sprite=scaleArea["dot"+(-currTarget["dx"])+(-currTarget["dy"])];
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
						
						updatePic();
						
				////
				var adjustScale:Boolean=false;
				var pic_scaleX:Number=Math.round(__pic.scaleX*1000)/1000;
				var pic_scaleY:Number=Math.round(__pic.scaleY*1000)/1000;
				if(minScale>0){
					if(pic_scaleX<minScale){
						pic_scaleX=minScale;
						adjustScale=true;
					}
					if(pic_scaleY<minScale){
						pic_scaleY=minScale;
						adjustScale=true;
					}
				}
				if(maxScale>0){
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
				////
					
					*/
						
					break;
					case TYPE_DRAG:
						this.x+=this.parent.mouseX-oldMouseX;
						this.y+=this.parent.mouseY-oldMouseY;
						updatePic();
					break;
				}
			}
			
			oldMouseX=this.parent.mouseX;
			oldMouseY=this.parent.mouseY;
			
			userMouse.x=this.mouseX;
			userMouse.y=this.mouseY;
		}
		private function mouseOver(event:MouseEvent):void{
			if(currTarget){
				return;
			}
			var target:Sprite=event.target as Sprite;
			switch(target["type"]){
				case TYPE_ROTATE:
				case TYPE_SCALE:
				case TYPE_DRAG:
					updateUserMouse(target["type"]);
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
			currTarget=event.target as Sprite;
			switch(currTarget["type"]){
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
			var target:Sprite=event.target as Sprite;
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
		
		private function updateOtherDotsByScaleDots():void{
			var dot:Sprite;
			var scaleDot:Sprite;
			for each(dot in rotateDotArr){
				scaleDot=scaleArea["dot"+dot["dx"]+dot["dy"]];
				dot.x=scaleDot.x;
				dot.y=scaleDot.y;
			}
			for each(dot in skewDotArr){
				scaleDot=scaleArea["dot"+dot["dx"]+dot["dy"]];
				dot.x=scaleDot.x;
				dot.y=scaleDot.y;
			}
		}
		private function setMidIn2Dot(dot0:Sprite,dot1:Sprite,dot2:Sprite):void{
			dot0.x=(dot1.x+dot2.x)/2;
			dot0.y=(dot1.y+dot2.y)/2;
		}
		private function updateDragAreaByDots():void{
			var dot0:Sprite=scaleArea["dot-1-1"];
			var dotx:Sprite=scaleArea["dot1-1"];
			var doty:Sprite=scaleArea["dot-11"];
			dragArea.transform.matrix=new Matrix((dotx.x-dot0.x)/100,(dotx.y-dot0.y)/100,(doty.x-dot0.x)/100,(doty.y-dot0.y)/100,dot0.x,dot0.y);
		}
		private function updateDotsByDragArea():void{
			var m:Matrix=dragArea.transform.matrix;
			
			var dot:Sprite;
			for each(dot in scaleDotArr){
				var p:Point=m.transformPoint(new Point(50+50*dot["dx"],50+50*dot["dy"]));
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
			var p:Point=getM(__pic,this.parent).transformPoint(midP);
			this.transform.matrix=new Matrix(1,0,0,1,p.x,p.y);//把 this 移至 __pic 中点
			this.rotation=__pic.rotation;//旋转设置为和 __pic 旋转一样
			
			var m:Matrix=dragArea_shape.transform.matrix.clone();
			m.concat(getM(__pic,dragArea.parent));
			dragArea.transform.matrix=m;
			
			updateDotsByDragArea();
			
			trace("__pic.scaleX="+__pic.scaleX,"__pic.scaleY="+__pic.scaleY);
		}
		private function updatePic():void{
			__pic.transform.matrix=getM(dragArea_shape.parent,__pic.parent);
			(onTran==null)||onTran(__pic,__pic.transform.matrix);
		}
		
		private static function getM(dspObj0:DisplayObject,dspObj1:DisplayObject):Matrix{
			//求得 m，此 m 的功能具体描述就是：假如进行以下操作：dspObj1.addChild(dspObj0);dspObj0.transform.matrix=m; 那么 dspObj0 将会和操作前看上去一样
			//
			/*
			//此算法可简单描述为：
			var m:Matrix=dspObj0.transform.concatenatedMatrix;
			var m1:Matrix=dspObj1.transform.concatenatedMatrix;
			m1.invert();
			m.concat(m1);
			return m;
			//由于 concatenatedMatrix 不总是能获取，所以不采用此算法
			//*/
			
			//找到共同的 parent
			var sameParent:DisplayObjectContainer=null;
			var parentDict:Dictionary=new Dictionary();
			var parent:DisplayObjectContainer;
			
			parent=dspObj0.parent;
			while(parent){
				parentDict[parent]=true;
				parent=parent.parent;
			}
			parent=dspObj1.parent;
			while(parent){
				if(parentDict[parent]){
					sameParent=parent;
					break;
				}
				parent=parent.parent;
			}
			//
			
			if(sameParent){
				var m:Matrix=dspObj0.transform.matrix;
				if(m){
					parent=dspObj0.parent;
					while(parent){
						if(parent==sameParent){
							break;
						}
						if(parent.transform.matrix){
							m.concat(parent.transform.matrix);
						}
						parent=parent.parent;
					}
				}
				
				var m1:Matrix=dspObj1.transform.matrix;
				if(m1){
					parent=dspObj1.parent;
					while(parent){
						if(parent==sameParent){
							break;
						}
						if(parent.transform.matrix){
							m1.concat(parent.transform.matrix);
						}
						parent=parent.parent;
					}
					
					m1.invert();
					m.concat(m1);
				}
				
				return m;
			}
			throw new Error("找不到 sameParent");
			return null;
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