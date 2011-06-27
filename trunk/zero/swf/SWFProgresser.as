/***
SWFProgresser
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月3日 11:31:39
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.swf{
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	import zero.Outputer;
	public class SWFProgresser{
		private var intervalId:int;
		private var swf:SWF;
		private var onProgress:Function;
		private var onComplete:Function;
		private var onRunComplete:Function;
		
		private var step:Function;
		private var stepId:int;
		private var stepCount:int;
		
		//仅用于 initByData
		private var initByDataOptions:zero_swf_InitByDataOptions;
		
		//仅用于 toData
		private var toDataOptions:zero_swf_ToDataOptions;
		private var tagsData:ByteArray;
		
		CONFIG::USE_XML{
		//仅用于 toXML
		private var toXMLOptions:zero_swf_ToXMLOptions;
		private var tagsXML:XML;
		private var frameIdDict:Dictionary;
		
		//仅用于 initByXML
		private var initByXMLOptions:zero_swf_InitByXMLOptions;
		private var nodeXMLList:XMLList;
		}//end of CONFIG::USE_XML
		
		public function clear():void{
			clearInterval(intervalId);
			swf=null;
			onProgress=null;
			onComplete=null;
			onRunComplete=null;
			
			step=null;
			
			initByDataOptions=null;
			
			toDataOptions=null;
			tagsData=null;
			
			CONFIG::USE_XML{
			toXMLOptions=null;
			tagsXML=null;
			frameIdDict=null;
			
			initByXMLOptions=null;
			nodeXMLList=null;
			}//end of CONFIG::USE_XML
		}
		
		private function startRun(
			_step:Function,
			_onProgress:Function,
			_onComplete:Function,
			_stepCount:int
		):void{
			step=_step;
			onProgress=_onProgress;
			onComplete=_onComplete;
			stepCount=_stepCount;
			
			stepId=0;
			
			intervalId=setInterval(runSteps,30);
		}
		private function runSteps():void{
			if(stepId<stepCount){
			}else{
				
				var _onProgress:Function=onProgress;
				var _onComplete:Function=onComplete;
				var _onRunComplete:Function=onRunComplete;
				var _swf:SWF=swf;
				
				if(_onProgress==null){
				}else{
					_onProgress(stepCount,stepCount);
				}
				
				var runResult:*;
				if(_onRunComplete==null){
					runResult=null;
				}else{
					runResult=_onRunComplete();
				}
				
				clear();
				
				if(_onComplete==null){
				}else{
					if(runResult){
						_onComplete(runResult);
					}else{
						_onComplete();
					}
				}
				
				return;
			}
			
			step();
			
			if(onProgress==null){
			}else{
				onProgress(stepId,stepCount);
			}
		}
		
		public function initBySWFData(
			_swf:SWF,
			swfData:ByteArray,
			_initByDataOptions:zero_swf_InitByDataOptions,
			_onProgress:Function,
			_onComplete:Function
		):void{
			clear();
			
			///
			swf=_swf;
			initByDataOptions=swf.initBySWFData_start(swfData,_initByDataOptions);
			
			//@@@@@
			startRun(initBySWFData_step,_onProgress,_onComplete,swf.tagV.length);
			
			//$$$$$
			onRunComplete=null;
		}
		
		//@@@@@
		private function initBySWFData_step():void{
			stepId=Tags.initByData_step(
				swf.tagV,
				stepId,
				stepCount,
				30,
				initByDataOptions
			);
		}
		
		public function toSWFData(_swf:SWF,_toDataOptions:zero_swf_ToDataOptions,_onProgress:Function,_onComplete:Function):void{
			clear();
			
			///
			swf=_swf;
			toDataOptions=swf.toSWFData_start(_toDataOptions);
			
			//临时变量
			tagsData=new ByteArray();
			
			//@@@@@
			startRun(toSWFData_step,_onProgress,_onComplete,swf.tagV.length);
			
			//$$$$$
			onRunComplete=toSWFData_end;
		}
		
		//@@@@@
		private function toSWFData_step():void{
			stepId=Tags.toData_step(
				swf.tagV,
				tagsData,
				stepId,
				stepCount,
				30,
				toDataOptions
			);
		}
		private function toSWFData_end():ByteArray{
			return swf.toSWFData_end(tagsData);
		}
		
		CONFIG::USE_XML{
		public function toXML(_swf:SWF,_toXMLOptions:zero_swf_ToXMLOptions,_onProgress:Function,_onComplete:Function):void{
			clear();
			
			///
			swf=_swf;
			toXMLOptions=swf.toXML_start(_toXMLOptions);
			
			//临时变量
			tagsXML=<tags count={swf.tagV.length}/>;
			frameIdDict=Tags.getFrameIdDict(swf.tagV);
			
			//@@@@@
			startRun(toXML_step,_onProgress,_onComplete,swf.tagV.length);
			
			//$$$$$
			onRunComplete=toXML_end;
		}
		
		//@@@@@
		private function toXML_step():void{
			stepId=Tags.toXML_step(
				swf.tagV,
				tagsXML,
				frameIdDict,
				stepId,
				stepCount,
				30,
				toXMLOptions
			);
		}
		private function toXML_end():XML{
			return swf.toXML_end(tagsXML);
		}
		
		public function initByXML(_swf:SWF,xml:XML,_initByXMLOptions:zero_swf_InitByXMLOptions,_onProgress:Function,_onComplete:Function):void{
			clear();
			
			///
			swf=_swf;
			initByXMLOptions=swf.initByXML_start(xml,_initByXMLOptions);
			
			//临时变量
			nodeXMLList=xml.tags[0].children();
			
			//@@@@@
			startRun(initByXML_step,_onProgress,_onComplete,nodeXMLList.length());
			
			//$$$$$
			onRunComplete=initByXML_end;
		}
		
		//@@@@@
		private function initByXML_step():void{
			stepId=Tags.initByXML_step(
				swf.tagV,
				nodeXMLList,
				stepId,
				stepCount,
				30,
				initByXMLOptions
			);
		}
		private function initByXML_end():void{
			swf.initByXML_end();
		}
		}//end of CONFIG::USE_XML
	}
}
		