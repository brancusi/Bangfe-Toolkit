package bangfe.events
{
	import flash.events.Event;
	
	/**
	 * BasicButtonEvent. This event bubbles by default. 
	 * @author Will Zadikian
	 * 
	 */
	public class BasicButtonEvent extends Event
	{
		
		//--------------------------------------
		//  PUBLIC STATIC CONSTANTS
		//--------------------------------------
		/**
		 * Dispatched when a <code>BasicButton</code> is selected 
		 */
		public static const BUTTON_SELECTED : String = "buttonSelected";
		
		/**
		 * Dispatched when a <code>BasicButton</code> is hovered
		 */
		public static const BUTTON_HOVERED : String = "buttonHovered";
		
		//--------------------------------------
		//  PUBLIC VARIABLES
		//--------------------------------------
		public var uid : String;
		public var data : *;
		public var index : int;
		public var label : String;
		
		//--------------------------------------
		//  PUBLIC METHODS
		//--------------------------------------
		public function BasicButtonEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}