package akdcl.pv3d
{
	import org.ascollada.fx.DaeBindVertexInput;
	import org.ascollada.fx.DaeInstanceMaterial;
	import org.ascollada.fx.DaeMaterial;
	import org.ascollada.fx.DaeEffect;
	import org.ascollada.fx.DaeLambert;
	import org.ascollada.types.DaeColorOrTexture;
	import org.ascollada.fx.DaeTexture;
	import org.ascollada.core.DaeImage;
	
	import org.papervision3d.core.proto.MaterialObject3D;
	import org.papervision3d.objects.parsers.DAE;
	import org.papervision3d.materials.BitmapMaterial;
	import org.papervision3d.materials.WireframeMaterial;
	import org.papervision3d.materials.ColorMaterial;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class DAEForZip extends DAE
	{
		public function DAEForZip(autoPlay:Boolean=true, name:String=null, loop:Boolean=false):void {
			super(autoPlay, name, loop);
		}
		override protected function buildMaterialInstance(daeInstanceMaterial:DaeInstanceMaterial, outBVI:DaeBindVertexInput):MaterialObject3D 
		{
			if(!daeInstanceMaterial)
			{
				return null;
			}
			
			var material : MaterialObject3D = this.materials.getMaterialByName(daeInstanceMaterial.target);
			var daeMaterial : DaeMaterial = this.document.materials[ daeInstanceMaterial.target ];
			var daeEffect : DaeEffect = daeMaterial ? this.document.effects[ daeMaterial.effect ] : null;
			var daeLambert : DaeLambert = daeEffect ? daeEffect.color as DaeLambert : null;
			var daeColorOrTexture : DaeColorOrTexture = daeLambert ? daeLambert.diffuse || daeLambert.emission : null;	
			var daeTexture : DaeTexture = daeColorOrTexture ? daeColorOrTexture.texture : null;
			var daeImage : DaeImage = (daeEffect && daeEffect.texture_url) ? this.document.images[daeEffect.texture_url] : null;
			var daeBVI : DaeBindVertexInput;

			if(daeTexture && daeTexture.texture)
			{
				daeBVI = daeInstanceMaterial.findBindVertexInput(daeTexture.texcoord);				
				outBVI.input_set = daeBVI ? daeBVI.input_set : -1;
			}
			
			if(material) 
			{
				// material already exists in #materials
				if(daeEffect && daeEffect.double_sided)
				{
					material.doubleSided = true;
				}
				return material;
			}
			
			if(daeImage && daeImage.bitmapData) 
			{
				material = new BitmapMaterial(daeImage.bitmapData.clone());
				material.tiled = true;
			}
			else if(daeColorOrTexture && daeColorOrTexture.color)
			{
				var r : int = daeColorOrTexture.color[0] * 0xff;
				var g : int = daeColorOrTexture.color[1] * 0xff;
				var b : int = daeColorOrTexture.color[2] * 0xff;	
				
				var rgb : uint = r << 16 | g << 8 | b;
				
				if(daeEffect.wireframe)
				{
					material = new WireframeMaterial(rgb, daeColorOrTexture.color[3]);	
				} 
				else
				{
					material = new ColorMaterial(rgb, daeColorOrTexture.color[3]);
				}
			}
			
			if(material)
			{
				if(daeEffect && daeEffect.double_sided)
				{
					material.doubleSided = true;
				}
				this.materials.addMaterial(material, daeInstanceMaterial.target);	
			}
			
			return material;
		}
	}
}