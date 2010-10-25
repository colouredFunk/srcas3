/***
SWF0Board 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月14日 17:24:50
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf.ui{
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.text.*;
	import flash.utils.*;
	
	import zero.html.*;
	import zero.swf.SWF0;
	
	public class SWF0Board extends HTML{
		private var fr:FileReference;
		private var swf:SWF0;
		public function SWF0Board(){
			init(
				<html>
					<html id="modifyBoard" x="10" y="10">
						<label														text="文件名:"/>
						<label	id="fileNameTxt" 			x="80"					/>
						
						<label											y="30"		text="压缩类型:"/>
						<txt	id="typeTxt" 				x="80" 	y="30" 	width="60" height="20" type={TextFieldType.INPUT} restrict="FCWS" maxChars="3"/>
						<label	id="typeStatusTxt"		x="150"	y="30"		/>
						
						<label 										y="60" 	text="播放器版本:"/>
						<txt	id="VersionTxt" 			x="80" 	y="60" 	width="60" height="20" type={TextFieldType.INPUT} restrict="0-9" maxChars="2" />
						<label	id="VersionStatusTxt"	x="150"	y="60"		/>
						
						<label 										y="90" 	text="文件长度:"/>
						<label	id="FileLengthTxt" 		x="80" 	y="90" 	/>
						
						<btn	id="btnModify" 			x="80" 	y="120" 	text="修改" />
					</html>
					<btn id="btnBrowse" x="180" y="130" text="点击选择SWF" />
					<txt id="outputTxt" x="10" y="160" width="280" height="130"/>
				</html>,
				click,change
			);
		}
		override public function added(event:Event):void{
			super.added(event);
			
			elements["modifyBoard"].enabled=false;
			
			fr=new FileReference();
			fr.addEventListener(Event.SELECT,select);
			fr.addEventListener(Event.COMPLETE,complete);
		}
		override public function removed(event:Event):void{
			super.removed(event);
			fr.removeEventListener(Event.SELECT,select);
			fr.removeEventListener(Event.COMPLETE,complete);
		}
		private function click(btn:Btn):void{
			//super.click(event);
			//event.target;
			switch(btn.id){
				case "btnBrowse":
					fr.browse([new FileFilter("选择一个swf","*.swf")]);
				break;
				case "btnModify":
					swf.type=elements["typeTxt"].text;
					swf.Version=int(elements["VersionTxt"].text);
					new FileReference().save(swf.toSWFData(),"modify_"+fr.name);
				break;
			}
		}
		private function change(txt:Txt):void{
			updateStatuses();
		}
		
		private function select(event:Event):void{
			fr.load();
			elements["modifyBoard"].enabled=false;
		}
		
		private function complete(event:Event):void{
			swf=new SWF0();
			try{
				swf.initBySWFData(fr.data);
			}catch(e:Error){
				elements["modifyBoard"].enabled=false;
				elements["outputTxt"].text="解码失败:\n"+e;
				return;
			}
			elements["fileNameTxt"].text=fr.name;
			
			elements["typeTxt"].text=swf.type;
			
			elements["VersionTxt"].text=swf.Version.toString();
			elements["FileLengthTxt"].text=swf.FileLength+" 字节";
			
			elements["modifyBoard"].enabled=true;
			elements["outputTxt"].text="解码成功";
			
			updateStatuses();
		}
		private function updateStatuses():void{
			var canModify:Boolean=true;
			if(elements["typeTxt"].text){
				switch(elements["typeTxt"].text){
					case "CWS":
						elements["typeStatusTxt"].text="(压缩影片)";
					break;
					case "FWS":
						elements["typeStatusTxt"].text="(非压缩影片)";
					break;
					default:
						elements["typeStatusTxt"].text="未知压缩类型: "+elements["typeTxt"].text;
						canModify=false;
					break;
				}
			}else{
				elements["typeStatusTxt"].text="压缩类型不能为空";
				canModify=false;
			}
			if(elements["VersionTxt"].text){
				if(int(elements["VersionTxt"].text)>0){
					elements["VersionStatusTxt"].text="";
				}else{
					elements["VersionStatusTxt"].text="播放器版本不能为 0";
					canModify=false;
				}
			}else{
				elements["VersionStatusTxt"].text="播放器版本不能为空";
				canModify=false;
			}
			
			elements["btnModify"].enabled=canModify;
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