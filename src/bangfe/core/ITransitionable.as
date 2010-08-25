package bangfe.core
{
	public interface ITransitionable
	{
		
		/**
		 * The transition in method 
		 *
		 */		
		function transitionIn () : void;
		
		/**
		 * The transition out method 
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