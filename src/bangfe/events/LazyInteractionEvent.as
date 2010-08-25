package bangfe.events
{
	import flash.events.Event;
	
	import system.data.collections.ArrayCollection;
	
	public class LazyInteractionEvent extends Event
	{
		
		public static const INTERACTION_IDLED : String = "interactionIdled";
		
		public var safeChildrenCollection : ArrayCollection;
		
		public function LazyInteractionEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}