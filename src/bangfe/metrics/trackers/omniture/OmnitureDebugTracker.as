package bangfe.metrics.trackers.omniture
{
	
	/**
	 * This is used to print back all tracking information. If the <code>MetricsManager</code>
	 * has not been set with a concrete <code>IOmnitureTracker</code>, this debugger will be
	 * delivered instead.
	 *  
	 * @author Will Zadikian
	 * 
	 */
	public class OmnitureDebugTracker implements IOmnitureTracker
	{
		
		//--------------------------------------
		//  PUBLIC STATIC CONSTANTS
		//--------------------------------------
		public static const OMNITURE_DEBUG_TRACKER : String = "Omniture Debug Tracker :: ";
		
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
		public function OmnitureDebugTracker() : void {}
		
		/**
		 * @inheritDoc
		 */
		public function track ( p_report : OmnitureReport, p_clearOldValues : Boolean = true ) : void
		{
			trace(p_report.toString());
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