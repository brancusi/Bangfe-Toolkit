package bangfe.core
{
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	/**
	 * A core level display object. Handles basic cleanup, data, draw, defaulting mechanisms.
	 * This can be used as the base class for any <code>DisplayObject</code> including document classes 
	 * @author Will Zadikian
	 * 
	 */
	public class CoreMovieClipObject extends MovieClip implements ICoreObject
	{
		//--------------------------------------
		//  PRIVATE VARIABLES
		//--------------------------------------
		private var _isDestroyed : Boolean = false;
		private var _data : *;
		
		//--------------------------------------
		//  PUBLIC METHODS
		//--------------------------------------
		/**
		 * Constructor 
		 * 
		 */
		public function CoreMovieClipObject() : void
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
			removeListeners();
			
			if(parent != null)parent.removeChild(this);
		}
		
		//--------------------------------------
		//  ACCESSOR/MUTATOR METHODS
		//--------------------------------------		
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
		 * Set defaults in concrete class 
		 * 
		 */
		protected function setDefaults () : void
		{
			//Override	
		}
		
		/**
		 * Map signals. This can be used to map native events to signals 
		 * 
		 */		
		protected function mapSignals () : void
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
		 * Gets called after init. This can be used by abstract classes
		 * 
		 */		
		protected function postInitGlobal () : void
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
		 * Gets called once the display object is removed from stage 
		 * 
		 */		
		protected function postRemovedFromStage () : void
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
			mapSignals();
			addListeners();
			postInitGlobal();
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
			postAddedToStage();
		}
		
		private function removedFromStageHandler ( e : Event ) : void
		{
			postRemovedFromStage();
		}
		
	}
}