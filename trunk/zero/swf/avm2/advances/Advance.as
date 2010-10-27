/***
Advance 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月23日 19:10:31
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf.avm2.advances{
	import zero.swf.avm2.AVM2Obj;
	
	public class Advance{
		public static var test_total_new:int;
		public function Advance(){
			trace(this+", test_total_new="+(++test_total_new));
		}
		
		public function getInfoVByAVM2Objs(avm2Obj:AVM2Obj,infoVName:String,infoClass:Class,infoVClass:*,infoInfoVName:String=null):void{
			var avm2ObjV:*=avm2Obj[infoVName];
			var infoV:*=this[infoInfoVName||infoVName]=new infoVClass(avm2ObjV.length);
			var i:int=-1;
			for each(avm2Obj in avm2ObjV){
				i++;
				infoV[i]=new infoClass();
				infoV[i].initByInfo(avm2Obj);
			}
		}
		
		public function getAVM2ObjsByInfoV(avm2Obj:AVM2Obj,infoVName:String,avm2ObjClass:Class,avm2ObjVClass:*,infoInfoVName:String=null):void{
			var infoV:*=this[infoInfoVName||infoVName];
			var avm2ObjV:*=avm2Obj[infoVName]=new avm2ObjVClass(infoV.length);
			var i:int=-1;
			for each(var info:* in infoV){
				i++;
				avm2ObjV[i]=info.toInfo();
			}
		}
		
		////
		CONFIG::toXMLAndInitByXML {
		public function getInfoListXMLByInfoV(name:String,isAdvance:Boolean):XML{
			var infoV:*=this[name+"V"];
			var infoListXML:XML=new XML("<"+name+"List count=\""+infoV.length+"\"/>");
			for each(var info:* in infoV){
				var infoXML:XML=new XML("<"+name+"/>");
				if(isAdvance){
					infoXML.appendChild(info.toXML());
				}else{
					infoXML.@value=info;
				}
				infoListXML.appendChild(infoXML);
			}
			return infoListXML;
		}
		
		public function getInfoVByInfoListXML(name:String,xml:XML,infoClass:Class,infoVClass:*):void{
			var infoXMLList:XMLList=xml[name+"List"][0][name];
			var i:int=-1;
			var infoV:*=this[name+"V"]=new infoVClass(infoXMLList.length());
			for each(var infoXML:XML in infoXMLList){
				i++;
				infoV[i]=new infoClass();
				infoV[i].initByXML(infoXML.children()[0]);
			}
		}
		}//end of CONFIG::toXMLAndInitByXML
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