/***
ABCClass
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月26日 12:17:51
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
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

//The class_info entry is used to define characteristics of an ActionScript 3.0 class.
//class_info
//{
//	u30 cinit
//	u30 trait_count
//	traits_info traits[trait_count]
//}
package zero.swf.avm2{
	import flash.utils.Dictionary;
	public class ABCClass{
		public var name:ABCMultiname;
		public var super_name:ABCMultiname;
		public var flags:int;
		public var protectedNs:ABCNamespace;
		public var intrfV:Vector.<ABCMultiname>;
		public var iinit:ABCMethod;
		public var itraitV:Vector.<ABCTrait>;
		public var cinit:ABCMethod;
		public var ctraitV:Vector.<ABCTrait>;
		
		public function getClassName():String{
			if(name){
				var className:String;
				
				if(name.ns.kind==NamespaceKinds.PackageNamespace){
					className="";
				}else{
					className="["+NamespaceKinds.kindV[name.ns.kind]+"]";
				}
				
				if(name.ns.name){
					className+=name.ns.name;
				}
				
				if(className){
					className+=".";
				}
				
				className+=name.name;
				
				return className;
			}
			throw new Error("name="+name);
		}
		//
		public function initByInfo(
			instance_info:Instance_info,
			class_info:Class_info,
			integerV:Vector.<int>,
			uintegerV:Vector.<int>,
			doubleV:Vector.<Number>,
			stringV:Vector.<String>,
			allNsV:Vector.<ABCNamespace>,
			allMultinameV:Vector.<ABCMultiname>,
			allMethodV:Vector.<ABCMethod>,
			allMetadataV:Vector.<ABCMetadata>,
			classV:Vector.<ABCClass>,
			_initByDataOptions:Object/*zero_swf_InitByDataOptions*/
		):void{
			var i:int;
			
			//The name field is an index into the multiname array of the constant pool; it provides a name for the
			//class. The entry specified must be a QName.
			if(instance_info.name>0){
				name=allMultinameV[instance_info.name];
				if(name.kind==MultinameKinds.QName){
				}else{
					throw new Error("name.kind="+name.kind);
				}
			}else{
				throw new Error("instance_info.name="+instance_info.name);
			}
			
			//The super_name field is an index into the multiname array of the constant pool; it provides the name of
			//the base class of this class, if any. A value of zero indicates that this class has no base class.			
			super_name=allMultinameV[instance_info.super_name];//allMultinameV[0]==null;
			
			//The flags field is used to identify various options when interpreting the instance_info entry. It is bit
			//vector; the following entries are defined. Other bits must be zero.
			//Name 							Value 	Meaning
			//CONSTANT_ClassSealed 			0x01 	The class is sealed: properties can not be dynamically added to instances of the class.
			//CONSTANT_ClassFinal 			0x02 	The class is final: it cannot be a base class for any other class.
			//CONSTANT_ClassInterface 		0x04 	The class is an interface.
			//CONSTANT_ClassProtectedNs 	0x08 	The class uses its protected namespace and the protectedNs field is present in the interface_info structure.
			flags=instance_info.flags;
			
			//This field is present only if the CONSTANT_ProtectedNs bit of flags is set. It is an index into the
			//namespace array of the constant pool and identifies the namespace that serves as the protected namespace
			//for this class.
			if(flags&InstanceFlags.ClassProtectedNs){
				protectedNs=allNsV[instance_info.protectedNs];//allNs[0]==null;
			}
			
			//The value of the intrf_count field is the number of entries in the interface array. The interface array
			//contains indices into the multiname array of the constant pool; the referenced names specify the interfaces
			//implemented by this class. None of the indices may be zero.
			i=-1;
			intrfV=new Vector.<ABCMultiname>();
			for each(var intrf:int in instance_info.intrfV){
				i++;
				if(intrf>0){
					intrfV[i]=allMultinameV[intrf];
				}else{
					throw new Error("intrf="+intrf);
				}
			}
			
			//This is an index into the method array of the abcFile; it references the method that is invoked whenever
			//an object of this class is constructed. This method is sometimes referred to as an instance initializer.
			iinit=allMethodV[instance_info.iinit];
			
			//The value of trait_count is the number of elements in the trait array. The trait array defines the set
			//of traits of a class instance. The next section defines the meaning of the traits_info structure.
			i=-1;
			itraitV=new Vector.<ABCTrait>();
			for each(var itraits_info:Traits_info in instance_info.itraits_infoV){
				i++;
				itraitV[i]=new ABCTrait();
				itraitV[i].initByInfo(
					itraits_info,
					integerV,
					uintegerV,
					doubleV,
					stringV,
					allNsV,
					allMultinameV,
					allMethodV,
					allMetadataV,
					classV,
					_initByDataOptions
				);
			}
			
			//This is an index into the method array of the abcFile; it references the method that is invoked when the
			//class is first created. This method is also known as the static initializer for the class.
			cinit=allMethodV[class_info.cinit];
			
			//The value of trait_count is the number of entries in the trait array. The trait array holds the traits
			//for the class (see above for information on traits).
			i=-1;
			ctraitV=new Vector.<ABCTrait>();
			for each(var ctraits_info:Traits_info in class_info.ctraits_infoV){
				i++;
				ctraitV[i]=new ABCTrait();
				ctraitV[i].initByInfo(
					ctraits_info,
					integerV,
					uintegerV,
					doubleV,
					stringV,
					allNsV,
					allMultinameV,
					allMethodV,
					allMetadataV,
					classV,
					_initByDataOptions
				);
			}
		}
		public function getInfo_product(productMark:ProductMark):void{
			
			//The name field is an index into the multiname array of the constant pool; it provides a name for the
			//class. The entry specified must be a QName.
			productMark.productMultiname(name);
			
			//The super_name field is an index into the multiname array of the constant pool; it provides the name of
			//the base class of this class, if any. A value of zero indicates that this class has no base class.			
			productMark.productMultiname(super_name);
			
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
			if(flags&InstanceFlags.ClassProtectedNs){
				productMark.productNs(protectedNs);
			}
			
			//The value of the intrf_count field is the number of entries in the interface array. The interface array
			//contains indices into the multiname array of the constant pool; the referenced names specify the interfaces
			//implemented by this class. None of the indices may be zero.
			for each(var intrf:ABCMultiname in intrfV){
				productMark.productMultiname(intrf);
			}
			
			//This is an index into the method array of the abcFile; it references the method that is invoked whenever
			//an object of this class is constructed. This method is sometimes referred to as an instance initializer.
			productMark.productMethod(iinit);
			
			//The value of trait_count is the number of elements in the trait array. The trait array defines the set
			//of traits of a class instance. The next section defines the meaning of the traits_info structure.
			for each(var itrait:ABCTrait in itraitV){
				itrait.getInfo_product(productMark);
			}
			
			//This is an index into the method array of the abcFile; it references the method that is invoked when the
			//class is first created. This method is also known as the static initializer for the class.
			productMark.productMethod(cinit);
			
			//The value of trait_count is the number of entries in the trait array. The trait array holds the traits
			//for the class (see above for information on traits).
			for each(var ctrait:ABCTrait in ctraitV){
				ctrait.getInfo_product(productMark);
			}
		}
		public function getInfo(productMark:ProductMark,_toDataOptions:Object/*zero_swf_ToDataOptions*/):Array{
			var i:int;
			
			var instance_info:Instance_info=new Instance_info();
			
			//The name field is an index into the multiname array of the constant pool; it provides a name for the
			//class. The entry specified must be a QName.
			if(name){
				if(name.kind==MultinameKinds.QName){
					instance_info.name=productMark.getMultinameId(name);
				}else{
					throw new Error("name.kind="+name.kind);
				}
			}else{
				throw new Error("name="+name);
			}
			
			//The super_name field is an index into the multiname array of the constant pool; it provides the name of
			//the base class of this class, if any. A value of zero indicates that this class has no base class.			
			instance_info.super_name=productMark.getMultinameId(super_name);
			
			//The flags field is used to identify various options when interpreting the instance_info entry. It is bit
			//vector; the following entries are defined. Other bits must be zero.
			//Name 							Value 	Meaning
			//CONSTANT_ClassSealed 			0x01 	The class is sealed: properties can not be dynamically added to instances of the class.
			//CONSTANT_ClassFinal 			0x02 	The class is final: it cannot be a base class for any other class.
			//CONSTANT_ClassInterface 		0x04 	The class is an interface.
			//CONSTANT_ClassProtectedNs 	0x08 	The class uses its protected namespace and the protectedNs field is present in the interface_info structure.
			instance_info.flags=flags;
			
			//This field is present only if the CONSTANT_ProtectedNs bit of flags is set. It is an index into the
			//namespace array of the constant pool and identifies the namespace that serves as the protected namespace
			//for this class.
			if(flags&InstanceFlags.ClassProtectedNs){
				instance_info.protectedNs=productMark.getNsId(protectedNs);
			}
			
			//The value of the intrf_count field is the number of entries in the interface array. The interface array
			//contains indices into the multiname array of the constant pool; the referenced names specify the interfaces
			//implemented by this class. None of the indices may be zero.
			i=-1;
			instance_info.intrfV=new Vector.<int>();
			for each(var intrf:ABCMultiname in intrfV){
				i++;
				if(intrf){
					instance_info.intrfV[i]=productMark.getMultinameId(intrf);
				}else{
					throw new Error("intrf="+intrf);
				}
			}
			
			//This is an index into the method array of the abcFile; it references the method that is invoked whenever
			//an object of this class is constructed. This method is sometimes referred to as an instance initializer.
			instance_info.iinit=productMark.getMethodId(iinit);
			
			//The value of trait_count is the number of elements in the trait array. The trait array defines the set
			//of traits of a class instance. The next section defines the meaning of the traits_info structure.
			i=-1;
			instance_info.itraits_infoV=new Vector.<Traits_info>();
			for each(var itrait:ABCTrait in itraitV){
				i++;
				instance_info.itraits_infoV[i]=itrait.getInfo(productMark,_toDataOptions);
			}
			
			var class_info:Class_info=new Class_info();
			
			//This is an index into the method array of the abcFile; it references the method that is invoked when the
			//class is first created. This method is also known as the static initializer for the class.
			class_info.cinit=productMark.getMethodId(cinit);
			
			//The value of trait_count is the number of entries in the trait array. The trait array holds the traits
			//for the class (see above for information on traits).
			i=-1;
			class_info.ctraits_infoV=new Vector.<Traits_info>();
			for each(var ctrait:ABCTrait in ctraitV){
				i++;
				class_info.ctraits_infoV[i]=ctrait.getInfo(productMark,_toDataOptions);
			}
			
			return [instance_info,class_info];
		}
		
		////
		CONFIG::USE_XML{
		public function toXMLAndMark(markStrs:MarkStrs,xmlName:String,_toXMLOptions:Object/*zero_swf_ToXMLOptions*/):XML{
			var xml:XML=<{xmlName}/>;
			
			if(name){
				if(name.kind==MultinameKinds.QName){
					xml.appendChild(name.toXMLAndMark(markStrs,"name",_toXMLOptions));
				}else{
					throw new Error("name.kind="+name.kind);
				}
			}else{
				throw new Error("name="+name);
			}
			
			if(super_name){
				xml.appendChild(super_name.toXMLAndMark(markStrs,"super_name",_toXMLOptions));
			}
			
			xml.@flags=(
				"|"+InstanceFlags.flagV[flags&InstanceFlags.ClassSealed]+
				"|"+InstanceFlags.flagV[flags&InstanceFlags.ClassFinal]+
				"|"+InstanceFlags.flagV[flags&InstanceFlags.ClassInterface]+
				"|"+InstanceFlags.flagV[flags&InstanceFlags.ClassProtectedNs]
			).replace(/\|null/g,"").substr(1);
			
			if(flags&InstanceFlags.ClassProtectedNs){
				if(protectedNs){
					xml.appendChild(protectedNs.toXMLAndMark(markStrs,"protectedNs",_toXMLOptions));
				}
			}
			
			if(intrfV.length){
				var intrfListXML:XML=<intrfList count={intrfV.length}/>
				for each(var intrf:ABCMultiname in intrfV){
					if(intrf){
						intrfListXML.appendChild(intrf.toXMLAndMark(markStrs,"intrf",_toXMLOptions));
					}else{
						throw new Error("intrf="+intrf);
					}
				}
				xml.appendChild(intrfListXML);
			}
			
			xml.appendChild(iinit.toXMLAndMark(markStrs,name.toMarkStrAndMark(markStrs),"iinit",_toXMLOptions));
			
			if(itraitV.length){
				var itraitListXML:XML=<itraitList count={itraitV.length}/>
				for each(var itrait:ABCTrait in itraitV){
					itraitListXML.appendChild(itrait.toXMLAndMark(markStrs,"itrait",_toXMLOptions));
				}
				xml.appendChild(itraitListXML);
			}
			
			xml.appendChild(cinit.toXMLAndMark(markStrs,"","cinit",_toXMLOptions));
			
			if(ctraitV.length){
				var ctraitListXML:XML=<ctraitList count={ctraitV.length}/>
				for each(var ctrait:ABCTrait in ctraitV){
					ctraitListXML.appendChild(ctrait.toXMLAndMark(markStrs,"ctrait",_toXMLOptions));
				}
				xml.appendChild(ctraitListXML);
			}
			
			return xml;
		}
		public function initByXMLAndMark(markStrs:MarkStrs,xml:XML,_initByXMLOptions:Object/*zero_swf_InitByXMLOptions*/):void{
			var i:int;
			
			var nameXML:XML=xml.name[0];
			if(nameXML){
				name=ABCMultiname.xml2multiname(markStrs,nameXML,_initByXMLOptions);
				if(name.kind==MultinameKinds.QName){
				}else{
					throw new Error("name.kind="+name.kind);
				}
			}else{
				throw new Error("nameXML="+nameXML);
			}
			
			var super_nameXML:XML=xml.super_name[0];
			if(super_nameXML){
				super_name=ABCMultiname.xml2multiname(markStrs,super_nameXML,_initByXMLOptions);
			}else{
				super_name=null;
			}
			
			flags=0;
			for each(var flagsStr:String in xml.@flags.toString().split("|")){
				flags|=InstanceFlags[flagsStr];
			}
			
			if(flags&InstanceFlags.ClassProtectedNs){
				var protectedNsXML:XML=xml.protectedNs[0];
				if(protectedNsXML){
					protectedNs=ABCNamespace.xml2ns(markStrs,protectedNsXML,_initByXMLOptions);
				}else{
					protectedNs=null;
				}
			}
			
			i=-1;
			intrfV=new Vector.<ABCMultiname>();
			for each(var intrfXML:XML in xml.intrfList.intrf){
				i++;
				intrfV[i]=ABCMultiname.xml2multiname(markStrs,intrfXML,_initByXMLOptions);
			}
			
			iinit=new ABCMethod();
			iinit.initByXMLAndMark(markStrs,xml.iinit[0],_initByXMLOptions);
			
			i=-1;
			itraitV=new Vector.<ABCTrait>();
			for each(var itraitXML:XML in xml.itraitList.itrait){
				i++;
				itraitV[i]=new ABCTrait();
				itraitV[i].initByXMLAndMark(markStrs,itraitXML,_initByXMLOptions);
			}
			
			cinit=new ABCMethod();
			cinit.initByXMLAndMark(markStrs,xml.cinit[0],_initByXMLOptions);
			
			i=-1;
			ctraitV=new Vector.<ABCTrait>();
			for each(var ctraitXML:XML in xml.ctraitList.ctrait){
				i++;
				ctraitV[i]=new ABCTrait();
				ctraitV[i].initByXMLAndMark(markStrs,ctraitXML,_initByXMLOptions);
			}
		}
		}//end of CONFIG::USE_XML
	}
}