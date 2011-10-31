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

import flash.display.BitmapData;
import flash.utils.ByteArray;

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
    public function JPEGEncoder(quality:int=50){
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
	
	public static function encode(bitmapData:BitmapData,quality:int):ByteArray{
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
    public function encode(bitmapData:BitmapData):ByteArray
    {
        return internalEncode(bitmapData, bitmapData.width, bitmapData.height,
							  bitmapData.transparent);
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
    public function encodeByteArray(byteArray:ByteArray, width:int, height:int,
									transparent:Boolean = true):ByteArray
    {
        return internalEncode(byteArray, width, height, transparent);
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
	
	private function normalizeBytes(bytes:ByteArray,width:int,height:int):ByteArray{
		
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

	//--------------------------------------------------------------------------
	//
	//  Methods: Core processing
	//
	//--------------------------------------------------------------------------

    /**
	 *  @private
	 */
	private function internalEncode(source:Object, width:int, height:int,
									transparent:Boolean = true):ByteArray
    {
		//trace("width="+width+",height="+height);
    	// The source is either a BitmapData or a ByteArray.
		var sourceByteArray:ByteArray;
		if(source is BitmapData){
			sourceByteArray = (source as BitmapData).getPixels((source as BitmapData).rect);
		}else{
			sourceByteArray = source as ByteArray;
		}
		
		sourceByteArray=normalizeBytes(sourceByteArray,width,height);
		
		var normalizeWidth:int=Math.ceil(width/8)*8;
		var normalizeHeight:int=Math.ceil(height/8)*8;
		
		/*
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
		var YDU:Vector.<Number>=new Vector.<Number>(64);
		YDU.fixed=true;
		var UDU:Vector.<Number>=new Vector.<Number>(64);
		UDU.fixed=true;
		var VDU:Vector.<Number>=new Vector.<Number>(64);
		VDU.fixed=true;
		
		var DCY:Number = 0;
		var DCU:Number = 0;
		var DCV:Number = 0;
		
		var I0:int=normalizeWidth/8;
		var posY:int=0;
		var DPosYY:int=28*normalizeWidth;
		var J:int=normalizeHeight/8;
		while(J--){
			var I:int=I0;
			while(I--){
				
				var position:int,r:int,g:int,b:int;
				position=posY+1;r=sourceByteArray[position++];g=sourceByteArray[position++];b=sourceByteArray[position++];YDU[0] =  0.29900 * r + 0.58700 * g + 0.11400 * b - 128.0;UDU[0] = -0.16874 * r - 0.33126 * g + 0.50000 * b;VDU[0] =  0.50000 * r - 0.41869 * g - 0.08131 * b;
				position++;r=sourceByteArray[position++];g=sourceByteArray[position++];b=sourceByteArray[position++];YDU[1] =  0.29900 * r + 0.58700 * g + 0.11400 * b - 128.0;UDU[1] = -0.16874 * r - 0.33126 * g + 0.50000 * b;VDU[1] =  0.50000 * r - 0.41869 * g - 0.08131 * b;
				position++;r=sourceByteArray[position++];g=sourceByteArray[position++];b=sourceByteArray[position++];YDU[2] =  0.29900 * r + 0.58700 * g + 0.11400 * b - 128.0;UDU[2] = -0.16874 * r - 0.33126 * g + 0.50000 * b;VDU[2] =  0.50000 * r - 0.41869 * g - 0.08131 * b;
				position++;r=sourceByteArray[position++];g=sourceByteArray[position++];b=sourceByteArray[position++];YDU[3] =  0.29900 * r + 0.58700 * g + 0.11400 * b - 128.0;UDU[3] = -0.16874 * r - 0.33126 * g + 0.50000 * b;VDU[3] =  0.50000 * r - 0.41869 * g - 0.08131 * b;
				position++;r=sourceByteArray[position++];g=sourceByteArray[position++];b=sourceByteArray[position++];YDU[4] =  0.29900 * r + 0.58700 * g + 0.11400 * b - 128.0;UDU[4] = -0.16874 * r - 0.33126 * g + 0.50000 * b;VDU[4] =  0.50000 * r - 0.41869 * g - 0.08131 * b;
				position++;r=sourceByteArray[position++];g=sourceByteArray[position++];b=sourceByteArray[position++];YDU[5] =  0.29900 * r + 0.58700 * g + 0.11400 * b - 128.0;UDU[5] = -0.16874 * r - 0.33126 * g + 0.50000 * b;VDU[5] =  0.50000 * r - 0.41869 * g - 0.08131 * b;
				position++;r=sourceByteArray[position++];g=sourceByteArray[position++];b=sourceByteArray[position++];YDU[6] =  0.29900 * r + 0.58700 * g + 0.11400 * b - 128.0;UDU[6] = -0.16874 * r - 0.33126 * g + 0.50000 * b;VDU[6] =  0.50000 * r - 0.41869 * g - 0.08131 * b;
				position++;r=sourceByteArray[position++];g=sourceByteArray[position++];b=sourceByteArray[position++];YDU[7] =  0.29900 * r + 0.58700 * g + 0.11400 * b - 128.0;UDU[7] = -0.16874 * r - 0.33126 * g + 0.50000 * b;VDU[7] =  0.50000 * r - 0.41869 * g - 0.08131 * b;
				position=posY+4*normalizeWidth+1;r=sourceByteArray[position++];g=sourceByteArray[position++];b=sourceByteArray[position++];YDU[8] =  0.29900 * r + 0.58700 * g + 0.11400 * b - 128.0;UDU[8] = -0.16874 * r - 0.33126 * g + 0.50000 * b;VDU[8] =  0.50000 * r - 0.41869 * g - 0.08131 * b;
				position++;r=sourceByteArray[position++];g=sourceByteArray[position++];b=sourceByteArray[position++];YDU[9] =  0.29900 * r + 0.58700 * g + 0.11400 * b - 128.0;UDU[9] = -0.16874 * r - 0.33126 * g + 0.50000 * b;VDU[9] =  0.50000 * r - 0.41869 * g - 0.08131 * b;
				position++;r=sourceByteArray[position++];g=sourceByteArray[position++];b=sourceByteArray[position++];YDU[10] =  0.29900 * r + 0.58700 * g + 0.11400 * b - 128.0;UDU[10] = -0.16874 * r - 0.33126 * g + 0.50000 * b;VDU[10] =  0.50000 * r - 0.41869 * g - 0.08131 * b;
				position++;r=sourceByteArray[position++];g=sourceByteArray[position++];b=sourceByteArray[position++];YDU[11] =  0.29900 * r + 0.58700 * g + 0.11400 * b - 128.0;UDU[11] = -0.16874 * r - 0.33126 * g + 0.50000 * b;VDU[11] =  0.50000 * r - 0.41869 * g - 0.08131 * b;
				position++;r=sourceByteArray[position++];g=sourceByteArray[position++];b=sourceByteArray[position++];YDU[12] =  0.29900 * r + 0.58700 * g + 0.11400 * b - 128.0;UDU[12] = -0.16874 * r - 0.33126 * g + 0.50000 * b;VDU[12] =  0.50000 * r - 0.41869 * g - 0.08131 * b;
				position++;r=sourceByteArray[position++];g=sourceByteArray[position++];b=sourceByteArray[position++];YDU[13] =  0.29900 * r + 0.58700 * g + 0.11400 * b - 128.0;UDU[13] = -0.16874 * r - 0.33126 * g + 0.50000 * b;VDU[13] =  0.50000 * r - 0.41869 * g - 0.08131 * b;
				position++;r=sourceByteArray[position++];g=sourceByteArray[position++];b=sourceByteArray[position++];YDU[14] =  0.29900 * r + 0.58700 * g + 0.11400 * b - 128.0;UDU[14] = -0.16874 * r - 0.33126 * g + 0.50000 * b;VDU[14] =  0.50000 * r - 0.41869 * g - 0.08131 * b;
				position++;r=sourceByteArray[position++];g=sourceByteArray[position++];b=sourceByteArray[position++];YDU[15] =  0.29900 * r + 0.58700 * g + 0.11400 * b - 128.0;UDU[15] = -0.16874 * r - 0.33126 * g + 0.50000 * b;VDU[15] =  0.50000 * r - 0.41869 * g - 0.08131 * b;
				position=posY+8*normalizeWidth+1;r=sourceByteArray[position++];g=sourceByteArray[position++];b=sourceByteArray[position++];YDU[16] =  0.29900 * r + 0.58700 * g + 0.11400 * b - 128.0;UDU[16] = -0.16874 * r - 0.33126 * g + 0.50000 * b;VDU[16] =  0.50000 * r - 0.41869 * g - 0.08131 * b;
				position++;r=sourceByteArray[position++];g=sourceByteArray[position++];b=sourceByteArray[position++];YDU[17] =  0.29900 * r + 0.58700 * g + 0.11400 * b - 128.0;UDU[17] = -0.16874 * r - 0.33126 * g + 0.50000 * b;VDU[17] =  0.50000 * r - 0.41869 * g - 0.08131 * b;
				position++;r=sourceByteArray[position++];g=sourceByteArray[position++];b=sourceByteArray[position++];YDU[18] =  0.29900 * r + 0.58700 * g + 0.11400 * b - 128.0;UDU[18] = -0.16874 * r - 0.33126 * g + 0.50000 * b;VDU[18] =  0.50000 * r - 0.41869 * g - 0.08131 * b;
				position++;r=sourceByteArray[position++];g=sourceByteArray[position++];b=sourceByteArray[position++];YDU[19] =  0.29900 * r + 0.58700 * g + 0.11400 * b - 128.0;UDU[19] = -0.16874 * r - 0.33126 * g + 0.50000 * b;VDU[19] =  0.50000 * r - 0.41869 * g - 0.08131 * b;
				position++;r=sourceByteArray[position++];g=sourceByteArray[position++];b=sourceByteArray[position++];YDU[20] =  0.29900 * r + 0.58700 * g + 0.11400 * b - 128.0;UDU[20] = -0.16874 * r - 0.33126 * g + 0.50000 * b;VDU[20] =  0.50000 * r - 0.41869 * g - 0.08131 * b;
				position++;r=sourceByteArray[position++];g=sourceByteArray[position++];b=sourceByteArray[position++];YDU[21] =  0.29900 * r + 0.58700 * g + 0.11400 * b - 128.0;UDU[21] = -0.16874 * r - 0.33126 * g + 0.50000 * b;VDU[21] =  0.50000 * r - 0.41869 * g - 0.08131 * b;
				position++;r=sourceByteArray[position++];g=sourceByteArray[position++];b=sourceByteArray[position++];YDU[22] =  0.29900 * r + 0.58700 * g + 0.11400 * b - 128.0;UDU[22] = -0.16874 * r - 0.33126 * g + 0.50000 * b;VDU[22] =  0.50000 * r - 0.41869 * g - 0.08131 * b;
				position++;r=sourceByteArray[position++];g=sourceByteArray[position++];b=sourceByteArray[position++];YDU[23] =  0.29900 * r + 0.58700 * g + 0.11400 * b - 128.0;UDU[23] = -0.16874 * r - 0.33126 * g + 0.50000 * b;VDU[23] =  0.50000 * r - 0.41869 * g - 0.08131 * b;
				position=posY+12*normalizeWidth+1;r=sourceByteArray[position++];g=sourceByteArray[position++];b=sourceByteArray[position++];YDU[24] =  0.29900 * r + 0.58700 * g + 0.11400 * b - 128.0;UDU[24] = -0.16874 * r - 0.33126 * g + 0.50000 * b;VDU[24] =  0.50000 * r - 0.41869 * g - 0.08131 * b;
				position++;r=sourceByteArray[position++];g=sourceByteArray[position++];b=sourceByteArray[position++];YDU[25] =  0.29900 * r + 0.58700 * g + 0.11400 * b - 128.0;UDU[25] = -0.16874 * r - 0.33126 * g + 0.50000 * b;VDU[25] =  0.50000 * r - 0.41869 * g - 0.08131 * b;
				position++;r=sourceByteArray[position++];g=sourceByteArray[position++];b=sourceByteArray[position++];YDU[26] =  0.29900 * r + 0.58700 * g + 0.11400 * b - 128.0;UDU[26] = -0.16874 * r - 0.33126 * g + 0.50000 * b;VDU[26] =  0.50000 * r - 0.41869 * g - 0.08131 * b;
				position++;r=sourceByteArray[position++];g=sourceByteArray[position++];b=sourceByteArray[position++];YDU[27] =  0.29900 * r + 0.58700 * g + 0.11400 * b - 128.0;UDU[27] = -0.16874 * r - 0.33126 * g + 0.50000 * b;VDU[27] =  0.50000 * r - 0.41869 * g - 0.08131 * b;
				position++;r=sourceByteArray[position++];g=sourceByteArray[position++];b=sourceByteArray[position++];YDU[28] =  0.29900 * r + 0.58700 * g + 0.11400 * b - 128.0;UDU[28] = -0.16874 * r - 0.33126 * g + 0.50000 * b;VDU[28] =  0.50000 * r - 0.41869 * g - 0.08131 * b;
				position++;r=sourceByteArray[position++];g=sourceByteArray[position++];b=sourceByteArray[position++];YDU[29] =  0.29900 * r + 0.58700 * g + 0.11400 * b - 128.0;UDU[29] = -0.16874 * r - 0.33126 * g + 0.50000 * b;VDU[29] =  0.50000 * r - 0.41869 * g - 0.08131 * b;
				position++;r=sourceByteArray[position++];g=sourceByteArray[position++];b=sourceByteArray[position++];YDU[30] =  0.29900 * r + 0.58700 * g + 0.11400 * b - 128.0;UDU[30] = -0.16874 * r - 0.33126 * g + 0.50000 * b;VDU[30] =  0.50000 * r - 0.41869 * g - 0.08131 * b;
				position++;r=sourceByteArray[position++];g=sourceByteArray[position++];b=sourceByteArray[position++];YDU[31] =  0.29900 * r + 0.58700 * g + 0.11400 * b - 128.0;UDU[31] = -0.16874 * r - 0.33126 * g + 0.50000 * b;VDU[31] =  0.50000 * r - 0.41869 * g - 0.08131 * b;
				position=posY+16*normalizeWidth+1;r=sourceByteArray[position++];g=sourceByteArray[position++];b=sourceByteArray[position++];YDU[32] =  0.29900 * r + 0.58700 * g + 0.11400 * b - 128.0;UDU[32] = -0.16874 * r - 0.33126 * g + 0.50000 * b;VDU[32] =  0.50000 * r - 0.41869 * g - 0.08131 * b;
				position++;r=sourceByteArray[position++];g=sourceByteArray[position++];b=sourceByteArray[position++];YDU[33] =  0.29900 * r + 0.58700 * g + 0.11400 * b - 128.0;UDU[33] = -0.16874 * r - 0.33126 * g + 0.50000 * b;VDU[33] =  0.50000 * r - 0.41869 * g - 0.08131 * b;
				position++;r=sourceByteArray[position++];g=sourceByteArray[position++];b=sourceByteArray[position++];YDU[34] =  0.29900 * r + 0.58700 * g + 0.11400 * b - 128.0;UDU[34] = -0.16874 * r - 0.33126 * g + 0.50000 * b;VDU[34] =  0.50000 * r - 0.41869 * g - 0.08131 * b;
				position++;r=sourceByteArray[position++];g=sourceByteArray[position++];b=sourceByteArray[position++];YDU[35] =  0.29900 * r + 0.58700 * g + 0.11400 * b - 128.0;UDU[35] = -0.16874 * r - 0.33126 * g + 0.50000 * b;VDU[35] =  0.50000 * r - 0.41869 * g - 0.08131 * b;
				position++;r=sourceByteArray[position++];g=sourceByteArray[position++];b=sourceByteArray[position++];YDU[36] =  0.29900 * r + 0.58700 * g + 0.11400 * b - 128.0;UDU[36] = -0.16874 * r - 0.33126 * g + 0.50000 * b;VDU[36] =  0.50000 * r - 0.41869 * g - 0.08131 * b;
				position++;r=sourceByteArray[position++];g=sourceByteArray[position++];b=sourceByteArray[position++];YDU[37] =  0.29900 * r + 0.58700 * g + 0.11400 * b - 128.0;UDU[37] = -0.16874 * r - 0.33126 * g + 0.50000 * b;VDU[37] =  0.50000 * r - 0.41869 * g - 0.08131 * b;
				position++;r=sourceByteArray[position++];g=sourceByteArray[position++];b=sourceByteArray[position++];YDU[38] =  0.29900 * r + 0.58700 * g + 0.11400 * b - 128.0;UDU[38] = -0.16874 * r - 0.33126 * g + 0.50000 * b;VDU[38] =  0.50000 * r - 0.41869 * g - 0.08131 * b;
				position++;r=sourceByteArray[position++];g=sourceByteArray[position++];b=sourceByteArray[position++];YDU[39] =  0.29900 * r + 0.58700 * g + 0.11400 * b - 128.0;UDU[39] = -0.16874 * r - 0.33126 * g + 0.50000 * b;VDU[39] =  0.50000 * r - 0.41869 * g - 0.08131 * b;
				position=posY+20*normalizeWidth+1;r=sourceByteArray[position++];g=sourceByteArray[position++];b=sourceByteArray[position++];YDU[40] =  0.29900 * r + 0.58700 * g + 0.11400 * b - 128.0;UDU[40] = -0.16874 * r - 0.33126 * g + 0.50000 * b;VDU[40] =  0.50000 * r - 0.41869 * g - 0.08131 * b;
				position++;r=sourceByteArray[position++];g=sourceByteArray[position++];b=sourceByteArray[position++];YDU[41] =  0.29900 * r + 0.58700 * g + 0.11400 * b - 128.0;UDU[41] = -0.16874 * r - 0.33126 * g + 0.50000 * b;VDU[41] =  0.50000 * r - 0.41869 * g - 0.08131 * b;
				position++;r=sourceByteArray[position++];g=sourceByteArray[position++];b=sourceByteArray[position++];YDU[42] =  0.29900 * r + 0.58700 * g + 0.11400 * b - 128.0;UDU[42] = -0.16874 * r - 0.33126 * g + 0.50000 * b;VDU[42] =  0.50000 * r - 0.41869 * g - 0.08131 * b;
				position++;r=sourceByteArray[position++];g=sourceByteArray[position++];b=sourceByteArray[position++];YDU[43] =  0.29900 * r + 0.58700 * g + 0.11400 * b - 128.0;UDU[43] = -0.16874 * r - 0.33126 * g + 0.50000 * b;VDU[43] =  0.50000 * r - 0.41869 * g - 0.08131 * b;
				position++;r=sourceByteArray[position++];g=sourceByteArray[position++];b=sourceByteArray[position++];YDU[44] =  0.29900 * r + 0.58700 * g + 0.11400 * b - 128.0;UDU[44] = -0.16874 * r - 0.33126 * g + 0.50000 * b;VDU[44] =  0.50000 * r - 0.41869 * g - 0.08131 * b;
				position++;r=sourceByteArray[position++];g=sourceByteArray[position++];b=sourceByteArray[position++];YDU[45] =  0.29900 * r + 0.58700 * g + 0.11400 * b - 128.0;UDU[45] = -0.16874 * r - 0.33126 * g + 0.50000 * b;VDU[45] =  0.50000 * r - 0.41869 * g - 0.08131 * b;
				position++;r=sourceByteArray[position++];g=sourceByteArray[position++];b=sourceByteArray[position++];YDU[46] =  0.29900 * r + 0.58700 * g + 0.11400 * b - 128.0;UDU[46] = -0.16874 * r - 0.33126 * g + 0.50000 * b;VDU[46] =  0.50000 * r - 0.41869 * g - 0.08131 * b;
				position++;r=sourceByteArray[position++];g=sourceByteArray[position++];b=sourceByteArray[position++];YDU[47] =  0.29900 * r + 0.58700 * g + 0.11400 * b - 128.0;UDU[47] = -0.16874 * r - 0.33126 * g + 0.50000 * b;VDU[47] =  0.50000 * r - 0.41869 * g - 0.08131 * b;
				position=posY+24*normalizeWidth+1;r=sourceByteArray[position++];g=sourceByteArray[position++];b=sourceByteArray[position++];YDU[48] =  0.29900 * r + 0.58700 * g + 0.11400 * b - 128.0;UDU[48] = -0.16874 * r - 0.33126 * g + 0.50000 * b;VDU[48] =  0.50000 * r - 0.41869 * g - 0.08131 * b;
				position++;r=sourceByteArray[position++];g=sourceByteArray[position++];b=sourceByteArray[position++];YDU[49] =  0.29900 * r + 0.58700 * g + 0.11400 * b - 128.0;UDU[49] = -0.16874 * r - 0.33126 * g + 0.50000 * b;VDU[49] =  0.50000 * r - 0.41869 * g - 0.08131 * b;
				position++;r=sourceByteArray[position++];g=sourceByteArray[position++];b=sourceByteArray[position++];YDU[50] =  0.29900 * r + 0.58700 * g + 0.11400 * b - 128.0;UDU[50] = -0.16874 * r - 0.33126 * g + 0.50000 * b;VDU[50] =  0.50000 * r - 0.41869 * g - 0.08131 * b;
				position++;r=sourceByteArray[position++];g=sourceByteArray[position++];b=sourceByteArray[position++];YDU[51] =  0.29900 * r + 0.58700 * g + 0.11400 * b - 128.0;UDU[51] = -0.16874 * r - 0.33126 * g + 0.50000 * b;VDU[51] =  0.50000 * r - 0.41869 * g - 0.08131 * b;
				position++;r=sourceByteArray[position++];g=sourceByteArray[position++];b=sourceByteArray[position++];YDU[52] =  0.29900 * r + 0.58700 * g + 0.11400 * b - 128.0;UDU[52] = -0.16874 * r - 0.33126 * g + 0.50000 * b;VDU[52] =  0.50000 * r - 0.41869 * g - 0.08131 * b;
				position++;r=sourceByteArray[position++];g=sourceByteArray[position++];b=sourceByteArray[position++];YDU[53] =  0.29900 * r + 0.58700 * g + 0.11400 * b - 128.0;UDU[53] = -0.16874 * r - 0.33126 * g + 0.50000 * b;VDU[53] =  0.50000 * r - 0.41869 * g - 0.08131 * b;
				position++;r=sourceByteArray[position++];g=sourceByteArray[position++];b=sourceByteArray[position++];YDU[54] =  0.29900 * r + 0.58700 * g + 0.11400 * b - 128.0;UDU[54] = -0.16874 * r - 0.33126 * g + 0.50000 * b;VDU[54] =  0.50000 * r - 0.41869 * g - 0.08131 * b;
				position++;r=sourceByteArray[position++];g=sourceByteArray[position++];b=sourceByteArray[position++];YDU[55] =  0.29900 * r + 0.58700 * g + 0.11400 * b - 128.0;UDU[55] = -0.16874 * r - 0.33126 * g + 0.50000 * b;VDU[55] =  0.50000 * r - 0.41869 * g - 0.08131 * b;
				position=posY+28*normalizeWidth+1;r=sourceByteArray[position++];g=sourceByteArray[position++];b=sourceByteArray[position++];YDU[56] =  0.29900 * r + 0.58700 * g + 0.11400 * b - 128.0;UDU[56] = -0.16874 * r - 0.33126 * g + 0.50000 * b;VDU[56] =  0.50000 * r - 0.41869 * g - 0.08131 * b;
				position++;r=sourceByteArray[position++];g=sourceByteArray[position++];b=sourceByteArray[position++];YDU[57] =  0.29900 * r + 0.58700 * g + 0.11400 * b - 128.0;UDU[57] = -0.16874 * r - 0.33126 * g + 0.50000 * b;VDU[57] =  0.50000 * r - 0.41869 * g - 0.08131 * b;
				position++;r=sourceByteArray[position++];g=sourceByteArray[position++];b=sourceByteArray[position++];YDU[58] =  0.29900 * r + 0.58700 * g + 0.11400 * b - 128.0;UDU[58] = -0.16874 * r - 0.33126 * g + 0.50000 * b;VDU[58] =  0.50000 * r - 0.41869 * g - 0.08131 * b;
				position++;r=sourceByteArray[position++];g=sourceByteArray[position++];b=sourceByteArray[position++];YDU[59] =  0.29900 * r + 0.58700 * g + 0.11400 * b - 128.0;UDU[59] = -0.16874 * r - 0.33126 * g + 0.50000 * b;VDU[59] =  0.50000 * r - 0.41869 * g - 0.08131 * b;
				position++;r=sourceByteArray[position++];g=sourceByteArray[position++];b=sourceByteArray[position++];YDU[60] =  0.29900 * r + 0.58700 * g + 0.11400 * b - 128.0;UDU[60] = -0.16874 * r - 0.33126 * g + 0.50000 * b;VDU[60] =  0.50000 * r - 0.41869 * g - 0.08131 * b;
				position++;r=sourceByteArray[position++];g=sourceByteArray[position++];b=sourceByteArray[position++];YDU[61] =  0.29900 * r + 0.58700 * g + 0.11400 * b - 128.0;UDU[61] = -0.16874 * r - 0.33126 * g + 0.50000 * b;VDU[61] =  0.50000 * r - 0.41869 * g - 0.08131 * b;
				position++;r=sourceByteArray[position++];g=sourceByteArray[position++];b=sourceByteArray[position++];YDU[62] =  0.29900 * r + 0.58700 * g + 0.11400 * b - 128.0;UDU[62] = -0.16874 * r - 0.33126 * g + 0.50000 * b;VDU[62] =  0.50000 * r - 0.41869 * g - 0.08131 * b;
				position++;r=sourceByteArray[position++];g=sourceByteArray[position++];b=sourceByteArray[position++];YDU[63] =  0.29900 * r + 0.58700 * g + 0.11400 * b - 128.0;UDU[63] = -0.16874 * r - 0.33126 * g + 0.50000 * b;VDU[63] =  0.50000 * r - 0.41869 * g - 0.08131 * b;
				
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
				
				//processDU(YDU, fdtbl_Y, DCY, YDC_HT, YAC_HT,processObj);
				
				// Pass 1: process rows.
				tmp0 = YDU[0] + YDU[7];tmp7 = YDU[0] - YDU[7];tmp1 = YDU[1] + YDU[6];tmp6 = YDU[1] - YDU[6];tmp2 = YDU[2] + YDU[5];tmp5 = YDU[2] - YDU[5];tmp3 = YDU[3] + YDU[4];tmp4 = YDU[3] - YDU[4];
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				YDU[0] = tmp10 + tmp11;YDU[4] = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				YDU[2] = tmp13 + z1;YDU[6] = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				YDU[5] = z13 + z2;YDU[3] = z13 - z2;YDU[1] = z11 + z4;YDU[7] = z11 - z4;
				
				tmp0 = YDU[8] + YDU[15];tmp7 = YDU[8] - YDU[15];tmp1 = YDU[9] + YDU[14];tmp6 = YDU[9] - YDU[14];tmp2 = YDU[10] + YDU[13];tmp5 = YDU[10] - YDU[13];tmp3 = YDU[11] + YDU[12];tmp4 = YDU[11] - YDU[12];
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				YDU[8] = tmp10 + tmp11;YDU[12] = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				YDU[10] = tmp13 + z1;YDU[14] = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				YDU[13] = z13 + z2;YDU[11] = z13 - z2;YDU[9] = z11 + z4;YDU[15] = z11 - z4;
				
				tmp0 = YDU[16] + YDU[23];tmp7 = YDU[16] - YDU[23];tmp1 = YDU[17] + YDU[22];tmp6 = YDU[17] - YDU[22];tmp2 = YDU[18] + YDU[21];tmp5 = YDU[18] - YDU[21];tmp3 = YDU[19] + YDU[20];tmp4 = YDU[19] - YDU[20];
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				YDU[16] = tmp10 + tmp11;YDU[20] = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				YDU[18] = tmp13 + z1;YDU[22] = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				YDU[21] = z13 + z2;YDU[19] = z13 - z2;YDU[17] = z11 + z4;YDU[23] = z11 - z4;
				
				tmp0 = YDU[24] + YDU[31];tmp7 = YDU[24] - YDU[31];tmp1 = YDU[25] + YDU[30];tmp6 = YDU[25] - YDU[30];tmp2 = YDU[26] + YDU[29];tmp5 = YDU[26] - YDU[29];tmp3 = YDU[27] + YDU[28];tmp4 = YDU[27] - YDU[28];
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				YDU[24] = tmp10 + tmp11;YDU[28] = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				YDU[26] = tmp13 + z1;YDU[30] = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				YDU[29] = z13 + z2;YDU[27] = z13 - z2;YDU[25] = z11 + z4;YDU[31] = z11 - z4;
				
				tmp0 = YDU[32] + YDU[39];tmp7 = YDU[32] - YDU[39];tmp1 = YDU[33] + YDU[38];tmp6 = YDU[33] - YDU[38];tmp2 = YDU[34] + YDU[37];tmp5 = YDU[34] - YDU[37];tmp3 = YDU[35] + YDU[36];tmp4 = YDU[35] - YDU[36];
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				YDU[32] = tmp10 + tmp11;YDU[36] = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				YDU[34] = tmp13 + z1;YDU[38] = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				YDU[37] = z13 + z2;YDU[35] = z13 - z2;YDU[33] = z11 + z4;YDU[39] = z11 - z4;
				
				tmp0 = YDU[40] + YDU[47];tmp7 = YDU[40] - YDU[47];tmp1 = YDU[41] + YDU[46];tmp6 = YDU[41] - YDU[46];tmp2 = YDU[42] + YDU[45];tmp5 = YDU[42] - YDU[45];tmp3 = YDU[43] + YDU[44];tmp4 = YDU[43] - YDU[44];
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				YDU[40] = tmp10 + tmp11;YDU[44] = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				YDU[42] = tmp13 + z1;YDU[46] = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				YDU[45] = z13 + z2;YDU[43] = z13 - z2;YDU[41] = z11 + z4;YDU[47] = z11 - z4;
				
				tmp0 = YDU[48] + YDU[55];tmp7 = YDU[48] - YDU[55];tmp1 = YDU[49] + YDU[54];tmp6 = YDU[49] - YDU[54];tmp2 = YDU[50] + YDU[53];tmp5 = YDU[50] - YDU[53];tmp3 = YDU[51] + YDU[52];tmp4 = YDU[51] - YDU[52];
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				YDU[48] = tmp10 + tmp11;YDU[52] = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				YDU[50] = tmp13 + z1;YDU[54] = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				YDU[53] = z13 + z2;YDU[51] = z13 - z2;YDU[49] = z11 + z4;YDU[55] = z11 - z4;
				
				tmp0 = YDU[56] + YDU[63];tmp7 = YDU[56] - YDU[63];tmp1 = YDU[57] + YDU[62];tmp6 = YDU[57] - YDU[62];tmp2 = YDU[58] + YDU[61];tmp5 = YDU[58] - YDU[61];tmp3 = YDU[59] + YDU[60];tmp4 = YDU[59] - YDU[60];
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				YDU[56] = tmp10 + tmp11;YDU[60] = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				YDU[58] = tmp13 + z1;YDU[62] = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				YDU[61] = z13 + z2;YDU[59] = z13 - z2;YDU[57] = z11 + z4;YDU[63] = z11 - z4;
				
				// Pass 2: process columns.
				tmp0 = YDU[0] + YDU[56];tmp7 = YDU[0] - YDU[56];tmp1 = YDU[8] + YDU[48];tmp6 = YDU[8] - YDU[48];tmp2 = YDU[16] + YDU[40];tmp5 = YDU[16] - YDU[40];tmp3 = YDU[24] + YDU[32];tmp4 = YDU[24] - YDU[32];
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				YDU[0] = tmp10 + tmp11;YDU[32] = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				YDU[16] = tmp13 + z1;YDU[48] = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				YDU[40] = z13 + z2;YDU[24] = z13 - z2;YDU[8] = z11 + z4;YDU[56] = z11 - z4;
				
				tmp0 = YDU[1] + YDU[57];tmp7 = YDU[1] - YDU[57];tmp1 = YDU[9] + YDU[49];tmp6 = YDU[9] - YDU[49];tmp2 = YDU[17] + YDU[41];tmp5 = YDU[17] - YDU[41];tmp3 = YDU[25] + YDU[33];tmp4 = YDU[25] - YDU[33];
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				YDU[1] = tmp10 + tmp11;YDU[33] = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				YDU[17] = tmp13 + z1;YDU[49] = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				YDU[41] = z13 + z2;YDU[25] = z13 - z2;YDU[9] = z11 + z4;YDU[57] = z11 - z4;
				
				tmp0 = YDU[2] + YDU[58];tmp7 = YDU[2] - YDU[58];tmp1 = YDU[10] + YDU[50];tmp6 = YDU[10] - YDU[50];tmp2 = YDU[18] + YDU[42];tmp5 = YDU[18] - YDU[42];tmp3 = YDU[26] + YDU[34];tmp4 = YDU[26] - YDU[34];
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				YDU[2] = tmp10 + tmp11;YDU[34] = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				YDU[18] = tmp13 + z1;YDU[50] = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				YDU[42] = z13 + z2;YDU[26] = z13 - z2;YDU[10] = z11 + z4;YDU[58] = z11 - z4;
				
				tmp0 = YDU[3] + YDU[59];tmp7 = YDU[3] - YDU[59];tmp1 = YDU[11] + YDU[51];tmp6 = YDU[11] - YDU[51];tmp2 = YDU[19] + YDU[43];tmp5 = YDU[19] - YDU[43];tmp3 = YDU[27] + YDU[35];tmp4 = YDU[27] - YDU[35];
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				YDU[3] = tmp10 + tmp11;YDU[35] = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				YDU[19] = tmp13 + z1;YDU[51] = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				YDU[43] = z13 + z2;YDU[27] = z13 - z2;YDU[11] = z11 + z4;YDU[59] = z11 - z4;
				
				tmp0 = YDU[4] + YDU[60];tmp7 = YDU[4] - YDU[60];tmp1 = YDU[12] + YDU[52];tmp6 = YDU[12] - YDU[52];tmp2 = YDU[20] + YDU[44];tmp5 = YDU[20] - YDU[44];tmp3 = YDU[28] + YDU[36];tmp4 = YDU[28] - YDU[36];
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				YDU[4] = tmp10 + tmp11;YDU[36] = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				YDU[20] = tmp13 + z1;YDU[52] = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				YDU[44] = z13 + z2;YDU[28] = z13 - z2;YDU[12] = z11 + z4;YDU[60] = z11 - z4;
				
				tmp0 = YDU[5] + YDU[61];tmp7 = YDU[5] - YDU[61];tmp1 = YDU[13] + YDU[53];tmp6 = YDU[13] - YDU[53];tmp2 = YDU[21] + YDU[45];tmp5 = YDU[21] - YDU[45];tmp3 = YDU[29] + YDU[37];tmp4 = YDU[29] - YDU[37];
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				YDU[5] = tmp10 + tmp11;YDU[37] = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				YDU[21] = tmp13 + z1;YDU[53] = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				YDU[45] = z13 + z2;YDU[29] = z13 - z2;YDU[13] = z11 + z4;YDU[61] = z11 - z4;
				
				tmp0 = YDU[6] + YDU[62];tmp7 = YDU[6] - YDU[62];tmp1 = YDU[14] + YDU[54];tmp6 = YDU[14] - YDU[54];tmp2 = YDU[22] + YDU[46];tmp5 = YDU[22] - YDU[46];tmp3 = YDU[30] + YDU[38];tmp4 = YDU[30] - YDU[38];
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				YDU[6] = tmp10 + tmp11;YDU[38] = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				YDU[22] = tmp13 + z1;YDU[54] = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				YDU[46] = z13 + z2;YDU[30] = z13 - z2;YDU[14] = z11 + z4;YDU[62] = z11 - z4;
				
				tmp0 = YDU[7] + YDU[63];tmp7 = YDU[7] - YDU[63];tmp1 = YDU[15] + YDU[55];tmp6 = YDU[15] - YDU[55];tmp2 = YDU[23] + YDU[47];tmp5 = YDU[23] - YDU[47];tmp3 = YDU[31] + YDU[39];tmp4 = YDU[31] - YDU[39];
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				YDU[7] = tmp10 + tmp11;YDU[39] = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				YDU[23] = tmp13 + z1;YDU[55] = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				YDU[47] = z13 + z2;YDU[31] = z13 - z2;YDU[15] = z11 + z4;YDU[63] = z11 - z4;
				
				// Quantize/descale the coefficients
				// Apply the quantization and scaling factor
				// and round to nearest integer
				//for(i=0;i<64;i++){YDU[i] = Math.round((YDU[i] * fdtbl_Y[i]));}
				YDU[0] = Math.round((YDU[0] * fdtbl_Y[0]));YDU[1] = Math.round((YDU[1] * fdtbl_Y[1]));YDU[2] = Math.round((YDU[2] * fdtbl_Y[2]));YDU[3] = Math.round((YDU[3] * fdtbl_Y[3]));YDU[4] = Math.round((YDU[4] * fdtbl_Y[4]));YDU[5] = Math.round((YDU[5] * fdtbl_Y[5]));YDU[6] = Math.round((YDU[6] * fdtbl_Y[6]));YDU[7] = Math.round((YDU[7] * fdtbl_Y[7]));YDU[8] = Math.round((YDU[8] * fdtbl_Y[8]));YDU[9] = Math.round((YDU[9] * fdtbl_Y[9]));YDU[10] = Math.round((YDU[10] * fdtbl_Y[10]));YDU[11] = Math.round((YDU[11] * fdtbl_Y[11]));YDU[12] = Math.round((YDU[12] * fdtbl_Y[12]));YDU[13] = Math.round((YDU[13] * fdtbl_Y[13]));YDU[14] = Math.round((YDU[14] * fdtbl_Y[14]));YDU[15] = Math.round((YDU[15] * fdtbl_Y[15]));YDU[16] = Math.round((YDU[16] * fdtbl_Y[16]));YDU[17] = Math.round((YDU[17] * fdtbl_Y[17]));YDU[18] = Math.round((YDU[18] * fdtbl_Y[18]));YDU[19] = Math.round((YDU[19] * fdtbl_Y[19]));YDU[20] = Math.round((YDU[20] * fdtbl_Y[20]));YDU[21] = Math.round((YDU[21] * fdtbl_Y[21]));YDU[22] = Math.round((YDU[22] * fdtbl_Y[22]));YDU[23] = Math.round((YDU[23] * fdtbl_Y[23]));YDU[24] = Math.round((YDU[24] * fdtbl_Y[24]));YDU[25] = Math.round((YDU[25] * fdtbl_Y[25]));YDU[26] = Math.round((YDU[26] * fdtbl_Y[26]));YDU[27] = Math.round((YDU[27] * fdtbl_Y[27]));YDU[28] = Math.round((YDU[28] * fdtbl_Y[28]));YDU[29] = Math.round((YDU[29] * fdtbl_Y[29]));YDU[30] = Math.round((YDU[30] * fdtbl_Y[30]));YDU[31] = Math.round((YDU[31] * fdtbl_Y[31]));YDU[32] = Math.round((YDU[32] * fdtbl_Y[32]));YDU[33] = Math.round((YDU[33] * fdtbl_Y[33]));YDU[34] = Math.round((YDU[34] * fdtbl_Y[34]));YDU[35] = Math.round((YDU[35] * fdtbl_Y[35]));YDU[36] = Math.round((YDU[36] * fdtbl_Y[36]));YDU[37] = Math.round((YDU[37] * fdtbl_Y[37]));YDU[38] = Math.round((YDU[38] * fdtbl_Y[38]));YDU[39] = Math.round((YDU[39] * fdtbl_Y[39]));YDU[40] = Math.round((YDU[40] * fdtbl_Y[40]));YDU[41] = Math.round((YDU[41] * fdtbl_Y[41]));YDU[42] = Math.round((YDU[42] * fdtbl_Y[42]));YDU[43] = Math.round((YDU[43] * fdtbl_Y[43]));YDU[44] = Math.round((YDU[44] * fdtbl_Y[44]));YDU[45] = Math.round((YDU[45] * fdtbl_Y[45]));YDU[46] = Math.round((YDU[46] * fdtbl_Y[46]));YDU[47] = Math.round((YDU[47] * fdtbl_Y[47]));YDU[48] = Math.round((YDU[48] * fdtbl_Y[48]));YDU[49] = Math.round((YDU[49] * fdtbl_Y[49]));YDU[50] = Math.round((YDU[50] * fdtbl_Y[50]));YDU[51] = Math.round((YDU[51] * fdtbl_Y[51]));YDU[52] = Math.round((YDU[52] * fdtbl_Y[52]));YDU[53] = Math.round((YDU[53] * fdtbl_Y[53]));YDU[54] = Math.round((YDU[54] * fdtbl_Y[54]));YDU[55] = Math.round((YDU[55] * fdtbl_Y[55]));YDU[56] = Math.round((YDU[56] * fdtbl_Y[56]));YDU[57] = Math.round((YDU[57] * fdtbl_Y[57]));YDU[58] = Math.round((YDU[58] * fdtbl_Y[58]));YDU[59] = Math.round((YDU[59] * fdtbl_Y[59]));YDU[60] = Math.round((YDU[60] * fdtbl_Y[60]));YDU[61] = Math.round((YDU[61] * fdtbl_Y[61]));YDU[62] = Math.round((YDU[62] * fdtbl_Y[62]));YDU[63] = Math.round((YDU[63] * fdtbl_Y[63]));
				
				// ZigZag reorder
				//for(i=0;i<64;i++){DU[ZigZag[i]] = YDU[i];}
				DU[ZigZag[0]] = YDU[0];DU[ZigZag[1]] = YDU[1];DU[ZigZag[2]] = YDU[2];DU[ZigZag[3]] = YDU[3];DU[ZigZag[4]] = YDU[4];DU[ZigZag[5]] = YDU[5];DU[ZigZag[6]] = YDU[6];DU[ZigZag[7]] = YDU[7];DU[ZigZag[8]] = YDU[8];DU[ZigZag[9]] = YDU[9];DU[ZigZag[10]] = YDU[10];DU[ZigZag[11]] = YDU[11];DU[ZigZag[12]] = YDU[12];DU[ZigZag[13]] = YDU[13];DU[ZigZag[14]] = YDU[14];DU[ZigZag[15]] = YDU[15];DU[ZigZag[16]] = YDU[16];DU[ZigZag[17]] = YDU[17];DU[ZigZag[18]] = YDU[18];DU[ZigZag[19]] = YDU[19];DU[ZigZag[20]] = YDU[20];DU[ZigZag[21]] = YDU[21];DU[ZigZag[22]] = YDU[22];DU[ZigZag[23]] = YDU[23];DU[ZigZag[24]] = YDU[24];DU[ZigZag[25]] = YDU[25];DU[ZigZag[26]] = YDU[26];DU[ZigZag[27]] = YDU[27];DU[ZigZag[28]] = YDU[28];DU[ZigZag[29]] = YDU[29];DU[ZigZag[30]] = YDU[30];DU[ZigZag[31]] = YDU[31];DU[ZigZag[32]] = YDU[32];DU[ZigZag[33]] = YDU[33];DU[ZigZag[34]] = YDU[34];DU[ZigZag[35]] = YDU[35];DU[ZigZag[36]] = YDU[36];DU[ZigZag[37]] = YDU[37];DU[ZigZag[38]] = YDU[38];DU[ZigZag[39]] = YDU[39];DU[ZigZag[40]] = YDU[40];DU[ZigZag[41]] = YDU[41];DU[ZigZag[42]] = YDU[42];DU[ZigZag[43]] = YDU[43];DU[ZigZag[44]] = YDU[44];DU[ZigZag[45]] = YDU[45];DU[ZigZag[46]] = YDU[46];DU[ZigZag[47]] = YDU[47];DU[ZigZag[48]] = YDU[48];DU[ZigZag[49]] = YDU[49];DU[ZigZag[50]] = YDU[50];DU[ZigZag[51]] = YDU[51];DU[ZigZag[52]] = YDU[52];DU[ZigZag[53]] = YDU[53];DU[ZigZag[54]] = YDU[54];DU[ZigZag[55]] = YDU[55];DU[ZigZag[56]] = YDU[56];DU[ZigZag[57]] = YDU[57];DU[ZigZag[58]] = YDU[58];DU[ZigZag[59]] = YDU[59];DU[ZigZag[60]] = YDU[60];DU[ZigZag[61]] = YDU[61];DU[ZigZag[62]] = YDU[62];DU[ZigZag[63]] = YDU[63];
				
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
				tmp0 = UDU[0] + UDU[7];tmp7 = UDU[0] - UDU[7];tmp1 = UDU[1] + UDU[6];tmp6 = UDU[1] - UDU[6];tmp2 = UDU[2] + UDU[5];tmp5 = UDU[2] - UDU[5];tmp3 = UDU[3] + UDU[4];tmp4 = UDU[3] - UDU[4];
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				UDU[0] = tmp10 + tmp11;UDU[4] = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				UDU[2] = tmp13 + z1;UDU[6] = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				UDU[5] = z13 + z2;UDU[3] = z13 - z2;UDU[1] = z11 + z4;UDU[7] = z11 - z4;
				
				tmp0 = UDU[8] + UDU[15];tmp7 = UDU[8] - UDU[15];tmp1 = UDU[9] + UDU[14];tmp6 = UDU[9] - UDU[14];tmp2 = UDU[10] + UDU[13];tmp5 = UDU[10] - UDU[13];tmp3 = UDU[11] + UDU[12];tmp4 = UDU[11] - UDU[12];
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				UDU[8] = tmp10 + tmp11;UDU[12] = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				UDU[10] = tmp13 + z1;UDU[14] = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				UDU[13] = z13 + z2;UDU[11] = z13 - z2;UDU[9] = z11 + z4;UDU[15] = z11 - z4;
				
				tmp0 = UDU[16] + UDU[23];tmp7 = UDU[16] - UDU[23];tmp1 = UDU[17] + UDU[22];tmp6 = UDU[17] - UDU[22];tmp2 = UDU[18] + UDU[21];tmp5 = UDU[18] - UDU[21];tmp3 = UDU[19] + UDU[20];tmp4 = UDU[19] - UDU[20];
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				UDU[16] = tmp10 + tmp11;UDU[20] = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				UDU[18] = tmp13 + z1;UDU[22] = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				UDU[21] = z13 + z2;UDU[19] = z13 - z2;UDU[17] = z11 + z4;UDU[23] = z11 - z4;
				
				tmp0 = UDU[24] + UDU[31];tmp7 = UDU[24] - UDU[31];tmp1 = UDU[25] + UDU[30];tmp6 = UDU[25] - UDU[30];tmp2 = UDU[26] + UDU[29];tmp5 = UDU[26] - UDU[29];tmp3 = UDU[27] + UDU[28];tmp4 = UDU[27] - UDU[28];
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				UDU[24] = tmp10 + tmp11;UDU[28] = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				UDU[26] = tmp13 + z1;UDU[30] = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				UDU[29] = z13 + z2;UDU[27] = z13 - z2;UDU[25] = z11 + z4;UDU[31] = z11 - z4;
				
				tmp0 = UDU[32] + UDU[39];tmp7 = UDU[32] - UDU[39];tmp1 = UDU[33] + UDU[38];tmp6 = UDU[33] - UDU[38];tmp2 = UDU[34] + UDU[37];tmp5 = UDU[34] - UDU[37];tmp3 = UDU[35] + UDU[36];tmp4 = UDU[35] - UDU[36];
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				UDU[32] = tmp10 + tmp11;UDU[36] = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				UDU[34] = tmp13 + z1;UDU[38] = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				UDU[37] = z13 + z2;UDU[35] = z13 - z2;UDU[33] = z11 + z4;UDU[39] = z11 - z4;
				
				tmp0 = UDU[40] + UDU[47];tmp7 = UDU[40] - UDU[47];tmp1 = UDU[41] + UDU[46];tmp6 = UDU[41] - UDU[46];tmp2 = UDU[42] + UDU[45];tmp5 = UDU[42] - UDU[45];tmp3 = UDU[43] + UDU[44];tmp4 = UDU[43] - UDU[44];
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				UDU[40] = tmp10 + tmp11;UDU[44] = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				UDU[42] = tmp13 + z1;UDU[46] = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				UDU[45] = z13 + z2;UDU[43] = z13 - z2;UDU[41] = z11 + z4;UDU[47] = z11 - z4;
				
				tmp0 = UDU[48] + UDU[55];tmp7 = UDU[48] - UDU[55];tmp1 = UDU[49] + UDU[54];tmp6 = UDU[49] - UDU[54];tmp2 = UDU[50] + UDU[53];tmp5 = UDU[50] - UDU[53];tmp3 = UDU[51] + UDU[52];tmp4 = UDU[51] - UDU[52];
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				UDU[48] = tmp10 + tmp11;UDU[52] = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				UDU[50] = tmp13 + z1;UDU[54] = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				UDU[53] = z13 + z2;UDU[51] = z13 - z2;UDU[49] = z11 + z4;UDU[55] = z11 - z4;
				
				tmp0 = UDU[56] + UDU[63];tmp7 = UDU[56] - UDU[63];tmp1 = UDU[57] + UDU[62];tmp6 = UDU[57] - UDU[62];tmp2 = UDU[58] + UDU[61];tmp5 = UDU[58] - UDU[61];tmp3 = UDU[59] + UDU[60];tmp4 = UDU[59] - UDU[60];
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				UDU[56] = tmp10 + tmp11;UDU[60] = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				UDU[58] = tmp13 + z1;UDU[62] = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				UDU[61] = z13 + z2;UDU[59] = z13 - z2;UDU[57] = z11 + z4;UDU[63] = z11 - z4;
				
				// Pass 2: process columns.
				tmp0 = UDU[0] + UDU[56];tmp7 = UDU[0] - UDU[56];tmp1 = UDU[8] + UDU[48];tmp6 = UDU[8] - UDU[48];tmp2 = UDU[16] + UDU[40];tmp5 = UDU[16] - UDU[40];tmp3 = UDU[24] + UDU[32];tmp4 = UDU[24] - UDU[32];
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				UDU[0] = tmp10 + tmp11;UDU[32] = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				UDU[16] = tmp13 + z1;UDU[48] = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				UDU[40] = z13 + z2;UDU[24] = z13 - z2;UDU[8] = z11 + z4;UDU[56] = z11 - z4;
				
				tmp0 = UDU[1] + UDU[57];tmp7 = UDU[1] - UDU[57];tmp1 = UDU[9] + UDU[49];tmp6 = UDU[9] - UDU[49];tmp2 = UDU[17] + UDU[41];tmp5 = UDU[17] - UDU[41];tmp3 = UDU[25] + UDU[33];tmp4 = UDU[25] - UDU[33];
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				UDU[1] = tmp10 + tmp11;UDU[33] = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				UDU[17] = tmp13 + z1;UDU[49] = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				UDU[41] = z13 + z2;UDU[25] = z13 - z2;UDU[9] = z11 + z4;UDU[57] = z11 - z4;
				
				tmp0 = UDU[2] + UDU[58];tmp7 = UDU[2] - UDU[58];tmp1 = UDU[10] + UDU[50];tmp6 = UDU[10] - UDU[50];tmp2 = UDU[18] + UDU[42];tmp5 = UDU[18] - UDU[42];tmp3 = UDU[26] + UDU[34];tmp4 = UDU[26] - UDU[34];
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				UDU[2] = tmp10 + tmp11;UDU[34] = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				UDU[18] = tmp13 + z1;UDU[50] = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				UDU[42] = z13 + z2;UDU[26] = z13 - z2;UDU[10] = z11 + z4;UDU[58] = z11 - z4;
				
				tmp0 = UDU[3] + UDU[59];tmp7 = UDU[3] - UDU[59];tmp1 = UDU[11] + UDU[51];tmp6 = UDU[11] - UDU[51];tmp2 = UDU[19] + UDU[43];tmp5 = UDU[19] - UDU[43];tmp3 = UDU[27] + UDU[35];tmp4 = UDU[27] - UDU[35];
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				UDU[3] = tmp10 + tmp11;UDU[35] = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				UDU[19] = tmp13 + z1;UDU[51] = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				UDU[43] = z13 + z2;UDU[27] = z13 - z2;UDU[11] = z11 + z4;UDU[59] = z11 - z4;
				
				tmp0 = UDU[4] + UDU[60];tmp7 = UDU[4] - UDU[60];tmp1 = UDU[12] + UDU[52];tmp6 = UDU[12] - UDU[52];tmp2 = UDU[20] + UDU[44];tmp5 = UDU[20] - UDU[44];tmp3 = UDU[28] + UDU[36];tmp4 = UDU[28] - UDU[36];
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				UDU[4] = tmp10 + tmp11;UDU[36] = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				UDU[20] = tmp13 + z1;UDU[52] = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				UDU[44] = z13 + z2;UDU[28] = z13 - z2;UDU[12] = z11 + z4;UDU[60] = z11 - z4;
				
				tmp0 = UDU[5] + UDU[61];tmp7 = UDU[5] - UDU[61];tmp1 = UDU[13] + UDU[53];tmp6 = UDU[13] - UDU[53];tmp2 = UDU[21] + UDU[45];tmp5 = UDU[21] - UDU[45];tmp3 = UDU[29] + UDU[37];tmp4 = UDU[29] - UDU[37];
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				UDU[5] = tmp10 + tmp11;UDU[37] = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				UDU[21] = tmp13 + z1;UDU[53] = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				UDU[45] = z13 + z2;UDU[29] = z13 - z2;UDU[13] = z11 + z4;UDU[61] = z11 - z4;
				
				tmp0 = UDU[6] + UDU[62];tmp7 = UDU[6] - UDU[62];tmp1 = UDU[14] + UDU[54];tmp6 = UDU[14] - UDU[54];tmp2 = UDU[22] + UDU[46];tmp5 = UDU[22] - UDU[46];tmp3 = UDU[30] + UDU[38];tmp4 = UDU[30] - UDU[38];
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				UDU[6] = tmp10 + tmp11;UDU[38] = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				UDU[22] = tmp13 + z1;UDU[54] = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				UDU[46] = z13 + z2;UDU[30] = z13 - z2;UDU[14] = z11 + z4;UDU[62] = z11 - z4;
				
				tmp0 = UDU[7] + UDU[63];tmp7 = UDU[7] - UDU[63];tmp1 = UDU[15] + UDU[55];tmp6 = UDU[15] - UDU[55];tmp2 = UDU[23] + UDU[47];tmp5 = UDU[23] - UDU[47];tmp3 = UDU[31] + UDU[39];tmp4 = UDU[31] - UDU[39];
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				UDU[7] = tmp10 + tmp11;UDU[39] = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				UDU[23] = tmp13 + z1;UDU[55] = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				UDU[47] = z13 + z2;UDU[31] = z13 - z2;UDU[15] = z11 + z4;UDU[63] = z11 - z4;
				
				// Quantize/descale the coefficients
				// Apply the quantization and scaling factor
				// and round to nearest integer
				//for(i=0;i<64;i++){UDU[i] = Math.round((UDU[i] * fdtbl_UV[i]));}
				UDU[0] = Math.round((UDU[0] * fdtbl_UV[0]));UDU[1] = Math.round((UDU[1] * fdtbl_UV[1]));UDU[2] = Math.round((UDU[2] * fdtbl_UV[2]));UDU[3] = Math.round((UDU[3] * fdtbl_UV[3]));UDU[4] = Math.round((UDU[4] * fdtbl_UV[4]));UDU[5] = Math.round((UDU[5] * fdtbl_UV[5]));UDU[6] = Math.round((UDU[6] * fdtbl_UV[6]));UDU[7] = Math.round((UDU[7] * fdtbl_UV[7]));UDU[8] = Math.round((UDU[8] * fdtbl_UV[8]));UDU[9] = Math.round((UDU[9] * fdtbl_UV[9]));UDU[10] = Math.round((UDU[10] * fdtbl_UV[10]));UDU[11] = Math.round((UDU[11] * fdtbl_UV[11]));UDU[12] = Math.round((UDU[12] * fdtbl_UV[12]));UDU[13] = Math.round((UDU[13] * fdtbl_UV[13]));UDU[14] = Math.round((UDU[14] * fdtbl_UV[14]));UDU[15] = Math.round((UDU[15] * fdtbl_UV[15]));UDU[16] = Math.round((UDU[16] * fdtbl_UV[16]));UDU[17] = Math.round((UDU[17] * fdtbl_UV[17]));UDU[18] = Math.round((UDU[18] * fdtbl_UV[18]));UDU[19] = Math.round((UDU[19] * fdtbl_UV[19]));UDU[20] = Math.round((UDU[20] * fdtbl_UV[20]));UDU[21] = Math.round((UDU[21] * fdtbl_UV[21]));UDU[22] = Math.round((UDU[22] * fdtbl_UV[22]));UDU[23] = Math.round((UDU[23] * fdtbl_UV[23]));UDU[24] = Math.round((UDU[24] * fdtbl_UV[24]));UDU[25] = Math.round((UDU[25] * fdtbl_UV[25]));UDU[26] = Math.round((UDU[26] * fdtbl_UV[26]));UDU[27] = Math.round((UDU[27] * fdtbl_UV[27]));UDU[28] = Math.round((UDU[28] * fdtbl_UV[28]));UDU[29] = Math.round((UDU[29] * fdtbl_UV[29]));UDU[30] = Math.round((UDU[30] * fdtbl_UV[30]));UDU[31] = Math.round((UDU[31] * fdtbl_UV[31]));UDU[32] = Math.round((UDU[32] * fdtbl_UV[32]));UDU[33] = Math.round((UDU[33] * fdtbl_UV[33]));UDU[34] = Math.round((UDU[34] * fdtbl_UV[34]));UDU[35] = Math.round((UDU[35] * fdtbl_UV[35]));UDU[36] = Math.round((UDU[36] * fdtbl_UV[36]));UDU[37] = Math.round((UDU[37] * fdtbl_UV[37]));UDU[38] = Math.round((UDU[38] * fdtbl_UV[38]));UDU[39] = Math.round((UDU[39] * fdtbl_UV[39]));UDU[40] = Math.round((UDU[40] * fdtbl_UV[40]));UDU[41] = Math.round((UDU[41] * fdtbl_UV[41]));UDU[42] = Math.round((UDU[42] * fdtbl_UV[42]));UDU[43] = Math.round((UDU[43] * fdtbl_UV[43]));UDU[44] = Math.round((UDU[44] * fdtbl_UV[44]));UDU[45] = Math.round((UDU[45] * fdtbl_UV[45]));UDU[46] = Math.round((UDU[46] * fdtbl_UV[46]));UDU[47] = Math.round((UDU[47] * fdtbl_UV[47]));UDU[48] = Math.round((UDU[48] * fdtbl_UV[48]));UDU[49] = Math.round((UDU[49] * fdtbl_UV[49]));UDU[50] = Math.round((UDU[50] * fdtbl_UV[50]));UDU[51] = Math.round((UDU[51] * fdtbl_UV[51]));UDU[52] = Math.round((UDU[52] * fdtbl_UV[52]));UDU[53] = Math.round((UDU[53] * fdtbl_UV[53]));UDU[54] = Math.round((UDU[54] * fdtbl_UV[54]));UDU[55] = Math.round((UDU[55] * fdtbl_UV[55]));UDU[56] = Math.round((UDU[56] * fdtbl_UV[56]));UDU[57] = Math.round((UDU[57] * fdtbl_UV[57]));UDU[58] = Math.round((UDU[58] * fdtbl_UV[58]));UDU[59] = Math.round((UDU[59] * fdtbl_UV[59]));UDU[60] = Math.round((UDU[60] * fdtbl_UV[60]));UDU[61] = Math.round((UDU[61] * fdtbl_UV[61]));UDU[62] = Math.round((UDU[62] * fdtbl_UV[62]));UDU[63] = Math.round((UDU[63] * fdtbl_UV[63]));
				
				// ZigZag reorder
				//for(i=0;i<64;i++){DU[ZigZag[i]] = UDU[i];}
				DU[ZigZag[0]] = UDU[0];DU[ZigZag[1]] = UDU[1];DU[ZigZag[2]] = UDU[2];DU[ZigZag[3]] = UDU[3];DU[ZigZag[4]] = UDU[4];DU[ZigZag[5]] = UDU[5];DU[ZigZag[6]] = UDU[6];DU[ZigZag[7]] = UDU[7];DU[ZigZag[8]] = UDU[8];DU[ZigZag[9]] = UDU[9];DU[ZigZag[10]] = UDU[10];DU[ZigZag[11]] = UDU[11];DU[ZigZag[12]] = UDU[12];DU[ZigZag[13]] = UDU[13];DU[ZigZag[14]] = UDU[14];DU[ZigZag[15]] = UDU[15];DU[ZigZag[16]] = UDU[16];DU[ZigZag[17]] = UDU[17];DU[ZigZag[18]] = UDU[18];DU[ZigZag[19]] = UDU[19];DU[ZigZag[20]] = UDU[20];DU[ZigZag[21]] = UDU[21];DU[ZigZag[22]] = UDU[22];DU[ZigZag[23]] = UDU[23];DU[ZigZag[24]] = UDU[24];DU[ZigZag[25]] = UDU[25];DU[ZigZag[26]] = UDU[26];DU[ZigZag[27]] = UDU[27];DU[ZigZag[28]] = UDU[28];DU[ZigZag[29]] = UDU[29];DU[ZigZag[30]] = UDU[30];DU[ZigZag[31]] = UDU[31];DU[ZigZag[32]] = UDU[32];DU[ZigZag[33]] = UDU[33];DU[ZigZag[34]] = UDU[34];DU[ZigZag[35]] = UDU[35];DU[ZigZag[36]] = UDU[36];DU[ZigZag[37]] = UDU[37];DU[ZigZag[38]] = UDU[38];DU[ZigZag[39]] = UDU[39];DU[ZigZag[40]] = UDU[40];DU[ZigZag[41]] = UDU[41];DU[ZigZag[42]] = UDU[42];DU[ZigZag[43]] = UDU[43];DU[ZigZag[44]] = UDU[44];DU[ZigZag[45]] = UDU[45];DU[ZigZag[46]] = UDU[46];DU[ZigZag[47]] = UDU[47];DU[ZigZag[48]] = UDU[48];DU[ZigZag[49]] = UDU[49];DU[ZigZag[50]] = UDU[50];DU[ZigZag[51]] = UDU[51];DU[ZigZag[52]] = UDU[52];DU[ZigZag[53]] = UDU[53];DU[ZigZag[54]] = UDU[54];DU[ZigZag[55]] = UDU[55];DU[ZigZag[56]] = UDU[56];DU[ZigZag[57]] = UDU[57];DU[ZigZag[58]] = UDU[58];DU[ZigZag[59]] = UDU[59];DU[ZigZag[60]] = UDU[60];DU[ZigZag[61]] = UDU[61];DU[ZigZag[62]] = UDU[62];DU[ZigZag[63]] = UDU[63];
				
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
				tmp0 = VDU[0] + VDU[7];tmp7 = VDU[0] - VDU[7];tmp1 = VDU[1] + VDU[6];tmp6 = VDU[1] - VDU[6];tmp2 = VDU[2] + VDU[5];tmp5 = VDU[2] - VDU[5];tmp3 = VDU[3] + VDU[4];tmp4 = VDU[3] - VDU[4];
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				VDU[0] = tmp10 + tmp11;VDU[4] = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				VDU[2] = tmp13 + z1;VDU[6] = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				VDU[5] = z13 + z2;VDU[3] = z13 - z2;VDU[1] = z11 + z4;VDU[7] = z11 - z4;
				
				tmp0 = VDU[8] + VDU[15];tmp7 = VDU[8] - VDU[15];tmp1 = VDU[9] + VDU[14];tmp6 = VDU[9] - VDU[14];tmp2 = VDU[10] + VDU[13];tmp5 = VDU[10] - VDU[13];tmp3 = VDU[11] + VDU[12];tmp4 = VDU[11] - VDU[12];
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				VDU[8] = tmp10 + tmp11;VDU[12] = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				VDU[10] = tmp13 + z1;VDU[14] = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				VDU[13] = z13 + z2;VDU[11] = z13 - z2;VDU[9] = z11 + z4;VDU[15] = z11 - z4;
				
				tmp0 = VDU[16] + VDU[23];tmp7 = VDU[16] - VDU[23];tmp1 = VDU[17] + VDU[22];tmp6 = VDU[17] - VDU[22];tmp2 = VDU[18] + VDU[21];tmp5 = VDU[18] - VDU[21];tmp3 = VDU[19] + VDU[20];tmp4 = VDU[19] - VDU[20];
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				VDU[16] = tmp10 + tmp11;VDU[20] = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				VDU[18] = tmp13 + z1;VDU[22] = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				VDU[21] = z13 + z2;VDU[19] = z13 - z2;VDU[17] = z11 + z4;VDU[23] = z11 - z4;
				
				tmp0 = VDU[24] + VDU[31];tmp7 = VDU[24] - VDU[31];tmp1 = VDU[25] + VDU[30];tmp6 = VDU[25] - VDU[30];tmp2 = VDU[26] + VDU[29];tmp5 = VDU[26] - VDU[29];tmp3 = VDU[27] + VDU[28];tmp4 = VDU[27] - VDU[28];
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				VDU[24] = tmp10 + tmp11;VDU[28] = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				VDU[26] = tmp13 + z1;VDU[30] = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				VDU[29] = z13 + z2;VDU[27] = z13 - z2;VDU[25] = z11 + z4;VDU[31] = z11 - z4;
				
				tmp0 = VDU[32] + VDU[39];tmp7 = VDU[32] - VDU[39];tmp1 = VDU[33] + VDU[38];tmp6 = VDU[33] - VDU[38];tmp2 = VDU[34] + VDU[37];tmp5 = VDU[34] - VDU[37];tmp3 = VDU[35] + VDU[36];tmp4 = VDU[35] - VDU[36];
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				VDU[32] = tmp10 + tmp11;VDU[36] = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				VDU[34] = tmp13 + z1;VDU[38] = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				VDU[37] = z13 + z2;VDU[35] = z13 - z2;VDU[33] = z11 + z4;VDU[39] = z11 - z4;
				
				tmp0 = VDU[40] + VDU[47];tmp7 = VDU[40] - VDU[47];tmp1 = VDU[41] + VDU[46];tmp6 = VDU[41] - VDU[46];tmp2 = VDU[42] + VDU[45];tmp5 = VDU[42] - VDU[45];tmp3 = VDU[43] + VDU[44];tmp4 = VDU[43] - VDU[44];
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				VDU[40] = tmp10 + tmp11;VDU[44] = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				VDU[42] = tmp13 + z1;VDU[46] = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				VDU[45] = z13 + z2;VDU[43] = z13 - z2;VDU[41] = z11 + z4;VDU[47] = z11 - z4;
				
				tmp0 = VDU[48] + VDU[55];tmp7 = VDU[48] - VDU[55];tmp1 = VDU[49] + VDU[54];tmp6 = VDU[49] - VDU[54];tmp2 = VDU[50] + VDU[53];tmp5 = VDU[50] - VDU[53];tmp3 = VDU[51] + VDU[52];tmp4 = VDU[51] - VDU[52];
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				VDU[48] = tmp10 + tmp11;VDU[52] = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				VDU[50] = tmp13 + z1;VDU[54] = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				VDU[53] = z13 + z2;VDU[51] = z13 - z2;VDU[49] = z11 + z4;VDU[55] = z11 - z4;
				
				tmp0 = VDU[56] + VDU[63];tmp7 = VDU[56] - VDU[63];tmp1 = VDU[57] + VDU[62];tmp6 = VDU[57] - VDU[62];tmp2 = VDU[58] + VDU[61];tmp5 = VDU[58] - VDU[61];tmp3 = VDU[59] + VDU[60];tmp4 = VDU[59] - VDU[60];
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				VDU[56] = tmp10 + tmp11;VDU[60] = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				VDU[58] = tmp13 + z1;VDU[62] = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				VDU[61] = z13 + z2;VDU[59] = z13 - z2;VDU[57] = z11 + z4;VDU[63] = z11 - z4;
				
				// Pass 2: process columns.
				tmp0 = VDU[0] + VDU[56];tmp7 = VDU[0] - VDU[56];tmp1 = VDU[8] + VDU[48];tmp6 = VDU[8] - VDU[48];tmp2 = VDU[16] + VDU[40];tmp5 = VDU[16] - VDU[40];tmp3 = VDU[24] + VDU[32];tmp4 = VDU[24] - VDU[32];
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				VDU[0] = tmp10 + tmp11;VDU[32] = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				VDU[16] = tmp13 + z1;VDU[48] = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				VDU[40] = z13 + z2;VDU[24] = z13 - z2;VDU[8] = z11 + z4;VDU[56] = z11 - z4;
				
				tmp0 = VDU[1] + VDU[57];tmp7 = VDU[1] - VDU[57];tmp1 = VDU[9] + VDU[49];tmp6 = VDU[9] - VDU[49];tmp2 = VDU[17] + VDU[41];tmp5 = VDU[17] - VDU[41];tmp3 = VDU[25] + VDU[33];tmp4 = VDU[25] - VDU[33];
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				VDU[1] = tmp10 + tmp11;VDU[33] = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				VDU[17] = tmp13 + z1;VDU[49] = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				VDU[41] = z13 + z2;VDU[25] = z13 - z2;VDU[9] = z11 + z4;VDU[57] = z11 - z4;
				
				tmp0 = VDU[2] + VDU[58];tmp7 = VDU[2] - VDU[58];tmp1 = VDU[10] + VDU[50];tmp6 = VDU[10] - VDU[50];tmp2 = VDU[18] + VDU[42];tmp5 = VDU[18] - VDU[42];tmp3 = VDU[26] + VDU[34];tmp4 = VDU[26] - VDU[34];
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				VDU[2] = tmp10 + tmp11;VDU[34] = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				VDU[18] = tmp13 + z1;VDU[50] = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				VDU[42] = z13 + z2;VDU[26] = z13 - z2;VDU[10] = z11 + z4;VDU[58] = z11 - z4;
				
				tmp0 = VDU[3] + VDU[59];tmp7 = VDU[3] - VDU[59];tmp1 = VDU[11] + VDU[51];tmp6 = VDU[11] - VDU[51];tmp2 = VDU[19] + VDU[43];tmp5 = VDU[19] - VDU[43];tmp3 = VDU[27] + VDU[35];tmp4 = VDU[27] - VDU[35];
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				VDU[3] = tmp10 + tmp11;VDU[35] = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				VDU[19] = tmp13 + z1;VDU[51] = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				VDU[43] = z13 + z2;VDU[27] = z13 - z2;VDU[11] = z11 + z4;VDU[59] = z11 - z4;
				
				tmp0 = VDU[4] + VDU[60];tmp7 = VDU[4] - VDU[60];tmp1 = VDU[12] + VDU[52];tmp6 = VDU[12] - VDU[52];tmp2 = VDU[20] + VDU[44];tmp5 = VDU[20] - VDU[44];tmp3 = VDU[28] + VDU[36];tmp4 = VDU[28] - VDU[36];
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				VDU[4] = tmp10 + tmp11;VDU[36] = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				VDU[20] = tmp13 + z1;VDU[52] = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				VDU[44] = z13 + z2;VDU[28] = z13 - z2;VDU[12] = z11 + z4;VDU[60] = z11 - z4;
				
				tmp0 = VDU[5] + VDU[61];tmp7 = VDU[5] - VDU[61];tmp1 = VDU[13] + VDU[53];tmp6 = VDU[13] - VDU[53];tmp2 = VDU[21] + VDU[45];tmp5 = VDU[21] - VDU[45];tmp3 = VDU[29] + VDU[37];tmp4 = VDU[29] - VDU[37];
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				VDU[5] = tmp10 + tmp11;VDU[37] = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				VDU[21] = tmp13 + z1;VDU[53] = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				VDU[45] = z13 + z2;VDU[29] = z13 - z2;VDU[13] = z11 + z4;VDU[61] = z11 - z4;
				
				tmp0 = VDU[6] + VDU[62];tmp7 = VDU[6] - VDU[62];tmp1 = VDU[14] + VDU[54];tmp6 = VDU[14] - VDU[54];tmp2 = VDU[22] + VDU[46];tmp5 = VDU[22] - VDU[46];tmp3 = VDU[30] + VDU[38];tmp4 = VDU[30] - VDU[38];
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				VDU[6] = tmp10 + tmp11;VDU[38] = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				VDU[22] = tmp13 + z1;VDU[54] = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				VDU[46] = z13 + z2;VDU[30] = z13 - z2;VDU[14] = z11 + z4;VDU[62] = z11 - z4;
				
				tmp0 = VDU[7] + VDU[63];tmp7 = VDU[7] - VDU[63];tmp1 = VDU[15] + VDU[55];tmp6 = VDU[15] - VDU[55];tmp2 = VDU[23] + VDU[47];tmp5 = VDU[23] - VDU[47];tmp3 = VDU[31] + VDU[39];tmp4 = VDU[31] - VDU[39];
				tmp10 = tmp0 + tmp3;tmp13 = tmp0 - tmp3;tmp11 = tmp1 + tmp2;
				VDU[7] = tmp10 + tmp11;VDU[39] = tmp10 - tmp11;
				z1 = (tmp1 - tmp2 + tmp13) * 0.707106781;
				VDU[23] = tmp13 + z1;VDU[55] = tmp13 - z1;
				tmp10 = tmp4 + tmp5;tmp12 = tmp6 + tmp7;
				z5 = (tmp10 - tmp12) * 0.382683433;z2 = 0.541196100 * tmp10 + z5;z4 = 1.306562965 * tmp12 + z5;z3 = (tmp5 + tmp6) * 0.707106781;
				z11 = tmp7 + z3;z13 = tmp7 - z3;
				VDU[47] = z13 + z2;VDU[31] = z13 - z2;VDU[15] = z11 + z4;VDU[63] = z11 - z4;
				
				// Quantize/descale the coefficients
				// Apply the quantization and scaling factor
				// and round to nearest integer
				//for(i=0;i<64;i++){VDU[i] = Math.round((VDU[i] * fdtbl_UV[i]));}
				VDU[0] = Math.round((VDU[0] * fdtbl_UV[0]));VDU[1] = Math.round((VDU[1] * fdtbl_UV[1]));VDU[2] = Math.round((VDU[2] * fdtbl_UV[2]));VDU[3] = Math.round((VDU[3] * fdtbl_UV[3]));VDU[4] = Math.round((VDU[4] * fdtbl_UV[4]));VDU[5] = Math.round((VDU[5] * fdtbl_UV[5]));VDU[6] = Math.round((VDU[6] * fdtbl_UV[6]));VDU[7] = Math.round((VDU[7] * fdtbl_UV[7]));VDU[8] = Math.round((VDU[8] * fdtbl_UV[8]));VDU[9] = Math.round((VDU[9] * fdtbl_UV[9]));VDU[10] = Math.round((VDU[10] * fdtbl_UV[10]));VDU[11] = Math.round((VDU[11] * fdtbl_UV[11]));VDU[12] = Math.round((VDU[12] * fdtbl_UV[12]));VDU[13] = Math.round((VDU[13] * fdtbl_UV[13]));VDU[14] = Math.round((VDU[14] * fdtbl_UV[14]));VDU[15] = Math.round((VDU[15] * fdtbl_UV[15]));VDU[16] = Math.round((VDU[16] * fdtbl_UV[16]));VDU[17] = Math.round((VDU[17] * fdtbl_UV[17]));VDU[18] = Math.round((VDU[18] * fdtbl_UV[18]));VDU[19] = Math.round((VDU[19] * fdtbl_UV[19]));VDU[20] = Math.round((VDU[20] * fdtbl_UV[20]));VDU[21] = Math.round((VDU[21] * fdtbl_UV[21]));VDU[22] = Math.round((VDU[22] * fdtbl_UV[22]));VDU[23] = Math.round((VDU[23] * fdtbl_UV[23]));VDU[24] = Math.round((VDU[24] * fdtbl_UV[24]));VDU[25] = Math.round((VDU[25] * fdtbl_UV[25]));VDU[26] = Math.round((VDU[26] * fdtbl_UV[26]));VDU[27] = Math.round((VDU[27] * fdtbl_UV[27]));VDU[28] = Math.round((VDU[28] * fdtbl_UV[28]));VDU[29] = Math.round((VDU[29] * fdtbl_UV[29]));VDU[30] = Math.round((VDU[30] * fdtbl_UV[30]));VDU[31] = Math.round((VDU[31] * fdtbl_UV[31]));VDU[32] = Math.round((VDU[32] * fdtbl_UV[32]));VDU[33] = Math.round((VDU[33] * fdtbl_UV[33]));VDU[34] = Math.round((VDU[34] * fdtbl_UV[34]));VDU[35] = Math.round((VDU[35] * fdtbl_UV[35]));VDU[36] = Math.round((VDU[36] * fdtbl_UV[36]));VDU[37] = Math.round((VDU[37] * fdtbl_UV[37]));VDU[38] = Math.round((VDU[38] * fdtbl_UV[38]));VDU[39] = Math.round((VDU[39] * fdtbl_UV[39]));VDU[40] = Math.round((VDU[40] * fdtbl_UV[40]));VDU[41] = Math.round((VDU[41] * fdtbl_UV[41]));VDU[42] = Math.round((VDU[42] * fdtbl_UV[42]));VDU[43] = Math.round((VDU[43] * fdtbl_UV[43]));VDU[44] = Math.round((VDU[44] * fdtbl_UV[44]));VDU[45] = Math.round((VDU[45] * fdtbl_UV[45]));VDU[46] = Math.round((VDU[46] * fdtbl_UV[46]));VDU[47] = Math.round((VDU[47] * fdtbl_UV[47]));VDU[48] = Math.round((VDU[48] * fdtbl_UV[48]));VDU[49] = Math.round((VDU[49] * fdtbl_UV[49]));VDU[50] = Math.round((VDU[50] * fdtbl_UV[50]));VDU[51] = Math.round((VDU[51] * fdtbl_UV[51]));VDU[52] = Math.round((VDU[52] * fdtbl_UV[52]));VDU[53] = Math.round((VDU[53] * fdtbl_UV[53]));VDU[54] = Math.round((VDU[54] * fdtbl_UV[54]));VDU[55] = Math.round((VDU[55] * fdtbl_UV[55]));VDU[56] = Math.round((VDU[56] * fdtbl_UV[56]));VDU[57] = Math.round((VDU[57] * fdtbl_UV[57]));VDU[58] = Math.round((VDU[58] * fdtbl_UV[58]));VDU[59] = Math.round((VDU[59] * fdtbl_UV[59]));VDU[60] = Math.round((VDU[60] * fdtbl_UV[60]));VDU[61] = Math.round((VDU[61] * fdtbl_UV[61]));VDU[62] = Math.round((VDU[62] * fdtbl_UV[62]));VDU[63] = Math.round((VDU[63] * fdtbl_UV[63]));
				
				// ZigZag reorder
				//for(i=0;i<64;i++){DU[ZigZag[i]] = VDU[i];}
				DU[ZigZag[0]] = VDU[0];DU[ZigZag[1]] = VDU[1];DU[ZigZag[2]] = VDU[2];DU[ZigZag[3]] = VDU[3];DU[ZigZag[4]] = VDU[4];DU[ZigZag[5]] = VDU[5];DU[ZigZag[6]] = VDU[6];DU[ZigZag[7]] = VDU[7];DU[ZigZag[8]] = VDU[8];DU[ZigZag[9]] = VDU[9];DU[ZigZag[10]] = VDU[10];DU[ZigZag[11]] = VDU[11];DU[ZigZag[12]] = VDU[12];DU[ZigZag[13]] = VDU[13];DU[ZigZag[14]] = VDU[14];DU[ZigZag[15]] = VDU[15];DU[ZigZag[16]] = VDU[16];DU[ZigZag[17]] = VDU[17];DU[ZigZag[18]] = VDU[18];DU[ZigZag[19]] = VDU[19];DU[ZigZag[20]] = VDU[20];DU[ZigZag[21]] = VDU[21];DU[ZigZag[22]] = VDU[22];DU[ZigZag[23]] = VDU[23];DU[ZigZag[24]] = VDU[24];DU[ZigZag[25]] = VDU[25];DU[ZigZag[26]] = VDU[26];DU[ZigZag[27]] = VDU[27];DU[ZigZag[28]] = VDU[28];DU[ZigZag[29]] = VDU[29];DU[ZigZag[30]] = VDU[30];DU[ZigZag[31]] = VDU[31];DU[ZigZag[32]] = VDU[32];DU[ZigZag[33]] = VDU[33];DU[ZigZag[34]] = VDU[34];DU[ZigZag[35]] = VDU[35];DU[ZigZag[36]] = VDU[36];DU[ZigZag[37]] = VDU[37];DU[ZigZag[38]] = VDU[38];DU[ZigZag[39]] = VDU[39];DU[ZigZag[40]] = VDU[40];DU[ZigZag[41]] = VDU[41];DU[ZigZag[42]] = VDU[42];DU[ZigZag[43]] = VDU[43];DU[ZigZag[44]] = VDU[44];DU[ZigZag[45]] = VDU[45];DU[ZigZag[46]] = VDU[46];DU[ZigZag[47]] = VDU[47];DU[ZigZag[48]] = VDU[48];DU[ZigZag[49]] = VDU[49];DU[ZigZag[50]] = VDU[50];DU[ZigZag[51]] = VDU[51];DU[ZigZag[52]] = VDU[52];DU[ZigZag[53]] = VDU[53];DU[ZigZag[54]] = VDU[54];DU[ZigZag[55]] = VDU[55];DU[ZigZag[56]] = VDU[56];DU[ZigZag[57]] = VDU[57];DU[ZigZag[58]] = VDU[58];DU[ZigZag[59]] = VDU[59];DU[ZigZag[60]] = VDU[60];DU[ZigZag[61]] = VDU[61];DU[ZigZag[62]] = VDU[62];DU[ZigZag[63]] = VDU[63];
				
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
				
				posY+=32;
			}
			
			posY+=DPosYY;
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