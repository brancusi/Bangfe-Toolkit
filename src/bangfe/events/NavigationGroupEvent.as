package bangfe.events
{
	import bangfe.ui.NavigationItem;
	
	import flash.events.Event;
	
	public class NavigationGroupEvent extends Event
	{
		
		//--------------------------------------
		//  PUBLIC STATIC CONSTANTS
		//--------------------------------------
		public static const SELECTED_ITEM_CHANGED : String = "selectedItemChanged";
		
		//--------------------------------------
		//  PUBLIC VARIABLES
		//--------------------------------------
		/**
		 * The navigation item that was selected 
		 */		
		public var navigationItem : NavigationItem;
		
		//--------------------------------------
		//  PUBLIC METHODS
		//--------------------------------------
		/**
		 * Constructor 
		 * @param type
		 * @param bubbles
		 * @param cancelable
		 * 
		 */
		public function NavigationGroupEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}