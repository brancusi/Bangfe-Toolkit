package bangfe.batchloader.events
{
	import flash.events.Event;

	public class LoaderItemEvent extends Event
	{
		public static const OPENED : String = "loaderItemOpened";
		public static const CLOSED : String = "loaderItemClosed";
		public static const COMPLETED : String = "loaderItemCompleted";
		public static const FAILED : String = "loaderItemFailed";
		
		public function LoaderItemEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}