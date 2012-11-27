package bangfe.display
{
	
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
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.system.SecurityDomain;
	
	import org.osflash.signals.Signal;
	
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
		 * Loading Error event name
		 */
		public static const LOAD_ERROR : String = "loadError";
		
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
		//  PRIVATE VARIABLES
		//--------------------------------------
		private var _url : String;
		private var _imageLoader : Loader;	
		private var _imageWidth : Number;
		private var _imageHeight : Number;
		private var _drawBorder : Boolean = false;
		private var _container : Sprite = new Sprite();
		private var _scaleType : String = FILL;
		private var _bitmap : Bitmap;
		private var _buffer : Bitmap;
		private var _extensionArray : Array;
		private var _readySignal : Signal = new Signal(AutoImage);
		private var _errorSignal : Signal = new Signal(AutoImage);
		
		//--------------------------------------
		//  PUBLIC METHODS
		//--------------------------------------
		/**
		 * Constructor 
		 * @param width The width of the image
		 * @param height The height of the image
		 * @param scaleType Scale type
		 * 
		 */		
		public function AutoImage ( width : Number = 100, height : Number = 100, scaleType : String = FILL )
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
			if(parent)parent.removeChild(this);
			_url = null
		}
		
		/**
		 * Clear out old images 
		 * 
		 */		
		public function clearImages () : void
		{
			_container.graphics.clear();
			_url = null
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
		 * The raw bitmap width 
		 * @return 
		 * 
		 */		
		public function get rawWidth () : Number
		{
			if(bitmap)return bitmap.width; 
			return this.width;
		}
		
		/**
		 * The raw bitmap height 
		 * @return 
		 * 
		 */		
		public function get rawHeight () : Number
		{
			if(bitmap)return bitmap.height; 
			return this.height;
		}
		
		/**
		 * The buffer width. This is the actual visible image width 
		 * @return 
		 * 
		 */		
		public function get bufferWidth () : Number 
		{
			if(_buffer)return _buffer.width; 
			return this.width;
		}
		
		/**
		 * The buffer height. This is the actual visible image height 
		 * @return 
		 * 
		 */		
		public function get bufferHeight () : Number 
		{
			if(_buffer)return _buffer.height; 
			return this.height;
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
			if(p_url == null || p_url == "")clearImages();
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
		public function get bitmap () : Bitmap
		{
			return _bitmap;
		}
		
		public function set bitmap ( p_bitmap : Bitmap ) : void
		{
			_bitmap = p_bitmap;
			generateImage();
		}
		
		/**
		 * Signal - Dispatched when the image has loaded
		 * 
		 * Handlers must accept the following params:
		 * 
		 * 1) AutoImage - The <code>AutoImage</code> that triggered the complete event 
		 * 
		 * @return 
		 * 
		 */		
		public function get readySignal () : Signal 
		{
			return _readySignal;
		}
		
		/**
		 * Signal - Dispatched when the image load has failed
		 * 
		 * Handlers must accept the following params:
		 * 
		 * 1) AutoImage - The <code>AutoImage</code> that triggered the load error 
		 * @return 
		 * 
		 */		
		public function get errorSignal () : Signal 
		{
			return _errorSignal;
		}
		
		//--------------------------------------
		//  PRIVATE METHODS
		//--------------------------------------
		private function setDefaults () : void
		{	
			addChild(_container);
			_imageLoader = new Loader();
			this.mouseChildren = false;
			this.mouseEnabled = false;
			
			_container.mouseEnabled = false;
			_container.mouseChildren = false; 
		}
		
		private function addListeners () : void
		{
			imageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, imageCompleteHandler, false, 0, true);
			imageLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler, false, 0, true);
		}
		
		private function removeListeners () : void
		{
			imageLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, imageCompleteHandler);
			imageLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
		}
		
		private function load () : void
		{
			var request : URLRequest = new URLRequest(url);
			
			var context : LoaderContext = new LoaderContext();
			
			context.applicationDomain = ApplicationDomain.currentDomain; 
			context.checkPolicyFile = true;
			
			imageLoader.load(request, context);
		}
		
		private function generateImage () : void
		{
			if(!bitmap)return;
			if(isNaN(width))width = bitmap.width;
			if(isNaN(height))height = bitmap.height;
			
			_buffer = new Bitmap(_bitmap.bitmapData.clone());
			_buffer.smoothing = true;
			
			var widthFactor:Number = width/_buffer.width;
			var heightFactor:Number = height/_buffer.height;
			
			switch(scaleType){
				case FILL :
					_buffer.scaleX = _buffer.scaleY = Math.max(widthFactor, heightFactor);
					break;
				case FIT :
					_buffer.scaleX = _buffer.scaleY = Math.min(widthFactor, heightFactor);
					break;
				default:
					//
					break;
			}

			drawBitmap();
		}
		
		private function drawBitmap () : void
		{
			_container.graphics.clear();
			
			var tempWidth : Number;
			var tempHeight : Number;
			
			switch(scaleType){
				case NO_SCALE :
					tempWidth = _buffer.width;
					tempHeight = _buffer.height;
					break;
				case FIT :
					tempWidth = _buffer.width;
					tempHeight = _buffer.height;
					break;
				case FILL :
					tempWidth = width;
					tempHeight = height;
					break;
			}
			
			var matrix : Matrix = new Matrix();
			matrix.tx = -(_buffer.width/2 - tempWidth/2);
			matrix.ty = -(_buffer.height/2 - tempHeight/2);
			var bitmapData : BitmapData = new BitmapData(tempWidth, tempHeight, true, 0xe3e3e3);
			
			//Must add to container for draw to work
			var tempContainer : Sprite = new Sprite();
			tempContainer.addChild(_buffer);
			
			bitmapData.draw(tempContainer, matrix, null, null, null, true);
			
			_container.graphics.beginBitmapFill(bitmapData, null, false, true);
			
			_container.graphics.drawRect(0, 0, tempWidth, tempHeight);
			_container.graphics.endFill();
			
			notifyReady();
		}
		
		private function attemptLoadAlternateExtension () : void
		{
			if(_extensionArray.length < 1){
				trace("There was no image found with URI: " + uri, "\n", "Attempted to use the following extensions : ", EXTENSIONS_ARRAY.toString());
				_errorSignal.dispatch(this);
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
			bitmap = Bitmap(imageLoader.content);
		}
		
		protected function notifyReady () : void
		{
			_readySignal.dispatch(this);
		}
		
		protected function ioErrorHandler ( e : IOErrorEvent ) : void
		{
			attemptLoadAlternateExtension();
		}
		
	}
}