package bangfe.display.container
{
	import bangfe.core.ICoreObject;
	import bangfe.core.ITransitionable;
	import bangfe.events.TransitionItemManagerEvent;
	import bangfe.events.TransitionableEvent;
	
	import com.greensock.TweenMax;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.EventDispatcher;

	/**
	 * Dispatched when this TransitionItemManager's item has completed it's intro
	 *
	 * @eventType bangfe.events.TransitionItemManagerEvent.TRANSITION_IN_COMPLETE
	 */			
	[Event(name="itemTransitionInComplete", type="bangfe.events.TransitionItemManagerEvent")]
	
	/**
	 * Dispatched when this TransitionItemManager's item has completed it's outro
	 *
	 * @eventType bangfe.events.TransitionItemManagerEvent.TRANSITION_OUT_COMPLETE
	 */			
	[Event(name="itemTransitionOutComplete", type="bangfe.events.TransitionItemManagerEvent")]
	
	public class TransitionItemManager extends EventDispatcher implements ICoreObject, ITransitionable
	{
		
		public static const MISSING_ITEM_ERROR_MESSAGE : String = "There is no item associated with this TransitionItemManager. Make sure to add this before acting on the manager";
		
		//--------------------------------------
		//  PRIVATE VARIABLES
		//--------------------------------------
		private var _item : DisplayObject;
		
		private var _isTransitioning : Boolean = false;
		private var _hasStartedIntro : Boolean = false;
		private var _hasCompletedIntro : Boolean = false;
		private var _hasStartedOutro : Boolean = false;
		private var _hasCompletedOutro : Boolean = false;
		private var _isDestroyed : Boolean = false;
		
		private var _scope : DisplayObjectContainer;
		//--------------------------------------
		//  PUBLIC METHODS
		//--------------------------------------
		/**
		 * Constructor 
		 * 
		 */
		public function TransitionItemManager( p_scope : DisplayObjectContainer )
		{
			_scope = p_scope;
		}
		
		/**
		 * Transition the item in 
		 * 
		 */
		public function transitionIn () : void
		{
			if(!item)throw new Error(MISSING_ITEM_ERROR_MESSAGE);
			
			_isTransitioning = true;
			
			if(_hasStartedIntro)return;
			
			_hasStartedIntro = true;
			
			_scope.addChild(item);
			
			if(item is ITransitionable){
				ITransitionable(item).transitionIn();
			}else{
				TweenMax.to(item, .5, {autoAlpha:1, onComplete:transitionInComplete});	
			}
		}
		
		/**
		 * Transition the item out 
		 * 
		 */
		public function transitionOut () : void
		{
			if(!item)throw new Error(MISSING_ITEM_ERROR_MESSAGE);
			
			_isTransitioning = true;
			
			if(_hasStartedOutro)return;
			
			_hasStartedOutro = true;
			if(item is ITransitionable){
				ITransitionable(item).transitionOut();
			}else{
				TweenMax.to(item, .5, {autoAlpha:0, onComplete:transitionOutComplete});
			}
		}
		
		/**
		 * Notify transition has completed 
		 * 
		 */
		public function transitionInComplete () : void
		{
			if(!item)throw new Error(MISSING_ITEM_ERROR_MESSAGE);
			
			_isTransitioning = false;
			_hasCompletedIntro = true;
			dispatchEvent(new TransitionItemManagerEvent(TransitionItemManagerEvent.TRANSITION_IN_COMPLETE));
		}
		
		/**
		 * Notify transition out has completed 
		 * 
		 */
		public function transitionOutComplete () : void
		{
			if(!item)throw new Error(MISSING_ITEM_ERROR_MESSAGE);
			
			_isTransitioning = false;
			_hasCompletedOutro = true;
			dispatchEvent(new TransitionItemManagerEvent(TransitionItemManagerEvent.TRANSITION_OUT_COMPLETE));
			destroy();
		}
		
		/**
		 * Destroy the manager and the item 
		 * 
		 */
		public function destroy () : void
		{
			if(_isDestroyed)return;
			
			destroyItem();			
			_isDestroyed = true;
		}
		
		//--------------------------------------
		//  PROTECTED METHODS
		//--------------------------------------
		/**
		 * The item to be managed 
		 * @return 
		 * 
		 */
		public function get item () : DisplayObject
		{
			return _item;
		}

		public function set item ( p_item : DisplayObject ) : void
		{
			destroyItem();
			_item = p_item;
			setItemDefaults();
			addItemListeners();
		}
		
		/**
		 * Is this manager's item currently transitioning 
		 * @return 
		 * 
		 */
		public function get isTransitioning () : Boolean
		{
			return _isTransitioning;
		}
		
		/**
		 * Has this manager's item intro transition started 
		 * @return 
		 * 
		 */
		public function get hasStartedIntro () : Boolean
		{
			return _hasStartedIntro;
		}
			
		/**
		 * Has this manager's item intro transition completed 
		 * @return 
		 * 
		 */		
		public function get hasCompletedIntro () : Boolean
		{
			return _hasCompletedIntro;
		}
		
		/**
		 * Has this manager's item outro transition started 
		 * @return 
		 * 
		 */
		public function get hasStartedOutro () : Boolean
		{
			return _hasStartedOutro;
		}

		/**
		 * Has this manager's item outro transition completed 
		 * @return 
		 * 
		 */
		public function get hasCompletedOutro () : Boolean
		{
			return _hasCompletedOutro;
		}
		
		/**
		 * Has this manager been destroyed 
		 * @return 
		 * 
		 */
		public function get isDestroyed () : Boolean
		{
			return _isDestroyed;
		}

		//--------------------------------------
		//  PROTECTED METHODS
		//--------------------------------------
		private function setItemDefaults () : void
		{
			if(!(item is ITransitionable)){
				item.alpha = 0;
			}
		}
		
		private function addItemListeners () : void
		{
			item.addEventListener(TransitionableEvent.TRANSITION_IN_COMPLETE, transitionInCompleteHandler, false, 0, true);
			item.addEventListener(TransitionableEvent.TRANSITION_OUT_COMPLETE, transitionOutCompleteHandler, false, 0, true);
		}
		
		private function removeItemListeners () : void
		{
			try{
				item.removeEventListener(TransitionableEvent.TRANSITION_IN_COMPLETE, transitionInCompleteHandler);
				item.removeEventListener(TransitionableEvent.TRANSITION_OUT_COMPLETE, transitionOutCompleteHandler);
			}catch(e:Error){}
		}
		
		private function destroyItem () : void
		{
			removeItemListeners();
			
			if(item is ICoreObject){
				ICoreObject(item).destroy();
			}else{
				try{
					_scope.removeChild(item);
				}catch(e:Error){}	
			}
		}
		
		//--------------------------------------
		//  PROTECTED METHODS
		//--------------------------------------
		private function transitionInCompleteHandler ( e : TransitionableEvent ) : void
		{
			transitionInComplete();
		}
		
		private function transitionOutCompleteHandler ( e : TransitionableEvent ) : void
		{
			transitionOutComplete();
		}
		
	}
}