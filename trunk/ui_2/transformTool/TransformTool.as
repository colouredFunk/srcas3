/**
*
* 6dn Transform Tool

*----------------------------------------------------------------
* @notice 6dn Transform Tool 变形工具类
* @author 6dn
* @fp9.0  as3.0
* @v2.0
* @date 2009-7-15
*
* AUTHOR ******************************************************************************
* 
* authorName : 黎新苑 - www.6dn.cn
* QQ :160379558(6dnの星)
* MSN :xdngo@hotmail.com
* email :6dn@6dn.cn  xdngo@163.com
* webpage :   http://www.6dn.cn
* blog :    http://blog.6dn.cn
* 
* LICENSE ******************************************************************************
* 
* ① 此类为携带版变形工具类，所有用到的类都集成在一起~，所以阅读起来可能会不太方便。
* ② 基本上实现对选中DisplayObject进行缩放，旋转，变形,可轻松添加和移除控制；
* ③构造方法:
		TansformTool(container:DisplayObjectContainer) //创建TansformTool

	公共方法:

		-Init():void                          //初始化并添加侦听
		-Clear():void                         //移除TansformTool并移除侦听

		-AddControl(displayobject:DisplayObject):void       //添加控制
		-RemoveControl(displayobject:DisplayObject):void    //移除控制

		-SetType(object:Object, type:String):void  //设置TansformTool的类型

			// object:Object 中可设置：
				//o_graphics:String("rect" | "circle" | "bmp"); 中心点图形
				//graphics:String("rect" | "circle" | "bmp"); 边块图形
				//o_bitmapdata:BitmapData 中心点填充位图,o_graphics设为"bmp"才生效
				//bitmapdata:BitmapData 边块填充位图,graphics设为"bmp"才生效
				//color:uint  颜色值
				//border:uint  线条粗细
				//size:uint  边块大小
				//type:String("default") 使用默认设置

			//type:String ("activate" | "select") 指定激活状态或选择状态

		-SetStyle(displayobject:DisplayObject, object:Object):void  //设置DisplayObject的控制方式

			//displayobject:DisplayObject 要控制的显示对象

			// object:Object 中可设置:
				//enMoveX:Boolean 是否可以沿X轴拖动
				//enMoveY:Boolean 是否可以沿Y轴拖动
				//enSclaeX:Boolean 是否可以沿X轴拉伸
				//enSclaeY:Boolean 是否可以沿Y轴拉伸
				//enSkewX:Boolean 是否可以沿X轴斜切
				//enSkewY:Boolean 是否可以沿Y轴斜切
				//enSclae:Boolean  是否可以拉伸
				//eqScale:Boolean  是否限制等比
				//enRotation:Boolean  是否可以旋转
				//enSetMidPoint:Boolean  是否设置中心点

		-SetInfo(displayobject:DisplayObject, parameter:Object):Boolean   //设置DisplayObject的属性
		    
			//displayobject:DisplayObject 要控制的显示对象

			//parameter:Object 中可设置
				//x  设置x值:Number=数值 设置还原初始:String="revert"
				//y  设置y值:Number=数值 设置还原初始:String="revert"
				//scalex  设置scalex值:Number=数值 设置还原初始:String="revert"
				//sclaey  设置sclaey值:Number=数值 设置还原初始:String="revert"
				//skewx  设置skewx值:Number=数值 设置还原初始:String="revert"
				//skewy  设置skewy值:Number=数值 设置还原初始:String="revert"
				//rotation 设置rotation值:Number=数值 设置还原初始:String="revert"

		-GetInfo(displayobject:DisplayObject):Object     //获取DisplayObject的属性值
		
		-Undo():Boolean   //撤消
		-Redo():Boolean   //重做
		-ClearRecorde():void //删除操作记录

	公共属性:
		-area:Rectangle  //TansformTool作用区域（默认为舞台区域)(读写）
		-selectedItem:DisplayObject  //当前选择的显示对象(读写）

	用法示例 usage：
	var _transform:TransformTool = new TransformTool(root as DisplayObjectContainer);
	_transform.AddControl( mc );
	_transform.SetStyle(mc, {enMoveX:false, enScaleY:false, enSkewX:false, enSkewY:false});
	_transform.SetType({o_graphics:"bmp", graphics:"rect", color:0x339900, size:2},"activate");
	_transform.SetType({o_graphics:"circle", graphics:"rect", color:0x0, size:1},"select");
	_transform.Init();

* Please, keep this header and the list of all authors
* 
*/

