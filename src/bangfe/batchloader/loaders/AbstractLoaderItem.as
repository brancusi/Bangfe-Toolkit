package bangfe.batchloader.loaders
{
	import bangfe.batchloader.core.ILoaderItem;
	import bangfe.batchloader.events.LoaderItemEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	
	/**
	* Dispatched when LoaderItem openes new connection
	*
	* @eventType com.bangfe.batchloader.events.LoaderItemEvent.OPENED
	*/			
	[Event(name="loaderItemOpened", type="com.bangfe.batchloader.events.LoaderItemEvent")]
	
	/**
	* Dispatched when LoaderItem closes connection
	*
	* @eventType com.bangfe.batchloader.events.LoaderItemEvent.CLOSED
	*/			
	[Event(name="loaderItemClosed", type="com.bangfe.batchloader.events.LoaderItemEvent")]
	
	/**
	* Dispatched when LoaderItem complete load and is ready for consumption
	*
	* @eventType com.bangfe.batchloader.events.LoaderItemEvent.COMPLETED
	*/			
	[Event(name="loaderItemCompleted", type="com.bangfe.batchloader.events.LoaderItemEvent")]
	
	/**
	* Dispatched when LoaderItem failed to load
	*
	* @eventType com.bangfe.batchloader.events.LoaderItemEvent.FAILED
	*/			
	[Event(name="loaderItemFailed", type="com.bangfe.batchloader.events.LoaderItemEvent")]
	
	/**
	 * Loader Item for BatchLoader 
	 * @author Will Zadikian
	 * 
	 */	
	public class AbstractLoaderItem extends EventDispatcher implements ILoaderItem
	{
		
		//--------------------------------------
		//  PROTECTED VARIABLES
		//--------------------------------------
		protected var _isComplete : Boolean = false;
		protected var _isFailed : Boolean = false;
		protected var _isLoading : Boolean = false;
		
		protected var _isPaused : Boolean = false;
		
		protected var _uid : String;
		protected var _url : String;
		
		protected var _content : *;
		
		//--------------------------------------
		//  PUBLIC METHODS
		//--------------------------------------
		/**
		 * Constructor 
		 * @param p_uid UID of loader itme
		 * @param p_url URL to load
		 * 
		 */		
		public function AbstractLoaderItem( p_url : String = null, p_props : Object = null)
		{
			processArguments(p_url, p_props);
			init();
		}
		
		/**
		 * Resume the loader item 
		 * 
		 */		
		public function resume () : void
		{
			isPaused = false;
		}
		
		/**
		 * Pause the loader item 
		 * 
		 */		
		public function pause () : void
		{
			isPaused = true;
			stopLoad();
		}
		
		/**
		 * Load the loader item. Will not processs if paused. 
		 * 
		 */		
		public function load () : void
		{
			initializeLoad();
		}
		
		//--------------------------------------
		//  ACCESSOR METHODS
		//--------------------------------------
		/**
		 * UID for this loader item 
		 * @return 
		 * 
		 */		
		public function get uid () : String 
		{
			return _uid; 
		}

		public function set uid ( p_uid : String ) : void 
		{ 
			_uid = p_uid; 
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
			_url = p_url; 
		}
		
		/**
		 * Is the loader item complete 
		 * @return 
		 * 
		 */		
		public function get isCompleted () : Boolean 
		{
			return _isComplete; 
		}

		public function set isCompleted ( p_isComplete : Boolean ) : void 
		{ 
			_isComplete = p_isComplete; 
		}
		
		/**
		 * Is the loader item currently paused 
		 * @return 
		 * 
		 */		
		public function get isPaused () : Boolean 
		{
			return _isPaused; 
		}

		public function set isPaused ( p_isPaused : Boolean ) : void 
		{ 
			_isPaused = p_isPaused; 
		}
		
		/**
		 * Bitmap content from loader 
		 * @return 
		 * 
		 */		
		public function get content () : * 
		{
			return _content; 
		}
		
		public function set content ( p_content : * ) : void 
		{
			_content = p_content; 
		}
		
		/**
		 * Has the loader failed to load the content 
		 * @return 
		 * 
		 */		
		public function get isFailed () : Boolean 
		{
			return _isFailed; 
		}

		public function set isFailed ( p_isFailed : Boolean ) : void 
		{ 
			_isFailed = p_isFailed; 
		}
		
		/**
		 * Is the loader currently loading 
		 * @return 
		 * 
		 */		
		public function get isLoading () : Boolean 
		{
			return _isLoading; 
		}

		public function set isLoading ( p_isLoading : Boolean ) : void 
		{ 
			_isLoading = p_isLoading; 
		}
		
		//--------------------------------------
		//  PROTECTED METHODS
		//--------------------------------------
		protected function init () : void
		{
			setDefaults();
		}
		
		protected function setDefaults () : void
		{
			//Override
			createLoader();
		}
		
		protected function createLoader () : void
		{
			//Override
		}	
		
		protected function processArguments ( p_url : String = null, p_props : Object = null ) : void
		{
			if(p_url){
				url = p_url;
				uid = p_url;
			}
			
			if(p_props){
				if(p_props.uid)uid = p_props.uid;
				if(p_props.paused)pause();
			}
		}
		
		protected function initializeLoad () : void
		{
			if(isCompleted || isFailed || isPaused || isLoading)return;
			isLoading = true;
			startLoaderLoad();
		}
		
		protected function startLoaderLoad () : void
		{
			//Override
		}
		
		protected function stopLoad () : void
		{
			isLoading = false;
			stopLoaderLoad();
		}
		
		protected function stopLoaderLoad () : void
		{
			//Override
		}
		
		protected function processContent () : void
		{
			//Override
		}

		//--------------------------------------
		//  HANDLER METHODS
		//--------------------------------------
		
		protected function progressHandler ( e : ProgressEvent ) : void
		{
			//trace(uid + " : " + e.bytesLoaded/e.bytesTotal);
		}
		
		protected function completeHandler ( e : Event ) : void
		{
			isCompleted = true;
			isLoading = false;
			
			processContent();
			dispatchEvent( new LoaderItemEvent(LoaderItemEvent.COMPLETED));
		}
		
		protected function ioErrorHandler ( e : IOErrorEvent ) : void
		{
			trace(e.type + " : " + url)
			isFailed = true;
			isLoading = false;
			
			dispatchEvent( new LoaderItemEvent(LoaderItemEvent.FAILED));
		}
		
		protected function openHandler ( e : Event ) : void
		{
			dispatchEvent( new LoaderItemEvent(LoaderItemEvent.OPENED));
		}
		
		protected function deactiveHandler ( e : Event ) : void
		{
			dispatchEvent( new LoaderItemEvent(LoaderItemEvent.CLOSED));
		}
		
		protected function unLoadHandler ( e : Event ) : void
		{
			dispatchEvent( new LoaderItemEvent(LoaderItemEvent.CLOSED));
		}
		
		protected function httpStatusEvent ( e : HTTPStatusEvent ) : void
		{
			//trace(e.type)
		}

		
	}
}