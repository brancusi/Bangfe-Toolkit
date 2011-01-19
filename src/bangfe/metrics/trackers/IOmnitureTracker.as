package bangfe.metrics.trackers
{
	
	/**
	 * Interface for any omniture related tracker
	 * 
	 * @author Will Zadikian
	 */	
	public interface IOmnitureTracker extends IMetricsTracker
	{
		
		//--------------------------------------
		//  PUBLIC METHODS
		//--------------------------------------
		/**
		 * Track a page view
		 * 
		 * @example Example shows how to track a page view
		 * 
		 * <listing version="1.0">
		 * 
		 * 		MetricsManager.omniture.trackPage("home_flash", "home");
		 * 
		 * </listing>
		 * 
		 * @param siteSection
		 * @param pageName
		 * 
		 */
		function trackPage ( p_pageName : String ) : void;
		
		/**
		 * Track a link. This should be used for custom events, downloads, and outbound links
		 * 
		 * @example Example shows how to track a link
		 * 
		 * <listing version="1.0">
		 * 
		 * 		MetricsManager.omniture.trackLink("http://google.com", "Some Link Name", "e");
		 * 
		 * </listing>
		 * 
		 * @param linkName The name that will appear in the link report
		 * @param pageURL The URL that identifies the link clicked. If no URL is specified the linkName is used
		 * @param linkType A letter identfying which link report the URL or name will be displayed in. "o" (Custom Links), "d" (File Downloads), and "e" (Exit Links)
		 * 
		 */	
		function trackLink ( p_linkName : String, p_pageURL:String = "", p_linkType : String = "o" ) : void;
		
		/**
		 * Track using low level track call
		 * 
		 * @example Example shows how to use the low level tracking.
		 * 
		 * <listing version="1.0">
		 * 
		 * //Track an event and a var
		 * omniture.track({key:'events', value:'event8'}, {key:'eVar4', value:'filename.flv'});
		 * 
		 * </listing>
		 * 
		 * @param args Objects passed in to be used for tracking.
		 * 
		 */		
		function track ( ...args ) : void;
		
		//--------------------------------------
		//  ACCESSOR/MUTATOR METHODS
		//--------------------------------------
		
		
	}
}