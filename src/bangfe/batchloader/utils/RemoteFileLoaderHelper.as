package bangfe.batchloader.utils
{
	import bangfe.batchloader.BatchLoader;
	import bangfe.utils.CountDownTimer;
	
	import calista.utils.Base64;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;

	public class RemoteFileLoaderHelper
	{
		
		//--------------------------------------
		//  PRIVATE VARIABLES
		//--------------------------------------
		private var _entry : String = "";
		private var _idleTimer : CountDownTimer = new CountDownTimer();
		private var _scope : DisplayObjectContainer;
		private var _matchKey : String;
		private var _removeKey : String;
		private var _url : String;
		private var _container : DisplayObjectContainer;
		
		private var _content : *;
		
		//--------------------------------------
		//  PUBLIC METHODS
		//--------------------------------------
		/**
		 * Constructor 
		 * 
		 */
		public function RemoteFileLoaderHelper()
		{
			init();
		}
		
		/**
		 * Activate listening 
		 * 
		 */
		public function activate () : void
		{
			try{
				_scope.stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			}catch(e:Error){}
			
			try{
				_scope.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler, false, 0, true);
			}catch(e:Error){}
		}
		
		/**
		 * Deactivate listening 
		 * 
		 */
		public function deActivate () : void
		{
			try{
				_scope.stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			}catch(e:Error){}
		}
		
		//--------------------------------------
		//  ACCESSOR METHODS
		//--------------------------------------
		/**
		 * Scope to listen on 
		 * @return 
		 * 
		 */
		public function get scope () : DisplayObjectContainer
		{
			return _scope;
		}

		public function set scope ( p_scope : DisplayObjectContainer ) : void
		{
			try{
				_scope.stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			}catch(e:Error){}
			
			_scope = p_scope;
		}
		
		/**
		 * Key to match against - Base64 Encoded
		 * @return 
		 * 
		 */
		public function get matchKey () : String
		{
			return _matchKey;
		}

		public function set matchKey ( p_matchKey : String ) : void
		{
			_matchKey = Base64.decode(p_matchKey);
		}
		
		/**
		 * Key to match against to remove  - Base64 Encoded
		 * @return 
		 * 
		 */
		public function get removeKey () : String
		{
			return _removeKey;
		}
		
		public function set removeKey ( p_removeKey : String ) : void
		{
			_removeKey = Base64.decode(p_removeKey);;
		}
		
		/**
		 * URL of content to load 
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
		 * Container to inject content into 
		 * @return 
		 * 
		 */
		public function get container () : DisplayObjectContainer
		{
			return _container;
		}

		public function set container ( p_container : DisplayObjectContainer ) : void
		{
			_container = p_container;
		}
		
		//--------------------------------------
		//  PRIVATE METHODS
		//--------------------------------------
		
		private function init () : void
		{
			setDefaults();
		}
		
		private function setDefaults () : void
		{
			_idleTimer.duration = 3000;
			_idleTimer.bind(clearEntry);
		}
		
		private function loadHelperSwf () : void
		{
			var batchLoader : BatchLoader = new BatchLoader();
			batchLoader.injectContent(url, addContent);
		}
		
		private function clearEntry ( e : TimerEvent = null ) : void
		{
			_entry = "";
		}
		
		private function addEntry ( p_entry : String ) : void
		{
			_idleTimer.reset();
			_entry += p_entry;
			if(_entry == matchKey){
				clearEntry();
				loadHelperSwf();
			}
			
			if(_entry == removeKey){
				clearEntry();
				removeContent();
			}
		}
		
		private function addContent ( p_content : * ) : void
		{
			if(!container)container = scope;
			try{
				container.removeChild(_content);
			}catch(e:Error){}
			
			_content = p_content;
			container.addChild(_content);
			try{
				_content.init();
			}catch(e:Error){}
		}
		
		private function removeContent () : void
		{
			if(!container)container = scope;
			try{
				container.removeChild(_content);
			}catch(e:Error){}
			
			try{
				_content.destroy();
			}catch(e:Error){}
		}
		
		//--------------------------------------
		//  HANDLER METHODS
		//--------------------------------------
		private function keyDownHandler ( e : KeyboardEvent ) : void
		{
			addEntry(String.fromCharCode(e.charCode));
		}
		
	}
}








