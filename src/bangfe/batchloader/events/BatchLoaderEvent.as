package bangfe.batchloader.events
{
	import flash.events.Event;

	public class BatchLoaderEvent extends Event
	{
		
		public static const COLLECTION_PROGRESS : String = "collectionProgress";
		public static const COLLECTION_COMPLETE : String = "collectionComplete";
		
		public function BatchLoaderEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}