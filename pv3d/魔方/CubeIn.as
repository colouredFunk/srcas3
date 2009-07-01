package {
	import org.papervision3d.objects.primitives.Cube;
	import org.papervision3d.materials.utils.MaterialsList;
	public class CubeIn extends Cube {
		public function CubeIn( materials:MaterialsList, width:Number=500, depth:Number=500, height:Number=500, segmentsS:int=1, segmentsT:int=1, segmentsH:int=1, insideFaces:int=0, excludeFaces:int=0 ) {
			super( materials, width, depth, height, segmentsS, segmentsT, segmentsH, insideFaces, excludeFaces);
		}
	}
}