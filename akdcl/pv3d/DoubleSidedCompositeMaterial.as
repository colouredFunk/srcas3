package akdcl.pv3d
{
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.geom.Matrix;
	
	import org.papervision3d.core.geom.renderables.Triangle3D;
	import org.papervision3d.core.geom.renderables.Vertex3DInstance;
	import org.papervision3d.core.material.TriangleMaterial;
	import org.papervision3d.core.proto.MaterialObject3D;
	import org.papervision3d.core.render.data.RenderSessionData;
	import org.papervision3d.core.render.draw.ITriangleDrawer;

	public class DoubleSidedCompositeMaterial extends TriangleMaterial implements ITriangleDrawer
	{
		protected var materials:Array;
		
		public function DoubleSidedCompositeMaterial()
		{
			_initialize();
		};
		
		private function _initialize():void
		{
			materials = new Array();
		};
		
		public function addMaterial(material:MaterialObject3D):void
		{
			materials.push(material);
		};
		
		public function removeMaterial(material:MaterialObject3D):void
		{
			materials.splice(materials.indexOf(material), 1);
		};
		
		public function removeAllMaterials(material:MaterialObject3D):void
		{
			materials.splice(0);
		};

		override public function drawTriangle(face3D:Triangle3D, graphics:Graphics, renderSessionData:RenderSessionData, altBitmap:BitmapData=null, altUV:Matrix = null):void
		{
			var vertex0:Vertex3DInstance;
			var vertex1:Vertex3DInstance;
			var vertex2:Vertex3DInstance;
			var x0:Number;
			var y0:Number;
			var x1:Number;
			var y1:Number;
			var x2:Number;
			var y2:Number;
			var draw:Boolean;
			
			var material:MaterialObject3D;
			
			for each(material in materials)
			{
				draw = true;
				
				vertex0 = face3D.v0.vertex3DInstance;
				vertex1 = face3D.v1.vertex3DInstance;
				vertex2 = face3D.v2.vertex3DInstance;
				
				x0 = vertex0.x;
				y0 = vertex0.y;
				x1 = vertex1.x;
				y1 = vertex1.y;
				x2 = vertex2.x;
				y2 = vertex2.y;
				
				if( material.opposite )
				{
					if( ( x2 - x0 ) * ( y1 - y0 ) - ( y2 - y0 ) * ( x1 - x0 ) > 0 )
					{
						draw = false;
					};
				} else
				{
					if( ( x2 - x0 ) * ( y1 - y0 ) - ( y2 - y0 ) * ( x1 - x0 ) < 0 )
					{
						draw = false;
					};
				};
				
				if (draw)
				{
					material.drawTriangle(face3D, graphics, renderSessionData);
				};
			};
		};
	};
};