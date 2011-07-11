/***
AVM2Tests
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月20日 21:32:58
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
	
	public class AVM2Tests extends BaseTests{
		public function AVM2Tests(){
			testABCNamespaces();
			testABCNs_sets();
			testABCMultinames();
			testABCMethods();
		}
		private function testABCNamespaces():void{
			check(ABCNamespace.normalizeMarkStr(""),"");
			check(ABCNamespace.normalizeMarkStr("(1)"),"");
			check(ABCNamespace.normalizeMarkStr("(2)"),"(2)");
			check(ABCNamespace.normalizeMarkStr("[PackageNamespace]"),"");
			check(ABCNamespace.normalizeMarkStr("[PackageNamespace](1)"),"");
			check(ABCNamespace.normalizeMarkStr("[PackageNamespace](2)"),"(2)");
			
			check(ABCNamespace.normalizeMarkStr("flash.display"),"flash.display");
			check(ABCNamespace.normalizeMarkStr("flash.display(1)"),"flash.display");
			check(ABCNamespace.normalizeMarkStr("flash.display(2)"),"flash.display(2)");
			check(ABCNamespace.normalizeMarkStr("[PackageNamespace]flash.display"),"flash.display");
			check(ABCNamespace.normalizeMarkStr("[PackageNamespace]flash.display(1)"),"flash.display");
			check(ABCNamespace.normalizeMarkStr("[PackageNamespace]flash.display(2)"),"flash.display(2)");
			
			check(ABCNamespace.normalizeMarkStr("[PrivateNs]flash.display"),"[PrivateNs]flash.display");
			check(ABCNamespace.normalizeMarkStr("[PrivateNs]flash.display(1)"),"[PrivateNs]flash.display");
			check(ABCNamespace.normalizeMarkStr("[PrivateNs]flash.display(2)"),"[PrivateNs]flash.display(2)");
			
			check(ABCNamespace.normalizeMarkStr("[PrivateNs](name=undefined)"),"[PrivateNs](name=undefined)");
			check(ABCNamespace.normalizeMarkStr("[PrivateNs](name=undefined)(1)"),"[PrivateNs](name=undefined)");
			check(ABCNamespace.normalizeMarkStr("[PrivateNs](name=undefined)(2)"),"[PrivateNs](name=undefined)(2)");
			
			check(ABCNamespace.normalizeMarkStr("null"),"null");
			check(ABCNamespace.normalizeMarkStr("undefined"),"undefined");
			check(ABCNamespace.normalizeMarkStr("\\,"),"\\,");
			check(ABCNamespace.normalizeMarkStr("[PrivateNs]\\]\\[\\)\\("),"[PrivateNs]\\]\\[\\)\\(");
			
			var ns:ABCNamespace;
			var _toXMLOptions:Object/*zero_swf_ToXMLOptions*/;
			var xml:XML;
			var markStrs:MarkStrs;
			var markStr:String;
			
			markStr="\\\\";
			ns=ABCNamespace.markStr2ns(new MarkStrs(),markStr);
			_toXMLOptions=new zero_swf_ToXMLOptions();
			_toXMLOptions.AVM2UseMarkStr=true;
			xml=ns.toXMLAndMark(new MarkStrs(),"ns",_toXMLOptions);
			check(xml.toXMLString(),<ns markStr="\\\\"/>.toXMLString());
			xml=ns.toXMLAndMark(new MarkStrs(),"ns",null);
			check(xml.toXMLString(),<ns class="zero.swf.avm2.ABCNamespace" kind="PackageNamespace" name="\\"/>.toXMLString());
			
			markStr="\\]";
			ns=ABCNamespace.markStr2ns(new MarkStrs(),markStr);
			_toXMLOptions=new zero_swf_ToXMLOptions();
			_toXMLOptions.AVM2UseMarkStr=true;
			xml=ns.toXMLAndMark(new MarkStrs(),"ns",_toXMLOptions);
			check(xml.toXMLString(),<ns markStr="\\]"/>.toXMLString());
			xml=ns.toXMLAndMark(new MarkStrs(),"ns",null);
			check(xml.toXMLString(),<ns class="zero.swf.avm2.ABCNamespace" kind="PackageNamespace" name="]"/>.toXMLString());
			
			markStr="\\\\\\]";
			ns=ABCNamespace.markStr2ns(new MarkStrs(),markStr);
			_toXMLOptions=new zero_swf_ToXMLOptions();
			_toXMLOptions.AVM2UseMarkStr=true;
			xml=ns.toXMLAndMark(new MarkStrs(),"ns",_toXMLOptions);
			check(xml.toXMLString(),<ns markStr="\\\\\\]"/>.toXMLString());
			xml=ns.toXMLAndMark(new MarkStrs(),"ns",null);
			check(xml.toXMLString(),<ns class="zero.swf.avm2.ABCNamespace" kind="PackageNamespace" name="\\]"/>.toXMLString());
			
			ns=new ABCNamespace();
			ns.kind=NamespaceKinds.PrivateNs;
			ns.name="[\n](1)";
			_toXMLOptions=new zero_swf_ToXMLOptions();
			_toXMLOptions.AVM2UseMarkStr=true;
			xml=ns.toXMLAndMark(new MarkStrs(),"ns",_toXMLOptions);
			check(xml.toXMLString(),<ns markStr="[PrivateNs]\\[\\n\\]\\(1\\)"/>.toXMLString());
			xml=ns.toXMLAndMark(new MarkStrs(),"ns",null);
			check(xml.toXMLString(),<ns class="zero.swf.avm2.ABCNamespace" kind="PrivateNs" name="[&#xA;](1)"/>.toXMLString());
			check(ns.toMarkStrAndMark(new MarkStrs()),"[PrivateNs]\\[\\n\\]\\(1\\)");
			
			_toXMLOptions=new zero_swf_ToXMLOptions();
			_toXMLOptions.AVM2UseMarkStr=true;
			markStrs=new MarkStrs();
			ns=ABCNamespace.markStr2ns(markStrs,"");
			xml=ns.toXMLAndMark(markStrs,"ns",_toXMLOptions);
			check(xml.toXMLString(),<ns markStr=""/>.toXMLString());
			check(ABCNamespace.xml2markStr(xml),"");
			markStrs=new MarkStrs();
			ns=ABCNamespace.markStr2ns(markStrs,"");
			xml=ns.toXMLAndMark(markStrs,"ns",null);
			check(xml.toXMLString(),<ns class="zero.swf.avm2.ABCNamespace" kind="PackageNamespace" name=""/>.toXMLString());
			check(ABCNamespace.xml2markStr(xml),"");
			
			_toXMLOptions=new zero_swf_ToXMLOptions();
			_toXMLOptions.AVM2UseMarkStr=true;
			markStrs=new MarkStrs();
			ns=ABCNamespace.markStr2ns(markStrs,"(name=undefined)(2)");
			xml=ns.toXMLAndMark(markStrs,"ns",_toXMLOptions);
			check(xml.toXMLString(),<ns markStr="(name=undefined)(2)"/>.toXMLString());
			check(ABCNamespace.xml2markStr(xml),"(name=undefined)(2)");
			markStrs=new MarkStrs();
			ns=ABCNamespace.markStr2ns(markStrs,"(name=undefined)(2)");
			xml=ns.toXMLAndMark(markStrs,"ns",null);
			check(xml.toXMLString(),<ns class="zero.swf.avm2.ABCNamespace" kind="PackageNamespace" copyId="2"/>.toXMLString());
			check(ABCNamespace.xml2markStr(xml),"(name=undefined)(2)");
			
			_toXMLOptions=new zero_swf_ToXMLOptions();
			_toXMLOptions.AVM2UseMarkStr=true;
			markStrs=new MarkStrs();
			ns=ABCNamespace.markStr2ns(markStrs,"(name=undefined)");
			xml=ns.toXMLAndMark(markStrs,"ns",_toXMLOptions);
			check(xml.toXMLString(),<ns markStr="(name=undefined)"/>.toXMLString());
			check(ABCNamespace.xml2markStr(xml),"(name=undefined)");
			markStrs=new MarkStrs();
			ns=ABCNamespace.markStr2ns(markStrs,"(name=undefined)");
			xml=ns.toXMLAndMark(markStrs,"ns",null);
			check(xml.toXMLString(),<ns class="zero.swf.avm2.ABCNamespace" kind="PackageNamespace"/>.toXMLString());
			check(ABCNamespace.xml2markStr(xml),"(name=undefined)");
			
			_toXMLOptions=new zero_swf_ToXMLOptions();
			_toXMLOptions.AVM2UseMarkStr=true;
			markStrs=new MarkStrs();
			ns=ABCNamespace.markStr2ns(markStrs,"(name=undefined)");
			xml=ns.toXMLAndMark(markStrs,"ns",_toXMLOptions);
			check(xml.toXMLString(),<ns markStr="(name=undefined)"/>.toXMLString());
			check(ABCNamespace.xml2markStr(xml),"(name=undefined)");
			markStrs=new MarkStrs();
			ns=ABCNamespace.markStr2ns(markStrs,"(name=undefined)");
			xml=ns.toXMLAndMark(markStrs,"ns",null);
			check(xml.toXMLString(),<ns class="zero.swf.avm2.ABCNamespace" kind="PackageNamespace"/>.toXMLString());
			check(ABCNamespace.xml2markStr(xml),"(name=undefined)");
			
			_toXMLOptions=new zero_swf_ToXMLOptions();
			_toXMLOptions.AVM2UseMarkStr=true;
			markStrs=new MarkStrs();
			ns=ABCNamespace.markStr2ns(markStrs,"[PrivateNs]flash.display(2)");
			xml=ns.toXMLAndMark(markStrs,"ns",_toXMLOptions);
			check(xml.toXMLString(),<ns markStr="[PrivateNs]flash.display(2)"/>.toXMLString());
			check(ABCNamespace.xml2markStr(xml),"[PrivateNs]flash.display(2)");
			markStrs=new MarkStrs();
			ns=ABCNamespace.markStr2ns(markStrs,"[PrivateNs]flash.display(2)");
			xml=ns.toXMLAndMark(markStrs,"ns",null);
			check(xml.toXMLString(),<ns class="zero.swf.avm2.ABCNamespace" kind="PrivateNs" name="flash.display" copyId="2"/>.toXMLString());
			check(ABCNamespace.xml2markStr(xml),"[PrivateNs]flash.display(2)");
		}
		
		private function testABCNs_sets():void{
			check(ABCNs_set.normalizeMarkStr("[]"),"[]");
			check(ABCNs_set.normalizeMarkStr("[](length=0)"),"[](length=0)");
			check(ABCNs_set.normalizeMarkStr("[](1)"),"[]");
			check(ABCNs_set.normalizeMarkStr("[](2)"),"[](2)");
			check(ABCNs_set.normalizeMarkStr("[PackageNamespace]"),"[PackageNamespace]");
			check(ABCNs_set.normalizeMarkStr("[PackageNamespace](1)"),"[PackageNamespace]");
			check(ABCNs_set.normalizeMarkStr("[PackageNamespace](2)"),"[PackageNamespace](2)");
			check(ABCNs_set.normalizeMarkStr("[flash.display,flash.events](2)"),"[flash.display,flash.events](2)");
			check(ABCNs_set.normalizeMarkStr("[[PackageNamespace]flash.display,[PrivateNs]flash.events]"),"[flash.display,[PrivateNs]flash.events]");
			
			var ns_set:ABCNs_set,ns:ABCNamespace;
			var _toXMLOptions:Object/*zero_swf_ToXMLOptions*/;
			var xml:XML;
			var markStrs:MarkStrs;
			var markStr:String;
			
			///
			check(ABCNs_set.normalizeMarkStr("[PrivateNs]"),"[PrivateNs]");
			check(ABCNs_set.normalizeMarkStr("[[PrivateNs]]"),"[[PrivateNs]]");
			check(ABCNs_set.normalizeMarkStr("[null,[PackageNamespace]undefined,,flash.display,[PrivateNs]null,[PrivateNs]undefined,[PrivateNs],[PrivateNs]flash.display]"),"[null,undefined,,flash.display,[PrivateNs]null,[PrivateNs]undefined,[PrivateNs],[PrivateNs]flash.display]");
			check(ABCNs_set.normalizeMarkStr("[]"),"[]");
			
			
			markStrs=new MarkStrs();
			ns_set=new ABCNs_set();
			ns_set.nsV=new Vector.<ABCNamespace>();
			ns=new ABCNamespace();
			ns.kind=NamespaceKinds.PrivateNs;
			ns_set.nsV.push(ns);
			ns_set.nsV.push(ns);
			ns_set.nsV.push(ns);
			xml=ns_set.toXMLAndMark(markStrs,"ns_set",null);
			check(
				xml.toXMLString(),
				<ns_set class="zero.swf.avm2.ABCNs_set">
				  <nsList count="3">
				    <ns class="zero.swf.avm2.ABCNamespace" kind="PrivateNs"/>
				    <ns class="zero.swf.avm2.ABCNamespace" kind="PrivateNs"/>
				    <ns class="zero.swf.avm2.ABCNamespace" kind="PrivateNs"/>
				  </nsList>
				</ns_set>.toXMLString()
			);
			
			xml=<ns_set class="zero.swf.avm2.ABCNs_set">
				<nsList count="3">
				  <ns markStr=""/>
				  <ns markStr="*"/>
				  <ns markStr="undefined"/>
				  <ns markStr="null"/>
				  <ns markStr="flash.display"/>
				  <ns class="zero.swf.avm2.ABCNamespace" kind="PrivateNs" name="哈哈"/>
				</nsList>
			  </ns_set>
			ns_set=ABCNs_set.xml2ns_set(markStrs,xml,null);
			xml=ns_set.toXMLAndMark(markStrs,"ns_set",null);
			check(
				xml.toXMLString(),
				<ns_set class="zero.swf.avm2.ABCNs_set">
				  <nsList count="6">
					<ns class="zero.swf.avm2.ABCNamespace" kind="PackageNamespace" name=""/>
					<ns class="zero.swf.avm2.ABCNamespace" kind="PackageNamespace" name="*"/>
					<ns class="zero.swf.avm2.ABCNamespace" kind="PackageNamespace" name="undefined"/>
					<ns class="zero.swf.avm2.ABCNamespace" kind="PackageNamespace" name="null"/>
					<ns class="zero.swf.avm2.ABCNamespace" kind="PackageNamespace" name="flash.display"/>
					<ns class="zero.swf.avm2.ABCNamespace" kind="PrivateNs" name="哈哈"/>
				  </nsList>
				</ns_set>.toXMLString()
			);
			
			////
			markStrs=new MarkStrs();
			ns_set=new ABCNs_set();
			ns_set.nsV=new Vector.<ABCNamespace>();
			
			ns=new ABCNamespace();
			ns.kind=NamespaceKinds.PackageNamespace;
			ns.name=",";
			ns_set.nsV[0]=ns;
			ns_set.nsV[1]=ABCNamespace.markStr2ns(markStrs,"\\,");
			markStr=ns_set.toMarkStrAndMark(markStrs);
			check(markStr,"[\\,(2),\\,]");
			_toXMLOptions=new zero_swf_ToXMLOptions();
			_toXMLOptions.AVM2UseMarkStr=true;
			markStrs=new MarkStrs();
			xml=ns_set.toXMLAndMark(markStrs,"ns_set",_toXMLOptions);
			check(xml.toXMLString(),<ns_set markStr="[\\,,\\,(2)]"/>.toXMLString());
			markStrs=new MarkStrs();
			xml=ns_set.toXMLAndMark(markStrs,"ns_set",null);
			check(
				xml.toXMLString(),
				<ns_set class="zero.swf.avm2.ABCNs_set">
				  <nsList count="2">
				    <ns class="zero.swf.avm2.ABCNamespace" kind="PackageNamespace" name=","/>
				    <ns class="zero.swf.avm2.ABCNamespace" kind="PackageNamespace" name="," copyId="2"/>
				  </nsList>
				</ns_set>.toXMLString()
			);
		}
		private function testABCMultinames():void{
			check(ABCMultiname.normalizeMarkStr(""),"");
			check(ABCMultiname.normalizeMarkStr("(1)"),"");
			check(ABCMultiname.normalizeMarkStr("(2)"),"(2)");
			check(ABCMultiname.normalizeMarkStr("null"),"null");
			check(ABCMultiname.normalizeMarkStr("undefined"),"undefined");
			check(ABCMultiname.normalizeMarkStr("\\,"),"\\,");
			check(ABCMultiname.normalizeMarkStr("\[PrivateNs\]\\]\\[\\)\\("),"\[PrivateNs\]\\]\\[\\)\\(");
			
			var markStrs:MarkStrs;
			var multiname:ABCMultiname;
			var _toXMLOptions:Object/*zero_swf_ToXMLOptions*/;
			var xml:XML;
			
			_toXMLOptions=new zero_swf_ToXMLOptions();
			_toXMLOptions.AVM2UseMarkStr=true;
			markStrs=new MarkStrs();
			multiname=ABCMultiname.markStr2multiname(markStrs,"flash.display.MovieClip");
			xml=multiname.toXMLAndMark(markStrs,"multiname",_toXMLOptions);
			check(xml.toXMLString(),<multiname markStr="flash.display.MovieClip"/>.toXMLString());
			check(ABCMultiname.xml2markStr(xml),"flash.display.MovieClip");
			markStrs=new MarkStrs();
			multiname=ABCMultiname.markStr2multiname(markStrs,"flash.display.MovieClip");
			xml=multiname.toXMLAndMark(markStrs,"multiname",null);
			check(
				xml.toXMLString(),
				<multiname class="zero.swf.avm2.ABCMultiname" kind="QName" name="MovieClip">
  					<ns class="zero.swf.avm2.ABCNamespace" kind="PackageNamespace" name="flash.display"/>
				</multiname>.toXMLString()
			);
			check(ABCMultiname.xml2markStr(xml),"flash.display.MovieClip");
			
			_toXMLOptions=new zero_swf_ToXMLOptions();
			_toXMLOptions.AVM2UseMarkStr=true;
			markStrs=new MarkStrs();
			multiname=ABCMultiname.markStr2multiname(markStrs,"(name=undefined)");
			xml=multiname.toXMLAndMark(markStrs,"multiname",_toXMLOptions);
			check(xml.toXMLString(),<multiname markStr="(name=undefined)"/>.toXMLString());
			check(ABCMultiname.xml2markStr(xml),"(name=undefined)");
			markStrs=new MarkStrs();
			multiname=ABCMultiname.markStr2multiname(markStrs,"(name=undefined)");
			xml=multiname.toXMLAndMark(markStrs,"multiname",null);
			check(
				xml.toXMLString(),
				<multiname class="zero.swf.avm2.ABCMultiname" kind="QName">
				  <ns class="zero.swf.avm2.ABCNamespace" kind="PackageNamespace" name=""/>
				</multiname>.toXMLString()
			);
			check(ABCMultiname.xml2markStr(xml),"(name=undefined)");
			
			_toXMLOptions=new zero_swf_ToXMLOptions();
			_toXMLOptions.AVM2UseMarkStr=true;
			markStrs=new MarkStrs();
			multiname=ABCMultiname.markStr2multiname(markStrs,"(ns=undefined)");
			xml=multiname.toXMLAndMark(markStrs,"multiname",_toXMLOptions);
			check(xml.toXMLString(),<multiname markStr="(ns=undefined)"/>.toXMLString());
			check(ABCMultiname.xml2markStr(xml),"(ns=undefined)");
			markStrs=new MarkStrs();
			multiname=ABCMultiname.markStr2multiname(markStrs,"(ns=undefined)");
			xml=multiname.toXMLAndMark(markStrs,"multiname",null);
			check(
				xml.toXMLString(),
				<multiname class="zero.swf.avm2.ABCMultiname" kind="QName" name=""/>.toXMLString()
			);
			check(ABCMultiname.xml2markStr(xml),"(ns=undefined)");
			
			_toXMLOptions=new zero_swf_ToXMLOptions();
			_toXMLOptions.AVM2UseMarkStr=true;
			markStrs=new MarkStrs();
			multiname=ABCMultiname.markStr2multiname(markStrs,"(ns=undefined)(name=undefined)");
			xml=multiname.toXMLAndMark(markStrs,"multiname",_toXMLOptions);
			check(xml.toXMLString(),<multiname markStr="(ns=undefined)(name=undefined)"/>.toXMLString());
			check(ABCMultiname.xml2markStr(xml),"(ns=undefined)(name=undefined)");
			markStrs=new MarkStrs();
			multiname=ABCMultiname.markStr2multiname(markStrs,"(ns=undefined)(name=undefined)");
			xml=multiname.toXMLAndMark(markStrs,"multiname",null);
			check(
				xml.toXMLString(),
				<multiname class="zero.swf.avm2.ABCMultiname" kind="QName"/>.toXMLString()
			);
			check(ABCMultiname.xml2markStr(xml),"(ns=undefined)(name=undefined)");
			
			
			_toXMLOptions=new zero_swf_ToXMLOptions();
			_toXMLOptions.AVM2UseMarkStr=true;
			markStrs=new MarkStrs();
			multiname=ABCMultiname.markStr2multiname(markStrs,"[QNameA]*(2)");
			xml=multiname.toXMLAndMark(markStrs,"multiname",_toXMLOptions);
			check(xml.toXMLString(),<multiname markStr="[QNameA]*(2)"/>.toXMLString());
			check(ABCMultiname.xml2markStr(xml),"[QNameA]*(2)");
			markStrs=new MarkStrs();
			multiname=ABCMultiname.markStr2multiname(markStrs,"[QNameA]*(2)");
			xml=multiname.toXMLAndMark(markStrs,"multiname",null);
			check(
				xml.toXMLString(),
				<multiname class="zero.swf.avm2.ABCMultiname" kind="QNameA" name="*" copyId="2">
					<ns class="zero.swf.avm2.ABCNamespace" kind="PackageNamespace" name=""/>
				</multiname>
				.toXMLString()
			);
			check(ABCMultiname.xml2markStr(xml),"[QNameA]*(2)");
			
			
			_toXMLOptions=new zero_swf_ToXMLOptions();
			_toXMLOptions.AVM2UseMarkStr=true;
			markStrs=new MarkStrs();
			multiname=ABCMultiname.markStr2multiname(markStrs,"[Multiname][flash.display,flash.events,flash.utils](2).*(2)");
			xml=multiname.toXMLAndMark(markStrs,"multiname",_toXMLOptions);
			check(xml.toXMLString(),<multiname markStr="[Multiname][flash.display,flash.events,flash.utils](2).*(2)"/>.toXMLString());
			check(ABCMultiname.xml2markStr(xml),"[Multiname][flash.display,flash.events,flash.utils](2).*(2)");
			markStrs=new MarkStrs();
			multiname=ABCMultiname.markStr2multiname(markStrs,"[Multiname][flash.display,flash.events,flash.utils](2).*(2)");
			xml=multiname.toXMLAndMark(markStrs,"multiname",null);
			check(
				xml.toXMLString(),
				<multiname class="zero.swf.avm2.ABCMultiname" kind="Multiname" name="*" copyId="2">
				  <ns_set class="zero.swf.avm2.ABCNs_set" copyId="2">
					<nsList count="3">
					  <ns class="zero.swf.avm2.ABCNamespace" kind="PackageNamespace" name="flash.display"/>
					  <ns class="zero.swf.avm2.ABCNamespace" kind="PackageNamespace" name="flash.events"/>
					  <ns class="zero.swf.avm2.ABCNamespace" kind="PackageNamespace" name="flash.utils"/>
					</nsList>
				  </ns_set>
				</multiname>
				.toXMLString()
			);
			check(ABCMultiname.xml2markStr(xml),"[Multiname][flash.display,flash.events,flash.utils](2).*(2)");
			
			
			_toXMLOptions=new zero_swf_ToXMLOptions();
			_toXMLOptions.AVM2UseMarkStr=true;
			markStrs=new MarkStrs();
			multiname=ABCMultiname.markStr2multiname(markStrs,"[GenericName]Vector.<String>");
			xml=multiname.toXMLAndMark(markStrs,"multiname",_toXMLOptions);
			check(xml.toXMLString(),<multiname markStr="[GenericName]Vector.&lt;String&gt;"/>.toXMLString());
			check(ABCMultiname.xml2markStr(xml),"[GenericName]Vector.<String>");
			markStrs=new MarkStrs();
			multiname=ABCMultiname.markStr2multiname(markStrs,"[GenericName]Vector.<String>");
			xml=multiname.toXMLAndMark(markStrs,"multiname",null);
			check(
				xml.toXMLString(),
				<multiname class="zero.swf.avm2.ABCMultiname" kind="GenericName">
				  <TypeDefinition class="zero.swf.avm2.ABCMultiname" kind="QName" name="Vector">
					<ns class="zero.swf.avm2.ABCNamespace" kind="PackageNamespace" name=""/>
				  </TypeDefinition>
				  <ParamList count="1">
					<Param class="zero.swf.avm2.ABCMultiname" kind="QName" name="String">
					  <ns class="zero.swf.avm2.ABCNamespace" kind="PackageNamespace" name=""/>
					</Param>
				  </ParamList>
				</multiname>
				.toXMLString()
			);
			check(ABCMultiname.xml2markStr(xml),"[GenericName]Vector.<String>");
			
			multiname=new ABCMultiname();
			multiname.kind=MultinameKinds.RTQName;
			multiname.name="\n";
			check(multiname.toMarkStrAndMark(new MarkStrs()),"[RTQName]\\n");
			check(
				multiname.toXMLAndMark(new MarkStrs(),"multiname",null).toXMLString(),
				<multiname class="zero.swf.avm2.ABCMultiname" kind="RTQName" name="&#xA;"/>.toXMLString()
			);
		}
		private function testABCMethods():void{
			var markStrs:MarkStrs;
			var method:ABCMethod;
			var _toXMLOptions:Object/*zero_swf_ToXMLOptions*/;
			var xml:XML;
			
			markStrs=new MarkStrs();
			method=new ABCMethod();
			method.return_type=ABCMultiname.markStr2multiname(markStrs,"flash.display.MovieClip");
			method.param_typeV=new Vector.<ABCMultiname>();
			method.param_typeV[0]=null;
			method.param_typeV[1]=ABCMultiname.markStr2multiname(markStrs,"flash.display.MovieClip");
			method.param_typeV[2]=null;
			method.name="哈哈";
			xml=method.toXMLAndMark(markStrs,"method",null);
			check(
				xml.toXMLString(),
				<method class="zero.swf.avm2.ABCMethod" name="哈哈">
				  <return_type class="zero.swf.avm2.ABCMultiname" kind="QName" name="MovieClip">
					<ns class="zero.swf.avm2.ABCNamespace" kind="PackageNamespace" name="flash.display"/>
				  </return_type>
				  <param_typeList count="3">
					<param_type/>
					<param_type class="zero.swf.avm2.ABCMultiname" kind="QName" name="MovieClip">
					  <ns class="zero.swf.avm2.ABCNamespace" kind="PackageNamespace" name="flash.display"/>
					</param_type>
					<param_type/>
				  </param_typeList>
				</method>.toXMLString()
			);
			check(method.toMarkStrAndMark(markStrs),"function(param0,param1:flash.display.MovieClip,param2):flash.display.MovieClip(name='哈哈')");
			
			markStrs=new MarkStrs();
			method=ABCMethod.xml2method(
				markStrs,
				<method class="zero.swf.avm2.ABCMethod" name="哈哈" return_type="flash.display.MovieClip">
				  <param_typeList count="3">
				    <param_type markStr="*"/>
				    <param_type class="zero.swf.avm2.ABCMultiname" kind="QName" name="MovieClip">
				      <ns class="zero.swf.avm2.ABCNamespace" kind="PackageNamespace" name="flash.display"/>
				    </param_type>
				    <param_type markStr="*"/>
				  </param_typeList>
				</method>,
				null
			);
			markStrs=new MarkStrs();
			check(method.toMarkStrAndMark(markStrs),"function(param0:*,param1:flash.display.MovieClip,param2:*):flash.display.MovieClip(name='哈哈')");
			
			markStrs=new MarkStrs();
			method=ABCMethod.xml2method(
				markStrs,
				<method class="zero.swf.avm2.ABCMethod">
				  <param_typeList count="2">
					<param_type/>
					<param_type/>
				  </param_typeList>
				</method>,
				null
			);
			check(method.toMarkStrAndMark(markStrs),'function(param0,param1)');
		}
	}
}
		