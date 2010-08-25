package bangfe.batchloader.loaders
{
	import bangfe.batchloader.core.ILoaderItem;
	
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	/**
	 * Data loader item, used to load any non binary data 
	 * @author Will Zadikian
	 * 
	 */	
	public class DataLoaderItem extends AbstractLoaderItem implements ILoaderItem
	{
		
		protected var _loader : URLLoader;
		
		public function DataLoaderItem(p_url:String=null, p_props:Object=null)
		{
			super(p_url, p_props);
		}
		
		//--------------------------------------
		//  PROTECTED METHODS
		//--------------------------------------
		
		override protected function createLoader () : void
		{
			_loader = new URLLoader();
			_loader.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			_loader.addEventListener(Event.COMPLETE, completeHandler);
			_loader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			_loader.addEventListener(Event.OPEN, openHandler);
			_loader.addEventListener(Event.DEACTIVATE, deactiveHandler);
			_loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusEvent);			
		}	
		
		override protected function startLoaderLoad () : void
		{
			if(!url)return;
			_loader.load(new URLRequest(url));
		}
		
		override protected function stopLoaderLoad () : void
		{
			try{
				_loader.close();
			}catch(e:Error){}
		}
		
		override protected function processContent () : void
		{
			content = _loader.data;	
		}
		
		//--------------------------------------
		//  HANDLER METHODS
		//--------------------------------------


	}
}