/***
getTime
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年8月17日 15:40:00
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.utils{
	public function getTime():String{
		var date:Date=new Date();
		var month:int=date.getMonth()+1;
		var day:int=date.getDate();
		var hours:int=date.getHours();
		var minutes:int=date.getMinutes();
		var seconds:int=date.getSeconds();
		
		return date.getFullYear()+"年"
			+(month<10?"0":"")+month+"月"
			+(day<10?"0":"")+day+"日 "
			+(hours<10?"0":"")+hours+":"
			+(minutes<10?"0":"")+minutes+":"
			+(seconds<10?"0":"")+seconds;
	}
}