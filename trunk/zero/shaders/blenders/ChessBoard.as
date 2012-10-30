/***
ChessBoard
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年10月30日 16:08:26
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.shaders.blenders{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	import zero.shaders.BaseShader;
	
	/**
	 * 
	 * 棋盘
	 * 
	 */	
	public class ChessBoard extends BaseShader{
		
		private static const code:ChessBoardCode=new ChessBoardCode();
		
		/**
		 * 
		 * @param _dimension 格子大小（1~100），默认20
		 * @param _whiteColor 白颜色
		 * @param _blackColor 黑颜色
		 * 
		 */		
		public function ChessBoard(_dimension:int=20,_whiteColor:uint=0xffffffff,_blackColor:uint=0x00000000){
			super(code);
			dimension=_dimension;
			whiteColor=_whiteColor;
			blackColor=_blackColor;
		}
		
		/**
		 * 
		 * 格子大小（1~100），默认20
		 * 
		 */		
		public function get dimension():int{
			return (data.dimension as ShaderParameter).value[0];
		}
		public function set dimension(_dimension:int):void{
			(data.dimension as ShaderParameter).value=[_dimension];
		}
		
		/**
		 * 
		 * 白颜色
		 * 
		 */		
		public function get whiteColor():uint{
			var value:Array=(data.whiteColor as ShaderParameter).value;
			return (int(value[0]*0xff)<<16)|(int(value[1]*0xff)<<8)|int(value[2]*0xff)|(int(value[3]*0xff)<<24);
		}
		public function set whiteColor(_whiteColor:uint):void{
			(data.whiteColor as ShaderParameter).value=[
				((_whiteColor>>16)&0xff)/0xff,
				((_whiteColor>>8)&0xff)/0xff,
				(_whiteColor&0xff)/0xff,
				((_whiteColor>>24)&0xff)/0xff
			];
		}
		
		/**
		 * 
		 * 黑颜色
		 * 
		 */		
		public function get blackColor():uint{
			var value:Array=(data.blackColor as ShaderParameter).value;
			return (int(value[0]*0xff)<<16)|(int(value[1]*0xff)<<8)|int(value[2]*0xff)|(int(value[3]*0xff)<<24);
		}
		public function set blackColor(_blackColor:uint):void{
			(data.blackColor as ShaderParameter).value=[
				((_blackColor>>16)&0xff)/0xff,
				((_blackColor>>8)&0xff)/0xff,
				(_blackColor&0xff)/0xff,
				((_blackColor>>24)&0xff)/0xff
			];
		}
	}
}