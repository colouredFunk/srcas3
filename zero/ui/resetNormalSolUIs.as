/***
resetNormalSolUIs
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年7月29日 07:21:24
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.ui{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	import mx.core.IVisualElement;
	import mx.core.IVisualElementContainer;
	
	public  function resetNormalSolUIs(ui:*):void{
		if(ui.hasOwnProperty("resetByNormalSol")){
			ui.resetByNormalSol();
		}
		if(ui is IVisualElementContainer){
			var L:int=ui.numElements;
			for(var i:int=0;i<L;i++){
				resetNormalSolUIs(ui.getElementAt(i));
			}
		}
	}
}