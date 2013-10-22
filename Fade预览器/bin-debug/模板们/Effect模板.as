${info}

package ${namespace}{
	import flash.display.*;
	import flash.geom.*;
	import flash.utils.*;
	import zero.shaders.Float2;
	import zero.shaders.Pixel4;
	import zero.stage3Ds.*;${imports}
	
	/**
	 * 
	 * ${description}
	 * 
	 */	
	public class ${className} extends BaseEffect{
		
		public static const nameV:Vector.<String>=new <String>[${nameV}];
		//${className}Code//为了编译进来
		public static const byteV:Vector.<int>=new <int>[${byteV}];
		
		public static const data:Vector.<Number>=new <Number>[${data}];
		data.fixed=true;
		
${params}
		/**
		 * 
${paramsInfo}		 * 
		 */
		public function ${className}(${_params}){
${initParams}		}
		
		override public function updateParams():void{
${updateParams}		}
		
${updateInputs}
	}
}