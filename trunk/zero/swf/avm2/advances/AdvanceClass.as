/***
AdvanceClass 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月25日 12:45:49 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
//The instance_info entry is used to define the characteristics of a run-time object (a class instance) within the
//AVM2. The corresponding(对应的) class_info entry is used in order to fully define an ActionScript 3.0 Class.

//instance_info
//{
//	u30 name
//	u30 super_name
//	u8 flags
//	u30 protectedNs
//	u30 intrf_count
//	u30 interface[intrf_count]
//	u30 iinit
//	u30 trait_count
//	traits_info trait[trait_count]
//}

//The name field is an index into the multiname array of the constant pool; it provides a name for the
//class. The entry specified must be a QName.
//The super_name field is an index into the multiname array of the constant pool; it provides the name of
//the base class of this class, if any. A value of zero indicates that this class has no base class.			

//The flags field is used to identify various options when interpreting the instance_info entry. It is bit
//vector; the following entries are defined. Other bits must be zero.
//Name 							Value 	Meaning
//CONSTANT_ClassSealed 			0x01 	The class is sealed: properties can not be dynamically added to instances of the class.
//CONSTANT_ClassFinal 			0x02 	The class is final: it cannot be a base class for any other class.
//CONSTANT_ClassInterface 		0x04 	The class is an interface.
//CONSTANT_ClassProtectedNs 	0x08 	The class uses its protected namespace and the protectedNs field is present in the interface_info structure.

//This field is present only if the CONSTANT_ProtectedNs bit of flags is set. It is an index into the
//namespace array of the constant pool and identifies the namespace that serves as the protected namespace
//for this class.

//The value of the intrf_count field is the number of entries in the interface array. The interface array
//contains indices into the multiname array of the constant pool; the referenced names specify the interfaces
//implemented by this class. None of the indices may be zero.

//This is an index into the method array of the abcFile; it references the method that is invoked whenever
//an object of this class is constructed. This method is sometimes referred to as an instance initializer.

//The value of trait_count is the number of elements in the trait array. The trait array defines the set
//of traits of a class instance. The next section defines the meaning of the traits_info structure.

//The class_info entry is used to define characteristics of an ActionScript 3.0 class.
//class_info
//{
//	u30 cinit
//	u30 trait_count
//	traits_info traits[trait_count]
//}

//This is an index into the method array of the abcFile; it references the method that is invoked when the
//class is first created. This method is also known as the static initializer for the class.

//The value of trait_count is the number of entries in the trait array. The trait array holds the traits
//for the class (see above for information on traits).
package zero.swf.avm2.advances{
	import zero.swf.avm2.Class_info;
	import zero.swf.avm2.Instance_info;
	import zero.swf.avm2.Traits_info;
	import zero.swf.vmarks.InstanceFlags;
	public class AdvanceClass extends Advance{
		
		private static const Instance_info_memberV:Vector.<Member>=Vector.<Member>([
			new Member("name",Member.MULTINAME_INFO),
			new Member("super_name",Member.MULTINAME_INFO),
			new Member("flags",null,{flagClass:InstanceFlags}),
			new Member("protectedNs",Member.NAMESPACE_INFO,{curr:Member.CURR_CASE}),
			new Member("intrf",Member.MULTINAME_INFO,{isList:true}),
			new Member("iinit",Member.METHOD),
			new Member("itraits_info",Member.TRAITS_INFO,{isList:true})
		]);
		
		private static const Class_info_memberV:Vector.<Member>=Vector.<Member>([
			new Member("cinit",Member.METHOD),
			new Member("ctraits_info",Member.TRAITS_INFO,{isList:true})
		]);
		
		private var infoId:int;	//从 swf 或 xml 直接读取过来的 id
		
		public var name:AdvanceMultiname_info;									//multiname_info
		public var super_name:AdvanceMultiname_info;							//multiname_info
		public var flags:int;													//direct
		public var protectedNs:AdvanceNamespace_info;							//namespace_info
		public var intrfV:Vector.<AdvanceMultiname_info>;						//multiname_info
		
		public var iinit:AdvanceMethod;										//method
		public var itraits_infoV:Vector.<AdvanceTraits_info>;					//traits_info
		
		public var cinit:AdvanceMethod;										//method
		public var ctraits_infoV:Vector.<AdvanceTraits_info>;					//traits_info
		
		//
		public function initByInfos(advanceABC:AdvanceABC,_infoId:int,instance_info:Instance_info,class_info:Class_info):void{
			infoId=_infoId;
			
			initByInfo_fun(advanceABC,instance_info,Instance_info_memberV,instance_info.flags&InstanceFlags.ClassProtectedNs);
			
			initByInfo_fun(advanceABC,class_info,Class_info_memberV);
		}
		public function toInfoId(advanceABC:AdvanceABC):int{
			var instance_info:Instance_info=new Instance_info();
			var class_info:Class_info=new Class_info();
			
			toInfo_fun(advanceABC,instance_info,Instance_info_memberV);
			toInfo_fun(advanceABC,class_info,Class_info_memberV);
			
			//--
			advanceABC.abcFile.instance_infoV.push(instance_info);
			advanceABC.abcFile.class_infoV.push(class_info);
			return advanceABC.abcFile.instance_infoV.length-1;
		}
		
		public function getMarkKey(marks:Object):String{
			return name.getMarkKey(marks);
			//return name.toXML(marks,"name").toXMLString();
		}

		////
		CONFIG::toXMLAndInitByXML {
		/*
		public function toXML(marks:Object,xmlName:String):XML{
			var xml:XML=toXML_fun(marks,Instance_info_memberV,xmlName);
			
			toXML_fun(marks,Class_info_memberV,xml);
			
			xml.@infoId=infoId;
			return xml;
		}
		public function initByXML(marks:Object,xml:XML):void{
			infoId=int(xml.@infoId.toString());
			
			initByXML_fun(marks,xml,Instance_info_memberV);
			initByXML_fun(marks,xml,Class_info_memberV);
			
			marks[Member.CLASS][getMarkKey(marks)]=this;
		}
		//*/
		
		///*
		
		public function toXML(marks:Object,xmlName:String):XML{
			var xml:XML=<{xmlName}/>
			
			////
			var description:String="";
			
			description+="class "+getMultiname_infoMarkKey(marks,name);
			if(super_name===AdvanceDefaultMultiname_info.instance){
			}else{
				description+=" extends "+getMultiname_infoMarkKey(marks,super_name);
			}
			if(intrfV.length){
				var intrfsStr:String="";
				for each(var intrf:AdvanceMultiname_info in intrfV){
					intrfsStr+=","+getMultiname_infoMarkKey(marks,intrf);
				}
				description+=" implements "+(intrfsStr.substr(1));
			}
			
			xml.@description=description;
			////
			
			if(protectedNs){
				xml.@protectedNs=getNamespace_infoMarkKey(marks,protectedNs);
			}
			
			//----
			toXML_fun(marks,Instance_info_memberV,xml);
			
			toXML_fun(marks,Class_info_memberV,xml);
			
			xml.@infoId=infoId;
			return xml;
		}
		public function initByXML(marks:Object,xml:XML):void{
			var matchArr:Array,strArr:Array;
			var description:String=xml.@description.toString();
			matchArr=description.match(/class\s+[\w\.\[\]]+\s+extends\s+[\w\.\[\]]+/);
			var classStr:String;
			if(matchArr){
				classStr=matchArr[0];
				strArr=classStr.split(/\s+/);
				//trace("strArr[3]="+strArr[3]);
				super_name=getMultiname_infoByMarkKey(marks,strArr[3]);
			}else{
				matchArr=description.match(/class\s+[\w\.\[\]]+/);
				if(matchArr){
					classStr=matchArr[0];
					strArr=classStr.split(/\s+/);
					super_name=AdvanceDefaultMultiname_info.instance;
				}else{
					throw new Error("错误的 description: "+description);
				}
			}
			name=getMultiname_infoByMarkKey(marks,strArr[1]);
			
			description=description.replace(classStr,"");
			
			matchArr=description.match(/implements\s+[\w\.\[\],]+/);
			intrfV=new Vector.<AdvanceMultiname_info>();
			if(matchArr){
				for each(var intrfStr:String in matchArr[0].replace(/implements\s+/,"").split(",")){//这里假定了 intrfsStr 里只含有 QName 和 Multiname
					intrfV.push(getMultiname_infoByMarkKey(marks,intrfStr));
				}
				//trace("intrfV="+intrfV);
			}
			
			var protectedNsStr:String=xml.@protectedNs.toString();
			if(protectedNsStr){
				protectedNs=getNamespace_infoByMarkKey(marks,protectedNsStr);
			}
			
			//----
			infoId=int(xml.@infoId.toString());
			
			initByXML_fun(marks,xml,Instance_info_memberV);
			initByXML_fun(marks,xml,Class_info_memberV);
			
			//trace("getMarkKey(marks)="+getMarkKey(marks));
			marks[Member.CLASS][getMarkKey(marks)]=this;
		}
		//*/
		
		}//end of CONFIG::toXMLAndInitByXML
	}
}