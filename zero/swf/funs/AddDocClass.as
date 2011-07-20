/***
AddDocClass
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年7月18日 03:49:27
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.swf.funs{
	import flash.utils.*;
	
	import zero.*;
	import zero.swf.*;
	import zero.swf.avm2.*;
	import zero.swf.tagBodys.*;
	
	public class AddDocClass{
		public static function add(swfData:ByteArray,newDocClassName:String):ByteArray{
			var swf:SWF=new SWF();
			swf.initBySWFData(swfData,null);
			var docClassName:String=getDocClassName(swf);
			if(docClassName){
				replace(swf,docClassName,newDocClassName);
			}else{
				insert(swf,newDocClassName);
			}
			return swf.toSWFData(null);
		}
		private static function replace(swf:SWF,docClassName:String,newDocClassName:String):void{
			var ABCData:ABCFileWithSimpleConstant_pool;
			var i:int;
			var dotId:int;
			
			var docClassName_nsName:String,docClassName_name:String,newDocClassName_nsName:String,newDocClassName_name:String;
			dotId=docClassName.lastIndexOf(".");
			if(dotId>-1){
				docClassName_nsName=docClassName.substr(0,dotId);
				docClassName_name=docClassName.substr(dotId+1);
			}else{
				docClassName_nsName=null;
				docClassName_name=docClassName;
			}
			dotId=newDocClassName.lastIndexOf(".");
			if(dotId>-1){
				newDocClassName_nsName=newDocClassName.substr(0,dotId);
				newDocClassName_name=newDocClassName.substr(dotId+1);
			}else{
				newDocClassName_nsName="";
				newDocClassName_name=newDocClassName;
			}
			var string:String;
			for each(var tag:Tag in swf.tagV){
				switch(tag.type){
					case TagTypes.DoABC:
						ABCData=tag.getBody(DoABC,{ABCDataClass:ABCFileWithSimpleConstant_pool}).ABCData;
						i=ABCData.stringV.length;
						while(--i>=0){
							string=ABCData.stringV[i];
							if(string){
								if(string==docClassName_nsName){
									ABCData.stringV[i]=newDocClassName_nsName;
									trace("newDocClassName_nsName="+newDocClassName_nsName);
								}else if(string==docClassName_name){
									ABCData.stringV[i]=newDocClassName_name;
									trace("newDocClassName_name="+newDocClassName_name);
								}
							}
						}
					break;
					case TagTypes.DoABCWithoutFlagsAndName:
						ABCData=tag.getBody(DoABCWithoutFlagsAndName,{ABCDataClass:ABCFileWithSimpleConstant_pool}).ABCData;
						i=ABCData.stringV.length;
						while(--i>=0){
							string=ABCData.stringV[i];
							if(string){
								if(string==docClassName_nsName){
									ABCData.stringV[i]=newDocClassName_nsName;
									trace("newDocClassName_nsName="+newDocClassName_nsName);
								}else if(string==docClassName_name){
									ABCData.stringV[i]=newDocClassName_name;
									trace("newDocClassName_name="+newDocClassName_name);
								}
							}
						}
					break;
					case TagTypes.SymbolClass:
						var NameV:Vector.<String>=tag.getBody(SymbolClass,null).NameV;
						i=NameV.length;
						while(--i>=0){
							var Name:String=NameV[i].replace(/\:\:/g,".");
							if(Name==docClassName){
								NameV[i]=newDocClassName;
							}
						}
					break;
				}
			}
		}
		private static function insert(swf:SWF,newDocClassName:String):void{
			var insertPos:int=-1;
			for each(var tag:Tag in swf.tagV){
				switch(tag.type){
					case TagTypes.DoABC:
					case TagTypes.DoABCWithoutFlagsAndName:
					case TagTypes.SymbolClass:
					case TagTypes.ShowFrame:
						insertPos=swf.tagV.indexOf(tag);
						swf.tagV.splice(insertPos,0,SimpleDoABC.getDoABCTag(newDocClassName,"mc"));
						return;
					break;
				}
			}
			throw new Error("找不到插入点");
		}
	}
}
		