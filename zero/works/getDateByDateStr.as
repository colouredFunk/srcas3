/***
getDateByDateStr
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年9月6日 09:42:12
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.works{
	public function getDateByDateStr(dateStr:String):Date{
		var timeArr:Array=dateStr.replace(/^\s*|\s*$/g,"").split(/\D+/g);
		return new Date(int(timeArr[0]),int(timeArr[1])-1,int(timeArr[2]),int(timeArr[3]),int(timeArr[4]),int(timeArr[5]));
	}
}