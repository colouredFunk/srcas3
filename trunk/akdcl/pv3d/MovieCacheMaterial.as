package pv3d
{
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	import org.papervision3d.core.render.command.RenderTriangle;
	import org.papervision3d.core.render.data.RenderSessionData;
	import org.papervision3d.core.render.draw.ITriangleDrawer;
	import org.papervision3d.core.render.material.IUpdateAfterMaterial;
	import org.papervision3d.core.render.material.IUpdateBeforeMaterial;
	import org.papervision3d.materials.MovieMaterial;

	public class MovieCacheMaterial extends MovieMaterial implements ITriangleDrawer, IUpdateBeforeMaterial, IUpdateAfterMaterial
	{
		private var movieAsset:MovieClip;
		private var cache:Array = [];
		private var materialIsDrawn:Boolean = false;
		
		public function MovieCacheMaterial( movieAsset:MovieClip=null, transparent:Boolean=false, animated:Boolean=false, precise:Boolean=false, rect:Rectangle=null )
		{
			this.movieAsset = movieAsset;
			super(movieAsset, transparent, animated, precise, rect);
			
			if(!movieCache[movieAsset]){
				cache = new Array();
				movieCache[movieAsset] = cache;
				
			}else{
				cache = movieCache[movieAsset];
			}
			
		}
		
		
		private var completeHandler:Function;
		private var fr:Number = 0;
		
		public function ripMovie(stage:Stage, frameRate:Number, completeHandler:Function):void{
			
			stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			fr = stage.frameRate;
			stage.frameRate = frameRate;
			movieAsset.play();
			this.completeHandler = completeHandler;
			
		}
		
		private function onEnterFrame(e:Event):void{
			
			var finished:Boolean = (movieAsset.currentFrame == movieAsset.totalFrames);
			drawBitmap();
			//the caching is ironically being done in the updatebeforerender for the material
			
			if(finished){
				Stage(e.target).removeEventListener(Event.ENTER_FRAME, onEnterFrame);
				Stage(e.target).frameRate = fr;
				completeHandler();
			}
		}
		
		private var useCached:Boolean = false;
		
		public override function updateBeforeRender(renderSessionData:RenderSessionData):void
		{
			materialIsDrawn = false;
			useCached = (cache[movieAsset.currentFrame-1] != null);
			if(useCached){
				bitmap = cache[movieAsset.currentFrame-1];
			}else{
				
				super.updateBeforeRender(renderSessionData);
				
				cache[movieAsset.currentFrame-1] = getNewCachedBitmap();
			}
		}
		
		private function getNewCachedBitmap():BitmapData{
			var bmp:BitmapData = new BitmapData(bitmap.width, bitmap.height, this.movieTransparent, this.fillColor);
				bmp.copyPixels(bitmap, bitmap.rect, new Point());
				return bmp;
		}
		
		public override function updateAfterRender(renderSessionData:RenderSessionData):void
		{
			
			if(!useCached){
				super.updateAfterRender(renderSessionData);
				if(!materialIsDrawn){
					drawBitmap();
				}
			}
				
		}
		
		override public function drawTriangle(tri:RenderTriangle, graphics:Graphics, renderSessionData:RenderSessionData, altBitmap:BitmapData=null, altUV:Matrix=null):void
		{
			materialIsDrawn = true;
			super.drawTriangle(tri, graphics, renderSessionData, altBitmap, altUV);
		}
		
		protected static var movieCache:Dictionary = new Dictionary(true);
		
	}
}