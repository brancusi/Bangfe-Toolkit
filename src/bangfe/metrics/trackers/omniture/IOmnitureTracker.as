package bangfe.metrics.trackers.omniture
{
	import bangfe.metrics.trackers.IMetricsTracker;
	
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
		 * @example Example shows how to use the track method
		 * 
		 * <listing version="1.0">
		 * 
		 * //Track an event and a var
		 * var report : OmnitureReport = new OmnitureReport(OmnitureReport.EVENT);
		 * report.addEvent("event23");
		 * report.addEvent("purchase");
		 * 
		 * MetricsManager.omniture.track(report);
		 * 
		 * </listing>
		 *  
		 * @param p_report The OmnitureReport object containing the call information
		 * 
		 */			
		function track ( p_report : OmnitureReport, p_clearOldValues : Boolean = true ) : void;
		
		//--------------------------------------
		//  ACCESSOR/MUTATOR METHODS
		//--------------------------------------
		
		
	}
}