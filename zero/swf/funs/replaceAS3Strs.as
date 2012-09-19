/***
replaceAS3Strs 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年11月6日 22:17:10
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf.funs{
	
	import flash.utils.ByteArray;
	
	import zero.swf.*;
	import zero.swf.avm2.*;
	import zero.swf.tagBodys.*;
	
	public function replaceAS3Strs(
		swfData:ByteArray,
		str0Arr:Array,
		strtArr:Array
	):ByteArray{
		
		//把 DoABC 或 DoABCWithoutFlagsAndName 的 ABCData 里的 stringV 里的特定的字符串替换成特定的字符串
		
		var swf:SWFExtend=new SWFExtend();
		swf.initBySWFData(swfData,null);
		
		if(swf.isAS3){
		}else{
			throw new Error("swf 必须是 AS3 的");
		}
		
		var mark:Object=new Object();
		var i:int=-1;
		for each(var str0:String in str0Arr){
			i++;
			mark["~"+str0]=strtArr[i];
		}
		
		for each(var ABCData:ABCFileWithSimpleConstant_pool in getABCFileWithSimpleConstant_pools(swf)){
			i=ABCData.stringV.length;
			while(--i>0){
				/*
				if(
					ABCData.stringV[i]
					&&
					ABCData.stringV[i].indexOf("http://")==-1//ReferenceError: Error #1069: 在 BtnLogin 上找不到属性 http.//adobe.com/AS3/2006/builtin::hasOwnProperty，且没有默认值。
				){
					strArr=ABCData.stringV[i].split(/\:+|\./);
					j=strArr.length;
					while(--j>=0){
						strt=mark["~"+strArr[j]];
						if(strt is String){
							strArr[j]=strt;
						}
					}
					ABCData.stringV[i]=strArr.join(".");
				}
				*/
				if(ABCData.stringV[i]){
					if(mark["~"+ABCData.stringV[i]]){
						ABCData.stringV[i]=mark["~"+ABCData.stringV[i]];
					}
				}
			}
		}
		
		for each(var tag:Tag in swf.tagV){
			if(tag.type==TagTypes.SymbolClass){
				var NameV:Vector.<String>=tag.getBody(SymbolClass,null).NameV;
				i=NameV.length;
				while(--i>=0){
					var strArr:Array=NameV[i].split(/\:+|\./);
					var j:int=strArr.length;
					while(--j>=0){
						var strt:String=mark["~"+strArr[j]];
						if(strt is String){
							strArr[j]=strt;
						}
					}
					NameV[i]=strArr.join(".");
				}
			}
		}
		
		return swf.toSWFData(null);
	}
}