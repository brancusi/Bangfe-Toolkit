package bangfe.navigation
{
	import org.osflash.signals.Signal;

	public interface INavigationItem
	{
		
		//--------------------------------------
		//  PUBLIC METHODS
		//--------------------------------------
		/**
		 * Set to selected state 
		 * @param p_dispatchChange Should this selection redispatch the 
		 * selectedSignal
		 * 
		 */		
		function setSelected ( p_dispatchChange : Boolean = true ) : void;
		
		/**
		 * Set to deselected state 
		 * 
		 */		
		function setDeSelected () : void;
		
		//--------------------------------------
		//  ACCESSOR/MUTATOR METHODS
		//--------------------------------------
		/**
		 * Signal - Dispatched when the navigation item requests to be selected.
		 * Depending on the type of navigation item, this can occur on click
		 * or on hover etc.
		 *   
		 * @return 
		 * 
		 */		
		function get selectRequesteSignal () : Signal;
		
		/**
		 * The UID of the navigation item 
		 * @return 
		 * 
		 */		
		function get uid () : String;
		function set uid ( p_uid : String ) : void;
		
		/**
		 * The navigation group that handles this navigation item  
		 * @return 
		 * 
		 */
		function get navigationGroup () : NavigationGroup;
		function set navigationGroup ( p_navigationGroup : NavigationGroup ) : void;
		
	}
}