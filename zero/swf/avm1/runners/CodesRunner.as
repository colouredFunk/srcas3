﻿/***
CodesRunner
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月10日 08:44:53
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.swf.avm1.runners{
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.system.fscommand;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import flash.utils.getTimer;
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;
	
	import zero.swf.avm1.AVM1Ops;

	public class CodesRunner{
		public function run(data:*,thisObj:*=null):*{
			if(data is ByteArray){
			}else{
				data=str162bytes(data);
			}
			
			var offset:int=0,jumpOffset:int;
			var endOffset:int=data.length;
			
			var stack:Array=new Array();
			var registerArr:Array=new Array();
			var obj:*,value:*,value1:*,value2:*;
			
			var Length:int;
			var get_str_size:int;
			
			var constStrV:Vector.<String>;
			var i:int,flags:int;
			
			var fName:*;//不能用 String 否则 undefined 就自动转成 null 了...
			var argsArr:Array;
			
			var varName:String;
			var vars:Object=new Object();
			if(thisObj){
				vars["this"]=thisObj;
				if(thisObj.hasOwnProperty("root")){
					vars["_root"]=thisObj.root;
				}
				if(thisObj.hasOwnProperty("parent")){
					vars["_parent"]=thisObj.parent;
				}
			}
			
			loop:while(offset<endOffset){
				var pos:int=offset;
				
				var op:int=data[offset++];
				
				if(op<0x80){
				}else{
					Length=data[offset++]|(data[offset++]<<8);
				}
				
				switch(op){
					case AVM1Ops.end:
						//<ActionEnd op="0x00" opName="end" opNameFlasm="end" opNameASV="end" opNameSothink="_end"/>
						break loop;
					break;
					//<!--SWF 3 actions-->
					//case AVM1Ops.gotoFrame:
						//<ActionGotoFrame op="0x81" opName="gotoFrame" opNameFlasm="gotoFrame" opNameASV="gotoFrame" opNameSothink="_gotoFrame" has2="true">
						//	<description><![CDATA[
						//			//ActionGotoFrame
						//			//ActionGotoFrame instructs Flash Player to go to the specified（指定） frame in the current file.
						//			//Field 				Type 					Comment
						//			//ActionGotoFrame 		ACTIONRECORDHEADER 		ActionCode = 0x81; Length is always 2
						//			//Frame 				UI16 					Frame index
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<help><![CDATA[
						//				gotoAndStop 函数
						//				gotoAndStop([scene:String], frame:Object) : Void
						//				
						//				将播放头转到场景中指定的帧并停止播放。如果未指定场景，播放头将转到当前场景中的帧。只能在根时间轴上使用 scene 参数，不能在影片剪辑或文档中的其它对象的时间轴内使用该参数。
						//				
						//				可用性：Flash Player 2；ActionScript 1.0
						//				
						//				参数
						//				scene:String [可选] - 一个字符串，指定播放头要转到其中的场景的名称。
						//				
						//				frame:Object - 表示播放头转到的帧编号的数字，或者表示播放头转到的帧标签的字符串。
						//			]]></help>
						//			<as><![CDATA[
						//				gotoAndStop(1235);
						//			]]></as>
						//			<pcode><![CDATA[
						//				gotoFrame 1234
						//			]]></pcode>
						//		</sample>
						//		<sample>
						//			<help><![CDATA[
						//				gotoAndPlay 函数
						//				gotoAndPlay([scene:String], frame:Object) : Void
						//
						//				将播放头转到场景中指定的帧并从该帧开始播放。如果未指定场景，则播放头将转到当前场景中的指定帧。只能在根时间轴上使用 scene 参数，不能在影片剪辑或文档中的其它对象的时间轴内使用该参数。
						//				
						//				可用性：Flash Player 2；ActionScript 1.0
						//				
						//				参数
						//				scene:String [可选] - 一个字符串，指定播放头要转到其中的场景的名称。
						//				
						//				frame:Object - 表示播放头转到的帧编号的数字，或者表示播放头转到的帧标签的字符串。
						//			]]></help>
						//			<as><![CDATA[
						//				gotoAndPlay(1235);
						//			]]></as>
						//			<pcode><![CDATA[
						//				gotoFrame 1234
						//				play
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionGotoFrame>
					//break;
					case AVM1Ops.getURL:
						//<ActionGetURL op="0x83" opName="getURL" opNameFlasm="getURL" opNameASV="getUrl" opNameSothink="_getURL" has2="true">
						//	<description><![CDATA[
						//			//ActionGetURL
						//			//ActionGetURL instructs Flash Player to get the URL that UrlString specifies. The URL can
						//			//be of any type, including an HTML file, an image or another SWF file. If the file is playing in
						//			//a browser, the URL is displayed in the frame that TargetString specifies. The "_level0" and
						//			//"_level1" special target names are used to load another SWF file into levels 0 and 1 respectively.
						//			//Field 				Type 					Comment
						//			//ActionGetURL 			ACTIONRECORDHEADER 		ActionCode = 0x83
						//			//UrlString 			STRING 					Target URL string
						//			//TargetString 			STRING 					Target string
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<help><![CDATA[
						//				getURL 函数
						//				getURL(url:String, [window:String, [method:String]]) : Void
						//
						//				将来自特定 URL 的文档加载到窗口中，或将变量传递到位于所定义的 URL 的另一个应用程序。若要测试此函数，请确保要加载的文件位于指定的位置。若要使用绝对 URL（例如，http://www.myserver.com），则需要网络连接。
						//				
						//				可用性：Flash Player 4；ActionScript 1.0
						//				
						//				参数
						//				url:String - 可从该处获取文档的 URL。
						//				
						//				window:String [可选] - 指定应将文档加载到其中的窗口或 HTML 帧。您可输入特定窗口的名称，或从下面的保留目标名称中选择： 
						//				
						//				_self 指定当前窗口中的当前帧。 
						//				_blank 指定一个新窗口。 
						//				_parent 指定当前帧的父级。 
						//				_top 指定当前窗口中的顶级帧。 
						//				method:String [可选] - 用于发送变量的 GET 或 POST 方法。如果没有变量，则省略此参数。GET 方法将变量附加到 URL 的末尾，它用于发送少量的变量。POST 方法在单独的 HTTP 标头中发送变量，它用于发送长字符串的变量。
						//			]]></help>
						//			<as><![CDATA[
						//				getURL("http://zero.flashwing.net", "_blank");
						//			]]></as>
						//			<pcode><![CDATA[
						//				getURL "http://zero.flashwing.net","_blank"
						//			]]></pcode>
						//		</sample>
						//		<sample>
						//			<help><![CDATA[
						//				fscommand 函数
						//				fscommand(command:String, parameters:String) : Void
						//				
						//				使 SWF 文件与 Flash Player 或承载 Flash Player 的程序（如 Web 浏览器）进行通讯。还可以使用 fscommand() 函数将消息传递给 Macromedia Director，或者传递给 Visual Basic (VB)、Visual C++ 和其它可承载 ActiveX 控件的程序。
						//				
						//				fscommand() 函数使 SWF 文件与 Web 页中的脚本能进行通讯。不过，脚本访问是由 Web 页的 allowScriptAccess 设置控制的。（您可以在嵌入 SWF 文件的 HTML 代码中设置此属性 - 例如，在 Internet Explorer 的 PARAM 标签或 Netscape 的 EMBED 标签中。）当 allowScriptAccess 设置为 "never" 时，SWF 文件无法访问 Web 页脚本。对于 Flash Player 7 及更高版本，当 allowScriptAccess 设置为 "always" 时，SWF 文件始终可以访问 Web 页脚本。当 allowScriptAccess 设置为 "sameDomain" 时，只允许从与该 Web 页位于同一域中的 SWF 文件进行脚本访问；对于以前版本的 Flash Player，始终允许脚本访问。如果在 HTML 页中未指定 allowScriptAccess，则默认情况下，对于第 8 版及更高版本的 SWF 文件，该属性设置为 "sameDomain"；对于第 7 版及更低版本的 SWF 文件，设置为 "always"。 
						//				
						//				用法 1：若要使用 fscommand() 将消息发送给 Flash Player，必须使用预定义的命令和参数。下表列出了可以为 fscommand() 函数的 command 参数和 parameters 参数指定的值。这些值控制在 Flash Player 中播放的 SWF 文件，包括放映文件。（放映文件 是以可作为独立应用程序运行（也就是说，不需要使用 Flash Player 即可运行）的格式保存的 SWF 文件。）
						//				
						//				命令
						//				 参数
						//				 目的
						//				 
						//				quit
						//				 无
						//				 关闭放映文件。
						//				 
						//				fullscreen
						//				 true 或者 false
						//				 指定 true 可将 Flash Player 设置为全屏模式。指定 false 可将播放器返回到标准菜单视图。
						//				 
						//				allowscale
						//				 true 或者 false
						//				 指定 false 可设置播放器始终按 SWF 文件的原始大小绘制 SWF 文件，从不进行缩放。指定 true 会强制将 SWF 文件缩放到播放器的 100% 大小。
						//				 
						//				showmenu
						//				 true 或者 false
						//				 指定 true 可启用整个上下文菜单项集合。指定 false 将隐藏除"关于 Flash Player"和"设置"外的所有上下文菜单项。
						//				 
						//				exec
						//				 应用程序的路径 
						//				 在放映文件内执行应用程序。
						//				 
						//				trapallkeys
						//				 true 或者 false
						//				 指定 true 可将所有按键事件（包括快捷键）发送到 Flash Player 中的 onClipEvent(keyDown/keyUp) 处理函数。 
						//				 
						//				
						//				可用性： 
						//				
						//				表中描述的命令在 Web 播放器中都不可用。 
						//				所有这些命令在独立的应用程序（例如，放映文件）中都可用。 
						//				只有 allowscale 和 exec 在测试影片播放器中可用。 
						//				exec 命令只能包含字符 A-Z、a-z、0-9、句号 (.) 和下划线 (_)。exec 命令仅在 fscommand 子目录中运行。也就是说，如果您使用 exec 命令调用应用程序，该应用程序必须位于名为 fscommand 的子目录中。exec 命令只在 Flash 放映文件内起作用。
						//				
						//				用法 2：若要使用 fscommand() 向 Web 浏览器中的脚本语言（例如 JavaScript）发送消息，您可以在 command 和 parameters 参数中传递任意两个参数。这些参数可以是字符串或表达式，并在处理或捕获 fscommand() 函数的 JavaScript 函数中使用。 
						//				
						//				在 Web 浏览器中，fscommand() 调用 JavaScript 函数 moviename_DoFScommand，该函数位于包含 SWF 文件的 Web 页中。对于 moviename，提供您用于 EMBED 标签的 NAME 属性或 OBJECT 标签的 ID 属性的 Flash 对象的名称。如果对 SWF 文件分配名称 myMovie，则调用 JavaScript 函数 myMovie_DoFScommand。 
						//				
						//				在包含 SWF 文件的 Web 页中，设置 allowScriptAccess 属性以允许或拒绝 SWF 文件访问 Web 页的能力。（您可以在嵌入 SWF 文件的 HTML 代码中设置此属性，例如，在 Internet Explorer 的 PARAM 标签或 Netscape 的 EMBED 标签中。）当 allowScriptAccess 设置为 "never" 时，外出脚本处理始终失败。当 allowScriptAccess 设置为 "always" 时，外出脚本处理始终成功。当它设置为 "sameDomain" 时，只允许从与该 Web 页位于同一域中的 SWF 文件进行脚本访问。如果未在 Web 页中指定 allowScriptAccess，则对于 Flash Player 8，它默认为 "sameDomain"；对于以前的 Flash Player 版本，它默认为 "always"。 
						//				
						//				使用此函数时，请考虑 Flash Player 安全模型。对于 Flash Player 8，如果执行调用的 SWF 文件在只能与本地文件系统内容交互的沙箱或只能与远程内容交互的沙箱中，并且所包含的 HTML 页在不受信任的沙箱中，则不允许使用 fscommand() 函数。有关更多信息，请参见以下部分： 
						//				
						//				"学习 Flash 中的 ActionScript 2.0"的第 17 章，"了解安全性" 
						//				Flash Player 8 安全性白皮书 
						//				Flash Player 8 与安全相关的 API 白皮书 
						//				用法 3：fscommand() 函数可以将消息发送给 Macromedia Director。这些消息由 Lingo（Director 脚本语言）解释为字符串、事件或可执行 Lingo 代码。如果消息为字符串或事件，则必须编写 Lingo 代码才能从 fscommand() 函数接收该消息并在 Director 中执行动作。有关更多信息，请访问 Director 支持中心，网址为 www.macromedia.com/support/director。
						//				
						//				用法 4：在 VisualBasic、Visual C++ 和可承载 ActiveX 控件的其它程序中，fscommand() 利用可使用环境的编程语言处理的两个字符串发送 VB 事件。有关更多信息，请使用关键字"Flash 方法"搜索 Flash 支持中心，网址为 www.macromedia.com/go/flash_support_cn。
						//				
						//				注意：如果要为 Flash Player 8 或更高版本发布，则 ExternalInterface 类可为以下通讯提供更好的性能：JavaScript 与 ActionScript 之间的通讯（用法 2）；ActionScript 与 VisualBasic、Visual C++ 或可承载 ActiveX 控件的其它程序之间的通讯（用法 4）。您应该继续使用 fscommand() 将消息发送到 Flash Player（用法 1）和 Macromedia Director（用法 3）。
						//				
						//				可用性：Flash Player 3；ActionScript 1.0
						//				
						//				参数
						//				command:String - 传递给主机应用程序用于任何用途的一个字符串，或传递给 Flash Player 的一个命令。
						//				
						//				parameters:String - 传递给主机应用程序用于任何用途的一个字符串，或传递给 Flash Player 的一个值。
						//			]]></help>
						//			<as><![CDATA[
						//				fscommand("fullscreen","true");
						//			]]></as>
						//			<pcode><![CDATA[
						//				getURL "FSCommand:fullscreen","true"
						//			]]></pcode>
						//		</sample>
						//		<sample>
						//			<help><![CDATA[
						//				loadMovieNum 函数
						//				loadMovieNum(url:String, level:Number, [method:String]) : Void
						//				
						//				在播放原始 SWF 文件时，将 SWF、JPEG、GIF 或 PNG 文件加载到一个级别中。在 Flash Player 8 中添加了对非动画 GIF 文件、PNG 文件和渐进式 JPEG 文件的支持。如果加载动画 GIF，则仅显示第一帧。
						//				
						//				提示：如果您要监视下载的进度，则使用 MovieClipLoader.loadClip() 而不是此函数。 
						//				
						//				一般情况下，Flash Player 显示单个 SWF 文件，然后关闭。loadMovieNum() 动作使您可以一次显示多个 SWF 文件，并且无需加载另一个 HTML 文档即可在 SWF 文件之间进行切换。
						//				
						//				如果要指定目标而不是级别，请使用 loadMovie() 而不是 loadMovieNum()。
						//				
						//				Flash Player 具有从级别 0 开始的级别堆叠顺序。这些级别类似于醋酸纤维层；除了每个级别上的对象之外，它们是透明的。当使用 loadMovieNum() 时，必须指定 SWF 文件将加载到 Flash Player 中的哪个级别。在 SWF 文件加载到某个级别后，即可使用语法 _level N 定位该 SWF 文件，其中 N 为级别号。
						//				
						//				当加载 SWF 文件时，可指定任何级别号，并且可将 SWF 文件加载到已加载有 SWF 文件的级别。如果执行此动作，则新的 SWF 文件将替换现有的 SWF 文件。如果将 SWF 文件加载到级别 0，则 Flash Player 中的每个级别均被卸载，并且级别 0 将替换为该新文件。处于级别 0 的 SWF 文件为其它所有加载的 SWF 文件设置帧频、背景色和帧大小。
						//				
						//				loadMovieNum() 动作也允许您在播放 SWF 文件时将 JPEG 文件加载到该 SWF 文件中。对于图像和 SWF 文件，在加载文件时，图像的左上角均与舞台的左上角对齐。另外，在这两种情况下，加载的文件均继承旋转和缩放设置，并且原始内容将在指定级别中被覆盖。 
						//				
						//				注意：不支持以渐进格式保存的 JPEG 文件。
						//				
						//				使用 unloadMovieNum() 可删除用 loadMovieNum() 加载的 SWF 文件或图像。
						//				
						//				使用此方法时，请考虑 Flash Player 安全模型。 
						//				
						//				对于 Flash Player 8： 
						//				
						//				如果执行调用的影片剪辑在只能与本地文件系统的内容交互的沙箱中，并且被加载的影片剪辑来自网络沙箱，则不允许加载。 
						//				如果执行调用的 SWF 文件在网络沙箱中并且要加载的影片剪辑是本地的，则不允许加载。 
						//				从受信任的本地沙箱或从只能与远程内容交互的沙箱访问网络沙箱需要通过跨域策略文件获得网站的许可。 
						//				在只能与本地文件系统的内容交互的沙箱中的影片剪辑不能对只能与远程内容交互的沙箱中的影片剪辑使用脚本（反之也是禁止的）。 
						//				对于 Flash Player 7 及更高版本： 
						//				
						//				网站可以允许通过跨域策略文件来跨域访问资源。 
						//				基于 SWF 文件的原始域，在各 SWF 文件之间使用脚本受到限制。使用 System.security.allowDomain() 方法可调整这些限制。 
						//				有关更多信息，请参见以下部分： 
						//				
						//				"学习 Flash 中的 ActionScript 2.0"的第 17 章，"了解安全性" 
						//				Flash Player 8 安全性白皮书 
						//				Flash Player 8 与安全相关的 API 白皮书 
						//				可用性：Flash Player 4；ActionScript 1.0
						//				
						//				参数
						//				url:String - 要加载的 SWF 文件或 JPEG 文件的绝对或相对 URL。相对路径必须相对于级别 0 处的 SWF 文件。为了在独立的 Flash Player 中使用 SWF 文件或在 Flash 创作应用程序的测试模式下测试 SWF 文件，必须将所有的 SWF 文件存储在同一个文件夹中，并且其文件名不能包含文件夹或磁盘驱动器的规格。
						//				
						//				level:Number - 一个整数，指定 SWF 文件将加载到 Flash Player 中的哪个级别。
						//				
						//				method:String [可选] - 指定用于发送变量的 HTTP 方法。该参数必须是字符串 GET 或 POST。如果没有要发送的变量，则省略此参数。GET 方法将变量附加到 URL 的末尾，它用于发送少量的变量。POST 方法在单独的 HTTP 标头中发送变量，它用于发送长字符串的变量。
						//			]]></help>
						//			<as><![CDATA[
						//				loadMovieNum("http://zero.flashwing.net", 1234);
						//			]]></as>
						//			<pcode><![CDATA[
						//				getURL "http://zero.flashwing.net","_level1234"
						//			]]></pcode>
						//		</sample>
						//		<sample>
						//			<help><![CDATA[
						//				unloadMovieNum 函数
						//				unloadMovieNum(level:Number) : Void
						//				
						//				从 Flash Player 中删除通过 loadMovieNum() 加载的 SWF 或图像。若要卸载通过 MovieClip.loadMovie() 加载的 SWF 或图像，应使用 unloadMovie() 而不是 unloadMovieNum()。
						//				
						//				可用性：Flash Player 3；ActionScript 1.0
						//				
						//				参数
						//				level:Number - 加载的影片的级别 (_level N)。
						//			]]></help>
						//			<as><![CDATA[
						//				unloadMovieNum(1234);
						//			]]></as>
						//			<pcode><![CDATA[
						//				getURL "","_level1234"
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionGetURL>
						get_str_size=0;
						while(data[offset+(get_str_size++)]){}
						data.position=offset;
						value1=data.readUTFBytes(get_str_size);
						offset+=get_str_size;
						get_str_size=0;
						while(data[offset+(get_str_size++)]){}
						data.position=offset;
						value2=data.readUTFBytes(get_str_size);
						offset+=get_str_size;
						if(value1.indexOf("FSCommand:")==0){
							fscommand(value1.replace("FSCommand:",""),value2);
						}else{
							if(value2.indexOf("_level")==0){
								throw new Error("暂不支持 loadMovie");
							}else{
								navigateToURL(new URLRequest(value1),value2);
							}
						}
					break;		
					//case AVM1Ops.nextFrame:
						//<ActionNextFrame op="0x04" opName="nextFrame" opNameFlasm="nextFrame" opNameASV="nextFrame" opNameSothink="_nextFrame">
						//	<description><![CDATA[
						//			//ActionNextFrame
						//			//ActionNextFrame instructs Flash Player to go to the next frame in the current file.
						//			//Field 				Type 					Comment
						//			//ActionNextFrame 		ACTIONRECORDHEADER 		ActionCode = 0x04
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<help><![CDATA[
						//				nextFrame 函数
						//				nextFrame() : Void
						//				
						//				将播放头转到下一帧。
						//				
						//				可用性：Flash Player 2；ActionScript 1.0
						//			]]></help>
						//			<as><![CDATA[
						//				nextFrame();
						//			]]></as>
						//			<pcode><![CDATA[
						//				nextFrame
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionNextFrame>
					//break;
					//case AVM1Ops.previousFrame:
						//<ActionPreviousFrame op="0x05" opName="previousFrame" opNameFlasm="prevFrame" opNameASV="prevFrame" opNameSothink="_prevFrame">
						//	<description><![CDATA[
						//			//ActionPreviousFrame
						//			//ActionPreviousFrame instructs Flash Player to go to the previous frame of the current file.
						//			//Field 				Type 					Comment
						//			//ActionPrevFrame 		ACTIONRECORDHEADER 		ActionCode = 0x05
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<help><![CDATA[
						//				prevFrame 函数
						//				prevFrame() : Void
						//
						//				将播放头转到前一帧。如果当前帧为第 1 帧，则播放头不移动。
						//				
						//				可用性：Flash Player 2；ActionScript 1.0
						//			]]></help>
						//			<as><![CDATA[
						//				prevFrame();
						//			]]></as>
						//			<pcode><![CDATA[
						//				previousFrame
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionPreviousFrame>
					//break;
					//case AVM1Ops.play:
						//<ActionPlay op="0x06" opName="play" opNameFlasm="play" opNameASV="play" opNameSothink="_play">
						//	<description><![CDATA[
						//			//ActionPlay
						//			//ActionPlay instructs Flash Player to start playing at the current frame.
						//			//Field 				Type 					Comment
						//			//ActionPlay 			ACTIONRECORDHEADER 		ActionCode = 0x06
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<help><![CDATA[
						//				play 函数
						//				play() : Void
						//
						//				在时间轴中向前移动播放头。
						//				
						//				可用性：Flash Player 2；ActionScript 1.0
						//			]]></help>
						//			<as><![CDATA[
						//				play();
						//			]]></as>
						//			<pcode><![CDATA[
						//				play
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionPlay>
					//break;
					//case AVM1Ops.stop:
						//<ActionStop op="0x07" opName="stop" opNameFlasm="stop" opNameASV="stop" opNameSothink="_stop">
						//	<description><![CDATA[
						//			//ActionStop
						//			//ActionStop instructs Flash Player to stop playing the file at the current frame.
						//			//Field 				Type 					Comment
						//			//ActionStop 			ACTIONRECORDHEADER 		ActionCode = 0x07
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<help><![CDATA[
						//				stop 函数
						//				stop() : Void
						//
						//				停止当前正在播放的 SWF 文件。此动作最通常的用法是用按钮控制影片剪辑。
						//				
						//				可用性：Flash Player 2；ActionScript 1.0
						//			]]></help>
						//			<as><![CDATA[
						//				stop();
						//			]]></as>
						//			<pcode><![CDATA[
						//				stop
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionStop>
					//break;
					//case AVM1Ops.toggleQuality:
						//<ActionToggleQuality op="0x08" opName="toggleQuality" opNameFlasm="toggleQuality" opNameASV="toggleQuality" opNameSothink="_toggleQuality">
						//	<description><![CDATA[
						//			//ActionToggleQuality
						//			//ActionToggleQuality toggles（切换） the display between high and low quality.
						//			//Field 				Type 					Comment
						//			//ActionToggleQualty 	ACTIONRECORDHEADER 		ActionCode = 0x08
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<help><![CDATA[
						//				toggleHighQuality 函数
						//				toggleHighQuality()
						//
						//				自 Flash Player 5 后不推荐使用。不推荐使用此函数，而推荐使用 _quality。
						//				
						//				在 Flash Player 中启用和禁用消除锯齿功能。消除锯齿可使对象的边缘平滑并会减缓 SWF 播放的速度。此动作会影响 Flash Player 中的所有 SWF 文件。
						//				
						//				可用性：Flash Player 2；ActionScript 1.0
						//			]]></help>
						//			<as><![CDATA[
						//				toggleHighQuality();
						//			]]></as>
						//			<pcode><![CDATA[
						//				toggleQuality
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionToggleQuality>
					//break;
					//case AVM1Ops.stopSounds:
						//<ActionStopSounds op="0x09" opName="stopSounds" opNameFlasm="stopSounds" opNameASV="stopSounds" opNameSothink="_stopSounds">
						//	<description><![CDATA[
						//			//ActionStopSounds
						//			//ActionStopSounds instructs Flash Player to stop playing all sounds.
						//			//Field 				Type 					Comment
						//			//ActionStopSounds 		ACTIONRECORDHEADER 		ActionCode = 0x09
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<help><![CDATA[
						//				stopAllSounds 函数
						//				stopAllSounds() : Void
						//
						//				在不停止播放头的情况下停止 SWF 文件中当前正在播放的所有声音。设置到流的声音在播放头移过它们所在的帧时将恢复播放。
						//				
						//				可用性：Flash Player 3；ActionScript 1.0
						//			]]></help>
						//			<as><![CDATA[
						//				stopAllSounds();
						//			]]></as>
						//			<pcode><![CDATA[
						//				stopSounds
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionStopSounds>
					//break;
					//case AVM1Ops.waitForFrame:
						//<ActionWaitForFrame op="0x8A" opName="waitForFrame" opNameFlasm="ifFrameLoaded" opNameASV="ifFrameLoaded" opNameSothink="_waitForFrame" has2="true">
						//	<description><![CDATA[
						//			//ActionWaitForFrame
						//			//ActionWaitForFrame instructs Flash Player to wait until the specified frame; otherwise skips
						//			//the specified number of actions.
						//			//Field 				Type 					Comment
						//			//ActionWaitForFrame 	ACTIONRECORDHEADER 		ActionCode = 0x8A; Length is always 3
						//			//Frame 				UI16 					Frame to wait for
						//			//SkipCount 			UI8 					Number of actions to skip if frame is not loaded
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<help><![CDATA[
						//				ifFrameLoaded 函数
						//				ifFrameLoaded([scene:String], frame) { 
						//					statement(s); 
						//				}
						//
						//				自 Flash Player 5 后不推荐使用。此函数已不推荐使用。Macromedia 建议您使用 MovieClip._framesloaded 属性。
						//				
						//				检查特定帧的内容是否在本地可用。使用 ifFrameLoaded 可在 SWF 文件的其余部分下载到本地计算机时开始播放简单的动画。使用 _framesloaded 与 ifFrameLoaded 的区别在于 _framesloaded 允许您添加自定义 if 或 else 语句。 
						//				
						//				可用性：Flash Player 4；ActionScript 1.0
						//				
						//				参数
						//				scene:String [可选] - 一个字符串，它指定必须加载的场景的名称。
						//				
						//				frame:Object - 在执行下一条语句之前必须加载的帧编号或帧标签。
						//			]]></help>
						//			<as><![CDATA[
						//				ifFrameLoaded(1235){
						//					trace("Hello World!");
						//				}
						//			]]></as>
						//			<pcode><![CDATA[
						//				waitForFrame 1234,label0
						//				push "Hello World!"
						//				trace
						//			label0:
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionWaitForFrame>
					//break;
					//case AVM1Ops.setTarget:
						//<ActionSetTarget op="0x8B" opName="setTarget" opNameFlasm="setTarget" opNameASV="setTarget" opNameSothink="_setTarget" has2="true">
						//	<description><![CDATA[
						//			//ActionSetTarget
						//			//ActionSetTarget instructs Flash Player to change the context of subsequent（随后） actions, so they
						//			//apply to a named object (TargetName) rather than the current file.
						//			//For example, the SetTarget action can be used to control the Timeline of a sprite object. The
						//			//following sequence of actions sends a sprite called "spinner" to the first frame in its
						//			//Timeline:
						//			//1. SetTarget "spinner"
						//			//2. GotoFrame zero
						//			//3. SetTarget " " (empty string)
						//			//4. End of actions. (Action code = 0)
						//			//All actions following SetTarget "spinner" apply to the spinner object until SetTarget "",
						//			//which sets the action context back to the current file. For a complete discussion of target
						//			//names see DefineSprite.
						//			//Field 				Type 					Comment
						//			//ActionSetTarget 		ACTIONRECORDHEADER 		ActionCode = 0x8B
						//			//TargetName 			STRING 					Target of action target
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<help><![CDATA[
						//				tellTarget 函数
						//				tellTarget(target:String) { 
						//					statement(s);
						//				}
						//
						//				自 Flash Player 5 后不推荐使用。Macromedia 建议使用点 (.) 记号和 with 语句。
						//				
						//				将在 statements 参数中指定的指令应用于在 target 参数中指定的时间轴。tellTarget 动作对导航控制很有帮助。将 tellTarget 分配给用于停止或开始舞台上其它地方的影片剪辑的按钮。还可以使影片剪辑转到此剪辑的特定帧。例如，可以将 tellTarget 分配给用于停止或开始舞台上影片剪辑的按钮，或者分配给用于提示影片剪辑跳至特定帧的按钮。
						//				
						//				在 Flash 5 或更高版本中，可以使用点 (.) 记号代替 tellTarget 动作。可以使用 with 动作向同一个时间轴发出多个动作。使用 with 动作可将任何对象作为目标，而 tellTarget 动作只能将影片剪辑作为目标。
						//				
						//				可用性：Flash Player 3；ActionScript 1.0
						//				
						//				参数
						//				target:String - 一个字符串，指定要控制的时间轴的目标路径。
						//				
						//				statement(s) - 条件为 true 时要执行的指令。
						//			]]></help>
						//			<as><![CDATA[
						//				tellTarget("mc"){
						//					trace("Hello World!");
						//				}
						//			]]></as>
						//			<pcode><![CDATA[
						//				setTarget "mc"
						//				push "Hello World!"
						//				trace
						//				setTarget ""
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionSetTarget>
					//break;
					//<!--SWF 4 actions-->
					//case AVM1Ops.gotoLabel:
						//<ActionGoToLabel op="0x8C" opName="gotoLabel" opNameFlasm="gotoLabel" opNameASV="gotoLabel" opNameSothink="_gotoLabel">
						//	<description><![CDATA[
						//			//ActionGoToLabel
						//			//ActionGoToLabel instructs Flash Player to go to the frame associated with the specified label.
						//			//You can attach a label to a frame with the FrameLabel tag.
						//			//Field 				Type 					Comment
						//			//ActionGoToLabel 		ACTIONRECORDHEADER 		ActionCode = 0x8C
						//			//Label 				STRING 					Frame label
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<help><![CDATA[
						//				gotoAndStop 函数
						//				gotoAndStop([scene:String], frame:Object) : Void
						//				
						//				将播放头转到场景中指定的帧并停止播放。如果未指定场景，播放头将转到当前场景中的帧。只能在根时间轴上使用 scene 参数，不能在影片剪辑或文档中的其它对象的时间轴内使用该参数。
						//				
						//				可用性：Flash Player 2；ActionScript 1.0
						//				
						//				参数
						//				scene:String [可选] - 一个字符串，指定播放头要转到其中的场景的名称。
						//				
						//				frame:Object - 表示播放头转到的帧编号的数字，或者表示播放头转到的帧标签的字符串。
						//			]]></help>
						//			<as><![CDATA[
						//				gotoAndStop("game");
						//			]]></as>
						//			<pcode><![CDATA[
						//				gotoLabel "game"
						//			]]></pcode>
						//		</sample>
						//		<sample>
						//			<help><![CDATA[
						//				gotoAndPlay 函数
						//				gotoAndPlay([scene:String], frame:Object) : Void
						//
						//				将播放头转到场景中指定的帧并从该帧开始播放。如果未指定场景，则播放头将转到当前场景中的指定帧。只能在根时间轴上使用 scene 参数，不能在影片剪辑或文档中的其它对象的时间轴内使用该参数。
						//				
						//				可用性：Flash Player 2；ActionScript 1.0
						//				
						//				参数
						//				scene:String [可选] - 一个字符串，指定播放头要转到其中的场景的名称。
						//				
						//				frame:Object - 表示播放头转到的帧编号的数字，或者表示播放头转到的帧标签的字符串。
						//			]]></help>
						//			<as><![CDATA[
						//				gotoAndPlay("game");
						//			]]></as>
						//			<pcode><![CDATA[
						//				gotoLabel "game"
						//				play
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionGoToLabel>
					//break;
					case AVM1Ops.push:
						//<ActionPush op="0x96" opName="push" opNameFlasm="push" opNameASV="push" opNameSothink="_push">
						//	<description><![CDATA[
						//			//ActionPush
						//			//ActionPush pushes one or more values to the stack.
						//			//Field 				Type 					Comment
						//			//ActionPush 			ACTIONRECORDHEADER 		ActionCode = 0x96
						//			//Type 					UI8 					0 = string literal
						//			//												1 = floating-point literal
						//			//												The following types are available in SWF 5 and later:
						//			//												2 = null
						//			//												3 = undefined
						//			//												4 = register
						//			//												5 = Boolean
						//			//												6 = double
						//			//												7 = integer
						//			//												8 = constant 8
						//			//												9 = constant 16
						//			//String 				If Type = 0, STRING 	Null-terminated character string
						//			//Float 				If Type = 1, FLOAT 		32-bit IEEE single-precision little-endian floating-point value
						//			//RegisterNumber 		If Type = 4, UI8 		Register number
						//			//Boolean 				If Type = 5, UI8 		Boolean value
						//			//Double 				If Type = 6, DOUBLE 	64-bit IEEE double-precision littleendian double value
						//			//Integer 				If Type = 7, UI32 		32-bit little-endian integer
						//			//Constant8 			If Type = 8, UI8 		Constant pool index (for indexes < 256) (see ActionConstantPool)
						//			//Constant16 			If Type = 9, UI16 		Constant pool index (for indexes >= 256) (see ActionConstantPool)
						//			//ActionPush pushes one or more values onto the stack. The Type field specifies the type of the
						//			//value to be pushed.
						//			//If Type = 1, the value to be pushed is specified as a 32-bit IEEE single-precision little-endian
						//			//floating-point value. 
						//			
						//			//PropertyIds are pushed as FLOATs. ActionGetProperty and ActionSetProperty use PropertyIds to access the properties of named objects.
						//			//ActionGetProperty 和 ActionSetProperty 用浮点数来索引对应的属性名（貌似改成整数了也没事）。
						//			
						//			//If Type = 4, the value to be pushed is a register number. Flash Player supports up to 4
						//			//registers. With the use of ActionDefineFunction2, up to 256 registers can be used.
						//			
						//			//In the first field of ActionPush, the length in ACTIONRECORD defines the total number of
						//			//Type and value bytes that follow the ACTIONRECORD itself. More than one set of Type
						//			//and value fields may follow the first field, depending on the number of bytes that the length
						//			//in ACTIONRECORD specifies.
						//			//ActionPush 可能会 push 一个或多个值，直到到达这个 ActionPush ACTIONRECORD 的结尾。
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<as><![CDATA[
						//				1234;
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "1234"
						//				pop
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionPush>
						///
						var numData:ByteArray;
						while(offset<pos+3+Length){
							switch(data[offset++]){
								case 0:
									get_str_size=0;
									while(data[offset+(get_str_size++)]){}
									data.position=offset;
									stack.push(data.readUTFBytes(get_str_size));
									offset+=get_str_size;
								break;
								case 1:
									//好像没见过。。。
									numData=new ByteArray();
									numData[3]=data[offset++];
									numData[2]=data[offset++];
									numData[1]=data[offset++];
									numData[0]=data[offset++];
									numData.position=0;
									stack.push(numData.readFloat());
									
									//data.endian=Endian.LITTLE_ENDIAN;
									//data.position=offset;
									//pushValueV[i]=data.readFloat();
									//offset+=4;
								break;
								case 2:
									stack.push(null);
								break;
								case 3:
									stack.push(undefined);
								break;
								case 4:
									stack.push(registerArr[data[offset++]]);
								break;
								case 5:
									stack.push(data[offset++]?true:false);
								break;
								case 6:
									numData=new ByteArray();
									numData[3]=data[offset++];
									numData[2]=data[offset++];
									numData[1]=data[offset++];
									numData[0]=data[offset++];
									numData[7]=data[offset++];
									numData[6]=data[offset++];
									numData[5]=data[offset++];
									numData[4]=data[offset++];
									numData.position=0;
									stack.push(numData.readDouble());
									
									//data.endian=Endian.LITTLE_ENDIAN;
									//data.position=offset;
									//pushValueV[i]=data.readDouble();
									//offset+=8;
								break;
								case 7:
									stack.push(data[offset++]|(data[offset++]<<8)|(data[offset++]<<16)|(data[offset++]<<24));
								break;
								case 8:
									stack.push(constStrV[data[offset++]]);
								break;
								case 9:
									stack.push(constStrV[data[offset++]|(data[offset++]<<8)]);
								break;
								default:
									throw new Error("未知 pushType");
								break;
							}
						}
					break;
					case AVM1Ops.pop:
						//<ActionPop op="0x17" opName="pop" opNameFlasm="pop" opNameASV="pop" opNameSothink="_pop">
						//	<description><![CDATA[
						//			//ActionPop
						//			//ActionPop pops a value from the stack and discards it.
						//			//Field 				Type 					Comment
						//			//ActionPop 			ACTIONRECORDHEADER 		ActionCode = 0x17
						//			//ActionPop pops a value off the stack and discards（丢弃） the value.
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<as><![CDATA[
						//				1234;
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "1234"
						//				pop
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionPop>
						stack.pop();
					break;
					//case AVM1Ops.add:
						//<ActionAdd op="0x0A" opName="add" opNameFlasm="oldAdd" opNameASV="oldAdd" opNameSothink="_add" has2="true">
						//	<description><![CDATA[
						//			//ActionAdd
						//			//ActionAdd adds two numbers and pushes the result back to the stack.
						//			//Field 				Type 					Comment
						//			//ActionAdd 			ACTIONRECORDHEADER 		ActionCode = 0x0A
						//			//ActionAdd does the following:
						//			//1. Pops value A off the stack.
						//			//2. Pops value B off the stack.
						//			//3. Converts A and B to floating-point; non-numeric values evaluate to 0.
						//			//4. Adds the numbers A and B.
						//			//5. Pushes the result, A+B, to the stack.
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<help><![CDATA[
						//				+ 加法运算符
						//				expression1 + expression2
						//
						//				将数值表达式相加或者连接（合并）字符串。如果其中一个表达式为字符串，则所有其它表达式都被转换为字符串，然后连接起来。两个表达式都为整数时，和为整数；其中一个或两个表达式为浮点数时，和为浮点数。
						//				
						//				可用性：Flash Player 4；ActionScript 1.0
						//				
						//				操作数
						//				expression1 - 一个数字或字符串。
						//				
						//				expression2 : Number - 一个数字或字符串。
						//				
						//				返回
						//				Object - 一个字符串、整数或浮点数。
						//			]]></help>
						//			<as><![CDATA[
						//				trace(a+b);//发布为 player4
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "a"
						//				getVariable
						//				push "b"
						//				getVariable
						//				add
						//				trace
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionAdd>
					//break;
					case AVM1Ops.subtract:
						//<ActionSubtract op="0x0B" opName="subtract" opNameFlasm="subtract" opNameASV="subtract" opNameSothink="_subtract">
						//	<description><![CDATA[
						//			//ActionSubtract
						//			//ActionSubtract subtracts two numbers and pushes the result back to the stack.
						//			//Field 				Type 					Comment
						//			//ActionSubtract 		ACTIONRECORDHEADER 		ActionCode = 0x0B
						//			//ActionSubtract does the following:
						//			//1. Pops value A off the stack.
						//			//2. Pops value B off the stack.
						//			//3. Converts A and B to floating-point; non-numeric values evaluate to 0.
						//			//4. Subtracts A from B.
						//			//5. Pushes the result, B-A, to the stack.
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<help><![CDATA[
						//				- 减法运算符
						//				(Negation) -expression
						//				(Subtraction) expression1 - expression2
						//
						//				用于执行求反或减法运算。
						//				
						//				用法 1：用于执行求反时，它将数值 expression 的符号取反。用法 2：用于减法时，它对两个数值表达式执行算术减法运算，从 expression1 减去 expression2。两个表达式都为整数时，差为整数。其中任何一个或两个表达式为浮点数时，差为浮点数。
						//				
						//				可用性：Flash Player 4；ActionScript 1.0
						//				
						//				操作数
						//				expression1 : Number - 数字或计算结果为数字的表达式。
						//				
						//				expression2 : Number - 数字或计算结果为数字的表达式。
						//				
						//				返回
						//				Number - 一个整数或浮点数。
						//			]]></help>
						//			<as><![CDATA[
						//				trace(a-b);
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "a"
						//				getVariable
						//				push "b"
						//				getVariable
						//				subtract
						//				trace
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionSubtract>
						value2=stack.pop();
						value1=stack.pop();
						stack.push(value1-value2);
					break;
					case AVM1Ops.multiply:
						//<ActionMultiply op="0x0C" opName="multiply" opNameFlasm="multiply" opNameASV="multiply" opNameSothink="_multiply">
						//	<description><![CDATA[
						//			//ActionMultiply
						//			//ActionMultiply multiplies two numbers and pushes the result back to the stack.
						//			//Field 				Type 					Comment
						//			//ActionMultiply 		ACTIONRECORDHEADER 		ActionCode = 0x0C
						//			//ActionMultiply does the following:
						//			//1. Pops value A off the stack.
						//			//2. Pops value B off the stack.
						//			//3. Converts A and B to floating-point; non-numeric values evaluate to 0.
						//			//4. Multiplies A times B.
						//			//5. Pushes the result, A*B, to the stack.
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<help><![CDATA[
						//				* 乘法运算符
						//				expression1 * expression2
						//				
						//				将两个数值表达式相乘。如果两个表达式都是整数，则积为整数。如果其中任何一个或两个表达式是浮点数，则积为浮点数。
						//				
						//				可用性：Flash Player 4；ActionScript 1.0
						//				
						//				操作数
						//				expression1 : Number - 数字或计算结果为数字的表达式。
						//				
						//				expression2 : Number - 数字或计算结果为数字的表达式。
						//				
						//				返回
						//				Number - 一个整数或浮点数。
						//			]]></help>
						//			<as><![CDATA[
						//				trace(a*b);
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "a"
						//				getVariable
						//				push "b"
						//				getVariable
						//				multiply
						//				trace
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionMultiply>
						value2=stack.pop();
						value1=stack.pop();
						stack.push(value1*value2);
					break;
					case AVM1Ops.divide:
						//<ActionDivide op="0x0D" opName="divide" opNameFlasm="divide" opNameASV="divide" opNameSothink="_divide">
						//	<description><![CDATA[
						//			//ActionDivide
						//			//ActionDivide divides two numbers and pushes the result back to the stack.
						//			//Field 				Type 					Comment
						//			//ActionDivide 			ACTIONRECORDHEADER 		ActionCode = 0x0D
						//			//ActionDivide does the following:
						//			//1. Pops value A off the stack.
						//			//2. Pops value B off the stack.
						//			//3. Converts A and B to floating-point; non-numeric values evaluate to 0.
						//			//4. Divides B by A.
						//			//5. Pushes the result, B/A, to the stack.
						//			//6. If A is zero, the result NaN, Infinity, or -Infinity is pushed to the stack in SWF 5 and
						//			//later. In SWF 4, the result is the string #ERROR#.
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<help><![CDATA[
						//				/ 除法运算符
						//				expression1 / expression2
						//				
						//				expression1 除以 expression2。除法运算的结果为双精度浮点数。
						//				
						//				可用性：Flash Player 4；ActionScript 1.0
						//				
						//				操作数
						//				expression : Number - 一个数字或计算结果为数字的一个变量。
						//				
						//				返回
						//				Number - 运算的浮点结果。
						//			]]></help>
						//			<as><![CDATA[
						//				trace(a/b);
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "a"
						//				getVariable
						//				push "b"
						//				getVariable
						//				divide
						//				trace
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionDivide>
						value2=stack.pop();
						value1=stack.pop();
						stack.push(value1/value2);
					break;
					//case AVM1Ops.equals:
						//<ActionEquals op="0x0E" opName="equals" opNameFlasm="oldEquals" opNameASV="oldEquals" opNameSothink="_equals" has2="true">
						//	<description><![CDATA[
						//			//ActionEquals
						//			//ActionEquals tests two numbers for equality.
						//			//Field 				Type 					Comment
						//			//ActionEquals 			ACTIONRECORDHEADER 		ActionCode = 0x0E
						//			//ActionEquals does the following:
						//			//1. Pops value A off the stack.
						//			//2. Pops value B off the stack.
						//			//3. Converts A and B to floating-point; non-numeric values evaluate to 0.
						//			//4. Compares the numbers for equality.
						//			//5. If the numbers are equal, true is pushed to the stack for SWF 5 and later.
						//			//For SWF 4, 1 is pushed to the stack.
						//			//6. Otherwise, false is pushed to the stack for SWF 5 and later.
						//			//For SWF 4, 0 is pushed to the stack.
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<help><![CDATA[
						//				== 等于运算符
						//				expression1 == expression2
						//				
						//				测试两个表达式是否相等。如果表达式相等，则结果为 true。
						//				
						//				确定是否相等取决于参数的数据类型：
						//				
						//				数字和布尔值按值进行比较，如果它们具有相同的值，则视为相等。 
						//				如果字符串表达式具有相同的字符数，而且这些字符都相同，则这些字符串表达式相等。 
						//				表示对象、数组和函数的变量按引用进行比较。如果两个变量引用同一个对象、数组或函数，则它们相等。而两个单独的数组即使具有相同数量的元素，也永远不会被视为相等。 
						//				当按值进行比较时，如果 expression1 和 expression2 为不同的数据类型，ActionScript 会尝试将 expression2 的数据类型转换为与 expression1 匹配的数据类型。
						//				
						//				可用性：Flash Player 5；ActionScript 1.0
						//				
						//				操作数
						//				expression1 : Object - 数字、字符串、布尔值、变量、对象、数组或函数。
						//				
						//				expression2 : Object - 数字、字符串、布尔值、变量、对象、数组或函数。
						//				
						//				返回
						//				Boolean - 比较的布尔结果。
						//			]]></help>
						//			<as><![CDATA[
						//				trace(a==b);//发布为 player4
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "a"
						//				getVariable
						//				push "b"
						//				getVariable
						//				equals
						//				trace
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionEquals>
					//break;
					//case AVM1Ops.less:
						//<ActionLess op="0x0F" opName="less" opNameFlasm="oldLessThan" opNameASV="oldLessThan" opNameSothink="_less" has2="true">
						//	<description><![CDATA[
						//			//ActionLess
						//			//ActionLess tests if a number is less than another number
						//			//Field 				Type 					Comment
						//			//ActionLess 			ACTIONRECORDHEADER 		ActionCode = 0x0F
						//			//ActionLess does the following:
						//			//1. Pops value A off the stack.
						//			//2. Pops value B off the stack.
						//			//3. Converts A and B to floating-point; non-numeric values evaluate to 0.
						//			//4. If B < A, true is pushed to the stack for SWF 5 and later (1 is pushed for SWF 4);
						//			//otherwise, false is pushed to the stack for SWF 5 and later (0 is pushed for SWF 4).
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<help><![CDATA[
						//				< 小于运算符
						//				expression1 < expression2
						//				
						//				比较两个表达式，确定 expression1 是否小于 expression2；如果是，则此运算符返回 true。如果 expression1 大于或等于 expression2，则该运算符返回 false。使用字母顺序计算字符串表达式；所有的大写字母排在小写字母的前面。
						//				
						//				可用性：Flash Player 4；ActionScript 1.0
						//				
						//				操作数
						//				expression1 : Number - 一个数字或字符串。
						//				
						//				expression2 : Number - 一个数字或字符串。
						//				
						//				返回
						//				Boolean - 比较的布尔结果。
						//			]]></help>
						//			<as><![CDATA[
						//				trace(a<b);//发布为 player4
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "a"
						//				getVariable
						//				push "b"
						//				getVariable
						//				less
						//				trace
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionLess>
					//break;
					case AVM1Ops.and:
						//<ActionAnd op="0x10" opName="and" opNameFlasm="and" opNameASV="and" opNameSothink="_and">
						//	<description><![CDATA[
						//			//ActionAnd
						//			//ActionAnd performs a logical AND of two numbers.
						//			//Field 				Type 					Comment
						//			//ActionAnd 			ACTIONRECORDHEADER 		ActionCode = 0x10
						//			//ActionAdd does the following:
						//			//1. Pops value A off the stack.
						//			//2. Pops value B off the stack.
						//			//3. Converts A and B to floating-point; non-numeric values evaluate to 0.
						//			//4. If both numbers are nonzero, true is pushed to the stack for SWF 5 and later (1 is pushed
						//			//for SWF 4); otherwise, false is pushed to the stack for SWF 5 and later (0 is pushed for
						//			//SWF 4).
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<help><![CDATA[
						//				&& 逻辑 AND 运算符
						//				expression1 && expression2
						//				
						//				对两个表达式的值执行布尔运算。如果 expression1 和 expression2 都为 true，则返回 true；否则返回 false。
						//				
						//				表达式 
						//				计算结果 
						//				
						//				true&&true
						//				true 
						//				
						//				true&&false
						//				false 
						//				
						//				false&&false
						//				false 
						//				
						//				false&&true
						//				false 
						//				
						//				
						//				可用性：Flash Player 4；ActionScript 1.0
						//				
						//				操作数
						//				expression1 : Number - 布尔值或要转换为布尔值的表达式。
						//				
						//				expression2 : Number - 布尔值或要转换为布尔值的表达式。
						//				
						//				返回
						//				Boolean - 逻辑运算的布尔结果。
						//			]]></help>
						//			<as><![CDATA[
						//				trace(a&&b);//不会编译出 and 运算符来
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "a"
						//				getVariable
						//				push "a"
						//				getVariable
						//				not
						//				if_ label0
						//				pop
						//				push "b"
						//				getVariable
						//			label0:
						//				trace
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionAnd>
						value2=stack.pop();
						value1=stack.pop();
						stack.push(value1&&value2);
					break;
					case AVM1Ops.or:
						//<ActionOr op="0x11" opName="or" opNameFlasm="or" opNameASV="or" opNameSothink="_or">
						//	<description><![CDATA[
						//			//ActionOr
						//			//ActionOr performs a logical OR of two numbers.
						//			//Field 				Type 					Comment
						//			//ActionOr 				ACTIONRECORDHEADER 		ActionCode = 0x11
						//			//ActionOr does the following:
						//			//1. Pops value A off the stack.
						//			//2. Pops value B off the stack.
						//			//3. Converts A and B to floating-point; non-numeric values evaluate to 0.
						//			//4. If either of the numbers is nonzero, true is pushed to the stack for SWF 5 and later (1 is
						//			//pushed for SWF 4); otherwise, false is pushed to the stack for SWF 5 and later (0 is
						//			//pushed for SWF 4).
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<help><![CDATA[
						//				|| 逻辑 OR 运算符
						//				expression1 || expression2
						//				
						//				计算 expression1（运算符左侧的表达式），如果表达式的计算结果为 true，则返回 true。如果 expression1 的结算结果为 false，则计算 expression2（运算符右侧的表达式）。如果 expression2 的计算结果为 false，则最终结果为 false；否则，最终结果为 true。
						//				
						//				如果将函数调用用作 expression2，则在 expression1 的计算结果为 true 时，该调用不会执行该函数。 
						//				
						//				如果其中任一表达式（或两者）的计算结果为 true，则结果为 true；只有当两个表达式的计算结果都为 false 时，结果才为 false。您可以将逻辑 OR 运算符与任意多个操作数一起使用；如果任一操作数的计算结果为 true，则结果为 true。 
						//				
						//				可用性：Flash Player 4；ActionScript 1.0
						//				
						//				操作数
						//				expression1 : Number - 布尔值或要转换为布尔值的表达式。
						//				
						//				expression2 : Number - 布尔值或要转换为布尔值的表达式。
						//				
						//				返回
						//				Boolean - 逻辑运算的结果。
						//			]]></help>
						//			<as><![CDATA[
						//				trace(a||b);//不会编译出 or 运算符来
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "a"
						//				getVariable
						//				push "a"
						//				getVariable
						//				if_ label0
						//				pop
						//				push "b"
						//				getVariable
						//			label0:
						//				trace
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionOr>
						value2=stack.pop();
						value1=stack.pop();
						stack.push(value1||value2);
					break;
					case AVM1Ops.not:
						//<ActionNot op="0x12" opName="not" opNameFlasm="not" opNameASV="not" opNameSothink="_not">
						//	<description><![CDATA[
						//			//ActionNot
						//			//ActionNot performs a logical NOT of a number.
						//			//NOTE
						//			//In SWF 5 files, the ActionNot operator converts its argument to a Boolean value, and
						//			//pushes a result of type Boolean. In SWF 4 files, the argument and result are numbers.
						//			//Field 				Type 					Comment
						//			//ActionNot 			ACTIONRECORDHEADER 		ActionCode = 0x12
						//			//Result Boolean
						//			//ActionNot does the following:
						//			//1. Pops a value off the stack.
						//			//2. Converts the value to floating point; non-numeric values evaluate to 0.
						//			//3. If the value is zero, true is pushed on the stack for SWF 5 and later (1 is pushed for
						//			//SWF 4).
						//			//4. If the value is nonzero, false is pushed on the stack for SWF 5 and later (0 is pushed for
						//			//SWF 4).
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<help><![CDATA[
						//				! 逻辑 NOT 运算符
						//				! expression
						//				
						//				对变量或表达式的布尔值取反。如果 expression 是具有绝对的或经过转换的值 true 的变量，则 ! expression 的值为 false。如果表达式 x && y 的计算结果为 false，则表达式 !(x && y) 的计算结果为 true。
						//				
						//				下面的表达式说明了使用逻辑 NOT (!) 运算符的结果： 
						//				
						//				! true 返回 false ! false 返回 true
						//				
						//				可用性：Flash Player 4；ActionScript 1.0
						//				
						//				操作数
						//				expression : Boolean - 计算结果为布尔值的一个表达式或变量。
						//				
						//				返回
						//				Boolean - 逻辑运算的布尔结果。
						//			]]></help>
						//			<as><![CDATA[
						//				trace(!a);
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "a"
						//				getVariable
						//				not
						//				trace
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionNot>
						stack.push(!stack.pop());
					break;
					//case AVM1Ops.stringEquals:
						//<ActionStringEquals op="0x13" opName="stringEquals" opNameFlasm="stringEq" opNameASV="stringEq" opNameSothink="_stringEquals">
						//	<description><![CDATA[
						//			//ActionStringEquals
						//			//ActionStringEquals tests two strings for equality.
						//			//Field 				Type 					Comment
						//			//ActionStringEquals 	ACTIONRECORDHEADER 		ActionCode = 0x13
						//			//ActionStringEquals does the following:
						//			//1. Pops value A off the stack.
						//			//2. Pops value B off the stack.
						//			//3. Compares A and B as strings.
						//			//The comparison is case-sensitive.
						//			//4. If the strings are equal, true is pushed to the stack for SWF 5 and later (SWF 4 pushes 1).
						//			//5. Otherwise, false is pushed to the stack for SWF 5 and later (SWF 4 pushes 0).
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<help><![CDATA[
						//				eq 等于（字符串）运算符
						//				expression1 eq expression2
						//				
						//				自 Flash Player 5 后不推荐使用。不推荐使用此运算符，而推荐使用 == (equality) 运算符。
						//				
						//				比较两个表达式是否相等，如果 expression1 的字符串表示形式等于 expression2 的字符串表示形式，则返回值 true，否则返回 false。 
						//				
						//				可用性：Flash Player 4；ActionScript 1.0
						//				
						//				操作数
						//				expression1 : Object - 数字、字符串或变量。
						//				
						//				expression2 : Object - 数字、字符串或变量。
						//				
						//				返回
						//				Boolean - 比较的结果。
						//			]]></help>
						//			<as><![CDATA[
						//				trace(a eq b);
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "a"
						//				getVariable
						//				push "b"
						//				getVariable
						//				stringEquals
						//				trace
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionStringEquals>
					//break;
					//case AVM1Ops.stringLength:
						//<ActionStringLength op="0x14" opName="stringLength" opNameFlasm="stringLength" opNameASV="stringLength" opNameSothink="_stringLength">
						//	<description><![CDATA[
						//			//ActionStringLength
						//			//ActionStringLength computes the length of a string.
						//			//Field 				Type 					Comment
						//			//ActionStringLength 	ACTIONRECORDHEADER 		ActionCode = 0x14
						//			//ActionStringLength does the following:
						//			//1. Pops a string off the stack.
						//			//2. Calculates the length of the string and pushes it to the stack.
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<help><![CDATA[
						//				length 函数
						//				length(expression:String)length(variable)
						//				
						//				自 Flash Player 5 后不推荐使用。此函数及所有字符串函数已不推荐使用。Macromedia 建议您使用 String 类的方法和 String.length 属性来执行相同的操作。
						//				
						//				返回指定字符串或变量的长度。
						//				
						//				可用性：Flash Player 4；ActionScript 1.0
						//				
						//				参数
						//				expression:String - 一个字符串。
						//				
						//				variable:Object - 变量的名称。
						//				
						//				返回
						//				Number - 指定的字符串或变量的长度。
						//			]]></help>
						//			<as><![CDATA[
						//				length(a);
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "a"
						//				getVariable
						//				stringLength
						//				pop
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionStringLength>
					//break;
					case AVM1Ops.stringAdd:
						//<ActionStringAdd op="0x21" opName="stringAdd" opNameFlasm="concat" opNameASV="concat" opNameSothink="_stringAdd">
						//	<description><![CDATA[
						//			//ActionStringAdd
						//			//ActionStringAdd concatenates two strings.
						//			//Field 				Type 					Comment
						//			//ActionStringAdd 		ACTIONRECORDHEADER 		ActionCode = 0x21
						//			//ActionStringAdd does the following:
						//			//1. Pops value A off the stack.
						//			//2. Pops value B off the stack.
						//			//3. Pushes the concatenation BA to the stack.
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<help><![CDATA[
						//				add 连接（字符串）运算符
						//				string1 add string2
						//				
						//				自 Flash Player 5 后不推荐使用。Macromedia 建议在为 Flash Player 5 或更高版本创建内容时使用加运算符 (+)。此运算符在 Flash Player 8 或更高版本中不受支持。
						//				
						//				连接两个或更多字符串。加法运算符 (+) 替换了 Flash 4 的 & 运算符；当将使用 & 运算符的 Flash Player 4 文件引入 Flash 5 或更高版本的创作环境中时，就会自动对其进行转换以使用加法运算符 (+) 进行字符串连接。如果您为 Flash Player 4 或更早版本的播放器创建内容，请使用加法 (+) 运算符来连接字符串。 
						//				
						//				可用性：Flash Player 4；ActionScript 1.0
						//				
						//				操作数
						//				string1 : String - 一个字符串。
						//				
						//				string2 : String - 一个字符串。
						//				
						//				返回
						//				String - 连接后的字符串。
						//			]]></help>
						//			<as><![CDATA[
						//				trace(a add b);
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "a"
						//				getVariable
						//				push "b"
						//				getVariable
						//				stringAdd
						//				trace
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionStringAdd>
						//fscommand(a,b);例如这种代码会用到。。。
						value2=stack.pop();
						value1=stack.pop();
						stack.push(value1+value2);
					break;
					//case AVM1Ops.stringExtract:
						//<ActionStringExtract op="0x15" opName="stringExtract" opNameFlasm="substring" opNameASV="substring" opNameSothink="_stringExtract">
						//	<description><![CDATA[
						//			//ActionStringExtract
						//			//ActionStringExtract extracts a substring from a string.
						//			//Field 				Type 					Comment
						//			//ActionStringExtract 	ACTIONRECORDHEADER 		ActionCode = 0x15
						//			//ActionStringExtract does the following:
						//			//1. Pops number count off the stack.
						//			//2. Pops number index off the stack.
						//			//3. Pops string string off the stack.
						//			//4. Pushes the substring of the string starting at the indexed character and count characters in
						//			//length to the stack.
						//			//5. If either index or count do not evaluate to integers, the result is the empty string.
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<help><![CDATA[
						//				substring 函数
						//				substring(string:String, index:Number, count:Number) : String
						//				
						//				自 Flash Player 5 后不推荐使用。不推荐使用此函数，而推荐使用 String.substr()。
						//				
						//				提取部分字符串。此函数是从 1 开始的，而 String 对象方法是从 0 开始的。
						//				
						//				可用性：Flash Player 4；ActionScript 1.0
						//				
						//				参数
						//				string:String - 从中提取新字符串的字符串。
						//				
						//				index:Number - 要提取的第一个字符的编号。
						//				
						//				count:Number - 要在已提取的字符串中包括的字符数，不包括索引字符。
						//				
						//				返回
						//				String - 已提取的子字符串。
						//			]]></help>
						//			<as><![CDATA[
						//				substring(a,1,3);
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "a"
						//				getVariable
						//				push "1"
						//				push "3"
						//				stringExtract
						//				pop
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionStringExtract>
					//break;
					//case AVM1Ops.stringLess:
						//<ActionStringLess op="0x29" opName="stringLess" opNameFlasm="stringLessThan" opNameASV="stringLessThan" opNameSothink="_stringLess">
						//	<description><![CDATA[
						//			//ActionStringLess
						//			//ActionStringLess tests to see if a string is less than another string
						//			//Field 				Type 					Comment
						//			//ActionStringLess 		ACTIONRECORDHEADER 		ActionCode = 0x29
						//			//ActionStringLess does the following:
						//			//1. Pops value A off the stack.
						//			//2. Pops value B off the stack.
						//			//3. If B < A using a byte-by-byte comparison, true is pushed to the stack for SWF 5 and later
						//			//(SWF 4 pushes 1); otherwise, false is pushed to the stack for SWF 5 and later (SWF 4
						//			//pushes 0).
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<help><![CDATA[
						//				lt 小于（字符串）运算符
						//				expression1 lt expression2
						//				
						//				自 Flash Player 5 后不推荐使用。不推荐使用此运算符，而推荐使用 <（小于）运算符。
						//				
						//				将 expression1 与 expression2 相比较，如果 expression1 小于 expression2，则返回 true，否则返回 false。
						//				
						//				可用性：Flash Player 4；ActionScript 1.0
						//				
						//				操作数
						//				expression1 : Object - 数字、字符串或变量。
						//				
						//				expression2 : Object - 数字、字符串或变量。
						//				
						//				返回
						//				Boolean - 比较的结果。
						//			]]></help>
						//			<as><![CDATA[
						//				trace(a lt b);
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "a"
						//				getVariable
						//				push "b"
						//				getVariable
						//				stringLess
						//				trace
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionStringLess>
					//break;
					//case AVM1Ops.mbStringLength:
						//<ActionMBStringLength op="0x31" opName="mbStringLength" opNameFlasm="mbLength" opNameASV="mbLength" opNameSothink="_mbStringLength">
						//	<description><![CDATA[
						//			//ActionMBStringLength
						//			//ActionMBStringLength computes the length of a string and is multi-byte aware.
						//			//Field 				Type 					Comment
						//			//ActionMBStringLength 	ACTIONRECORDHEADER 		ActionCode = 0x31
						//			//ActionMBStringLength does the following:
						//			//1. Pops a string off the stack.
						//			//2. Calculates the length of the string in characters and pushes it to the stack.
						//			//This is a multi-byte aware version of ActionStringLength. On systems with double-byte
						//			//support, a double-byte character is counted as a single character.
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<help><![CDATA[
						//				mblength 函数
						//				mblength(string:String) : Number
						//				
						//				自 Flash Player 5 后不推荐使用。不推荐使用此函数，而推荐使用 String 类的方法和属性。
						//				
						//				返回多字节字符串的长度。
						//				
						//				可用性：Flash Player 4；ActionScript 1.0
						//				
						//				参数
						//				string:String - 要度量的字符串。
						//				
						//				返回
						//				Number - 多字节字符串的长度。
						//			]]></help>
						//			<as><![CDATA[
						//				mblength(a);
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "a"
						//				getVariable
						//				mbStringLength
						//				pop
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionMBStringLength>
					//break;
					//case AVM1Ops.mbStringExtract:
						//<ActionMBStringExtract op="0x35" opName="mbStringExtract" opNameFlasm="mbSubstring" opNameASV="mbSubstring" opNameSothink="_mbStringExtract">
						//	<description><![CDATA[
						//			//ActionMBStringExtract
						//			//ActionMBStringExtract extracts a substring from a string and is multi-byte aware.
						//			//Field 				Type 					Comment
						//			//ActionMBStringExtract	ACTIONRECORDHEADER 		ActionCode = 0x35
						//			//It does the following:
						//			//1. Pops the number count off the stack.
						//			//2. Pops the number index off the stack.
						//			//3. Pops the string string off the stack.
						//			//4. Pushes the substring of string starting at the index'th character and count characters in
						//			//length to the stack.
						//			//NOTE
						//			//If either index or count do not evaluate to integers, the result is the empty string.
						//			//This is a multi-byte aware version of ActionStringExtract. Index and count are treated as
						//			//character indexes, counting double-byte characters as single characters.
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<help><![CDATA[
						//				mbsubstring 函数
						//				mbsubstring(value:String, index:Number, count:Number) : String
						//				
						//				自 Flash Player 5 后不推荐使用。不推荐使用此函数，而推荐使用 String.substr()。
						//				
						//				从多字节字符串中提取新的多字节字符串。 
						//				
						//				可用性：Flash Player 4；ActionScript 1.0
						//				
						//				参数
						//				value:String - 多字节字符串，要从其中提取一个新的多字节字符串。
						//				
						//				index:Number - 要提取的第一个字符的编号。
						//				
						//				count:Number - 要在已提取的字符串中包括的字符数，不包括索引字符。
						//				
						//				返回
						//				String - 从多字节字符串中提取的字符串。
						//			]]></help>
						//			<as><![CDATA[
						//				mbsubstring(a,1,3);
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "a"
						//				getVariable
						//				push "1"
						//				push "3"
						//				mbStringExtract
						//				pop
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionMBStringExtract>
					//break;
					case AVM1Ops.toInteger:
						//<ActionToInteger op="0x18" opName="toInteger" opNameFlasm="int" opNameASV="int" opNameSothink="_toInteger">
						//	<description><![CDATA[
						//			//ActionToInteger
						//			//ActionToInteger converts a value to an integer.
						//			//Field 				Type 					Comment
						//			//ActionToInteger 		ACTIONRECORDHEADER 		ActionCode = 0x18
						//			//ActionToInteger does the following:
						//			//1. Pops a value off the stack.
						//			//2. Converts the value to a number.
						//			//3. Discards any digits after the decimal point, resulting in an integer.
						//			//4. Pushes the resulting integer to the stack.
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<help><![CDATA[
						//				int 函数
						//				int(value:Number) : Number
						//				
						//				自 Flash Player 5 后不推荐使用。不推荐使用此函数，而推荐使用 Math.round()。
						//				
						//				通过截断小数值将小数转换为整数值。当 value 参数为正值时，此函数等效于 Math.floor()；当 value 参数为负值时，此函数等效于 Math.ceil()。
						//				
						//				可用性：Flash Player 4；ActionScript 1.0
						//				
						//				参数
						//				value:Number - 要舍入为整数的数字。
						//				
						//				返回
						//				Number - 截断的整数值。
						//			]]></help>
						//			<as><![CDATA[
						//				int(a);
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "a"
						//				getVariable
						//				toInteger
						//				pop
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionToInteger>
						stack.push(int(stack.pop()));
					break;
					case AVM1Ops.charToAscii:
						//<ActionCharToAscii op="0x32" opName="charToAscii" opNameFlasm="ord" opNameASV="ord" opNameSothink="_charToAscii">
						//	<description><![CDATA[
						//			//ActionCharToAscii
						//			//ActionCharToAscii converts character code to ASCII.
						//			//Field 				Type 					Comment
						//			//ActionCharToAscii 	ACTIONRECORDHEADER 		ActionCode = 0x32
						//			//ActionCharToAscii does the following:
						//			//1. Pops a value off the stack.
						//			//2. Converts the first character of the value to a numeric ASCII character code.
						//			//3. Pushes the resulting character code to the stack.
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<help><![CDATA[
						//				ord 函数
						//				ord(character:String) : Number
						//				
						//				自 Flash Player 5 后不推荐使用。不推荐使用此函数，而推荐使用 String 类的方法和属性。
						//				
						//				将字符转换为 ASCII 代码数字。
						//				
						//				可用性：Flash Player 4；ActionScript 1.0
						//				
						//				参数
						//				character:String - 要转换为 ASCII 代码数字的字符。
						//				
						//				返回
						//				Number - 指定的字符的 ASCII 代码数字。
						//			]]></help>
						//			<as><![CDATA[
						//				ord(a);
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "a"
						//				getVariable
						//				charToAscii
						//				pop
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionCharToAscii>
						stack.push(stack.pop().charCodeAt(0));
					break;
					case AVM1Ops.asciiToChar:
						//<ActionAsciiToChar op="0x33" opName="asciiToChar" opNameFlasm="chr" opNameASV="chr" opNameSothink="_asciiToChar">
						//	<description><![CDATA[
						//			//ActionAsciiToChar
						//			//ActionAsciiToChar converts a value to an ASCII character code.
						//			//Field 				Type 					Comment
						//			//ActionAsciiToChar 	ACTIONRECORDHEADER 		ActionCode = 0x33
						//			//ActionAsciiToChar does the following:
						//			//1. Pops a value off the stack.
						//			//2. Converts the value from a number to the corresponding ASCII character.
						//			//3. Pushes the resulting character to the stack.
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<help><![CDATA[
						//				chr 函数
						//				chr(number:Number) : String
						//				
						//				自 Flash Player 5 后不推荐使用。不推荐使用此函数，而推荐使用 String.fromCharCode()。
						//				
						//				将 ASCII 代码数字转换为字符。
						//				
						//				可用性：Flash Player 4；ActionScript 1.0
						//				
						//				参数
						//				number:Number - 一个 ASCII 代码数字。
						//				
						//				返回
						//				String - 指定的 ASCII 代码的字符值。
						//			]]></help>
						//			<as><![CDATA[
						//				chr(a);
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "a"
						//				getVariable
						//				asciiToChar
						//				pop
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionAsciiToChar>
						stack.push(String.fromCharCode(stack.pop()));
					break;
					//case AVM1Ops.mbCharToAscii:
						//<ActionMBCharToAscii op="0x36" opName="mbCharToAscii" opNameFlasm="mbOrd" opNameASV="mbOrd" opNameSothink="_mbCharToAscii">
						//	<description><![CDATA[
						//			//ActionMBCharToAscii
						//			//ActionMBCharToAscii converts character code to ASCII and is multi-byte aware.
						//			//Field 				Type 					Comment
						//			//ActionMBCharToAscii 	ACTIONRECORDHEADER 		ActionCode = 0x36
						//			//ActionMBCharToAscii does the following:
						//			//1. Pops a value off the stack.
						//			//2. Converts the first character of the value to a numeric character code.
						//			//If the first character of the value is a double-byte character, a 16-bit value is constructed
						//			//with the first byte as the high-order byte and the second byte as the low-order byte.
						//			//3. Pushes the resulting character code to the stack.
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<help><![CDATA[
						//				mbord 函数
						//				mbord(character:String) : Number
						//				
						//				自 Flash Player 5 后不推荐使用。不推荐使用此函数，而推荐使用 String.charCodeAt()。
						//				
						//				将指定字符转换为多字节数字。
						//				
						//				可用性：Flash Player 4；ActionScript 1.0
						//				
						//				参数
						//				character:String - character 要转换为多字节数字的字符。
						//				
						//				返回
						//				Number - 已转换的字符。
						//			]]></help>
						//			<as><![CDATA[
						//				mbord(a);
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "a"
						//				getVariable
						//				mbCharToAscii
						//				pop
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionMBCharToAscii>
					//break;
					//case AVM1Ops.mbAsciiToChar:
						//<ActionMBAsciiToChar op="0x37" opName="mbAsciiToChar" opNameFlasm="mbChr" opNameASV="mbChr" opNameSothink="_mbAsciiToChar">
						//	<description><![CDATA[
						//			//ActionMBAsciiToChar
						//			//ActionMBAsciiToChar converts ASCII to character code and is multi-byte aware.
						//			//Field 				Type 					Comment
						//			//ActionMBAsciiToChar 	ACTIONRECORDHEADER 		ActionCode = 0x37
						//			//ActionMBAsciiToChar does the following:
						//			//1. Pops a value off the stack.
						//			//2. Converts the value from a number to the corresponding character.
						//			//If the character is a 16-bit value (>= 256), a double-byte character is constructed with the
						//			//first byte containing the high-order byte, and the second byte containing the low-order
						//			//byte.
						//			//3. Pushes the resulting character to the stack.
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<help><![CDATA[
						//				mbchr 函数
						//				mbchr(number:Number)
						//				
						//				自 Flash Player 5 后不推荐使用。不推荐使用此函数，而推荐使用 String.fromCharCode() 方法。
						//				
						//				将 ASCII 代码数字转换为多字节字符。
						//				
						//				可用性：Flash Player 4；ActionScript 1.0
						//				
						//				参数
						//				number:Number - 要转换为多字节字符的数字。
						//			]]></help>
						//			<as><![CDATA[
						//				mbchr(a);
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "a"
						//				getVariable
						//				mbAsciiToChar
						//				pop
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionMBAsciiToChar>
					//break;
					case AVM1Ops.jump:
						//<ActionJump op="0x99" opName="jump" opNameFlasm="branch" opNameASV="branch" opNameSothink="_jump">
						//	<description><![CDATA[
						//			//ActionJump
						//			//ActionJump creates an unconditional branch.
						//			//Field 				Type 					Comment
						//			//ActionJump 			ACTIONRECORDHEADER 		ActionCode = 0x99
						//			//BranchOffset 			SI16 					Offset
						//			//ActionJump adds BranchOffset bytes to the instruction pointer in the execution stream.
						//			//The offset is a signed quantity, enabling branches from –32,768 bytes to 32,767 bytes. An
						//			//offset of 0 points to the action directly after the ActionJump action.
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<as><![CDATA[
						//				while(a){}
						//			]]></as>
						//			<pcode><![CDATA[
						//			label1:
						//				push "a"
						//				getVariable
						//				not
						//				if_ label0
						//				jump label1
						//			label0:
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionJump>
						jumpOffset=data[offset++]|(data[offset++]<<8);
						if(jumpOffset&0x00008000){jumpOffset|=0xffff0000}//最高位为1,表示负数
						offset=offset+jumpOffset;
						if(offset<0||offset>endOffset){
							offset=endOffset;
							trace("offset 已修正为: "+offset,"brown");
						}
					break;
					case AVM1Ops.if_:
						//<ActionIf op="0x9D" opName="if_" opNameFlasm="branchIfTrue" opNameASV="branchIfTrue" opNameSothink="_if">
						//	<description><![CDATA[
						//			//ActionIf
						//			//ActionIf creates a conditional test and branch.
						//			//Field 				Type 					Comment
						//			//ActionIf 				ACTIONRECORDHEADER 		ActionCode = 0x9D
						//			//BranchOffset 			SI16 					Offset
						//			//ActionIf does the following:
						//			//1. Pops Condition, a number, off the stack.
						//			//2. Converts Condition to a Boolean value.
						//			//3. Tests if Condition is true.
						//			//If Condition is true, BranchOffset bytes are added to the instruction pointer in the
						//			//execution stream.
						//			//NOTE
						//			//When playing a SWF 4 file, Condition is not converted to a Boolean value and is
						//			//instead compared to 0, not true.
						//			//The offset is a signed quantity, enabling branches from –32768 bytes to 32767 bytes. An
						//			//offset of 0 points to the action directly after the ActionIf action.
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<as><![CDATA[
						//				if(a){}
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "a"
						//				getVariable
						//				not
						//				if_ label0
						//			label0
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionIf>
						if(stack.pop()){
							jumpOffset=data[offset++]|(data[offset++]<<8);
							if(jumpOffset&0x00008000){jumpOffset|=0xffff0000}//最高位为1,表示负数
							offset=offset+jumpOffset;
							if(offset<0||offset>endOffset){
								offset=endOffset;
								trace("offset 已修正为: "+offset,"brown");
							}
						}else{
							offset+=2;
						}
					break;
					//case AVM1Ops.call:
						//<ActionCall op="0x9E" opName="call" opNameFlasm="callFrame" opNameASV="callFrame" opNameSothink="_call">
						//	<description><![CDATA[
						//			//ActionCall
						//			//ActionCall calls a subroutine.
						//			//Field 				Type 					Comment
						//			//ActionCall 			ACTIONRECORDHEADER 		ActionCode = 0x9E
						//			//ActionCall does the following:
						//			//1. Pops a value off the stack.
						//			//This value should be either a string that matches a frame label, or a number that indicates
						//			//a frame number. The value can be prefixed by a target string that identifies the movie clip
						//			//that contains the frame being called.
						//			//2. If the frame is successfully located, the actions in the target frame are executed.
						//			//After the actions in the target frame are executed, execution resumes at the instruction
						//			//after the ActionCall instruction.
						//			//3. If the frame cannot be found, nothing happens.
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<help><![CDATA[
						//				call 函数
						//				call(frame)
						//				
						//				自 Flash Player 5 后不推荐使用。不推荐使用此动作，而推荐使用 function 语句。
						//				
						//				在被调用帧中执行脚本，而不将播放头移动到该帧。在脚本执行后，局部变量将消失。
						//				
						//				如果变量不是在块 ({}) 内声明的，但执行该动作列表时使用的是 call() 动作，则这些变量是局部变量，并且它们在当前列表结束时到期。 
						//				如果变量不是在块中声明的，且执行当前动作列表时使用的不是 call() 动作，则这些变量被解释为时间轴变量。 
						//				可用性：Flash Player 4；ActionScript 1.0
						//				
						//				参数
						//				frame:Object - 时间轴中帧的标签或编号。
						//			]]></help>
						//			<as><![CDATA[
						//				call("game");
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "game"
						//				call
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionCall>
					//break;
					case AVM1Ops.getVariable:
						//<ActionGetVariable op="0x1C" opName="getVariable" opNameFlasm="getVariable" opNameASV="getVariable" opNameSothink="_getVariable">
						//	<description><![CDATA[
						//			//ActionGetVariable
						//			//ActionGetVariable gets a variable's value.
						//			//Field 				Type 					Comment
						//			//ActionGetVariable 	ACTIONRECORDHEADER 		ActionCode = 0x1C
						//			//ActionGetVariable does the following:
						//			//1. Pops a name off the stack, a string that names is the variable to get.
						//			//2. Pushes the value of the variable to the stack.
						//			//A variable in another execution context can be referenced by prefixing the variable name with
						//			//the target path and a colon. For example: /A/B:FOO references variable FOO in a movie clip
						//			//with a target path of /A/B.
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<as><![CDATA[
						//				a=b;
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "a"
						//				push "b"
						//				getVariable
						//				setVariable
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionGetVariable>
						stack.push(getVar(stack.pop(),vars));
					break;
					case AVM1Ops.setVariable:
						//<ActionSetVariable op="0x1D" opName="setVariable" opNameFlasm="setVariable" opNameASV="setVariable" opNameSothink="_setVariable">
						//	<description><![CDATA[
						//			//ActionSetVariable
						//			//ActionSetVariable sets a variable.
						//			//Field 				Type 					Comment
						//			//ActionSetVariable 	ACTIONRECORDHEADER 		ActionCode = 0x1D
						//			//ActionSetVariable does the following:
						//			//1. Pops the value off the stack.
						//			//2. Pops the name off the stack, a string which names the variable to set.
						//			//3. Sets the variable name in the current execution context to value.
						//			//A variable in another execution context can be referenced by prefixing the variable name with
						//			//the target path and a colon. For example: /A/B:FOO references the FOO variable in the movie
						//			//clip with a target path of /A/B.
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<as><![CDATA[
						//				a=b;
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "a"
						//				push "b"
						//				getVariable
						//				setVariable
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionSetVariable>
						value=stack.pop();
						vars[stack.pop()]=value;
					break;
					case AVM1Ops.getURL2:
						//<ActionGetURL2 op="0x9A" opName="getURL2" opNameFlasm="getURL2,loadMovie,loadVariablesNum,loadVariables" opNameASV="getUrl2" opNameSothink="_getURL2">
						//	<description><![CDATA[
						//			//ActionGetURL2
						//			//ActionGetURL2 gets a URL and is stack based.
						//			//Field 				Type 				Comment
						//			//ActionGetURL2 		ACTIONRECORDHEADER 	ActionCode = 0x9A; Length is always 1
						//			//SendVarsMethod 		UB[2] 				0 = None
						//			//											1 = GET
						//			//											2 = POST
						//			//Reserved 				UB[4] 				Always 0
						//			//LoadTargetFlag 		UB[1] 				0 = Target is a browser window
						//			//											1 = Target is a path to a sprite
						//			//LoadVariablesFlag 	UB[1] 				0 = No variables to load
						//			//											1 = Load variables
						//			//ActionGetURL2 does the following:
						//			//1. Pops target off the stack.
						//			//■ A LoadTargetFlag value of 0 indicates that the target is a window. The target can be an
						//			//empty string to indicate the current window.
						//			//■ A LoadTargetFlag value of 1 indicates that the target is a path to a sprite. The target
						//			//path can be in slash or dot syntax.
						//			//2. Pops a URL off the stack; the URL specifies the URL to be retrieved.
						//			//3. SendVarsMethod specifies the method to use for the HTTP request.
						//			//■ A SendVarsMethod value of 0 indicates that this is not a form request, so the movie
						//			//clip's variables should not be encoded and submitted.
						//
						//			//■ A SendVarsMethod value of 1 specifies a HTTP GET request.
						//			//■ A SendVarsMethod value of 2 specifies a HTTP POST request.
						//			//4. If the SendVarsMethod value is 1 (GET) or 2 (POST), the variables in the current movie
						//			//clip are submitted to the URL by using the standard x-www-form-urlencoded encoding
						//			//and the HTTP request method specified by method.
						//			//If the LoadVariablesFlag is set, the server is expected to respond with a MIME type of
						//			//application/x-www-form-urlencoded and a body in the format
						//			//var1=value1&var2=value2&...&varx=valuex. This response is used to populate
						//			//ActionScript variables rather than display a document. The variables populated can be in a
						//			//timeline (if LoadTargetFlag is 0) or in the specified sprite (if LoadTargetFlag is 1).
						//			//If the LoadTargetFlag is specified without the LoadVariablesFlag, the server is expected to
						//			//respond with a MIME type of application/x-shockwave-flash and a body that consists of a
						//			//SWF file. This response is used to load a subfile into the specified sprite rather than to display
						//			//an HTML document.
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<help><![CDATA[
						//				getURL 函数
						//				getURL(url:String, [window:String, [method:String]]) : Void
						//				
						//				将来自特定 URL 的文档加载到窗口中，或将变量传递到位于所定义的 URL 的另一个应用程序。若要测试此函数，请确保要加载的文件位于指定的位置。若要使用绝对 URL（例如，http://www.myserver.com），则需要网络连接。
						//				
						//				可用性：Flash Player 4；ActionScript 1.0
						//				
						//				参数
						//				url:String - 可从该处获取文档的 URL。
						//				
						//				window:String [可选] - 指定应将文档加载到其中的窗口或 HTML 帧。您可输入特定窗口的名称，或从下面的保留目标名称中选择： 
						//				
						//				_self 指定当前窗口中的当前帧。 
						//				_blank 指定一个新窗口。 
						//				_parent 指定当前帧的父级。 
						//				_top 指定当前窗口中的顶级帧。 
						//				method:String [可选] - 用于发送变量的 GET 或 POST 方法。如果没有变量，则省略此参数。GET 方法将变量附加到 URL 的末尾，它用于发送少量的变量。POST 方法在单独的 HTTP 标头中发送变量，它用于发送长字符串的变量。
						//			]]></help>
						//			<as><![CDATA[
						//				getURL(a,b);
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "a"
						//				getVariable
						//				push "b"
						//				getVariable
						//				getURL2 GET_URL
						//			]]></pcode>
						//			<as><![CDATA[
						//				getURL("http://zero.flashwing.net", "_blank", "GET");
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "http://zero.flashwing.net"
						//				push "_blank"
						//				getURL2 GET_URL,GET
						//			]]></pcode>
						//			<as><![CDATA[
						//				getURL("http://zero.flashwing.net", "_blank", "POST");
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "http://zero.flashwing.net"
						//				push "_blank"
						//				getURL2 GET_URL,POST
						//			]]></pcode>
						//		</sample>
						//		<sample>
						//			<help><![CDATA[
						//				loadMovie 函数
						//				loadMovie(url:String, target:Object, [method:String]) : Void
						//				loadMovie(url:String, target:String, [method:String]) : Void
						//				
						//				在播放原始 SWF 文件时，将 SWF、JPEG、GIF 或 PNG 文件加载到 Flash Player 中的影片剪辑中。在 Flash Player 8 中添加了对非动画 GIF 文件、PNG 文件和渐进式 JPEG 文件的支持。如果加载动画 GIF，则仅显示第一帧。
						//				
						//				提示：如果您要监视下载的进度，则使用 MovieClipLoader.loadClip() 而不是此函数。
						//				
						//				使用 loadMovie() 函数可以一次显示多个 SWF 文件，并且无需加载另一个 HTML 文档即可在 SWF 文件之间进行切换。如果不使用 loadMovie() 函数，则 Flash Player 显示单个 SWF 文件。
						//				
						//				如果要将 SWF 文件或 JPEG 文件加载到特定的级别中，请使用 loadMovieNum() 而不是 loadMovie()。
						//				
						//				如果 SWF 文件加载到目标影片剪辑，则可使用该影片剪辑的目标路径来定位加载的 SWF 文件。加载到目标的 SWF 文件或图像会继承目标影片剪辑的位置、旋转和缩放属性。加载的图像或 SWF 文件的左上角与目标影片剪辑的注册点对齐。或者，如果目标为根时间轴，则该图像或 SWF 文件的左上角与舞台的左上角对齐。
						//				
						//				使用 unloadMovie() 可删除用 loadMovie() 加载的 SWF 文件。
						//				
						//				使用此函数时，请考虑 Flash Player 安全模型。 
						//				
						//				对于 Flash Player 8： 
						//				
						//				如果执行调用的影片剪辑在只能与本地文件系统的内容交互的沙箱中，并且被加载的影片剪辑来自网络沙箱，则不允许加载。 
						//				如果执行调用的 SWF 文件在网络沙箱中并且要加载的影片剪辑是本地的，则不允许加载。 
						//				从受信任的本地沙箱或从只能与远程内容交互的沙箱访问网络沙箱需要通过跨域策略文件获得网站的许可。 
						//				在只能与本地文件系统内容交互的沙箱中的影片剪辑不能对只能与远程内容交互的沙箱中的影片剪辑使用脚本（反之也是禁止的）。 
						//				对于 Flash Player 7 及更高版本： 
						//				
						//				网站可以允许通过跨域策略文件来跨域访问资源。 
						//				基于 SWF 文件的原始域，在各 SWF 文件之间使用脚本受到限制。使用 System.security.allowDomain() 方法可调整这些限制。 
						//				有关更多信息，请参见以下部分： 
						//				
						//				"学习 Flash 中的 ActionScript 2.0"的第 17 章，"了解安全性" 
						//				Flash Player 8 安全性白皮书 
						//				Flash Player 8 与安全相关的 API 白皮书 
						//				可用性：Flash Player 3；ActionScript 1.0
						//				
						//				参数
						//				url:String - 要加载的 SWF 文件或 JPEG 文件的绝对或相对 URL。相对路径必须相对于级别 0 处的 SWF 文件。绝对 URL 必须包括协议引用，例如 http:// 或 file:///。
						//				
						//				target:Object - 对影片剪辑对象的引用或表示目标影片剪辑路径的字符串。目标影片剪辑将被加载的 SWF 文件或图像所替换。
						//				
						//				method:String [可选] - 指定用于发送变量的 HTTP 方法。该参数必须是字符串 GET 或 POST。如果没有要发送的变量，则省略此参数。GET 方法将变量附加到 URL 的末尾，它用于发送少量的变量。POST 方法在单独的 HTTP 标头中发送变量，它用于发送长字符串的变量。
						//			]]></help>
						//			<as><![CDATA[
						//				loadMovie("http://zero.flashwing.net", mc);
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "http://zero.flashwing.net"
						//				push "mc"
						//				getVariable
						//				getURL2 LOAD_MOVIE
						//			]]></pcode>
						//			<as><![CDATA[
						//				loadMovie("http://zero.flashwing.net", mc, "GET");
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "http://zero.flashwing.net"
						//				push "mc"
						//				getVariable
						//				getURL2 LOAD_MOVIE,GET
						//			]]></pcode>
						//			<as><![CDATA[
						//				loadMovie("http://zero.flashwing.net", mc, "POST");
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "http://zero.flashwing.net"
						//				push "mc"
						//				getVariable
						//				getURL2 LOAD_MOVIE,POST
						//			]]></pcode>
						//		</sample>
						//		<sample>
						//			<help><![CDATA[
						//				loadVariablesNum 函数
						//				loadVariablesNum(url:String, level:Number, [method:String]) : Void
						//				
						//				从外部文件（例如文本文件，或由 ColdFusion、CGI 脚本、ASP、PHP 或 Perl 脚本生成的文本）中读取数据，并设置 Flash Player 的某个级别中的变量的值。此函数还可用于使用新值更新活动 SWF 文件中的变量。
						//				
						//				指定的 URL 处的文本必须为标准的 MIME 格式 application/x-www-form-urlencoded（CGI 脚本所使用的一种标准格式）。可以指定任意数量的变量。例如，下面的代码定义了多个变量：
						//				
						//				company=Macromedia&address=601+Townsend&city=San+Francisco&zip=94103
						//				
						//				如果 SWF 文件在比 Flash Player 7 更低的版本中运行，则 url 必须与发布此调用的 SWF 文件位于同一个超级域中。超级域可以通过滤除某一文件的 URL 最左侧的部分而得到。例如，位于 www.someDomain.com 的 SWF 文件可以从位于 store.someDomain.com 的源中加载数据，这是因为这两个文件都在同一个名为 someDomain.com 的超级域中。
						//				
						//				如果任何版本的 SWF 文件在 Flash Player 7 或更高版本中运行，则 url 必须与发布此调用的 SWF 文件位于完全相同的域中（请参见"在 Flash 中使用 ActionScript"中的"Flash Player 安全功能"）。例如，位于 www.someDomain.com 的 SWF 文件只能从同样位于 www.someDomain.com 的源中加载数据。如果要从其它域中加载数据，则可以在承载该 SWF 文件的服务器上放置一个跨域策略文件。有关更多信息，请参见"在 Flash 中使用 ActionScript"中的"关于允许跨域数据加载"。 
						//				
						//				如果要将变量加载到目标影片剪辑中，请使用 loadVariables() 而不是 loadVariablesNum()。
						//				
						//				可用性：Flash Player 4；ActionScript 1.0
						//				
						//				参数
						//				url:String - 变量所处位置的绝对或相对 URL。如果发出此调用的 SWF 文件正在 Web 浏览器上运行，则 url 必须与 SWF 文件位于同一个域中；有关详细信息，请参见"说明"部分。
						//				
						//				level:Number - 一个整数，指定 Flash Player 中接收这些变量的级别。
						//				
						//				method:String [可选] - 指定用于发送变量的 HTTP 方法。该参数必须是字符串 GET 或 POST。如果没有要发送的变量，则省略此参数。GET 方法将变量附加到 URL 的末尾，它用于发送少量的变量。POST 方法在单独的 HTTP 标头中发送变量，它用于发送长字符串的变量。
						//			]]></help>
						//			<as><![CDATA[
						//				loadVariablesNum("http://zero.flashwing.net", 1234);
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "http://zero.flashwing.net"
						//				push "_level1234"
						//				getURL2 LOAD_VARIABLES_NUM
						//			]]></pcode>
						//			<as><![CDATA[
						//				loadVariablesNum("http://zero.flashwing.net", 1234, "GET");
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "http://zero.flashwing.net"
						//				push "_level1234"
						//				getURL2 LOAD_VARIABLES_NUM,GET
						//			]]></pcode>
						//			<as><![CDATA[
						//				loadVariablesNum("http://zero.flashwing.net", 1234, "POST");
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "http://zero.flashwing.net"
						//				push "_level1234"
						//				getURL2 LOAD_VARIABLES_NUM,POST
						//			]]></pcode>
						//		</sample>
						//		<sample>
						//			<help><![CDATA[
						//				loadVariables 函数
						//				loadVariables(url:String, target:Object, [method:String]) : Void
						//				
						//				从外部文件（例如文本文件，或由 ColdFusion、CGI 脚本、Active Server Page (ASP)、PHP 或 Perl 脚本生成的文本）中读取数据，并设置目标影片剪辑中变量的值。此动作还可用于使用新值更新活动 SWF 文件中的变量。
						//				
						//				指定 URL 处的文本必须是标准的 MIME 格式 application/x-www-form-urlencoded（CGI 脚本所使用的一种标准格式）。可以指定任意数量的变量。例如，下面的代码定义了多个变量：
						//				
						//				company=Macromedia&address=600+Townsend&city=San+Francisco&zip=94103
						//				
						//				如果 SWF 文件在比 Flash Player 7 更低的版本中运行，则 url 必须与发布此调用的 SWF 文件位于同一个超级域中。超级域可以通过滤除某一文件的 URL 最左侧的部分而得到。例如，位于 www.someDomain.com 的 SWF 文件可以从位于 store.someDomain.com 的源中加载数据，这是因为这两个文件都在同一个名为 someDomain.com 的超级域中。
						//				
						//				如果任何版本的 SWF 文件在 Flash Player 7 或更高版本中运行，则 url 必须与发布此调用的 SWF 文件位于完全相同的域中（请参见"在 Flash 中使用 ActionScript"中的"Flash Player 安全功能"）。例如，位于 www.someDomain.com 的 SWF 文件只能从同样位于 www.someDomain.com 的源中加载数据。如果要从其它域中加载数据，则可以在承载要被访问的 SWF 文件的服务器上放置一个跨域策略文件。有关更多信息，请参见"在 Flash 中使用 ActionScript"中的"关于允许跨域数据加载"。
						//				
						//				如果要将变量加载到特定的级别中，请使用 loadVariablesNum() 而不是 loadVariables()。
						//				
						//				可用性：Flash Player 4；ActionScript 1.0
						//				
						//				参数
						//				url:String - 变量所处位置的绝对或相对 URL。如果发出此调用的 SWF 文件正在 Web 浏览器上运行，则 url 必须与 SWF 文件位于同一个域中；有关详细信息，请参见"说明"部分。
						//				
						//				target:Object - 指向接收所加载变量的影片剪辑的目标路径。
						//				
						//				method:String [可选] - 指定用于发送变量的 HTTP 方法。该参数必须是字符串 GET 或 POST。如果没有要发送的变量，则省略此参数。GET 方法将变量附加到 URL 的末尾，它用于发送少量的变量。POST 方法在单独的 HTTP 标头中发送变量，它用于发送长字符串的变量。
						//			]]></help>
						//			<as><![CDATA[
						//				loadVariables("http://zero.flashwing.net", mc);
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "http://zero.flashwing.net"
						//				push "mc"
						//				getVariable
						//				getURL2 LOAD_VARIABLES
						//			]]></pcode>
						//			<as><![CDATA[
						//				loadVariables("http://zero.flashwing.net", mc, "GET");
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "http://zero.flashwing.net"
						//				push "mc"
						//				getVariable
						//				getURL2 LOAD_VARIABLES,GET
						//			]]></pcode>
						//			<as><![CDATA[
						//				loadVariables("http://zero.flashwing.net", mc, "POST");
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "http://zero.flashwing.net"
						//				push "mc"
						//				getVariable
						//				getURL2 LOAD_VARIABLES,POST
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionGetURL2>
						flags=data[offset++];
						if(flags&0x80){//LoadVariablesFlag						//10000000
							throw new Error("暂不支持 loadVariables");
						}
						if(flags&0x40){//LoadTargetFlag							//01000000
							throw new Error("暂不支持 loadMovie");
						}
						if(flags&0x03){//SendVarsMethod							//00000011
							throw new Error("暂不支持 SendVarsMethod");
						}
						value2=stack.pop();
						value1=stack.pop();
						//trace("value1="+value1+",value2="+value2);
						if(value1.indexOf("FSCommand:")==0){
							fscommand(value1.replace("FSCommand:",""),value2);
						}else{
							navigateToURL(new URLRequest(value1),value2);
						}
					break;
					//case AVM1Ops.gotoFrame2:
						//<ActionGotoFrame2 op="0x9F" opName="gotoFrame2" opNameFlasm="gotoAndStop,gotoAndPlay" opNameASV="gotoAndStop,gotoAndPlay" opNameSothink="_gotoFrame2">
						//	<description><![CDATA[
						//			//ActionGotoFrame2
						//			//ActionGotoFrame2 goes to a frame and is stack based.
						//			//Field 				Type 						Comment
						//			//ActionGotoFrame2 		ACTIONRECORDHEADER 			ActionCode = 0x9F
						//			//Reserved 				UB[6] 						Always 0
						//			//SceneBiasFlag 		UB[1] 						Scene bias flag
						//			//Play flag 			UB[1] 						0 = Go to frame and stop
						//			//													1 = Go to frame and play
						//			//SceneBias 			If SceneBiasFlag = 1, UI16 	Number to be added to frame determined by stack argument
						//			//ActionGotoFrame2 does the following:
						//			//1. Pops a frame off the stack.
						//			//■ If the frame is a number, n, the next frame of the movie to be displayed is the nth
						//			//frame in the current movie clip.
						//			//■ If the frame is a string, frame is treated as a frame label. If the specified label exists in
						//			//the current movie clip, the labeled frame will become the current frame. Otherwise,
						//			//the action is ignored.
						//			//2. Either a frame or a number can be prefixed by a target path, for example, /MovieClip:3 or
						//			///MovieClip:FrameLabel.
						//			//3. If the Play flag is set, the action goes to the specified frame and begins playing the enclosing
						//			//movie clip. Otherwise, the action goes to the specified frame and stops.
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<help><![CDATA[
						//				gotoAndStop 函数
						//				gotoAndStop([scene:String], frame:Object) : Void
						//				
						//				将播放头转到场景中指定的帧并停止播放。如果未指定场景，播放头将转到当前场景中的帧。只能在根时间轴上使用 scene 参数，不能在影片剪辑或文档中的其它对象的时间轴内使用该参数。
						//				
						//				可用性：Flash Player 2；ActionScript 1.0
						//				
						//				参数
						//				scene:String [可选] - 一个字符串，指定播放头要转到其中的场景的名称。
						//				
						//				frame:Object - 表示播放头转到的帧编号的数字，或者表示播放头转到的帧标签的字符串。
						//			]]></help>
						//			<as><![CDATA[
						//				gotoAndStop(a);//发布为 player5
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "a"
						//				getVariable
						//				gotoFrame2 STOP,10
						//			]]></pcode>
						//		</sample>
						//		<sample>
						//			<help><![CDATA[
						//				gotoAndPlay 函数
						//				gotoAndPlay([scene:String], frame:Object) : Void
						//
						//				将播放头转到场景中指定的帧并从该帧开始播放。如果未指定场景，则播放头将转到当前场景中的指定帧。只能在根时间轴上使用 scene 参数，不能在影片剪辑或文档中的其它对象的时间轴内使用该参数。
						//				
						//				可用性：Flash Player 2；ActionScript 1.0
						//				
						//				参数
						//				scene:String [可选] - 一个字符串，指定播放头要转到其中的场景的名称。
						//				
						//				frame:Object - 表示播放头转到的帧编号的数字，或者表示播放头转到的帧标签的字符串。
						//			]]></help>
						//			<as><![CDATA[
						//				gotoAndPlay(a);//发布为 player5
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "a"
						//				getVariable
						//				gotoFrame2 PLAY,10
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionGotoFrame2>
					//break;
					//case AVM1Ops.setTarget2:
						//<ActionSetTarget2 op="0x20" opName="setTarget2" opNameFlasm="setTargetExpr" opNameASV="setTargetExpr" opNameSothink="_setTarget2">
						//	<description><![CDATA[
						//			//ActionSetTarget2
						//			//ActionSetTarget2 sets the current context and is stack based.
						//			//Field 				Type 					Comment
						//			//ActionSetTarget2 		ACTIONRECORDHEADER 		ActionCode = 0x20
						//			//ActionSetTarget2 pops the target off the stack and makes it the current active context.
						//			//This action behaves exactly like ActionSetTarget but is stack based to enable the target path to
						//			//be the result of expression evaluation.
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<help><![CDATA[
						//				tellTarget 函数
						//				tellTarget(target:String) { 
						//					statement(s);
						//				}
						//
						//				自 Flash Player 5 后不推荐使用。Macromedia 建议使用点 (.) 记号和 with 语句。
						//				
						//				将在 statements 参数中指定的指令应用于在 target 参数中指定的时间轴。tellTarget 动作对导航控制很有帮助。将 tellTarget 分配给用于停止或开始舞台上其它地方的影片剪辑的按钮。还可以使影片剪辑转到此剪辑的特定帧。例如，可以将 tellTarget 分配给用于停止或开始舞台上影片剪辑的按钮，或者分配给用于提示影片剪辑跳至特定帧的按钮。
						//				
						//				在 Flash 5 或更高版本中，可以使用点 (.) 记号代替 tellTarget 动作。可以使用 with 动作向同一个时间轴发出多个动作。使用 with 动作可将任何对象作为目标，而 tellTarget 动作只能将影片剪辑作为目标。
						//				
						//				可用性：Flash Player 3；ActionScript 1.0
						//				
						//				参数
						//				target:String - 一个字符串，指定要控制的时间轴的目标路径。
						//				
						//				statement(s) - 条件为 true 时要执行的指令。
						//			]]></help>
						//			<as><![CDATA[
						//				tellTarget(mc){
						//					trace("Hello World!");
						//				}
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "mc"
						//				getVariable
						//				setTarget2
						//				push "Hello World!"
						//				trace
						//				setTarget ""
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionSetTarget2>
					//break;
					//case AVM1Ops.getProperty:
						//<ActionGetProperty op="0x22" opName="getProperty" opNameFlasm="getProperty" opNameASV="getProperty" opNameSothink="_getProperty">
						//	<description><![CDATA[
						//			//ActionGetProperty
						//			//ActionGetProperty gets a file property.
						//			//Field 				Type 					Comment
						//			//ActionGetProperty 	ACTIONRECORDHEADER 		ActionCode = 0x22
						//			//ActionGetProperty does the following:
						//			//1. Pops index off the stack.
						//			//2. Pops target off the stack.
						//			//3. Retrieves the value of the property enumerated as index from the movie clip with target
						//			//path target and pushes the value to the stack.
						//			//The following table lists property index values. The _quality, _xmouse and _ymouse
						//			//properties are available in SWF 5 and later.
						//			//Property Value
						//			//_x 0
						//			//_y 1
						//			//_xscale 2
						//			//_yscale 3
						//			//_currentframe 4
						//			//_totalframes 5
						//			//_alpha 6
						//			//_visible 7
						//			//_width 8
						//			//_height 9
						//			//_rotation 10
						//			//_target 11
						//			//_framesloaded 12
						//			//_name 13
						//			//_droptarget 14
						//			//_url 15
						//			//_highquality 16
						//			//_focusrect 17
						//			//_soundbuftime 18
						//			//_quality 19
						//			//_xmouse 20
						//			//_ymouse 21
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<help><![CDATA[
						//				getProperty 函数
						//				getProperty(my_mc:Object, property:Object) : Object
						//				
						//				返回影片剪辑 my_mc 的指定属性的值。
						//				
						//				可用性：Flash Player 4；ActionScript 1.0
						//				
						//				参数
						//				my_mc:String - 要检索其属性的影片剪辑的实例名称。
						//				
						//				property - 影片剪辑的一个属性。
						//				
						//				返回
						//				Object - 指定属性的值。
						//			]]></help>
						//			<as><![CDATA[
						//				getProperty(mc,_x);
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "mc"
						//				getVariable
						//				push "0"
						//				getProperty
						//				pop
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionGetProperty>
					//break;
					//case AVM1Ops.setProperty:
						//<ActionSetProperty op="0x23" opName="setProperty" opNameFlasm="setProperty" opNameASV="setProperty" opNameSothink="_setProperty">
						//	<description><![CDATA[
						//			//ActionSetProperty
						//			//ActionSetProperty sets a file property.
						//			//Field 				Type 					Comment
						//			//ActionSetProperty 	ACTIONRECORDHEADER 		ActionCode = 0x23
						//			//ActionSetProperty does the following:
						//			//1. Pops a value off the stack.
						//			//2. Pops an index off the stack.
						//			//3. Pops a target off the stack.
						//			//4. Sets the property enumerated as index in the movie clip with the target path target to the
						//			//value value.
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<help><![CDATA[
						//				setProperty 函数
						//				setProperty(target:Object, property:Object, expression:Object) : Void
						//				
						//				当影片剪辑播放时，更改影片剪辑的属性值。
						//				
						//				可用性：Flash Player 4；ActionScript 1.0
						//				
						//				参数
						//				target:Object - 要设置其属性的影片剪辑的实例名称的路径。 
						//				
						//				property:Object - 要设置的属性。
						//				
						//				expression:Object - 或者是属性的新的字面值，或者是计算结果为属性新值的等式。
						//			]]></help>
						//			<as><![CDATA[
						//				setProperty(mc,_x,0);
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "mc"
						//				getVariable
						//				push 0
						//				push "0"
						//				setProperty
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionSetProperty>
					//break;
					//case AVM1Ops.cloneSprite:
						//<ActionCloneSprite op="0x24" opName="cloneSprite" opNameFlasm="duplicateClip" opNameASV="duplicateClip" opNameSothink="_cloneSprite">
						//	<description><![CDATA[
						//			//ActionCloneSprite
						//			//ActionCloneSprite clones a sprite.
						//			//Field 				Type 					Comment
						//			//ActionCloneSprite 	ACTIONRECORDHEADER 		ActionCode = 0x24
						//			//ActionCloneSprite does the following:
						//			//1. Pops a depth off the stack.
						//			//2. Pops a target off the stack.
						//			//3. Pops a source off the stack.
						//			//4. Duplicates the movie clip source, giving the new instance the name target, at z-order depth
						//			//depth.
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<help><![CDATA[
						//				duplicateMovieClip 函数
						//				duplicateMovieClip(target:String, newname:String, depth:Number) : Void
						//				duplicateMovieClip(target:MovieClip, newname:String, depth:Number) : Void
						//				当 SWF 文件正在播放时，创建一个影片剪辑的实例。无论播放头在原始影片剪辑中处于什么位置，在重复的影片剪辑中，播放头始终从第 1 帧开始。原始影片剪辑中的变量不会复制到重复的影片剪辑中。使用 removeMovieClip() 函数或方法可以删除用 duplicateMovieClip() 创建的影片剪辑实例。
						//				
						//				可用性：Flash Player 4；ActionScript 1.0
						//				
						//				参数
						//				target:Object - 要复制的影片剪辑的目标路径。此参数可以是一个字符串（例如 "my_mc"），也可以是对影片剪辑实例的直接引用（例如 my_mc）。能够接受一种以上数据类型的参数以 Object 类型列出。
						//				
						//				newname:String - 所复制的影片剪辑的唯一标识符。
						//				
						//				depth:Number - 所复制的影片剪辑的唯一深度级别。深度级别是所复制的影片剪辑的堆叠顺序。这种堆叠顺序很像时间轴中图层的堆叠顺序；较低深度级别的影片剪辑隐藏在较高堆叠顺序的剪辑之下。必须为每个所复制的影片剪辑分配一个唯一的深度级别，以防止它替换已占用深度上的 SWF 文件。
						//			]]></help>
						//			<as><![CDATA[
						//				duplicateMovieClip(mc,"mc2",0);
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "mc"
						//				getVariable
						//				push "mc2"
						//				push "16384"
						//				cloneSprite
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionCloneSprite>
					//break;
					//case AVM1Ops.removeSprite:
						//<ActionRemoveSprite op="0x25" opName="removeSprite" opNameFlasm="removeClip" opNameASV="removeClip" opNameSothink="_removeSprite">
						//	<description><![CDATA[
						//			//ActionRemoveSprite
						//			//ActionRemoveSprite removes a clone sprite.
						//			//Field 				Type 					Comment
						//			//ActionRemoveSprite 	ACTIONRECORDHEADER 		ActionCode = 0x25
						//			//ActionRemoveSprite does the following:
						//			//1. Pops a target off the stack.
						//			//2. Removes the clone movie clip that the target path target identifies.
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<help><![CDATA[
						//				removeMovieClip 函数
						//				removeMovieClip(target:Object)
						//				
						//				删除指定的影片剪辑。
						//				
						//				可用性：Flash Player 4；ActionScript 1.0
						//				
						//				参数
						//				target:Object - 用 duplicateMovieClip() 创建的影片剪辑实例的目标路径，或者是用 MovieClip.attachMovie()、MovieClip.duplicateMovieClip() 或 MovieClip.createEmptyMovieClip() 创建的影片剪辑的实例名称。
						//			]]></help>
						//			<as><![CDATA[
						//				removeMovieClip(mc);
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "mc"
						//				getVariable
						//				removeSprite
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionRemoveSprite>
					//break;
					//case AVM1Ops.startDrag:
						//<ActionStartDrag op="0x27" opName="startDrag" opNameFlasm="startDrag" opNameASV="startDrag" opNameSothink="_startDrag">
						//	<description><![CDATA[
						//			//ActionStartDrag
						//			//ActionStartDrag starts dragging a movie clip.
						//			//Field 				Type 					Comment
						//			//ActionStartDrag 		ACTIONRECORDHEADER 		ActionCode = 0x27
						//			//ActionStartDrag does the following:
						//			//1. Pops a target off the stack; target identifies the movie clip to be dragged.
						//			//2. Pops lockcenter off the stack. If lockcenter evaluates to a nonzero value, the center of the
						//			//dragged movie clip is locked to the mouse position. Otherwise, the movie clip moves
						//			//relative to the mouse position when the drag started.
						//			//3. Pops constrain off the stack.
						//			//4. If constrain evaluates to a nonzero value:
						//			//■ Pops y2 off the stack.
						//			//■ Pops x2 off the stack.
						//			//■ Pops y1 off the stack.
						//			//■ Pops x1 off the stack.
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<help><![CDATA[
						//				startDrag 函数
						//				startDrag(target:Object, [lock:Boolean, left:Number, top:Number, right:Number, bottom:Number]) : Void
						//				
						//				使 target 影片剪辑在影片播放过程中可拖动。一次只能拖动一个影片剪辑。执行 startDrag() 操作后，影片剪辑将保持可拖动状态，直到用 stopDrag() 显式停止拖动为止，或直到对其它影片剪辑调用了 startDrag() 动作为止。
						//				
						//				可用性：Flash Player 4；ActionScript 1.0
						//				
						//				参数
						//				target:Object - 要拖动的影片剪辑的目标路径。
						//				
						//				lock:Boolean [可选] - 一个布尔值，指定可拖动影片剪辑是锁定到鼠标位置中央 (true)，还是锁定到用户首次单击该影片剪辑的位置上 (false)。
						//				
						//				left,top,right,bottom:Number [可选] - 相对于该影片剪辑的父级的坐标的值，用以指定该影片剪辑的约束矩形。
						//			]]></help>
						//			<as><![CDATA[
						//				startDrag(mc);
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "0"
						//				push "0"
						//				push "mc"
						//				getVariable
						//				startDrag
						//			]]></pcode>
						//			<as><![CDATA[
						//				startDrag(mc,true,0,0,100,100);
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "0"
						//				push "0"
						//				push "100"
						//				push "100"
						//				push "1"
						//				push "1"
						//				push "mc"
						//				getVariable
						//				startDrag
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionStartDrag>
					//break;
					//case AVM1Ops.endDrag:
						//<ActionEndDrag op="0x28" opName="endDrag" opNameFlasm="stopDrag" opNameASV="stopDrag" opNameSothink="_endDrag">
						//	<description><![CDATA[
						//			//ActionEndDrag
						//			//ActionEndDrag ends the drag operation in progress, if any.
						//			//Field 				Type 					Comment
						//			//ActionEndDrag 		ACTIONRECORDHEADER 		ActionCode = 0x28
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<help><![CDATA[
						//				stopDrag 函数
						//				stopDrag() : Void
						//				
						//				停止当前的拖动操作。
						//				
						//				可用性：Flash Player 4；ActionScript 1.0
						//			]]></help>
						//			<as><![CDATA[
						//				stopDrag();
						//			]]></as>
						//			<pcode><![CDATA[
						//				endDrag
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionEndDrag>
					//break;
					//case AVM1Ops.waitForFrame2:
						//<ActionWaitForFrame2 op="0x8D" opName="waitForFrame2" opNameFlasm="ifFrameLoadedExpr" opNameASV="ifFrameLoadedExpr" opNameSothink="_waitForFrame2">
						//	<description><![CDATA[
						//			//ActionWaitForFrame2
						//			//ActionWaitForFrame2 waits for a frame to be loaded and is stack based.
						//			//Field 				Type 					Comment
						//			//ActionWaitForFrame2 	ACTIONRECORDHEADER 		ActionCode = 0x8D; Length is always 1
						//			//SkipCount 			UI8 					The number of actions to skip
						//			//ActionWaitForFrame2 does the following:
						//			//1. Pops a frame off the stack.
						//			//2. If the frame is loaded, skip the next n actions that follow the current action, where n is
						//			//indicated by SkipCount.
						//			//The frame is evaluated in the same way as ActionGotoFrame2.
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<help><![CDATA[
						//				ifFrameLoaded 函数
						//				ifFrameLoaded([scene:String], frame) { 
						//					statement(s); 
						//				}
						//
						//				自 Flash Player 5 后不推荐使用。此函数已不推荐使用。Macromedia 建议您使用 MovieClip._framesloaded 属性。
						//				
						//				检查特定帧的内容是否在本地可用。使用 ifFrameLoaded 可在 SWF 文件的其余部分下载到本地计算机时开始播放简单的动画。使用 _framesloaded 与 ifFrameLoaded 的区别在于 _framesloaded 允许您添加自定义 if 或 else 语句。 
						//				
						//				可用性：Flash Player 4；ActionScript 1.0
						//				
						//				参数
						//				scene:String [可选] - 一个字符串，它指定必须加载的场景的名称。
						//				
						//				frame:Object - 在执行下一条语句之前必须加载的帧编号或帧标签。
						//			]]></help>
						//			<as><![CDATA[
						//				ifFrameLoaded(a){
						//					trace("Hello World!");
						//				}
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "a"
						//				getVariable
						//				push "10"
						//				add
						//				waitForFrame2 label0
						//				push "Hello World!"
						//				trace
						//			label0:
						//				end
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionWaitForFrame2>
					//break;
					case AVM1Ops.trace:
						//<ActionTrace op="0x26" opName="trace" opNameFlasm="trace" opNameASV="trace" opNameSothink="_trace">
						//	<description><![CDATA[
						//			//ActionTrace
						//			//ActionTrace sends a debugging output string.
						//			//Field 				Type 					Comment
						//			//ActionTrace 			ACTIONRECORDHEADER 		ActionCode = 0x26
						//			//ActionTrace does the following:
						//			//1. Pops a value off the stack.
						//			//2. In the Test Movie mode of the Adobe Flash editor, ActionTrace appends a value to the
						//			//output window if the debugging level is not set to None.
						//			//In Adobe Flash Player, nothing happens.
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<help><![CDATA[
						//				trace 函数
						//				trace(expression:Object)
						//				
						//				您可以使用 Flash 调试播放器捕获来自 trace() 函数的输出并显示结果。
						//				
						//				在测试 SWF 文件时，使用此语句可在"输出"面板中记录编程注释或显示消息。使用 expression 参数可以检查是否存在某种条件，或在"输出"面板中显示值。trace() 语句类似于 JavaScript 中的 alert 函数。
						//				
						//				可以使用"发布设置"对话框中的"省略跟踪动作"命令将 trace() 动作从导出的 SWF 文件中删除。 
						//				
						//				可用性：Flash Player 4；ActionScript 1.0
						//				
						//				参数
						//				expression:Object - 要计算的表达式。在 Flash 创作工具中打开 SWF 文件时（使用"测试影片"命令），expression 参数的值显示在"输出"面板中。
						//			]]></help>
						//			<as><![CDATA[
						//				trace("Hello World!");
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "Hello World!"
						//				trace
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionTrace>
						trace(stack.pop());
					break;
					case AVM1Ops.getTime:
						//<ActionGetTime op="0x34" opName="getTime" opNameFlasm="getTimer" opNameASV="getTimer" opNameSothink="_getTime">
						//	<description><![CDATA[
						//			//ActionGetTime
						//			//ActionGetTime reports the milliseconds since Adobe Flash Player started.
						//			//Field 				Type 					Comment
						//			//ActionGetTime 		ACTIONRECORDHEADER 		ActionCode = 0x34
						//			//ActionGetTime does the following:
						//			//1. Calculates as an integer the number of milliseconds since Flash Player was started.
						//			//2. Pushes the number to the stack.
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<help><![CDATA[
						//				getTimer 函数
						//				getTimer() : Number
						//				
						//				返回自 SWF 文件开始播放时起已经过的毫秒数。
						//				
						//				可用性：Flash Player 4；ActionScript 1.0
						//				
						//				返回
						//				Number - 自 SWF 文件开始播放时起已经过的毫秒数。
						//			]]></help>
						//			<as><![CDATA[
						//				getTimer();
						//			]]></as>
						//			<pcode><![CDATA[
						//				getTime
						//				pop
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionGetTime>
						stack.push(getTimer());
					break;
					case AVM1Ops.randomNumber:
						//<ActionRandomNumber op="0x30" opName="randomNumber" opNameFlasm="random" opNameASV="random" opNameSothink="_randomNumber">
						//	<description><![CDATA[
						//			//ActionRandomNumber
						//			//ActionRandomNumber calculates a random number.
						//			//Field 				Type 					Comment
						//			//ActionRandomNumber 	ACTIONRECORDHEADER 		ActionCode = 0x30
						//			//ActionRandomNumber does the following:
						//			//1. Pops the maximum off the stack.
						//			//2. Calculates a random number as an integer in the range 0…(maximum-1).
						//			//3. Pushes the random number to the stack.
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<help><![CDATA[
						//				random 函数
						//				random(value:Number) : Number
						//				
						//				自 Flash Player 5 后不推荐使用。不推荐使用此函数，而推荐使用 Math.random()。
						//				
						//				返回一个随机整数，此整数介于 0 和小于在 value 参数中指定的整数之间。
						//				
						//				可用性：Flash Player 4；ActionScript 1.0
						//				
						//				参数
						//				value:Number - 一个整数。
						//				
						//				返回
						//				Number - 一个随机整数。
						//			]]></help>
						//			<as><![CDATA[
						//				random(1234);
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "1234"
						//				randomNumber
						//				pop
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionRandomNumber>
						value=stack.pop();
						if(value is uint){
							stack.push(int(Math.random()*value));
						}else{
							stack.push(0);
						}
					break;
					//<!--SWF 5 actions-->
					case AVM1Ops.callFunction:
						//<ActionCallFunction op="0x3D" opName="callFunction" opNameFlasm="callFunction" opNameASV="callFunction" opNameSothink="_callFunction">
						//	<description><![CDATA[
						//			//ActionCallFunction
						//			//ActionCallFunction executes a function. The function can be an ActionScript built-in
						//			//function (such as parseInt), a user-defined ActionScript function, or a native function. For
						//			//more information, see ActionNewObject.
						//			//Field 				Type 					Comment
						//			//ActionCallFunction 	ACTIONRECORDHEADER 		ActionCode = 0x3D
						//			//ActionCallFunction does the following:
						//			//1. Pops the function name (String) from the stack.
						//			//2. Pops numArgs (int) from the stack.
						//			//3. Pops the arguments off the stack.
						//			//4. Invokes the function, passing the arguments to it.
						//			//5. Pushes the return value of the function invocation to the stack.
						//			//If no appropriate return value is present (that is, the function does not have a return
						//			//statement), a push undefined message is generated by the compiler and is pushed to the
						//			//stack. The undefined return value should be popped off the stack.
						//			//For all of the call actions (ActionCallMethod, ActionNewMethod, ActionNewObject, and
						//			//ActionCallFunction) and initialization actions (ActionInitObject and ActionInitArray), the
						//			//arguments of the function are pushed onto the stack in reverse order, with the rightmost
						//			//argument first and the leftmost argument last. The arguments are subsequently popped off in
						//			//order (first to last).
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<help><![CDATA[
						//				关于函数和方法
						//				方法和函数是一些可以在 SWF 文件中的任意位置重复使用的 ActionScript 代码块。您可以在 FLA 文件或外部 ActionScript 文件中编写自己的函数，然后可以从文档内的任意位置调用该函数。方法只是一些位于 ActionScript 类定义中的函数。您可以定义函数，对传递的值执行一系列语句。函数也可以返回值。在定义了函数后，就可以从任意一个时间轴中调用它，包括加载的 SWF 文件的时间轴。 
						//				
						//				如果您将值作为参数传递给函数，则函数就可以使用提供的值进行计算。每个函数都有其各自的特性，而某些函数需要您传递特定类型或数量的值。如果传递的参数多于函数的需要，该函数将忽略多余的值。如果您没有传递必需的参数，则函数将为空的参数指定 undefined 数据类型。这可能导致在运行时出错。函数也可以返回值（请参见从函数中返回值）。
						//			]]></help>
						//			<as><![CDATA[
						//				parseInt("0xff");
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "0xff",1,"parseInt"
						//				callFunction
						//				pop
						//				end
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionCallFunction>
						fName=stack.pop();
						argsArr=new Array();
						i=stack.pop();
						while(--i>=0){
							argsArr.push(stack.pop());
						}
						obj=getVar(fName,vars);
						stack.push(obj.apply(obj,argsArr));
					break;
					case AVM1Ops.callMethod:
						//<ActionCallMethod op="0x52" opName="callMethod" opNameFlasm="callMethod" opNameASV="callMethod" opNameSothink="_callMethod">
						//	<description><![CDATA[
						//			//ActionCallMethod
						//			//ActionCallMethod pushes a method (function) call onto the stack, similar to
						//			//ActionNewMethod.
						//			//Field 				Type 					Comment
						//			//ActionCallMethod 		ACTIONRECORDHEADER 		ActionCode = 0x52
						//			//If the named method exists, ActionCallMethod does the following:
						//			//1. Pops the name of the method from the stack.
						//			//If the method name is blank or undefined, the object is taken to be a function object that
						//			//should be invoked, rather than the container object of a method. For example, if
						//			//CallMethod is invoked with object obj and method name blank, it's equivalent to using
						//			//the syntax:
						//			//obj();
						//			//If a method's name is foo, it's equivalent to:
						//			//obj.foo();
						//			//2. Pops the ScriptObject, object, from the stack.
						//			//3. Pops the number of arguments, args, from the stack.
						//			//4. Pops the arguments off the stack.
						//			//5. Executes the method call with the specified arguments.
						//			//6. Pushes the return value of the method or function to the stack.
						//			//If no appropriate return value is present (the function does not have a return statement), a
						//			//push undefined is generated by the compiler and is pushed to the stack. The undefined
						//			//return value should be popped off the stack.
						//			//For all of the call actions (ActionCallMethod, ActionNewMethod, ActionNewObject, and
						//			//ActionCallFunction) and initialization actions (ActionInitObject and ActionInitArray), the
						//			//arguments of the function are pushed onto the stack in reverse order, with the rightmost
						//			//argument first and the leftmost argument last. The arguments are subsequently popped off in
						//			//order (first to last).
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<help><![CDATA[
						//				关于函数和方法
						//				方法和函数是一些可以在 SWF 文件中的任意位置重复使用的 ActionScript 代码块。您可以在 FLA 文件或外部 ActionScript 文件中编写自己的函数，然后可以从文档内的任意位置调用该函数。方法只是一些位于 ActionScript 类定义中的函数。您可以定义函数，对传递的值执行一系列语句。函数也可以返回值。在定义了函数后，就可以从任意一个时间轴中调用它，包括加载的 SWF 文件的时间轴。 
						//				
						//				如果您将值作为参数传递给函数，则函数就可以使用提供的值进行计算。每个函数都有其各自的特性，而某些函数需要您传递特定类型或数量的值。如果传递的参数多于函数的需要，该函数将忽略多余的值。如果您没有传递必需的参数，则函数将为空的参数指定 undefined 数据类型。这可能导致在运行时出错。函数也可以返回值（请参见从函数中返回值）。
						//			]]></help>
						//			<as><![CDATA[
						//				super();//在某个类的构造函数里
						//			]]></as>
						//			<pcode><![CDATA[
						//				push 0,r:1,undefined
						//				callMethod
						//				pop
						//			]]></pcode>
						//			<as><![CDATA[
						//				obj.foo();
						//			]]></as>
						//			<pcode><![CDATA[
						//				push 0,"obj"
						//				getVariable
						//				push "foo"
						//				callMethod
						//				pop
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionCallMethod>
						fName=stack.pop();
						obj=stack.pop();
						argsArr=new Array();
						i=stack.pop();
						while(--i>=0){
							argsArr.push(stack.pop());
						}
						if(fName is String){
							stack.push(obj[fName].apply(obj,argsArr));
						}else{
							//stack.push(obj.apply(obj,argsArr));
							throw new Error("暂不支持");
						}
					break;
					case AVM1Ops.constantPool:
						//<ActionConstantPool op="0x88" opName="constantPool" opNameFlasm="constants" opNameASV="constants" opNameSothink="_constantPool">
						//	<description><![CDATA[
						//			//ActionConstantPool
						//			//ActionConstantPool creates a new constant pool, and replaces the old constant pool if one
						//			//already exists.
						//			//Field 				Type 					Comment
						//			//ActionConstantPool 	ACTIONRECORDHEADER 		ActionCode = 0x88
						//			//Count 				UI16 					Number of constants to follow
						//			//ConstantPool 			STRING[Count] 			String constants
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<as><![CDATA[
						//				a="a";
						//			]]></as>
						//			<pcode><![CDATA[
						//				constantPool "a"
						//				push "a","a"
						//				setVariable
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionConstantPool>
						constStrV=new Vector.<String>();
						var Count:int=data[offset++]|(data[offset++]<<8);
						for(i=0;i<Count;i++){
							get_str_size=0;
							while(data[offset+(get_str_size++)]){}
							data.position=offset;
							constStrV[i]=data.readUTFBytes(get_str_size);
							offset+=get_str_size;
						}
					break;
					case AVM1Ops.defineFunction:
						//<ActionDefineFunction op="0x9B" opName="defineFunction" opNameFlasm="function" opNameASV="function" opNameSothink="_defineFunction" has2="true">
						//	<description><![CDATA[
						//			//ActionDefineFunction
						//			//NOTE
						//			//ActionDefineFunction is rarely used as of SWF 7 and later; it was superseded by
						//			//ActionDefineFunction2.
						//			//ActionDefineFunction defines a function with a given name and body size.
						//			//Field 				Type 					Comment
						//			//ActionDefineFunction 	ACTIONRECORDHEADER 		ActionCode = 0x9B
						//			//FunctionName 			STRING 					Function name, empty if anonymous
						//			//NumParams 			UI16 					# of parameters
						//			//param 1 				STRING 					Parameter name 1
						//			//param 2 				STRING 					Parameter name 2
						//			//...
						//			//param N 				STRING 					Parameter name N
						//			//codeSize 				UI16 					# of bytes of code that follow
						//			//ActionDefineFunction parses (in order) FunctionName, NumParams, [param1, param2, …,
						//			//param N] and then code size.
						//			//ActionDefineFunction does the following:
						//			//1. Parses the name of the function (name) from the action tag.
						//			//2. Skips the parameters in the tag.
						//			//3. Parses the code size from the tag.
						//			//After the DefineFunction tag, the next codeSize bytes of action data are considered to be
						//			//the body of the function.
						//			//4. Gets the code for the function.
						//			//ActionDefineFunction can be used in the following ways:
						//			//Usage 1 Pushes an anonymous function on the stack that does not persist. This function is
						//			//a function literal that is declared in an expression instead of a statement. An anonymous
						//			//function can be used to define a function, return its value, and assign it to a variable in one
						//			//expression, as in the following ActionScript:
						//			//area = (function () {return Math.PI * radius *radius;})(5);
						//			//Usage 2 Sets a variable with a given FunctionName and a given function definition. This is
						//			//the more conventional function definition. For example, in ActionScript:
						//			//function Circle(radius) {
						//			//	this.radius = radius;
						//			//	this.area = Math.PI * radius * radius;
						//			//}
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<help><![CDATA[
						//				关于函数和方法
						//				方法和函数是一些可以在 SWF 文件中的任意位置重复使用的 ActionScript 代码块。您可以在 FLA 文件或外部 ActionScript 文件中编写自己的函数，然后可以从文档内的任意位置调用该函数。方法只是一些位于 ActionScript 类定义中的函数。您可以定义函数，对传递的值执行一系列语句。函数也可以返回值。在定义了函数后，就可以从任意一个时间轴中调用它，包括加载的 SWF 文件的时间轴。 
						//				
						//				如果您将值作为参数传递给函数，则函数就可以使用提供的值进行计算。每个函数都有其各自的特性，而某些函数需要您传递特定类型或数量的值。如果传递的参数多于函数的需要，该函数将忽略多余的值。如果您没有传递必需的参数，则函数将为空的参数指定 undefined 数据类型。这可能导致在运行时出错。函数也可以返回值（请参见从函数中返回值）。
						//			]]></help>
						//			<as><![CDATA[
						//				function Circle(radius) {
						//					this.radius = radius;
						//					this.area = Math.PI * radius * radius;
						//				}
						//			]]></as>
						//			<pcode><![CDATA[
						//				defineFunction Circle(radius)(end label0)
						//				push r:1
						//				push "radius"
						//				getVariable
						//				storeRegister 1
						//				pop
						//				push "this"
						//				getVariable
						//				push "radius",r:1
						//				setMember
						//				push "this"
						//				getVariable
						//				push "area",3.141592653589793,r:1
						//				multiply
						//				push r:1
						//				multiply
						//				setMember
						//				storeRegister 1
						//				pop
						//			label0:
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionDefineFunction>
						offset+=Length;trace("跳过函数头，直接运行函数体");
					break;
					case AVM1Ops.defineLocal:
						//<ActionDefineLocal op="0x3C" opName="defineLocal" opNameFlasm="varEquals" opNameASV="varequals" opNameSothink="_var" has2="true">
						//	<description><![CDATA[
						//			//ActionDefineLocal
						//			//ActionDefineLocal defines a local variable and sets its value. If the variable already exists, the
						//			//value is set to the newly specified value.
						//			//Field 				Type 					Comment
						//			//ActionDefineLocal 	ACTIONRECORDHEADER 		ActionCode = 0x3C
						//			//ActionDefineLocal does the following:
						//			//1. Pops a value off the stack.
						//			//2. Pops a name off the stack.
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<as><![CDATA[
						//				var a=1234;
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "a",1234
						//				defineLocal
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionDefineLocal>
						value=stack.pop();
						vars[stack.pop()]=value;
					break;
					case AVM1Ops.defineLocal2:
						//<ActionDefineLocal2 op="0x41" opName="defineLocal2" opNameFlasm="var" opNameASV="var" opNameSothink="_var2">
						//	<description><![CDATA[
						//			//ActionDefineLocal2
						//			//ActionDefineLocal2 defines a local variable without setting its value. If the variable already
						//			//exists, nothing happens. The initial value of the local variable is undefined.
						//			//Field 				Type 					Comment
						//			//ActionDefineLocal2 	ACTIONRECORDHEADER 		ActionCode = 0x41
						//			//ActionDefineLocal2 pops name off the stack.
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<as><![CDATA[
						//				var a;
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "a"
						//				defineLocal2
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionDefineLocal2>
						varName=stack.pop();
						if(vars.hasOwnProperty(varName)){
						}else{
							vars[varName]=undefined;
						}
					break;
					case AVM1Ops.delete_:
						//<ActionDelete op="0x3A" opName="delete_" opNameFlasm="delete" opNameASV="delete" opNameSothink="_delete" has2="true">
						//	<description><![CDATA[
						//			//ActionDelete
						//			//ActionDelete deletes a named property from a ScriptObject.
						//			//Field 				Type 					Comment
						//			//ActionDelete 			ACTIONRECORDHEADER 		ActionCode = 0x3A
						//			//ActionDelete does the following:
						//			//1. Pops the name of the property to delete off the stack.
						//			//2. Pops the object to delete the property from.
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<help><![CDATA[
						//				delete 语句
						//				delete reference
						//				
						//				破坏由 reference 参数指定的对象引用，如果成功删除了引用，则返回 true；否则返回 false。该运算符对于释放脚本所用的内存非常有用。可以用 delete 运算符删除对对象的引用。删除所有对对象的引用后，Flash Player 会删除该对象并释放由该对象使用的内存。
						//				
						//				虽然 delete 是一个运算符，但它通常作为语句使用，如以下示例所示：
						//				
						//				delete x;
						//				
						//				如果 reference 参数不存在或无法删除，delete 运算符将失败并返回 false。您不能删除预定义的对象和属性，也不能删除使用 var 语句在函数内声明的变量。不能使用 delete 运算符删除影片剪辑。
						//				
						//				可用性：Flash Player 5；ActionScript 1.0
						//				
						//				返回
						//				Boolean - 一个布尔值。
						//				
						//				参数
						//				reference:Object - 要消除的变量或对象的名称。
						//			]]></help>
						//			<as><![CDATA[
						//				delete obj.foo;
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "obj"
						//				getVariable
						//				push "foo"
						//				delete_
						//				pop
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionDelete>
						varName=stack.pop();
						obj=stack.pop();
						stack.push(delete obj[varName]);
					break;
					//case AVM1Ops.delete2:
						//<ActionDelete2 op="0x3B" opName="delete2" opNameFlasm="delete2" opNameASV="delete2" opNameSothink="_delete2">
						//	<description><![CDATA[
						//			//ActionDelete2
						//			//ActionDelete2 deletes a named property. Flash Player first looks for the property in the
						//			//current scope, and if the property cannot be found, continues to search in the encompassing
						//			//scopes.
						//			//Field 				Type 					Comment
						//			//ActionDelete2 		ACTIONRECORDHEADER 		ActionCode = 0x3B
						//			//ActionDelete2 pops the name of the property to delete off the stack.
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<help><![CDATA[
						//				delete 语句
						//				delete reference
						//				
						//				破坏由 reference 参数指定的对象引用，如果成功删除了引用，则返回 true；否则返回 false。该运算符对于释放脚本所用的内存非常有用。可以用 delete 运算符删除对对象的引用。删除所有对对象的引用后，Flash Player 会删除该对象并释放由该对象使用的内存。
						//				
						//				虽然 delete 是一个运算符，但它通常作为语句使用，如以下示例所示：
						//				
						//				delete x;
						//				
						//				如果 reference 参数不存在或无法删除，delete 运算符将失败并返回 false。您不能删除预定义的对象和属性，也不能删除使用 var 语句在函数内声明的变量。不能使用 delete 运算符删除影片剪辑。
						//				
						//				可用性：Flash Player 5；ActionScript 1.0
						//				
						//				返回
						//				Boolean - 一个布尔值。
						//				
						//				参数
						//				reference:Object - 要消除的变量或对象的名称。
						//			]]></help>
						//			<as><![CDATA[
						//				delete obj;
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "obj"
						//				delete2
						//				pop
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionDelete2>
					//break;
					//case AVM1Ops.enumerate:
						//<ActionEnumerate op="0x46" opName="enumerate" opNameFlasm="enumerate" opNameASV="enumerate" opNameSothink="_enumerate" has2="true">
						//	<description><![CDATA[
						//			//ActionEnumerate
						//			//ActionEnumerate obtains the names of all "slots" in use in an ActionScript object—that is, for
						//			//an object obj, all names X that could be retrieved with the syntax obj.X. ActionEnumerate is
						//			//used to implement the for..in statement in ActionScript.
						//			//NOTE
						//			//Certain special slot names are omitted; for a list of these, search for the term DontEnum in
						//			//the ECMA-262 standard.
						//			//Field 				Type 					Comment
						//			//ActionEnumerate ACTIONRECORDHEADER ActionCode = 0x46
						//			//ActionEnumerate does the following:
						//			//1. Pops the name of the object variable (which can include slash-path or dot-path syntax) off
						//			//of the stack.
						//			//2. Pushes a null value onto the stack to indicate the end of the slot names.
						//			//3. Pushes each slot name (a string) onto the stack.
						//			//NOTE
						//			//The order in which slot names are pushed is undefined.
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<help><![CDATA[
						//				for..in 语句
						//				for (variableIterant in object) {
						//					statement(s);
						//				} 
						//				
						//				迭代对象的属性或数组中的元素，并对每个属性或元素执行 statement。对象的方法不能由 for..in 动作来枚举。
						//				
						//				有些属性不能由 for..in 动作来枚举。例如，不能枚举影片剪辑属性，例如 _x 和 _y。在外部类文件中，和实例成员不同的是，静态成员是不能枚举的。
						//				
						//				for..in 语句迭代所迭代对象的原型链中对象的属性。首先枚举该对象的属性，接着枚举其直接原型的属性，然后枚举该原型的原型的属性，依次类推。for..in 语句不会将相同的属性名枚举两次。如果 child 对象有原型 parent，并且两者都包含属性 prop，则对 child 调用的 for..in 语句将枚举来自 child 的 prop，而忽略 parent 对象中的该属性。
						//				
						//				如果只执行一条语句，用来括起要由 for..in 语句执行的语句块的花括号 ({}) 是不必要的。
						//				
						//				如果在一个类文件（外部 AS 文件）中编写一个 for..in 循环，则实例成员对于该循环不可用，而静态成员则可用。然而，如果在一个 FLA 文件中为类的实例编写一个 for..in 循环，则实例成员在循环中可用，而静态成员不可用。
						//				
						//				可用性：Flash Player 5；ActionScript 1.0
						//				
						//				参数
						//				variableIterant:String - 要作为迭代变量的变量的名称，迭代变量引用对象的每个属性或数组中的每个元素。
						//			]]></help>
						//			<as><![CDATA[
						//				for(var i in obj){}//发布为 player5
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "obj"
						//				enumerate
						//			label1:
						//				storeRegister 0
						//				push null
						//				equals2
						//				if_ label0
						//				push "i",r:0
						//				defineLocal
						//				jump label1
						//			label0:
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionEnumerate>
					//break;
					case AVM1Ops.equals2:
						//<ActionEquals2 op="0x49" opName="equals2" opNameFlasm="equals" opNameASV="equals" opNameSothink="_equals2">
						//	<description><![CDATA[
						//			//ActionEquals2
						//			//ActionEquals2 is similar to ActionEquals, but ActionEquals2 knows about types. The equality
						//			//comparison algorithm from ECMA-262 Section 11.9.3 is applied.
						//			//Field 				Type 					Comment
						//			//ActionEquals2 		ACTIONRECORDHEADER 		ActionCode = 0x49
						//			//ActionEquals2 does the following:
						//			//1. Pops arg1 off the stack.
						//			//2. Pops arg2 off the stack.
						//			//3. Pushes the return value to the stack.
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<help><![CDATA[
						//				== 等于运算符
						//				expression1 == expression2
						//				
						//				测试两个表达式是否相等。如果表达式相等，则结果为 true。
						//				
						//				确定是否相等取决于参数的数据类型：
						//				
						//				数字和布尔值按值进行比较，如果它们具有相同的值，则视为相等。 
						//				如果字符串表达式具有相同的字符数，而且这些字符都相同，则这些字符串表达式相等。 
						//				表示对象、数组和函数的变量按引用进行比较。如果两个变量引用同一个对象、数组或函数，则它们相等。而两个单独的数组即使具有相同数量的元素，也永远不会被视为相等。 
						//				当按值进行比较时，如果 expression1 和 expression2 为不同的数据类型，ActionScript 会尝试将 expression2 的数据类型转换为与 expression1 匹配的数据类型。
						//				
						//				可用性：Flash Player 5；ActionScript 1.0
						//				
						//				操作数
						//				expression1 : Object - 数字、字符串、布尔值、变量、对象、数组或函数。
						//				
						//				expression2 : Object - 数字、字符串、布尔值、变量、对象、数组或函数。
						//				
						//				返回
						//				Boolean - 比较的布尔结果。
						//			]]></help>
						//			<as><![CDATA[
						//				a==b;
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "a"
						//				getVariable
						//				push "b"
						//				getVariable
						//				equals2
						//				pop
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionEquals2>
						value2=stack.pop();
						value1=stack.pop();
						stack.push(value1==value2);
					break;
					case AVM1Ops.getMember:
						//<ActionGetMember op="0x4E" opName="getMember" opNameFlasm="getMember" opNameASV="getMember" opNameSothink="_getMember">
						//	<description><![CDATA[
						//			//ActionGetMember
						//			//ActionGetMember retrieves a named property from an object, and pushes the value of the
						//			//property onto the stack.
						//			//Field 				Type 					Comment
						//			//ActionGetMember 		ACTIONRECORDHEADER 		ActionCode = 0x4E
						//			//ActionGetMember does the following:
						//			//1. Pops the name of the member function.
						//			//2. Pops the ScriptObject object off of the stack.
						//			//3. Pushes the value of the property on to the stack.
						//			//For example, assume obj is an object, and it is assigned a property, foo, as follows:
						//			//obj.foo = 3;
						//			//Then, ActionGetMember with object set to obj and name set to foo pushes 3 onto the stack.
						//			//If the specified property does not exist, undefined is pushed to the stack.
						//			//The object parameter cannot actually be of type Object. If the object parameter is a primitive
						//			//type such as number, Boolean, or string, it is converted automatically to a temporary wrapper
						//			//object of class Number, Boolean, or String. Thus, methods of wrapper objects can be invoked
						//			//on values of primitive types. For example, the following correctly prints 5:
						//			//var x = "Hello";
						//			//trace (x.length);
						//			//In this case, the variable, x, contains the primitive string, "Hello". When x.length is
						//			//retrieved, a temporary wrapper object for x is created by using the String type, which has a
						//			//length property.
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<as><![CDATA[
						//				obj.foo;
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "obj"
						//				getVariable
						//				push "foo"
						//				getMember
						//				pop
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionGetMember>
						varName=stack.pop();
						obj=stack.pop();
						stack.push(obj[varName]);
					break;
					case AVM1Ops.initArray:
						//<ActionInitArray op="0x42" opName="initArray" opNameFlasm="initArray" opNameASV="initArray" opNameSothink="_initArray">
						//	<description><![CDATA[
						//			//ActionInitArray
						//			//ActionInitArray initializes an array in a ScriptObject and is similar to ActionInitObject. The
						//			//newly created object is pushed to the stack. The stack is the only existing reference to the
						//			//newly created object. A subsequent SetVariable or SetMember action can store the newly
						//			//created object in a variable.
						//			//Field 				Type 					Comment
						//			//ActionInitArray 		ACTIONRECORDHEADER 		ActionCode = 0x42
						//			//ActionInitArray pops elems and then [arg1, arg2, …, argn] off the stack.
						//			//ActionInitArray does the following:
						//			//1. Gets the number of arguments (or elements) from the stack.
						//			//2. If arguments are present, ActionInitArray initializes an array object with the right number
						//			//of elements.
						//			//3. Initializes the array as a ScriptObject.
						//			//4. Sets the object type to Array.
						//			//5. Populates the array with initial elements by popping the values off of the stack.
						//			//For all of the call actions (ActionCallMethod, ActionNewMethod, ActionNewObject, and
						//			//ActionCallFunction) and initialization actions (ActionInitObject and ActionInitArray), the
						//			//arguments of the function are pushed onto the stack in reverse order, with the rightmost
						//			//argument first and the leftmost argument last. The arguments are subsequently popped off in
						//			//order (first to last).
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<help><![CDATA[
						//				[] 数组访问运算符
						//				myArray = [ a0, a1,...aN ]
						//				myArray[ i ] = value
						//				myObject [ propertyName ]
						//				
						//				用指定的元素（a0 等）初始化一个新数组或多维数组，或者访问数组中的元素。数组访问运算符使您能够动态地设置和检索实例、变量和对象的名称。它还使您能够访问对象属性。
						//			]]></help>
						//			<as><![CDATA[
						//				obj=[1,2,3,4];
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "obj",4,3,2,1,4
						//				initArray
						//				setVariable
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionInitArray>
						i=stack.pop();
						value=new Array();
						while(--i>=0){
							value.push(stack.pop());
						}
						stack.push(value);
					break;
					case AVM1Ops.initObject:
						//<ActionInitObject op="0x43" opName="initObject" opNameFlasm="initObject" opNameASV="initObject" opNameSothink="_initObject">
						//	<description><![CDATA[
						//			//ActionInitObject
						//			//ActionInitObject initializes an object and is similar to ActionInitArray. The newly created
						//			//object is pushed to the stack. The stack is the only existing reference to the newly created
						//			//object. A subsequent SetVariable or SetMember action can store the newly created object in a
						//			//variable.
						//			//Field 				Type 					Comment
						//			//ActionInitObject 		ACTIONRECORDHEADER 		ActionCode = 0x43
						//			//ActionInitObject pops elems off of the stack. Pops [value1, name1, …, valueN, nameN]
						//			//off the stack.
						//			//ActionInitObject does the following:
						//			//1. Pops the number of initial properties from the stack.
						//			//2. Initializes the object as a ScriptObject.
						//			//3. Sets the object type to Object.
						//			//4. Pops each initial property off the stack.
						//			//For each initial property, the value of the property is popped off the stack, then the name
						//			//of the property is popped off the stack. The name of the property is converted to a string.
						//			//The value can be of any type.
						//			//For all of the call actions (ActionCallMethod, ActionNewMethod, ActionNewObject, and
						//			//ActionCallFunction) and initialization actions (ActionInitObject and ActionInitArray), the
						//			//arguments of the function are pushed onto the stack in reverse order, with the rightmost
						//			//argument first and the leftmost argument last. The arguments are subsequently popped off in
						//			//order (first to last).
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<help><![CDATA[
						//				{} 对象初始值设定项运算符
						//				object = { name1 : value1 , name2 : value2 ,... nameN : valueN }
						//				{expression1; [...expressionN]}
						//				
						//				创建一个新对象，并用指定的 name 和 value 属性对初始化该对象。使用此运算符的效果与使用 new Object 语法并用赋值运算符填充属性对的效果相同。新建对象的原型通常命名为 Object 对象。
						//				
						//				此运算符也用于标记与流控制语句（for、while、if、else、switch）和函数相关联的连续代码块。 
						//				
						//				可用性：Flash Player 5；ActionScript 1.0
						//				
						//				操作数
						//				object : Object - 要创建的对象。name1,2,...N 属性名。 value1,2,...N 每个 name 属性的对应值。
						//				
						//				返回
						//				Object - 
						//				
						//				用法 1：一个 Object 对象。 
						//				
						//				用法 2：无，除非函数具有一个显式的 return 语句，在这种情况中，返回类型在函数实现中指定。
						//			]]></help>
						//			<as><![CDATA[
						//				obj={a:12,b:34};
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "obj","a",12,"b",34,2
						//				initObject
						//				setVariable
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionInitObject>
						i=stack.pop();
						obj=new Object();
						while(--i>=0){
							value=stack.pop();
							varName=stack.pop();
							obj[varName]=value;
						}
						stack.push(obj);
					break;
					case AVM1Ops.newMethod:
						//<ActionNewMethod op="0x53" opName="newMethod" opNameFlasm="newMethod" opNameASV="newMethod" opNameSothink="_newMethod">
						//	<description><![CDATA[
						//			//ActionNewMethod
						//			//ActionNewMethod invokes a constructor function to create a new object. A new object is
						//			//constructed and passed to the constructor function as the value of the this keyword.
						//			//Arguments can be specified to the constructor function. The return value from the
						//			//constructor function is discarded. The newly constructed object is pushed to the stack, similar
						//			//to ActionCallMethod and ActionNewObject.
						//			//Field 				Type 					Comment
						//			//ActionNewMethod 		ACTIONRECORDHEADER 		ActionCode = 0x53
						//			//ActionNewMethod does the following:
						//			//1. Pops the name of the method from the stack.
						//			//2. Pops the ScriptObject from the stack.
						//			//If the name of the method is blank, the ScriptObject is treated as a function object that is
						//			//invoked as the constructor function. If the method name is not blank, the named method
						//			//of the ScriptObject is invoked.
						//			//3. Pops the number of arguments from the stack.
						//			//4. Executes the method call.
						//			//5. Pushes the newly constructed object to the stack.
						//			//If no appropriate return value occurs (for instance, the function does not have a return
						//			//statement), the compiler generates a push undefined and pushes it to the stack. The
						//			//undefined return value should be popped off the stack.
						//			//For all of the call actions (ActionCallMethod, ActionNewMethod, ActionNewObject, and
						//			//ActionCallFunction) and initialization actions (ActionInitObject and ActionInitArray), the
						//			//arguments of the function are pushed onto the stack in reverse order, with the rightmost
						//			//argument first and the leftmost argument last. The arguments are subsequently popped off in
						//			//order (first to last).
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<help><![CDATA[
						//				new 运算符
						//				new constructor()
						//				
						//				创建一个新的初始匿名对象，并调用由 constructor 参数标识的函数。new 运算符将括号中的任何可选参数和用关键字 this 引用的新建对象传递给函数。然后 constructor 函数可以用 this 来设置对象的变量。
						//				
						//				可用性：Flash Player 5；ActionScript 1.0
						//				
						//				操作数
						//				constructor : Object - 一个函数，其后跟用括号括起来的任意可选参数。此函数通常是要构造的对象类型（如 Array、Number 或 Object）的名称。
						//			]]></help>
						//			<as><![CDATA[
						//				function f(){
						//					var obj;
						//					new obj();
						//				}
						//			]]></as>
						//			<pcode><![CDATA[
						//				defineFunction2 f(RegisterCount=2)(flags=SUPPRESS_SUPER|SUPPRESS_ARGUMENTS|SUPPRESS_THIS)()(end label0)
						//				push undefined
						//				storeRegister 1
						//				pop
						//				push 0,r:1,undefined
						//				newMethod
						//				pop
						//			label0:
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionNewMethod>
						fName=stack.pop();
						obj=stack.pop();
						argsArr=new Array();
						i=stack.pop();
						while(--i>=0){
							argsArr.push(stack.pop());
						}
						if(fName is String){
							//stack.push(newClass(obj[fName],argsArr));
							throw new Error("暂不支持");
						}else{
							stack.push(newClass(obj,argsArr));
						}
					break;
					case AVM1Ops.newObject:
						//<ActionNewObject op="0x40" opName="newObject" opNameFlasm="new" opNameASV="new" opNameSothink="_new">
						//	<description><![CDATA[
						//			//ActionNewObject
						//			//ActionNewObject invokes a constructor function. A new object is created and passed to the
						//			//constructor function as the this keyword. In addition, arguments can optionally be specified
						//			//to the constructor function on the stack. The return value of the constructor function is
						//			//discarded. The newly constructed object is pushed to the stack. ActionNewObject is similar
						//			//to ActionCallFunction and ActionNewMethod.
						//			//Field 				Type 					Comment
						//			//ActionNewObject 		ACTIONRECORDHEADER 		ActionCode = 0x40
						//			//ActionNewObject does the following:
						//			//1. Pops the object name (STRING) this from the stack.
						//			//2. Pops numArgs (int) from the stack.
						//			//3. Pops the arguments off the stack.
						//			//4. Invokes the named object as a constructor function, passing it the specified arguments and
						//			//a newly constructed object as the this keyword.
						//			//5. The return value of the constructor function is discarded.
						//			//6. The newly constructed object is pushed to the stack.
						//			//For all of the call actions (ActionCallMethod, ActionNewMethod, ActionNewObject, and
						//			//ActionCallFunction) and initialization actions (ActionInitObject and ActionInitArray), the
						//			//arguments of the function are pushed onto the stack in reverse order, with the rightmost
						//			//argument first and the leftmost argument last. The arguments are subsequently popped off in
						//			//order (first to last).
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<help><![CDATA[
						//				new 运算符
						//				new constructor()
						//				
						//				创建一个新的初始匿名对象，并调用由 constructor 参数标识的函数。new 运算符将括号中的任何可选参数和用关键字 this 引用的新建对象传递给函数。然后 constructor 函数可以用 this 来设置对象的变量。
						//				
						//				可用性：Flash Player 5；ActionScript 1.0
						//				
						//				操作数
						//				constructor : Object - 一个函数，其后跟用括号括起来的任意可选参数。此函数通常是要构造的对象类型（如 Array、Number 或 Object）的名称。
						//			]]></help>
						//			<as><![CDATA[
						//				new Object();
						//			]]></as>
						//			<pcode><![CDATA[
						//				push 0,"Object"
						//				newObject
						//				pop
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionNewObject>
						fName=stack.pop();
						argsArr=new Array();
						i=stack.pop();
						while(--i>=0){
							argsArr.push(stack.pop());
						}
						obj=getVar(fName,vars);
						stack.push(newClass(obj,argsArr));
					break;
					case AVM1Ops.setMember:
						//<ActionSetMember op="0x4F" opName="setMember" opNameFlasm="setMember" opNameASV="setMember" opNameSothink="_setMember">
						//	<description><![CDATA[
						//			//ActionSetMember
						//			//ActionSetMember sets a property of an object. If the property does not already exist, it is
						//			//created. Any existing value in the property is overwritten.
						//			//Field 				Type 					Comment
						//			//ActionSetMember 		ACTIONRECORDHEADER 		ActionCode = 0x4F
						//			//ActionSetMember does the following:
						//			//1. Pops the new value off the stack.
						//			//2. Pops the object name off the stack.
						//			//3. Pops the object off of the stack.
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<as><![CDATA[
						//				obj.foo=1234;
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "obj"
						//				getVariable
						//				push "foo",1234
						//				setMember
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionSetMember>
						value=stack.pop();
						varName=stack.pop();
						obj=stack.pop();
						obj[varName]=value;
					break;
					//case AVM1Ops.targetPath:
						//<ActionTargetPath op="0x45" opName="targetPath" opNameFlasm="targetPath" opNameASV="targetPath" opNameSothink="_targetPath">
						//	<description><![CDATA[
						//			//ActionTargetPath
						//			//If the object in the stack is of type MovieClip, the object's target path is pushed on the stack
						//			//in dot notation. If the object is not a MovieClip, the result is undefined rather than the
						//			//movie clip target path.
						//			//Field 				Type 					Comment
						//			//ActionTargetPath 		ACTIONRECORDHEADER 		ActionCode = 0x45
						//			//ActionTargetPath does the following:
						//			//1. Pops the object off the stack.
						//			//2. Pushes the target path onto the stack.
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<help><![CDATA[
						//				targetPath 函数
						//				targetpath(targetObject:Object) : String
						//				
						//				返回一个字符串，其中包含 MovieClip、Button、TextField 或 Videoobject 的目标路径。该目标路径以点记号 (.) 形式返回。若要检索以斜杠 (/) 记号表示的目标路径，请使用 _target 属性。
						//				
						//				可用性：Flash Player 5；ActionScript 1.0
						//				
						//				参数
						//				targetObject:Object - 正在对其检索目标路径的对象的引用（例如，_root 或 _parent）。这可以是一个 MovieClip、Button 或 TextField 对象。
						//				
						//				返回
						//				String - 包含指定对象的目标路径的字符串。
						//			]]></help>
						//			<as><![CDATA[
						//				targetPath(mc);
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "mc"
						//				getVariable
						//				targetPath
						//				pop
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionTargetPath>
					//break;
					//case AVM1Ops.with_:
						//<ActionWith op="0x94" opName="with_" opNameFlasm="with" opNameASV="with" opNameSothink="_with">
						//	<description><![CDATA[
						//			//ActionWith
						//			//Defines a With block of script.
						//			//Field 				Type 					Comment
						//			//ActionWith 			ACTIONRECORDHEADER 		ActionCode = 0x94
						//			//Size 					UI16 					# of bytes of code that follow
						//			//ActionWith does the following:
						//			//1. Pops the object involved with the With.
						//			//2. Parses the size (body length) of the With block from the ActionWith tag.
						//			//3. Checks to see if the depth of calls exceeds the maximum depth, which is 16 for SWF 6 and
						//			//later, and 8 for SWF 5.
						//			//If the With depth exceeds the maximum depth, the next Size bytes of data are skipped
						//			//rather than executed.
						//			//4. After the ActionWith tag, the next Size bytes of action codes are considered to be the body
						//			//of the With block.
						//			//5. Adds the With block to the scope chain.
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<help><![CDATA[
						//				with 语句
						//				with (object:Object) { 
						//					statement(s); 
						//				}
						//				
						//				允许您使用 object 参数指定一个对象（例如影片剪辑），并使用 statement(s) 参数计算该对象内的表达式和动作。这可以使您不必重复书写对象的名称或路径。
						//				
						//				object 参数变为在其中读取 statement(s) 参数中的属性、变量和函数的上下文。例如，如果 object 是 my_array，并且指定的两个属性为 length 和 concat，则这些属性自动作为 my_array.length 和 my_array.concat 读取。在另一个示例中，如果 object 是 state.california，则 with 语句内部的任何动作或语句将从 california 实例的内部调用。
						//				
						//				若要查找 statement(s) 参数中某个标识符的值，ActionScript 将从 object 指定的范围链的开头开始查找，并按照特定的顺序在范围链的每个级别中搜索该标识符。 
						//				
						//				with 语句使用范围链解析标识符，该范围链从下面列表中的第一项开始，到最后一项结束：
						//				
						//				在最里面的 with 语句中的 object 参数中指定的对象。 
						//				在最外面的 with 语句中的 object 参数中指定的对象。 
						//				激活的对象。（当调用函数时自动创建的临时对象，该函数包含函数所调用的局部变量。） 
						//				包含当前执行脚本的影片剪辑。 
						//				全局对象（诸如 Math 与 String 的内置对象）。 
						//				若要在 with 语句中设置变量，该变量必须已在 with 语句外部进行了声明，或者您必须输入该变量所存在的时间轴的完整路径。如果在 with 语句中设置了未声明的变量，with 语句将根据范围链查找该值。如果该变量尚不存在，则将在调用 with 语句的时间轴上设置此新值。
						//				
						//				可以用直接路径来代替 with()。如果觉得路径输入起来又长又麻烦，可以创建一个局部变量并把路径存储到其中，这样就可以重用代码，如下面的 ActionScript 所示：
						//				
						//				var shortcut = this._parent._parent.name_txt; shortcut.text = "Hank"; shortcut.autoSize = true;
						//				
						//				可用性：Flash Player 5；ActionScript 1.0
						//				
						//				参数
						//				object:Object - ActionScript 对象或影片剪辑的一个实例。
						//			]]></help>
						//			<as><![CDATA[
						//				with(mc){
						//					trace("Hello World!");
						//				}
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "mc"
						//				getVariable
						//				with_ label0
						//				push "Hello World!"
						//				trace
						//			label0:
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionWith>
					//break;
					case AVM1Ops.toNumber:
						//<ActionToNumber op="0x4A" opName="toNumber" opNameFlasm="toNumber" opNameASV="toNumber" opNameSothink="_toNumber">
						//	<description><![CDATA[
						//			//ActionToNumber
						//			//Converts the object on the top of the stack into a number, and pushes the number back to
						//			//the stack.
						//			//For the Object type, the ActionScript valueOf() method is invoked to convert the object to
						//			//a Number type for ActionToNumber. Conversions between primitive types, such as from
						//			//String to Number, are built-in.
						//			//Field 				Type 					Comment
						//			//ActionToNumber 		ACTIONRECORDHEADER 		ActionCode = 0x4A
						//			//ActionToNumber does the following:
						//			//1. Pops the object off of the stack.
						//			//2. Pushes the number on to the stack.
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<help><![CDATA[
						//				Number 函数
						//				Number(expression) : Number
						//				
						//				将参数 expression 转换为数字，并返回下面列表中说明的值：
						//				
						//				如果 expression 是数字，则返回值为 expression。 
						//				如果 expression 是布尔值，则当 expression 是 true 时，返回值为 1；当 expression 是 false 时，返回值为 0。 
						//				如果 expression 为字符串，则该函数尝试将 expression 分析为一个带有可选尾随指数的十进制数字（例如 1.57505e-3）。 
						//				如果 expression 是 NaN，则返回值为 NaN。 
						//				如果 expression 是 undefined，则返回值如下所示：在为 Flash Player 6 或更低版本发布的文件中，结果为 0。在为 Flash Player 7 或更高版本发布的文件中，结果为 NaN。 
						//				可用性：Flash Player 4；ActionScript 1.0
						//				
						//				参数
						//				expression:Object - 要转换为数字的表达式。以 0x 开头的数字或字符串被解释为十六进制值。以 0 开头的数字或字符串被解释为八进制值。
						//				
						//				返回
						//				Number - 一个数字或 NaN（非数字）。
						//			]]></help>
						//			<as><![CDATA[
						//				Number(a);
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "a"
						//				getVariable
						//				toNumber
						//				pop
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionToNumber>
						stack.push(Number(stack.pop()));
					break;
					case AVM1Ops.toString:
						//<ActionToString op="0x4B" opName="toString" opNameFlasm="toString" opNameASV="toString" opNameSothink="_toString">
						//	<description><![CDATA[
						//			//ActionToString
						//			//ActionToString converts the object on the top of the stack into a String, and pushes the
						//			//string back to the stack.
						//			//For the Object type, the ActionScript toString() method is invoked to convert the object
						//			//to the String type for ActionToString.
						//			//Field 				Type 					Comment
						//			//ActionToString 		ACTIONRECORDHEADER 		ActionCode = 0x4B
						//			//ActionToString does the following:
						//			//1. Pops the object off of the stack.
						//			//2. Pushes the string on to the stack.
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<help><![CDATA[
						//				String 函数
						//				String(expression:Object) : String
						//				
						//				返回指定参数的字符串表示形式，如下面的列表所述：
						//				
						//				如果 expression 是数字，则返回字符串为该数字的文本表示形式。 
						//				如果 expression 是字符串，则返回字符串为 expression。 
						//				如果 expression 是一个对象，则返回值是该对象的字符串表示形式，这是通过调用该对象的字符串属性生成的；如果不存在此类属性，则是通过调用 Object.toString() 生成的。 
						//				如果 expression 是布尔值，则返回字符串为 "true" 或 "false"。 
						//				如果 expression 是一个影片剪辑，则返回值是以斜杠 (/) 记号表示的该影片剪辑的目标路径。 
						//				如果 expression 是 undefined，则返回值如下：
						//				
						//				在为 Flash Player 6 和更低版本发布的文件中，结果为空字符串 ("")。 
						//				在为 Flash Player 7 及更高版本发布的文件中，结果为 undefined。 
						//				注意： ActionScript 2.0 不支持斜杠记号。
						//				
						//				
						//				可用性：Flash Player 4；ActionScript 1.0
						//				
						//				参数
						//				expression:Object - 要转换为字符串的表达式。
						//				
						//				返回
						//				String - 一个字符串。
						//			]]></help>
						//			<as><![CDATA[
						//				String(a);
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "a"
						//				getVariable
						//				toString
						//				pop
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionToString>
						stack.push(String(stack.pop()));
					break;
					case AVM1Ops.typeOf:
						//<ActionTypeOf op="0x44" opName="typeOf" opNameFlasm="typeof" opNameASV="typeof" opNameSothink="_typeof">
						//	<description><![CDATA[
						//			//ActionTypeOf
						//			//ActionTypeOf pushes the object type to the stack, which is equivalent to the ActionScript
						//			//TypeOf() method. The possible types are:
						//			//"number"
						//			//"boolean"
						//			//"string"
						//			//"object"
						//			//"movieclip"
						//			//"null"
						//			//"undefined"
						//			//"function"
						//			//Field 				Type 					Comment
						//			//ActionTypeOf 			ACTIONRECORDHEADER 		ActionCode = 0x44
						//			//ActionTypeOf does the following:
						//			//1. Pops the value to determine the type of off the stack.
						//			//2. Pushes a string with the type of the object on to the stack.
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<help><![CDATA[
						//				typeof 运算符
						//				typeof(expression)
						//				
						//				计算 expression 并返回一个字符串，该字符串指定该表达式为字符串、影片剪辑、对象、函数、数字或布尔值。
						//				
						//				可用性：Flash Player 5；ActionScript 1.0
						//				
						//				操作数
						//				expression : Object - 一个字符串、影片剪辑、按钮、对象或函数。
						//				
						//				返回
						//				String - expression 类型的一个 String 表示形式。下表说明对各个类型的 expression 使用 typeof 运算符的结果。 
						//				
						//				
						//				表达式类型
						//				 结果
						//				 
						//				String 
						//				 string
						//				 
						//				影片剪辑 
						//				 movieclip
						//				 
						//				Button 
						//				 object
						//				 
						//				文本字段 
						//				 object
						//				 
						//				Number 
						//				 number
						//				 
						//				Boolean 
						//				 boolean
						//				 
						//				Object 
						//				 object
						//				 
						//				Function 
						//				 function
						//			]]></help>
						//			<as><![CDATA[
						//				typeof(a);
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "a"
						//				getVariable
						//				typeOf
						//				pop
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionTypeOf>
						stack.push(typeof(stack.pop()));
					break;
					case AVM1Ops.add2:
						//<ActionAdd2 op="0x47" opName="add2" opNameFlasm="add" opNameASV="add" opNameSothink="_add2">
						//	<description><![CDATA[
						//			//ActionAdd2
						//			//ActionAdd2 is similar to ActionAdd, but performs the addition differently, according to the
						//			//data types of the arguments. The addition operator algorithm in ECMA-262 Section 11.6.1 is
						//			//used. If string concatenation is applied, the concatenated string is arg2 followed by arg1.
						//			//Field 				Type 					Comment
						//			//ActionAdd2 			ACTIONRECORDHEADER 		ActionCode = 0x47
						//			//ActionAdd2 does the following:
						//			//1. Pops arg1 off of the stack.
						//			//2. Pops arg2 off of the stack.
						//			//3. Pushes the result back to the stack.
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<help><![CDATA[
						//				+ 加法运算符
						//				expression1 + expression2
						//
						//				将数值表达式相加或者连接（合并）字符串。如果其中一个表达式为字符串，则所有其它表达式都被转换为字符串，然后连接起来。两个表达式都为整数时，和为整数；其中一个或两个表达式为浮点数时，和为浮点数。
						//				
						//				可用性：Flash Player 4；ActionScript 1.0
						//				
						//				操作数
						//				expression1 - 一个数字或字符串。
						//				
						//				expression2 : Number - 一个数字或字符串。
						//				
						//				返回
						//				Object - 一个字符串、整数或浮点数。
						//			]]></help>
						//			<as><![CDATA[
						//				trace(a+b);
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "a"
						//				getVariable
						//				push "b"
						//				getVariable
						//				add2
						//				trace
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionAdd2>
						value2=stack.pop();
						value1=stack.pop();
						stack.push(value1+value2);
					break;
					case AVM1Ops.less2:
						//<ActionLess2 op="0x48" opName="less2" opNameFlasm="lessThan" opNameASV="lessThan" opNameSothink="_less2">
						//	<description><![CDATA[
						//			//ActionLess2
						//			//ActionLess2 calculates whether arg1 is less than arg2 and pushes a Boolean return value to the
						//			//stack. This action is similar to ActionLess, but performs the comparison differently according
						//			//to the data types of the arguments. The abstract relational comparison algorithm in ECMA-
						//			//262 Section 11.8.5 is used.
						//			//Field 				Type 					Comment
						//			//ActionLess2 			ACTIONRECORDHEADER 		ActionCode = 0x48
						//			//ActionLess2 does the following:
						//			//1. Pops arg1 off of the stack.
						//			//2. Pops arg2 off of the stack.
						//			//3. Compares arg2 < arg1.
						//			//4. Pushes the return value (a Boolean value) onto the stack.
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<help><![CDATA[
						//				< 小于运算符
						//				expression1 < expression2
						//				
						//				比较两个表达式，确定 expression1 是否小于 expression2；如果是，则此运算符返回 true。如果 expression1 大于或等于 expression2，则该运算符返回 false。使用字母顺序计算字符串表达式；所有的大写字母排在小写字母的前面。
						//				
						//				可用性：Flash Player 4；ActionScript 1.0
						//				
						//				操作数
						//				expression1 : Number - 一个数字或字符串。
						//				
						//				expression2 : Number - 一个数字或字符串。
						//				
						//				返回
						//				Boolean - 比较的布尔结果。
						//			]]></help>
						//			<as><![CDATA[
						//				trace(a<b);
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "a"
						//				getVariable
						//				push "b"
						//				getVariable
						//				less2
						//				trace
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionLess2>
						value2=stack.pop();
						value1=stack.pop();
						stack.push(value1<value2);
					break;
					case AVM1Ops.modulo:
						//<ActionModulo op="0x3F" opName="modulo" opNameFlasm="modulo" opNameASV="modulo" opNameSothink="_modulo">
						//	<description><![CDATA[
						//			//ActionModulo
						//			//ActionModulo calculates x modulo y. If y is 0, then NaN (0x7FC00000) is pushed to the
						//			//stack.
						//			//Field 				Type 					Comment
						//			//ActionModulo 			ACTIONRECORDHEADER 		ActionCode = 0x3F
						//			//ActionModulo does the following:
						//			//1. Pops x then y off of the stack.
						//			//2. Pushes the value x % y on to the stack.
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<help><![CDATA[
						//				% 模运算符
						//				expression1 % expression2
						//				
						//				计算 expression1 除以 expression2 的余数。如果有任一 expression 参数是非数字值，则模运算符 (%) 尝试将它们转换为数字。expression 可以是数字或转换为数值的字符串。
						//				
						//				模运算结果的符号与被除数（第一个数字）的符号相匹配。例如，-4 % 3 和 -4 % -3 的计算结果都为 -1。
						//				
						//				可用性：Flash Player 4；ActionScript 1.0
						//				
						//				操作数
						//				expression1 : Number - 数字或计算结果为数字的表达式。
						//				
						//				expression2 : Number - 数字或计算结果为数字的表达式。
						//				
						//				返回
						//				Number - 算术运算的结果。
						//				
						//				示例
						//				下面的数值示例使用模运算符 (%)： 
						//				
						//				trace(12%5); // traces 2 
						//				trace(4.3%2.1); // traces 0.0999999999999996 
						//				trace(4%4); // traces 0 
						//				
						//				第一个 trace 返回 2，而不是 12/5 或 2.4，因为模运算符 (%) 仅返回余数。第二个 trace 返回 0.0999999999999996 而不是预期的 0.1，因为在二进制计算中对浮点数精度有限制。
						//			]]></help>
						//			<as><![CDATA[
						//				trace(a%b);
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "a"
						//				getVariable
						//				push "b"
						//				getVariable
						//				modulo
						//				trace
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionModulo>
						value2=stack.pop();
						value1=stack.pop();
						stack.push(value1%value2);
					break;
					case AVM1Ops.bitAnd:
						//<ActionBitAnd op="0x60" opName="bitAnd" opNameFlasm="bitwiseAnd" opNameASV="bitwiseAnd" opNameSothink="_bitwiseAnd">
						//	<description><![CDATA[
						//			//ActionBitAnd
						//			//ActionBitAnd pops two numbers off of the stack, performs a bitwise AND, and pushes an
						//			//S32 number to the stack. The arguments are converted to 32-bit unsigned integers before
						//			//performing the bitwise operation. The result is a SIGNED 32-bit integer.
						//			//Field 				Type 					Comment
						//			//ActionBitAnd 			ACTIONRECORDHEADER 		ActionCode = 0x60
						//			//ActionBitAnd does the following:
						//			//1. Pops arg1 then arg2 off of the stack.
						//			//2. Pushes the result to the stack.
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<help><![CDATA[
						//				& 按位 AND 运算符
						//				expression1 & expression2
						//				
						//				将 expression1 和 expression2 转换为 32 位无符号整数，并对整数参数的每一位执行布尔 AND 运算。浮点数通过舍去小数点后面的所有位来转换为整数。结果是一个新的 32 位整数。
						//				
						//				正整数转换为无符号的十六进制值，其最大值为 4294967295 或 0xFFFFFFFF；转换大于最大值的数时，会舍去最高有效位，使该值仍保持为 32 位。负数通过 2 的补码标记转换为无符号的十六进制值，其最小值为 -2147483648 或 0x800000000；小于最小值的数转换为精度更高的 2 的补码，同时也会舍去最高有效位。 
						//				
						//				由于返回值解释为带符号的 2 的补码数，因此，返回值将是 -2147483648 到 2147483647 范围中的一个整数。
						//				
						//				可用性：Flash Player 5；ActionScript 1.0
						//				
						//				操作数
						//				expression1 : Number - 一个数字。
						//				
						//				expression2 : Number - 一个数字。
						//				
						//				返回
						//				Number - 按位运算的结果。
						//			]]></help>
						//			<as><![CDATA[
						//				trace(a&b);
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "a"
						//				getVariable
						//				push "b"
						//				getVariable
						//				bitAnd
						//				trace
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionBitAnd>
						value2=stack.pop();
						value1=stack.pop();
						stack.push(value1&value2);
					break;
					case AVM1Ops.bitLShift:
						//<ActionBitLShift op="0x63" opName="bitLShift" opNameFlasm="shiftLeft" opNameASV="shiftLeft" opNameSothink="_shiftLeft">
						//	<description><![CDATA[
						//			//ActionBitLShift
						//			//ActionBitLShift pops the shift count arg and then value off of the stack. The value argument
						//			//is converted to 32-bit signed integer and only the least significant 5 bits are used as the shift
						//			//count. The bits in the value arg are shifted to the left by the shift count. ActionBitLShift
						//			//pushes an S32 number to the stack.
						//			//Field 				Type 					Comment
						//			//ActionBitLShift 		ACTIONRECORDHEADER 		ActionCode = 0x63
						//			//ActionBitLShift does the following:
						//			//1. Pops shift count arg, then value off of the stack.
						//			//2. Pushes the result to the stack.
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<help><![CDATA[
						//				<< 按位向左移位运算符
						//				expression1 << expression2
						//				
						//				将 expression1 和 expression2 转换为 32 位整数值；可将其分别称为 V1 和 V2。将值 V1 的所有位向左移动 V2 个位置。将此运算中 V1 移到左端以外的位舍去，并在右端空出位的位置插入零。将一个值向左侧移动一位与这个值乘以 2 等效。
						//				
						//				浮点数通过舍去小数点后面的所有位来转换为整数。正整数转换为无符号的十六进制值，其最大值为 4294967295 或 0xFFFFFFFF；转换大于最大值的数时，会舍去最高有效位，因此该值仍保持为 32 位。负数通过 2 的补码标记转换为无符号的十六进制值，其最小值为 -2147483648 或 0x800000000；小于最小值的数转换为精度更高的 2 的补码，同时也会舍去最高有效位。 
						//				
						//				由于返回值解释为带符号的 2 的补码数，因此，返回值将是 -2147483648 到 2147483647 范围中的一个整数。 
						//				
						//				可用性：Flash Player 5；ActionScript 1.0
						//				
						//				操作数
						//				expression1 : Number - 要向左移位的数字或表达式。
						//				
						//				expression2 : Number - 转换为从 0 到 31 的整数的数字或表达式。
						//				
						//				返回
						//				Number - 按位运算的结果。
						//			]]></help>
						//			<as><![CDATA[
						//				trace(a<<b);
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "a"
						//				getVariable
						//				push "b"
						//				getVariable
						//				bitLShift
						//				trace
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionBitLShift>
						value2=stack.pop();
						value1=stack.pop();
						stack.push(value1<<value2);
					break;
					case AVM1Ops.bitOr:
						//<ActionBitOr op="0x61" opName="bitOr" opNameFlasm="bitwiseOr" opNameASV="bitwiseOr" opNameSothink="_bitwiseOr">
						//	<description><![CDATA[
						//			//ActionBitOr
						//			//ActionBitOr pops two numbers off of the stack, performs a bitwise OR, and pushes an S32
						//			//number to the stack. The arguments are converted to 32-bit unsigned integers before
						//			//performing the bitwise operation. The result is a SIGNED 32-bit integer.
						//			//Field 				Type 					Comment
						//			//ActionBitOr 			ACTIONRECORDHEADER 		ActionCode = 0x61
						//			//ActionBitOr does the following:
						//			//1. Pops arg1 then arg2 off of the stack.
						//			//2. Pushes the result to the stack.
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<help><![CDATA[
						//				| 按位 OR 运算符
						//				expression1 | expression2
						//				
						//				将 expression1 和 expression2 转换为无符号的 32 位整数，然后对于 expression1 或 expression2 的为 1 的对应位的每一位返回 1。浮点数通过舍去小数点后面的所有位来转换为整数。结果是一个新的 32 位整数。
						//				
						//				正整数转换为无符号的十六进制值，其最大值为 4294967295 或 0xFFFFFFFF；转换大于最大值的数时，会舍去最高有效位，因此该值仍保持为 32 位。负数通过 2 的补码标记转换为无符号的十六进制值，其最小值为 -2147483648 或 0x800000000；小于最小值的数转换为精度更高的 2 的补码，同时也会舍去最高有效位。 
						//				
						//				由于返回值解释为带符号的 2 的补码数，因此，返回值将是 -2147483648 到 2147483647 范围中的一个整数。 
						//				
						//				可用性：Flash Player 5；ActionScript 1.0
						//				
						//				操作数
						//				expression1 : Number - 一个数字。
						//				
						//				expression2 : Number - 一个数字。
						//				
						//				返回
						//				Number - 按位运算的结果。
						//			]]></help>
						//			<as><![CDATA[
						//				trace(a|b);
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "a"
						//				getVariable
						//				push "b"
						//				getVariable
						//				bitOr
						//				trace
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionBitOr>
						value2=stack.pop();
						value1=stack.pop();
						stack.push(value1|value2);
					break;
					case AVM1Ops.bitRShift:
						//<ActionBitRShift op="0x64" opName="bitRShift" opNameFlasm="shiftRight" opNameASV="shiftRight" opNameSothink="_shiftRight">
						//	<description><![CDATA[
						//			//ActionBitRShift
						//			//ActionBitRShift pops the shift count from the stack. Pops the value from the stack. The value
						//			//argument is converted to a 32-bit signed integer and only the least significant 5 bits are used
						//			//as the shift count.
						//			//The bits in the arg value are shifted to the right by the shift count. ActionBitRShift pushes an
						//			//S32 number to the stack.
						//			//Field 				Type 					Comment
						//			//ActionBitRShift 		ACTIONRECORDHEADER 		ActionCode = 0x64
						//			//ActionBitRShift does the following:
						//			//1. Pops the shift count from the stack.
						//			//2. Pops the value to shift from the stack.
						//			//3. Pushes the result to the stack.
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<help><![CDATA[
						//				>> 按位向右移位运算符
						//				expression1 >> expression2
						//				
						//				将 expression1 和 expression2 转换为 32 位整数，并将 expression1 中的所有位向右移动由 expression2 转换所得到的整数指定的位数。移到右端以外的位将被舍去。若要保留原始 expression 的符号，则如果 expression1 的最高有效位（最左端的位）为 0，那么左侧的位都填补 0；如果最高有效位为 1，那么左侧的位都填补 1。将一个值右移一位等效于将它除以 2 并舍去余数。
						//				
						//				浮点数通过舍去小数点后面的所有位来转换为整数。正整数转换为无符号的十六进制值，其最大值为 4294967295 或 0xFFFFFFFF；转换大于最大值的数时，会舍去最高有效位，因此该值仍保持为 32 位。负数通过 2 的补码标记转换为无符号的十六进制值，其最小值为 -2147483648 或 0x800000000；小于最小值的数转换为精度更高的 2 的补码，同时也会舍去最高有效位。 
						//				
						//				由于返回值解释为带符号的 2 的补码数，因此，返回值将是 -2147483648 到 2147483647 范围中的一个整数。 
						//				
						//				可用性：Flash Player 5；ActionScript 1.0
						//				
						//				操作数
						//				expression1 : Number - 要向右移位的数字或表达式。
						//				
						//				expression2 : Number - 转换为从 0 到 31 的整数的数字或表达式。
						//				
						//				返回
						//				Number - 按位运算的结果。
						//			]]></help>
						//			<as><![CDATA[
						//				trace(a>>b);
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "a"
						//				getVariable
						//				push "b"
						//				getVariable
						//				bitRShift
						//				trace
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionBitRShift>
						value2=stack.pop();
						value1=stack.pop();
						stack.push(value1>>value2);
					break;
					case AVM1Ops.bitURShift:
						//<ActionBitURShift op="0x65" opName="bitURShift" opNameFlasm="shiftRight2" opNameASV="shiftRight2" opNameSothink="_shiftRight2">
						//	<description><![CDATA[
						//			//ActionBitURShift
						//			//ActionBitURShift pops the value and shift count arguments from the stack. The value
						//			//argument is converted to 32-bit signed integer and only the least significant 5 bits are used as
						//			//the shift count.
						//			//The bits in the arg value are shifted to the right by the shift count. ActionBitURShift pushes
						//			//a UI32 number to the stack.
						//			//Field 				Type 					Comment
						//			//ActionBitURShift 		ACTIONRECORDHEADER 		ActionCode = 0x65
						//			//ActionBitURShift does the following:
						//			//1. Pops the shift count from the stack.
						//			//2. Pops the value to shift from the stack.
						//			//3. Pushes the result to the stack.
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<help><![CDATA[
						//				>>> 按位无符号向右移位运算符
						//				expression1 >>> expression2
						//				
						//				除了不保留原始 expression 的符号外，此运算符与按位向右移位运算符 (>>) 相同，这是因为左侧的位始终用 0 填充。
						//				
						//				浮点数通过舍去小数点后面的所有位来转换为整数。正整数转换为无符号的十六进制值，其最大值为 4294967295 或 0xFFFFFFFF；转换大于最大值的数时，会舍去最高有效位，因此该值仍保持为 32 位。负数通过 2 的补码标记转换为无符号的十六进制值，其最小值为 -2147483648 或 0x800000000；小于最小值的数转换为精度更高的 2 的补码，同时也会舍去最高有效位。 
						//				
						//				可用性：Flash Player 5；ActionScript 1.0
						//				
						//				操作数
						//				expression1 : Number - 要向右移位的数字或表达式。
						//				
						//				expression2 : Number - 转换为从 0 到 31 的整数的数字或表达式。
						//				
						//				返回
						//				Number - 按位运算的结果。
						//			]]></help>
						//			<as><![CDATA[
						//				trace(a>>>b);
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "a"
						//				getVariable
						//				push "b"
						//				getVariable
						//				bitURShift
						//				trace
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionBitURShift>
						value2=stack.pop();
						value1=stack.pop();
						stack.push(value1>>>value2);
					break;
					case AVM1Ops.bitXor:
						//<ActionBitXor op="0x62" opName="bitXor" opNameFlasm="bitwiseXor" opNameASV="bitwiseXor" opNameSothink="_bitwiseXor">
						//	<description><![CDATA[
						//			//ActionBitXor
						//			//ActionBitXor pops two numbers off of the stack, performs a bitwise XOR, and pushes an S32
						//			//number to the stack.
						//			//The arguments are converted to 32-bit unsigned integers before performing the bitwise
						//			//operation. The result is a SIGNED 32-bit integer.
						//			//Field 				Type 					Comment
						//			//ActionBitXor 			ACTIONRECORDHEADER 		ActionCode = 0x62
						//			//ActionBitXor does the following:
						//			//1. Pops arg1 and arg2 off of the stack.
						//			//2. Pushes the result back to the stack.
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<help><![CDATA[
						//				^ 按位 XOR 运算符
						//				expression1 ^ expression2
						//				
						//				将 expression1 和 expression2 转换为无符号 32 位整数，然后对于 expression1 或 expression2 中为 1（但不在两者中同时为 1）的相应位的每一位返回 1。浮点数通过舍去小数点后面的所有位来转换为整数。结果是一个新的 32 位整数。
						//				
						//				正整数转换为无符号的十六进制值，其最大值为 4294967295 或 0xFFFFFFFF；转换大于最大值的数时，会舍去最高有效位，因此该值仍保持为 32 位。负数通过 2 的补码标记转换为无符号的十六进制值，其最小值为 -2147483648 或 0x800000000；小于最小值的数转换为精度更高的 2 的补码，同时也会舍去最高有效位。 
						//				
						//				由于返回值解释为带符号的 2 的补码数，因此，返回值将是 -2147483648 到 2147483647 范围中的一个整数。 
						//				
						//				可用性：Flash Player 5；ActionScript 1.0
						//				
						//				操作数
						//				expression1 : Number - 一个数字。
						//				
						//				expression2 : Number - 一个数字。
						//				
						//				返回
						//				Number - 按位运算的结果。
						//			]]></help>
						//			<as><![CDATA[
						//				trace(a^b);
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "a"
						//				getVariable
						//				push "b"
						//				getVariable
						//				bitXor
						//				trace
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionBitXor>
						value2=stack.pop();
						value1=stack.pop();
						stack.push(value1^value2);
					break;
					case AVM1Ops.decrement:
						//<ActionDecrement op="0x51" opName="decrement" opNameFlasm="decrement" opNameASV="decrement" opNameSothink="_decrement">
						//	<description><![CDATA[
						//			//ActionDecrement
						//			//ActionDecrement pops a value from the stack, converts it to number type, decrements it by 1,
						//			//and pushes it back to the stack.
						//			//Field 				Type 					Comment
						//			//ActionDecrement 		ACTIONRECORDHEADER 		ActionCode = 0x51
						//			//ActionDecrement does the following:
						//			//1. Pops the number off of the stack.
						//			//2. Pushes the result on to the stack.
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<help><![CDATA[
						//				-- 递减运算符
						//				--expression
						//				expression--
						//				
						//				从 expression 中减 1 的预先递减和滞后递减一元运算符。 expression 可以是变量、数组中的元素或对象的属性。此运算符的预先递减格式 (--expression) 从 expression 中减去 1，然后返回结果。此运算符的滞后递减格式 (expression--) 从 expression 中减去 1，然后返回 expression 的初始值（即减去 1 之前的值）。
						//				
						//				可用性：Flash Player 4；ActionScript 1.0
						//				
						//				操作数
						//				expression : Number - 一个数字或计算结果为数字的一个变量。
						//				
						//				返回
						//				Number -被递减的值的结果。
						//			]]></help>
						//			<as><![CDATA[
						//				a--;
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "a","a"
						//				getVariable
						//				decrement
						//				setVariable
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionDecrement>
						stack.push(stack.pop()-1);
					break;
					case AVM1Ops.increment:
						//<ActionIncrement op="0x50" opName="increment" opNameFlasm="increment" opNameASV="increment" opNameSothink="_increment">
						//	<description><![CDATA[
						//			//ActionIncrement
						//			//ActionIncrement pops a value from the stack, converts it to number type, increments it by 1,
						//			//and pushes it back to the stack.
						//			//Field 				Type 					Comment
						//			//ActionIncrement 		ACTIONRECORDHEADER 		ActionCode = 0x50
						//			//ActionIncrement does the following:
						//			//1. Pops the number off of the stack.
						//			//2. Pushes the result on to the stack.
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<help><![CDATA[
						//				++ 递增运算符
						//				++expression
						//				expression++
						//				
						//				将 expression 加 1 的预先递增和滞后递增一元运算符。 expression 可以是变量、数组中的元素或对象的属性。运算符的预先递增格式 (++expression) 将 expression 加 1，然后返回结果。此运算符的滞后递增格式 (expression++) 将 expression 加 1，并返回 expression 的初始值（即增加之前的值）。
						//				
						//				頓炬륜돨渡邱뒵藤목駕쉥 x 뒵藤槨 2 (x + 1 = 2)，깻쉥써벎鱗槨 y 럿쀼：
						//				
						//				var x:Number = 1; 
						//				var y:Number = ++x; 
						//				trace("x:"+x); //traces x:2 
						//				trace("y:"+y); //traces y:2
						//				
						//				此运算符的滞后递增格式将 x 递增为 2 (x + 1 = 2)，并将 x 的初始值作为结果 y 返回： 
						//				
						//				var x:Number = 1; 
						//				var y:Number = x++; 
						//				trace("x:"+x); //traces x:2 
						//				trace("y:"+y); //traces y:1
						//				
						//				可用性：Flash Player 4；ActionScript 1.0
						//				
						//				操作数
						//				expression : Number - 一个数字或计算结果为数字的一个变量。
						//				
						//				返回
						//				Number - 递增的结果。
						//			]]></help>
						//			<as><![CDATA[
						//				a++;
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "a","a"
						//				getVariable
						//				increment
						//				setVariable
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionIncrement>
						stack.push(stack.pop()+1);
					break;
					case AVM1Ops.pushDuplicate:
						//<ActionPushDuplicate op="0x4C" opName="pushDuplicate" opNameFlasm="dup" opNameASV="dup" opNameSothink="_dup">
						//	<description><![CDATA[
						//			//ActionPushDuplicate
						//			//ActionPushDuplicate pushes a duplicate of top of stack (the current return value) to the stack.
						//			//Field 				Type 					Comment
						//			//ActionPushDuplicate 	ACTIONRECORDHEADER 		ActionCode = 0x4C
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<as><![CDATA[
						//				trace(a||b);
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "a"
						//				getVariable
						//				pushDuplicate
						//				if_ label0
						//				pop
						//				push "b"
						//				getVariable
						//			label0:
						//				trace
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionPushDuplicate>
						value=stack.pop();
						stack.push(value);
						stack.push(value);
					break;
					case AVM1Ops.return_:
						//<ActionReturn op="0x3E" opName="return_" opNameFlasm="return" opNameASV="return" opNameSothink="_return">
						//	<description><![CDATA[
						//			//ActionReturn
						//			//ActionReturn forces the return item to be pushed off the stack and returned. If a return is not
						//			//appropriate, the return item is discarded.
						//			//Field 				Type 					Comment
						//			//ActionReturn 			ACTIONRECORDHEADER 		ActionCode = 0x3E
						//			//ActionReturn pops a value off the stack.
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<help><![CDATA[
						//				return 语句
						//				return[expression]
						//				
						//				指定由函数返回的值。return 语句计算 expression 并将结果作为在其中执行该语句的函数的值返回。return 语句使执行立即返回到调用函数。如果单独使用 return 语句，则它返回 undefined。
						//				
						//				您不能返回多个值。如果尝试返回多个值，则将只返回最后一个值。在下面的示例中，返回 c：
						//				
						//				return a, b, c ;
						//				
						//				如果需要返回多个值，可以改用数组或对象。
						//				
						//				可用性：Flash Player 5；ActionScript 1.0
						//				
						//				返回
						//				String - 经过计算的 expression 参数（如果提供了）。
						//				
						//				参数
						//				expression - 要计算的字符串、数字、布尔值、数组或对象，其计算结果作为函数值返回。此参数是可选的。
						//			]]></help>
						//			<as><![CDATA[
						//				return 1234;
						//			]]></as>
						//			<pcode><![CDATA[
						//				push 1234
						//				return_
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionReturn>
						value=stack.pop();
						if(stack.length>0){
							trace("end，stack有残留值: "+stack);
						}
						return value;
					break;
					case AVM1Ops.stackSwap:
						//<ActionStackSwap op="0x4D" opName="stackSwap" opNameFlasm="swap" opNameASV="swap" opNameSothink="_swap">
						//	<description><![CDATA[
						//			//ActionStackSwap
						//			//ActionStackSwap swaps the top two ScriptAtoms on the stack.
						//			//Field 				Type 					Comment
						//			//ActionStackSwap 		ACTIONRECORDHEADER 		ActionCode = 0x4D
						//			//ActionStackSwap does the following:
						//			//1. Pops Item1 and then Item2 off of the stack.
						//			//2. Pushes Item2 and then Item1 back to the stack.
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<as><![CDATA[
						//				//
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "a","b"
						//				stackSwap
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionStackSwap>
						value2=stack.pop();
						value1=stack.pop();
						stack.push(value2);
						stack.push(value1);
					break;
					case AVM1Ops.storeRegister:
						//<ActionStoreRegister op="0x87" opName="storeRegister" opNameFlasm="setRegister" opNameASV="setRegister" opNameSothink="_storeRegister">
						//	<description><![CDATA[
						//			//ActionStoreRegister
						//			//ActionStoreRegister reads the next object from the stack (without popping it) and stores it in
						//			//one of four registers. If ActionDefineFunction2 is used, up to 256 registers are available.
						//			//Field 				Type 					Comment
						//			//ActionStoreRegister 	ACTIONRECORDHEADER 		ActionCode = 0x87
						//			//RegisterNumber 		UI8
						//			//ActionStoreRegister parses register number from the StoreRegister tag.
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<as><![CDATA[
						//				function foo(){
						//					var a=1234;
						//				}
						//			]]></as>
						//			<pcode><![CDATA[
						//				defineFunction2 foo(RegisterCount=2)(flags=SUPPRESS_SUPER|SUPPRESS_ARGUMENTS|SUPPRESS_THIS)()(end label0)
						//				push 1234
						//				storeRegister 1
						//				pop
						//			label0:
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionStoreRegister>
						registerArr[data[offset++]]=stack[stack.length-1];//不 pop
					break;
					//<!--SWF 6 actions-->
					case AVM1Ops.instanceOf:
						//<ActionInstanceOf op="0x54" opName="instanceOf" opNameFlasm="instanceOf" opNameASV="instanceOf" opNameSothink="_instanceof">
						//	<description><![CDATA[
						//			//ActionInstanceOf
						//			//ActionInstanceOf implements the ActionScript instanceof() operator. This is a Boolean
						//			//operator that indicates whether the left operand (typically an object) is an instance of the class
						//			//represented by a constructor function passed as the right operand.
						//			//Additionally, with SWF 7 or later, ActionInstanceOf also supports with interfaces. If the right
						//			//operand constructor is a reference to an interface object, and the left operand implements this
						//			//interface, ActionInstanceOf accurately reports that the left operand is an instance of the right
						//			//operand.
						//			//Field 				Type 					Comment
						//			//ActionInstanceOf 		ACTIONRECORDHEADER 		ActionCode = 0x54
						//			//ActionInstanceOf does the following:
						//			//1. Pops constr then obj off of the stack.
						//			//2. Determines if obj is an instance of constr.
						//			//3. Pushes the return value (a Boolean value) onto the stack.
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<help><![CDATA[
						//				instanceof 运算符
						//				object instanceof classConstructor
						//				
						//				测试 object 是 classConstructor 的实例还是 classConstructor 的子类。instanceof 运算符不会将原始类型转换为包装对象。例如，下面的代码返回 true：
						//				
						//				new String("Hello") instanceof String;
						//				
						//				而下面的代码则返回 false：
						//				
						//				"Hello" instanceof String;
						//				
						//				可用性：Flash Player 6；ActionScript 1.0
						//				
						//				操作数
						//				object : Object - 一个 ActionScript 对象。
						//				
						//				classConstructor : Function - 对 ActionScript 构造函数（如 String 或 Date）的引用。
						//				
						//				返回
						//				Boolean - 如果 object 是 classConstructor 的实例或子类，则 instanceof 返回 true，否则返回 false。另外，_global instanceof Object 返回 false。
						//			]]></help>
						//			<as><![CDATA[
						//				trace(a instanceof b);
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "a"
						//				getVariable
						//				push "b"
						//				getVariable
						//				instanceOf
						//				trace
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionInstanceOf>
						value2=stack.pop();
						value1=stack.pop();
						stack.push(value1 is value2);
					break;
					case AVM1Ops.enumerate2:
						//<ActionEnumerate2 op="0x55" opName="enumerate2" opNameFlasm="enumerateValue" opNameASV="enumerateValue" opNameSothink="_enumerate2">
						//	<description><![CDATA[
						//			//ActionEnumerate2
						//			//ActionEnumerate2 is similar to ActionEnumerate, but uses a stack argument of object type
						//			//rather than using a string to specify its name.
						//			//Field 				Type 					Comment
						//			//ActionEnumerate2 		ACTIONRECORDHEADER 		ActionCode = 0x55
						//			//ActionEnumerate2 does the following:
						//			//1. Pops obj off of the stack.
						//			//2. Pushes a null value onto the stack to indicate the end of the slot names.
						//			//3. Pushes each slot name (a string) from obj onto the stack.
						//			//NOTE
						//			//The order in which slot names are pushed is undefined.
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<help><![CDATA[
						//				for..in 语句
						//				for (variableIterant in object) {
						//					statement(s);
						//				} 
						//				
						//				迭代对象的属性或数组中的元素，并对每个属性或元素执行 statement。对象的方法不能由 for..in 动作来枚举。
						//				
						//				有些属性不能由 for..in 动作来枚举。例如，不能枚举影片剪辑属性，例如 _x 和 _y。在外部类文件中，和实例成员不同的是，静态成员是不能枚举的。
						//				
						//				for..in 语句迭代所迭代对象的原型链中对象的属性。首先枚举该对象的属性，接着枚举其直接原型的属性，然后枚举该原型的原型的属性，依次类推。for..in 语句不会将相同的属性名枚举两次。如果 child 对象有原型 parent，并且两者都包含属性 prop，则对 child 调用的 for..in 语句将枚举来自 child 的 prop，而忽略 parent 对象中的该属性。
						//				
						//				如果只执行一条语句，用来括起要由 for..in 语句执行的语句块的花括号 ({}) 是不必要的。
						//				
						//				如果在一个类文件（外部 AS 文件）中编写一个 for..in 循环，则实例成员对于该循环不可用，而静态成员则可用。然而，如果在一个 FLA 文件中为类的实例编写一个 for..in 循环，则实例成员在循环中可用，而静态成员不可用。
						//				
						//				可用性：Flash Player 5；ActionScript 1.0
						//				
						//				参数
						//				variableIterant:String - 要作为迭代变量的变量的名称，迭代变量引用对象的每个属性或数组中的每个元素。
						//			]]></help>
						//			<as><![CDATA[
						//				for(var i in obj){}//发布为 player8
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "obj"
						//				getVariable
						//				enumerate2
						//			label1:
						//				storeRegister 0
						//				push null
						//				equals2
						//				if_ label0
						//				push "i",r:0
						//				defineLocal
						//				jump label1
						//			label0:
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionEnumerate2>
						obj=stack.pop();
						stack.push(null);
						for(varName in obj){
							stack.push(varName);
						}
					break;
					case AVM1Ops.strictEquals:
						//<ActionStrictEquals op="0x66" opName="strictEquals" opNameFlasm="strictEquals" opNameASV="strictEquals" opNameSothink="_strictEquals">
						//	<description><![CDATA[
						//			//ActionStrictEquals
						//			//ActionStrictEquals is similar to ActionEquals2, but the two arguments must be of the same
						//			//type in order to be considered equal. Implements the '===' operator from the ActionScript
						//			//language.
						//			//Field 				Type 					Comment
						//			//ActionStrictEquals 	ACTIONRECORDHEADER 		ActionCode = 0x66
						//			//ActionStrictEquals does the following:
						//			//1. Pops arg1 then arg2 off the stack.
						//			//2. Pushes the return value, a Boolean value, to the stack.
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<help><![CDATA[
						//				=== 全等运算符
						//				expression1 === expression2
						//				
						//				测试两个表达式是否相等；除了不转换数据类型外，全等运算符 (===) 与等于运算符 (==) 执行运算的方式相同。如果两个表达式（包括它们的数据类型）相等，则结果为 true。
						//				
						//				确定是否相等取决于参数的数据类型：
						//				
						//				数字和布尔值按值进行比较，如果它们具有相同的值，则视为相等。 
						//				如果字符串表达式具有相同的字符数，而且这些字符都相同，则这些字符串表达式相等。 
						//				表示对象、数组和函数的变量按引用进行比较。如果两个变量引用同一个对象、数组或函数，则它们相等。而两个单独的数组即使具有相同数量的元素，也永远不会被视为相等。 
						//				可用性：Flash Player 6；ActionScript 1.0
						//				
						//				操作数
						//				expression1 : Object - 数字、字符串、布尔值、变量、对象、数组或函数。
						//				
						//				expression2 : Object - 数字、字符串、布尔值、变量、对象、数组或函数。
						//				
						//				返回
						//				Boolean - 比较的布尔结果。
						//			]]></help>
						//			<as><![CDATA[
						//				trace(a===b);
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "a"
						//				getVariable
						//				push "b"
						//				getVariable
						//				strictEquals
						//				trace
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionStrictEquals>
						value2=stack.pop();
						value1=stack.pop();
						stack.push(value1===value2);
					break;
					case AVM1Ops.greater:
						//<ActionGreater op="0x67" opName="greater" opNameFlasm="greaterThan" opNameASV="greaterThan" opNameSothink="_greater">
						//	<description><![CDATA[
						//			//ActionGreater
						//			//ActionGreater is the exact opposite of ActionLess2. Originally there was no ActionGreater,
						//			//because it can be emulated by reversing the order of argument pushing, then performing an
						//			//ActionLess followed by an ActionNot. However, this argument reversal resulted in a reversal
						//			//of the usual order of evaluation of arguments, which in a few cases led to surprises.
						//			//Field 				Type 					Comment
						//			//ActionGreater 		ACTIONRECORDHEADER 		ActionCode = 0x67
						//			//ActionGreater does the following:
						//			//1. Pops arg1 and then arg2 off of the stack.
						//			//2. Compares if arg2 > arg1.
						//			//3. Pushes the return value, a Boolean value, onto the stack.
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<help><![CDATA[
						//				> 大于运算符
						//				expression1 > expression2
						//				
						//				比较两个表达式，确定 expression1 是否大于 expression2；如果是，则此运算符返回 true。如果 expression1 小于或等于 expression2，则此运算符返回 false。使用字母顺序计算字符串表达式；所有的大写字母排在小写字母的前面。 
						//				
						//				可用性：Flash Player 4；ActionScript 1.0
						//				
						//				操作数
						//				expression1 : Object - 一个数字或字符串。
						//				
						//				expression2 : Object - 一个数字或字符串。
						//				
						//				返回
						//				Boolean - 比较的布尔结果。
						//			]]></help>
						//			<as><![CDATA[
						//				trace(a>b);
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "a"
						//				getVariable
						//				push "b"
						//				getVariable
						//				greater
						//				trace
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionGreater>
						value2=stack.pop();
						value1=stack.pop();
						stack.push(value1>value2);
					break;
					//case AVM1Ops.stringGreater:
						//<ActionStringGreater op="0x68" opName="stringGreater" opNameFlasm="stringGreaterThan" opNameASV="stringGreaterThan" opNameSothink="_stringGreater">
						//	<description><![CDATA[
						//			//ActionStringGreater
						//			//ActionStringGreater is the exact opposite of ActionStringLess. This action code was added for
						//			//the same reasons as ActionGreater.
						//			//Field 				Type 					Comment
						//			//ActionStringGreater 	ACTIONRECORDHEADER 		ActionCode = 0x68
						//			//ActionStringGreater does the following:
						//			//1. Pops arg1 and then arg2 off of the stack.
						//			//2. Compares if arg2 > arg1, using byte-by-byte comparison.
						//			//3. Pushes the return value, a Boolean value, onto the stack.
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<help><![CDATA[
						//				gt 大于（字符串）运算符
						//				expression1 gt expression2
						//				
						//				自 Flash Player 5 后不推荐使用。不推荐使用此运算符，而推荐使用 >（大于）运算符。
						//				
						//				将 expression1 的字符串表达式与 expression2 的字符串表达式相比较，如果 expression1 大于 expression2，则返回 true，否则返回 false。 
						//				
						//				可用性：Flash Player 4；ActionScript 1.0
						//				
						//				操作数
						//				expression1 : Object - 数字、字符串或变量。
						//				
						//				expression2 : Object - 数字、字符串或变量。
						//				
						//				返回
						//				Boolean - 比较的布尔结果。
						//			]]></help>
						//			<as><![CDATA[
						//				trace(a gt b);
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "a"
						//				getVariable
						//				push "b"
						//				getVariable
						//				stringGreater
						//				trace
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionStringGreater>
					//break;
					//<!--SWF 7 actions-->
					case AVM1Ops.defineFunction2:
						//<ActionDefineFunction2 op="0x8E" opName="defineFunction2" opNameFlasm="function2" opNameASV="function2" opNameSothink="_defineFunction2">
						//	<description><![CDATA[
						//			//ActionDefineFunction2
						//			//ActionDefineFunction2 is similar to ActionDefineFunction, with additional features that can
						//			//help speed up the execution of function calls by preventing the creation of unused variables in
						//			//the function's activation object and by enabling the replacement of local variables with a
						//			//variable number of registers. With ActionDefineFunction2, a function can allocate its own
						//			//private set of up to 256 registers. Parameters or local variables can be replaced with a register,
						//			//which is loaded with the value instead of the value being stored in the function's activation
						//			//object. (The activation object is an implicit local scope that contains named arguments and
						//			//local variables. For further description of the activation object, see the ECMA-262 standard.)
						//			//ActionDefineFunction2 also includes six flags to instruct Flash Player to preload variables,
						//			//and three flags to suppress variables. By setting PreloadParentFlag, PreloadRootFlag,
						//			//PreloadSuperFlag, PreloadArgumentsFlag, PreloadThisFlag, or
						//			//PreloadGlobalFlag, common variables can be preloaded into registers before the function
						//			//executes (_parent, _root, super, arguments, this, or _global, respectively). With flags
						//			//SuppressSuper, SuppressArguments, and SuppressThis, common variables super,
						//			//arguments, and this are not created. By using suppress flags, Flash Player avoids preevaluating
						//			//variables, thus saving time and improving performance.
						//			//No suppress flags are provided for _parent, _root, or _global because Flash Player always
						//			//evaluates these variables as needed; no time is ever wasted on pre-evaluating these variables.
						//			//Specifying both the preload flag and the suppress flag for any variable is not allowed.
						//			//The body of the function that ActionDefineFunction2 specifies should use ActionPush and
						//			//ActionStoreRegister for local variables that are assigned to registers. ActionGetVariable and
						//			//ActionSetVariable cannot be used for variables assigned to registers.
						//			//Flash Player 6 release 65 and later supports ActionDefineFunction2.
						//			//Field 				Type 						Comment
						//			//ActionDefineFunction2	ACTIONRECORDHEADER 			ActionCode = 0x8E
						//			//FunctionName 			STRING 						Name of function, empty if anonymous
						//			//NumParams 			UI16 						# of parameters
						//			//RegisterCount 		UI8 						Number of registers to allocate, up to 255 registers (from 0 to 254)
						//			//PreloadParentFlag 	UB[1] 						0 = Don't preload _parent into register
						//			//													1 = Preload _parent into register
						//			//PreloadRootFlag 		UB[1] 						0 = Don't preload _root into register
						//			//													1 = Preload _root into register
						//			//SuppressSuperFlag 	UB[1] 						0 = Create super variable
						//			//													1 = Don't create super variable
						//			//PreloadSuperFlag 		UB[1] 						0 = Don't preload super into register
						//			//													1 = Preload super into register
						//			//SuppressArgumentsFlag	UB[1] 						0 = Create arguments variable
						//			//													1 = Don't create arguments variable
						//			//PreloadArgumentsFlag 	UB[1] 						0 = Don't preload arguments into register
						//			//													1 = Preload arguments into register
						//			//SuppressThisFlag 		UB[1] 						0 = Create this variable
						//			//													1 = Don't create this variable
						//			//PreloadThisFlag 		UB[1] 						0 = Don't preload this into register
						//			//													1 = Preload this into register
						//			//Reserved 				UB[7] 						Always 0
						//			//PreloadGlobalFlag 	UB[1] 						0 = Don't preload _global into register
						//			//													1 = Preload _global into register
						//			//Parameters 			REGISTERPARAM[NumParams]	See REGISTERPARAM, following
						//			//codeSize 				UI16 						# of bytes of code that follow
						//			//REGISTERPARAM is defined as follows:
						//			//Field 				Type 					Comment
						//			//Register 				UI8 					For each parameter to the function, a register can be specified. If the register specified is zero, the parameter is created as a variable named ParamName in the activation object, which can be referenced with ActionGetVariable and ActionSetVariable. If the register specified is nonzero, the parameter is copied into the register, and it can be referenced with ActionPush and ActionStoreRegister, and no variable is created in the activation object.
						//			//ParamName 			STRING 					Parameter name
						//			//The function body following an ActionDefineFunction2 consists of further action codes, just
						//			//as for ActionDefineFunction.
						//			//Flash Player selects register numbers by first copying each argument into the register specified
						//			//in the corresponding REGISTERPARAM record. Next, the preloaded variables are copied
						//			//into registers starting at 1, and in the order this, arguments, super, _root, _parent,
						//			//and _global, skipping any that are not to be preloaded. (The SWF file must accurately
						//			//specify which registers will be used by preloaded variables and ensure that no parameter uses a
						//			//register number that falls within this range, or else that parameter is overwritten by a
						//			//preloaded variable.)
						//			//The value of NumParams should equal the number of parameter registers. The value of
						//			//RegisterCount should equal NumParams plus the number of preloaded variables and the
						//			//number of local variable registers desired.
						//			//For example, if NumParams is 2, RegisterCount is 6, PreloadThisFlag is 1, and
						//
						//			//PreloadRootFlag is 1, the REGISTERPARAM records will probably specify registers 3 and 4.
						//			//Register 1 will be this, register 2 will be _root, registers 3 and 4 will be the first and second
						//			//parameters, and registers 5 and 6 will be for local variables.
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<help><![CDATA[
						//				关于函数和方法
						//				方法和函数是一些可以在 SWF 文件中的任意位置重复使用的 ActionScript 代码块。您可以在 FLA 文件或外部 ActionScript 文件中编写自己的函数，然后可以从文档内的任意位置调用该函数。方法只是一些位于 ActionScript 类定义中的函数。您可以定义函数，对传递的值执行一系列语句。函数也可以返回值。在定义了函数后，就可以从任意一个时间轴中调用它，包括加载的 SWF 文件的时间轴。 
						//				
						//				如果您将值作为参数传递给函数，则函数就可以使用提供的值进行计算。每个函数都有其各自的特性，而某些函数需要您传递特定类型或数量的值。如果传递的参数多于函数的需要，该函数将忽略多余的值。如果您没有传递必需的参数，则函数将为空的参数指定 undefined 数据类型。这可能导致在运行时出错。函数也可以返回值（请参见从函数中返回值）。
						//			]]></help>
						//			<as><![CDATA[
						//				function fun(a,b){
						//					trace(arguments);
						//				}
						//			]]></as>
						//			<pcode><![CDATA[
						//				defineFunction2 fun(RegisterCount=2)(flags=SUPPRESS_SUPER|PRELOAD_ARGUMENTS|SUPPRESS_THIS)(r:0="a",r:0="b")(end label0)
						//				push r:1
						//				trace
						//			label0:
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionDefineFunction2>
						offset+=Length;trace("跳过函数头，直接运行函数体");
					break;
					//case AVM1Ops.extends_:
						//<ActionExtends op="0x69" opName="extends_" opNameFlasm="extends" opNameASV="extends" opNameSothink="_extends">
						//	<description><![CDATA[
						//			//ActionExtends
						//			//ActionExtends implements the ActionScript extends keyword. ActionExtends creates an
						//			//inheritance relationship between two classes, called the subclass and the superclass.
						//			//SWF 7 adds ActionExtends to the file format to avoid spurious calls to the superclass
						//			//constructor function (which would occur when inheritance was established under
						//			//ActionScript 1.0). Consider the following code:
						//			//Subclass.prototype = new Superclass();
						//			//Before the existence of ActionExtends, this code would result in a spurious call to the
						//			//Superclass superconstructor function. Now, ActionExtends is generated by the
						//			//ActionScript compiler when the code class A extends B is encountered, to set up the
						//			//inheritance relationship between A and B.
						//			//Field 				Type 					Comment
						//			//ActionExtends 		ACTIONRECORDHEADER 		ActionCode = 0x69
						//			//ActionExtends does the following:
						//			//1. Pops the ScriptObject superclass constructor off the stack.
						//			//2. Pops the ScriptObject subclass constructor off the stack.
						//			//3. Creates a new ScriptObject.
						//			//4. Sets the new ScriptObject's __proto__ property to the superclass' prototype property.
						//			//5. Sets the new ScriptObject's __constructor__ property to the superclass.
						//			//6. Sets the subclass' prototype property to the new ScriptObject.
						//			//These steps are the equivalent to the following ActionScript:
						//			//Subclass.prototype = new Object();
						//			//Subclass.prototype.__proto__ = Superclass.prototype;
						//			//Subclass.prototype.__constructor__ = Superclass;
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<help><![CDATA[
						//				extends 语句
						//				class className extends otherClassName {}
						//				interface interfaceName extends otherInterfaceName {} 
						//				
						//				定义一个类，它是另一个类（超类）的子类。子类继承超类中定义的所有方法、属性、函数等。
						//				
						//				接口也可以使用 extends 关键字扩展。扩展另一个接口的接口包括原接口的所有方法声明。
						//				
						//				可用性：Flash Player 6；ActionScript 2.0
						//				
						//				参数
						//				className:String - 您所定义的类的名称。
						//			]]></help>
						//			<as><![CDATA[
						//				class Mc extends MovieClip
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "_global"
						//				getVariable
						//				push "Mc"
						//				getMember
						//				push "MovieClip"
						//				getVariable
						//				extends_
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionExtends>
					//break;
					case AVM1Ops.castOp:
						//<ActionCastOp op="0x2B" opName="castOp" opNameFlasm="cast" opNameASV="cast" opNameSothink="_cast">
						//	<description><![CDATA[
						//			//ActionCastOp
						//			//ActionCastOp implements the ActionScript cast operator, which allows the casting from one
						//			//data type to another. ActionCastOp pops an object off the stack and attempts to convert the
						//			//object to an instance of the class or to the interface represented by the constructor function.
						//			//Field 				Type 					Comment
						//			//ActionCastOp 			ACTIONRECORDHEADER 		ActionCode = 0x2B
						//			//ActionCastOp does the following:
						//			//1. Pops the ScriptObject to cast off the stack.
						//			//2. Pops the constructor function off the stack.
						//			//3. Determines if object is an instance of constructor (doing the same comparison as
						//			//ActionInstanceOf).
						//			//4. If the object is an instance of constructor, the popped ScriptObject is pushed onto the
						//			//stack.
						//			//If the object is not an instance of constructor, a null value is pushed onto the stack.
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<help><![CDATA[
						//				关于转换对象
						//				转换的语法为 type(item)，表示您希望编译器将 item 视作数据类型为 type 的项目。转换实质上是一个函数调用，如果转换在运行时失败，该函数调用将返回 null（仅在为 Flash Player 7 或更高版本发布的文件中会出现这种情况；为 Flash Player 6 发布的文件不为失败的转换提供运行时支持）。如果转换成功，该函数调用将返回原对象。不过，编译器无法确定转换在运行时是否会失败，也不会在失败时生成编译时错误。
						//			]]></help>
						//			<as><![CDATA[
						//				Mc(this);
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "Mc"
						//				getVariable
						//				push "this"
						//				getVariable
						//				castOp
						//				pop
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionCastOp>
						value1=stack.pop();
						value2=stack.pop();
						stack.push(value1 as value2);
					break;
					//case AVM1Ops.implementsOp:
						//<ActionImplementsOp op="0x2C" opName="implementsOp" opNameFlasm="implements" opNameASV="implements" opNameSothink="_implements">
						//	<description><![CDATA[
						//			//ActionImplementsOp
						//			//ActionImplementsOp implements the ActionScript implements keyword. The
						//			//ActionImplementsOp action specifies the interfaces that a class implements, for use by
						//			//ActionCastOp. ActionImplementsOp can also specify the interfaces that an interface
						//			//implements, as interfaces can extend other interfaces.
						//			//Field 				Type 					Comment
						//			//ActionImplementsOp 	ACTIONRECORDHEADER 		ActionCode = 0x2C
						//			//ActionImplementsOp does the following:
						//			//1. Pops the constructor function off the stack.
						//			//The constructor function represents the class that will implement the interfaces. The
						//			//constructor function must have a prototype property.
						//			//2. Pops the count of implemented interfaces off the stack.
						//			//3. For each interface count, pops a constructor function off of the stack.
						//			//The constructor function represents an interface.
						//			//4. Sets the constructor function's list of interfaces to the array collected in the previous step,
						//			//and sets the count of interfaces to the count popped in step 2.
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<help><![CDATA[
						//				implements 语句
						//				myClass implements interface01 [, interface02 , ...]
						//				
						//				指定类必须定义所实现的接口中声明的所有方法。
						//				
						//				可用性：Flash Player 6；ActionScript 2.0
						//			]]></help>
						//			<as><![CDATA[
						//				class Mc implements I
						//			]]></as>
						//			<pcode><![CDATA[
						//				push "_global"
						//				getVariable
						//				push "I"
						//				getMember
						//				push 1,"_global"
						//				getVariable
						//				push "Mc"
						//				getMember
						//				implementsOp
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionImplementsOp>
					//break;
					//case AVM1Ops.try_:
						//<ActionTry op="0x8F" opName="try_" opNameFlasm="try" opNameASV="try" opNameSothink="_try">
						//	<description><![CDATA[
						//			//ActionTry
						//			//ActionTry defines handlers for exceptional conditions, implementing the ActionScript try,
						//			//catch, and finally keywords.
						//			//Field 				Type 									Comment
						//			//ActionTry 			ACTIONRECORDHEADER 						ActionCode = 0x8F
						//			//Reserved 				UB[5] 									Always zero
						//			//CatchInRegisterFlag 	UB[1] 									0 - Do not put caught object into register (instead, store in named variable)
						//			//																1 - Put caught object into register (do not store in named variable)
						//			//FinallyBlockFlag 		UB[1] 									0 - No finally block
						//			//																1 - Has finally block
						//			//CatchBlockFlag 		UB[1] 									0 - No catch block
						//			//																1 - Has catch block
						//			//TrySize 				UI16 									Length of the try block
						//			//CatchSize 			UI16 									Length of the catch block
						//			//FinallySize 			UI16 									Length of the finally block
						//			//CatchName 			If CatchInRegisterFlag = 0, STRING		Name of the catch variable
						//			//CatchRegister 		If CatchInRegisterFlag = 1, UI8 		Register to catch into
						//			//TryBody 				UI8[TrySize] 							Body of the try block
						//			//CatchBody 			UI8[CatchSize] 							Body of the catch block, if any
						//			//FinallyBody 			UI8[FinallySize] 						Body of the finally block, if any
						//			//NOTE
						//			//The CatchSize and FinallySize fields always exist, whether or not the CatchBlockFlag or
						//			//FinallyBlockFlag settings are 1.
						//			//NOTE
						//			//The try, catch, and finally blocks do not use end tags to mark the end of their respective
						//			//blocks. Instead, the length of a block is set by the TrySize, CatchSize, and FinallySize
						//			//values.
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<help><![CDATA[
						//				try..catch..finally 语句
						//				try {
						//				// ... try block ...
						//				} finally { 
						//				// ... finally block ...
						//				} 
						//				try { 
						//				// ... try block ...
						//				} catch(error [:ErrorType1]) {
						//				// ... catch block ...
						//				} [catch(error[:ErrorTypeN]) {
						//				// ... catch block ...
						//				}] [finally { 
						//				// ... finally block ...
						//				}]
						//				
						//				包含一个代码块，在其中可发生错误，然后对该错误进行响应。如果 try 代码块中的任何代码抛出错误（使用 throw 语句），控制会传递到 catch 块（如果有），然后传递到 finally 代码块（如果有）。无论是否抛出了错误，始终会执行 finally 块。如果 try 代码块中的代码未抛出错误（也就是说，如果 try 代码块正常完成），则仍会执行 finally 代码块中的代码。即使 try 代码块使用 return 语句退出，仍执行 finally 代码块。
						//				
						//				try 代码块后面必须跟有 catch 代码块、finally 代码块，或两者都有。单个 try 代码块可以有多个 catch 代码块，但只能有一个 finally 代码块。您可以根据需要嵌套任意层数的 try 代码块。
						//				
						//				catch 处理函数中指定的 error 参数必须是一个简单的标识符，如 e、theException 或 x。您还可以为 catch 处理函数中的变量指定类型。当与多个 catch 代码块一起使用时，如果指定了错误类型，则可以捕获从一个 try 代码块抛出的多种类型的错误。
						//				
						//				如果抛出的异常是对象，则当抛出的对象是指定类型的子类时，类型将匹配。如果抛出的错误属于特定类型，将执行处理相应错误的 catch 代码块。如果抛出的异常不属于指定类型，则不执行 catch 代码块，而自动将该异常从 try 代码块抛出到与其匹配的 catch 处理函数。 
						//				
						//				如果在某个函数内抛出了错误，而该函数不包含 catch 处理函数，则 ActionScript 解释程序退出该函数以及任何调用函数，直到找到一个 catch 代码块。在此过程中，在各层上都会调用 finally 处理函数。
						//				
						//				可用性：Flash Player 7；ActionScript 1.0
						//				
						//				参数
						//				error:Object - 从 throw 语句抛出的表达式，通常是 Error 类或其子类之一的实例。
						//			]]></help>
						//			<as><![CDATA[
						//				try{
						//					trace("Hello World");
						//				}catch(e:Error){}
						//			]]></as>
						//			<pcode><![CDATA[
						//				try_ r:0(try end label0)(catch end label1)
						//				push "Hello World"
						//				trace
						//				jump label1
						//			label0:
						//				push "Error"
						//				getVariable
						//				push r:0
						//				castOp
						//				pushDuplicate
						//				push null
						//				equals2
						//				if_ label2
						//				push "e"
						//				stackSwap
						//				defineLocal
						//				jump label1
						//			label2:
						//				pop
						//				push r:0
						//				throw_
						//			label1:
						//			]]></pcode>
						//			<as><![CDATA[
						//				try{
						//					trace("Hello World");
						//				}catch(e:Error){
						//					trace("Hello World");
						//				}
						//			]]></as>
						//			<pcode><![CDATA[
						//				try_ r:0(try end label3)(catch end label4)
						//				push "Hello World"
						//				trace
						//				jump label4
						//			label3:
						//				push "Error"
						//				getVariable
						//				push r:0
						//				castOp
						//				pushDuplicate
						//				push null
						//				equals2
						//				if_ label5
						//				push "e"
						//				stackSwap
						//				defineLocal
						//				push "Hello World"
						//				trace
						//				jump label4
						//			label5:
						//				pop
						//				push r:0
						//				throw_
						//			label4:
						//			]]></pcode>
						//			<as><![CDATA[
						//				try{
						//					trace("Hello World");
						//				}finally{
						//					trace("Hello World");
						//				}
						//			]]></as>
						//			<pcode><![CDATA[
						//				try_ (try end label6)(finally end label7)
						//				push "Hello World"
						//				trace
						//			label6:
						//				push "Hello World"
						//				trace
						//			label7:
						//			]]></pcode>
						//			<as><![CDATA[
						//				try{
						//					trace("Hello World");
						//				}catch(e:Error){
						//					trace("Hello World");
						//				}finally{
						//					trace("Hello World");
						//				}
						//			]]></as>
						//			<pcode><![CDATA[
						//				try_ r:0(try end label8)(catch end label9)(finally end label10)
						//				push "Hello World"
						//				trace
						//				jump label9
						//			label8:
						//				push "Error"
						//				getVariable
						//				push r:0
						//				castOp
						//				pushDuplicate
						//				push null
						//				equals2
						//				if_ label11
						//				push "e"
						//				stackSwap
						//				defineLocal
						//				push "Hello World"
						//				trace
						//				jump label9
						//			label11:
						//				pop
						//				push r:0
						//				throw_
						//			label9:
						//				push "Hello World"
						//				trace
						//			label10:
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionTry>
					//break;
					case AVM1Ops.throw_:
						//<ActionThrow op="0x2A" opName="throw_" opNameFlasm="throw" opNameASV="throw" opNameSothink="_throw">
						//	<description><![CDATA[
						//			//ActionThrow
						//			//ActionThrow implements the ActionScript throw keyword. ActionThrow is used to signal, or
						//			//throw, an exceptional condition, which is handled by the exception handlers declared with
						//			//ActionTry.
						//			//If any code within the try block throws an object, control passes to the catch block, if one
						//			//exists, then to the finally block, if one exists. The finally block always executes, regardless
						//			//of whether an error was thrown.
						//			//If an exceptional condition occurs within a function and the function does not include a
						//			//catch handler, the function and any caller functions are exited until a catch block is found
						//			//(executing all finally handlers at all levels).
						//			//Any ActionScript data type can be thrown, though typically usage is to throw objects.
						//			//Field 				Type 					Comment
						//			//ActionThrow 			ACTIONRECORDHEADER 		ActionCode = 0x2A
						//			//ActionThrow pops the value to be thrown off the stack.
						//	]]></description>
						//	<samples>
						//		<sample>
						//			<help><![CDATA[
						//				throw 语句
						//				throw expression
						//				
						//				生成或抛出（使用 throw 语句）一个可由 catch{} 代码块处理或捕获 的错误。如果异常未被 catch 代码块捕获，抛出值的字符串表示形式将被发送到"输出"面板。
						//				
						//				通常，抛出的错误是 Error 类或其子类的实例（请参见"示例"部分）。
						//				
						//				可用性：Flash Player 7；ActionScript 1.0
						//				
						//				参数
						//				expression:Object - 一个 ActionScript 表达式或对象。
						//			]]></help>
						//			<as><![CDATA[
						//				throw 1234;
						//			]]></as>
						//			<pcode><![CDATA[
						//				push 1234
						//				throw_
						//			]]></pcode>
						//		</sample>
						//	</samples>
						//</ActionThrow>
						throw stack.pop();
					break;
					default:
						throw new Error("不支持的 op："+op+"，"+AVM1Ops.opNameV[op]);
					break;
				}
			}
			
			if(stack.length>0){
				trace("end，stack有残留值: "+stack);
			}
		}
		private static function str162bytes(str16:String):ByteArray{
			var bytes:ByteArray=new ByteArray();
			if(str16){
				var i:int=0;
				for each(var str:String in str16.replace(/^\s*|\s*$/g,"").split(/[^0-9a-fA-F]+/)){
					bytes[i++]=int("0x"+str);
				}
			}
			return bytes;
		}
		private static function newClass(clazz:Class,argsArr:Array):*{
			//貌似 Class 不支持像 Function.apply 的东西,参考 Flash CS3 帮助里的例子: ActionScript 3.0 编程 > 处理数组 > 高级主题  
			switch(argsArr.length){
				case 0:
					return new clazz();
				case 1:
					return new clazz(argsArr[0]);
				case 2:
					return new clazz(argsArr[0],argsArr[1]);
				case 3:
					return new clazz(argsArr[0],argsArr[1],argsArr[2]);
				case 4:
					return new clazz(argsArr[0],argsArr[1],argsArr[2],argsArr[3]);
				case 5:
					return new clazz(argsArr[0],argsArr[1],argsArr[2],argsArr[3],argsArr[4]);
				case 6:
					return new clazz(argsArr[0],argsArr[1],argsArr[2],argsArr[3],argsArr[4],argsArr[5]);
				case 7:
					return new clazz(argsArr[0],argsArr[1],argsArr[2],argsArr[3],argsArr[4],argsArr[5],argsArr[6]);
				case 8:
					return new clazz(argsArr[0],argsArr[1],argsArr[2],argsArr[3],argsArr[4],argsArr[5],argsArr[6],argsArr[7]);
				case 9:
					return new clazz(argsArr[0],argsArr[1],argsArr[2],argsArr[3],argsArr[4],argsArr[5],argsArr[6],argsArr[7],argsArr[8]);
				case 10:
					return new clazz(argsArr[0],argsArr[1],argsArr[2],argsArr[3],argsArr[4],argsArr[5],argsArr[6],argsArr[7],argsArr[8],argsArr[9]);
			}
			throw new Error("暂不支持的参数个数: "+argsArr.length);
		}
		private static function getVar(varName:String,vars:Object):*{
			//
			if(vars.hasOwnProperty(varName)){
				return vars[varName];
			}
			
			//
			try{
				return getDefinitionByName(varName);
			}catch(e:Error){
			}
			
			switch(varName){
				case "ByteArray":
					return ByteArray;
				break;
				case "Sprite":
					return Sprite;
				break;
				case "MovieClip":
					return MovieClip;
				break;
			}
			
			if(varName.indexOf("flash.filesystem")==0){
				throw new Error("getVar 失败："+varName+"，可能需要发布成 air");
			}else{
				throw new Error("getVar 失败："+varName);
			}
		}
	}
}