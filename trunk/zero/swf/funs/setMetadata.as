/***
setMetadata
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月27日 18:33:42
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.swf.funs{
	
	import zero.swf.*;
	import zero.swf.tagBodys.*;
	
	public function setMetadata(swf:SWF,metadata:String):void{
		var tag:Tag,metadataTag:Tag;
		if(metadata is String){
			for each(tag in swf.tagV){
				switch(tag.type){
					case TagTypes.FileAttributes:
						tag.getBody({
							TagBodyClass:FileAttributes
						}).HasMetadata=1;
					break;
					case TagTypes.Metadata:
						tag.getBody({
							TagBodyClass:Metadata
						}).metadata=metadata;
						metadataTag=tag;
					break;
				}
			}
			if(metadataTag){
			}else{
				trace("木找到 Metadata，可考虑自动插入一个");
			}
		}else{
			for each(tag in swf.tagV){
				switch(tag.type){
					case TagTypes.FileAttributes:
						tag.getBody({
							TagBodyClass:FileAttributes
						}).HasMetadata=0;
					break;
					case TagTypes.Metadata:
						metadataTag=tag;
					break;
				}
			}
			if(metadataTag){
				swf.tagV.splice(swf.tagV.indexOf(metadataTag),1);
			}
		}
	}
}
		