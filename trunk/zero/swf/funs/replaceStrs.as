/***
replaceStrs 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年11月6日 22:17:10
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf.funs{
	import flash.utils.ByteArray;
	import zero.swf.*;
	import zero.swf.tagBodys.*;
	import zero.swf.avm2.*;
	public function replaceStrs(
		swfData:ByteArray,
		str0Arr:Array,
		strtArr:Array//,
		//symbolClassNameIdArr:Array=null
	):ByteArray{
		trace("未考虑非默认包下的类名的情况");
		//把 DoABC 或 DoABCWithoutFlagsAndName 的 ABCData 里的 stringV 里的特定的字符串替换成特定的字符串
		
		var swf:SWF=new SWF();
		swf.initBySWFData(swfData,null);
		
		var str0:String;
		var i:int;
		
		var mark:Object=new Object();
		i=-1;
		for each(str0 in str0Arr){
			i++;
			mark["~"+str0]=strtArr[i];
		}
		
		var strt:String;
		var ABCData:ABCFileWithSimpleConstant_pool;
		for each(var tag:Tag in swf.tagV){
			switch(tag.type){
				case TagTypes.DoABC:
					ABCData=tag.getBody(DoABC,{ABCDataClass:ABCFileWithSimpleConstant_pool}).ABCData;
					i=ABCData.stringV.length;
					while(--i>0){
						strt=mark["~"+ABCData.stringV[i]];
						if(strt is String){
							//trace("strt=\""+strt+"\",strt.length="+strt.length);
							ABCData.stringV[i]=strt;
						}
					}
				break;
				case TagTypes.DoABCWithoutFlagsAndName:
					ABCData=tag.getBody(DoABCWithoutFlagsAndName,{ABCDataClass:ABCFileWithSimpleConstant_pool}).ABCData;
					i=ABCData.stringV.length;
					while(--i>0){
						strt=mark["~"+ABCData.stringV[i]];
						if(strt is String){
							//trace("strt=\""+strt+"\",strt.length="+strt.length);
							ABCData.stringV[i]=strt;
						}
					}
				break;
				case TagTypes.SymbolClass:
					var NameV:Vector.<String>=tag.getBody(SymbolClass,null).NameV;
					i=NameV.length;
					while(--i>=0){
						strt=mark["~"+NameV[i]];
						if(strt is String){
							NameV[i]=strt;
						}
					}
				break;
			}
		}
		
		return swf.toSWFData(null);
	}
}

