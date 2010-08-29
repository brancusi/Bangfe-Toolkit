package bangfe.metrics.trackers
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
		public function OmnitureDebugTracker()
		{
		}
		
		/**
		 * @inheritDoc
		 */
		public function trackPage ( p_pageName : String ) : void
		{
			if(!debugMode)return;
			trace(OMNITURE_DEBUG_TRACKER + "TRACK PAGE");
			trace("pageName : " + p_pageName);
		}
		
		/**
		 * @inheritDoc
		 */	
		public function trackLink ( p_linkName : String, p_pageURL:String = "", p_linkType : String = "o" ) : void
		{
			if(!debugMode)return;
			trace(OMNITURE_DEBUG_TRACKER + "TRACK LINK");
			trace("linkName : " + p_linkName);
			trace("pageURL : " + p_pageURL);
			trace("linkType : " + p_linkType);
		}
		
		/**
		 * @inheritDoc
		 */
		public function track ( ...args ) : void
		{
			for(var i : int = 0; i < args.length; i++ ){
				var item : Object = args[i] as Object;
				trace(item.key, item.value);		
			}
			
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