package bangfe.core
{
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * A core level movieclip object. Handles basic cleanup, data, draw, defaulting mechanisms.
	 * This can be used as the base class for any <code>DisplayObject</code> including document classes
	 * 
	 * This has the same logic as CoreDisplayObject except that it extends MovieClip. Use whenever a timeline is needed
	 *  
	 * @author Will Zadikian
	 * 
	 */
	public class CoreMovieClipObject extends MovieClip implements ICoreObject
	{
		//--------------------------------------
		//  PRIVATE VARIABLES
		//--------------------------------------
		private var _isDestroyed : Boolean = false;
		private var _isRemoved : Boolean = false;
		private var _autoDestroy : Boolean = true;
		
		private var _data : *;
		
		//--------------------------------------
		//  PUBLIC METHODS
		//--------------------------------------
		/**
		 * Constructor 
		 * 
		 */
		public function CoreMovieClipObject()
		{
			init();
		}
		
		/** @inheritDoc */
		public function destroy () : void
		{
			if(isDestroyed)return;
			_isDestroyed = true;
			
			removeInternalListeners();
			removeGlobalListeners();
			removeGlobalStageListeners();
			removeListeners();
			removeStageListeners();
			
			if(parent && !isRemoved)parent.removeChild(this);
			
			//Recurisvly destroy children
			for (var i : int = this.numChildren-1; i > 0; i--){
				var child : DisplayObject = this.getChildAt(i);
				if(child is CoreDisplayObject)CoreDisplayObject(child).destroy();
			}
		}
		
		/**
		 * Realign the elements of this module 
		 * 
		 */
		public function reAlign () : void
		{
			//Override
		}
		
		//--------------------------------------
		//  ACCESSOR/MUTATOR METHODS
		//--------------------------------------
		/**
		 * Should this CoreDisplayObject be automatically destroyed when removed from the stage .
		 * When value is manually set, it will cascade to children
		 * @return 
		 * 
		 */
		public function get autoDestroy () : Boolean
		{
			return _autoDestroy;
		}
		
		public function set autoDestroy ( p_autoDestroy : Boolean ) : void
		{
			_autoDestroy = p_autoDestroy;
			
			var childCount : int = this.numChildren;
			for (var i : int = 0; i < childCount; i++){
				var child : DisplayObject = this.getChildAt(i);
				if(child is CoreDisplayObject)CoreDisplayObject(child).autoDestroy = _autoDestroy;
			}
		}
		
		/**
		 * Was this CoreDisplayObject destroyed 
		 * @return 
		 * 
		 */
		public function get isDestroyed () : Boolean
		{
			return _isDestroyed;
		}
		
		/**
		 * Has this CoreDisplayObject been removed from the stage 
		 * @return 
		 * 
		 */		
		public function get isRemoved () : Boolean
		{
			return _isRemoved;
		}
		
		/**
		 * Abstract data object
		 * @return 
		 * 
		 */
		public function get data () : *
		{
			return _data;
		}
		
		public function set data ( p_data : * ) : void
		{
			_data = p_data;
			processData();
			draw();
		}
		
		//--------------------------------------
		//  PROTECTED METHODS
		//--------------------------------------
		/**
		 * Use to set global defaults. This can be used by abstract classes.
		 * For subclasses, use setDefaults
		 * 
		 */		
		protected function setGlobalDefaults () : void
		{
			//Override	
		}
		
		/**
		 * Use to add global listeners. This can be used by abstract classes.
		 * For subclasses, use addListeners
		 * 
		 */		
		protected function addGlobalListeners () : void
		{
			//Override	
		}
		
		/**
		 * Use to remove global listeners. This can be used by abstract classes 
		 * 
		 */
		protected function removeGlobalListeners () : void
		{
			//Override
		}
		
		/**
		 * Use to add stage global listeners. This can be used by abstract classes.
		 * For subclasses, use addListeners
		 * 
		 */		
		protected function addGlobalStageListeners () : void
		{
			//Override	
		}
		
		/**
		 * Use to remove global stage listeners. This can be used by abstract classes 
		 * 
		 */
		protected function removeGlobalStageListeners () : void
		{
			//Override
		}
		
		/**
		 * Set defaults in concrete class 
		 * 
		 */
		protected function setDefaults () : void
		{
			//Override	
		}
		
		/**
		 * Add listeners in concrete class 
		 * 
		 */
		protected function addListeners () : void
		{
			//Override
		}
		
		/**
		 * Remove listeners in concrete class 
		 * 
		 */
		protected function removeListeners () : void
		{
			//Override
		}
		
		/**
		 * Add stage listeners in concrete class 
		 * 
		 */
		protected function addStageListeners () : void
		{
			//Override
		}
		
		/**
		 * Remove stage listeners in concrete class 
		 * 
		 */
		protected function removeStageListeners () : void
		{
			//Override
		}
		
		/**
		 * Gets called after init 
		 * 
		 */		
		protected function postInit () : void
		{
			//Override
		}
		
		/**
		 * Gets called once the display object is on stage 
		 * 
		 */		
		protected function postAddedToStage () : void
		{
			//Override
		}
		
		/**
		 * Process the newly set data if needed. 
		 * 
		 */		
		protected function processData () : void
		{
			//Override
		}
		
		/**
		 * Draw in concrete class 
		 * 
		 */
		protected function draw () : void
		{
			//Override
		}
		
		//--------------------------------------
		//  PRIVATE METHODS
		//--------------------------------------
		private function init () : void
		{
			addInternalListeners();
			setGlobalDefaults();
			addGlobalListeners();
			setDefaults();
			addListeners();
			postInit();
		}
		
		private function addInternalListeners () : void
		{
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler, false, 0, true);
			addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler, false, 0, true);
		}
		
		private function removeInternalListeners () : void
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
		}
		
		//--------------------------------------
		//  HANDLER METHODS
		//--------------------------------------
		private function addedToStageHandler ( e : Event ) : void
		{
			//Remove added to stage listener. Protects against recalling addStageListeners and addGlobalStageListeners
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			
			postAddedToStage();
			addGlobalStageListeners();
			addStageListeners();
		}
		
		private function removedFromStageHandler ( e : Event ) : void
		{
			if(autoDestroy){
				_isRemoved = true;
				destroy();
			}
		}
		
	}
}