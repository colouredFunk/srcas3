package akdcl.pv3d
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import org.papervision3d.scenes.Scene3D;
	import org.papervision3d.view.Viewport3D;
	import org.papervision3d.cameras.Camera3D;
	import org.papervision3d.render.BasicRenderEngine;
	import org.papervision3d.render.QuadrantRenderEngine;
	
	/**
	 * ...
	 * @author ...
	 */
	public class  PV3DRenderDouble extends Sprite
	{
		protected var render_basic:BasicRenderEngine;
		protected var render_quadrant:QuadrantRenderEngine;
		protected var scene:Scene3D;
		protected var viewport:Viewport3D;
		protected var camera:Camera3D;
		public function init(_vpWidth:Number=550,_vpHeight:Number=400,_interactive:Boolean=false):void {
			render_basic = new BasicRenderEngine();
			render_quadrant = new QuadrantRenderEngine();
			scene = new Scene3D();
			camera = new Camera3D();
			viewport = new Viewport3D(_vpWidth, _vpHeight, false, _interactive);
			addChild(viewport);
			init2d();
			init3d();
			initEvents();
			addEventListener(Event.REMOVED_FROM_STAGE, removed);
		}
		protected function removed(_evt:Event):void {
			removeEventListener(Event.REMOVED_FROM_STAGE, removed);
		}
		protected function init2d():void {
		}
		protected function init3d():void {
		}
		protected function initEvents():void {
		}
		protected function renderScene(_isBasic:Boolean = true ):void {
			if (_isBasic) {
				render_basic.renderScene(scene, camera, viewport);
			}else {
				render_quadrant.renderScene(scene, camera, viewport);
			}
		}
	}
}
/*
package akdcl.pv3d{
	import flash.display.*;
	import flash.events.*;
	
	import org.papervision3d.scenes.Scene3D;
	import org.papervision3d.view.Viewport3D;
	import org.papervision3d.cameras.Camera3D;
	import org.papervision3d.render.BasicRenderEngine;
	
	public class PvBase_2 extends Sprite {
		public var viewport:Viewport3D;
		public var renderer:*;
		public var scene:Scene3D;
		public var camera:Camera3D;
		public var pause:Boolean;
		public function init():void {
			initPaperVision(vpWidth,vpHeight,_interactive);
			init2d();
			init3d();
			initEvents();
		}
		protected function initPaperVision(vpWidth:Number,vpHeight:Number,_interactive:Boolean=false):void {
			viewport=new Viewport3D(vpWidth,vpHeight,false,_interactive);
			renderer=new BasicRenderEngine();
			scene=new Scene3D();
			camera=new Camera3D();
			addChild(viewport);
		}
		protected function initEvents():void {
			addEventListener(Event.ENTER_FRAME,onEnterFrame);
		}
		protected function processFrame():void {
		}
		protected function onEnterFrame(event:Event):void {
			if(pause){
				return;
			}
			processFrame();
			render();
		}
		protected function render():void{
			renderer.renderScene(scene,camera,viewport);
		}
	}
}*/