/***
HTML 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月14日 18:11:11
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.html{
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	import flash.utils.*;
	
	public class HTML extends Sprite{
		public static function getStyle(xml:XML):StyleSheet{
			var style:StyleSheet=new StyleSheet();
			style.parseCSS(xml.toString().replace(/\s*[\r\n]\s*/g,""));
			return style;
		}
		private static const elementClasses:Object={
			label:Label,
			txt:Txt,
			btn:Btn
		}
		public static const defaultStyle:StyleSheet=getStyle(
			<style><![CDATA[
				body {
					font-family: _sans;
					font-size: 12px;
					color: #ff0000;
					margin-left: 0px;
					margin-top: 0px;
					margin-right: 0px;
					margin-bottom: 0px;
				}
				a {
					color: #2CB200;
					font-weight: bold;
				}
				a:hover {
					color: #ED4901;
				}
			]]></style>
		);
		private static function initByXMLAtts(parentObj:HTML,obj:Object,xml:XML):void{
			for each(var att:XML in xml.attributes()){
				var attName:String=att.name();
				if(attName){
					switch(attName){
						case "id":
							obj.id=att.toString();
							parentObj.elements[obj.id]=obj;
						break;
						case "eventId":
							//已被征用
						break;
						default:
							//if(obj.hasOwnProperty(attName)){
								obj[attName]=att.toString();
							//}
						break;
					}
				}
			}
		}
		
		private var onClick:Function;
		private var onChange:Function;
		public var id:String;
		public var elements:Object;
		
		public function HTML(){
			
		}
		public function init(xml:XML,_onClick:Function=null,_onChange:Function=null,style:StyleSheet=null):void{
			var rootHTML:HTML=this;
			while(rootHTML.parent){
				if(rootHTML.parent is HTML){
					rootHTML=rootHTML.parent as HTML;
				}else{
					break;
				}
			}
			if(rootHTML==this){
				elements=new Object();
			}
			
			var styleNode:XML=xml.style[0];
			if(styleNode){
				style=getStyle(styleNode);
			}else if(style){
			}else{
				style=defaultStyle;
			}
			onClick=_onClick;
			onChange=_onChange;
			for each(var node:XML in xml.children()){
				var nodeName:String=node.name();
				if(nodeName){
					if(nodeName=="html"){
						var html:HTML=new HTML();
						this.addChild(html);
						initByXMLAtts(rootHTML,html,node);
						html.init(node,onClick,onChange,style);
					}else{
						var htmlElement:HTMLElement=new (elementClasses[nodeName])();
						this.addChild(htmlElement);
						initByXMLAtts(rootHTML,htmlElement,node);
						
						if(htmlElement.type==TextFieldType.INPUT){
							//- -
							//如果使用样式, 将无法编辑文本
							htmlElement.addEventListener(Event.CHANGE,change);
						}else{
							htmlElement.styleSheet=style;
						}
						
						switch(nodeName){
							case "label":
							case "txt":
							break;
							case "btn":
								var btn:Btn=htmlElement as Btn;
								btn.eventId=node.@eventId.toString()||node.@id.toString();
								btn.addEventListener(TextEvent.LINK,click);
							break;
						}
					}
				}
			}
			
			this.addEventListener(Event.ADDED_TO_STAGE,added);
		}
		public function added(event:Event):void{
			this.removeEventListener(Event.ADDED_TO_STAGE,added);
			this.addEventListener(Event.REMOVED_FROM_STAGE,removed);
		}
		public function removed(event:Event):void{
			this.removeEventListener(Event.REMOVED_FROM_STAGE,removed);
			var i:int=this.numChildren;
			while(--i>=0){
				var child:DisplayObject=this.getChildAt(i);
				child.removeEventListener(TextEvent.LINK,click);
				child.removeEventListener(Event.CHANGE,change);
			}
			onClick=null;
			onChange=null;
			elements=null;
		}
		private function click(event:TextEvent):void{
			trace("event.text="+event.text);
			if(onClick!=null){
				onClick(event.target);
			}
		}
		private function change(event:Event):void{
			if(onChange!=null){
				onChange(event.target);
			}
		}
		
		///*
		public function set enabled(_enabled:Boolean):void{
			//Grey.setEnabled(this,_enabled);
			this.mouseEnabled=this.mouseChildren=_enabled;
		}
		//*/
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