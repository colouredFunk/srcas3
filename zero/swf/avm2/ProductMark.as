/***
ProductMark
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月23日 09:33:56
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.swf.avm2{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	public class ProductMark{
		
		private var integer_countDict:Dictionary;
		private var uinteger_countDict:Dictionary;
		private var countDict:Dictionary;//记录使用次数
		private var integer_idDict:Dictionary;
		private var uinteger_idDict:Dictionary;
		private var idDict:Dictionary;//记录id
		
		public var integerV:Vector.<int>;
		public var uintegerV:Vector.<uint>;
		public var doubleV:Vector.<Number>;
		public var stringV:Vector.<String>;
		public var nsV:Vector.<ABCNamespace>;
		public var ns_setV:Vector.<ABCNs_set>;
		public var multinameV:Vector.<ABCMultiname>;
		public var methodV:Vector.<ABCMethod>;
		public var metadataV:Vector.<ABCMetadata>;
		
		public function ProductMark(){
			integer_countDict=new Dictionary();
			uinteger_countDict=new Dictionary();
			countDict=new Dictionary();
			integer_idDict=new Dictionary();
			uinteger_idDict=new Dictionary();
			idDict=new Dictionary();
			
			integerV=new Vector.<int>();
			uintegerV=new Vector.<uint>();
			doubleV=new Vector.<Number>();
			stringV=new Vector.<String>();
			nsV=new Vector.<ABCNamespace>();
			ns_setV=new Vector.<ABCNs_set>();
			multinameV=new Vector.<ABCMultiname>();
			methodV=new Vector.<ABCMethod>();
			metadataV=new Vector.<ABCMetadata>();
		}
		public function productInteger(integer:int):void{
			if(integer_countDict[integer]){
				integer_countDict[integer]++;
			}else{
				integer_countDict[integer]=1;
				integerV.push(integer);
			}
		}
		public function productUinteger(uinteger:uint):void{
			if(uinteger_countDict[uinteger]){
				uinteger_countDict[uinteger]++;
			}else{
				uinteger_countDict[uinteger]=1;
				uintegerV.push(uinteger);
			}
			//throw new Error("uinteger="+uinteger+",uinteger_countDict[uinteger]="+uinteger_countDict[uinteger]);
		}
		public function productDouble(double:Number):void{
			if(countDict[double]){
				countDict[double]++;
			}else{
				countDict[double]=1;
				doubleV.push(double);
			}
		}
		public function productString(string:String):void{
			if(string is String){
				if(countDict["~"+string]){
					countDict["~"+string]++;
				}else{
					countDict["~"+string]=1;
					stringV.push(string);
				}
			}
		}
		public function productNs(ns:ABCNamespace):void{
			if(ns){
				if(countDict[ns]){
					countDict[ns]++;
				}else{
					countDict[ns]=1;
					nsV.push(ns);
					ns.getInfo_product(this);
				}
			}
		}
		public function productNs_set(ns_set:ABCNs_set):void{
			if(ns_set){
				if(countDict[ns_set]){
					countDict[ns_set]++;
				}else{
					countDict[ns_set]=1;
					ns_setV.push(ns_set);
					ns_set.getInfo_product(this);
				}
			}
		}
		public function productMultiname(multiname:ABCMultiname):void{
			if(multiname){
				if(countDict[multiname]){
					countDict[multiname]++;
				}else{
					countDict[multiname]=1;
					multinameV.push(multiname);
					multiname.getInfo_product(this);
				}
			}
		}
		public function productMethod(method:ABCMethod):void{
			//if(method){
				if(countDict[method]){
					//countDict[method]++;
				}else{
					countDict[method]=1;
					methodV.push(method);
					method.getInfo_product(this);
				}
			//}
		}
		public function productMetadata(metadata:ABCMetadata):void{
			if(metadata){
				if(countDict[metadata]){
					countDict[metadata]++;
				}else{
					countDict[metadata]=1;
					metadataV.push(metadata);
					metadata.getInfo_product(this);
				}
			}
		}
		public function productClass(clazz:ABCClass,classId:int):void{
			//if(clazz){
				if(countDict[clazz]){
					//countDict[clazz]++;
				}else{
					countDict[clazz]=1;
					//classV.push(clazz);
					idDict[clazz]=classId;
					clazz.getInfo_product(this);
				}
			//}
		}
		
		public function calIds():void{
			
			var id:int;
			
			integerV.sort(sortInteger);
			id=0;
			for each(var integer:int in integerV){
				//trace("integer_countDict[integer]="+integer_countDict[integer]);
				integer_idDict[integer]=++id;
			}
			
			uintegerV.sort(sortUinteger);
			id=0;
			for each(var uinteger:uint in uintegerV){
				//trace("uinteger_countDict[uinteger]="+uinteger_countDict[uinteger]);
				uinteger_idDict[uinteger]=++id;
			}
			
			doubleV.sort(sortDouble);
			id=0;
			for each(var double:Number in doubleV){
				//trace("countDict[double]="+countDict[double]);
				idDict[double]=++id;
			}
			
			stringV.sort(sortString);
			id=0;
			for each(var string:String in stringV){
				//trace("countDict[string]="+countDict["~"+string]);
				idDict["~"+string]=++id;
			}
			
			///
			var dumpSameInfos:Boolean=false;
			
			//var dumpSameInfos:Boolean=true;trace("合并 info 们");
			///
			
			nsV.sort(sortNs);
			var ns:ABCNamespace;
			if(dumpSameInfos){
				//合并 ns 们
				var nssArr:Array=getNssArr();
				nsV=new Vector.<ABCNamespace>();
				id=0;
				for each(var nss:Array in nssArr){
					id++;
					for each(ns in nss){
						idDict[ns]=id;
					}
					nsV.push(ns);
				}
			}else{
				//不合并 ns 们
				id=0;
				for each(ns in nsV){
					//trace("countDict[ns]="+countDict[ns]);
					idDict[ns]=++id;
				}
			}
			
			ns_setV.sort(sortNs_set);
			var ns_set:ABCNs_set;
			if(dumpSameInfos){
				//合并 ns_set 们
				var ns_setsArr:Array=getNs_setsArr();
				ns_setV=new Vector.<ABCNs_set>();
				id=0;
				for each(var ns_sets:Array in ns_setsArr){
					id++;
					for each(ns_set in ns_sets){
						idDict[ns_set]=id;
					}
					ns_setV.push(ns_set);
				}
			}else{
				//不合并 ns_set 们
				id=0;
				for each(ns_set in ns_setV){
					//trace("countDict[ns_set]="+countDict[ns_set]);
					idDict[ns_set]=++id;
				}
			}
			
			multinameV.sort(sortMultiname);
			var multiname:ABCMultiname;
			if(dumpSameInfos){
				//合并 multiname 们
				var multinamesArr:Array=getMultinamesArr();
				multinameV=new Vector.<ABCMultiname>();
				id=0;
				for each(var multinames:Array in multinamesArr){
					id++;
					for each(multiname in multinames){
						idDict[multiname]=id;
					}
					multinameV.push(multiname);
				}
			}else{
				//不合并 multiname 们
				id=0;
				for each(multiname in multinameV){
					//trace("countDict[multiname]="+countDict[multiname]);
					idDict[multiname]=++id;
				}
			}
			
			//methodV.sort(sortMethod);
			id=-1;
			for each(var method:ABCMethod in methodV){
				//trace("countDict[method]="+countDict[method]);
				idDict[method]=++id;
			}
			
			metadataV.sort(sortMetadata);
			id=-1;
			for each(var metadata:ABCMetadata in metadataV){
				//trace("countDict[metadata]="+countDict[metadata]);
				idDict[metadata]=++id;
			}
			
			//trace("----------------------------------");
		}
		
		private function sortInteger(integer1:int,integer2:int):int{
			var dCount:int=integer_countDict[integer1]-integer_countDict[integer2];
			if(dCount>0){
				return -1;
			}
			if(dCount<0){
				return 1;
			}
			
			if(integer1<integer2){
				return -1;
			}
			
			return 1;
		}
		private function sortUinteger(uinteger1:uint,uinteger2:uint):int{
			var dCount:int=uinteger_countDict[uinteger1]-uinteger_countDict[uinteger2];
			if(dCount>0){
				return -1;
			}
			if(dCount<0){
				return 1;
			}
			
			if(uinteger1<uinteger2){
				return -1;
			}
			
			return 1;
		}
		private function sortDouble(double1:Number,double2:Number):int{
			var dCount:int=countDict[double1]-countDict[double2];
			if(dCount>0){
				return -1;
			}
			if(dCount<0){
				return 1;
			}
			
			if(double1<double2){
				return -1;
			}
			
			return 1;
		}
		private function sortString(string1:String,string2:String):int{
			var dCount:int=countDict["~"+string1]-countDict["~"+string2];
			if(dCount>0){
				return -1;
			}
			if(dCount<0){
				return 1;
			}
			
			var lower_string1:String=string1.toLowerCase();
			var lower_string2:String=string2.toLowerCase();
			if(lower_string1<lower_string2){
				return -1;
			}
			if(lower_string1>lower_string2){
				return 1;
			}
			
			if(string1<string2){
				return -1;
			}
			
			return 1;
		}
		private function sortNs(ns1:ABCNamespace,ns2:ABCNamespace):int{
			var dCount:int=countDict[ns1]-countDict[ns2];
			if(dCount>0){
				return -1;
			}
			if(dCount<0){
				return 1;
			}
			
			var dKind:int=ns1.kind-ns2.kind;
			if(dKind<0){
				return -1;
			}
			if(dKind>0){
				return 1;
			}
			
			if(
				ns1.name is String
				&&
				ns2.name is String
			){
				return sortString(ns1.name,ns2.name);
			}
			
			if(ns1.name is String){
				return -1;
			}
			
			if(ns2.name is String){
				return 1;
			}
			
			return 0;
		}
		private function sortNs_set(ns_set1:ABCNs_set,ns_set2:ABCNs_set):int{
			var dCount:int=countDict[ns_set1]-countDict[ns_set2];
			if(dCount>0){
				return -1;
			}
			if(dCount<0){
				return 1;
			}
			
			var dLen:int=ns_set1.nsV.length-ns_set2.nsV.length;
			if(dLen<0){
				return -1;
			}
			if(dLen>0){
				return 1;
			}
			
			var i:int=-1;
			for each(var ns:ABCNamespace in ns_set1.nsV){
				i++;
				if(ns==ns_set2.nsV[i]){
				}else{
					return sortNs(ns,ns_set2.nsV[i]);
				}
			}
			
			return 1;
		}
		
		private function sortMultiname(multiname1:ABCMultiname,multiname2:ABCMultiname):int{
			var dCount:int=countDict[multiname1]-countDict[multiname2];
			if(dCount>0){
				return -1;
			}
			if(dCount<0){
				return 1;
			}
			
			var dKind:int=multiname1.kind-multiname2.kind;
			if(dKind<0){
				return -1;
			}
			if(dKind>0){
				return 1;
			}
			
			switch(multiname1.kind){
				case MultinameKinds.QName:
				case MultinameKinds.QNameA:
					
					if(multiname1.ns==multiname2.ns){
					}else{
						if(
							multiname1.ns
							&&
							multiname2.ns
						){
							return sortNs(multiname1.ns,multiname2.ns);
						}
						if(multiname1.ns){
							return -1;
						}
						if(multiname2.ns){
							return 1;
						}
					}
					
					if(
						multiname1.name is String
						&&
						multiname2.name is String
					){
						return sortString(multiname1.name,multiname2.name);
					}
					
					if(multiname1.name is String){
						return -1;
					}
					
					if(multiname2.name is String){
						return 1;
					}
					
					return 0;
					
				break;
				case MultinameKinds.Multiname:
				case MultinameKinds.MultinameA:
					
					if(multiname1.ns_set==multiname2.ns_set){
					}else{
						return sortNs_set(multiname1.ns_set,multiname2.ns_set);
					}
					
					if(
						multiname1.name is String
						&&
						multiname2.name is String
					){
						return sortString(multiname1.name,multiname2.name);
					}
					
					if(multiname1.name is String){
						return -1;
					}
					
					if(multiname2.name is String){
						return 1;
					}
					
					return 0;
					
				break;
				case MultinameKinds.RTQName:
				case MultinameKinds.RTQNameA:
					
					if(
						multiname1.name is String
						&&
						multiname2.name is String
					){
						return sortString(multiname1.name,multiname2.name);
					}
					
					if(multiname1.name is String){
						return -1;
					}
					
					if(multiname2.name is String){
						return 1;
					}
					
					return 0;
					
				break;
				case MultinameKinds.RTQNameL:
				case MultinameKinds.RTQNameLA:
					
					return 0;
					
				break;
				case MultinameKinds.MultinameL:
				case MultinameKinds.MultinameLA:
					
					if(multiname1.ns_set==multiname2.ns_set){
						return 0;
					}
					
					return sortNs_set(multiname1.ns_set,multiname2.ns_set);
				
				break;
				case MultinameKinds.GenericName:
					if(
						multiname1.TypeDefinition==multiname1
						&&
						multiname2.TypeDefinition==multiname2
					){
						return 0;
					}
					if(multiname1.TypeDefinition==multiname1){
						return -1;
					}
					if(multiname2.TypeDefinition==multiname2){
						return 1;
					}
					if(multiname1.TypeDefinition==multiname2.TypeDefinition){
					}else{
						return sortMultiname(multiname1.TypeDefinition,multiname2.TypeDefinition);
					}
					
					var dLen:int=multiname1.ParamV.length-multiname2.ParamV.length;
					if(dLen<0){
						return -1;
					}
					if(dLen>0){
						return 1;
					}
					
					var i:int=-1;
					for each(var Param:ABCMultiname in multiname1.ParamV){
						i++;
						if(
							Param==multiname1
							&&
							multiname2.ParamV[i]==multiname2
						){
							return 0;
						}
						if(Param==multiname1){
							return -1;
						}
						if(multiname2.ParamV[i]==multiname2){
							return 1;
						}
							
						if(Param==multiname2.ParamV[i]){
						}else{
							if(Param&&multiname2.ParamV[i]){
								return sortMultiname(Param,multiname2.ParamV[i]);
							}
							if(multiname2.ParamV[i]){
								return -1;
							}
							if(Param){
								return 1;
							}
						}
					}
					
					return 0;
					
				break;
			}
			
			return 0;
		}
		private function sortMetadata(metadata1:ABCMetadata,metadata2:ABCMetadata):int{
			var dCount:int=countDict[metadata1]-countDict[metadata2];
			if(dCount>0){
				return -1;
			}
			if(dCount<0){
				return 1;
			}
			
			var dLen:int=metadata1.itemV.length-metadata2.itemV.length;
			if(dLen<0){
				return -1;
			}
			if(dLen>0){
				return 1;
			}
			
			var i:int=-1;
			for each(var item:ABCItem in metadata1.itemV){
				i++;
				
				var item2:ABCItem=metadata2.itemV[i];
				
				if(
					item.key is String
					&&
					item2.key is String
				){
					if(item.key==item2.key){
					}else{
						return sortString(item.key,item2.key);
					}
					
					if(
						item.value is String
						&&
						item2.value is String
					){
						if(item.value==item2.value){
						}else{
							return sortString(item.value,item2.value);
						}
					}
					
					if(item.value is String){
						return -1;
					}
					
					if(item2.value is String){
						return 1;
					}
				}
				
				if(item.key is String){
					return -1;
				}
				
				if(item2.key is String){
					return 1;
				}
			}
			
			return 0;
		}
		
		
		public function getIntegerId(integer:int):int{
			return integer_idDict[integer];
		}
		public function getUintegerId(uinteger:uint):int{
			//throw new Error("uinteger="+uinteger+",uinteger_idDict[uinteger]="+uinteger_idDict[uinteger]);
			return uinteger_idDict[uinteger];
		}
		public function getDoubleId(double:Number):int{
			return idDict[double];
		}
		public function getStringId(string:String):int{
			if(string is String){
				return idDict["~"+string];
			}
			return 0;
		}
		public function getNsId(ns:ABCNamespace):int{
			if(ns){
				return idDict[ns];
			}
			return 0;
		}
		public function getNs_setId(ns_set:ABCNs_set):int{
			if(ns_set){
				return idDict[ns_set];
			}
			return 0;
		}
		public function getMultinameId(multiname:ABCMultiname):int{
			if(multiname){
				return idDict[multiname];
			}
			return 0;
		}
		public function getMethodId(method:ABCMethod):int{
			//if(method){
				return idDict[method];
			//}
			//return 0;
		}
		public function getMetadataId(metadata:ABCMetadata):int{
			//if(metadata){
				return idDict[metadata];
			//}
			//return 0;
		}
		public function getClassId(clazz:ABCClass):int{
			//if(clazz){
				return idDict[clazz];
			//}
			//return 0;
		}
		
		//20110721
		private function isSameNs(ns1:ABCNamespace,ns2:ABCNamespace):Boolean{
			if(ns1==ns2){
				return true;
			}
			/*
			if(
				ns1.kind==ns2.kind
				&&
				ns1.name==ns2.name
			){
				return true;
			}
			*/
			if(
				(
					ns1.kind==NamespaceKinds.PackageNamespace
					||
					ns1.kind==NamespaceKinds.Namespace
				)
				&&
				ns1.kind==ns2.kind
				&&
				ns1.name==ns2.name
			){
				return true;
			}
			return false;
		}
		private function isSameNs_set(ns_set1:ABCNs_set,ns_set2:ABCNs_set):Boolean{
			if(ns_set1==ns_set2){
				return true;
			}
			if(ns_set1.nsV.length==ns_set2.nsV.length){
				var i:int=-1;
				for each(var ns:ABCNamespace in ns_set1.nsV){
					i++;
					if(isSameNs(ns,ns_set2.nsV[i])){
					}else{
						return false;
					}
				}
				return true;
			}
			return false;
		}
		private function isSameMultiname(multiname1:ABCMultiname,multiname2:ABCMultiname):Boolean{
			if(multiname1==multiname2){
				return true;
			}
			if(multiname1.kind==multiname2.kind){
				switch(multiname1.kind){
					case MultinameKinds.QName:
					case MultinameKinds.QNameA:
						if(multiname1.ns&&multiname2.ns){
							if(
								isSameNs(multiname1.ns,multiname2.ns)
								&&
								multiname1.name==multiname2.name
							){
								return true;
							}
							return false;
						}
						if(multiname1.ns||multiname2.ns){
							return false;
						}
						return true;
					break;
					case MultinameKinds.Multiname:
					case MultinameKinds.MultinameA:
						if(
							multiname1.name==multiname2.name
							&&
							isSameNs_set(multiname1.ns_set,multiname2.ns_set)
						){
							return true;
						}
					break;
					case MultinameKinds.RTQName:
					case MultinameKinds.RTQNameA:
						if(
							multiname1.name==multiname2.name
						){
							return true;
						}
					break;
					case MultinameKinds.RTQNameL:
					case MultinameKinds.RTQNameLA:
						return true;
					break;
					case MultinameKinds.MultinameL:
					case MultinameKinds.MultinameLA:
						if(
							isSameNs_set(multiname1.ns_set,multiname2.ns_set)
						){
							return true;
						}
					break;
					case MultinameKinds.GenericName:
						if(multiname1.TypeDefinition==multiname1){
							return false;
						}
						if(multiname2.TypeDefinition==multiname2){
							return false;
						}
						if(isSameMultiname(multiname1.TypeDefinition,multiname2.TypeDefinition)){
							if(multiname1.ParamV.length==multiname2.ParamV.length){
								var i:int=-1;
								for each(var multiname:ABCMultiname in multiname1.ParamV){
									i++;
									if(isSameMultiname(multiname,multiname2.ParamV[i])){
									}else{
										return false;
									}
								}
								return true;
							}
						}
					break;
				}
			}
			return false;
		}
		private function getNssArr():Array{
			//合并可合并的 ns
			var arr:Array=new Array();
			var dict:Dictionary=new Dictionary();
			//trace("nsV="+nsV);
			for each(var ns1:ABCNamespace in nsV){
				if(dict[ns1]){
					continue;
				}
				dict[ns1]=true;
				var subArr:Array=[ns1];
				for each(var ns2:ABCNamespace in nsV){
					if(dict[ns2]){
						continue;
					}
					if(isSameNs(ns1,ns2)){
						dict[ns2]=true;
						subArr.push(ns2);
					}
				}
				//if(subArr.length>1){
				//	trace("合并："+subArr);
				//}
				arr.push(subArr);
			}
			//trace("arr="+arr);
			return arr;
		}
		private function getNs_setsArr():Array{
			//合并可合并的 ns_set
			var arr:Array=new Array();
			var dict:Dictionary=new Dictionary();
			//trace("ns_setV="+ns_setV);
			for each(var ns_set1:ABCNs_set in ns_setV){
				if(dict[ns_set1]){
					continue;
				}
				dict[ns_set1]=true;
				var subArr:Array=[ns_set1];
				for each(var ns_set2:ABCNs_set in ns_setV){
					if(dict[ns_set2]){
						continue;
					}
					if(isSameNs_set(ns_set1,ns_set2)){
						dict[ns_set2]=true;
						subArr.push(ns_set2);
					}
				}
				//if(subArr.length>1){
				//	trace("合并："+subArr);
				//}
				arr.push(subArr);
			}
			//trace("arr="+arr);
			return arr;
		}
		private function getMultinamesArr():Array{
			//合并可合并的 multiname
			var arr:Array=new Array();
			var dict:Dictionary=new Dictionary();
			//trace("multinameV="+multinameV);
			for each(var multiname1:ABCMultiname in multinameV){
				if(dict[multiname1]){
					continue;
				}
				dict[multiname1]=true;
				var subArr:Array=[multiname1];
				for each(var multiname2:ABCMultiname in multinameV){
					if(dict[multiname2]){
						continue;
					}
					if(isSameMultiname(multiname1,multiname2)){
						dict[multiname2]=true;
						subArr.push(multiname2);
					}
				}
				//if(subArr.length>1){
				//	trace("合并："+subArr);
				//}
				arr.push(subArr);
			}
			//trace("arr="+arr);
			return arr;
		}
	}
}
		