package ui_2.transformTool
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.ui.Mouse;

	import flash.events.Event;	
	import flash.events.MouseEvent;
	import flash.events.IEventDispatcher;
		
	public class TransformTool 
	{
		private var _matrix:MatrixClass;
		private var _math:MathClass;
		private var _state:StateClass;
		private var _shape_arrow:ArrowShapeClass;
		private var _isInBounds:ContainPointClass;
		private var _shape_bounds:ShapeClass ;
	
		private var _Object_list:Array;
		private var _Recorde_list:Array;
		
		private var _select_index:int;	
		private var _recorde_index:int;	
		private var _container:DisplayObject;
		private var _type_activate:Object;
		private var _type_select:Object;
		private var _rectAngle:Rectangle;
		
		public function TransformTool($containner:DisplayObjectContainer = null) 
		{	
			if (!$containner)
			{
				throw Error("please set containner first!");
				return;
			}
			_container = $containner
			_matrix = new MatrixClass();
			_math = new MathClass();
			_state = new StateClass();
			_shape_arrow = new ArrowShapeClass();
			_shape_bounds = new ShapeClass();
			_isInBounds = new ContainPointClass();
			
			_rectAngle =  new Rectangle(0, 0, _container.stage.stageWidth, _container.stage.stageHeight);
			
			_Object_list = new Array();
			_Recorde_list = new Array();
			_select_index = -1;
			_recorde_index = 0;

			
			_type_activate = new Object();
			_type_activate = { o_graphics:"cicle", graphics:"rect", o_bitmapdata: null, bitmapdata: null, color:0x0};
			_type_select = new Object();
			_type_select = { o_graphics:"cicle",  graphics:"rect", o_bitmapdata:null,  bitmapdata: null, color:0xFF9900};
			
		}
		
		public function Init():void
		{
			_container.stage.addChild(_shape_bounds);
			_container.stage.addChild(_shape_arrow);
			
			_container.stage.addEventListener( MouseEvent.MOUSE_MOVE, EventHadler);
			_container.stage.addEventListener( MouseEvent.MOUSE_DOWN, EventHadler);
			_container.stage.addEventListener( MouseEvent.MOUSE_UP, EventHadler);
		}
		
		public function Clear():void
		{
			_shape_arrow.Clear();
			_shape_bounds.Clear();
			
			_container.stage.removeChild(_shape_arrow);
			_container.stage.removeChild(_shape_bounds);
			
			_container.stage.removeEventListener( MouseEvent.MOUSE_MOVE, EventHadler);
			_container.stage.removeEventListener( MouseEvent.MOUSE_DOWN, EventHadler);
			_container.stage.removeEventListener( MouseEvent.MOUSE_UP, EventHadler);
		}	
		
		public function AddControl($disOjbect:DisplayObject):void
		{
			var $_style :Object= {
				enMoveX:true,
				enMoveY:true,
				enScaleX:true,
				enScaleY:true,
				enSkewX:true,
				enSkewY:true,
				enScale:true,
				eaScale:false,
				enRotation:true,
				enSetMidPoint:true
			};
			
			var $_index:int = FindIndex($disOjbect);
			var $_internalPoint:Point = new Point(0, 0);
			var $_externalPoint:Point = ($disOjbect.parent).globalToLocal($disOjbect.localToGlobal($_internalPoint));
			var $_matrix_obj:Object = _matrix.GetMatrix($disOjbect, $_internalPoint);
			
			if ($disOjbect is DisplayObjectContainer) {
				($disOjbect as DisplayObjectContainer).mouseChildren=false;
			}
			
			if ($_index==-1) {
				_Object_list.push(
					{
						obj        : $disOjbect, 
						state      : _state.normal,
						areanum    : -1,
						mousePoint0 : new Point(0, 0),
						mousePoint1 : new Point(0,0),
						internalPoint  : $_internalPoint,
						externalPoint  : $_externalPoint,
						initMatrix : $_matrix_obj,
						matrix     : $_matrix_obj,
						style      : $_style
					}
				);
			}
		}
		
		public function RemoveControl($object:DisplayObject):void 
		{
			var $_index:int=FindIndex($object);
			if ($_index != -1) 
			{
				_Object_list.splice($_index,1);
			}
		}
		
		public function Undo():Boolean
		{
			if (_recorde_index < 0 || _Recorde_list.length<1 ) {
				_recorde_index = 0;
				return false;
			}else {
				var $_disOjbect:DisplayObject = _Recorde_list[_recorde_index]["disObject"];
				var $_matrix:Object = _Recorde_list[_recorde_index]["matrix_old"];
				var $_tx:Number = $_matrix["tx"];
				var $_ty:Number = $_matrix["ty"];
				var $_scalex:Number = $_matrix["scalex"];
				var $_scaley:Number = $_matrix["scaley"];
				var $_skewx:Number = $_matrix["skewx"];
				var $_skewy:Number = $_matrix["skewy"];
				
				var $_index:int = FindIndex($_disOjbect);
				var $_obj_info:Object = _Object_list[$_index];
				GraphicsClear();
				(_select_index != -1) && (_Object_list[_select_index]["state"] =  _state.normal );
				$_obj_info["state"] = _state.select;
				$_obj_info["matrix"] = $_matrix;
				_select_index = $_index;
				GraphicsDraw($_matrix);
				
				_matrix.SetMatrix($_disOjbect, $_tx, $_ty, $_scalex, $_scaley, $_skewx, $_skewy);
				_recorde_index = _recorde_index > 0? _recorde_index - 1:0;
			}
			return true;
		}
		
		public function Redo():Boolean
		{
			_recorde_index = _recorde_index < ( _Recorde_list.length - 1)? _recorde_index + 1:( _Recorde_list.length - 1);
			if (_recorde_index > _Recorde_list.length -1 || _Recorde_list.length<1 ) {
				_recorde_index = _Recorde_list.length -1;
				return false;
			}else{
				var $_disOjbect:DisplayObject = _Recorde_list[_recorde_index]["disObject"];
				var $_matrix:Object = _Recorde_list[_recorde_index]["matrix_new"];
				var $_tx:Number = $_matrix["tx"];
				var $_ty:Number = $_matrix["ty"];
				var $_scalex:Number = $_matrix["scalex"];
				var $_scaley:Number = $_matrix["scaley"];
				var $_skewx:Number = $_matrix["skewx"];
				var $_skewy:Number = $_matrix["skewy"];
				
				var $_index:int = FindIndex($_disOjbect);
				var $_obj_info:Object = _Object_list[$_index];
				GraphicsClear();
				(_select_index != -1) && (_Object_list[_select_index]["state"] =  _state.normal );
				$_obj_info["state"] = _state.select;
				$_obj_info["matrix"] = $_matrix;
				_select_index = $_index;
				GraphicsDraw($_matrix);
				
				_matrix.SetMatrix($_disOjbect, $_tx, $_ty, $_scalex, $_scaley, $_skewx, $_skewy);
				
			}
			return true;
		}
		
		public function ClearRecorde():void
		{
			_Recorde_list = [];
		}
		
		public function SetInfo($disOjbect:DisplayObject,$parameter:Object):Boolean
		{
			var $_index:int=FindIndex($disOjbect);
			if ($_index != -1) 
			{
				var $_obj_info:Object = _Object_list[$_index];
				var $_matrix:Object = $_obj_info["matrix"];
				var $_o_matrix:Object = $_obj_info["initMatrix"];
				

				var $_tx:* = $parameter["x"];
				var $_ty:* = $parameter["y"];
				var $_scalex:* = $parameter["scalex"];
				var $_scaley:* = $parameter["scaley"];
				var $_skewx:* = $parameter["skewx"];
				var $_skewy:* = $parameter["skewy"];
				var $_rotation:* = $parameter["rotation"];

				
				($_tx == "revert") ? ($_matrix["tx"] = $_o_matrix["tx"]) : ($_tx != null) ? ($_matrix["tx"] = Number($_tx)) : null ;
				($_ty == "revert") ? ($_matrix["ty"] = $_o_matrix["ty"]) : ($_ty != null) ? ($_matrix["ty"] = Number($_ty)) : null ;
				($_scalex == "revert") ? ($_matrix["scalex"] = $_o_matrix["scalex"]) : ($_scalex != null) ? ($_matrix["scalex"] = Number($_scalex)) : null ;
				($_scaley == "revert") ? ($_matrix["scaley"] = $_o_matrix["scaley"]) : ($_scaley != null) ? ($_matrix["scaley"] = Number($_scaley)) : null ;
				if ($_rotation != null) 
				{
					if ($_rotation == "revert") {
						$_matrix["skewx"] = $_o_matrix["skewx"];
						$_matrix["skewy"] = $_o_matrix["skewy"];
					}else {
						$_matrix["skewx"] = Number($_rotation);
						$_matrix["skewy"] = Number($_rotation);
					}
				}
				($_skewx == "revert") ? ($_matrix["skewx"] = $_o_matrix["skewx"]) : ($_skewx != null) ? ($_matrix["skewx"] = Number($_skewx)) : null ;
				($_skewy == "revert") ? ($_matrix["skewy"] = $_o_matrix["skewy"]) : ($_skewy != null) ? ($_matrix["skewy"] = Number($_skewy)) : null ;

				_matrix.SetMatrix($disOjbect, $_matrix["tx"], $_matrix["ty"], $_matrix["scalex"], $_matrix["scaley"], $_matrix["skewx"], $_matrix["skewy"]);
				$_obj_info["matrix"] = _matrix.GetMatrix($disOjbect, $_obj_info["internalPoint"]);

				return true;
			}
			return false;
		}
		
		public function GetInfo($disOjbect:DisplayObject):Object
		{
			var $_index:int=FindIndex($disOjbect);
			if ($_index != -1) 
			{
				var $_obj_info:Object = _Object_list[$_index];
				var $_matrix:Object = $_obj_info["matrix"];
				var $_re_object:Object = {
					x: $_matrix["tx"],
					y: $_matrix["ty"],
					scalex: $_matrix["scalex"],
					scaley: $_matrix["scaley"],
					skewx: $_matrix["skewx"],
					skewy: $_matrix["skewy"],
					rotation: $_matrix["skewx"]
				}
				return $_re_object;
			}
			return null;
		}
		
		public function SetType($type:Object, $state:String = "activate"):void
		{
			var $_o_graphics :* = $type["o_graphics"];
			var $_graphics:* = $type["graphics"];
			var $_o_bitmapdata:* = $type["o_bitmapdata"];
			var $_bitmapdata :* = $type["bitmapdata"];
			var $_color :* = $type["color"];
			var $_border :* = $type["border"];
			var $_size :* = $type["size"];
			var $_type :String = $type["type"];
			
			var $_type_activate:Object = { o_graphics:"cicle", graphics:"rect", o_bitmapdata: null, bitmapdata: null, color:0x0, border:1};
			var $_type_select:Object  = { o_graphics:"cicle",  graphics:"rect", o_bitmapdata:null,  bitmapdata: null, color:0xFF9900, border:1};
			
			var $_obj:Object = $state == "select" ? _type_select : _type_activate;
			if ($_type == "default")
			{
				$_obj = $state == "select" ? $_type_select : $_type_activate;
			}
			($_o_graphics != null) && ($_obj["o_graphics"] = String($_o_graphics));
			($_graphics != null) && ($_obj["graphics"] = String($_graphics));
			($_o_bitmapdata != null) && ($_obj["o_bitmapdata"] = BitmapData($_o_bitmapdata));
			($_bitmapdata != null) && ($_obj["bitmapdata"] = BitmapData($_bitmapdata));
			($_color != null) && ($_obj["color"] = uint($_color));
			($_border != null) && ($_obj["border"] = uint($_border));
			($_size != null) && ($_obj["size"] = uint($_size));
			
		}
		public function SetStyle($object:DisplayObject, $style:Object):void
		{
			var $_index:int=FindIndex($object);
			if ($_index != -1) 
			{
				var $_info:Object = _Object_list[$_index];
				var $_EnMoveX :* = $style["enMoveX"];
				var $_EnMoveY :* = $style["enMoveY"];
				var $_EnScaleX:* = $style["enScaleX"];
				var $_EnScaleY:* = $style["enScaleY"];
				var $_EnSkewX :* = $style["enSkewX"];
				var $_EnSkewY :* = $style["enSkewY"];
				var $_EnScale :* = $style["enScale"];
				var $_EqScale :* = $style["eqScale"];
				var $_EnRotation:* = $style["enRotation"];
				var $_EnSetMidPoint:* = $style["enSetMidPoint"];
				
				($_EnMoveX != null) && ($_info["style"]["enMoveX"] = Boolean($_EnMoveX));
				($_EnMoveY != null) && ($_info["style"]["enMoveY"] = Boolean($_EnMoveY));
				($_EnScaleX != null) && ($_info["style"]["enScaleX"] = Boolean($_EnScaleX));
				($_EnScaleY != null) && ($_info["style"]["enScaleY"] = Boolean($_EnScaleY));
				($_EnSkewX != null) && ($_info["style"]["enSkewX"] = Boolean($_EnSkewX));
				($_EnSkewY != null) && ($_info["style"]["enSkewY"] = Boolean($_EnSkewY));
				($_EnScale != null) && ($_info["style"]["enScale"] = Boolean($_EnScale));
				($_EqScale != null) && ($_info["style"]["eqScale"] = Boolean($_EqScale));
				($_EnRotation != null) && ($_info["style"]["enRotation"] = Boolean($_EnRotation));
				($_EnSetMidPoint != null) && ($_info["style"]["enSetMidPoint"] = Boolean($_EnSetMidPoint));
				
			}
		}
		public function set selectedItem($disObject:DisplayObject):void
		{
			var $_index:int=FindIndex($disObject);
			if ($_index != -1) 
			{
				var $_obj_info:Object = _Object_list[$_index];
				GraphicsClear();
				(_select_index != -1) && (_Object_list[_select_index]["state"] =  _state.normal );
				$_obj_info["state"] = _state.select;
				_select_index = $_index;
				GraphicsDraw($_obj_info["matrix"]);
			}
		}
		
		public function get selectedItem():DisplayObject
		{
			if (_select_index != -1)
			{
				return _Object_list[_select_index]["obj"];
			}
			return null;
		}
		
		public function set area($rectangle:Rectangle):void
		{
			_rectAngle = $rectangle;
		}
		
		public function get area():Rectangle
		{
			return _rectAngle;
		}
		
		private function EventHadler(evt:MouseEvent):void 
		{
			var $_target:*= evt.target;
			var $_type:String = evt.type;
			var $_disOjbect:DisplayObject;	
			var $_selectObject:DisplayObject;	
			var $_matrix:Object;
			var $_obj_info:Object;
			var $_index:int ;
			var $_state:String;
			var $_area_num:int;
			var $_inexistence :int = -1;
			
			evt.updateAfterEvent();
			$_disOjbect = $_target as DisplayObject;	
			switch($_type) {
				case "mouseDown":
					if (_select_index != $_inexistence )
					{
						$_obj_info = _Object_list[_select_index];
						$_state = $_obj_info["state"];
						if ($_state==_state.area)
						{
							$_disOjbect = $_obj_info["obj"];
							$_obj_info["mousePoint0"] = new Point(_container.mouseX, _container.mouseY);
							$_obj_info["externalPoint"] = ($_disOjbect.parent).globalToLocal($_disOjbect.localToGlobal($_obj_info["internalPoint"]));
							$_obj_info["state"] = _state.change;
							
							return;
						}
					}
					
					$_index = FindIndex($_disOjbect);
					if ($_index != $_inexistence)
					{
						$_obj_info = _Object_list[$_index];
						$_state = $_obj_info["state"];
						$_matrix = $_obj_info["matrix"];
						
						if ($_state == _state.select || $_state ==_state.normal)
						{
							_select_index = $_index;
							$_disOjbect.parent.addChild($_disOjbect);
							_shape_bounds.parent.addChild(_shape_bounds);
							_shape_arrow.parent.addChild(_shape_arrow);
							
							$_obj_info["mousePoint0"] = new Point(_container.mouseX, _container.mouseY);
							$_obj_info["state"] = _state.drag ;
							$_obj_info["matrix"]["array"][4] = ($_disOjbect.parent).globalToLocal($_disOjbect.localToGlobal($_obj_info["internalPoint"]));
							$_obj_info["externalPoint"] = ($_disOjbect.parent).globalToLocal($_disOjbect.localToGlobal($_obj_info["internalPoint"]));
							GraphicsClear();
							GraphicsDraw($_matrix);
							
						}
					}else
					{
						(_select_index != $_inexistence) && (_Object_list[_select_index]["state"] =  _state.normal );
						_select_index = $_inexistence;
						GraphicsClear();
					}
				break;
				case "mouseUp":
					if (_select_index != $_inexistence )
					{
						$_obj_info = _Object_list[_select_index];
						$_state = $_obj_info["state"];
						$_matrix = $_obj_info["matrix"];
						
						if ($_state==_state.change)
						{
							$_disOjbect = $_obj_info["obj"];
							
							(_recorde_index != _Recorde_list.length - 1) && (_Recorde_list.splice(_recorde_index+1,_Recorde_list.length));
							_Recorde_list.push( {
								disObject: $_disOjbect,
								matrix_old: $_obj_info["matrix"],
								matrix_new: _matrix.GetMatrix($_disOjbect,$_obj_info["internalPoint"])
							});
							_recorde_index = _Recorde_list.length - 1;
							
							$_obj_info["state"] = _state.select;
							$_obj_info["matrix"] = _matrix.GetMatrix($_disOjbect,$_obj_info["internalPoint"]);
							_container.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_MOVE));
							
							return;
						}else if ( $_state == _state.drag)
						{
							ArrowClear();
							$_disOjbect = $_obj_info["obj"];
							
							(_recorde_index != _Recorde_list.length - 1) && (_Recorde_list.splice(_recorde_index+1,_Recorde_list.length));
							_Recorde_list.push({
								disObject: $_disOjbect,
								matrix_old: $_obj_info["matrix"],
								matrix_new: _matrix.GetMatrix($_disOjbect,$_obj_info["internalPoint"])
							});
							_recorde_index = _Recorde_list.length - 1;
							
							$_obj_info["state"]  = _state.select;
							$_obj_info["matrix"] = _matrix.GetMatrix($_disOjbect,$_obj_info["internalPoint"]);
					
							$_obj_info["externalPoint"] = ($_disOjbect.parent).globalToLocal($_disOjbect.localToGlobal($_obj_info["internalPoint"]));
							
						}
						
					}
				break;
				case "mouseMove":
					var $_isInArea:Boolean = _rectAngle.containsPoint(new Point(_container.mouseX, _container.mouseY));
					
					if (!$_isInArea)
					{
						ArrowClear();
						_container.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_UP));
						return;
					}
					
					GraphicsClear();
					$_index = FindIndex($_disOjbect);
					if ($_index != $_inexistence && $_index != _select_index)
					{
						$_obj_info  = _Object_list[$_index];
						$_matrix    = $_obj_info["matrix"];
						DrawSelectGraphics($_matrix);
					}
					
					if (_select_index != $_inexistence)
					{
						$_obj_info  = _Object_list[_select_index];
						$_disOjbect = $_obj_info["obj"];
						$_matrix    = $_obj_info["matrix"];
						$_state     = $_obj_info["state"];
						$_area_num  = GetAreaNum(_select_index);
						
						if ($_state == _state.change)
						{
							GraphicsClear();
							$_area_num  = $_obj_info["areanum"];
							ArrowMove();
							SetChange(_select_index, $_area_num);
							$_matrix    = _matrix.GetMatrix($_disOjbect,$_obj_info["internalPoint"]);

						}else if ($_state == _state.drag)
						{
							GraphicsClear();
							SetMove(_select_index);
							ArrowShow(_shape_arrow.Bmp_move);
							ArrowMove();
							$_matrix    = _matrix.GetMatrix($_disOjbect,$_obj_info["internalPoint"]);
							
						}else if ($_area_num!=$_inexistence)
						{
							GraphicsClear();
							$_obj_info["areanum"] = $_area_num;
							$_obj_info["state"] = _state.area;
							
							var $_tmp_bmp:BitmapData = GetArrowBmp($_matrix, $_area_num);
							var $_isOrigin:Boolean = $_area_num == 4 ? true : false;
							if ($_tmp_bmp != null) 
							{
								ArrowShow($_tmp_bmp,$_isOrigin);
								ArrowMove();
							}
						}else 
						{
							$_obj_info["state"] = _state.select;
							//GraphicsClear();
							ArrowClear();
						}
						
						GraphicsDraw($_matrix);
						
					}
				break;
			}
		}
		
		//-----------------------------------------------------------------------
		private function SetMove($index:int):void
		{
			var $_obj_info:Object = _Object_list[$index];
			var $_disOjbect:DisplayObject = $_obj_info["obj"];
			var $_mousePoint0:Point = $_obj_info["mousePoint0"];
			var $_mousePoint1:Point = new Point(_container.mouseX, _container.mouseY);
			var $_matrix:Object =  $_obj_info["matrix"];
			
			var $_EnMoveX:Boolean = $_obj_info["style"]["enMoveX"];
			var $_EnMoveY:Boolean = $_obj_info["style"]["enMoveY"];
			
			($_EnMoveX) && ($_disOjbect.x = $_matrix["tx"] + $_mousePoint1.x -$_mousePoint0.x);
			($_EnMoveY) && ($_disOjbect.y = $_matrix["ty"] + $_mousePoint1.y -$_mousePoint0.y);
		}
		private function SetMidPoint($index:int):void 
		{	
			var $_obj_info:Object = _Object_list[$index];
			var $_disOjbect:DisplayObject = $_obj_info["obj"];
			$_obj_info["externalPoint"].x = _container.mouseX;
			$_obj_info["externalPoint"].y = _container.mouseY;
			$_obj_info["internalPoint"] = ($_disOjbect).globalToLocal(($_disOjbect.parent).localToGlobal($_obj_info["externalPoint"]));
		}
		private function SetChange($index:int, $area_num:int):void 
		{
			//   ------------------
			//   [0] 11 [3] 11 [6]
			//    9			   10
			//   [1]    [4]    [7]
			//    9            10
			//   [2] 12 [5] 12 [8] [13]
			//   ------------------
			var $_type:String;
			if ($area_num == 4) 
			{
				$_type = "setMidPoint" ;
				SetMidPoint($index);
				return;
			}else if ($area_num == 0 || $area_num == 8 || $area_num == 2 || $area_num == 6) 
			{
				$_type = "scale";
			} else if ($area_num == 1 || $area_num == 7 ) 
			{
				$_type = "xscale";
			} else if ($area_num == 3 || $area_num == 5 )
			{
				$_type = "yscale";
			} else if ($area_num == 9 || $area_num == 10) 
			{
				$_type = "yskew";
			} else if ($area_num == 11 || $area_num == 12) 
			{
				$_type = "xskew";
			} else if ($area_num == 13) 
			{
				$_type = "rotation";
			} else{
				return;
			}
			
			var $_obj_info:Object = _Object_list[$index];
			var $_disOjbect:DisplayObject = $_obj_info["obj"];
			
			var $_matrix:Object = $_obj_info["matrix"];
			//var $_matrix_new:Object = _matrix.GetMatrix($_disOjbect,$_obj_info["internalPoint"]);
			var $_array:Array = $_matrix["array"];
			var $_internalPoint:Point = $_obj_info["internalPoint"];
			var $_externalPoint:Point = $_obj_info["externalPoint"];
			
			var $_EqScale:Boolean = $_obj_info["style"]["eqScale"];
			var $_EnScaleX:Boolean = $_obj_info["style"]["enScaleX"];
			var $_EnScaleY:Boolean = $_obj_info["style"]["enScaleY"];
			
			var $_mousePoint0:Point = $_obj_info["mousePoint0"];
			var $_mousePoint1:Point = new Point(_container.mouseX, _container.mouseY);
			$_obj_info["mousePoint1"] =  $_mousePoint1;
			
			var $_minW:int = 10 ;
			var $_minH:int = 10 ;
			var $_minSkew:int = 10 ;
			var $_objW:int ;
			var $_objH:int ;
			var $_skew_gap:Number ;
			
			var $_tx:Number = $_matrix["tx"];
			var $_ty:Number = $_matrix["ty"];
			var $_scalex:Number = $_matrix["scalex"];
			var $_scaley:Number = $_matrix["scaley"];
			var $_skewx:Number = $_matrix["skewx"];
			var $_skewy:Number = $_matrix["skewy"];
			var $_angle0:Number;
			var $_angle1:Number;
			var $_tmp_obj:Object;
			
			
			switch ($_type) {
				case "xscale" :
					if($_EnScaleX){	
						$_scalex = GetNewScaleX($index, $area_num);
						($_EqScale) && ($_scaley = $_scalex);
					}
					break;
					
				case "yscale" :
					if($_EnScaleY){	
						$_scaley = GetNewScaleY($index, $area_num);
						($_EqScale) && ($_scalex = $_scaley);
					}
					break;
					
				case "scale" :
					if($_EnScaleX){	
						$_scalex = GetNewScaleX($index, $area_num);
						($_EqScale) && ($_scaley = $_scalex);
					}
					if($_EnScaleY){	
						$_scaley = GetNewScaleY($index, $area_num);
						($_EqScale) && ($_scalex = $_scaley);
					}
					//$_scaley = $_scalex;
					break;
					
				case "rotation" :
					$_angle0 = _math.GetAngle($_mousePoint0, $_externalPoint);
					$_angle1 = _math.GetAngle($_mousePoint1, $_externalPoint);
					$_skewx  = $_skewx + $_angle1 - $_angle0;
					$_skewy  = $_skewy + $_angle1 - $_angle0;
					break;
				case "xskew" :
					$_tmp_obj = GetNewSkewY($index, $area_num);
					$_skewx  = $_tmp_obj["skewx"];
					$_scaley = $_tmp_obj["scaley"];
					($_EqScale)&& ($_scaley = $_scalex);
					break;
				case "yskew" :
					$_tmp_obj = GetNewSkewX($index, $area_num);
					$_skewy  = $_tmp_obj["skewy"];
					$_scalex = $_tmp_obj["scalex"];
					($_EqScale)&& ($_scalex = $_scaley);
					break;
				default :
					break;
			}
			$_objW = $_matrix["w"] * $_scalex;
			$_objH = $_matrix["h"] * $_scaley;
			$_skew_gap = Math.abs($_skewx - $_skewy)%180;
			
			if(($_objW < $_minW && $_objW > -$_minW) || ($_objH < $_minH && $_objH > -$_minH) || ($_skew_gap< 90+$_minSkew && $_skew_gap> 90-$_minSkew))
			{
				return;
			}
				
			_matrix.SetMatrix($_disOjbect, $_tx, $_ty, $_scalex, $_scaley, $_skewx, $_skewy);
			_matrix.SetMidPoint($_disOjbect, $_internalPoint, $_externalPoint);
			
		}
		//-----------------------------------------------------------------------
		private function GetNewSkewX($index:int, $area_num:int):Object
		{
			//-------------------
			//   0   3   6
			//   1   4   7
			//   2   5   8
			//-------------------
			var $_num:int = $area_num == 9 ? 1 : 7; 
			var $_obj_info:Object = _Object_list[$index];
			var $_matrix:Object = $_obj_info["matrix"];
			var $_array:Array = $_matrix["array"];
			var $_skewx:Number = $_matrix["skewx"];
			var $_skewy:Number = $_matrix["skewy"];
			var $_scalex:Number = $_matrix["scalex"];
		
			var $_midPoint:Point = $_array[4];
			var $_areaPoint:Point= $_array[$_num];
			var $_mousePoint0:Point = $_obj_info["mousePoint0"];	
			var $_mousePoint1:Point = $_obj_info["mousePoint1"];	

			var $_mp0:Point = _math.GetCrossPoint( $_mousePoint0, $_skewy, $_midPoint, $_skewx + 90);
			var $_mp1:Point = _math.GetCrossPoint( $_mousePoint0, $_skewy, $_areaPoint, $_skewx + 90);
			var $_mp2:Point = _math.GetCrossPoint( $_mousePoint1, $_skewy, $_midPoint, $_skewx + 90);
			var $_mp3:Point = _math.GetCrossPoint( $_mousePoint1, $_skewy, $_areaPoint, $_skewx + 90);
			
			var $_angle:Number ;
			var $_angle0:Number = _math.GetAngle($_mp3, $_mp0);
			var $_angle1:Number = _math.GetAngle($_mp0, $_mp3);
			
			var $_tmp_point0:Point = _math.GetCrossPoint( $_midPoint, $_skewy, $_array[1], $_skewx + 90);
			var $_tmp_point1:Point = _math.GetCrossPoint( $_midPoint, $_skewy, $_array[7], $_skewx + 90);
			
			var $_s0:Number = _math.GetPos( $_array[1], $_array[7]);
			var $_s1:Number = _math.GetPos( $_midPoint, $_tmp_point0);
			var $_s2:Number = _math.GetPos( $_midPoint, $_tmp_point1);
			
			var $_isLeft :Boolean = $_s2 > $_s0 && $_s2 > $_s1 ;
			var $_isRight :Boolean = $_s1 > $_s0 && $_s1 > $_s2 ;
			
			if ($area_num == 9)
			{
				$_angle = $_angle0;
				($_isLeft) && ($_angle = $_angle1);
			}else if ($area_num == 10)
			{
				$_angle = $_angle1;
				($_isRight) && ($_angle = $_angle0);
			}
			
			if (int($_mp0.x-$_mp1.x)!=0 || int($_mp0.y-$_mp1.y)!=0)
			{
				$_skewy  = $_angle;
				$_mp0 = _math.GetCrossPoint( $_midPoint, $_skewy, $_array[0], $_skewx + 90);
				$_mp1 = _math.GetCrossPoint( $_midPoint, $_skewy, $_array[8], $_skewx + 90);
				$_scalex = _math.GetPos($_mp0, $_mp1) / $_matrix["w"];
			}
			
			return {skewy:$_skewy, scalex:$_scalex};
		}
		private function GetNewSkewY($index:int, $area_num:int):Object
		{
			//-------------------
			//   0   3   6
			//   1   4   7
			//   2   5   8
			//-------------------
			var $_num:int = $area_num == 11 ? 3 : 5; 
			var $_obj_info:Object = _Object_list[$index];
			var $_matrix:Object = $_obj_info["matrix"];
			var $_array:Array = $_matrix["array"];
			var $_skewx:Number = $_matrix["skewx"];
			var $_skewy:Number = $_matrix["skewy"];
			var $_scaley:Number = $_matrix["scaley"];
			
			var $_midPoint:Point = $_array[4];
			var $_areaPoint:Point= $_array[$_num];
			var $_mousePoint0:Point = $_obj_info["mousePoint0"];	
			var $_mousePoint1:Point = $_obj_info["mousePoint1"];	

			var $_mp0:Point = _math.GetCrossPoint( $_mousePoint0, $_skewx + 90, $_midPoint, $_skewy);
			var $_mp1:Point = _math.GetCrossPoint( $_mousePoint0, $_skewx + 90, $_areaPoint, $_skewy);
			var $_mp2:Point = _math.GetCrossPoint( $_mousePoint1, $_skewx + 90, $_midPoint, $_skewy);
			var $_mp3:Point = _math.GetCrossPoint( $_mousePoint1, $_skewx + 90, $_areaPoint, $_skewy);
			
			var $_angle:Number ;
			var $_angle0:Number = _math.GetAngle($_mp3, $_mp0);
			var $_angle1:Number = _math.GetAngle($_mp0, $_mp3);
			
			var $_tmp_point0:Point = _math.GetCrossPoint( $_midPoint, $_skewx + 90, $_array[3], $_skewy);
			var $_tmp_point1:Point = _math.GetCrossPoint( $_midPoint, $_skewx + 90, $_array[5], $_skewy);
			
			var $_s0:Number = _math.GetPos( $_array[3], $_array[5]);
			var $_s1:Number = _math.GetPos( $_midPoint, $_tmp_point0);
			var $_s2:Number = _math.GetPos( $_midPoint, $_tmp_point1);
			
			var $_isUp :Boolean = $_s2 > $_s0 && $_s2 > $_s1 ;
			var $_isDown :Boolean = $_s1 > $_s0 && $_s1 > $_s2 ;
			
			if ($area_num == 11)
			{
				$_angle = $_angle0;
				($_isUp) && ($_angle = $_angle1);
			}else if ($area_num == 12)
			{
				$_angle = $_angle1;
				($_isDown) && ($_angle = $_angle0);
			}
			
			if (int($_mp0.x-$_mp1.x)!=0 || int($_mp0.y-$_mp1.y)!=0)
			{
				$_skewx  = $_angle-90;
				$_mp0 = _math.GetCrossPoint( $_midPoint, $_skewx + 90, $_array[0], $_skewy);
				$_mp1 = _math.GetCrossPoint( $_midPoint, $_skewx + 90, $_array[8], $_skewy);
				
				$_scaley =  _math.GetPos($_mp0, $_mp1) / $_matrix["h"];
				
			}
			return { skewx:$_skewx, scaley:$_scaley };
		}
		
		private function GetNewScaleX($index:int, $area_num:int):Number
		{
			//-------------------
			//   0   3   6
			//   1   4   7
			//   2   5   8
			//-------------------
			var $_obj_info:Object = _Object_list[$index];
			var $_matrix:Object = $_obj_info["matrix"];
			var $_array:Array = $_matrix["array"];
			var $_skewx:Number = $_matrix.skewx;
			var $_skewy:Number = $_matrix.skewy;
			
			var $_midPoint:Point = $_array[4];
			var $_mousePoint1:Point = $_obj_info["mousePoint1"];
			var $_areaPoint:Point= $_array[$area_num];
			
			var $_mp0:Point = _math.GetCrossPoint( $_midPoint, $_skewy, $_areaPoint, $_skewx + 90);
			var $_mp1:Point = _math.GetCrossPoint( $_midPoint, $_skewy, $_mousePoint1, $_skewx + 90);
			
			var $_s0:Number = _math.GetPos( $_midPoint, $_mp0);
			var $_s1:Number = _math.GetPos( $_midPoint, $_mp1);
			var $_s3:Number = _math.GetPos( $_mp0, $_mp1);
			var $_vetor:int = ($_s3 > $_s1)&&($_s3 > $_s0) ? -1 :1;
			
			var $_scalex:Number = $_matrix.scalex;
			($_s0 > 1 || $_s0 < -1) && ( $_scalex  = $_scalex *($_s1/$_s0) * $_vetor);	
			return $_scalex;
		}
		
		private function GetNewScaleY($index:int, $area_num:int):Number
		{
			//-------------------
			//   0   3   6
			//   1   4   7
			//   2   5   8
			//-------------------
			var $_obj_info:Object = _Object_list[$index];
			var $_matrix:Object = $_obj_info["matrix"];
			var $_array:Array = $_matrix["array"];
			var $_skewx:Number = $_matrix.skewx;
			var $_skewy:Number = $_matrix.skewy;
			
			var $_midPoint:Point = $_array[4];
			var $_mousePoint1:Point = $_obj_info["mousePoint1"];
			var $_areaPoint:Point= $_array[$area_num];
			
			var $_mp0:Point = _math.GetCrossPoint( $_midPoint, $_skewx + 90, $_areaPoint, $_skewy);
			var $_mp1:Point = _math.GetCrossPoint( $_midPoint, $_skewx + 90, $_mousePoint1, $_skewy);
			
			var $_s0:Number = _math.GetPos( $_midPoint, $_mp0);
			var $_s1:Number = _math.GetPos( $_midPoint, $_mp1);
			var $_s3:Number = _math.GetPos( $_mp0, $_mp1);
			var $_vetor:int = ($_s3 > $_s1)&&($_s3 > $_s0) ? -1 :1;
			
			var $_scaley:Number = $_matrix.scaley;
			($_s0 > 1 || $_s0 < -1) && ($_scaley  = $_scaley *($_s1 / $_s0 ) * $_vetor) ;
			return $_scaley;
		}
		
		private function GetAreaNum($index:int):int
		{
			//   $areanum--------------
			//   [0] 11 [3] 11 [6]
			//    9			   10
			//   [1]    [4]    [7]
			//    9            10
			//   [2] 12 [5] 12 [8] [13]
			//   ----------------------
			
			var $_obj_info:Object = _Object_list[$index];
			var $_matrix:Object = $_obj_info["matrix"];
			var $_arr:Array = $_matrix["array"];
			var $_testPoint:Point = new Point(_container.mouseX, _container.mouseY);
			var $_areaPoint:Point ;
			var $_isTrue:Boolean ;
			var $_obj_size0:uint = $_matrix["w"] * $_matrix["scalex"] * 0.25;
			var $_obj_size1:uint = $_matrix["h"] * $_matrix["scaley"] * 0.25;
			var $_block_size0:uint = 10;
			var $_block_size1:uint = 10;
			var $_block_size2:uint = 8;
			var $_block_size3:uint = 8;
			var $_block_size4:uint = 15;
			
			var $_EnScaleX:Boolean = $_obj_info["style"]["enScaleX"];
			var $_EnScaleY:Boolean = $_obj_info["style"]["enScaleY"];
			var $_EnSkewX:Boolean = $_obj_info["style"]["enSkewX"];
			var $_EnSkewY:Boolean = $_obj_info["style"]["enSkewY"];
			var $_EnScale:Boolean = $_obj_info["style"]["enScale"];
			var $_EnRotation:Boolean = $_obj_info["style"]["enRotation"];
			var $_EnSetMidPoint:Boolean = $_obj_info["style"]["enSetMidPoint"];
			
			var $_inexistence:int = -1;

			($_obj_size0 < 10) && ($_block_size0 = $_obj_size0);
			($_obj_size1 < 10) && ($_block_size1 = $_obj_size1);
			($_obj_size0 < 8) && ($_block_size2 = $_obj_size0);
			($_obj_size1 < 8) && ($_block_size3 = $_obj_size1);
			
			var $_p_arr0:Array = new Array(
				new Point($_arr[0].x - $_block_size0, $_arr[0].y),
				new Point($_arr[0].x + $_block_size0, $_arr[0].y),
				new Point($_arr[2].x - $_block_size0, $_arr[2].y),
				new Point($_arr[2].x + $_block_size0, $_arr[2].y)
			);
			
			var $_p_arr1:Array = new Array(
				new Point($_arr[6].x - $_block_size0, $_arr[6].y),
				new Point($_arr[6].x + $_block_size0, $_arr[6].y),
				new Point($_arr[8].x - $_block_size0, $_arr[8].y),
				new Point($_arr[8].x + $_block_size0, $_arr[8].y)
			);
			
			var $_p_arr2:Array = new Array(
				new Point($_arr[0].x , $_arr[0].y - $_block_size1),
				new Point($_arr[0].x , $_arr[0].y + $_block_size1),
				new Point($_arr[6].x , $_arr[6].y - $_block_size1),
				new Point($_arr[6].x , $_arr[6].y + $_block_size1)
			);
			
			var $_p_arr3:Array = new Array(
				new Point($_arr[2].x , $_arr[2].y - $_block_size1),
				new Point($_arr[2].x , $_arr[2].y + $_block_size1),
				new Point($_arr[8].x , $_arr[8].y - $_block_size1),
				new Point($_arr[8].x , $_arr[8].y + $_block_size1)
			);
			
			var $_p_bounds:Array = new Array($_arr[0],$_arr[6],$_arr[2],$_arr[8]);
			
			var $_len:int = $_arr.length;
			while ($_len--)
			{
				$_areaPoint = $_arr[$_len];
				$_isTrue = _isInBounds.IsInRect($_testPoint, $_areaPoint, $_block_size2, $_block_size3);
				if ($_isTrue)
				{
					if (($_len == 1 || $_len == 7) && (!$_EnScaleX)) {
						return $_inexistence;
					}else if (($_len == 3 || $_len == 5) && (!$_EnScaleY)) {
						return $_inexistence;
					}else if (($_len == 0 || $_len == 6 || $_len == 2 || $_len == 8 ) && (!$_EnScale)) {
						return $_inexistence;
					}else if (($_len == 4 ) && (!$_EnSetMidPoint)) {
						return $_inexistence;
					}else{
						return $_len;
					}
				}
			}
			//----------------
			if (_isInBounds.IsInBouds($_testPoint, $_p_arr0)) 
			{
				if ($_EnSkewY){
					return 9
				}else {
					return $_inexistence;
				}
			} else if (_isInBounds.IsInBouds($_testPoint, $_p_arr1)) 
			{
				if ($_EnSkewY) {
					return 10;
				}else {
					return $_inexistence;
				}
			} else if (_isInBounds.IsInBouds($_testPoint, $_p_arr2)) 
			{
				if ($_EnSkewX) {
					return 11;
				}else {
					return $_inexistence;
				}
			} else if (_isInBounds.IsInBouds($_testPoint, $_p_arr3)) 
			{
				if ($_EnSkewX) {
					return 12 ;
				}else {
					return $_inexistence;
				}
			} else if (_isInBounds.IsInBouds($_testPoint, $_p_bounds)) 
			{
				return $_inexistence;
			}
			//----------------
			var $_isTrue0:Boolean = _isInBounds.IsInRect($_testPoint, $_arr[0], $_block_size4, $_block_size4);
			var $_isTrue1:Boolean = _isInBounds.IsInRect($_testPoint, $_arr[2], $_block_size4, $_block_size4);
			var $_isTrue2:Boolean = _isInBounds.IsInRect($_testPoint, $_arr[6], $_block_size4, $_block_size4);
			var $_isTrue3:Boolean = _isInBounds.IsInRect($_testPoint, $_arr[8], $_block_size4, $_block_size4);
			if ($_isTrue0 || $_isTrue1 || $_isTrue2 || $_isTrue3)
			{
				if ($_EnRotation) {
					return 13;
				}else {
					return $_inexistence;
				}
			}
			
			return $_inexistence;
		}
		
		private function GetArrowBmp($matrix:Object, $areanum:int):BitmapData
		{
			//   $areanum--------------
			//   [0] 11 [3] 11 [6]
			//    9			   10
			//   [1]    [4]    [7]
			//    9            10
			//   [2] 12 [5] 12 [8] [13]
			//   ----------------------
			
			var $_skewx:Number = $matrix["skewx"];
			var $_skewy:Number = $matrix["skewy"];
			var $_angle:Number;
			var $_bmp:BitmapData;
			
			if ($areanum == 4 ) 
			{
				$_bmp = _shape_arrow["Bmp_cursor"];
			}else if ( $areanum == 0 || $areanum == 8 )
			{
				$_angle = GetNearAngle(($_skewx + $_skewy )* 0.5 + 45 );
				($_angle!=-1) && ($_bmp = _shape_arrow["Bmp_resize" + $_angle]);
			}else if ($areanum == 2 || $areanum == 6 ) 
			{
				$_angle = GetNearAngle(($_skewx + $_skewy )* 0.5 + 135);
				($_angle!=-1) && ($_bmp = _shape_arrow["Bmp_resize" + $_angle]);
			}else if ($areanum == 1 || $areanum == 7 ) 
			{
				$_angle = GetNearAngle($_skewy);
				($_angle!=-1) && ($_bmp = _shape_arrow["Bmp_resize" + $_angle]);
			}else if ($areanum == 3 || $areanum == 5 ) 
			{
				$_angle = GetNearAngle($_skewx+270);
				($_angle!=-1) && ($_bmp = _shape_arrow["Bmp_resize" + $_angle]);
			}else if ($areanum == 9 || $areanum == 10 ) 
			{
				$_angle = GetNearAngle($_skewx+270);
				($_angle!=-1) && ($_bmp = _shape_arrow["Bmp_skew" + $_angle]);
			}else if ($areanum == 11 || $areanum == 12 ) 
			{
				$_angle = GetNearAngle($_skewy);
				($_angle!=-1) && ($_bmp = _shape_arrow["Bmp_skew" + $_angle]);
			}else if ($areanum == 13 ) 
			{
				$_bmp = _shape_arrow["Bmp_rotation"];
			}
			
			return $_bmp;
			
		}
		
		private function GetNearAngle($angle:Number):Number
		{
			var $_arr:Array = new Array(0, 45, 90, 135, 180);
			var $_len:int = $_arr.length;
			var $_min:Number = Number.POSITIVE_INFINITY;
			var $_gap:Number;
			var $_re_num:Number = -1;
			
			$angle = $angle % 360;
			($angle < 0) && ($angle = 360 + $angle);
			($angle > 180) && ($angle =  $angle-180);
			
			while ($_len--)
			{
				$_gap = $angle-$_arr[$_len];
				($_gap < 0) && ($_gap = -$_gap);
				if ($_min > $_gap)
				{
					$_min = $_gap;
					$_re_num = $_arr[$_len];
				}
			}
			($_re_num == 180) && ($_re_num = 0);
			return $_re_num;
			
		}
		//----------------------------------------------------------------------------
		private function ArrowMove():void
		{
			_shape_arrow.x = _container.mouseX;
			_shape_arrow.y = _container.mouseY;
		}
		private function ArrowShow($bmp:BitmapData, $isOrigin:Boolean = false):void
		{
			//var $_bmp:BitmapData = _arr_bmp[$index];
			_shape_arrow.Show($bmp,$isOrigin);
			Mouse.hide();
		}
		private function ArrowClear():void
		{
			_shape_arrow.Clear();
			Mouse.show();
		}
		//----------------------------------------------------------------------------
			
		private function FindIndex($object:DisplayObject):int 
		{
			var $_len:int=_Object_list.length;
			while ($_len--) {
				var $_object:Object=_Object_list[$_len];
				if ($_object["obj"] == $object) {
					return $_len;
				}
			}
			return -1;
		}
		
		//----------------------------------------------------------------------
		
		private function GraphicsClear():void
		{
			_shape_bounds.Clear();
		}
		
		private function GraphicsDraw($matrix:Object):void
		{
			//var $_block_size:Number = 3;
			var $_arr:Array = $matrix["array"];
			var $_len:int = $_arr.length;
			
			var $_color:uint = _type_activate["color"] == null? 0x0 : _type_activate["color"];
			var $_border:uint = _type_activate["border"] == null? 1 : _type_activate["border"];
			var $_block_size:uint = _type_activate["size"] == null? 3 : _type_activate["size"];
			var $_graphics:String = _type_activate["graphics"];
			var $_bitmapdata:BitmapData = _type_activate["bitmapdata"] == null ? _shape_arrow["Bmp_6dn"] : _type_activate["bitmapdata"];
			var $_o_graphics:String = _type_activate["o_graphics"];
			var $_o_bitmapdata:BitmapData = _type_activate["o_bitmapdata"] == null ? _shape_arrow["Bmp_6dn"] : _type_activate["o_bitmapdata"];
			
			var $_tmp_arr:Array = new Array($_arr[0], $_arr[2], $_arr[8], $_arr[6]);
			
			_shape_bounds.CreateLine($_tmp_arr,$_border,$_color);
			
			while ($_len--)
			{
				
				if ($_len != 4)
				{
					switch($_graphics)
					{
						case "rect":
							_shape_bounds.CreateRect($_arr[$_len].x-$_block_size, $_arr[$_len].y-$_block_size, $_block_size*2, $_block_size*2, $_color);
							break;
						case "circle":
							_shape_bounds.CreateCircle($_arr[$_len].x, $_arr[$_len].y, $_block_size, $_color, $_border, 0xffffff);
							break;
						case "bmp":
							_shape_bounds.FillBitmap($_bitmapdata, false, $_arr[$_len].x, $_arr[$_len].y);
							break;
						default:
							_shape_bounds.CreateRect($_arr[$_len].x - $_block_size, $_arr[$_len].y - $_block_size, $_block_size * 2, $_block_size * 2, $_color);
							break;
					}
				}
			}
			
			switch($_o_graphics)
			{
				case "rect":
					_shape_bounds.CreateRect($_arr[4].x-$_block_size, $_arr[4].y-$_block_size, $_block_size*2, $_block_size*2, $_color);
					break;
				case "circle":
					_shape_bounds.CreateCircle($_arr[4].x, $_arr[4].y, $_block_size, 0xffffff, $_border, $_color);
					break;
				case "bmp":
					_shape_bounds.FillBitmap($_o_bitmapdata, false, $_arr[4].x, $_arr[4].y);
					break;
				default:
					_shape_bounds.CreateCircle($_arr[4].x, $_arr[4].y, $_block_size, 0xffffff, $_border, $_color);
					break;
			}
			
		}
		
		private function DrawSelectGraphics($matrix:Object):void
		{
			var $_arr:Array = $matrix["array"];
			var $_len:int = $_arr.length;
			//var $_block_size:Number = 3;
			
			var $_color:uint = _type_select["color"] == null? 0xFF9900 : _type_select["color"];
			var $_border:uint = _type_select["border"] == null? 1 : _type_select["border"];
			var $_block_size:uint = _type_select["size"] == null? 3 : _type_select["size"];
			var $_graphics:String = _type_select["graphics"];
			var $_bitmapdata:BitmapData = _type_select["bitmapdata"] == null ? _shape_arrow["Bmp_6dn"] : _type_select["bitmapdata"];
			var $_o_graphics:String = _type_select["o_graphics"];
			var $_o_bitmapdata:BitmapData = _type_select["o_bitmapdata"] == null ? _shape_arrow["Bmp_6dn"] : _type_select["o_bitmapdata"];
			
			var $_tmp_arr:Array = new Array($_arr[0], $_arr[2], $_arr[8], $_arr[6]);
			
			_shape_bounds.CreateLine($_tmp_arr,$_border,$_color);
			
			while ($_len--)
			{
				
				if ($_len != 4)
				{
					//_shape_bounds.CreateRect($_arr[$_len].x-$_block_size, $_arr[$_len].y-$_block_size, $_block_size*2, $_block_size*2, $_color);
					switch($_graphics)
					{
						case "rect":
							_shape_bounds.CreateRect($_arr[$_len].x-$_block_size, $_arr[$_len].y-$_block_size, $_block_size*2, $_block_size*2, $_color);
							break;
						case "circle":
							_shape_bounds.CreateCircle($_arr[$_len].x, $_arr[$_len].y, $_block_size, $_color, $_border, 0xffffff);
							break;
						case "bmp":
							_shape_bounds.FillBitmap($_bitmapdata, false, $_arr[$_len].x, $_arr[$_len].y);
							break;
						default:
							_shape_bounds.CreateRect($_arr[$_len].x - $_block_size, $_arr[$_len].y - $_block_size, $_block_size * 2, $_block_size * 2, $_color);
							break;
					}
				}
			}
			
			switch($_o_graphics)
			{
				case "rect":
					_shape_bounds.CreateRect($_arr[4].x-$_block_size, $_arr[4].y-$_block_size, $_block_size*2, $_block_size*2, $_color);
					break;
				case "circle":
					_shape_bounds.CreateCircle($_arr[4].x, $_arr[4].y, $_block_size, 0xffffff, $_border, $_color);
					break;
				case "bmp":
					_shape_bounds.FillBitmap($_o_bitmapdata, false, $_arr[4].x, $_arr[4].y);
					break;
				default:
					_shape_bounds.CreateCircle($_arr[4].x, $_arr[4].y, $_block_size, 0xffffff, $_border, $_color);
					break;
			}
		}
		
	}
}