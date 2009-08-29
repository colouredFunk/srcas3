package {
	import Box2D.Collision.Shapes.b2PolygonDef;
	import Box2D.Collision.b2AABB;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2DebugDraw;
	import Box2D.Dynamics.b2World;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	[SWF(width="800", height="400",backgroundColor=0x663366)]
	public class Test extends Sprite
	{
		// Box2D 中的单位是 m ， 1m 等于 30个像素。
		private const rate:int = 30;
		// 创造一个 Box2D 的世界
		private var myWorld:b2World;
		// 一个物体
		private var rec1:b2Body;
		// 另外一个物体，作为表面
		private var surface:b2Body;
		
		public function Test()
		{
			addEventListener( Event.ENTER_FRAME, run );
			
			// 创造一个 box2D 的世界
			var worldAABB:b2AABB = new b2AABB;
			worldAABB.lowerBound.Set( -100, -100 );
			worldAABB.upperBound.Set( 100, 100 );
			var doSleep:Boolean = true;
			var gravity:b2Vec2 = new b2Vec2;
			gravity.Set( 0, 10 );
			myWorld = new b2World( worldAABB, gravity, doSleep );
		
			// 初始化拖拽类
			var drag:Drag = new Drag( myWorld, this );
			drag.addDrag();
			
			// 声明调试图形，在 demo 中看到的半透明图形就是调试用的
			var dbgDraw:b2DebugDraw = new b2DebugDraw;
			var dbgSprite:Sprite = new Sprite;
			addChild( dbgSprite );
			dbgDraw.m_sprite = dbgSprite;
			dbgDraw.m_drawScale = 30;
			dbgDraw.m_fillAlpha = 0.5;
			dbgDraw.m_lineThickness = 1.0;
			dbgDraw.m_drawFlags = b2DebugDraw.e_shapeBit;
			myWorld.SetDebugDraw( dbgDraw );
			
			// 声明表面
			var surfaceDef:b2BodyDef = new b2BodyDef;
			surfaceDef.position.Set( 400/rate, 350/rate );	// 位置
			surface = myWorld.CreateBody( surfaceDef );
			
			// 形状定义
			var boxDef:b2PolygonDef = new b2PolygonDef;
			boxDef.SetAsBox( 400/rate, 10/rate );
			boxDef.density = 0;				// 密度为 0，box2d 规定质量为 0 ，那么物体是固定的
			surface.CreateShape( boxDef );
			surface.SetMassFromShapes();
			
			// 声明一个物体
			var rec1Def:b2BodyDef = new b2BodyDef;
			rec1Def.position.Set( 100 / rate, 100 / rate );
			rec1 = myWorld.CreateBody( rec1Def );
			
			// 定义形状
			boxDef.SetAsBox( 20/rate, 20/rate );
			boxDef.density = 1;
			boxDef.restitution = 0.4;	// 弹性
			boxDef.friction = 0.2;		// 摩擦力
			rec1.CreateShape( boxDef );
			rec1.SetMassFromShapes();		// 根据形状计算质量
		}
		
		private function run( e:Event ):void {
			myWorld.Step( 1/30, 10 );			// 每一帧刷新一下，这样物体才会运动
		} 
	}
}
