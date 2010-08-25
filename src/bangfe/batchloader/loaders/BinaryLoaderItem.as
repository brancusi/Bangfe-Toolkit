package bangfe.batchloader.loaders
{
	import bangfe.batchloader.core.ILoaderItem;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	
	/**
	 * Binary LoaderItem. Used to load any binary data 
	 * @author Will Zadikian
	 * 
	 */	
	public class BinaryLoaderItem extends AbstractLoaderItem implements ILoaderItem
	{
		
		protected var _loader : Loader;
		
		public function BinaryLoaderItem(p_url:String=null, p_props:Object=null)
		{
			super(p_url, p_props);
		}
		
		//--------------------------------------
		//  PROTECTED METHODS
		//--------------------------------------
		
		override protected function createLoader () : void
		{
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			_loader.contentLoaderInfo.addEventListener(Event.OPEN, openHandler);
			_loader.contentLoaderInfo.addEventListener(Event.DEACTIVATE, deactiveHandler);
			_loader.contentLoaderInfo.addEventListener(Event.UNLOAD, unLoadHandler);
			_loader.contentLoaderInfo.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusEvent);
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
			content = _loader.content;	
		}
		
		//--------------------------------------
		//  HANDLER METHODS
		//--------------------------------------


	}
}