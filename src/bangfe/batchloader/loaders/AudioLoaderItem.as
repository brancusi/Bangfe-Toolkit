package bangfe.batchloader.loaders
{
	import bangfe.batchloader.core.ILoaderItem;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.media.Sound;
	import flash.net.URLRequest;
	
	/**
	 * Audio LoaderItem. Used to load any audio file 
	 * @author Will Zadikian
	 * 
	 */	
	public class AudioLoaderItem extends AbstractLoaderItem implements ILoaderItem
	{
		
		protected var _sound : Sound;
		
		public function AudioLoaderItem(p_url:String=null, p_props:Object=null)
		{
			super(p_url, p_props);
		}
		
		//--------------------------------------
		//  PROTECTED METHODS
		//--------------------------------------
		
		override protected function createLoader () : void
		{
			_sound = new Sound();
			
			_sound.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			_sound.addEventListener(Event.COMPLETE, completeHandler);
			_sound.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			_sound.addEventListener(Event.OPEN, openHandler);
		}	
		
		override protected function startLoaderLoad () : void
		{
			if(!url)return;
			_sound.load(new URLRequest(url));
		}
		
		override protected function stopLoaderLoad () : void
		{
			try{
				_sound.close();
			}catch(e:Error){}
		}
		
		override protected function processContent () : void
		{
			content = _sound;	
		}
		
		//--------------------------------------
		//  HANDLER METHODS
		//--------------------------------------
		
		
	}
}