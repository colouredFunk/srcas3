/***
Tag 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年5月10日 00:29:22
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf{
	import flash.utils.ByteArray;
	
	import zero.Outputer;
	
	public class Tag{
		public var headOffset:int;
		public var bodyOffset:int;
		public var bodyLength:int;
		public var type:int;
		
		//public var test_isShort:Boolean;//测试
		
		public function Tag(_type:int=-1){
			type=_type;
		}
		
		public function initByData(data:ByteArray,offset:int):void{
			headOffset=offset;
			var temp:int=data[offset++];
			type=(temp>>>6)|(data[offset++]<<2);
			bodyLength=temp&0x3f;
			if(bodyLength==0x3f){//长tag
				bodyLength=data[offset++]|(data[offset++]<<8)|(data[offset++]<<16)|(data[offset++]<<24);
				//test_isShort=false;
			}//else{
				//test_isShort=true;
			//}
			bodyOffset=offset;
			
			__bodyData=data;
		}
		
		private var __bodyData:ByteArray;
		public function getBodyData():ByteArray{
			if(__bodyData){
				return __bodyData;
			}
			throw new Error("__bodyData="+__bodyData);
			return null;
		}
		public function setBodyData(_bodyData:ByteArray):void{
			if(_bodyData){
				//body=null;
				setBody(null);
				if(type<0){
					throw new Error("未设置 type");
				}
				__bodyData=_bodyData;
				headOffset=0;
				bodyOffset=0;
				bodyLength=__bodyData.length;
			}else{
				__bodyData=null;
				headOffset=-1;
				bodyOffset=-1;
				bodyLength=-1;
			}
		}
		
		private var __body:Object;
		public function getBody():Object{
			if(__body){
			}else{
				if(__bodyData){
					var TagBodyClass:Class=TagAndBodyClasses.getTagBodyClassByType(type);
					if(TagBodyClass){
						__body=new TagBodyClass();
						var endOffset:int=bodyOffset+bodyLength;
						var offset:int=__body.initByData(__bodyData,bodyOffset,endOffset);
						if(offset===endOffset){
						}else{
							Outputer.outputError("type="+type+", typeName="+TagType.typeNameArr[type]+", offset="+offset+", endOffset="+endOffset);
						}
					}else{
						throw new Error("type="+type+", typeName="+TagType.typeNameArr[type]+", TagBodyClass 未定义");
					}
				}
			}
			//trace("__body="+__body);
			return __body;
		}
		public function setBody(_body:Object):void{
			if(_body){
				//data=null;
				setBodyData(null);
				__body=_body;
				type=TagAndBodyClasses.getTypeByTagBodyOrBodyClass(_body);
			}else{
				__body=null;
			}
		}
		
		public function getDefId():int{
			if(__body){
				return __body["id"];
			}
			if(__bodyData){
				if(bodyLength<2){
					throw new Error("bodyLength="+bodyLength);
				}
				return __bodyData[bodyOffset]|(__bodyData[bodyOffset+1]<<8);
			}
			throw new Error("未处理");
			return -1;
		}
		public function setDefId(defId:int):void{
			if(__body){
				__body["id"]=defId;
			}else if(__bodyData){
				if(bodyLength<2){
					throw new Error("bodyLength="+bodyLength);
				}
				__bodyData[bodyOffset]=defId;
				__bodyData[bodyOffset+1]=defId>>8;
			}else{
				throw new Error("未处理");
			}
		}
		
		public function getData():ByteArray{
			var bodyData:ByteArray;
			if(__body){
				bodyData=__body.toData();
			}else{
				bodyData=new ByteArray();
				if(bodyLength>0){
					bodyData.writeBytes(__bodyData,bodyOffset,bodyLength);
				}
			}
			var data:ByteArray=new ByteArray();
			//toDataResult.writeBytes(Tag.getHeaderData(type,bodyData.length,test_isShort));
			data.writeBytes(TagAndHeader.getHeaderData(type,bodyData.length));
			data.writeBytes(bodyData);
			return data;
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