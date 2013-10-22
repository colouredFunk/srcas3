${info}

package ${namespace}{
	import flash.display.*;
	import flash.geom.*;
	import flash.utils.*;
	import zero.shaders.*;${imports}
	
	/**
	 * 
	 * ${description}
	 * 
	 */	
	public class ${className} extends BaseShader{
		
		public static const nameV:Vector.<String>=new <String>[${nameV}];
		//${className}Code//为了编译进来
		public static const byteV:Vector.<int>=new <int>[${byteV}];
		
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