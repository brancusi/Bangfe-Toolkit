package bangfe.events
{
	import flash.events.Event;
	
	public class TransitionableEvent extends Event
	{
		
		public static const TRANSITION_IN_COMPLETE : String = "transitionInComplete";
		public static const TRANSITION_OUT_COMPLETE : String = "transitionOutComplete";
		
		public function TransitionableEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}