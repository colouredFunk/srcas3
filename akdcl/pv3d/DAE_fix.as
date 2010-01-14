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
	public class DAE_fix extends DAE
	{
		public var needWireframe:Boolean;
		private var wireframeDic:Object;
		private var backMaterialDic:Object;
		private var isWireframeNow:Boolean;
		public function DAE_fix(autoPlay:Boolean=true, name:String=null, loop:Boolean=false):void {
			super(autoPlay, name, loop);
			backMaterialDic = { };
			wireframeDic = { };
		}
		override protected function buildMaterialInstance(daeInstanceMaterial:DaeInstanceMaterial, outBVI:DaeBindVertexInput):MaterialObject3D 
		{
			if(!daeInstanceMaterial){
				return null;
			}
			var materialName:String = daeInstanceMaterial.target;
			var material : MaterialObject3D = this.materials.getMaterialByName(materialName);
			var daeMaterial : DaeMaterial = this.document.materials[ materialName ];
			var daeEffect : DaeEffect = daeMaterial ? this.document.effects[ daeMaterial.effect ] : null;
			var daeLambert : DaeLambert = daeEffect ? daeEffect.color as DaeLambert : null;
			var daeColorOrTexture : DaeColorOrTexture = daeLambert ? daeLambert.diffuse || daeLambert.emission : null;	
			var daeTexture : DaeTexture = daeColorOrTexture ? daeColorOrTexture.texture : null;
			var daeImage : DaeImage = (daeEffect && daeEffect.texture_url) ? this.document.images[daeEffect.texture_url] : null;
			var daeBVI : DaeBindVertexInput;

			if(daeTexture && daeTexture.texture){
				daeBVI = daeInstanceMaterial.findBindVertexInput(daeTexture.texcoord);				
				outBVI.input_set = daeBVI ? daeBVI.input_set : -1;
			}
			if(material) {
				// material already exists in #materials
			}else if(daeImage && daeImage.bitmapData){
				material = new BitmapMaterial(daeImage.bitmapData.clone());
				material.tiled = true;
				this.materials.addMaterial(material, materialName);
			}
			if (material) {
				if (needWireframe) {
					var _material:*= createMaterial(0x0098ff);
					wireframeDic[materialName] = _material;
					backMaterialDic[materialName] = material;
				}
				if(daeEffect && daeEffect.double_sided){
					material.doubleSided = true;
					if (_material) {
						_material.doubleSided = true;
					}
				}
			}
			return material;
		}//
		private function createMaterial(_color:uint, _alpha:Number = 0.2, _isWireframe:Boolean = true):*{
			var _material:*;
			if(_isWireframe){
				_material = new WireframeMaterial(_color,_alpha);	
			} else{
				_material = new ColorMaterial(_color, _alpha);
			}
			return _material;
		}
		public function changeMaterial(_isWireframe:Boolean):void {
			if (isWireframeNow==_isWireframe) {
				return;
			}
			isWireframeNow = _isWireframe;
			var _i:String;
			if (isWireframeNow) {
				for (_i in wireframeDic) {
					//this.materials.addMaterial(wireframeDic[_i], _i);
					replaceMaterialByName(wireframeDic[_i], _i);
				}
			}else {
				for (_i in backMaterialDic) {
					//this.materials.addMaterial(backMaterialDic[_i], _i);
					replaceMaterialByName(backMaterialDic[_i], _i);
				}
			}
		}
	}
	
}