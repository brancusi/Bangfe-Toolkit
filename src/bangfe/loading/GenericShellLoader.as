package bangfe.loading
{
	import bangfe.core.CoreDisplayObject;
	import bangfe.core.IRunnable;
	import bangfe.display.InfiniteSpinner;
	
	import com.greensock.TweenMax;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.SWFLoader;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.errors.IllegalOperationError;
	
	import org.osflash.signals.Signal;
	
	import system.numeric.Range;
	
	/**
	 * This is a generic swf loader. It can be used to load the main application swf
	 * for a project. It uses LoaderMax, and will tie in nested loading.
	 *  
	 * @author Will Zadikian
	 * 
	 */	
	public class GenericShellLoader extends Sprite
	{
		
		//--------------------------------------
		//  SIGNALS
		//--------------------------------------
		/**
		 * Dispatched when the loaded swf inits 
		 */		
		public var loadInited : Signal = new Signal();
		
		/**
		 * Dispatched when all the loading is complete 
		 */		
		public var loadCompleted : Signal = new Signal();
		
		//--------------------------------------
		//  PRIVATE VARIABLES
		//--------------------------------------
		private var _swfLoader : LoaderMax;
		private var _range : Range = new Range(0, 1);
		private var _targetSWFID : String = "__defaultTargetID__";
		private var _targetSWFURL : String = "application.swf";
		private var _targetContainer : DisplayObjectContainer;
		private var _content : *;
		
		//--------------------------------------
		//  PUBLIC METHODS
		//--------------------------------------
		/**
		 * Constructor 
		 * 
		 */
		public function GenericShellLoader () : void
		{
			init();
		}
		
		/**
		 * Start the load 
		 * 
		 */		
		public function load ( p_targetContainer : DisplayObjectContainer = null ) : void
		{
			if(p_targetContainer != null)targetContainer = p_targetContainer;
			if(_targetContainer == null)throw new IllegalOperationError("You must define the target container before calling load");
			
			_swfLoader = new LoaderMax({ onProgress:onProgressHandler, onComplete:masterOnCompleteHandler});
			_swfLoader.append(new SWFLoader(targetSWFURL, {name:targetSWFID, onInit:mainSWFInitHandler}));
			_swfLoader.load();
		}
		
		//--------------------------------------
		//  ACCESSOR/MUTATOR METHODS
		//--------------------------------------
		/**
		 * The target swf id to be used to reference the loaded swf 
		 * @return 
		 * 
		 */
		public function get targetSWFID () : String
		{
			return _targetSWFID;
		}
		
		public function set targetSWFID ( p_targetSWFID : String) : void
		{
			_targetSWFID = p_targetSWFID;
		}
		
		/**
		 * The url of the swf to load 
		 * @return 
		 * 
		 */		
		public function get targetSWFURL () : String
		{
			return _targetSWFURL;
		}
		
		public function set targetSWFURL ( p_targetSWFURL : String) : void
		{
			_targetSWFURL = p_targetSWFURL;
		}
		
		/**
		 * The container to inject the content into 
		 * @return 
		 * 
		 */		
		public function get targetContainer () : DisplayObjectContainer
		{
			return _targetContainer;
		}
		
		public function set targetContainer ( p_targetContainer : DisplayObjectContainer) : void
		{
			_targetContainer = p_targetContainer;
		}
		
		/**
		 * The raw loaded content 
		 * @return 
		 * 
		 */		
		public function get content () : *
		{
			return _content;
		}
		
		//--------------------------------------
		//  PROTECTED METHODS
		//--------------------------------------
		/**
		 * Set global defaults 
		 * 
		 */		
		protected function setGlobalDefaults () : void
		{
			this.stage.align = StageAlign.TOP_LEFT;
			this.stage.scaleMode = StageScaleMode.NO_SCALE;
		}
		
		/**
		 * Set defaults. Use to set up swf location and content container 
		 * 
		 */		
		protected function setDefaults () : void
		{
			//Override
		}
		
		/**
		 * Called after the target swf is loaded. It will attempt to call run() on the target implements 
		 * IRunnable.
		 * 
		 */		
		protected function onSwfInit () : void
		{
			if(content is IRunnable)IRunnable(content).run();
		}
		
		/**
		 * Called when the swf and sub loaders have completed 
		 * @param p_content
		 * 
		 */		
		protected function onSwfComplete () : void
		{
			//Override
		}
		
		/**
		 * This gets called on loadermax progress update.
		 * The value will be pre clamped between 0-1
		 *  
		 * @param p_progress Current load percentage, clamped between 0-1 
		 * 
		 */		
		protected function progressUpdate ( p_progress : Number ) : void
		{
			//Override
		}
		
		//--------------------------------------
		//  PRIVATE METHODS
		//--------------------------------------
		private function init () : void
		{
			setGlobalDefaults();
			setDefaults();
		}
		
		//--------------------------------------
		//  HANDLER METHODS
		//--------------------------------------
		private function mainSWFInitHandler ( e : LoaderEvent ) : void
		{
			var swfLoader : SWFLoader = _swfLoader.getLoader(targetSWFID) as SWFLoader;
			_content = swfLoader.rawContent;
			
			targetContainer.addChild(_content);
			
			onSwfInit();
			
			//Dispatch Signal
			loadInited.dispatch();
		}
		
		private function onProgressHandler ( e : LoaderEvent ) : void
		{
			progressUpdate(_range.clamp(e.target.progress));
		}
		
		private function masterOnCompleteHandler ( e : LoaderEvent ) : void
		{
			onSwfComplete();
			
			//Dispatch Signal
			loadCompleted.dispatch();
		}
	}
}