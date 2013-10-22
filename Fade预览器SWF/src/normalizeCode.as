/***
normalizeCode
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年11月15日 17:47:44
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package{
	public function normalizeCode(code:String):String{
		
		//var xml:XML=<node/>;
		var stack:Array=new Array();
		//var currNode:XML=xml;
		var currStack:Array=new Array();
		
		var i:int=-1;
		var currCodeSeg:String="";
		for each(var c:String in code.split("")){
			i++;
			switch(c){
				case "+":
				case "-":
				case "*":
				case "/":
				case "=":
				case ",":
				case ";":
					
					if(currCodeSeg){
						//currNode.appendChild(<node code={currCodeSeg}/>);
						currStack.push(currCodeSeg);
					}
					currCodeSeg="";
					
					//currNode.appendChild(<node code={c}/>);
					currStack.push(c);
					
				break;
				case "(":
				case "[":
				case "{":
					
					//var nextNode:XML=<node/>;
					//currNode.appendChild(nextNode);
					//currNode=nextNode;
					stack.push(currStack);
					currStack=new Array();
					
					if(currCodeSeg){
						//currNode.appendChild(<node code={currCodeSeg}/>);
						currStack.push(currCodeSeg);
					}
					currCodeSeg="";
					
					//currNode.appendChild(<node code={c}/>);
					currStack.push(c);
					
				break;
				case ")":
				case "]":
				case "}":
					
					if(currCodeSeg){
						//currNode.appendChild(<node code={currCodeSeg}/>);
						currStack.push(currCodeSeg);
					}
					currCodeSeg="";
					
					//currNode.appendChild(<node code={c}/>);
					currStack.push(c);
					
					//trace("currStack="+currStack.join("|"));
					var normalizeCode:String="";
					
					var execResult:Array=/^\s*(\w+)\s*$/.exec(currStack[0]);
					if(execResult){
						switch(execResult[1]){
							case "add":
							case "subtract":
							case "multiply":
							case "divide":
							case "xOr":
								currStack.pop();
								currStack.shift();
								currStack.shift();
								while(currStack.length>3){
									currStack[currStack.length-2]+=currStack[currStack.length-1];
									currStack.pop();
								}
								currStack[0]=currStack[0].replace(/^\s*|\s*$/g,"");
								if(currStack[0].search(/[\+\-\*\/]/)>-1){
									currStack[0]="("+currStack[0]+")";
								}
								currStack[2]=currStack[2].replace(/^\s*|\s*$/g,"");
								if(currStack[2].search(/[\+\-\*\/]/)>-1){
									currStack[2]="("+currStack[2]+")";
								}
								switch(execResult[1]){
									case "add":
										normalizeCode=currStack[0]+"+"+currStack[2];
									break;
									case "subtract":
										normalizeCode=currStack[0]+"-"+currStack[2];
									break;
									case "multiply":
										normalizeCode=currStack[0]+"*"+currStack[2];
									break;
									case "divide":
										normalizeCode=currStack[0]+"/"+currStack[2];
									break;
									case "xOr":
										normalizeCode=currStack[0]+"^^"+currStack[2];
									break;
								}
							break;
							case "floor":
								currStack.pop();
								currStack.shift();
								currStack.shift();
								while(currStack.length>1){
									currStack[currStack.length-2]+=currStack[currStack.length-1];
									currStack.pop();
								}
								currStack[0]=currStack[0].replace(/^\s*|\s*$/g,"");
								normalizeCode="floor("+currStack[0]+")";
							break;
						}
					}
					
					if(normalizeCode){
					}else{
						normalizeCode=currStack.join("");
						//trace("normalizeCode="+normalizeCode);
					}
					
					//currNode=currNode.parent();
					currStack=stack.pop();
					currStack.push(normalizeCode);
					
				break;
				default:
					currCodeSeg+=c;
				break;
			}
		}
		//trace("xml="+xml);
		//trace("currStack="+currStack.join("|"));
		return currStack.join("");
	}
}