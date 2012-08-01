/***
swfTagV2SpTagV
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年12月27日 15:36:37
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.swf.funs{
	
	import zero.swf.*;
	import zero.swf.tagBodys.*;

	public function swfTagV2SpTagV(tagV:Vector.<Tag>):Vector.<Tag>{
		var spTagV:Vector.<Tag>=new Vector.<Tag>();
		for each(var tag:Tag in tagV){
			switch(tag.type){
				case TagTypes.SetBackgroundColor:
				case TagTypes.Protect:
				case TagTypes.ProductInfo:
				case TagTypes.EnableDebugger:
				case TagTypes.DebugID:
				case TagTypes.EnableDebugger2:
				case TagTypes.ScriptLimits:
				case TagTypes.FileAttributes:
				case TagTypes.Metadata:
				case TagTypes.DefineSceneAndFrameLabelData:
				break;
				default:
					spTagV.push(tag);
				break;
			}
		}
		return spTagV;
	}
}