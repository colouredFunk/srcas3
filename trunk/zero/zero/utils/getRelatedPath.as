/***
getRelatedPath
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；已婚（单身美女们没机会了~~）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2013年08月02日 10:09:23
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.utils{
	
	/**
	 * 获取 path 相对于 basePath 的路径 
	 */	
	public function getRelatedPath(basePath:String,path:String):String{
		var basePathArr:Array=basePath.split("/");
		var pathArr:Array=path.split("/");
		for(var i:int=0;i<basePathArr.length;i++){
			basePath=basePathArr[i];
			path=pathArr[i];
			if(basePath==path){
			}else{
				break;
			}
		}
		path=pathArr.slice(i).join("/");
		i=basePathArr.length-1-i;
		while(--i>=0){
			path="../"+path;
		}
		return path;
	}
}