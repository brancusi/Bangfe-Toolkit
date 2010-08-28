package bangfe.display.container
{
	import bangfe.core.ICoreObject;
	import bangfe.core.ITransitionable;
	import bangfe.events.TransitionableEvent;
	
	import com.greensock.TweenMax;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import org.osflash.signals.Signal;
	
	public class TransitionItemManager implements ICoreObject, ITransitionable
	{
		
		//--------------------------------------
		//  PUBLIC STATIC CONSTANTS
		//--------------------------------------
		/**
		 * Error message dispatched when there is no DisplayObject associated with the <code>TransitionItemManager</code>  
		 */		
		public static const MISSING_ITEM_ERROR_MESSAGE : String = "There is no item associated with this TransitionItemManager. Make sure to add this before acting on the manager";
		
		public static const TRANSITIONING_IN_STATE : String = "transitioningInState";
		public static const TRANSITIONING_OUT_STATE : String = "transitioningOutState";
		public static const ON_STATE : String = "onState";
		public static const OFF_STATE : String = "offState";
		
		//--------------------------------------
		//  SIGNALS
		//--------------------------------------
		/**
		 * Signal sent when the managed <code>ITransitionable</code> instance has complete
		 * its transitionIn
		 */		
		public var transitionInCompleted : Signal = new Signal(TransitionItemManager);
		
		/**
		 * Signal sent when the managed <code>ITransitionable</code> instance has complete
		 * its transitionOut
		 */		
		public var transitionOutCompleted : Signal = new Signal(TransitionItemManager);
		
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
		
		private var _currentState : String;
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
			
			_currentState = TRANSITIONING_IN_STATE;
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
			
			_currentState = TRANSITIONING_OUT_STATE;
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
			
			transitionInCompleted.dispatch(this);
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
			
			transitionOutCompleted.dispatch(this);
			
			destroy();
		}
		
		/**
		 * Destroy the manager and the item 
		 * 
		 */
		public function destroy () : void
		{
			if(_isDestroyed)return;
			
			//Cleanup signals
			transitionOutCompleted.removeAll();
			transitionInCompleted.removeAll();
			
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
		
		/**
		 * The current state of the <code>TransitionItemManager</code> 
		 * 
		 */		
		public function get currentState () : String
		{
			return _currentState;
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
			_currentState = ON_STATE;
			transitionInComplete();
		}
		
		private function transitionOutCompleteHandler ( e : TransitionableEvent ) : void
		{
			_currentState = OFF_STATE;
			transitionOutComplete();
		}
		
	}
}