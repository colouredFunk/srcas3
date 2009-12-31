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
		public function init(vpWidth:Number=550,vpHeight:Number=400,_interactive:Boolean=false):void {
			initPaperVision(vpWidth,vpHeight,_interactive);
			init2d();
			init3d();
			initEvents();
			addEventListener(Event.ADDED_TO_STAGE, added);
		}
		protected function added(_evt:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, added);
			addEventListener(Event.REMOVED_FROM_STAGE, removed);
		}
		protected function removed(_evt:Event):void {
			removeEventListener(Event.REMOVED_FROM_STAGE, removed);
			
		}
		protected function initPaperVision(vpWidth:Number,vpHeight:Number,_interactive:Boolean=false):void {
			viewport=new Viewport3D(vpWidth,vpHeight,false,_interactive);
			renderer=new BasicRenderEngine();
			scene=new Scene3D();
			camera=new Camera3D();
			addChild(viewport);
		}
		protected function init2d():void {
		}
		protected function init3d():void {
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
}