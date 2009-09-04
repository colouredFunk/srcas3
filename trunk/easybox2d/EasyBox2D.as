package easybox2d
{
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Common.*;
	import Box2D.Common.Math.*;
	import Box2D.Dynamics.*;
	import Box2D.Dynamics.Contacts.*;
	import Box2D.Dynamics.Joints.*;
	
	
	import com.MouseControl;
	
	import flash.display.*;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	public class EasyBox2D
	{
		public static const BOX:int=0;
		public static const CIRCLE:int=1;

		private var worldBox:b2World;
		private var rjd:b2RevoluteJointDef;
		//迭代次数
		public static var iterations:int = 10;
		//时间系数
		public static var timeStep:Number = 1/30;
		//像素点到单位量度的系数
		public static var physScale:Number = 30;
		public static var physToPixel:Number=1/physScale;
		public static var R2A:Number=180/Math.PI;
		//鼠标
		private var mouseControl:MouseControl;
		public var bodyMouse:b2MouseJoint;
		public var mouseXPhys:Number;
		public var mouseYPhys:Number;
		public var mouseXWorld:Number;
		public var mouseYWorld:Number;
		
		public var worldClip:Sprite;
		//测试用图元容器
		public var debugClip:Sprite;
		private var bodyDict:Dictionary;
		private var invisibleDict:Dictionary;

		public function EasyBox2D(_container:Sprite,_debug:Boolean=false,_worldAABB:b2AABB=null,_gravity:b2Vec2=null,_doSleep:Boolean=true):void{
			if (!_worldAABB){
				_worldAABB= new b2AABB();
				_worldAABB.lowerBound.Set(-500, -500);
				_worldAABB.upperBound.Set(500, 500);
			}
			if (!_gravity) {
				_gravity = new b2Vec2(0.0, 10.0);
			}
			worldBox = new b2World(_worldAABB, _gravity, _doSleep);
			rjd = new b2RevoluteJointDef();
			
			worldClip=_container;
			mouseControl=new MouseControl(worldClip);
			mouseControl.onPress=function():void{
				updateMouse();
				var _body:b2Body = GetBodyAtMouse();
				if (!_body){
					return;
				}
				var md:b2MouseJointDef = new b2MouseJointDef();
				md.body1 = worldBox.GetGroundBody();
				md.body2 = _body;
				md.target.Set(mouseXPhys, mouseYPhys);
				md.maxForce = 300.0 * _body.GetMass();
				md.timeStep = timeStep;
				bodyMouse = worldBox.CreateJoint(md) as b2MouseJoint;
				_body.WakeUp();
			}
					
			if (_debug){
				debugClip = new Sprite();
				worldClip.addChild(debugClip);
				var dbgDraw:b2DebugDraw = new b2DebugDraw();
				dbgDraw.m_sprite = debugClip;
				dbgDraw.m_drawScale = 30.0;
				dbgDraw.m_fillAlpha = 0.3;
				dbgDraw.m_lineThickness = 1.0;
				dbgDraw.m_drawFlags = b2DebugDraw.e_shapeBit | b2DebugDraw.e_jointBit;
				worldBox.SetDebugDraw(dbgDraw);
			}
			
			worldClip.addEventListener(Event.ENTER_FRAME, update, false, 0, true);
			
			bodyDict=new Dictionary(true);	
			invisibleDict=new Dictionary(true);
		}
		
		//参数列表
		//x,y左上角坐标
		//width,height长宽
		//radius半径
		//type类型 BOX CIRCLE
		//density 质量;
		//friction 摩擦;
		//restitution 反弹;
		
		//创建刚体
		public function createBody(_bodyDef:*):b2Body{
			if(!(_bodyDef is b2BodyDef)){
				if (!_bodyDef) {
					_bodyDef=new Object();
				}
				var bodyDef:b2BodyDef=new b2BodyDef();
				bodyDef.position.Set(_bodyDef.x*physToPixel,_bodyDef.y*physToPixel);
				
				var shapeDef:b2ShapeDef;
			
				if (_bodyDef.type==BOX){
					shapeDef=new b2PolygonDef();
					(shapeDef as b2PolygonDef).SetAsBox(_bodyDef.width*physToPixel*0.5,_bodyDef.height*physToPixel*0.5);
				}else if (_bodyDef.type==CIRCLE){
					shapeDef=new b2CircleDef();
					(shapeDef as b2CircleDef).radius = _bodyDef.radius*physToPixel;
				}else{
					throw new Error("type取值不合法")
				}
				if (_bodyDef.hasOwnProperty("density")){
					shapeDef.density=_bodyDef.density;
				}
				if (_bodyDef.hasOwnProperty("friction")){
					shapeDef.friction=_bodyDef.friction;
				}
				if (_bodyDef.hasOwnProperty("restitution")){
					shapeDef.restitution=_bodyDef.restitution
				};
			
				var _body:b2Body =worldBox.CreateBody(bodyDef);
				_body.CreateShape(shapeDef);
				return _body;
			}else{
				
			}
			return worldBox.CreateBody(_bodyDef);
		}
		public function createBodyDef():b2BodyDef{
			return new b2BodyDef();
		}
		public function createCircleDef():b2CircleDef{
			return new b2CircleDef();
		}
		public function createJoint(_body1:b2Body,_body2:b2Body,pos:*=null):b2RevoluteJointDef{
			var jd:b2RevoluteJointDef = new b2RevoluteJointDef();
			
			/*if (!isNaN(lowerAngle)){
				jd.enableLimit = true;
				jd.lowerAngle=lowerAngle;
			}
			if (!isNaN(upperAngle)){
				jd.enableLimit = true;
				jd.upperAngle=upperAngle;
			}*/
			if(!pos){
				var v1:*=_body1.GetPosition();
				var v2:*=_body2.GetPosition();
				pos=v2.Copy();
				pos.Subtract(v1);
				pos.Multiply(0.5);
				pos.Add(v1);
			}else{
				//,{x:5,y:5}
			}
			jd.Initialize(_body1, _body2, pos);
			worldBox.CreateJoint(jd);
			return jd;
		}
		public function createDistanceJoint(_body1:b2Body,_body2:b2Body):b2DistanceJointDef{
			var jd:b2DistanceJointDef = new b2DistanceJointDef();
			jd.Initialize(_body1, _body2, _body1.GetPosition(),_body2.GetPosition());
			worldBox.CreateJoint(jd);
			return jd;
		}
		private function putToDic(_clip:*,_body:*):b2Body{
			if (_clip){
				bodyDict[_clip]=_body;
			}else{
				invisibleDict[_body]=_body;
			}
			_body.SetMassFromShapes();
			return _body;
		}
		public function register(_clip:*,_body:*):b2Body{
			if(_body is b2Body){
				//_body.position.Set(_clip.x*physToPixel,_clip.y*physToPixel);
				return putToDic(_clip,_body);
			}
			if (!_body){
				_body={};
			}
			if (!_body.hasOwnProperty("type")){
				_body.type=BOX;
			}
			if (_clip is DisplayObject){ 
				if (!_body.hasOwnProperty("x")){
					_body.x=_clip.x;
				};
				if (!_body.hasOwnProperty("y")){
					_body.y=_clip.y;
				};
				if (_body.type==BOX){
					if (!_body.hasOwnProperty("width")){
						_body.width=_clip.width
					};
					if (!_body.hasOwnProperty("height")){
						_body.height=_clip.height
					};
				}else if (_body.type==CIRCLE){
					if (!_body.hasOwnProperty("radius")){
						_body.radius=_clip.width/2
					};
				}
			}
			return putToDic(_clip,createBody(_body));
		}
		//销毁刚体
		public function unregister(_clip:*):void{
			worldBox.DestroyBody(getBody(_clip));
			if(_clip is DisplayObject){
				delete bodyDict[_clip];
			}else{
				delete invisibleDict[_clip];
			}
		}
		//查找刚体
		public function getBody(_clip:*):b2Body{
			if(_clip is DisplayObject){
				return bodyDict[_clip];
			}
			return invisibleDict[_clip];
		}
		private function update(event:Event):void{
			//更新鼠标
			updateMouse();
			updateDrag();
			//更新物理
			worldBox.Step(timeStep, iterations);
			//更新粒子显示
			for (var clip:* in bodyDict){
				var _body:b2Body=bodyDict[clip];
				if(_body.IsSleeping()){
					continue;
				}
				clip.x=_body.m_xf.position.x*physScale;
				clip.y=_body.m_xf.position.y*physScale;
				clip.rotation = _body.m_xf.R.GetAngle()*R2A;
			}
		}
		public function updateClip(_clip:*):void{
			var _body:b2Body=getBody(_clip);
			_clip.x=_body.m_xf.position.x*physScale;
			_clip.y=_body.m_xf.position.y*physScale;
			_clip.rotation = _body.m_xf.R.GetAngle()*R2A;
		}
		protected function updateMouse():void{
			mouseXPhys = (mouseControl.mouseX)*physToPixel;
			mouseYPhys = (mouseControl.mouseY)*physToPixel;
		}
		protected function updateDrag():void{
			if(mouseControl.mouseDown){
				if(bodyMouse){
					var p2:b2Vec2 = new b2Vec2(mouseXPhys, mouseYPhys);
					bodyMouse.SetTarget(p2);
				}
			}else if(bodyMouse){
				worldBox.DestroyJoint(bodyMouse);
				bodyMouse = null;
			}
		}
		
		private function MouseDestroy():void{
			if (!mouseControl.mouseDown){
				var _body:b2Body = GetBodyAtMouse(true);
				if (_body){
					worldBox.DestroyBody(_body);
					return;
				}
			}
		}
		// 取得当前鼠标的物体
		private var mousePVec:b2Vec2 = new b2Vec2();
		public function GetBodyAtMouse(includeStatic:Boolean=false):b2Body{
			// Make a small box.
			mousePVec.Set(mouseXPhys, mouseYPhys);
			var aabb:b2AABB = new b2AABB();
			aabb.lowerBound.Set(mouseXPhys - 0.001, mouseYPhys - 0.001);
			aabb.upperBound.Set(mouseXPhys + 0.001, mouseYPhys + 0.001);
			
			// Query the world for overlapping shapes.
			var k_maxCount:int = 10;
			var shapes:Array = new Array();
			var count:int = worldBox.Query(aabb, shapes, k_maxCount);
			var _body:b2Body = null;
			for (var i:int = 0; i < count; ++i)
			{
				if (shapes[i].GetBody().IsStatic() == false || includeStatic)
				{
					var tShape:b2Shape = shapes[i] as b2Shape;
					var inside:Boolean = tShape.TestPoint(tShape.GetBody().GetXForm(), mousePVec);
					if (inside)
					{
						_body = tShape.GetBody();
						break;
					}
				}
			}
			return _body;
		}

	}
}