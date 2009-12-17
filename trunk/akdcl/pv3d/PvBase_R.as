package akdcl.pv3d{
	import org.papervision3d.scenes.Scene3D;
	import org.papervision3d.view.Viewport3D;
	import org.papervision3d.cameras.Camera3D;
	//import org.papervision3d.render.BasicRenderEngine;
	import org.papervision3d.render.QuadrantRenderEngine;
	
	import akdcl.pv3d.PvBase_2;
	
	public class PvBase_R extends PvBase_2 {
		override protected function initPaperVision(vpWidth:Number,vpHeight:Number,_interactive:Boolean=false):void {
			viewport=new Viewport3D(vpWidth,vpHeight,false,_interactive);
			addChild(viewport);
			renderer=new QuadrantRenderEngine  ;
			scene=new Scene3D  ;
			camera=new Camera3D  ;
		}
	}
}