package bangfe.events
{
	import flash.events.Event;
	
	public class TransitionItemManagerEvent extends Event
	{
		
		public static const TRANSITION_IN_COMPLETE : String = "itemTransitionInComplete";
		public static const TRANSITION_OUT_COMPLETE : String = "itemTransitionOutComplete";
		
		public function TransitionItemManagerEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}