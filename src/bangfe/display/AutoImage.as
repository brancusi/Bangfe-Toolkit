package bangfe.display
{
	import com.greensock.TweenLite;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.CapsStyle;
	import flash.display.JointStyle;
	import flash.display.LineScaleMode;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.geom.Matrix;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;

	 /**
	 * Dispatched once image has loaded and is added to the stage
	 * @eventType bangfe.display.AutoImage.IMAGE_READY
	 */
	[Event(name="imageReady", type="bangfe.display.AutoImage")]
	
	 /**
	 * Dispatched during onUpdate tween event
	 * @eventType bangfe.display.AutoImage.IMAGE_TRANSITIONING
	 */
	[Event(name="imageTransitioning", type="bangfe.display.AutoImage")]
	
	/**
	 * Simple image class. Takes a url and loads the image.
	 * 
	 */	
	public class AutoImage extends Sprite
	{
		
		//--------------------------------------
		//  CONSTANTS
		//--------------------------------------
		/**
		 * Image ready event name
		 */
		public static const IMAGE_READY : String = "imageReady";
		
		/**
		 * Image Transitioning event name
		 */
		public static const IMAGE_TRANSITIONING : String = "imageTransitioning";
		
		/**
		 * The image should fill the area difined width and height.
		 */
		public static const EXTENSIONS_ARRAY : Array = ["jpg", "jpeg", "gif", "png"];
		
		/**
		 * The image should fill the area difined width and height.
		 */
		public static const FILL : String = "fill";
		
		/**
		 * The image should scale fit and center to the the area difined width and height.
		 */
		public static const FIT : String = "fit";
		
		/**
		 * The image should display its full, non-croppped size. 
		 */
		public static const NO_SCALE : String = "noScale";
		
		//--------------------------------------
		//  PROTECTED VARIABLES
		//--------------------------------------
		protected var _url : String;
		
		protected var _imageLoader : Loader;
		
		protected var _borderColor : Number = 0x000000;
		
		protected var _fillColor : Number = 0x000000;
		
		protected var _imageWidth : Number;
		
		protected var _imageHeight : Number;
		
		protected var _drawBorder : Boolean = false;
		
		protected var _container : Sprite = new Sprite();
		
		protected var _scaleType : String = "noScale";
		
		protected var _currentBitmap : Bitmap;
		
		protected var _extensionArray : Array;
		
		//--------------------------------------
		//  PUBLIC METHODS
		//--------------------------------------
		
		/**
		 * Constructor 
		 * @param p_url
		 * 
		 */		
		public function AutoImage ( width : Number = 100, height : Number = 100, scaleType : String = FIT )
		{	
			setDefaults();
			addListeners();
			
			if(width)this.width = width;
			if(height)this.height = height;
			if(scaleType)this.scaleType = scaleType;
		}
		
		/**
		 * Fadeout and destroy the image 
		 * 
		 */		
		public function destroy () : void
		{
			removeListeners();
			TweenLite.to(this, .25, {alpha:0, onUpdate:notifyTransitionChange, onComplete:function():void{
				if(parent)parent.removeChild(this);
			}});
		}
		
		public function clearImages () : void
		{
			TweenLite.to(this, .25, {alpha:0, onUpdate:notifyTransitionChange, onComplete:function():void{
				_container.graphics.clear();
			}});
		}
		
		//--------------------------------------
		//  ACCESSOR METHODS
		//--------------------------------------
		
		/**
		 * Image width to draw 
		 * @return 
		 * 
		 */		
		override public function get width () : Number 
		{
			return _imageWidth; 
		}

		override public function set width ( value : Number ) : void 
		{ 
			if(_imageWidth == value)return;
			_imageWidth = value;
			generateImage();
		}
		
		public function get rawWidth () : Number
		{
			if(currentBitmap)return currentBitmap.width; 
			return this.width;
		}
		
		public function get rawHeight () : Number
		{
			if(currentBitmap)return currentBitmap.height; 
			return this.height;
		}
		
		/**
		 * Image height to draw 
		 * @return 
		 * 
		 */		
		override public function get height () : Number 
		{
			return _imageHeight; 
		}

		override public function set height ( value : Number ) : void 
		{ 
			if(_imageHeight == value)return;
			_imageHeight = value; 
			generateImage();
		}
		
		/**
		 * Should the autoimage draw a border 
		 * @return 
		 * 
		 */		
		public function get drawBorder () : Boolean 
		{
			return _drawBorder; 
		}

		public function set drawBorder ( p_drawBorder : Boolean ) : void 
		{ 
			_drawBorder = p_drawBorder;
			generateImage(); 
		}
		
		/**
		 * URL to load 
		 * @return 
		 * 
		 */		
		public function get url () : String
		{
			return _url;
		}

		public function set url ( p_url : String ) : void
		{
			if(_url == p_url)return;
			_url = p_url;
			_extensionArray = EXTENSIONS_ARRAY.slice();
			load();
		}
		
		/**
		 * URI cleaned of the file extension 
		 * @return 
		 * 
		 */		
		public function get uri () : String
		{
			var newString : String = url;
			
			for(var i : int = 0; i < EXTENSIONS_ARRAY.length; i++){
				newString = newString.replace(("." + EXTENSIONS_ARRAY[i]), "");
			}
			
			return newString;
		}
		
		/**
		 * How should the image scale 
		 * @return 
		 * 
		 */
		public function get scaleType () : String
		{
			return _scaleType;
		}

		public function set scaleType ( p_scaleType : String ) : void
		{
			_scaleType = p_scaleType;
			generateImage();
		}
		
		/**
		 * The current Loader for this <code>AutoImage</code> 
		 * @return 
		 * 
		 */
		public function get imageLoader () : Loader
		{
			return _imageLoader;
		}
		
		/**
		 * The current bitmap being or about to be displayed 
		 * @return 
		 * 
		 */
		public function get currentBitmap () : Bitmap
		{
			return _currentBitmap;
		}
		
		public function set currentBitmap ( p_bitmap : Bitmap ) : void
		{
			_currentBitmap = p_bitmap;
			_currentBitmap.smoothing = true;
			TweenLite.to(this, .25, {alpha:0, onComplete:generateImage, onUpdate:notifyTransitionChange});
		}
		
		/**
		 * Fill color 
		 * @return 
		 * 
		 */		
		public function get fillColor () : Number
		{
			return _fillColor;
		}

		public function set fillColor ( p_fillColor : Number ) : void
		{
			_fillColor = p_fillColor;
		}
		
		//--------------------------------------
		//  PROTECTED METHODS
		//--------------------------------------
		protected function setDefaults () : void
		{	
			addChild(_container);
			_imageLoader = new Loader();
			this.mouseChildren = false;
			this.mouseEnabled = false;
			
			_container.mouseEnabled = false;
			_container.mouseChildren = false; 
		}
		
		protected function addListeners () : void
		{
			imageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, imageCompleteHandler, false, 0, true);
			imageLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler, false, 0, true);
		}
		
		protected function removeListeners () : void
		{
			imageLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, imageCompleteHandler);
			imageLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
		}
		
		protected function load () : void
		{
			_container.graphics.clear();
			var request : URLRequest = new URLRequest(url);
			imageLoader.load(request, new LoaderContext(true));
		}
		
		protected function generateImage () : void
		{
		
			if(!currentBitmap)return;
			if(isNaN(width))width = imageLoader.width;
			if(isNaN(height))height = imageLoader.height;
			
			currentBitmap.scaleX = currentBitmap.scaleY = 1;
			currentBitmap.smoothing = true;
			
			var widthFactor:Number = width/currentBitmap.width;
			var heightFactor:Number = height/currentBitmap.height;
			
			switch(scaleType){
				case FILL :
					currentBitmap.scaleX = currentBitmap.scaleY = Math.max(widthFactor, heightFactor);
					break;
				case FIT :
					currentBitmap.scaleX = currentBitmap.scaleY = Math.min(widthFactor, heightFactor);
					break;
				default:
					//
				break;
			}
			
			drawBitmap();
		}
		
		protected function drawBitmap () : void
		{
			_container.graphics.clear();
			
			var tempWidth : Number = currentBitmap.width;
			var tempHeight : Number = currentBitmap.height;
			
			switch(scaleType){
				case NO_SCALE :
					tempWidth = currentBitmap.width;
					tempHeight = currentBitmap.height;
					break;
				default:
					tempWidth = width;
					tempHeight = height;
					break;
			}
			
			var matrix : Matrix = new Matrix();
			matrix.tx = -(currentBitmap.width/2 - tempWidth/2);
			matrix.ty = -(currentBitmap.height/2 - tempHeight/2);
			var bitmapData : BitmapData = new BitmapData(tempWidth, tempHeight, true, fillColor);
			
			//Must add to container for draw to work
			var tempContainer : Sprite = new Sprite();
			tempContainer.addChild(currentBitmap);
			
			bitmapData.draw(tempContainer, matrix, null, null, null, true);
			
			_container.graphics.beginBitmapFill(bitmapData, null, false, true);
			if(drawBorder)_container.graphics.lineStyle(1, _borderColor, 1, false, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER);
			_container.graphics.drawRect(0, 0, tempWidth, tempHeight);
			_container.graphics.endFill();
			
			TweenLite.to(this, .25, {alpha:1, onUpdate:notifyTransitionChange, onComplete:notifyComplete});
		}
		
		private function attemptLoadAlternateExtension () : void
		{
			if(_extensionArray.length < 1){
				trace("There was no image found with URI: " + uri, "\n", "Attempted to use the following extensions : ", EXTENSIONS_ARRAY.toString());
				return;
			}
			
			var extension : String = _extensionArray.shift();
			_url = uri + "." + extension;
			
			load();
		}
		
		private function clearAlternateLoadAttemp () : void
		{
			_extensionArray = null;
		}
		
		//--------------------------------------
		//  HANDLER METHODS
		//--------------------------------------
		protected function imageCompleteHandler ( e : Event ) : void
		{
			currentBitmap = Bitmap(imageLoader.content);
		}
		
		protected function notifyTransitionChange () : void
		{
			dispatchEvent(new Event(IMAGE_TRANSITIONING));	
		}
		
		protected function notifyComplete () : void
		{
			dispatchEvent(new Event(IMAGE_READY));
		}
			
		protected function ioErrorHandler ( e : IOErrorEvent ) : void
		{
			attemptLoadAlternateExtension();
		}

	}
}