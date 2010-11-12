package bangfe.core
{
	public interface ITransitionable
	{
		
		/**
		 * The transition in method. 
		 * Very important that you call the transitionInComplete method
		 * or dispatch <code>TransitionableEvent</code> TRANSITION_IN_COMPLETE
		 *
		 */		
		function transitionIn () : void;
		
		/**
		 * The transition out method.
		 * Very important that you call the transitionOutComplete method
		 * or dispatch <code>TransitionableEvent</code> TRANSITION_OUT_COMPLETE
		 * 
		 */		
		function transitionOut () : void;
		
		/**
		 * Very important that you dispatch the proper transition in complete event.
		 * <code>TransitionableEvent</code> TRANSITION_IN_COMPLETE
		 * 
		 * @see TransitionableEvent
		 * 
		 * 
		 */		
		function transitionInComplete () : void;
		
		/**
		 * Very important that you dispatch the proper transition out complete event 
		 * <code>TransitionableEvent</code> TRANSITION_OUT_COMPLETE
		 * 
		 * @see TransitionableEvent 
		 */		
		function transitionOutComplete () : void;
	}
}