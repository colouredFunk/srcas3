class akdcl.tilegame.MazeGenerator{
	public static var returnMap:Array;
	private static var w:Number;
	private static var h:Number;
	private static var map:Array;
	private static var startNode;
	private static var endNode;
	private static var seed:Array;
	private static var seed2:Array;
	private static var total:Number;
	private static var diff:Number;
	public static var onProgress:Function;
	public static var onGetMaze:Function;
	
	private static var dirArr:Array=[[-1,0],[0,-1],[1,0],[0,1]];
	private static var intervalId:Number;
	
	public static function getMaze(_w:Number,_h:Number,_diff:Number,unwalkAbleRect:Array):Void{
		diff=_diff?_diff:0.5;
		//trace("diff="+diff);
		//0<diff<1,越大越难
		//_root.clear();
		//_root.lineStyle(1,0xffffff);
		if(_w%2==0||_h%2==0){
			trace("长宽得是奇数");
			return;
		}
		w=(_w-1)/2;
		h=(_h-1)/2;
		map=getMap(w,h,"");
		startNode={x:0,y:0,childs:[],color:1};
		endNode={x:w-1,y:h-1,childs:[],color:2};
		map[0][0]=startNode;
		map[h-1][w-1]=endNode;
		if(unwalkAbleRect){
			for(var i:Number=0;i<4;i++){
				unwalkAbleRect[i]=(unwalkAbleRect[i]-1)/2;
			}
			var xMin:Number=Math.min(unwalkAbleRect[0],unwalkAbleRect[2]);
			var xMax:Number=Math.max(unwalkAbleRect[0],unwalkAbleRect[2]);
			var yMin:Number=Math.min(unwalkAbleRect[1],unwalkAbleRect[3]);
			var yMax:Number=Math.max(unwalkAbleRect[1],unwalkAbleRect[3]);
			for(var y:Number=yMin;y<=yMax;y++){
				for(var x:Number=xMin;x<=xMax;x++){
					map[y][x]="unwalkAble";
				}
			}
			total=w*h-2-(yMax-yMin+1)*(xMax-xMin+1);
		}else{
			total=w*h-2;
		}
		//trace(Common.arrToStr(map));
		seed=[startNode,endNode];
		//Global.addRun(MazeGenerator,"timeRun");
		//intervalId=setInterval(timeRun,30);
		while(!timeStep());
	}
	public static function timeRun():Void{
		onProgress((w*h-total)/(w*h));
		for(var i:Number=0;i<5;i++){
			if(timeStep()){
				//Global.delRun(MazeGenerator,"timeRun");
				clearInterval(intervalId);
				return;
			}
		}
	}
	private static function timeStep():Boolean{
		if(total<=0){
			var linkNodeArr:Array=new Array();
			for(var y:Number=0;y<h;y++){
				for(var x:Number=0;x<w;x++){
					var node=map[y][x];
					for(var i:Number=0;i<4;i++){
						var nextNode=map[node.y+dirArr[i][1]][node.x+dirArr[i][0]];
						if(node.color+nextNode.color==3){
							linkNodeArr.push(node);
							break;
						}
					}
				}
			}
			node=linkNodeArr[random(linkNodeArr.length)];
			for(var i:Number=0;i<4;i++){
				var nextNode=map[node.y+dirArr[i][1]][node.x+dirArr[i][0]];
				if(node.color+nextNode.color==3){
					node.childs.push(nextNode);
					break;
				}
			}
			
			w=w*2+1;
			h=h*2+1;
			map=getMap(w,h,1);
			setMap(startNode,map);
			setMap(endNode,map);
			onGetMaze(map);
			returnMap=map;
			//trace("returnMap="+returnMap);
			return true;
		}else{
			seed2=new Array();
			var L:Number=seed.length;
			for(var i:Number=0;i<L;i++){
				var node=seed[i];
				var walkAbleArr:Array=new Array();
				for(var j:Number=0;j<4;j++){
					var x:Number=node.x+dirArr[j][0];
					var y:Number=node.y+dirArr[j][1];
					if(map[y][x]==""){
						walkAbleArr.push([x,y]);
					}
				}
				if(walkAbleArr.length==0){
					seed.splice(i,1);
					i--;
					L--;
					continue;
				}
				disorder(walkAbleArr);
				for(var j:Number=0;j<walkAbleArr.length;j++){
					if(Math.random()<diff){
						break;
					}
					var nextNode={x:walkAbleArr[j][0],y:walkAbleArr[j][1],childs:[],color:node.color};
					map[nextNode.y][nextNode.x]=nextNode;
					total--;
					node.childs.push(nextNode);
					//_root.moveTo(node.x*10,node.y*10);
					//_root.lineTo(nextNode.x*10,nextNode.y*10);
					seed2.push(nextNode);
				}
			}
			seed=seed.concat(seed2);
		}
		return false;
	}
	private static function setMap(node,map:Array):Void{
		map[node.y*2+1][node.x*2+1]=0;
		var L:Number=node.childs.length;
		for(var i:Number=0;i<L;i++){
			var nextNode=node.childs[i];
			map[node.y+nextNode.y+1][node.x+nextNode.x+1]=0;
			setMap(nextNode,map);
		}
	}
	private static function getMap(w:Number,h:Number,initValue):Array{
		var map:Array=new Array(h);
		for(var y:Number=0;y<h;y++){
			map[y]=new Array(w);
			for(var x:Number=0;x<w;x++){
				map[y][x]=initValue;
			}
		}
		return map;
	}
	private static function disorder(arr:Array):Void{
		var L:Number=arr.length;
		for(var i:Number=0;i<L;i++){
			var ran:Number=random(L);
			var temp=arr[i];
			arr[i]=arr[ran];
			arr[ran]=temp;
		}
	}
}