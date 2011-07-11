/***
MultiData 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2011年3月29日 16:02:54
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.net{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	
	public class MultiData{
		public static const STRING:int=0x01;
		public static const DATA:int=0x02;
		
		private var values:Object;
		public function MultiData(_values:Object=null){
			values=_values||new Object();
			
		}
		public function add(name:String,value:*):void{
			values[name]=value;
		}
		public function get data():ByteArray{
			var data:ByteArray=new ByteArray();
			var strData:ByteArray;
			for(var name:String in values){
				var value:*=values[name];
				if(value is ByteArray){
					
					data.writeByte(DATA);
					
					strData=new ByteArray();
					strData.writeUTFBytes(name);
					data.writeInt(strData.length);
					data.writeBytes(strData);
					
					data.writeInt(value.length);
					data.writeBytes(value);
					
				}else{
					
					data.writeByte(STRING);
					
					strData=new ByteArray();
					strData.writeUTFBytes(name);
					data.writeInt(strData.length);
					data.writeBytes(strData);
					
					strData=new ByteArray();
					strData.writeUTFBytes(value);
					data.writeInt(strData.length);
					data.writeBytes(strData);
					
				}
			}
			return data;
		}
	}
}

