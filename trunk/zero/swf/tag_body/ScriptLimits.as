/***
ScriptLimits 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年9月1日 13:07:08 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
//he ScriptLimits tag includes two fields that can be used to override the default settings for
//maximum recursion depth and ActionScript time-out: MaxRecursionDepth and
//ScriptTimeoutSeconds.
//The MaxRecursionDepth field sets the ActionScript maximum recursion limit. The default
//setting is 256 at the time of this writing. This default can be changed to any value greater
//than zero (0).
//The ScriptTimeoutSeconds field sets the maximum number of seconds the player should
//process ActionScript before displaying a dialog box asking if the script should be stopped.
//The default value for ScriptTimeoutSeconds varies by platform and is between 15 to 20
//seconds. This default value is subject to change.
//The minimum file format version is SWF 7.

//ScriptLimits
//Field 				Type 			Comment
//Header 				RECORDHEADER 	Tag type = 65
//MaxRecursionDepth 	UI16 			Maximum recursion depth
//ScriptTimeoutSeconds 	UI16 			Maximum ActionScript processing time before script stuck dialog box displays
package zero.swf.tag_body{
	import flash.utils.ByteArray;
	public class ScriptLimits extends TagBody{
		public var MaxRecursionDepth:int;		//UI16
		public var ScriptTimeoutSeconds:int;	//UI16
		//
		override public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			MaxRecursionDepth=data[offset]|(data[offset+1]<<8);
			ScriptTimeoutSeconds=data[offset+2]|(data[offset+3]<<8);
			return offset+4;
		}
		override public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			//var offset:int=0;//测试
			data[0]=MaxRecursionDepth;
			data[1]=MaxRecursionDepth>>8;
			data[2]=ScriptTimeoutSeconds;
			data[3]=ScriptTimeoutSeconds>>8;
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		override public function toXML():XML{
			return <ScriptLimits
				MaxRecursionDepth={MaxRecursionDepth}
				ScriptTimeoutSeconds={ScriptTimeoutSeconds}
			/>;
		}
		override public function initByXML(xml:XML):void{
			MaxRecursionDepth=int(xml.@MaxRecursionDepth.toString());
			ScriptTimeoutSeconds=int(xml.@ScriptTimeoutSeconds.toString());
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
