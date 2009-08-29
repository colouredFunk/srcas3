// ActionScript file
package {
	import Box2D.Collision.Shapes.b2Shape;
	import Box2D.Collision.b2AABB;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.Joints.b2MouseJoint;
	import Box2D.Dynamics.Joints.b2MouseJointDef;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2World;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class Drag {
		private var mouseJoint:b2MouseJoint;
		private const rate:uint = 30;
		private var myWorld:b2World;
		private var mousePVec:b2Vec2 = new b2Vec2;
		private var mc:Sprite;
		
		public function Drag( _myWorld:b2World, _mc:Sprite ) {
			mc = _mc;
			myWorld = _myWorld;
		}
		
		/**
		 * 添加拖拽侦听器
		 */
		public function addDrag():void {
			mc.stage.addEventListener( MouseEvent.MOUSE_DOWN, downHandler );
			mc.stage.addEventListener( MouseEvent.MOUSE_MOVE, moveHandler );
			mc.stage.addEventListener( MouseEvent.MOUSE_UP, upHandler );
		}
		
		/**
		 * 移除拖拽侦听器
		 */
		public function removeDrag():void {
			mc.stage.removeEventListener( MouseEvent.MOUSE_DOWN, downHandler );
			mc.stage.removeEventListener( MouseEvent.MOUSE_MOVE, moveHandler );
			mc.stage.removeEventListener( MouseEvent.MOUSE_UP, upHandler );
		}
		
		/**
		 * 鼠标按下后注册一个 b2MouseJoint
		 */
		private function downHandler( e:MouseEvent ):void {
			if ( !mouseJoint ) {
				var body:b2Body = getBodyAtMouse();
				if ( body ) {
					var md:b2MouseJointDef = new b2MouseJointDef;
					md.body1 = myWorld.GetGroundBody();
					md.body2 = body;
					md.target.Set( e.stageX/rate, e.stageY/rate );		// 设置拖拽的最初目标位置（ 在鼠标移动中还会不断改变 ）
					md.maxForce = 300.0 * body.GetMass();		// 拖拽使用的力
					md.timeStep = 1/30;
					mouseJoint = myWorld.CreateJoint( md ) as b2MouseJoint;
					body.WakeUp();
				}
			}
		}
		
		/**
		 * 鼠标移动过程中，改变拖拽的目的地。目的地为鼠标的位置
		 */
		private function moveHandler( e:MouseEvent ):void {
			if ( mouseJoint ) {
				var p2:b2Vec2 = new b2Vec2( e.localX / rate, e.localY / rate );
				mouseJoint.SetTarget( p2 );
			}
		}
		
		/**
		 * 鼠标弹起后，删除 mouseJoint
		 */
		private function upHandler( e:MouseEvent ):void {
			if ( mouseJoint ) {
				myWorld.DestroyJoint( mouseJoint );
				mouseJoint = null;
			}
		}
		
		/**
		 * 根据鼠标位置获取 body
		 */
		private function getBodyAtMouse():b2Body {
			// 声明一个 b2AABB，以后会用到。这个 b2AABB 非常小，长宽都只有 0.002，位置是 鼠标位置。
			mousePVec.Set( mc.mouseX/rate, mc.mouseY/rate );
			var aabb:b2AABB = new b2AABB();
			aabb.lowerBound.Set( mc.mouseX/rate - 0.001, mc.mouseY/rate - 0.001 );
			aabb.upperBound.Set( mc.mouseX/rate + 0.001, mc.mouseY/rate + 0.001 );
			
			// 利用了 b2World 的 Query 函数，返回与 aabb 重叠的 b2Shape 数组。
			var k_maxCount:int = 10;
			var shapes:Array = new Array();
			var count:int = myWorld.Query( aabb, shapes, k_maxCount );
			var body:b2Body = null;
			// 遍历数组，找出 鼠标指的body
			for (var i:int = 0; i < count; ++i)
			{
				if (shapes[i].GetBody().IsStatic() == false )
				{
					var tShape:b2Shape = shapes[i] as b2Shape;
					var inside:Boolean = tShape.TestPoint(tShape.GetBody().GetXForm(), mousePVec);
					if (inside)
					{
						body = tShape.GetBody();
						break;
					}
				}
			}
			return body;
		}
	}
}