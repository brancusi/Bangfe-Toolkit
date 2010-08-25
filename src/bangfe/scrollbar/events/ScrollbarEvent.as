package bangfe.scrollbar.events
{
	import flash.events.Event;
	
	/**
	 * NSVolumeControlEvent
	 * @author Will Zadikian
	 * 
	 */	
	public class ScrollbarEvent extends Event
	{
		
		public static const VALUE_CHANGE : String = "valueChange";
		
		private var _value : Number;
		
		public function ScrollbarEvent ( type : String, p_value : Number )
		{
			super(type);
			_value = p_value;
		}
		
		override public function clone():Event {
			return new ScrollbarEvent (type, _value);
		};
		
		/**
		 * Percentage of the slider bar 
		 * @param p_value
		 * 
		 */		
		public function set value ( p_value : Number ) : void
		{
			_value = p_value;
		}
		
		public function get value () : Number
		{
			return _value;
		}

	}
}