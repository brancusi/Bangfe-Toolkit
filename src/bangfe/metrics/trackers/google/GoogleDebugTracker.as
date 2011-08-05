package bangfe.metrics.trackers.google
{
	
	/**
	 * This is used to print back all tracking information. If the <code>MetricsManager</code>
	 * has not been set with a concrete <code>IGoogleTracker</code>, this debugger will be
	 * delivered instead.
	 *  
	 * @author Will Zadikian
	 * 
	 */
	public class GoogleDebugTracker implements IGoogleTracker
	{
		
		//--------------------------------------
		//  PUBLIC STATIC CONSTANTS
		//--------------------------------------
		public static const GOOGLE_DEBUG_TRACKER : String = "Google Debug Tracker :: ";
		
		//--------------------------------------
		//  PRIVATE VARIABLES
		//--------------------------------------
		private var _debugMode : Boolean = false;
		
		//--------------------------------------
		//  PUBLIC METHODS
		//--------------------------------------
		/**
		 * Constructor
		 * 
		 */
		public function GoogleDebugTracker() : void
		{
		}
		
		/**
		 * @inheritDoc
		 */
		public function trackPage ( p_page : String ) : void
		{
			if(!debugMode)return;
			trace(GOOGLE_DEBUG_TRACKER + "TRACK PAGE");
			trace("page : " + p_page);
		}
		
		/**
		 * @inheritDoc
		 */	
		public function trackEvent ( p_category : String, p_action : String, p_label : String = null, p_value : Number = NaN ) : void
		{
			if(!debugMode)return;
			trace(GOOGLE_DEBUG_TRACKER + "TRACK LINK");
			trace("Category : " + p_category);
			trace("Action : " + p_action);
			trace("Label : " + p_label);
			trace("Value : " + p_value);
		}
		
		//--------------------------------------
		//  ACCESSOR/MUTATOR METHODS
		//--------------------------------------
		
		/**
		 * @inheritDoc
		 */
		public function get debugMode () : Boolean
		{
			return _debugMode;
		}
		
		public function set debugMode ( p_debugMode : Boolean ) : void
		{
			_debugMode = p_debugMode;
		}
		
	}
}