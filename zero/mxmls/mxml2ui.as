/***
mxml2ui
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年4月13日 17:37:06
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.mxmls{
	import zero.DescribeTypes;
	public function mxml2ui(
		mxml:XML,
		classMark:Object,
		elements:Object,
		valueSetter:Object=null
	):*{
		var elementClassName:String=mxml.name().toString();
		var elementClass:Class=classMark[elementClassName];
		if(elementClass){
			var element:*=new elementClass();
			
			for each(var att:XML in mxml.attributes()){
				var attName:String=att.name().toString();
				switch(attName){
					case "id":
						var id:String=att.toString();
						if(elements[id]){
							throw new Error("重复的 id: "+id);
						}else{
							elements[id]=element;
						}
					break;
					default:
					break;
				}
				
				if(
					valueSetter
					&&
					valueSetter[elementClassName]
					&&
					valueSetter[elementClassName][attName]
				){
					element[attName]=valueSetter[elementClassName][attName](att.toString());
				}else{
					DescribeTypes.setValueByStr(element,attName,att.toString());
				}
			}
			for each(var subMXML:XML in mxml.children()){
				element.addElement(mxml2ui(subMXML,classMark,elements,valueSetter));
			}
			//trace("element="+element);
			return element;
		}
		throw new Error("无法 mxml2ui: name="+mxml.name().toString()+"\nmxml="+mxml.toXMLString());
		return null;
	}
}