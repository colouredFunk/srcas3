/***
SWFInfoEditor 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年8月23日 21:30:39
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	
	import zero.swf.tag_body.DebugID;
	import zero.swf.tag_body.EnableDebugger2;
	import zero.swf.tag_body.ScriptLimits;
	import zero.swf.tag_body.SetBackgroundColor;
	//import zero.swf.tag_body.ProductInfo;
	
	public class SWFInfoEditor{
		
		public var enableDebugger2_password:String;
		public var debugIDStr:String;
		public var MaxRecursionDepth:int;
		public var ScriptTimeoutSeconds:int;
		public var bgColor:int;
		
		public function SWFInfoEditor(){
			bgColor=0xffffff;
		}
		public function initBySWF(swf:SWFLevel0):void{
			for each(var tag:Tag in swf.dataAndTags.tagV){
				switch(tag.type){
					case TagType.EnableDebugger2:
						var enableDebugger2:EnableDebugger2;
						if(tag.tagBody){
							enableDebugger2=tag.tagBody as EnableDebugger2;
						}else{
							enableDebugger2=new EnableDebugger2();
							enableDebugger2.initByData(tag.bodyData,tag.bodyOffset,tag.bodyOffset+tag.bodyLength);
						}
						enableDebugger2_password=enableDebugger2.password;
					break;
					case TagType.DebugID:
						var debugID:DebugID;
						if(tag.tagBody){
							debugID=tag.tagBody as DebugID;
						}else{
							debugID=new DebugID();
							debugID.initByData(tag.bodyData,tag.bodyOffset,tag.bodyOffset+tag.bodyLength);
						}
						debugIDStr=debugID.id;
					break;
					case TagType.ScriptLimits:
						var scriptLimits:ScriptLimits;
						if(tag.tagBody){
							scriptLimits=tag.tagBody as ScriptLimits;
						}else{
							scriptLimits=new ScriptLimits();
							scriptLimits.initByData(tag.bodyData,tag.bodyOffset,tag.bodyOffset+tag.bodyLength);
						}
						MaxRecursionDepth=scriptLimits.MaxRecursionDepth;
						ScriptTimeoutSeconds=scriptLimits.ScriptTimeoutSeconds;
					break;
					case TagType.SetBackgroundColor:
						var setBackgroundColor:SetBackgroundColor;
						if(tag.tagBody){
							setBackgroundColor=tag.tagBody as SetBackgroundColor;
						}else{
							setBackgroundColor=new SetBackgroundColor();
							setBackgroundColor.initByData(tag.bodyData,tag.bodyOffset,tag.bodyOffset+tag.bodyLength);
						}
						bgColor=setBackgroundColor.BackgroundColor;
					break;
				}
			}
		}
		public function updateSWF(swf:SWFLevel0):void{
			var tagV:Vector.<Tag>=swf.dataAndTags.tagV;
			
			//
			var fileAttributesTag:Tag;
			var metadataTag:Tag;
			
			//
			var tagId:int=tagV.length;
			var tag:Tag;
			while(--tagId>=0){
				tag=tagV[tagId];
				switch(tag.type){
					case TagType.FileAttributes:
						fileAttributesTag=tag;
						tagV.splice(tagId,1);
					break;
					case TagType.Metadata:
						metadataTag=tag;
						tagV.splice(tagId,1);
					break;
					case TagType.EnableDebugger2:
					case TagType.DebugID:
					case TagType.ScriptLimits:
					case TagType.SetBackgroundColor:
						tagV.splice(tagId,1);
					break;
				}
			}
			
			//
			if(enableDebugger2_password){
				var enableDebugger2:EnableDebugger2=new EnableDebugger2();
				enableDebugger2.password=enableDebugger2_password;
				tag=new Tag();
				tag.tagBody=enableDebugger2;
				tagV.unshift(tag);
			}
			
			//
			if(debugIDStr){
				var debugID:DebugID=new DebugID();
				debugID.id=debugIDStr;
				tag=new Tag();
				tag.tagBody=debugID;
				tagV.unshift(tag);
			}
			
			//
			if(MaxRecursionDepth>0&&ScriptTimeoutSeconds>0){
				var scriptLimits:ScriptLimits=new ScriptLimits();
				scriptLimits.MaxRecursionDepth=MaxRecursionDepth;
				scriptLimits.ScriptTimeoutSeconds=ScriptTimeoutSeconds;
				tag=new Tag();
				tag.tagBody=scriptLimits;
				tagV.unshift(tag);
			}
			
			//
			var setBackgroundColor:SetBackgroundColor=new SetBackgroundColor();
			setBackgroundColor.BackgroundColor=bgColor;
			tag=new Tag();
			tag.tagBody=setBackgroundColor;
			tagV.unshift(tag);
			
			//
			if(metadataTag){
				tagV.unshift(metadataTag);
			}	
			if(fileAttributesTag){
				tagV.unshift(fileAttributesTag);
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