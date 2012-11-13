package bangfe.metrics.trackers.google
{
	import bangfe.metrics.trackers.IMetricsTracker;

	public interface IGoogleTracker extends IMetricsTracker
	{
		function trackPage ( p_page : String ) : void;
		function trackEvent ( p_category : String, p_action : String, p_label : String = null, p_value : Number = NaN ) : void;
	}
}