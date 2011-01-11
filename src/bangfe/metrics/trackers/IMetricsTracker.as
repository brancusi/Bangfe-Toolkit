package bangfe.metrics.trackers
{
	public interface IMetricsTracker
	{
		/**
		 * Should track in debug mode. Will trace back information 
		 * @return 
		 * 
		 */
		function get debugMode () : Boolean;
		function set debugMode ( p_debugMode : Boolean ) : void;
	}
}