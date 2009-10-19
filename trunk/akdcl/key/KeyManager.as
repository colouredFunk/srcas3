package akdcl.key{
	
	import flash.utils.setInterval
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	
	import akdcl.math.AkdclMath;
	import akdcl.events.KeyEvent;
	public class KeyManager extends EventDispatcher {
		static private var stageList:Array=new Array
		//
		protected var _stage:*		
		protected var _groupNameList:Array=new Array
		protected var _keyList:Array=new Array;
		protected var _keyGroupList:Array=new Array
		
		protected var _keyState:Array=new Array
		protected var _keyCodeList:Array=new Array
		protected var _upEvent:KeyEvent=new KeyEvent(KeyEvent.KEY_UP)
		protected var _donwEvent:KeyEvent=new KeyEvent(KeyEvent.KEY_DOWN)
		protected var _holdEvent:KeyEvent=new KeyEvent(KeyEvent.KEY_HOLD)
		protected var _onUpKeyIndex:Array=new Array			
		protected var _keyIntervalManager:Number
		protected var _precision:uint
		//
		public function KeyManager(stage:*,precision:uint=1,...Keys):void{
			var test:Boolean=true		
			for(var s:uint=0;s<KeyManager.stageList.length;s++){				
				if(KeyManager.stageList[s]==stage){
					test=false
					break
				}
			}
			if(test){
				this._stage=stage
				KeyManager.stageList.push(stage)
				this._keyList=Keys
				this._precision=precision
				for(var i:uint=0;i<this._keyList.length;i++){
					this.addKey(this._keyList[i])
				}			
				this._stage.addEventListener(KeyboardEvent.KEY_DOWN,_onKeyDown)
				this._stage.addEventListener(KeyboardEvent.KEY_UP,_onKeyUp)
				//
				this._keyIntervalManager=setInterval(this._eventTest,this._precision,[0])				
			}else{				
				throw new Error("在"+stage+"中已经存在一个KeyCath实例，在同一对象中KeyCath只允许实例化一次。")
			}
		}		
		public function addKey(key:Key):void{
			var test:Boolean=true
			for(var i:uint=0;i<this._keyList.length;i++){				
				if(key.keyCode==this._keyList[i].keyCode){
					test=false
					break
				}
			}
			if(test){
				key.addEventListener(KeyEvent.KEY_CHANGE,_onKeyChange)
				if(!this._keyGroupList[key.groupID]){
					this._keyGroupList[key.groupID]=new Array
					this._keyState[key.groupID]=new Array
					this._keyCodeList[key.groupID]=new Array
				}
				this._keyList.push(key)	
				this._keyGroupList[key.groupID].push(key)
				this._keyState[key.groupID].push(KeyType.CODE_UP)
				this._keyCodeList[key.groupID][key.keyCode]=this._keyState[key.groupID].length-1				
			} 
		}
		public function getNewGroupName():String{			
			var outS:String="KeyGroup"+(this._groupNameList.length+1)
			this._onUpKeyIndex[this._groupNameList.length]=-1
			this._groupNameList.push(outS)
			
			return outS
		}
		public function getGroupID(groupName:String):uint{
			var outU:uint
			for (var i:uint=0;i<this._groupNameList.length;i++){
				if(groupName==this._groupNameList[i]){
					outU=i
					break
				}
			}
			return outU
		}
		protected function _onKeyChange(_evt:KeyEvent):void{
			trace(_evt.target.keysCode,_evt.target.groupID)			
		}
		private var laskKeyCode:uint;
		protected function _onKeyDown(_evt:KeyboardEvent):void{
			if(laskKeyCode==_evt.keyCode){
				return;
			}
			laskKeyCode=_evt.keyCode;
			for(var i:uint=0;i<this._keyList.length;i++){
				var nowKey:Key=this._keyList[i]
				if(_evt.keyCode==nowKey.keyCode&&!nowKey.disable){	
					this._keyState[nowKey.groupID][this._keyCodeList[nowKey.groupID][_evt.keyCode]]=KeyType.CODE_DOWN
					var nowVoidTime:uint=nowKey.voidTime
					nowKey.isDown(true)	
					this._eventTest(nowVoidTime)				
					break
				}
			}
			
		}
		protected function _onKeyUp(_evt:KeyboardEvent):void{
			laskKeyCode=0;
			for(var i:uint=0;i<this._keyList.length;i++){
				var nowKey:Key=this._keyList[i]	
				if(_evt.keyCode==nowKey.keyCode&&!nowKey.disable){
					this._keyState[nowKey.groupID][this._keyCodeList[nowKey.groupID][_evt.keyCode]]=KeyType.CODE_UP
					var nowHoldTime:uint=nowKey.holdTime
					nowKey.isUp(true)					
					this._onUpKeyIndex[nowKey.groupID]=this._keyCodeList[nowKey.groupID][_evt.keyCode]
					this._eventTest(nowHoldTime)
					break
				}
			}
			
		}		
		protected function _getCodeInt(target:Array):int{
			var outI:int=0
			target.slice().forEach(callback)			
		 	function callback(item:*, index:int, array:Array):void{		 		
				item&&(outI+=Math.pow(2,index))				
			}		
			return outI
		}
		protected function _eventTest(time:uint):void{		
			for(var i:uint=0;i<this._keyList.length;i++){
				var nowKey:Key=this._keyList[i]
				if(nowKey.isUp()){
					if(nowKey.voidTime==1){						
						this._upEvent=new KeyEvent(KeyEvent.KEY_UP,true,false,nowKey);
						var upState:Array=this._keyState[nowKey.groupID].slice();
						upState[this._onUpKeyIndex[nowKey.groupID]]=1;
						this._upEvent.keysCode=this._getCodeInt(upState);
						this._upEvent.voidTime=0;
						this._upEvent.holdTime=this._getHoldTime(nowKey,time,this._upEvent.keysCode);
						dispatchEvent(this._upEvent);
					}
					nowKey.voidTime++
				}
				//
				if(nowKey.isDown()){									
					if(nowKey.holdTime>1){	
						this._holdEvent=new KeyEvent(KeyEvent.KEY_HOLD,true,false,nowKey)
						this._holdEvent.keysCode=this._getCodeInt(this._keyState[nowKey.groupID])
						this._holdEvent.voidTime=0
						this._holdEvent.holdTime=this._getHoldTime(nowKey,0,this._holdEvent.keysCode)															
						dispatchEvent(this._holdEvent)						
					}else{						
						this._donwEvent=new KeyEvent(KeyEvent.KEY_DOWN,true,false,nowKey)
						this._donwEvent.keysCode=this._getCodeInt(this._keyState[nowKey.groupID])
						this._donwEvent.voidTime=this._getVoidTime(nowKey,time,this._donwEvent.keysCode)						
						this._donwEvent.holdTime=1
						dispatchEvent(this._donwEvent)		
					}
					nowKey.holdTime++
				}
				
			}
			//trace("------------------")
		}		
		protected function _getHoldTime(key:Key,keyHoldTime:uint,keyCode:uint):uint{			
			var testA:Array=new Array()
			for(var i:uint=0;i<this._keyState[key.groupID].length;i++){	
				var nowKey:Key=this._keyGroupList[key.groupID][i]
				if(keyCode&Math.pow(2,i)){
					if(nowKey!=key){						
						testA.push(nowKey.holdTime)
					}else{
						if(keyHoldTime){							
							testA.push(keyHoldTime)
						}else{
							testA.push(nowKey.holdTime)
						}
					}				
				}
			}	
			
			var outU:uint=testA.length>1?AkdclMath.getMin(testA)[0]:testA[0]
			return outU
		}
		//		
		protected function _getVoidTime(key:Key,keyVoidTime:uint,keyCode:uint):uint{
			var testA:Array=new Array()
			for(var i:uint=0;i<this._keyState[key.groupID].length;i++){				
				var nowKey:Key=this._keyGroupList[key.groupID][i]
				if(keyCode&Math.pow(2,i)){
					if(nowKey!=key){						
						testA.push(nowKey.voidTime)
					}else{
						testA.push(keyVoidTime)
					}								
				}
			}			
			var outU:uint=testA.length>1?AkdclMath.getMax(testA)[0]:testA[0]			
			return outU
		}				
		//
		public function getKeyList():Array {
			return this._keyList
		}
		public function get length():uint{
			return this._keyList.length
		}		
	}//end KeyManager

}