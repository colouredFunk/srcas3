/***
AGAL2ByteV
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年12月11日 20:46:50
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.stage3Ds{
	import com.adobe.utils.AGALMiniAssembler;
	
	import flash.utils.ByteArray;
	
	import zero.BytesAndStr16;

	public function AGAL2ByteV(mode:String,source:String):ByteArray{
		var agalMiniAssembler:AGALMiniAssembler=new AGALMiniAssembler();
		source=("\n"+source)
			.replace(/\s*\n\s*/g,"\n")
			.replace(/\n\/\/.*/g,"")
			.replace(/\/\/.*\n/g,"\n")
			.replace(/^\s*|\s*$/g,"")
			.replace(/\s*\n\s*/g,"\n");
		for each(var matchStr:String in source.match(/\.[rgba]+/g)){
			source=source.replace(matchStr,matchStr.replace(/r/g,"x").replace(/g/g,"y").replace(/b/g,"z").replace(/a/g,"w"));
		}
		trace(source);
		agalMiniAssembler.assemble(mode,source);
		//trace("var byteV:Vector.<int>=new <int>[0x"+BytesAndStr16.bytes2str16(agalMiniAssembler.agalcode,0,agalMiniAssembler.agalcode.length).replace(/ /g,",0x")+"];");
		//trace("0x"+BytesAndStr16.bytes2str16(agalMiniAssembler.agalcode,0,agalMiniAssembler.agalcode.length).replace(/ /g,",0x"));
		return agalMiniAssembler.agalcode;
	}
}