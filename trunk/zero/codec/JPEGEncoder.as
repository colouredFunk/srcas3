////////////////////////////////////////////////////////////////////////////////
//
//  ADOBE SYSTEMS INCORPORATED
//  Copyright 2007 Adobe Systems Incorporated
//  All Rights Reserved.
//
//  NOTICE: Adobe permits you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////

//改进 ZЁЯ¤ 2011年10月31日

package zero.codec{

import flash.display.*;
import flash.utils.*;
import flash.geom.*;

/**
 *  The JPEGEncoder class converts raw bitmap images into encoded
 *  images using Joint Photographic Experts Group (JPEG) compression.
 *
 *  For information about the JPEG algorithm, see the document
 *  http://www.opennet.ru/docs/formats/jpeg.txt by Cristi Cuturicu.
 *  
 *  @langversion 3.0
 *  @playerversion Flash 9
 *  @playerversion AIR 1.1
 *  @productversion Flex 3
 */
public class JPEGEncoder{

	//--------------------------------------------------------------------------
	//
	//  Class constants
	//
	//--------------------------------------------------------------------------

    /**
     *  @private
     */
    private static const CONTENT_TYPE:String = "image/jpeg";
	
	private static var jpegEncoderV:Vector.<JPEGEncoder>=new Vector.<JPEGEncoder>(101);

	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------

    /**
     *  Constructor.
     *
     *  @param quality A value between 0.0 and 100.0. 
     *  The smaller the <code>quality</code> value, 
     *  the smaller the file size of the resultant image. 
     *  The value does not affect the encoding speed.
     *. Note that even though this value is a number between 0.0 and 100.0, 
     *  it does not represent a percentage. 
	 *  The default value is 50.0.
     *  
     *  @langversion 3.0
     *  @playerversion Flash 9
     *  @playerversion AIR 1.1
     *  @productversion Flex 3
     */
    public function JPEGEncoder(quality:int){
    	var sf:int = 0;
        if (quality < 50.0)
            sf = int(5000 / quality);
        else
            sf = int(200 - quality * 2);

        // Create tables
        initHuffmanTbl();
        initCategoryNumber();
        initQuantTables(sf);
		
		DU=new Vector.<Number>(64);
		DU.fixed=true;
    }

	//--------------------------------------------------------------------------
	//
	//  Constants
	//
	//--------------------------------------------------------------------------

    /**
	 *  @private
	 */
    private static const std_dc_luminance_nrcodes:Vector.<int> = Vector.<int>([ 0, 0, 1, 5, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0 ]);
    
    /**
	 *  @private
	 */
	private static const std_dc_luminance_values:Vector.<int> =  Vector.<int>([ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 ]);
    
    /**
	 *  @private
	 */
    private static const std_dc_chrominance_nrcodes:Vector.<int> =  Vector.<int>([ 0, 0, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0 ]);
    
    /**
	 *  @private
	 */
	private static const std_dc_chrominance_values:Vector.<int> =  Vector.<int>([ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 ]);
    
    /**
	 *  @private
	 */
	private static const std_ac_luminance_nrcodes:Vector.<int> =  Vector.<int>([ 0, 0, 2, 1, 3, 3, 2, 4, 3, 5, 5, 4, 4, 0, 0, 1, 0x7D ]);
    
    /**
	 *  @private
	 */
	private static const std_ac_luminance_values:Vector.<int> = Vector.<int>([
        0x01, 0x02, 0x03, 0x00, 0x04, 0x11, 0x05, 0x12,
        0x21, 0x31, 0x41, 0x06, 0x13, 0x51, 0x61, 0x07,
        0x22, 0x71, 0x14, 0x32, 0x81, 0x91, 0xA1, 0x08,
        0x23, 0x42, 0xB1, 0xC1, 0x15, 0x52, 0xD1, 0xF0,
        0x24, 0x33, 0x62, 0x72, 0x82, 0x09, 0x0A, 0x16,
        0x17, 0x18, 0x19, 0x1A, 0x25, 0x26, 0x27, 0x28,
        0x29, 0x2A, 0x34, 0x35, 0x36, 0x37, 0x38, 0x39,
        0x3A, 0x43, 0x44, 0x45, 0x46, 0x47, 0x48, 0x49,
        0x4A, 0x53, 0x54, 0x55, 0x56, 0x57, 0x58, 0x59,
        0x5A, 0x63, 0x64, 0x65, 0x66, 0x67, 0x68, 0x69,
        0x6A, 0x73, 0x74, 0x75, 0x76, 0x77, 0x78, 0x79,
        0x7A, 0x83, 0x84, 0x85, 0x86, 0x87, 0x88, 0x89,
        0x8A, 0x92, 0x93, 0x94, 0x95, 0x96, 0x97, 0x98,
        0x99, 0x9A, 0xA2, 0xA3, 0xA4, 0xA5, 0xA6, 0xA7,
        0xA8, 0xA9, 0xAA, 0xB2, 0xB3, 0xB4, 0xB5, 0xB6,
        0xB7, 0xB8, 0xB9, 0xBA, 0xC2, 0xC3, 0xC4, 0xC5,
        0xC6, 0xC7, 0xC8, 0xC9, 0xCA, 0xD2, 0xD3, 0xD4,
        0xD5, 0xD6, 0xD7, 0xD8, 0xD9, 0xDA, 0xE1, 0xE2,
        0xE3, 0xE4, 0xE5, 0xE6, 0xE7, 0xE8, 0xE9, 0xEA,
        0xF1, 0xF2, 0xF3, 0xF4, 0xF5, 0xF6, 0xF7, 0xF8,
        0xF9, 0xFA
    ]);

    /**
	 *  @private
	 */
	private static const std_ac_chrominance_nrcodes:Vector.<int> = Vector.<int>([ 0, 0, 2, 1, 2, 4, 4, 3, 4, 7, 5, 4, 4, 0, 1, 2, 0x77 ]);
    
    /**
	 *  @private
	 */
	private static const std_ac_chrominance_values:Vector.<int> = Vector.<int>([
        0x00, 0x01, 0x02, 0x03, 0x11, 0x04, 0x05, 0x21,
        0x31, 0x06, 0x12, 0x41, 0x51, 0x07, 0x61, 0x71,
        0x13, 0x22, 0x32, 0x81, 0x08, 0x14, 0x42, 0x91,
        0xA1, 0xB1, 0xC1, 0x09, 0x23, 0x33, 0x52, 0xF0,
        0x15, 0x62, 0x72, 0xD1, 0x0A, 0x16, 0x24, 0x34,
        0xE1, 0x25, 0xF1, 0x17, 0x18, 0x19, 0x1A, 0x26,
        0x27, 0x28, 0x29, 0x2A, 0x35, 0x36, 0x37, 0x38,
        0x39, 0x3A, 0x43, 0x44, 0x45, 0x46, 0x47, 0x48,
        0x49, 0x4A, 0x53, 0x54, 0x55, 0x56, 0x57, 0x58,
        0x59, 0x5A, 0x63, 0x64, 0x65, 0x66, 0x67, 0x68,
        0x69, 0x6A, 0x73, 0x74, 0x75, 0x76, 0x77, 0x78,
        0x79, 0x7A, 0x82, 0x83, 0x84, 0x85, 0x86, 0x87,
        0x88, 0x89, 0x8A, 0x92, 0x93, 0x94, 0x95, 0x96,
        0x97, 0x98, 0x99, 0x9A, 0xA2, 0xA3, 0xA4, 0xA5,
        0xA6, 0xA7, 0xA8, 0xA9, 0xAA, 0xB2, 0xB3, 0xB4,
        0xB5, 0xB6, 0xB7, 0xB8, 0xB9, 0xBA, 0xC2, 0xC3,
        0xC4, 0xC5, 0xC6, 0xC7, 0xC8, 0xC9, 0xCA, 0xD2,
        0xD3, 0xD4, 0xD5, 0xD6, 0xD7, 0xD8, 0xD9, 0xDA,
        0xE2, 0xE3, 0xE4, 0xE5, 0xE6, 0xE7, 0xE8, 0xE9,
        0xEA, 0xF2, 0xF3, 0xF4, 0xF5, 0xF6, 0xF7, 0xF8,
        0xF9, 0xFA
    ]);

    /**
	 *  @private
	 */
    private static const ZigZag:Vector.<int> = Vector.<int>([
         0,  1,  5,  6, 14, 15, 27, 28,
         2,  4,  7, 13, 16, 26, 29, 42,
         3,  8, 12, 17, 25, 30, 41, 43,
         9, 11, 18, 24, 31, 40, 44, 53,
        10, 19, 23, 32, 39, 45, 52, 54,
        20, 22, 33, 38, 46, 51, 55, 60,
        21, 34, 37, 47, 50, 56, 59, 61,
        35, 36, 48, 49, 57, 58, 62, 63
    ]);
	
	private static const YQT:Vector.<int> = Vector.<int>([
		16, 11, 10, 16,  24,  40,  51,  61,
		12, 12, 14, 19,  26,  58,  60,  55,
		14, 13, 16, 24,  40,  57,  69,  56,
		14, 17, 22, 29,  51,  87,  80,  62,
		18, 22, 37, 56,  68, 109, 103,  77,
		24, 35, 55, 64,  81, 104, 113,  92,
		49, 64, 78, 87, 103, 121, 120, 101,
		72, 92, 95, 98, 112, 100, 103,  99
	]);
	
	private static const UVQT:Vector.<int> = Vector.<int>([
		17, 18, 24, 47, 99, 99, 99, 99,
		18, 21, 26, 66, 99, 99, 99, 99,
		24, 26, 56, 99, 99, 99, 99, 99,
		47, 66, 99, 99, 99, 99, 99, 99,
		99, 99, 99, 99, 99, 99, 99, 99,
		99, 99, 99, 99, 99, 99, 99, 99,
		99, 99, 99, 99, 99, 99, 99, 99,
		99, 99, 99, 99, 99, 99, 99, 99
	]);
	
	private static const aasf:Vector.<Number> = Vector.<Number>([
		1.0, 1.387039845, 1.306562965, 1.175875602,
		1.0, 0.785694958, 0.541196100, 0.275899379
	]);

	//--------------------------------------------------------------------------
	//
	//  Variables
	//
	//--------------------------------------------------------------------------

    /**
	 *  @private
	 *  Initialized by initHuffmanTbl() in constructor.
	 */
    private var YDC_HT:Vector.<int>;

    /**
	 *  @private
	 *  Initialized by initHuffmanTbl() in constructor.
	 */
    private var UVDC_HT:Vector.<int>;

    /**
	 *  @private
	 *  Initialized by initHuffmanTbl() in constructor.
	 */
    private var YAC_HT:Vector.<int>;

    /**
	 *  @private
	 *  Initialized by initHuffmanTbl() in constructor.
	 */
    private var UVAC_HT:Vector.<int>;

    /**
	 *  @private
	 *  Initialized by initCategoryNumber() in constructor.
	 */
	private var category:Vector.<int>;

    /**
	 *  @private
	 *  Initialized by initCategoryNumber() in constructor.
	 */
    private var bitcode:Vector.<int>;
    
    /**
	 *  @private
	 *  Initialized by initQuantTables() in constructor.
	 */
    private var YTable:Vector.<Number>;

    /**
	 *  @private
	 *  Initialized by initQuantTables() in constructor.
	 */
    private var UVTable:Vector.<Number>;

    /**
	 *  @private
	 *  Initialized by initQuantTables() in constructor.
	 */
    private var fdtbl_Y:Vector.<Number>;

    /**
	 *  @private
	 *  Initialized by initQuantTables() in constructor.
	 */
    private var fdtbl_UV:Vector.<Number>;

    /**
	 *  @private
	 */
    private var DU:Vector.<Number>;

	//--------------------------------------------------------------------------
	//
	//  Properties
	//
	//--------------------------------------------------------------------------

	//----------------------------------
	//  contentType
	//----------------------------------

    /**
     *  The MIME type for the JPEG encoded image. 
     *  The value is <code>"image/jpeg"</code>.
     *  
     *  @langversion 3.0
     *  @playerversion Flash 9
     *  @playerversion AIR 1.1
     *  @productversion Flex 3
     */
    public function get contentType():String
    {
        return CONTENT_TYPE;
    }
	
	public static function encode(bitmapData:BitmapData,quality:int=80):ByteArray{
		if (quality <= 0){
			quality = 1;
		}else if (quality > 100){
			quality = 100;
		}
			
		if(jpegEncoderV[quality]){
		}else{
			jpegEncoderV[quality]=new JPEGEncoder(quality);
		}
		return jpegEncoderV[quality].encode(bitmapData);
	}

	//--------------------------------------------------------------------------
	//
	//  Methods
	//
	//--------------------------------------------------------------------------

    /**
     *  Converts the pixels of BitmapData object
	 *  to a JPEG-encoded ByteArray object.
     *
     *  @param bitmapData The input BitmapData object.
     *
     *  @return Returns a ByteArray object containing JPEG-encoded image data.
     *  
     *  @langversion 3.0
     *  @playerversion Flash 9
     *  @playerversion AIR 1.1
     *  @productversion Flex 3
     */
    public function encode(bitmapData:BitmapData):ByteArray{
        return internalEncode(
			bitmapData,
			bitmapData.width,
			bitmapData.height
		);
    }

    /**
     *  Converts a ByteArray object containing raw pixels
	 *  in 32-bit ARGB (Alpha, Red, Green, Blue) format
	 *  to a new JPEG-encoded ByteArray object. 
	 *  The original ByteArray is left unchanged.
	 *  Transparency is not supported; however you still must represent
	 *  each pixel as four bytes in ARGB format.
     *
     *  @param byteArray The input ByteArray object containing raw pixels.
	 *  This ByteArray should contain
	 *  <code>4 * width * height</code> bytes.
	 *  Each pixel is represented by 4 bytes, in the order ARGB.
	 *  The first four bytes represent the top-left pixel of the image.
	 *  The next four bytes represent the pixel to its right, etc.
	 *  Each row follows the previous one without any padding.
     *
     *  @param width The width of the input image, in pixels.
     *
     *  @param height The height of the input image, in pixels.
     *
     *  @param transparent If <code>false</code>,
	 *  alpha channel information is ignored.
     *
     *  @return Returns a ByteArray object containing JPEG-encoded image data. 
     *  
     *  @langversion 3.0
     *  @playerversion Flash 9
     *  @playerversion AIR 1.1
     *  @productversion Flex 3
     */
    public function encodeByteArray(
		byteArray:ByteArray,
		width:int,
		height:int
	):ByteArray{
        return internalEncode(
			byteArray,
			width,
			height
		);
    }

	//--------------------------------------------------------------------------
	//
	//  Methods: Initialization
	//
	//--------------------------------------------------------------------------

    /**
	 *  @private
	 *  Initializes the Huffman tables YDC_HT, UVDC_HT, YAC_HT, and UVAC_HT.
	 */
    private function initHuffmanTbl():void
    {
        YDC_HT = computeHuffmanTbl(std_dc_luminance_nrcodes,
								   std_dc_luminance_values);

        UVDC_HT = computeHuffmanTbl(std_dc_chrominance_nrcodes,
									std_dc_chrominance_values);

        YAC_HT = computeHuffmanTbl(std_ac_luminance_nrcodes,
								   std_ac_luminance_values);

        UVAC_HT = computeHuffmanTbl(std_ac_chrominance_nrcodes,
									std_ac_chrominance_values);
		
	 }

    /**
	 *  @private
	 */
    private function computeHuffmanTbl(nrcodes:Vector.<int>, std_table:Vector.<int>):Vector.<int>
    {
        var codevalue:int = 0;
        var pos_in_table:int = 0;
        
		var HT:Vector.<int> = new Vector.<int>((std_table[std_table.length-1]+1)*2);
		HT.fixed=true;
        
		var bitStringId:int;
		for (var k:int = 1; k <= 16; k++)
        {
            for (var j:int = 1; j <= nrcodes[k]; j++)
            {
				bitStringId=std_table[pos_in_table]*2;
                HT[bitStringId] = codevalue;
				HT[bitStringId+1] = k;
                
				pos_in_table++;
				codevalue++;
            }

            codevalue *= 2;
        }
		
        return HT;
    }

    /**
	 *  @private
	 *  Initializes the category and bitcode arrays.
	 */
    private function initCategoryNumber():void
    {
        var nr:int;
        
		var nrlower:int = 1;
        var nrupper:int = 2;
		
		category=new Vector.<int>(65535);
		category.fixed=true;
		bitcode=new Vector.<int>(65535*2);
		bitcode.fixed=true;
		
		var bitStringId:int;
		
		for (var cat:int = 1; cat <= 15; cat++)
        {
            // Positive numbers
            for (nr = nrlower; nr < nrupper; nr++)
            {
				bitStringId=32767 + nr;
				
                category[bitStringId] = cat;
                
				bitStringId*=2;
				bitcode[bitStringId]=nr;
				bitcode[bitStringId+1]=cat;
            }

            // Negative numbers
            for (nr = -(nrupper - 1); nr <= -nrlower; nr++)
            {
				bitStringId=32767 + nr;
				
                category[bitStringId] = cat;
				
				bitStringId*=2;
				bitcode[bitStringId]=nrupper - 1 + nr;
				bitcode[bitStringId+1]=cat;
			}

            nrlower <<= 1;
            nrupper <<= 1;
        }
    }

    /**
	 *  @private
	 *  Initializes YTable, UVTable, fdtbl_Y, and fdtbl_UV.
	 */
    private function initQuantTables(sf:int):void
    {
        var i:int = 0;
        var t:Number;
		
		YTable=new Vector.<Number>(64);
		YTable.fixed=true;
        for (i = 0; i < 64; i++)
		{
            t = Math.floor((YQT[i] * sf + 50)/100);
            if (t < 1)
                t = 1;
            else if (t > 255)
                t = 255;
            YTable[ZigZag[i]] = t;
        }

		UVTable=new Vector.<Number>(64);
		UVTable.fixed=true;
        for (i = 0; i < 64; i++)
		{
            t = Math.floor((UVQT[i] * sf + 50) / 100);
            if (t < 1)
                t = 1;
            else if (t > 255)
                t = 255;
            UVTable[ZigZag[i]] = t;
        }

        i = 0;
		fdtbl_Y=new Vector.<Number>(64);
		fdtbl_Y.fixed=true;
		fdtbl_UV=new Vector.<Number>(64);
		fdtbl_UV.fixed=true;
        for (var row:int = 0; row < 8; row++)
        {
            for (var col:int = 0; col < 8; col++)
            {
                fdtbl_Y[i] =
					(1.0 / (YTable [ZigZag[i]] * aasf[row] * aasf[col] * 8.0));
                
				fdtbl_UV[i] =
					(1.0 / (UVTable[ZigZag[i]] * aasf[row] * aasf[col] * 8.0));
                
				i++;
            }
        }
    }
	
	private static function normalizeBytes(bytes:ByteArray,width:int,height:int):ByteArray{
		
		var normalizeBytes:ByteArray,i:int,lastLineBytes:ByteArray;
		
		if(width%8){
		}else{
			if(height%8){
			}else{
				return bytes;
			}
			
			normalizeBytes=new ByteArray();
			normalizeBytes.writeBytes(bytes);
			
			lastLineBytes=new ByteArray();
			lastLineBytes.writeBytes(bytes,bytes.length-width*4,width*4);
			
			i=8-(height%8);
			while(i--){
				normalizeBytes.writeBytes(lastLineBytes);
			}
			
			return normalizeBytes;
		}
		
		normalizeBytes=new ByteArray();
		var mod:int=8-(width%8);
		for(var y:int=0;y<height;y++){
			normalizeBytes.writeBytes(bytes,y*width*4,width*4);
			
			bytes.position=(y*width+width-1)*4
			var lastColor:int=bytes.readInt();
			
			i=mod;
			while(i--){
				normalizeBytes.writeInt(lastColor);
			}
		}
		
		if(height%8){
			var normalizeWidth:int=Math.ceil(width/8)*8;
			lastLineBytes=new ByteArray();
			lastLineBytes.writeBytes(normalizeBytes,normalizeBytes.length-normalizeWidth*4,normalizeWidth*4);
			
			i=8-(height%8);
			while(i--){
				normalizeBytes.writeBytes(lastLineBytes);
			}
		}
		
		return normalizeBytes;
	}
	
	private static function breakToBytes88(sourceByteArray:ByteArray,normalizeWidth:int,normalizeHeight:int):Vector.<ByteArray>{
		var bytes88V:Vector.<ByteArray>=new Vector.<ByteArray>();
		var bmd:BitmapData=new BitmapData(normalizeWidth,normalizeHeight,false,0xffffff);
		sourceByteArray.position=0;
		bmd.setPixels(bmd.rect,sourceByteArray);
		var i:int=0;
		for(var y:int=0;y<normalizeHeight;y+=8){
			for(var x:int=0;x<normalizeWidth;x+=8){
				bytes88V[i++]=bmd.getPixels(new Rectangle(x,y,8,8));
			}
		}
		bytes88V.fixed=true;
		return bytes88V;
	}

	//--------------------------------------------------------------------------
	//
	//  Methods: Core processing
	//
	//--------------------------------------------------------------------------

    /**
	 *  @private
	 */
	private function internalEncode(
		source:Object,
		width:int,
		height:int,
		transparent:Boolean = true
	):ByteArray
    {
		var t:int;
		
		t=getTimer();
		//trace("width="+width+",height="+height);
    	// The source is either a BitmapData or a ByteArray.
		var sourceByteArray:ByteArray;
		if(source is BitmapData){
			sourceByteArray = (source as BitmapData).getPixels((source as BitmapData).rect);
		}else{
			sourceByteArray = source as ByteArray;
		}
		
		trace("把 "+source+" 转换成 sourceByteArray 耗时："+(getTimer()-t)+" 毫秒");
		
		t=getTimer();
		sourceByteArray=normalizeBytes(sourceByteArray,width,height);
		trace("normalizeBytes 耗时："+(getTimer()-t)+" 毫秒");
		
		var normalizeWidth:int=Math.ceil(width/8)*8;
		var normalizeHeight:int=Math.ceil(height/8)*8;
		
		/*
		//检查 normalizeBytes 后的 BitmapData
		var bmd:BitmapData=new BitmapData(normalizeWidth,normalizeHeight,false,0xffffff);
		sourceByteArray.position=0;
		trace("normalizeWidth="+normalizeWidth);
		trace("normalizeHeight="+normalizeHeight);
		trace("sourceByteArray.length="+sourceByteArray.length);
		trace("sourceByteArray.length/normalizeWidth/4="+sourceByteArray.length/normalizeWidth/4);
		bmd.setPixels(bmd.rect,sourceByteArray);
		width=bmd.width;
		height=bmd.height;
		sourceByteArray = bmd.getPixels(bmd.rect);
		*/
		
		t=getTimer();
		var bytes88V:Vector.<ByteArray>=breakToBytes88(sourceByteArray,normalizeWidth,normalizeHeight);
		trace("breakToBytes88 耗时："+(getTimer()-t)+" 毫秒");
    	
        // Initialize bit writer
		var byteout:ByteArray = new ByteArray();
        
		var bGroupValue:int=0;
		var bGroupBitsOffset:int=32;
		
		var offset:int=0;

        // Add JPEG headers
		byteout[offset++]=0xFF;
		byteout[offset++]=0xD8;// SOI
       
		//writeAPP0
		byteout[offset++]=0xFF;
		byteout[offset++]=0xE0;	// marker
		byteout[offset++]=0;
		byteout[offset++]=16;	// length
		byteout[offset++]=0x4A;	// J
		byteout[offset++]=0x46;	// F
		byteout[offset++]=0x49;	// I
		byteout[offset++]=0x46;	// F
		byteout[offset++]=0;		// = "JFIF",'\0'
		byteout[offset++]=1;		// versionhi
		byteout[offset++]=1;		// versionlo
		byteout[offset++]=0;		// xyunits
		byteout[offset++]=0;
		byteout[offset++]=1;		// xdensity
		byteout[offset++]=0;
		byteout[offset++]=1;		// ydensity
		byteout[offset++]=0;		// thumbnwidth
		byteout[offset++]=0;		// thumbnheight
		
		//writeDQT
		byteout[offset++]=0xFF;
		byteout[offset++]=0xDB;	// marker
		byteout[offset++]=0;
		byteout[offset++]=132;     // length
		byteout[offset++]=0;
		var i:int;
		
		for (i = 0; i < 64; i++)
		{
			byteout[offset++]=YTable[i];
		}
		
		byteout[offset++]=1;
		
		for (i = 0; i < 64; i++)
		{
			byteout[offset++]=UVTable[i];
		}
        
		//writeSOF0
		byteout[offset++]=0xFF;
		byteout[offset++]=0xC0;	// marker
		byteout[offset++]=0;
		byteout[offset++]=17;		// length, truecolor YUV JPG
		byteout[offset++]=8;		// precision
		byteout[offset++]=height>>8;
		byteout[offset++]=height;
		byteout[offset++]=width>>8;
		byteout[offset++]=width;
		byteout[offset++]=3;		// nrofcomponents
		byteout[offset++]=1;		// IdY
		byteout[offset++]=0x11;	// HVY
		byteout[offset++]=0;		// QTY
		byteout[offset++]=2;		// IdU
		byteout[offset++]=0x11;	// HVU
		byteout[offset++]=1;		// QTU
		byteout[offset++]=3;		// IdV
		byteout[offset++]=0x11;	// HVV
		byteout[offset++]=1;		// QTV
       
		//writeDHT
		byteout[offset++]=0xFF;
		byteout[offset++]=0xC4; // marker
		byteout[offset++]=0x01;
		byteout[offset++]=0xA2; // length
		
		byteout[offset++]=0; // HTYDCinfo
		for (i = 0; i < 16; i++)
		{
			byteout[offset++]=std_dc_luminance_nrcodes[i + 1];
		}
		for (i = 0; i <= 11; i++)
		{
			byteout[offset++]=std_dc_luminance_values[i];
		}
		
		byteout[offset++]=0x10; // HTYACinfo
		for (i = 0; i < 16; i++)
		{
			byteout[offset++]=std_ac_luminance_nrcodes[i + 1];
		}
		for (i = 0; i <= 161; i++)
		{
			byteout[offset++]=std_ac_luminance_values[i];
		}
		
		byteout[offset++]=1; // HTUDCinfo
		for (i = 0; i < 16; i++)
		{
			byteout[offset++]=std_dc_chrominance_nrcodes[i + 1];
		}
		for (i = 0; i <= 11; i++)
		{
			byteout[offset++]=std_dc_chrominance_values[i];
		}
		
		byteout[offset++]=0x11; // HTUACinfo
		for (i = 0; i < 16; i++)
		{
			byteout[offset++]=std_ac_chrominance_nrcodes[i + 1];
		}
		for (i = 0; i <= 161; i++)
		{
			byteout[offset++]=std_ac_chrominance_values[i];
		}
		
        //writeSOS
		byteout[offset++]=0xFF;
		byteout[offset++]=0xDA;	// marker
		byteout[offset++]=0;
		byteout[offset++]=12;		// length
		byteout[offset++]=3;		// nrofcomponents
		byteout[offset++]=1;		// IdY
		byteout[offset++]=0;		// HTY
		byteout[offset++]=2;		// IdU
		byteout[offset++]=0x11;	// HTU
		byteout[offset++]=3;		// IdV
		byteout[offset++]=0x11;	// HTV
		byteout[offset++]=0;		// Ss
		byteout[offset++]=0x3f;	// Se
		byteout[offset++]=0;		// Bf

        // Encode 8x8 macroblocks
		var YUVDU:Vector.<Number>=new Vector.<Number>(64*3);
		YUVDU.fixed=true;
		
		var DCY:Number = 0;
		var DCU:Number = 0;
		var DCV:Number = 0;
		
		var bitStringId:int;
		
		var tmp0:Number;
		var tmp1:Number;
		var tmp2:Number;
		var tmp3:Number;
		var tmp4:Number;
		var tmp5:Number;
		var tmp6:Number;
		var tmp7:Number;
		var tmp10:Number;
		var tmp11:Number;
		var tmp12:Number;
		var tmp13:Number;
		
		var z1:Number;
		var z2:Number;
		var z3:Number;
		var z4:Number;
		var z5:Number;
		var z11:Number;
		var z13:Number;
		
		var Diff:int;
		var end0pos:int;
		var startpos:int;
		var nrzeroes:int;
		var nrmarker:int;
		
		for each(var bytes88:ByteArray in bytes88V){
			YUVDU[0] =  0.299 * bytes88[1] + 0.587 * bytes88[2] + 0.114 * bytes88[3] - 128;
			YUVDU[64] = -0.16874 * bytes88[1] - 0.33126 * bytes88[2] + 0.5 * bytes88[3];
			YUVDU[128] =  0.5 * bytes88[1] - 0.41869 * bytes88[2] - 0.08131 * bytes88[3];
			YUVDU[1] =  0.299 * bytes88[5] + 0.587 * bytes88[6] + 0.114 * bytes88[7] - 128;
			YUVDU[65] = -0.16874 * bytes88[5] - 0.33126 * bytes88[6] + 0.5 * bytes88[7];
			YUVDU[129] =  0.5 * bytes88[5] - 0.41869 * bytes88[6] - 0.08131 * bytes88[7];
			YUVDU[2] =  0.299 * bytes88[9] + 0.587 * bytes88[10] + 0.114 * bytes88[11] - 128;
			YUVDU[66] = -0.16874 * bytes88[9] - 0.33126 * bytes88[10] + 0.5 * bytes88[11];
			YUVDU[130] =  0.5 * bytes88[9] - 0.41869 * bytes88[10] - 0.08131 * bytes88[11];
			YUVDU[3] =  0.299 * bytes88[13] + 0.587 * bytes88[14] + 0.114 * bytes88[15] - 128;
			YUVDU[67] = -0.16874 * bytes88[13] - 0.33126 * bytes88[14] + 0.5 * bytes88[15];
			YUVDU[131] =  0.5 * bytes88[13] - 0.41869 * bytes88[14] - 0.08131 * bytes88[15];
			YUVDU[4] =  0.299 * bytes88[17] + 0.587 * bytes88[18] + 0.114 * bytes88[19] - 128;
			YUVDU[68] = -0.16874 * bytes88[17] - 0.33126 * bytes88[18] + 0.5 * bytes88[19];
			YUVDU[132] =  0.5 * bytes88[17] - 0.41869 * bytes88[18] - 0.08131 * bytes88[19];
			YUVDU[5] =  0.299 * bytes88[21] + 0.587 * bytes88[22] + 0.114 * bytes88[23] - 128;
			YUVDU[69] = -0.16874 * bytes88[21] - 0.33126 * bytes88[22] + 0.5 * bytes88[23];
			YUVDU[133] =  0.5 * bytes88[21] - 0.41869 * bytes88[22] - 0.08131 * bytes88[23];
			YUVDU[6] =  0.299 * bytes88[25] + 0.587 * bytes88[26] + 0.114 * bytes88[27] - 128;
			YUVDU[70] = -0.16874 * bytes88[25] - 0.33126 * bytes88[26] + 0.5 * bytes88[27];
			YUVDU[134] =  0.5 * bytes88[25] - 0.41869 * bytes88[26] - 0.08131 * bytes88[27];
			YUVDU[7] =  0.299 * bytes88[29] + 0.587 * bytes88[30] + 0.114 * bytes88[31] - 128;
			YUVDU[71] = -0.16874 * bytes88[29] - 0.33126 * bytes88[30] + 0.5 * bytes88[31];
			YUVDU[135] =  0.5 * bytes88[29] - 0.41869 * bytes88[30] - 0.08131 * bytes88[31];
			YUVDU[8] =  0.299 * bytes88[33] + 0.587 * bytes88[34] + 0.114 * bytes88[35] - 128;
			YUVDU[72] = -0.16874 * bytes88[33] - 0.33126 * bytes88[34] + 0.5 * bytes88[35];
			YUVDU[136] =  0.5 * bytes88[33] - 0.41869 * bytes88[34] - 0.08131 * bytes88[35];
			YUVDU[9] =  0.299 * bytes88[37] + 0.587 * bytes88[38] + 0.114 * bytes88[39] - 128;
			YUVDU[73] = -0.16874 * bytes88[37] - 0.33126 * bytes88[38] + 0.5 * bytes88[39];
			YUVDU[137] =  0.5 * bytes88[37] - 0.41869 * bytes88[38] - 0.08131 * bytes88[39];
			YUVDU[10] =  0.299 * bytes88[41] + 0.587 * bytes88[42] + 0.114 * bytes88[43] - 128;
			YUVDU[74] = -0.16874 * bytes88[41] - 0.33126 * bytes88[42] + 0.5 * bytes88[43];
			YUVDU[138] =  0.5 * bytes88[41] - 0.41869 * bytes88[42] - 0.08131 * bytes88[43];
			YUVDU[11] =  0.299 * bytes88[45] + 0.587 * bytes88[46] + 0.114 * bytes88[47] - 128;
			YUVDU[75] = -0.16874 * bytes88[45] - 0.33126 * bytes88[46] + 0.5 * bytes88[47];
			YUVDU[139] =  0.5 * bytes88[45] - 0.41869 * bytes88[46] - 0.08131 * bytes88[47];
			YUVDU[12] =  0.299 * bytes88[49] + 0.587 * bytes88[50] + 0.114 * bytes88[51] - 128;
			YUVDU[76] = -0.16874 * bytes88[49] - 0.33126 * bytes88[50] + 0.5 * bytes88[51];
			YUVDU[140] =  0.5 * bytes88[49] - 0.41869 * bytes88[50] - 0.08131 * bytes88[51];
			YUVDU[13] =  0.299 * bytes88[53] + 0.587 * bytes88[54] + 0.114 * bytes88[55] - 128;
			YUVDU[77] = -0.16874 * bytes88[53] - 0.33126 * bytes88[54] + 0.5 * bytes88[55];
			YUVDU[141] =  0.5 * bytes88[53] - 0.41869 * bytes88[54] - 0.08131 * bytes88[55];
			YUVDU[14] =  0.299 * bytes88[57] + 0.587 * bytes88[58] + 0.114 * bytes88[59] - 128;
			YUVDU[78] = -0.16874 * bytes88[57] - 0.33126 * bytes88[58] + 0.5 * bytes88[59];
			YUVDU[142] =  0.5 * bytes88[57] - 0.41869 * bytes88[58] - 0.08131 * bytes88[59];
			YUVDU[15] =  0.299 * bytes88[61] + 0.587 * bytes88[62] + 0.114 * bytes88[63] - 128;
			YUVDU[79] = -0.16874 * bytes88[61] - 0.33126 * bytes88[62] + 0.5 * bytes88[63];
			YUVDU[143] =  0.5 * bytes88[61] - 0.41869 * bytes88[62] - 0.08131 * bytes88[63];
			YUVDU[16] =  0.299 * bytes88[65] + 0.587 * bytes88[66] + 0.114 * bytes88[67] - 128;
			YUVDU[80] = -0.16874 * bytes88[65] - 0.33126 * bytes88[66] + 0.5 * bytes88[67];
			YUVDU[144] =  0.5 * bytes88[65] - 0.41869 * bytes88[66] - 0.08131 * bytes88[67];
			YUVDU[17] =  0.299 * bytes88[69] + 0.587 * bytes88[70] + 0.114 * bytes88[71] - 128;
			YUVDU[81] = -0.16874 * bytes88[69] - 0.33126 * bytes88[70] + 0.5 * bytes88[71];
			YUVDU[145] =  0.5 * bytes88[69] - 0.41869 * bytes88[70] - 0.08131 * bytes88[71];
			YUVDU[18] =  0.299 * bytes88[73] + 0.587 * bytes88[74] + 0.114 * bytes88[75] - 128;
			YUVDU[82] = -0.16874 * bytes88[73] - 0.33126 * bytes88[74] + 0.5 * bytes88[75];
			YUVDU[146] =  0.5 * bytes88[73] - 0.41869 * bytes88[74] - 0.08131 * bytes88[75];
			YUVDU[19] =  0.299 * bytes88[77] + 0.587 * bytes88[78] + 0.114 * bytes88[79] - 128;
			YUVDU[83] = -0.16874 * bytes88[77] - 0.33126 * bytes88[78] + 0.5 * bytes88[79];
			YUVDU[147] =  0.5 * bytes88[77] - 0.41869 * bytes88[78] - 0.08131 * bytes88[79];
			YUVDU[20] =  0.299 * bytes88[81] + 0.587 * bytes88[82] + 0.114 * bytes88[83] - 128;
			YUVDU[84] = -0.16874 * bytes88[81] - 0.33126 * bytes88[82] + 0.5 * bytes88[83];
			YUVDU[148] =  0.5 * bytes88[81] - 0.41869 * bytes88[82] - 0.08131 * bytes88[83];
			YUVDU[21] =  0.299 * bytes88[85] + 0.587 * bytes88[86] + 0.114 * bytes88[87] - 128;
			YUVDU[85] = -0.16874 * bytes88[85] - 0.33126 * bytes88[86] + 0.5 * bytes88[87];
			YUVDU[149] =  0.5 * bytes88[85] - 0.41869 * bytes88[86] - 0.08131 * bytes88[87];
			YUVDU[22] =  0.299 * bytes88[89] + 0.587 * bytes88[90] + 0.114 * bytes88[91] - 128;
			YUVDU[86] = -0.16874 * bytes88[89] - 0.33126 * bytes88[90] + 0.5 * bytes88[91];
			YUVDU[150] =  0.5 * bytes88[89] - 0.41869 * bytes88[90] - 0.08131 * bytes88[91];
			YUVDU[23] =  0.299 * bytes88[93] + 0.587 * bytes88[94] + 0.114 * bytes88[95] - 128;
			YUVDU[87] = -0.16874 * bytes88[93] - 0.33126 * bytes88[94] + 0.5 * bytes88[95];
			YUVDU[151] =  0.5 * bytes88[93] - 0.41869 * bytes88[94] - 0.08131 * bytes88[95];
			YUVDU[24] =  0.299 * bytes88[97] + 0.587 * bytes88[98] + 0.114 * bytes88[99] - 128;
			YUVDU[88] = -0.16874 * bytes88[97] - 0.33126 * bytes88[98] + 0.5 * bytes88[99];
			YUVDU[152] =  0.5 * bytes88[97] - 0.41869 * bytes88[98] - 0.08131 * bytes88[99];
			YUVDU[25] =  0.299 * bytes88[101] + 0.587 * bytes88[102] + 0.114 * bytes88[103] - 128;
			YUVDU[89] = -0.16874 * bytes88[101] - 0.33126 * bytes88[102] + 0.5 * bytes88[103];
			YUVDU[153] =  0.5 * bytes88[101] - 0.41869 * bytes88[102] - 0.08131 * bytes88[103];
			YUVDU[26] =  0.299 * bytes88[105] + 0.587 * bytes88[106] + 0.114 * bytes88[107] - 128;
			YUVDU[90] = -0.16874 * bytes88[105] - 0.33126 * bytes88[106] + 0.5 * bytes88[107];
			YUVDU[154] =  0.5 * bytes88[105] - 0.41869 * bytes88[106] - 0.08131 * bytes88[107];
			YUVDU[27] =  0.299 * bytes88[109] + 0.587 * bytes88[110] + 0.114 * bytes88[111] - 128;
			YUVDU[91] = -0.16874 * bytes88[109] - 0.33126 * bytes88[110] + 0.5 * bytes88[111];
			YUVDU[155] =  0.5 * bytes88[109] - 0.41869 * bytes88[110] - 0.08131 * bytes88[111];
			YUVDU[28] =  0.299 * bytes88[113] + 0.587 * bytes88[114] + 0.114 * bytes88[115] - 128;
			YUVDU[92] = -0.16874 * bytes88[113] - 0.33126 * bytes88[114] + 0.5 * bytes88[115];
			YUVDU[156] =  0.5 * bytes88[113] - 0.41869 * bytes88[114] - 0.08131 * bytes88[115];
			YUVDU[29] =  0.299 * bytes88[117] + 0.587 * bytes88[118] + 0.114 * bytes88[119] - 128;
			YUVDU[93] = -0.16874 * bytes88[117] - 0.33126 * bytes88[118] + 0.5 * bytes88[119];
			YUVDU[157] =  0.5 * bytes88[117] - 0.41869 * bytes88[118] - 0.08131 * bytes88[119];
			YUVDU[30] =  0.299 * bytes88[121] + 0.587 * bytes88[122] + 0.114 * bytes88[123] - 128;
			YUVDU[94] = -0.16874 * bytes88[121] - 0.33126 * bytes88[122] + 0.5 * bytes88[123];
			YUVDU[158] =  0.5 * bytes88[121] - 0.41869 * bytes88[122] - 0.08131 * bytes88[123];
			YUVDU[31] =  0.299 * bytes88[125] + 0.587 * bytes88[126] + 0.114 * bytes88[127] - 128;
			YUVDU[95] = -0.16874 * bytes88[125] - 0.33126 * bytes88[126] + 0.5 * bytes88[127];
			YUVDU[159] =  0.5 * bytes88[125] - 0.41869 * bytes88[126] - 0.08131 * bytes88[127];
			YUVDU[32] =  0.299 * bytes88[129] + 0.587 * bytes88[130] + 0.114 * bytes88[131] - 128;
			YUVDU[96] = -0.16874 * bytes88[129] - 0.33126 * bytes88[130] + 0.5 * bytes88[131];
			YUVDU[160] =  0.5 * bytes88[129] - 0.41869 * bytes88[130] - 0.08131 * bytes88[131];
			YUVDU[33] =  0.299 * bytes88[133] + 0.587 * bytes88[134] + 0.114 * bytes88[135] - 128;
			YUVDU[97] = -0.16874 * bytes88[133] - 0.33126 * bytes88[134] + 0.5 * bytes88[135];
			YUVDU[161] =  0.5 * bytes88[133] - 0.41869 * bytes88[134] - 0.08131 * bytes88[135];
			YUVDU[34] =  0.299 * bytes88[137] + 0.587 * bytes88[138] + 0.114 * bytes88[139] - 128;
			YUVDU[98] = -0.16874 * bytes88[137] - 0.33126 * bytes88[138] + 0.5 * bytes88[139];
			YUVDU[162] =  0.5 * bytes88[137] - 0.41869 * bytes88[138] - 0.08131 * bytes88[139];
			YUVDU[35] =  0.299 * bytes88[141] + 0.587 * bytes88[142] + 0.114 * bytes88[143] - 128;
			YUVDU[99] = -0.16874 * bytes88[141] - 0.33126 * bytes88[142] + 0.5 * bytes88[143];
			YUVDU[163] =  0.5 * bytes88[141] - 0.41869 * bytes88[142] - 0.08131 * bytes88[143];
			YUVDU[36] =  0.299 * bytes88[145] + 0.587 * bytes88[146] + 0.114 * bytes88[147] - 128;
			YUVDU[100] = -0.16874 * bytes88[145] - 0.33126 * bytes88[146] + 0.5 * bytes88[147];
			YUVDU[164] =  0.5 * bytes88[145] - 0.41869 * bytes88[146] - 0.08131 * bytes88[147];
			YUVDU[37] =  0.299 * bytes88[149] + 0.587 * bytes88[150] + 0.114 * bytes88[151] - 128;
			YUVDU[101] = -0.16874 * bytes88[149] - 0.33126 * bytes88[150] + 0.5 * bytes88[151];
			YUVDU[165] =  0.5 * bytes88[149] - 0.41869 * bytes88[150] - 0.08131 * bytes88[151];
			YUVDU[38] =  0.299 * bytes88[153] + 0.587 * bytes88[154] + 0.114 * bytes88[155] - 128;
			YUVDU[102] = -0.16874 * bytes88[153] - 0.33126 * bytes88[154] + 0.5 * bytes88[155];
			YUVDU[166] =  0.5 * bytes88[153] - 0.41869 * bytes88[154] - 0.08131 * bytes88[155];
			YUVDU[39] =  0.299 * bytes88[157] + 0.587 * bytes88[158] + 0.114 * bytes88[159] - 128;
			YUVDU[103] = -0.16874 * bytes88[157] - 0.33126 * bytes88[158] + 0.5 * bytes88[159];
			YUVDU[167] =  0.5 * bytes88[157] - 0.41869 * bytes88[158] - 0.08131 * bytes88[159];
			YUVDU[40] =  0.299 * bytes88[161] + 0.587 * bytes88[162] + 0.114 * bytes88[163] - 128;
			YUVDU[104] = -0.16874 * bytes88[161] - 0.33126 * bytes88[162] + 0.5 * bytes88[163];
			YUVDU[168] =  0.5 * bytes88[161] - 0.41869 * bytes88[162] - 0.08131 * bytes88[163];
			YUVDU[41] =  0.299 * bytes88[165] + 0.587 * bytes88[166] + 0.114 * bytes88[167] - 128;
			YUVDU[105] = -0.16874 * bytes88[165] - 0.33126 * bytes88[166] + 0.5 * bytes88[167];
			YUVDU[169] =  0.5 * bytes88[165] - 0.41869 * bytes88[166] - 0.08131 * bytes88[167];
			YUVDU[42] =  0.299 * bytes88[169] + 0.587 * bytes88[170] + 0.114 * bytes88[171] - 128;
			YUVDU[106] = -0.16874 * bytes88[169] - 0.33126 * bytes88[170] + 0.5 * bytes88[171];
			YUVDU[170] =  0.5 * bytes88[169] - 0.41869 * bytes88[170] - 0.08131 * bytes88[171];
			YUVDU[43] =  0.299 * bytes88[173] + 0.587 * bytes88[174] + 0.114 * bytes88[175] - 128;
			YUVDU[107] = -0.16874 * bytes88[173] - 0.33126 * bytes88[174] + 0.5 * bytes88[175];
			YUVDU[171] =  0.5 * bytes88[173] - 0.41869 * bytes88[174] - 0.08131 * bytes88[175];
			YUVDU[44] =  0.299 * bytes88[177] + 0.587 * bytes88[178] + 0.114 * bytes88[179] - 128;
			YUVDU[108] = -0.16874 * bytes88[177] - 0.33126 * bytes88[178] + 0.5 * bytes88[179];
			YUVDU[172] =  0.5 * bytes88[177] - 0.41869 * bytes88[178] - 0.08131 * bytes88[179];
			YUVDU[45] =  0.299 * bytes88[181] + 0.587 * bytes88[182] + 0.114 * bytes88[183] - 128;
			YUVDU[109] = -0.16874 * bytes88[181] - 0.33126 * bytes88[182] + 0.5 * bytes88[183];
			YUVDU[173] =  0.5 * bytes88[181] - 0.41869 * bytes88[182] - 0.08131 * bytes88[183];
			YUVDU[46] =  0.299 * bytes88[185] + 0.587 * bytes88[186] + 0.114 * bytes88[187] - 128;
			YUVDU[110] = -0.16874 * bytes88[185] - 0.33126 * bytes88[186] + 0.5 * bytes88[187];
			YUVDU[174] =  0.5 * bytes88[185] - 0.41869 * bytes88[186] - 0.08131 * bytes88[187];
			YUVDU[47] =  0.299 * bytes88[189] + 0.587 * bytes88[190] + 0.114 * bytes88[191] - 128;
			YUVDU[111] = -0.16874 * bytes88[189] - 0.33126 * bytes88[190] + 0.5 * bytes88[191];
			YUVDU[175] =  0.5 * bytes88[189] - 0.41869 * bytes88[190] - 0.08131 * bytes88[191];
			YUVDU[48] =  0.299 * bytes88[193] + 0.587 * bytes88[194] + 0.114 * bytes88[195] - 128;
			YUVDU[112] = -0.16874 * bytes88[193] - 0.33126 * bytes88[194] + 0.5 * bytes88[195];
			YUVDU[176] =  0.5 * bytes88[193] - 0.41869 * bytes88[194] - 0.08131 * bytes88[195];
			YUVDU[49] =  0.299 * bytes88[197] + 0.587 * bytes88[198] + 0.114 * bytes88[199] - 128;
			YUVDU[113] = -0.16874 * bytes88[197] - 0.33126 * bytes88[198] + 0.5 * bytes88[199];
			YUVDU[177] =  0.5 * bytes88[197] - 0.41869 * bytes88[198] - 0.08131 * bytes88[199];
			YUVDU[50] =  0.299 * bytes88[201] + 0.587 * bytes88[202] + 0.114 * bytes88[203] - 128;
			YUVDU[114] = -0.16874 * bytes88[201] - 0.33126 * bytes88[202] + 0.5 * bytes88[203];
			YUVDU[178] =  0.5 * bytes88[201] - 0.41869 * bytes88[202] - 0.08131 * bytes88[203];
			YUVDU[51] =  0.299 * bytes88[205] + 0.587 * bytes88[206] + 0.114 * bytes88[207] - 128;
			YUVDU[115] = -0.16874 * bytes88[205] - 0.33126 * bytes88[206] + 0.5 * bytes88[207];
			YUVDU[179] =  0.5 * bytes88[205] - 0.41869 * bytes88[206] - 0.08131 * bytes88[207];
			YUVDU[52] =  0.299 * bytes88[209] + 0.587 * bytes88[210] + 0.114 * bytes88[211] - 128;
			YUVDU[116] = -0.16874 * bytes88[209] - 0.33126 * bytes88[210] + 0.5 * bytes88[211];
			YUVDU[180] =  0.5 * bytes88[209] - 0.41869 * bytes88[210] - 0.08131 * bytes88[211];
			YUVDU[53] =  0.299 * bytes88[213] + 0.587 * bytes88[214] + 0.114 * bytes88[215] - 128;
			YUVDU[117] = -0.16874 * bytes88[213] - 0.33126 * bytes88[214] + 0.5 * bytes88[215];
			YUVDU[181] =  0.5 * bytes88[213] - 0.41869 * bytes88[214] - 0.08131 * bytes88[215];
			YUVDU[54] =  0.299 * bytes88[217] + 0.587 * bytes88[218] + 0.114 * bytes88[219] - 128;
			YUVDU[118] = -0.16874 * bytes88[217] - 0.33126 * bytes88[218] + 0.5 * bytes88[219];
			YUVDU[182] =  0.5 * bytes88[217] - 0.41869 * bytes88[218] - 0.08131 * bytes88[219];
			YUVDU[55] =  0.299 * bytes88[221] + 0.587 * bytes88[222] + 0.114 * bytes88[223] - 128;
			YUVDU[119] = -0.16874 * bytes88[221] - 0.33126 * bytes88[222] + 0.5 * bytes88[223];
			YUVDU[183] =  0.5 * bytes88[221] - 0.41869 * bytes88[222] - 0.08131 * bytes88[223];
			YUVDU[56] =  0.299 * bytes88[225] + 0.587 * bytes88[226] + 0.114 * bytes88[227] - 128;
			YUVDU[120] = -0.16874 * bytes88[225] - 0.33126 * bytes88[226] + 0.5 * bytes88[227];
			YUVDU[184] =  0.5 * bytes88[225] - 0.41869 * bytes88[226] - 0.08131 * bytes88[227];
			YUVDU[57] =  0.299 * bytes88[229] + 0.587 * bytes88[230] + 0.114 * bytes88[231] - 128;
			YUVDU[121] = -0.16874 * bytes88[229] - 0.33126 * bytes88[230] + 0.5 * bytes88[231];
			YUVDU[185] =  0.5 * bytes88[229] - 0.41869 * bytes88[230] - 0.08131 * bytes88[231];
			YUVDU[58] =  0.299 * bytes88[233] + 0.587 * bytes88[234] + 0.114 * bytes88[235] - 128;
			YUVDU[122] = -0.16874 * bytes88[233] - 0.33126 * bytes88[234] + 0.5 * bytes88[235];
			YUVDU[186] =  0.5 * bytes88[233] - 0.41869 * bytes88[234] - 0.08131 * bytes88[235];
			YUVDU[59] =  0.299 * bytes88[237] + 0.587 * bytes88[238] + 0.114 * bytes88[239] - 128;
			YUVDU[123] = -0.16874 * bytes88[237] - 0.33126 * bytes88[238] + 0.5 * bytes88[239];
			YUVDU[187] =  0.5 * bytes88[237] - 0.41869 * bytes88[238] - 0.08131 * bytes88[239];
			YUVDU[60] =  0.299 * bytes88[241] + 0.587 * bytes88[242] + 0.114 * bytes88[243] - 128;
			YUVDU[124] = -0.16874 * bytes88[241] - 0.33126 * bytes88[242] + 0.5 * bytes88[243];
			YUVDU[188] =  0.5 * bytes88[241] - 0.41869 * bytes88[242] - 0.08131 * bytes88[243];
			YUVDU[61] =  0.299 * bytes88[245] + 0.587 * bytes88[246] + 0.114 * bytes88[247] - 128;
			YUVDU[125] = -0.16874 * bytes88[245] - 0.33126 * bytes88[246] + 0.5 * bytes88[247];
			YUVDU[189] =  0.5 * bytes88[245] - 0.41869 * bytes88[246] - 0.08131 * bytes88[247];
			YUVDU[62] =  0.299 * bytes88[249] + 0.587 * bytes88[250] + 0.114 * bytes88[251] - 128;
			YUVDU[126] = -0.16874 * bytes88[249] - 0.33126 * bytes88[250] + 0.5 * bytes88[251];
			YUVDU[190] =  0.5 * bytes88[249] - 0.41869 * bytes88[250] - 0.08131 * bytes88[251];
			YUVDU[63] =  0.299 * bytes88[253] + 0.587 * bytes88[254] + 0.114 * bytes88[255] - 128;
			YUVDU[127] = -0.16874 * bytes88[253] - 0.33126 * bytes88[254] + 0.5 * bytes88[255];
			YUVDU[191] =  0.5 * bytes88[253] - 0.41869 * bytes88[254] - 0.08131 * bytes88[255];
			
			//processDU(YDU, fdtbl_Y, DCY, YDC_HT, YAC_HT,processObj);
			
			// Pass 1: process rows.
			tmp0 = YUVDU[0] + YUVDU[7];tmp7 = YUVDU[0] - YUVDU[7];tmp1 = YUVDU[1] + YUVDU[6];tmp6 = YUVDU[1] - YUVDU[6];tmp2 = YUVDU[2] + YUVDU[5];tmp5 = YUVDU[2] - YUVDU[5];tmp3 = YUVDU[3] + YUVDU[4];tmp4 = YUVDU[3] - YUVDU[4];
			tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
			YUVDU[0] = tmp10 + tmp11;YUVDU[4] = tmp10 - tmp11;
			z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
			YUVDU[2] = tmp13 + z1;YUVDU[6] = tmp13 - z1;
			tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
			z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
			z11 = tmp7 + z3;z13 = tmp7 - z3;
			YUVDU[5] = z13 + z2;YUVDU[3] = z13 - z2;YUVDU[1] = z11 + z4;YUVDU[7] = z11 - z4;
			
			tmp0 = YUVDU[8] + YUVDU[15];tmp7 = YUVDU[8] - YUVDU[15];tmp1 = YUVDU[9] + YUVDU[14];tmp6 = YUVDU[9] - YUVDU[14];tmp2 = YUVDU[10] + YUVDU[13];tmp5 = YUVDU[10] - YUVDU[13];tmp3 = YUVDU[11] + YUVDU[12];tmp4 = YUVDU[11] - YUVDU[12];
			tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
			YUVDU[8] = tmp10 + tmp11;YUVDU[12] = tmp10 - tmp11;
			z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
			YUVDU[10] = tmp13 + z1;YUVDU[14] = tmp13 - z1;
			tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
			z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
			z11 = tmp7 + z3;z13 = tmp7 - z3;
			YUVDU[13] = z13 + z2;YUVDU[11] = z13 - z2;YUVDU[9] = z11 + z4;YUVDU[15] = z11 - z4;
			
			tmp0 = YUVDU[16] + YUVDU[23];tmp7 = YUVDU[16] - YUVDU[23];tmp1 = YUVDU[17] + YUVDU[22];tmp6 = YUVDU[17] - YUVDU[22];tmp2 = YUVDU[18] + YUVDU[21];tmp5 = YUVDU[18] - YUVDU[21];tmp3 = YUVDU[19] + YUVDU[20];tmp4 = YUVDU[19] - YUVDU[20];
			tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
			YUVDU[16] = tmp10 + tmp11;YUVDU[20] = tmp10 - tmp11;
			z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
			YUVDU[18] = tmp13 + z1;YUVDU[22] = tmp13 - z1;
			tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
			z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
			z11 = tmp7 + z3;z13 = tmp7 - z3;
			YUVDU[21] = z13 + z2;YUVDU[19] = z13 - z2;YUVDU[17] = z11 + z4;YUVDU[23] = z11 - z4;
			
			tmp0 = YUVDU[24] + YUVDU[31];tmp7 = YUVDU[24] - YUVDU[31];tmp1 = YUVDU[25] + YUVDU[30];tmp6 = YUVDU[25] - YUVDU[30];tmp2 = YUVDU[26] + YUVDU[29];tmp5 = YUVDU[26] - YUVDU[29];tmp3 = YUVDU[27] + YUVDU[28];tmp4 = YUVDU[27] - YUVDU[28];
			tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
			YUVDU[24] = tmp10 + tmp11;YUVDU[28] = tmp10 - tmp11;
			z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
			YUVDU[26] = tmp13 + z1;YUVDU[30] = tmp13 - z1;
			tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
			z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
			z11 = tmp7 + z3;z13 = tmp7 - z3;
			YUVDU[29] = z13 + z2;YUVDU[27] = z13 - z2;YUVDU[25] = z11 + z4;YUVDU[31] = z11 - z4;
			
			tmp0 = YUVDU[32] + YUVDU[39];tmp7 = YUVDU[32] - YUVDU[39];tmp1 = YUVDU[33] + YUVDU[38];tmp6 = YUVDU[33] - YUVDU[38];tmp2 = YUVDU[34] + YUVDU[37];tmp5 = YUVDU[34] - YUVDU[37];tmp3 = YUVDU[35] + YUVDU[36];tmp4 = YUVDU[35] - YUVDU[36];
			tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
			YUVDU[32] = tmp10 + tmp11;YUVDU[36] = tmp10 - tmp11;
			z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
			YUVDU[34] = tmp13 + z1;YUVDU[38] = tmp13 - z1;
			tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
			z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
			z11 = tmp7 + z3;z13 = tmp7 - z3;
			YUVDU[37] = z13 + z2;YUVDU[35] = z13 - z2;YUVDU[33] = z11 + z4;YUVDU[39] = z11 - z4;
			
			tmp0 = YUVDU[40] + YUVDU[47];tmp7 = YUVDU[40] - YUVDU[47];tmp1 = YUVDU[41] + YUVDU[46];tmp6 = YUVDU[41] - YUVDU[46];tmp2 = YUVDU[42] + YUVDU[45];tmp5 = YUVDU[42] - YUVDU[45];tmp3 = YUVDU[43] + YUVDU[44];tmp4 = YUVDU[43] - YUVDU[44];
			tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
			YUVDU[40] = tmp10 + tmp11;YUVDU[44] = tmp10 - tmp11;
			z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
			YUVDU[42] = tmp13 + z1;YUVDU[46] = tmp13 - z1;
			tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
			z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
			z11 = tmp7 + z3;z13 = tmp7 - z3;
			YUVDU[45] = z13 + z2;YUVDU[43] = z13 - z2;YUVDU[41] = z11 + z4;YUVDU[47] = z11 - z4;
			
			tmp0 = YUVDU[48] + YUVDU[55];tmp7 = YUVDU[48] - YUVDU[55];tmp1 = YUVDU[49] + YUVDU[54];tmp6 = YUVDU[49] - YUVDU[54];tmp2 = YUVDU[50] + YUVDU[53];tmp5 = YUVDU[50] - YUVDU[53];tmp3 = YUVDU[51] + YUVDU[52];tmp4 = YUVDU[51] - YUVDU[52];
			tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
			YUVDU[48] = tmp10 + tmp11;YUVDU[52] = tmp10 - tmp11;
			z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
			YUVDU[50] = tmp13 + z1;YUVDU[54] = tmp13 - z1;
			tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
			z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
			z11 = tmp7 + z3;z13 = tmp7 - z3;
			YUVDU[53] = z13 + z2;YUVDU[51] = z13 - z2;YUVDU[49] = z11 + z4;YUVDU[55] = z11 - z4;
			
			tmp0 = YUVDU[56] + YUVDU[63];tmp7 = YUVDU[56] - YUVDU[63];tmp1 = YUVDU[57] + YUVDU[62];tmp6 = YUVDU[57] - YUVDU[62];tmp2 = YUVDU[58] + YUVDU[61];tmp5 = YUVDU[58] - YUVDU[61];tmp3 = YUVDU[59] + YUVDU[60];tmp4 = YUVDU[59] - YUVDU[60];
			tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
			YUVDU[56] = tmp10 + tmp11;YUVDU[60] = tmp10 - tmp11;
			z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
			YUVDU[58] = tmp13 + z1;YUVDU[62] = tmp13 - z1;
			tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
			z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
			z11 = tmp7 + z3;z13 = tmp7 - z3;
			YUVDU[61] = z13 + z2;YUVDU[59] = z13 - z2;YUVDU[57] = z11 + z4;YUVDU[63] = z11 - z4;
			
			// Pass 2: process columns.
			tmp0 = YUVDU[0] + YUVDU[56];tmp7 = YUVDU[0] - YUVDU[56];tmp1 = YUVDU[8] + YUVDU[48];tmp6 = YUVDU[8] - YUVDU[48];tmp2 = YUVDU[16] + YUVDU[40];tmp5 = YUVDU[16] - YUVDU[40];tmp3 = YUVDU[24] + YUVDU[32];tmp4 = YUVDU[24] - YUVDU[32];
			tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
			YUVDU[0] = tmp10 + tmp11;YUVDU[32] = tmp10 - tmp11;
			z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
			YUVDU[16] = tmp13 + z1;YUVDU[48] = tmp13 - z1;
			tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
			z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
			z11 = tmp7 + z3;z13 = tmp7 - z3;
			YUVDU[40] = z13 + z2;YUVDU[24] = z13 - z2;YUVDU[8] = z11 + z4;YUVDU[56] = z11 - z4;
			
			tmp0 = YUVDU[1] + YUVDU[57];tmp7 = YUVDU[1] - YUVDU[57];tmp1 = YUVDU[9] + YUVDU[49];tmp6 = YUVDU[9] - YUVDU[49];tmp2 = YUVDU[17] + YUVDU[41];tmp5 = YUVDU[17] - YUVDU[41];tmp3 = YUVDU[25] + YUVDU[33];tmp4 = YUVDU[25] - YUVDU[33];
			tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
			YUVDU[1] = tmp10 + tmp11;YUVDU[33] = tmp10 - tmp11;
			z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
			YUVDU[17] = tmp13 + z1;YUVDU[49] = tmp13 - z1;
			tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
			z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
			z11 = tmp7 + z3;z13 = tmp7 - z3;
			YUVDU[41] = z13 + z2;YUVDU[25] = z13 - z2;YUVDU[9] = z11 + z4;YUVDU[57] = z11 - z4;
			
			tmp0 = YUVDU[2] + YUVDU[58];tmp7 = YUVDU[2] - YUVDU[58];tmp1 = YUVDU[10] + YUVDU[50];tmp6 = YUVDU[10] - YUVDU[50];tmp2 = YUVDU[18] + YUVDU[42];tmp5 = YUVDU[18] - YUVDU[42];tmp3 = YUVDU[26] + YUVDU[34];tmp4 = YUVDU[26] - YUVDU[34];
			tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
			YUVDU[2] = tmp10 + tmp11;YUVDU[34] = tmp10 - tmp11;
			z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
			YUVDU[18] = tmp13 + z1;YUVDU[50] = tmp13 - z1;
			tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
			z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
			z11 = tmp7 + z3;z13 = tmp7 - z3;
			YUVDU[42] = z13 + z2;YUVDU[26] = z13 - z2;YUVDU[10] = z11 + z4;YUVDU[58] = z11 - z4;
			
			tmp0 = YUVDU[3] + YUVDU[59];tmp7 = YUVDU[3] - YUVDU[59];tmp1 = YUVDU[11] + YUVDU[51];tmp6 = YUVDU[11] - YUVDU[51];tmp2 = YUVDU[19] + YUVDU[43];tmp5 = YUVDU[19] - YUVDU[43];tmp3 = YUVDU[27] + YUVDU[35];tmp4 = YUVDU[27] - YUVDU[35];
			tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
			YUVDU[3] = tmp10 + tmp11;YUVDU[35] = tmp10 - tmp11;
			z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
			YUVDU[19] = tmp13 + z1;YUVDU[51] = tmp13 - z1;
			tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
			z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
			z11 = tmp7 + z3;z13 = tmp7 - z3;
			YUVDU[43] = z13 + z2;YUVDU[27] = z13 - z2;YUVDU[11] = z11 + z4;YUVDU[59] = z11 - z4;
			
			tmp0 = YUVDU[4] + YUVDU[60];tmp7 = YUVDU[4] - YUVDU[60];tmp1 = YUVDU[12] + YUVDU[52];tmp6 = YUVDU[12] - YUVDU[52];tmp2 = YUVDU[20] + YUVDU[44];tmp5 = YUVDU[20] - YUVDU[44];tmp3 = YUVDU[28] + YUVDU[36];tmp4 = YUVDU[28] - YUVDU[36];
			tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
			YUVDU[4] = tmp10 + tmp11;YUVDU[36] = tmp10 - tmp11;
			z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
			YUVDU[20] = tmp13 + z1;YUVDU[52] = tmp13 - z1;
			tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
			z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
			z11 = tmp7 + z3;z13 = tmp7 - z3;
			YUVDU[44] = z13 + z2;YUVDU[28] = z13 - z2;YUVDU[12] = z11 + z4;YUVDU[60] = z11 - z4;
			
			tmp0 = YUVDU[5] + YUVDU[61];tmp7 = YUVDU[5] - YUVDU[61];tmp1 = YUVDU[13] + YUVDU[53];tmp6 = YUVDU[13] - YUVDU[53];tmp2 = YUVDU[21] + YUVDU[45];tmp5 = YUVDU[21] - YUVDU[45];tmp3 = YUVDU[29] + YUVDU[37];tmp4 = YUVDU[29] - YUVDU[37];
			tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
			YUVDU[5] = tmp10 + tmp11;YUVDU[37] = tmp10 - tmp11;
			z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
			YUVDU[21] = tmp13 + z1;YUVDU[53] = tmp13 - z1;
			tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
			z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
			z11 = tmp7 + z3;z13 = tmp7 - z3;
			YUVDU[45] = z13 + z2;YUVDU[29] = z13 - z2;YUVDU[13] = z11 + z4;YUVDU[61] = z11 - z4;
			
			tmp0 = YUVDU[6] + YUVDU[62];tmp7 = YUVDU[6] - YUVDU[62];tmp1 = YUVDU[14] + YUVDU[54];tmp6 = YUVDU[14] - YUVDU[54];tmp2 = YUVDU[22] + YUVDU[46];tmp5 = YUVDU[22] - YUVDU[46];tmp3 = YUVDU[30] + YUVDU[38];tmp4 = YUVDU[30] - YUVDU[38];
			tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
			YUVDU[6] = tmp10 + tmp11;YUVDU[38] = tmp10 - tmp11;
			z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
			YUVDU[22] = tmp13 + z1;YUVDU[54] = tmp13 - z1;
			tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
			z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
			z11 = tmp7 + z3;z13 = tmp7 - z3;
			YUVDU[46] = z13 + z2;YUVDU[30] = z13 - z2;YUVDU[14] = z11 + z4;YUVDU[62] = z11 - z4;
			
			tmp0 = YUVDU[7] + YUVDU[63];tmp7 = YUVDU[7] - YUVDU[63];tmp1 = YUVDU[15] + YUVDU[55];tmp6 = YUVDU[15] - YUVDU[55];tmp2 = YUVDU[23] + YUVDU[47];tmp5 = YUVDU[23] - YUVDU[47];tmp3 = YUVDU[31] + YUVDU[39];tmp4 = YUVDU[31] - YUVDU[39];
			tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
			YUVDU[7] = tmp10 + tmp11;YUVDU[39] = tmp10 - tmp11;
			z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
			YUVDU[23] = tmp13 + z1;YUVDU[55] = tmp13 - z1;
			tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
			z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
			z11 = tmp7 + z3;z13 = tmp7 - z3;
			YUVDU[47] = z13 + z2;YUVDU[31] = z13 - z2;YUVDU[15] = z11 + z4;YUVDU[63] = z11 - z4;
			
			// Quantize/descale the coefficients
			// Apply the quantization and scaling factor
			// and round to nearest integer
			//for(i=0;i<64;i++){YDU[i] = Math.round((YDU[i] * fdtbl_Y[i]));}
			YUVDU[0] = Math.round((YUVDU[0] * fdtbl_Y[0]));YUVDU[1] = Math.round((YUVDU[1] * fdtbl_Y[1]));YUVDU[2] = Math.round((YUVDU[2] * fdtbl_Y[2]));YUVDU[3] = Math.round((YUVDU[3] * fdtbl_Y[3]));YUVDU[4] = Math.round((YUVDU[4] * fdtbl_Y[4]));YUVDU[5] = Math.round((YUVDU[5] * fdtbl_Y[5]));YUVDU[6] = Math.round((YUVDU[6] * fdtbl_Y[6]));YUVDU[7] = Math.round((YUVDU[7] * fdtbl_Y[7]));YUVDU[8] = Math.round((YUVDU[8] * fdtbl_Y[8]));YUVDU[9] = Math.round((YUVDU[9] * fdtbl_Y[9]));YUVDU[10] = Math.round((YUVDU[10] * fdtbl_Y[10]));YUVDU[11] = Math.round((YUVDU[11] * fdtbl_Y[11]));YUVDU[12] = Math.round((YUVDU[12] * fdtbl_Y[12]));YUVDU[13] = Math.round((YUVDU[13] * fdtbl_Y[13]));YUVDU[14] = Math.round((YUVDU[14] * fdtbl_Y[14]));YUVDU[15] = Math.round((YUVDU[15] * fdtbl_Y[15]));YUVDU[16] = Math.round((YUVDU[16] * fdtbl_Y[16]));YUVDU[17] = Math.round((YUVDU[17] * fdtbl_Y[17]));YUVDU[18] = Math.round((YUVDU[18] * fdtbl_Y[18]));YUVDU[19] = Math.round((YUVDU[19] * fdtbl_Y[19]));YUVDU[20] = Math.round((YUVDU[20] * fdtbl_Y[20]));YUVDU[21] = Math.round((YUVDU[21] * fdtbl_Y[21]));YUVDU[22] = Math.round((YUVDU[22] * fdtbl_Y[22]));YUVDU[23] = Math.round((YUVDU[23] * fdtbl_Y[23]));YUVDU[24] = Math.round((YUVDU[24] * fdtbl_Y[24]));YUVDU[25] = Math.round((YUVDU[25] * fdtbl_Y[25]));YUVDU[26] = Math.round((YUVDU[26] * fdtbl_Y[26]));YUVDU[27] = Math.round((YUVDU[27] * fdtbl_Y[27]));YUVDU[28] = Math.round((YUVDU[28] * fdtbl_Y[28]));YUVDU[29] = Math.round((YUVDU[29] * fdtbl_Y[29]));YUVDU[30] = Math.round((YUVDU[30] * fdtbl_Y[30]));YUVDU[31] = Math.round((YUVDU[31] * fdtbl_Y[31]));YUVDU[32] = Math.round((YUVDU[32] * fdtbl_Y[32]));YUVDU[33] = Math.round((YUVDU[33] * fdtbl_Y[33]));YUVDU[34] = Math.round((YUVDU[34] * fdtbl_Y[34]));YUVDU[35] = Math.round((YUVDU[35] * fdtbl_Y[35]));YUVDU[36] = Math.round((YUVDU[36] * fdtbl_Y[36]));YUVDU[37] = Math.round((YUVDU[37] * fdtbl_Y[37]));YUVDU[38] = Math.round((YUVDU[38] * fdtbl_Y[38]));YUVDU[39] = Math.round((YUVDU[39] * fdtbl_Y[39]));YUVDU[40] = Math.round((YUVDU[40] * fdtbl_Y[40]));YUVDU[41] = Math.round((YUVDU[41] * fdtbl_Y[41]));YUVDU[42] = Math.round((YUVDU[42] * fdtbl_Y[42]));YUVDU[43] = Math.round((YUVDU[43] * fdtbl_Y[43]));YUVDU[44] = Math.round((YUVDU[44] * fdtbl_Y[44]));YUVDU[45] = Math.round((YUVDU[45] * fdtbl_Y[45]));YUVDU[46] = Math.round((YUVDU[46] * fdtbl_Y[46]));YUVDU[47] = Math.round((YUVDU[47] * fdtbl_Y[47]));YUVDU[48] = Math.round((YUVDU[48] * fdtbl_Y[48]));YUVDU[49] = Math.round((YUVDU[49] * fdtbl_Y[49]));YUVDU[50] = Math.round((YUVDU[50] * fdtbl_Y[50]));YUVDU[51] = Math.round((YUVDU[51] * fdtbl_Y[51]));YUVDU[52] = Math.round((YUVDU[52] * fdtbl_Y[52]));YUVDU[53] = Math.round((YUVDU[53] * fdtbl_Y[53]));YUVDU[54] = Math.round((YUVDU[54] * fdtbl_Y[54]));YUVDU[55] = Math.round((YUVDU[55] * fdtbl_Y[55]));YUVDU[56] = Math.round((YUVDU[56] * fdtbl_Y[56]));YUVDU[57] = Math.round((YUVDU[57] * fdtbl_Y[57]));YUVDU[58] = Math.round((YUVDU[58] * fdtbl_Y[58]));YUVDU[59] = Math.round((YUVDU[59] * fdtbl_Y[59]));YUVDU[60] = Math.round((YUVDU[60] * fdtbl_Y[60]));YUVDU[61] = Math.round((YUVDU[61] * fdtbl_Y[61]));YUVDU[62] = Math.round((YUVDU[62] * fdtbl_Y[62]));YUVDU[63] = Math.round((YUVDU[63] * fdtbl_Y[63]));
			
			// ZigZag reorder
			//for(i=0;i<64;i++){DU[ZigZag[i]] = YDU[i];}
			DU[ZigZag[0]] = YUVDU[0];DU[ZigZag[1]] = YUVDU[1];DU[ZigZag[2]] = YUVDU[2];DU[ZigZag[3]] = YUVDU[3];DU[ZigZag[4]] = YUVDU[4];DU[ZigZag[5]] = YUVDU[5];DU[ZigZag[6]] = YUVDU[6];DU[ZigZag[7]] = YUVDU[7];DU[ZigZag[8]] = YUVDU[8];DU[ZigZag[9]] = YUVDU[9];DU[ZigZag[10]] = YUVDU[10];DU[ZigZag[11]] = YUVDU[11];DU[ZigZag[12]] = YUVDU[12];DU[ZigZag[13]] = YUVDU[13];DU[ZigZag[14]] = YUVDU[14];DU[ZigZag[15]] = YUVDU[15];DU[ZigZag[16]] = YUVDU[16];DU[ZigZag[17]] = YUVDU[17];DU[ZigZag[18]] = YUVDU[18];DU[ZigZag[19]] = YUVDU[19];DU[ZigZag[20]] = YUVDU[20];DU[ZigZag[21]] = YUVDU[21];DU[ZigZag[22]] = YUVDU[22];DU[ZigZag[23]] = YUVDU[23];DU[ZigZag[24]] = YUVDU[24];DU[ZigZag[25]] = YUVDU[25];DU[ZigZag[26]] = YUVDU[26];DU[ZigZag[27]] = YUVDU[27];DU[ZigZag[28]] = YUVDU[28];DU[ZigZag[29]] = YUVDU[29];DU[ZigZag[30]] = YUVDU[30];DU[ZigZag[31]] = YUVDU[31];DU[ZigZag[32]] = YUVDU[32];DU[ZigZag[33]] = YUVDU[33];DU[ZigZag[34]] = YUVDU[34];DU[ZigZag[35]] = YUVDU[35];DU[ZigZag[36]] = YUVDU[36];DU[ZigZag[37]] = YUVDU[37];DU[ZigZag[38]] = YUVDU[38];DU[ZigZag[39]] = YUVDU[39];DU[ZigZag[40]] = YUVDU[40];DU[ZigZag[41]] = YUVDU[41];DU[ZigZag[42]] = YUVDU[42];DU[ZigZag[43]] = YUVDU[43];DU[ZigZag[44]] = YUVDU[44];DU[ZigZag[45]] = YUVDU[45];DU[ZigZag[46]] = YUVDU[46];DU[ZigZag[47]] = YUVDU[47];DU[ZigZag[48]] = YUVDU[48];DU[ZigZag[49]] = YUVDU[49];DU[ZigZag[50]] = YUVDU[50];DU[ZigZag[51]] = YUVDU[51];DU[ZigZag[52]] = YUVDU[52];DU[ZigZag[53]] = YUVDU[53];DU[ZigZag[54]] = YUVDU[54];DU[ZigZag[55]] = YUVDU[55];DU[ZigZag[56]] = YUVDU[56];DU[ZigZag[57]] = YUVDU[57];DU[ZigZag[58]] = YUVDU[58];DU[ZigZag[59]] = YUVDU[59];DU[ZigZag[60]] = YUVDU[60];DU[ZigZag[61]] = YUVDU[61];DU[ZigZag[62]] = YUVDU[62];DU[ZigZag[63]] = YUVDU[63];
			
			Diff = DU[0] - DCY;
			DCY = DU[0];
			
			// Encode DCY
			if(Diff){// Diff might be 0
				bitStringId=category[32767 + Diff]*2;
				bGroupBitsOffset-=YDC_HT[bitStringId+1];
				bGroupValue|=YDC_HT[bitStringId]<<bGroupBitsOffset;
				//向 data 写入满8位(1字节)的数据:
				while(bGroupBitsOffset<24){byteout[offset++]=bGroupValue>>>24;if((bGroupValue>>>24)==0xff){byteout[offset++]=0x00;}bGroupValue<<=8;bGroupBitsOffset+=8;}
				
				bitStringId=(32767 + Diff)*2;
				bGroupBitsOffset-=bitcode[bitStringId+1];
				bGroupValue|=bitcode[bitStringId]<<bGroupBitsOffset;
				//向 data 写入满8位(1字节)的数据:
				while(bGroupBitsOffset<24){byteout[offset++]=bGroupValue>>>24;if((bGroupValue>>>24)==0xff){byteout[offset++]=0x00;}bGroupValue<<=8;bGroupBitsOffset+=8;}
			}else{
				bGroupBitsOffset-=YDC_HT[1];
				bGroupValue|=YDC_HT[0]<<bGroupBitsOffset;
				//向 data 写入满8位(1字节)的数据:
				while(bGroupBitsOffset<24){byteout[offset++]=bGroupValue>>>24;if((bGroupValue>>>24)==0xff){byteout[offset++]=0x00;}bGroupValue<<=8;bGroupBitsOffset+=8;}
			}
			
			// Encode ACs
			//var end0pos:int=64;
			//for (; (end0pos > 0) && (DU[end0pos] == 0); end0pos--){};
			if(DU[63]){end0pos=63;}else{if(DU[62]){end0pos=62;}else{if(DU[61]){end0pos=61;}else{if(DU[60]){end0pos=60;}else{if(DU[59]){end0pos=59;}else{if(DU[58]){end0pos=58;}else{if(DU[57]){end0pos=57;}else{if(DU[56]){end0pos=56;}else{if(DU[55]){end0pos=55;}else{if(DU[54]){end0pos=54;}else{if(DU[53]){end0pos=53;}else{if(DU[52]){end0pos=52;}else{if(DU[51]){end0pos=51;}else{if(DU[50]){end0pos=50;}else{if(DU[49]){end0pos=49;}else{if(DU[48]){end0pos=48;}else{if(DU[47]){end0pos=47;}else{if(DU[46]){end0pos=46;}else{if(DU[45]){end0pos=45;}else{if(DU[44]){end0pos=44;}else{if(DU[43]){end0pos=43;}else{if(DU[42]){end0pos=42;}else{if(DU[41]){end0pos=41;}else{if(DU[40]){end0pos=40;}else{if(DU[39]){end0pos=39;}else{if(DU[38]){end0pos=38;}else{if(DU[37]){end0pos=37;}else{if(DU[36]){end0pos=36;}else{if(DU[35]){end0pos=35;}else{if(DU[34]){end0pos=34;}else{if(DU[33]){end0pos=33;}else{if(DU[32]){end0pos=32;}else{if(DU[31]){end0pos=31;}else{if(DU[30]){end0pos=30;}else{if(DU[29]){end0pos=29;}else{if(DU[28]){end0pos=28;}else{if(DU[27]){end0pos=27;}else{if(DU[26]){end0pos=26;}else{if(DU[25]){end0pos=25;}else{if(DU[24]){end0pos=24;}else{if(DU[23]){end0pos=23;}else{if(DU[22]){end0pos=22;}else{if(DU[21]){end0pos=21;}else{if(DU[20]){end0pos=20;}else{if(DU[19]){end0pos=19;}else{if(DU[18]){end0pos=18;}else{if(DU[17]){end0pos=17;}else{if(DU[16]){end0pos=16;}else{if(DU[15]){end0pos=15;}else{if(DU[14]){end0pos=14;}else{if(DU[13]){end0pos=13;}else{if(DU[12]){end0pos=12;}else{if(DU[11]){end0pos=11;}else{if(DU[10]){end0pos=10;}else{if(DU[9]){end0pos=9;}else{if(DU[8]){end0pos=8;}else{if(DU[7]){end0pos=7;}else{if(DU[6]){end0pos=6;}else{if(DU[5]){end0pos=5;}else{if(DU[4]){end0pos=4;}else{if(DU[3]){end0pos=3;}else{if(DU[2]){end0pos=2;}else{if(DU[1]){end0pos=1;}else{end0pos=0;}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}
			
			// end0pos = first element in reverse order != 0
			if(end0pos){
				i = 0;
				while(i++<end0pos){
					startpos = i;
					//for (; (DU[i] == 0) && (i <= end0pos); i++){}
					while(i <= end0pos){
						if(DU[i]){
							break;
						}
						i++;
					}
					nrzeroes = i - startpos;
					
					if(nrzeroes<16){
					}else{
						nrmarker=nrzeroes / 16;
						while(nrmarker--){
							bGroupBitsOffset-=YAC_HT[481];
							bGroupValue|=YAC_HT[480]<<bGroupBitsOffset;
							//向 data 写入满8位(1字节)的数据:
							while(bGroupBitsOffset<24){byteout[offset++]=bGroupValue>>>24;if((bGroupValue>>>24)==0xff){byteout[offset++]=0x00;}bGroupValue<<=8;bGroupBitsOffset+=8;}
						}
						nrzeroes = nrzeroes & 0xF;
					}
					
					bitStringId=(nrzeroes * 16 + category[32767 + DU[i]])*2;
					bGroupBitsOffset-=YAC_HT[bitStringId+1];
					bGroupValue|=YAC_HT[bitStringId]<<bGroupBitsOffset;
					//向 data 写入满8位(1字节)的数据:
					while(bGroupBitsOffset<24){byteout[offset++]=bGroupValue>>>24;if((bGroupValue>>>24)==0xff){byteout[offset++]=0x00;}bGroupValue<<=8;bGroupBitsOffset+=8;}
					
					bitStringId=(32767 + DU[i])*2;
					bGroupBitsOffset-=bitcode[bitStringId+1];
					bGroupValue|=bitcode[bitStringId]<<bGroupBitsOffset;
					//向 data 写入满8位(1字节)的数据:
					while(bGroupBitsOffset<24){byteout[offset++]=bGroupValue>>>24;if((bGroupValue>>>24)==0xff){byteout[offset++]=0x00;}bGroupValue<<=8;bGroupBitsOffset+=8;}
				}
				
				if (end0pos == 63){
				}else{
					bGroupBitsOffset-=YAC_HT[1];
					bGroupValue|=YAC_HT[0]<<bGroupBitsOffset;
					//向 data 写入满8位(1字节)的数据:
					while(bGroupBitsOffset<24){byteout[offset++]=bGroupValue>>>24;if((bGroupValue>>>24)==0xff){byteout[offset++]=0x00;}bGroupValue<<=8;bGroupBitsOffset+=8;}
				}
			}else{
				bGroupBitsOffset-=YAC_HT[1];
				bGroupValue|=YAC_HT[0]<<bGroupBitsOffset;
				//向 data 写入满8位(1字节)的数据:
				while(bGroupBitsOffset<24){byteout[offset++]=bGroupValue>>>24;if((bGroupValue>>>24)==0xff){byteout[offset++]=0x00;}bGroupValue<<=8;bGroupBitsOffset+=8;}
			}
			
			//processDU(UDU, fdtbl_UV, DCU, UVDC_HT, UVAC_HT,processObj);
			
			// Pass 1: process rows.
			tmp0 = YUVDU[64] + YUVDU[71];tmp7 = YUVDU[64] - YUVDU[71];tmp1 = YUVDU[65] + YUVDU[70];tmp6 = YUVDU[65] - YUVDU[70];tmp2 = YUVDU[66] + YUVDU[69];tmp5 = YUVDU[66] - YUVDU[69];tmp3 = YUVDU[67] + YUVDU[68];tmp4 = YUVDU[67] - YUVDU[68];
			tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
			YUVDU[64] = tmp10 + tmp11;YUVDU[68] = tmp10 - tmp11;
			z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
			YUVDU[66] = tmp13 + z1;YUVDU[70] = tmp13 - z1;
			tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
			z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
			z11 = tmp7 + z3;z13 = tmp7 - z3;
			YUVDU[69] = z13 + z2;YUVDU[67] = z13 - z2;YUVDU[65] = z11 + z4;YUVDU[71] = z11 - z4;
			
			tmp0 = YUVDU[72] + YUVDU[79];tmp7 = YUVDU[72] - YUVDU[79];tmp1 = YUVDU[73] + YUVDU[78];tmp6 = YUVDU[73] - YUVDU[78];tmp2 = YUVDU[74] + YUVDU[77];tmp5 = YUVDU[74] - YUVDU[77];tmp3 = YUVDU[75] + YUVDU[76];tmp4 = YUVDU[75] - YUVDU[76];
			tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
			YUVDU[72] = tmp10 + tmp11;YUVDU[76] = tmp10 - tmp11;
			z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
			YUVDU[74] = tmp13 + z1;YUVDU[78] = tmp13 - z1;
			tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
			z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
			z11 = tmp7 + z3;z13 = tmp7 - z3;
			YUVDU[77] = z13 + z2;YUVDU[75] = z13 - z2;YUVDU[73] = z11 + z4;YUVDU[79] = z11 - z4;
			
			tmp0 = YUVDU[80] + YUVDU[87];tmp7 = YUVDU[80] - YUVDU[87];tmp1 = YUVDU[81] + YUVDU[86];tmp6 = YUVDU[81] - YUVDU[86];tmp2 = YUVDU[82] + YUVDU[85];tmp5 = YUVDU[82] - YUVDU[85];tmp3 = YUVDU[83] + YUVDU[84];tmp4 = YUVDU[83] - YUVDU[84];
			tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
			YUVDU[80] = tmp10 + tmp11;YUVDU[84] = tmp10 - tmp11;
			z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
			YUVDU[82] = tmp13 + z1;YUVDU[86] = tmp13 - z1;
			tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
			z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
			z11 = tmp7 + z3;z13 = tmp7 - z3;
			YUVDU[85] = z13 + z2;YUVDU[83] = z13 - z2;YUVDU[81] = z11 + z4;YUVDU[87] = z11 - z4;
			
			tmp0 = YUVDU[88] + YUVDU[95];tmp7 = YUVDU[88] - YUVDU[95];tmp1 = YUVDU[89] + YUVDU[94];tmp6 = YUVDU[89] - YUVDU[94];tmp2 = YUVDU[90] + YUVDU[93];tmp5 = YUVDU[90] - YUVDU[93];tmp3 = YUVDU[91] + YUVDU[92];tmp4 = YUVDU[91] - YUVDU[92];
			tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
			YUVDU[88] = tmp10 + tmp11;YUVDU[92] = tmp10 - tmp11;
			z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
			YUVDU[90] = tmp13 + z1;YUVDU[94] = tmp13 - z1;
			tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
			z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
			z11 = tmp7 + z3;z13 = tmp7 - z3;
			YUVDU[93] = z13 + z2;YUVDU[91] = z13 - z2;YUVDU[89] = z11 + z4;YUVDU[95] = z11 - z4;
			
			tmp0 = YUVDU[96] + YUVDU[103];tmp7 = YUVDU[96] - YUVDU[103];tmp1 = YUVDU[97] + YUVDU[102];tmp6 = YUVDU[97] - YUVDU[102];tmp2 = YUVDU[98] + YUVDU[101];tmp5 = YUVDU[98] - YUVDU[101];tmp3 = YUVDU[99] + YUVDU[100];tmp4 = YUVDU[99] - YUVDU[100];
			tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
			YUVDU[96] = tmp10 + tmp11;YUVDU[100] = tmp10 - tmp11;
			z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
			YUVDU[98] = tmp13 + z1;YUVDU[102] = tmp13 - z1;
			tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
			z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
			z11 = tmp7 + z3;z13 = tmp7 - z3;
			YUVDU[101] = z13 + z2;YUVDU[99] = z13 - z2;YUVDU[97] = z11 + z4;YUVDU[103] = z11 - z4;
			
			tmp0 = YUVDU[104] + YUVDU[111];tmp7 = YUVDU[104] - YUVDU[111];tmp1 = YUVDU[105] + YUVDU[110];tmp6 = YUVDU[105] - YUVDU[110];tmp2 = YUVDU[106] + YUVDU[109];tmp5 = YUVDU[106] - YUVDU[109];tmp3 = YUVDU[107] + YUVDU[108];tmp4 = YUVDU[107] - YUVDU[108];
			tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
			YUVDU[104] = tmp10 + tmp11;YUVDU[108] = tmp10 - tmp11;
			z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
			YUVDU[106] = tmp13 + z1;YUVDU[110] = tmp13 - z1;
			tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
			z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
			z11 = tmp7 + z3;z13 = tmp7 - z3;
			YUVDU[109] = z13 + z2;YUVDU[107] = z13 - z2;YUVDU[105] = z11 + z4;YUVDU[111] = z11 - z4;
			
			tmp0 = YUVDU[112] + YUVDU[119];tmp7 = YUVDU[112] - YUVDU[119];tmp1 = YUVDU[113] + YUVDU[118];tmp6 = YUVDU[113] - YUVDU[118];tmp2 = YUVDU[114] + YUVDU[117];tmp5 = YUVDU[114] - YUVDU[117];tmp3 = YUVDU[115] + YUVDU[116];tmp4 = YUVDU[115] - YUVDU[116];
			tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
			YUVDU[112] = tmp10 + tmp11;YUVDU[116] = tmp10 - tmp11;
			z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
			YUVDU[114] = tmp13 + z1;YUVDU[118] = tmp13 - z1;
			tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
			z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
			z11 = tmp7 + z3;z13 = tmp7 - z3;
			YUVDU[117] = z13 + z2;YUVDU[115] = z13 - z2;YUVDU[113] = z11 + z4;YUVDU[119] = z11 - z4;
			
			tmp0 = YUVDU[120] + YUVDU[127];tmp7 = YUVDU[120] - YUVDU[127];tmp1 = YUVDU[121] + YUVDU[126];tmp6 = YUVDU[121] - YUVDU[126];tmp2 = YUVDU[122] + YUVDU[125];tmp5 = YUVDU[122] - YUVDU[125];tmp3 = YUVDU[123] + YUVDU[124];tmp4 = YUVDU[123] - YUVDU[124];
			tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
			YUVDU[120] = tmp10 + tmp11;YUVDU[124] = tmp10 - tmp11;
			z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
			YUVDU[122] = tmp13 + z1;YUVDU[126] = tmp13 - z1;
			tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
			z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
			z11 = tmp7 + z3;z13 = tmp7 - z3;
			YUVDU[125] = z13 + z2;YUVDU[123] = z13 - z2;YUVDU[121] = z11 + z4;YUVDU[127] = z11 - z4;
			
			// Pass 2: process columns.
			tmp0 = YUVDU[64] + YUVDU[120];tmp7 = YUVDU[64] - YUVDU[120];tmp1 = YUVDU[72] + YUVDU[112];tmp6 = YUVDU[72] - YUVDU[112];tmp2 = YUVDU[80] + YUVDU[104];tmp5 = YUVDU[80] - YUVDU[104];tmp3 = YUVDU[88] + YUVDU[96];tmp4 = YUVDU[88] - YUVDU[96];
			tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
			YUVDU[64] = tmp10 + tmp11;YUVDU[96] = tmp10 - tmp11;
			z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
			YUVDU[80] = tmp13 + z1;YUVDU[112] = tmp13 - z1;
			tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
			z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
			z11 = tmp7 + z3;z13 = tmp7 - z3;
			YUVDU[104] = z13 + z2;YUVDU[88] = z13 - z2;YUVDU[72] = z11 + z4;YUVDU[120] = z11 - z4;
			
			tmp0 = YUVDU[65] + YUVDU[121];tmp7 = YUVDU[65] - YUVDU[121];tmp1 = YUVDU[73] + YUVDU[113];tmp6 = YUVDU[73] - YUVDU[113];tmp2 = YUVDU[81] + YUVDU[105];tmp5 = YUVDU[81] - YUVDU[105];tmp3 = YUVDU[89] + YUVDU[97];tmp4 = YUVDU[89] - YUVDU[97];
			tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
			YUVDU[65] = tmp10 + tmp11;YUVDU[97] = tmp10 - tmp11;
			z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
			YUVDU[81] = tmp13 + z1;YUVDU[113] = tmp13 - z1;
			tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
			z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
			z11 = tmp7 + z3;z13 = tmp7 - z3;
			YUVDU[105] = z13 + z2;YUVDU[89] = z13 - z2;YUVDU[73] = z11 + z4;YUVDU[121] = z11 - z4;
			
			tmp0 = YUVDU[66] + YUVDU[122];tmp7 = YUVDU[66] - YUVDU[122];tmp1 = YUVDU[74] + YUVDU[114];tmp6 = YUVDU[74] - YUVDU[114];tmp2 = YUVDU[82] + YUVDU[106];tmp5 = YUVDU[82] - YUVDU[106];tmp3 = YUVDU[90] + YUVDU[98];tmp4 = YUVDU[90] - YUVDU[98];
			tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
			YUVDU[66] = tmp10 + tmp11;YUVDU[98] = tmp10 - tmp11;
			z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
			YUVDU[82] = tmp13 + z1;YUVDU[114] = tmp13 - z1;
			tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
			z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
			z11 = tmp7 + z3;z13 = tmp7 - z3;
			YUVDU[106] = z13 + z2;YUVDU[90] = z13 - z2;YUVDU[74] = z11 + z4;YUVDU[122] = z11 - z4;
			
			tmp0 = YUVDU[67] + YUVDU[123];tmp7 = YUVDU[67] - YUVDU[123];tmp1 = YUVDU[75] + YUVDU[115];tmp6 = YUVDU[75] - YUVDU[115];tmp2 = YUVDU[83] + YUVDU[107];tmp5 = YUVDU[83] - YUVDU[107];tmp3 = YUVDU[91] + YUVDU[99];tmp4 = YUVDU[91] - YUVDU[99];
			tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
			YUVDU[67] = tmp10 + tmp11;YUVDU[99] = tmp10 - tmp11;
			z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
			YUVDU[83] = tmp13 + z1;YUVDU[115] = tmp13 - z1;
			tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
			z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
			z11 = tmp7 + z3;z13 = tmp7 - z3;
			YUVDU[107] = z13 + z2;YUVDU[91] = z13 - z2;YUVDU[75] = z11 + z4;YUVDU[123] = z11 - z4;
			
			tmp0 = YUVDU[68] + YUVDU[124];tmp7 = YUVDU[68] - YUVDU[124];tmp1 = YUVDU[76] + YUVDU[116];tmp6 = YUVDU[76] - YUVDU[116];tmp2 = YUVDU[84] + YUVDU[108];tmp5 = YUVDU[84] - YUVDU[108];tmp3 = YUVDU[92] + YUVDU[100];tmp4 = YUVDU[92] - YUVDU[100];
			tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
			YUVDU[68] = tmp10 + tmp11;YUVDU[100] = tmp10 - tmp11;
			z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
			YUVDU[84] = tmp13 + z1;YUVDU[116] = tmp13 - z1;
			tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
			z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
			z11 = tmp7 + z3;z13 = tmp7 - z3;
			YUVDU[108] = z13 + z2;YUVDU[92] = z13 - z2;YUVDU[76] = z11 + z4;YUVDU[124] = z11 - z4;
			
			tmp0 = YUVDU[69] + YUVDU[125];tmp7 = YUVDU[69] - YUVDU[125];tmp1 = YUVDU[77] + YUVDU[117];tmp6 = YUVDU[77] - YUVDU[117];tmp2 = YUVDU[85] + YUVDU[109];tmp5 = YUVDU[85] - YUVDU[109];tmp3 = YUVDU[93] + YUVDU[101];tmp4 = YUVDU[93] - YUVDU[101];
			tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
			YUVDU[69] = tmp10 + tmp11;YUVDU[101] = tmp10 - tmp11;
			z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
			YUVDU[85] = tmp13 + z1;YUVDU[117] = tmp13 - z1;
			tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
			z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
			z11 = tmp7 + z3;z13 = tmp7 - z3;
			YUVDU[109] = z13 + z2;YUVDU[93] = z13 - z2;YUVDU[77] = z11 + z4;YUVDU[125] = z11 - z4;
			
			tmp0 = YUVDU[70] + YUVDU[126];tmp7 = YUVDU[70] - YUVDU[126];tmp1 = YUVDU[78] + YUVDU[118];tmp6 = YUVDU[78] - YUVDU[118];tmp2 = YUVDU[86] + YUVDU[110];tmp5 = YUVDU[86] - YUVDU[110];tmp3 = YUVDU[94] + YUVDU[102];tmp4 = YUVDU[94] - YUVDU[102];
			tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
			YUVDU[70] = tmp10 + tmp11;YUVDU[102] = tmp10 - tmp11;
			z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
			YUVDU[86] = tmp13 + z1;YUVDU[118] = tmp13 - z1;
			tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
			z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
			z11 = tmp7 + z3;z13 = tmp7 - z3;
			YUVDU[110] = z13 + z2;YUVDU[94] = z13 - z2;YUVDU[78] = z11 + z4;YUVDU[126] = z11 - z4;
			
			tmp0 = YUVDU[71] + YUVDU[127];tmp7 = YUVDU[71] - YUVDU[127];tmp1 = YUVDU[79] + YUVDU[119];tmp6 = YUVDU[79] - YUVDU[119];tmp2 = YUVDU[87] + YUVDU[111];tmp5 = YUVDU[87] - YUVDU[111];tmp3 = YUVDU[95] + YUVDU[103];tmp4 = YUVDU[95] - YUVDU[103];
			tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
			YUVDU[71] = tmp10 + tmp11;YUVDU[103] = tmp10 - tmp11;
			z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
			YUVDU[87] = tmp13 + z1;YUVDU[119] = tmp13 - z1;
			tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
			z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
			z11 = tmp7 + z3;z13 = tmp7 - z3;
			YUVDU[111] = z13 + z2;YUVDU[95] = z13 - z2;YUVDU[79] = z11 + z4;YUVDU[127] = z11 - z4;
			
			// Quantize/descale the coefficients
			// Apply the quantization and scaling factor
			// and round to nearest integer
			//for(i=0;i<64;i++){UDU[i] = Math.round((UDU[i] * fdtbl_UV[i]));}
			YUVDU[64] = Math.round((YUVDU[64] * fdtbl_UV[0]));YUVDU[65] = Math.round((YUVDU[65] * fdtbl_UV[1]));YUVDU[66] = Math.round((YUVDU[66] * fdtbl_UV[2]));YUVDU[67] = Math.round((YUVDU[67] * fdtbl_UV[3]));YUVDU[68] = Math.round((YUVDU[68] * fdtbl_UV[4]));YUVDU[69] = Math.round((YUVDU[69] * fdtbl_UV[5]));YUVDU[70] = Math.round((YUVDU[70] * fdtbl_UV[6]));YUVDU[71] = Math.round((YUVDU[71] * fdtbl_UV[7]));YUVDU[72] = Math.round((YUVDU[72] * fdtbl_UV[8]));YUVDU[73] = Math.round((YUVDU[73] * fdtbl_UV[9]));YUVDU[74] = Math.round((YUVDU[74] * fdtbl_UV[10]));YUVDU[75] = Math.round((YUVDU[75] * fdtbl_UV[11]));YUVDU[76] = Math.round((YUVDU[76] * fdtbl_UV[12]));YUVDU[77] = Math.round((YUVDU[77] * fdtbl_UV[13]));YUVDU[78] = Math.round((YUVDU[78] * fdtbl_UV[14]));YUVDU[79] = Math.round((YUVDU[79] * fdtbl_UV[15]));YUVDU[80] = Math.round((YUVDU[80] * fdtbl_UV[16]));YUVDU[81] = Math.round((YUVDU[81] * fdtbl_UV[17]));YUVDU[82] = Math.round((YUVDU[82] * fdtbl_UV[18]));YUVDU[83] = Math.round((YUVDU[83] * fdtbl_UV[19]));YUVDU[84] = Math.round((YUVDU[84] * fdtbl_UV[20]));YUVDU[85] = Math.round((YUVDU[85] * fdtbl_UV[21]));YUVDU[86] = Math.round((YUVDU[86] * fdtbl_UV[22]));YUVDU[87] = Math.round((YUVDU[87] * fdtbl_UV[23]));YUVDU[88] = Math.round((YUVDU[88] * fdtbl_UV[24]));YUVDU[89] = Math.round((YUVDU[89] * fdtbl_UV[25]));YUVDU[90] = Math.round((YUVDU[90] * fdtbl_UV[26]));YUVDU[91] = Math.round((YUVDU[91] * fdtbl_UV[27]));YUVDU[92] = Math.round((YUVDU[92] * fdtbl_UV[28]));YUVDU[93] = Math.round((YUVDU[93] * fdtbl_UV[29]));YUVDU[94] = Math.round((YUVDU[94] * fdtbl_UV[30]));YUVDU[95] = Math.round((YUVDU[95] * fdtbl_UV[31]));YUVDU[96] = Math.round((YUVDU[96] * fdtbl_UV[32]));YUVDU[97] = Math.round((YUVDU[97] * fdtbl_UV[33]));YUVDU[98] = Math.round((YUVDU[98] * fdtbl_UV[34]));YUVDU[99] = Math.round((YUVDU[99] * fdtbl_UV[35]));YUVDU[100] = Math.round((YUVDU[100] * fdtbl_UV[36]));YUVDU[101] = Math.round((YUVDU[101] * fdtbl_UV[37]));YUVDU[102] = Math.round((YUVDU[102] * fdtbl_UV[38]));YUVDU[103] = Math.round((YUVDU[103] * fdtbl_UV[39]));YUVDU[104] = Math.round((YUVDU[104] * fdtbl_UV[40]));YUVDU[105] = Math.round((YUVDU[105] * fdtbl_UV[41]));YUVDU[106] = Math.round((YUVDU[106] * fdtbl_UV[42]));YUVDU[107] = Math.round((YUVDU[107] * fdtbl_UV[43]));YUVDU[108] = Math.round((YUVDU[108] * fdtbl_UV[44]));YUVDU[109] = Math.round((YUVDU[109] * fdtbl_UV[45]));YUVDU[110] = Math.round((YUVDU[110] * fdtbl_UV[46]));YUVDU[111] = Math.round((YUVDU[111] * fdtbl_UV[47]));YUVDU[112] = Math.round((YUVDU[112] * fdtbl_UV[48]));YUVDU[113] = Math.round((YUVDU[113] * fdtbl_UV[49]));YUVDU[114] = Math.round((YUVDU[114] * fdtbl_UV[50]));YUVDU[115] = Math.round((YUVDU[115] * fdtbl_UV[51]));YUVDU[116] = Math.round((YUVDU[116] * fdtbl_UV[52]));YUVDU[117] = Math.round((YUVDU[117] * fdtbl_UV[53]));YUVDU[118] = Math.round((YUVDU[118] * fdtbl_UV[54]));YUVDU[119] = Math.round((YUVDU[119] * fdtbl_UV[55]));YUVDU[120] = Math.round((YUVDU[120] * fdtbl_UV[56]));YUVDU[121] = Math.round((YUVDU[121] * fdtbl_UV[57]));YUVDU[122] = Math.round((YUVDU[122] * fdtbl_UV[58]));YUVDU[123] = Math.round((YUVDU[123] * fdtbl_UV[59]));YUVDU[124] = Math.round((YUVDU[124] * fdtbl_UV[60]));YUVDU[125] = Math.round((YUVDU[125] * fdtbl_UV[61]));YUVDU[126] = Math.round((YUVDU[126] * fdtbl_UV[62]));YUVDU[127] = Math.round((YUVDU[127] * fdtbl_UV[63]));
			
			// ZigZag reorder
			//for(i=0;i<64;i++){DU[ZigZag[i]] = UDU[i];}
			DU[ZigZag[0]] = YUVDU[64];DU[ZigZag[1]] = YUVDU[65];DU[ZigZag[2]] = YUVDU[66];DU[ZigZag[3]] = YUVDU[67];DU[ZigZag[4]] = YUVDU[68];DU[ZigZag[5]] = YUVDU[69];DU[ZigZag[6]] = YUVDU[70];DU[ZigZag[7]] = YUVDU[71];DU[ZigZag[8]] = YUVDU[72];DU[ZigZag[9]] = YUVDU[73];DU[ZigZag[10]] = YUVDU[74];DU[ZigZag[11]] = YUVDU[75];DU[ZigZag[12]] = YUVDU[76];DU[ZigZag[13]] = YUVDU[77];DU[ZigZag[14]] = YUVDU[78];DU[ZigZag[15]] = YUVDU[79];DU[ZigZag[16]] = YUVDU[80];DU[ZigZag[17]] = YUVDU[81];DU[ZigZag[18]] = YUVDU[82];DU[ZigZag[19]] = YUVDU[83];DU[ZigZag[20]] = YUVDU[84];DU[ZigZag[21]] = YUVDU[85];DU[ZigZag[22]] = YUVDU[86];DU[ZigZag[23]] = YUVDU[87];DU[ZigZag[24]] = YUVDU[88];DU[ZigZag[25]] = YUVDU[89];DU[ZigZag[26]] = YUVDU[90];DU[ZigZag[27]] = YUVDU[91];DU[ZigZag[28]] = YUVDU[92];DU[ZigZag[29]] = YUVDU[93];DU[ZigZag[30]] = YUVDU[94];DU[ZigZag[31]] = YUVDU[95];DU[ZigZag[32]] = YUVDU[96];DU[ZigZag[33]] = YUVDU[97];DU[ZigZag[34]] = YUVDU[98];DU[ZigZag[35]] = YUVDU[99];DU[ZigZag[36]] = YUVDU[100];DU[ZigZag[37]] = YUVDU[101];DU[ZigZag[38]] = YUVDU[102];DU[ZigZag[39]] = YUVDU[103];DU[ZigZag[40]] = YUVDU[104];DU[ZigZag[41]] = YUVDU[105];DU[ZigZag[42]] = YUVDU[106];DU[ZigZag[43]] = YUVDU[107];DU[ZigZag[44]] = YUVDU[108];DU[ZigZag[45]] = YUVDU[109];DU[ZigZag[46]] = YUVDU[110];DU[ZigZag[47]] = YUVDU[111];DU[ZigZag[48]] = YUVDU[112];DU[ZigZag[49]] = YUVDU[113];DU[ZigZag[50]] = YUVDU[114];DU[ZigZag[51]] = YUVDU[115];DU[ZigZag[52]] = YUVDU[116];DU[ZigZag[53]] = YUVDU[117];DU[ZigZag[54]] = YUVDU[118];DU[ZigZag[55]] = YUVDU[119];DU[ZigZag[56]] = YUVDU[120];DU[ZigZag[57]] = YUVDU[121];DU[ZigZag[58]] = YUVDU[122];DU[ZigZag[59]] = YUVDU[123];DU[ZigZag[60]] = YUVDU[124];DU[ZigZag[61]] = YUVDU[125];DU[ZigZag[62]] = YUVDU[126];DU[ZigZag[63]] = YUVDU[127];
			
			Diff = DU[0] - DCU;
			DCU = DU[0];
			
			// Encode DCU
			if(Diff){// Diff might be 0
				bitStringId=category[32767 + Diff]*2;
				bGroupBitsOffset-=UVDC_HT[bitStringId+1];
				bGroupValue|=UVDC_HT[bitStringId]<<bGroupBitsOffset;
				//向 data 写入满8位(1字节)的数据:
				while(bGroupBitsOffset<24){byteout[offset++]=bGroupValue>>>24;if((bGroupValue>>>24)==0xff){byteout[offset++]=0x00;}bGroupValue<<=8;bGroupBitsOffset+=8;}
				
				bitStringId=(32767 + Diff)*2;
				bGroupBitsOffset-=bitcode[bitStringId+1];
				bGroupValue|=bitcode[bitStringId]<<bGroupBitsOffset;
				//向 data 写入满8位(1字节)的数据:
				while(bGroupBitsOffset<24){byteout[offset++]=bGroupValue>>>24;if((bGroupValue>>>24)==0xff){byteout[offset++]=0x00;}bGroupValue<<=8;bGroupBitsOffset+=8;}
			}else{
				bGroupBitsOffset-=UVDC_HT[1];
				bGroupValue|=UVDC_HT[0]<<bGroupBitsOffset;
				//向 data 写入满8位(1字节)的数据:
				while(bGroupBitsOffset<24){byteout[offset++]=bGroupValue>>>24;if((bGroupValue>>>24)==0xff){byteout[offset++]=0x00;}bGroupValue<<=8;bGroupBitsOffset+=8;}
			}
			
			// Encode ACs
			//var end0pos:int=64;
			//for (; (end0pos > 0) && (DU[end0pos] == 0); end0pos--){};
			if(DU[63]){end0pos=63;}else{if(DU[62]){end0pos=62;}else{if(DU[61]){end0pos=61;}else{if(DU[60]){end0pos=60;}else{if(DU[59]){end0pos=59;}else{if(DU[58]){end0pos=58;}else{if(DU[57]){end0pos=57;}else{if(DU[56]){end0pos=56;}else{if(DU[55]){end0pos=55;}else{if(DU[54]){end0pos=54;}else{if(DU[53]){end0pos=53;}else{if(DU[52]){end0pos=52;}else{if(DU[51]){end0pos=51;}else{if(DU[50]){end0pos=50;}else{if(DU[49]){end0pos=49;}else{if(DU[48]){end0pos=48;}else{if(DU[47]){end0pos=47;}else{if(DU[46]){end0pos=46;}else{if(DU[45]){end0pos=45;}else{if(DU[44]){end0pos=44;}else{if(DU[43]){end0pos=43;}else{if(DU[42]){end0pos=42;}else{if(DU[41]){end0pos=41;}else{if(DU[40]){end0pos=40;}else{if(DU[39]){end0pos=39;}else{if(DU[38]){end0pos=38;}else{if(DU[37]){end0pos=37;}else{if(DU[36]){end0pos=36;}else{if(DU[35]){end0pos=35;}else{if(DU[34]){end0pos=34;}else{if(DU[33]){end0pos=33;}else{if(DU[32]){end0pos=32;}else{if(DU[31]){end0pos=31;}else{if(DU[30]){end0pos=30;}else{if(DU[29]){end0pos=29;}else{if(DU[28]){end0pos=28;}else{if(DU[27]){end0pos=27;}else{if(DU[26]){end0pos=26;}else{if(DU[25]){end0pos=25;}else{if(DU[24]){end0pos=24;}else{if(DU[23]){end0pos=23;}else{if(DU[22]){end0pos=22;}else{if(DU[21]){end0pos=21;}else{if(DU[20]){end0pos=20;}else{if(DU[19]){end0pos=19;}else{if(DU[18]){end0pos=18;}else{if(DU[17]){end0pos=17;}else{if(DU[16]){end0pos=16;}else{if(DU[15]){end0pos=15;}else{if(DU[14]){end0pos=14;}else{if(DU[13]){end0pos=13;}else{if(DU[12]){end0pos=12;}else{if(DU[11]){end0pos=11;}else{if(DU[10]){end0pos=10;}else{if(DU[9]){end0pos=9;}else{if(DU[8]){end0pos=8;}else{if(DU[7]){end0pos=7;}else{if(DU[6]){end0pos=6;}else{if(DU[5]){end0pos=5;}else{if(DU[4]){end0pos=4;}else{if(DU[3]){end0pos=3;}else{if(DU[2]){end0pos=2;}else{if(DU[1]){end0pos=1;}else{end0pos=0;}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}
			
			// end0pos = first element in reverse order != 0
			if(end0pos){
				i = 0;
				while(i++<end0pos){
					startpos = i;
					//for (; (DU[i] == 0) && (i <= end0pos); i++){}
					while(i <= end0pos){
						if(DU[i]){
							break;
						}
						i++;
					}
					nrzeroes = i - startpos;
					
					if(nrzeroes<16){
					}else{
						nrmarker=nrzeroes / 16;
						while(nrmarker--){
							bGroupBitsOffset-=UVAC_HT[481];
							bGroupValue|=UVAC_HT[480]<<bGroupBitsOffset;
							//向 data 写入满8位(1字节)的数据:
							while(bGroupBitsOffset<24){byteout[offset++]=bGroupValue>>>24;if((bGroupValue>>>24)==0xff){byteout[offset++]=0x00;}bGroupValue<<=8;bGroupBitsOffset+=8;}
						}
						nrzeroes = nrzeroes & 0xF;
					}
					
					bitStringId=(nrzeroes * 16 + category[32767 + DU[i]])*2;
					bGroupBitsOffset-=UVAC_HT[bitStringId+1];
					bGroupValue|=UVAC_HT[bitStringId]<<bGroupBitsOffset;
					//向 data 写入满8位(1字节)的数据:
					while(bGroupBitsOffset<24){byteout[offset++]=bGroupValue>>>24;if((bGroupValue>>>24)==0xff){byteout[offset++]=0x00;}bGroupValue<<=8;bGroupBitsOffset+=8;}
					
					bitStringId=(32767 + DU[i])*2;
					bGroupBitsOffset-=bitcode[bitStringId+1];
					bGroupValue|=bitcode[bitStringId]<<bGroupBitsOffset;
					//向 data 写入满8位(1字节)的数据:
					while(bGroupBitsOffset<24){byteout[offset++]=bGroupValue>>>24;if((bGroupValue>>>24)==0xff){byteout[offset++]=0x00;}bGroupValue<<=8;bGroupBitsOffset+=8;}
				}
				
				if (end0pos == 63){
				}else{
					bGroupBitsOffset-=UVAC_HT[1];
					bGroupValue|=UVAC_HT[0]<<bGroupBitsOffset;
					//向 data 写入满8位(1字节)的数据:
					while(bGroupBitsOffset<24){byteout[offset++]=bGroupValue>>>24;if((bGroupValue>>>24)==0xff){byteout[offset++]=0x00;}bGroupValue<<=8;bGroupBitsOffset+=8;}
				}
			}else{
				bGroupBitsOffset-=UVAC_HT[1];
				bGroupValue|=UVAC_HT[0]<<bGroupBitsOffset;
				//向 data 写入满8位(1字节)的数据:
				while(bGroupBitsOffset<24){byteout[offset++]=bGroupValue>>>24;if((bGroupValue>>>24)==0xff){byteout[offset++]=0x00;}bGroupValue<<=8;bGroupBitsOffset+=8;}
			}
			
			//processDU(VDU, fdtbl_UV, DCV, UVDC_HT, UVAC_HT,processObj);
			
			// Pass 1: process rows.
			tmp0 = YUVDU[128] + YUVDU[135];tmp7 = YUVDU[128] - YUVDU[135];tmp1 = YUVDU[129] + YUVDU[134];tmp6 = YUVDU[129] - YUVDU[134];tmp2 = YUVDU[130] + YUVDU[133];tmp5 = YUVDU[130] - YUVDU[133];tmp3 = YUVDU[131] + YUVDU[132];tmp4 = YUVDU[131] - YUVDU[132];
			tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
			YUVDU[128] = tmp10 + tmp11;YUVDU[132] = tmp10 - tmp11;
			z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
			YUVDU[130] = tmp13 + z1;YUVDU[134] = tmp13 - z1;
			tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
			z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
			z11 = tmp7 + z3;z13 = tmp7 - z3;
			YUVDU[133] = z13 + z2;YUVDU[131] = z13 - z2;YUVDU[129] = z11 + z4;YUVDU[135] = z11 - z4;
			
			tmp0 = YUVDU[136] + YUVDU[143];tmp7 = YUVDU[136] - YUVDU[143];tmp1 = YUVDU[137] + YUVDU[142];tmp6 = YUVDU[137] - YUVDU[142];tmp2 = YUVDU[138] + YUVDU[141];tmp5 = YUVDU[138] - YUVDU[141];tmp3 = YUVDU[139] + YUVDU[140];tmp4 = YUVDU[139] - YUVDU[140];
			tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
			YUVDU[136] = tmp10 + tmp11;YUVDU[140] = tmp10 - tmp11;
			z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
			YUVDU[138] = tmp13 + z1;YUVDU[142] = tmp13 - z1;
			tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
			z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
			z11 = tmp7 + z3;z13 = tmp7 - z3;
			YUVDU[141] = z13 + z2;YUVDU[139] = z13 - z2;YUVDU[137] = z11 + z4;YUVDU[143] = z11 - z4;
			
			tmp0 = YUVDU[144] + YUVDU[151];tmp7 = YUVDU[144] - YUVDU[151];tmp1 = YUVDU[145] + YUVDU[150];tmp6 = YUVDU[145] - YUVDU[150];tmp2 = YUVDU[146] + YUVDU[149];tmp5 = YUVDU[146] - YUVDU[149];tmp3 = YUVDU[147] + YUVDU[148];tmp4 = YUVDU[147] - YUVDU[148];
			tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
			YUVDU[144] = tmp10 + tmp11;YUVDU[148] = tmp10 - tmp11;
			z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
			YUVDU[146] = tmp13 + z1;YUVDU[150] = tmp13 - z1;
			tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
			z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
			z11 = tmp7 + z3;z13 = tmp7 - z3;
			YUVDU[149] = z13 + z2;YUVDU[147] = z13 - z2;YUVDU[145] = z11 + z4;YUVDU[151] = z11 - z4;
			
			tmp0 = YUVDU[152] + YUVDU[159];tmp7 = YUVDU[152] - YUVDU[159];tmp1 = YUVDU[153] + YUVDU[158];tmp6 = YUVDU[153] - YUVDU[158];tmp2 = YUVDU[154] + YUVDU[157];tmp5 = YUVDU[154] - YUVDU[157];tmp3 = YUVDU[155] + YUVDU[156];tmp4 = YUVDU[155] - YUVDU[156];
			tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
			YUVDU[152] = tmp10 + tmp11;YUVDU[156] = tmp10 - tmp11;
			z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
			YUVDU[154] = tmp13 + z1;YUVDU[158] = tmp13 - z1;
			tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
			z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
			z11 = tmp7 + z3;z13 = tmp7 - z3;
			YUVDU[157] = z13 + z2;YUVDU[155] = z13 - z2;YUVDU[153] = z11 + z4;YUVDU[159] = z11 - z4;
			
			tmp0 = YUVDU[160] + YUVDU[167];tmp7 = YUVDU[160] - YUVDU[167];tmp1 = YUVDU[161] + YUVDU[166];tmp6 = YUVDU[161] - YUVDU[166];tmp2 = YUVDU[162] + YUVDU[165];tmp5 = YUVDU[162] - YUVDU[165];tmp3 = YUVDU[163] + YUVDU[164];tmp4 = YUVDU[163] - YUVDU[164];
			tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
			YUVDU[160] = tmp10 + tmp11;YUVDU[164] = tmp10 - tmp11;
			z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
			YUVDU[162] = tmp13 + z1;YUVDU[166] = tmp13 - z1;
			tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
			z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
			z11 = tmp7 + z3;z13 = tmp7 - z3;
			YUVDU[165] = z13 + z2;YUVDU[163] = z13 - z2;YUVDU[161] = z11 + z4;YUVDU[167] = z11 - z4;
			
			tmp0 = YUVDU[168] + YUVDU[175];tmp7 = YUVDU[168] - YUVDU[175];tmp1 = YUVDU[169] + YUVDU[174];tmp6 = YUVDU[169] - YUVDU[174];tmp2 = YUVDU[170] + YUVDU[173];tmp5 = YUVDU[170] - YUVDU[173];tmp3 = YUVDU[171] + YUVDU[172];tmp4 = YUVDU[171] - YUVDU[172];
			tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
			YUVDU[168] = tmp10 + tmp11;YUVDU[172] = tmp10 - tmp11;
			z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
			YUVDU[170] = tmp13 + z1;YUVDU[174] = tmp13 - z1;
			tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
			z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
			z11 = tmp7 + z3;z13 = tmp7 - z3;
			YUVDU[173] = z13 + z2;YUVDU[171] = z13 - z2;YUVDU[169] = z11 + z4;YUVDU[175] = z11 - z4;
			
			tmp0 = YUVDU[176] + YUVDU[183];tmp7 = YUVDU[176] - YUVDU[183];tmp1 = YUVDU[177] + YUVDU[182];tmp6 = YUVDU[177] - YUVDU[182];tmp2 = YUVDU[178] + YUVDU[181];tmp5 = YUVDU[178] - YUVDU[181];tmp3 = YUVDU[179] + YUVDU[180];tmp4 = YUVDU[179] - YUVDU[180];
			tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
			YUVDU[176] = tmp10 + tmp11;YUVDU[180] = tmp10 - tmp11;
			z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
			YUVDU[178] = tmp13 + z1;YUVDU[182] = tmp13 - z1;
			tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
			z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
			z11 = tmp7 + z3;z13 = tmp7 - z3;
			YUVDU[181] = z13 + z2;YUVDU[179] = z13 - z2;YUVDU[177] = z11 + z4;YUVDU[183] = z11 - z4;
			
			tmp0 = YUVDU[184] + YUVDU[191];tmp7 = YUVDU[184] - YUVDU[191];tmp1 = YUVDU[185] + YUVDU[190];tmp6 = YUVDU[185] - YUVDU[190];tmp2 = YUVDU[186] + YUVDU[189];tmp5 = YUVDU[186] - YUVDU[189];tmp3 = YUVDU[187] + YUVDU[188];tmp4 = YUVDU[187] - YUVDU[188];
			tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
			YUVDU[184] = tmp10 + tmp11;YUVDU[188] = tmp10 - tmp11;
			z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
			YUVDU[186] = tmp13 + z1;YUVDU[190] = tmp13 - z1;
			tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
			z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
			z11 = tmp7 + z3;z13 = tmp7 - z3;
			YUVDU[189] = z13 + z2;YUVDU[187] = z13 - z2;YUVDU[185] = z11 + z4;YUVDU[191] = z11 - z4;
			
			// Pass 2: process columns.
			tmp0 = YUVDU[128] + YUVDU[184];tmp7 = YUVDU[128] - YUVDU[184];tmp1 = YUVDU[136] + YUVDU[176];tmp6 = YUVDU[136] - YUVDU[176];tmp2 = YUVDU[144] + YUVDU[168];tmp5 = YUVDU[144] - YUVDU[168];tmp3 = YUVDU[152] + YUVDU[160];tmp4 = YUVDU[152] - YUVDU[160];
			tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
			YUVDU[128] = tmp10 + tmp11;YUVDU[160] = tmp10 - tmp11;
			z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
			YUVDU[144] = tmp13 + z1;YUVDU[176] = tmp13 - z1;
			tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
			z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
			z11 = tmp7 + z3;z13 = tmp7 - z3;
			YUVDU[168] = z13 + z2;YUVDU[152] = z13 - z2;YUVDU[136] = z11 + z4;YUVDU[184] = z11 - z4;
			
			tmp0 = YUVDU[129] + YUVDU[185];tmp7 = YUVDU[129] - YUVDU[185];tmp1 = YUVDU[137] + YUVDU[177];tmp6 = YUVDU[137] - YUVDU[177];tmp2 = YUVDU[145] + YUVDU[169];tmp5 = YUVDU[145] - YUVDU[169];tmp3 = YUVDU[153] + YUVDU[161];tmp4 = YUVDU[153] - YUVDU[161];
			tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
			YUVDU[129] = tmp10 + tmp11;YUVDU[161] = tmp10 - tmp11;
			z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
			YUVDU[145] = tmp13 + z1;YUVDU[177] = tmp13 - z1;
			tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
			z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
			z11 = tmp7 + z3;z13 = tmp7 - z3;
			YUVDU[169] = z13 + z2;YUVDU[153] = z13 - z2;YUVDU[137] = z11 + z4;YUVDU[185] = z11 - z4;
			
			tmp0 = YUVDU[130] + YUVDU[186];tmp7 = YUVDU[130] - YUVDU[186];tmp1 = YUVDU[138] + YUVDU[178];tmp6 = YUVDU[138] - YUVDU[178];tmp2 = YUVDU[146] + YUVDU[170];tmp5 = YUVDU[146] - YUVDU[170];tmp3 = YUVDU[154] + YUVDU[162];tmp4 = YUVDU[154] - YUVDU[162];
			tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
			YUVDU[130] = tmp10 + tmp11;YUVDU[162] = tmp10 - tmp11;
			z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
			YUVDU[146] = tmp13 + z1;YUVDU[178] = tmp13 - z1;
			tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
			z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
			z11 = tmp7 + z3;z13 = tmp7 - z3;
			YUVDU[170] = z13 + z2;YUVDU[154] = z13 - z2;YUVDU[138] = z11 + z4;YUVDU[186] = z11 - z4;
			
			tmp0 = YUVDU[131] + YUVDU[187];tmp7 = YUVDU[131] - YUVDU[187];tmp1 = YUVDU[139] + YUVDU[179];tmp6 = YUVDU[139] - YUVDU[179];tmp2 = YUVDU[147] + YUVDU[171];tmp5 = YUVDU[147] - YUVDU[171];tmp3 = YUVDU[155] + YUVDU[163];tmp4 = YUVDU[155] - YUVDU[163];
			tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
			YUVDU[131] = tmp10 + tmp11;YUVDU[163] = tmp10 - tmp11;
			z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
			YUVDU[147] = tmp13 + z1;YUVDU[179] = tmp13 - z1;
			tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
			z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
			z11 = tmp7 + z3;z13 = tmp7 - z3;
			YUVDU[171] = z13 + z2;YUVDU[155] = z13 - z2;YUVDU[139] = z11 + z4;YUVDU[187] = z11 - z4;
			
			tmp0 = YUVDU[132] + YUVDU[188];tmp7 = YUVDU[132] - YUVDU[188];tmp1 = YUVDU[140] + YUVDU[180];tmp6 = YUVDU[140] - YUVDU[180];tmp2 = YUVDU[148] + YUVDU[172];tmp5 = YUVDU[148] - YUVDU[172];tmp3 = YUVDU[156] + YUVDU[164];tmp4 = YUVDU[156] - YUVDU[164];
			tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
			YUVDU[132] = tmp10 + tmp11;YUVDU[164] = tmp10 - tmp11;
			z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
			YUVDU[148] = tmp13 + z1;YUVDU[180] = tmp13 - z1;
			tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
			z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
			z11 = tmp7 + z3;z13 = tmp7 - z3;
			YUVDU[172] = z13 + z2;YUVDU[156] = z13 - z2;YUVDU[140] = z11 + z4;YUVDU[188] = z11 - z4;
			
			tmp0 = YUVDU[133] + YUVDU[189];tmp7 = YUVDU[133] - YUVDU[189];tmp1 = YUVDU[141] + YUVDU[181];tmp6 = YUVDU[141] - YUVDU[181];tmp2 = YUVDU[149] + YUVDU[173];tmp5 = YUVDU[149] - YUVDU[173];tmp3 = YUVDU[157] + YUVDU[165];tmp4 = YUVDU[157] - YUVDU[165];
			tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
			YUVDU[133] = tmp10 + tmp11;YUVDU[165] = tmp10 - tmp11;
			z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
			YUVDU[149] = tmp13 + z1;YUVDU[181] = tmp13 - z1;
			tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
			z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
			z11 = tmp7 + z3;z13 = tmp7 - z3;
			YUVDU[173] = z13 + z2;YUVDU[157] = z13 - z2;YUVDU[141] = z11 + z4;YUVDU[189] = z11 - z4;
			
			tmp0 = YUVDU[134] + YUVDU[190];tmp7 = YUVDU[134] - YUVDU[190];tmp1 = YUVDU[142] + YUVDU[182];tmp6 = YUVDU[142] - YUVDU[182];tmp2 = YUVDU[150] + YUVDU[174];tmp5 = YUVDU[150] - YUVDU[174];tmp3 = YUVDU[158] + YUVDU[166];tmp4 = YUVDU[158] - YUVDU[166];
			tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
			YUVDU[134] = tmp10 + tmp11;YUVDU[166] = tmp10 - tmp11;
			z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
			YUVDU[150] = tmp13 + z1;YUVDU[182] = tmp13 - z1;
			tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
			z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
			z11 = tmp7 + z3;z13 = tmp7 - z3;
			YUVDU[174] = z13 + z2;YUVDU[158] = z13 - z2;YUVDU[142] = z11 + z4;YUVDU[190] = z11 - z4;
			
			tmp0 = YUVDU[135] + YUVDU[191];tmp7 = YUVDU[135] - YUVDU[191];tmp1 = YUVDU[143] + YUVDU[183];tmp6 = YUVDU[143] - YUVDU[183];tmp2 = YUVDU[151] + YUVDU[175];tmp5 = YUVDU[151] - YUVDU[175];tmp3 = YUVDU[159] + YUVDU[167];tmp4 = YUVDU[159] - YUVDU[167];
			tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
			YUVDU[135] = tmp10 + tmp11;YUVDU[167] = tmp10 - tmp11;
			z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
			YUVDU[151] = tmp13 + z1;YUVDU[183] = tmp13 - z1;
			tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
			z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
			z11 = tmp7 + z3;z13 = tmp7 - z3;
			YUVDU[175] = z13 + z2;YUVDU[159] = z13 - z2;YUVDU[143] = z11 + z4;YUVDU[191] = z11 - z4;
			
			// Quantize/descale the coefficients
			// Apply the quantization and scaling factor
			// and round to nearest integer
			//for(i=0;i<64;i++){VDU[i] = Math.round((VDU[i] * fdtbl_UV[i]));}
			YUVDU[128] = Math.round((YUVDU[128] * fdtbl_UV[0]));YUVDU[129] = Math.round((YUVDU[129] * fdtbl_UV[1]));YUVDU[130] = Math.round((YUVDU[130] * fdtbl_UV[2]));YUVDU[131] = Math.round((YUVDU[131] * fdtbl_UV[3]));YUVDU[132] = Math.round((YUVDU[132] * fdtbl_UV[4]));YUVDU[133] = Math.round((YUVDU[133] * fdtbl_UV[5]));YUVDU[134] = Math.round((YUVDU[134] * fdtbl_UV[6]));YUVDU[135] = Math.round((YUVDU[135] * fdtbl_UV[7]));YUVDU[136] = Math.round((YUVDU[136] * fdtbl_UV[8]));YUVDU[137] = Math.round((YUVDU[137] * fdtbl_UV[9]));YUVDU[138] = Math.round((YUVDU[138] * fdtbl_UV[10]));YUVDU[139] = Math.round((YUVDU[139] * fdtbl_UV[11]));YUVDU[140] = Math.round((YUVDU[140] * fdtbl_UV[12]));YUVDU[141] = Math.round((YUVDU[141] * fdtbl_UV[13]));YUVDU[142] = Math.round((YUVDU[142] * fdtbl_UV[14]));YUVDU[143] = Math.round((YUVDU[143] * fdtbl_UV[15]));YUVDU[144] = Math.round((YUVDU[144] * fdtbl_UV[16]));YUVDU[145] = Math.round((YUVDU[145] * fdtbl_UV[17]));YUVDU[146] = Math.round((YUVDU[146] * fdtbl_UV[18]));YUVDU[147] = Math.round((YUVDU[147] * fdtbl_UV[19]));YUVDU[148] = Math.round((YUVDU[148] * fdtbl_UV[20]));YUVDU[149] = Math.round((YUVDU[149] * fdtbl_UV[21]));YUVDU[150] = Math.round((YUVDU[150] * fdtbl_UV[22]));YUVDU[151] = Math.round((YUVDU[151] * fdtbl_UV[23]));YUVDU[152] = Math.round((YUVDU[152] * fdtbl_UV[24]));YUVDU[153] = Math.round((YUVDU[153] * fdtbl_UV[25]));YUVDU[154] = Math.round((YUVDU[154] * fdtbl_UV[26]));YUVDU[155] = Math.round((YUVDU[155] * fdtbl_UV[27]));YUVDU[156] = Math.round((YUVDU[156] * fdtbl_UV[28]));YUVDU[157] = Math.round((YUVDU[157] * fdtbl_UV[29]));YUVDU[158] = Math.round((YUVDU[158] * fdtbl_UV[30]));YUVDU[159] = Math.round((YUVDU[159] * fdtbl_UV[31]));YUVDU[160] = Math.round((YUVDU[160] * fdtbl_UV[32]));YUVDU[161] = Math.round((YUVDU[161] * fdtbl_UV[33]));YUVDU[162] = Math.round((YUVDU[162] * fdtbl_UV[34]));YUVDU[163] = Math.round((YUVDU[163] * fdtbl_UV[35]));YUVDU[164] = Math.round((YUVDU[164] * fdtbl_UV[36]));YUVDU[165] = Math.round((YUVDU[165] * fdtbl_UV[37]));YUVDU[166] = Math.round((YUVDU[166] * fdtbl_UV[38]));YUVDU[167] = Math.round((YUVDU[167] * fdtbl_UV[39]));YUVDU[168] = Math.round((YUVDU[168] * fdtbl_UV[40]));YUVDU[169] = Math.round((YUVDU[169] * fdtbl_UV[41]));YUVDU[170] = Math.round((YUVDU[170] * fdtbl_UV[42]));YUVDU[171] = Math.round((YUVDU[171] * fdtbl_UV[43]));YUVDU[172] = Math.round((YUVDU[172] * fdtbl_UV[44]));YUVDU[173] = Math.round((YUVDU[173] * fdtbl_UV[45]));YUVDU[174] = Math.round((YUVDU[174] * fdtbl_UV[46]));YUVDU[175] = Math.round((YUVDU[175] * fdtbl_UV[47]));YUVDU[176] = Math.round((YUVDU[176] * fdtbl_UV[48]));YUVDU[177] = Math.round((YUVDU[177] * fdtbl_UV[49]));YUVDU[178] = Math.round((YUVDU[178] * fdtbl_UV[50]));YUVDU[179] = Math.round((YUVDU[179] * fdtbl_UV[51]));YUVDU[180] = Math.round((YUVDU[180] * fdtbl_UV[52]));YUVDU[181] = Math.round((YUVDU[181] * fdtbl_UV[53]));YUVDU[182] = Math.round((YUVDU[182] * fdtbl_UV[54]));YUVDU[183] = Math.round((YUVDU[183] * fdtbl_UV[55]));YUVDU[184] = Math.round((YUVDU[184] * fdtbl_UV[56]));YUVDU[185] = Math.round((YUVDU[185] * fdtbl_UV[57]));YUVDU[186] = Math.round((YUVDU[186] * fdtbl_UV[58]));YUVDU[187] = Math.round((YUVDU[187] * fdtbl_UV[59]));YUVDU[188] = Math.round((YUVDU[188] * fdtbl_UV[60]));YUVDU[189] = Math.round((YUVDU[189] * fdtbl_UV[61]));YUVDU[190] = Math.round((YUVDU[190] * fdtbl_UV[62]));YUVDU[191] = Math.round((YUVDU[191] * fdtbl_UV[63]));
			
			// ZigZag reorder
			//for(i=0;i<64;i++){DU[ZigZag[i]] = VDU[i];}
			DU[ZigZag[0]] = YUVDU[128];DU[ZigZag[1]] = YUVDU[129];DU[ZigZag[2]] = YUVDU[130];DU[ZigZag[3]] = YUVDU[131];DU[ZigZag[4]] = YUVDU[132];DU[ZigZag[5]] = YUVDU[133];DU[ZigZag[6]] = YUVDU[134];DU[ZigZag[7]] = YUVDU[135];DU[ZigZag[8]] = YUVDU[136];DU[ZigZag[9]] = YUVDU[137];DU[ZigZag[10]] = YUVDU[138];DU[ZigZag[11]] = YUVDU[139];DU[ZigZag[12]] = YUVDU[140];DU[ZigZag[13]] = YUVDU[141];DU[ZigZag[14]] = YUVDU[142];DU[ZigZag[15]] = YUVDU[143];DU[ZigZag[16]] = YUVDU[144];DU[ZigZag[17]] = YUVDU[145];DU[ZigZag[18]] = YUVDU[146];DU[ZigZag[19]] = YUVDU[147];DU[ZigZag[20]] = YUVDU[148];DU[ZigZag[21]] = YUVDU[149];DU[ZigZag[22]] = YUVDU[150];DU[ZigZag[23]] = YUVDU[151];DU[ZigZag[24]] = YUVDU[152];DU[ZigZag[25]] = YUVDU[153];DU[ZigZag[26]] = YUVDU[154];DU[ZigZag[27]] = YUVDU[155];DU[ZigZag[28]] = YUVDU[156];DU[ZigZag[29]] = YUVDU[157];DU[ZigZag[30]] = YUVDU[158];DU[ZigZag[31]] = YUVDU[159];DU[ZigZag[32]] = YUVDU[160];DU[ZigZag[33]] = YUVDU[161];DU[ZigZag[34]] = YUVDU[162];DU[ZigZag[35]] = YUVDU[163];DU[ZigZag[36]] = YUVDU[164];DU[ZigZag[37]] = YUVDU[165];DU[ZigZag[38]] = YUVDU[166];DU[ZigZag[39]] = YUVDU[167];DU[ZigZag[40]] = YUVDU[168];DU[ZigZag[41]] = YUVDU[169];DU[ZigZag[42]] = YUVDU[170];DU[ZigZag[43]] = YUVDU[171];DU[ZigZag[44]] = YUVDU[172];DU[ZigZag[45]] = YUVDU[173];DU[ZigZag[46]] = YUVDU[174];DU[ZigZag[47]] = YUVDU[175];DU[ZigZag[48]] = YUVDU[176];DU[ZigZag[49]] = YUVDU[177];DU[ZigZag[50]] = YUVDU[178];DU[ZigZag[51]] = YUVDU[179];DU[ZigZag[52]] = YUVDU[180];DU[ZigZag[53]] = YUVDU[181];DU[ZigZag[54]] = YUVDU[182];DU[ZigZag[55]] = YUVDU[183];DU[ZigZag[56]] = YUVDU[184];DU[ZigZag[57]] = YUVDU[185];DU[ZigZag[58]] = YUVDU[186];DU[ZigZag[59]] = YUVDU[187];DU[ZigZag[60]] = YUVDU[188];DU[ZigZag[61]] = YUVDU[189];DU[ZigZag[62]] = YUVDU[190];DU[ZigZag[63]] = YUVDU[191];
			
			Diff = DU[0] - DCV;
			DCV = DU[0];
			
			// Encode DCV
			if(Diff){// Diff might be 0
				bitStringId=category[32767 + Diff]*2;
				bGroupBitsOffset-=UVDC_HT[bitStringId+1];
				bGroupValue|=UVDC_HT[bitStringId]<<bGroupBitsOffset;
				//向 data 写入满8位(1字节)的数据:
				while(bGroupBitsOffset<24){byteout[offset++]=bGroupValue>>>24;if((bGroupValue>>>24)==0xff){byteout[offset++]=0x00;}bGroupValue<<=8;bGroupBitsOffset+=8;}
				
				bitStringId=(32767 + Diff)*2;
				bGroupBitsOffset-=bitcode[bitStringId+1];
				bGroupValue|=bitcode[bitStringId]<<bGroupBitsOffset;
				//向 data 写入满8位(1字节)的数据:
				while(bGroupBitsOffset<24){byteout[offset++]=bGroupValue>>>24;if((bGroupValue>>>24)==0xff){byteout[offset++]=0x00;}bGroupValue<<=8;bGroupBitsOffset+=8;}
			}else{
				bGroupBitsOffset-=UVDC_HT[1];
				bGroupValue|=UVDC_HT[0]<<bGroupBitsOffset;
				//向 data 写入满8位(1字节)的数据:
				while(bGroupBitsOffset<24){byteout[offset++]=bGroupValue>>>24;if((bGroupValue>>>24)==0xff){byteout[offset++]=0x00;}bGroupValue<<=8;bGroupBitsOffset+=8;}
			}
			
			// Encode ACs
			//var end0pos:int=64;
			//for (; (end0pos > 0) && (DU[end0pos] == 0); end0pos--){};
			if(DU[63]){end0pos=63;}else{if(DU[62]){end0pos=62;}else{if(DU[61]){end0pos=61;}else{if(DU[60]){end0pos=60;}else{if(DU[59]){end0pos=59;}else{if(DU[58]){end0pos=58;}else{if(DU[57]){end0pos=57;}else{if(DU[56]){end0pos=56;}else{if(DU[55]){end0pos=55;}else{if(DU[54]){end0pos=54;}else{if(DU[53]){end0pos=53;}else{if(DU[52]){end0pos=52;}else{if(DU[51]){end0pos=51;}else{if(DU[50]){end0pos=50;}else{if(DU[49]){end0pos=49;}else{if(DU[48]){end0pos=48;}else{if(DU[47]){end0pos=47;}else{if(DU[46]){end0pos=46;}else{if(DU[45]){end0pos=45;}else{if(DU[44]){end0pos=44;}else{if(DU[43]){end0pos=43;}else{if(DU[42]){end0pos=42;}else{if(DU[41]){end0pos=41;}else{if(DU[40]){end0pos=40;}else{if(DU[39]){end0pos=39;}else{if(DU[38]){end0pos=38;}else{if(DU[37]){end0pos=37;}else{if(DU[36]){end0pos=36;}else{if(DU[35]){end0pos=35;}else{if(DU[34]){end0pos=34;}else{if(DU[33]){end0pos=33;}else{if(DU[32]){end0pos=32;}else{if(DU[31]){end0pos=31;}else{if(DU[30]){end0pos=30;}else{if(DU[29]){end0pos=29;}else{if(DU[28]){end0pos=28;}else{if(DU[27]){end0pos=27;}else{if(DU[26]){end0pos=26;}else{if(DU[25]){end0pos=25;}else{if(DU[24]){end0pos=24;}else{if(DU[23]){end0pos=23;}else{if(DU[22]){end0pos=22;}else{if(DU[21]){end0pos=21;}else{if(DU[20]){end0pos=20;}else{if(DU[19]){end0pos=19;}else{if(DU[18]){end0pos=18;}else{if(DU[17]){end0pos=17;}else{if(DU[16]){end0pos=16;}else{if(DU[15]){end0pos=15;}else{if(DU[14]){end0pos=14;}else{if(DU[13]){end0pos=13;}else{if(DU[12]){end0pos=12;}else{if(DU[11]){end0pos=11;}else{if(DU[10]){end0pos=10;}else{if(DU[9]){end0pos=9;}else{if(DU[8]){end0pos=8;}else{if(DU[7]){end0pos=7;}else{if(DU[6]){end0pos=6;}else{if(DU[5]){end0pos=5;}else{if(DU[4]){end0pos=4;}else{if(DU[3]){end0pos=3;}else{if(DU[2]){end0pos=2;}else{if(DU[1]){end0pos=1;}else{end0pos=0;}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}
			
			// end0pos = first element in reverse order != 0
			if(end0pos){
				i = 0;
				while(i++<end0pos){
					startpos = i;
					//for (; (DU[i] == 0) && (i <= end0pos); i++){}
					while(i <= end0pos){
						if(DU[i]){
							break;
						}
						i++;
					}
					nrzeroes = i - startpos;
					
					if(nrzeroes<16){
					}else{
						nrmarker=nrzeroes / 16;
						while(nrmarker--){
							bGroupBitsOffset-=UVAC_HT[481];
							bGroupValue|=UVAC_HT[480]<<bGroupBitsOffset;
							//向 data 写入满8位(1字节)的数据:
							while(bGroupBitsOffset<24){byteout[offset++]=bGroupValue>>>24;if((bGroupValue>>>24)==0xff){byteout[offset++]=0x00;}bGroupValue<<=8;bGroupBitsOffset+=8;}
						}
						nrzeroes = nrzeroes & 0xF;
					}
					
					bitStringId=(nrzeroes * 16 + category[32767 + DU[i]])*2;
					bGroupBitsOffset-=UVAC_HT[bitStringId+1];
					bGroupValue|=UVAC_HT[bitStringId]<<bGroupBitsOffset;
					//向 data 写入满8位(1字节)的数据:
					while(bGroupBitsOffset<24){byteout[offset++]=bGroupValue>>>24;if((bGroupValue>>>24)==0xff){byteout[offset++]=0x00;}bGroupValue<<=8;bGroupBitsOffset+=8;}
					
					bitStringId=(32767 + DU[i])*2;
					bGroupBitsOffset-=bitcode[bitStringId+1];
					bGroupValue|=bitcode[bitStringId]<<bGroupBitsOffset;
					//向 data 写入满8位(1字节)的数据:
					while(bGroupBitsOffset<24){byteout[offset++]=bGroupValue>>>24;if((bGroupValue>>>24)==0xff){byteout[offset++]=0x00;}bGroupValue<<=8;bGroupBitsOffset+=8;}
				}
				
				if (end0pos == 63){
				}else{
					bGroupBitsOffset-=UVAC_HT[1];
					bGroupValue|=UVAC_HT[0]<<bGroupBitsOffset;
					//向 data 写入满8位(1字节)的数据:
					while(bGroupBitsOffset<24){byteout[offset++]=bGroupValue>>>24;if((bGroupValue>>>24)==0xff){byteout[offset++]=0x00;}bGroupValue<<=8;bGroupBitsOffset+=8;}
				}
			}else{
				bGroupBitsOffset-=UVAC_HT[1];
				bGroupValue|=UVAC_HT[0]<<bGroupBitsOffset;
				//向 data 写入满8位(1字节)的数据:
				while(bGroupBitsOffset<24){byteout[offset++]=bGroupValue>>>24;if((bGroupValue>>>24)==0xff){byteout[offset++]=0x00;}bGroupValue<<=8;bGroupBitsOffset+=8;}
			}
		}
		
		//向 data 写入有效的数据:
		while(bGroupBitsOffset<32){
			byteout[offset++]=bGroupValue>>>24;
			if((bGroupValue>>>24)==0xff){
				byteout[offset++]=0x00;
			}
			bGroupValue<<=8;
			bGroupBitsOffset+=8;
		}
		
        // Add EOI
		byteout[offset++]=0xFF;
		byteout[offset++]=0xD9;
        
		return byteout;
    }
}

}