/***
SWFLevel1 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年8月11日 12:12:11
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf{
	import _swf._tag._body.*;
	
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	
	public class SWFLevel1 extends SWFLevel0{
		private var fileAttributes:FileAttributes;
		private var setBackgroundColor:SetBackgroundColor;
		
		private var setBackgroundColorTag:Tag;
		private var fileAttributesTag:Tag;
		private var metadataTag:Tag;
		
		public function SWFLevel1(){
			fileAttributes=new FileAttributes();
			setBackgroundColor=new SetBackgroundColor();
			isAS3=true;//默认AS3
			bgColor=0xffffff;//默认白色
		}
		
		//
		public function get isAS3():Boolean{
			return fileAttributes.ActionScript3==1;
		}
		public function set isAS3(_isAS3:Boolean):void{
			fileAttributes.ActionScript3=(_isAS3?1:0);
		}
		public function get UseNetwork():Boolean{
			return fileAttributes.UseNetwork==1;
		}
		public function set UseNetwork(_UseNetwork:Boolean):void{
			fileAttributes.UseNetwork=(_UseNetwork?1:0);
		}
		public function get HasMetadata():Boolean{
			return fileAttributes.UseNetwork==1;
		}
		public function set HasMetadata(_HasMetadata:Boolean):void{
			fileAttributes.HasMetadata=(_HasMetadata?1:0);
		}
		
		//
		public function get bgColor():int{
			return setBackgroundColor.BackgroundColor;
		}
		public function set bgColor(_bgColor:int):void{
			setBackgroundColor.BackgroundColor=_bgColor;
		}
		
		override public function initByData(data:ByteArray):void{
			super.initByData(data);
			isAS3=false;
			dataAndTags.forEachTag(getInfosByTag);
		}
		private function getInfosByTag(data:ByteArray,tag:Tag,tagV:Vector.<Tag>,tagId:int):void{
			switch(tag.type){
				case TagType.SetBackgroundColor:
					setBackgroundColor.initByDataNow(data,tag.bodyOffset);
				break;
				case TagType.FileAttributes:
					fileAttributes.initByDataNow(data,tag.bodyOffset);
				break;
			}
		}
		override public function toData():ByteArray{
			setBackgroundColorTag=null;
			fileAttributesTag=null;
			metadataTag=null;
			
			dataAndTags.forEachTag(updateInfoTag);
			
			if(!setBackgroundColorTag){
				setBackgroundColorTag=new Tag();
			}
			if(!fileAttributesTag){
				fileAttributesTag=new Tag();
			}
			setBackgroundColorTag.updateByBodyData(setBackgroundColor);
			dataAndTags.tagV.unshift(setBackgroundColorTag);
			if(HasMetadata){
				if(metadataTag){
					//metadataTag.updateByBodyData(metadata);
					dataAndTags.tagV.unshift(metadataTag);
				}else{
					HasMetadata=false;
				}
			}
			if(isAS3){
				if(Version<9){
					throw new Error("Version="+Version+", 不支持AS3");
					//Version=9;
				}
			}
			fileAttributesTag.updateByBodyData(fileAttributes);
			dataAndTags.tagV.unshift(fileAttributesTag);
			
			return super.toData();
		}
		private function updateInfoTag(data:ByteArray,tag:Tag,tagV:Vector.<Tag>,tagId:int):void{
			switch(tag.type){
				case TagType.SetBackgroundColor:
					setBackgroundColorTag=tag;
					tagV.splice(tagId,1);
				break;
				case TagType.FileAttributes:
					fileAttributesTag=tag;
					tagV.splice(tagId,1);
				break;
				case TagType.Metadata:
					metadataTag=tag;
					tagV.splice(tagId,1);
				break;
			}
		}
	}
}

//

// 常忘正则表达式
// /^\s*|\s*$/					//前后空白						"\nabc d  e 哈 哈\t \r".replace(/^\s*|\s*$/g,"") === "abc d  e 哈 哈"
// /[\\\/:*?\"<>|]/				//不合法的windows文件名字符集		"\\\/:*?\"<>|\\\/:*哈 哈?\"<>|\\哈 \/:*?\"<>|".replace(/[\\\/:*?\"<>|]/g,"") === "哈 哈哈 "
// /[a-zA-Z_][a-zA-Z0-9_]*/		//合法的变量名(不考虑中文)
// value=value.replace(/[^a-zA-Z0-9_]/g,"").replace(/^[0-9]*/,"");//替换不合法的变量名
// 先把除字母数字下划线的字符去掉,再把开头的数字去掉
// 想不到怎样能用一个正则表达式搞定...

//正则表达式30分钟入门教程		http://www.unibetter.com/deerchao/zhengzhe-biaodashi-jiaocheng-se.htm
//正则表达式用法及实例			http://eskimo.blogbus.com/logs/29095458.html
//常用正则表达式					http://www.williamlong.info/archives/433.html

/*

//常用值

//常用语句块

*/