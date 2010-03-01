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
			camera.focus = 100;
			camera.zoom = 10;
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