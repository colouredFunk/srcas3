package {
	import pv3d.*;
	import org.papervision3d.objects.primitives.Plane;
	import org.papervision3d.materials.MovieMaterial;
	public class Test_0 extends PvBase_2 {
		private var plane:Plane;
		private var mouseDrag:MouseDrag
		public function Test_0():void{
			init();
		}
		override protected function init3d():void {
			var _movieClip_0:movieClip_0=new movieClip_0();
			plane=new Plane(new MovieMaterial(_movieClip_0,true,true));
			scene.addChild(plane);
		}
	}
}