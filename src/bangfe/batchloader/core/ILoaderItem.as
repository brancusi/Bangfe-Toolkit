package bangfe.batchloader.core
{
	import flash.events.IEventDispatcher;

	public interface ILoaderItem extends IEventDispatcher
	{
		function resume () : void;
		function pause () : void;
		function load () : void;
		
		function get uid () : String ;
		function set uid ( p_uid : String ) : void;
		function get url () : String;
		function set url ( p_url : String ) : void;
		function get isCompleted () : Boolean;
		function set isCompleted ( p_isComplete : Boolean ) : void;
		function get isPaused () : Boolean;
		function set isPaused ( p_isPaused : Boolean ) : void;
		function get content () : *;
		function set content ( p_content : * ) : void;
		function get isFailed () : Boolean;
		function set isFailed ( p_isFailed : Boolean ) : void;
		function get isLoading () : Boolean;
		function set isLoading ( p_isLoading : Boolean ) : void;
		
	}
}