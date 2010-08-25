package
{
	import bangfe.batchloader.BatchLoader;
	import bangfe.batchloader.events.BatchLoaderEvent;
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	
	/**
	 * BatchLoader test doc 
	 * @author Will Zadikian
	 * 
	 */	
	public class Test extends MovieClip
	{
		protected var _batchLoader : BatchLoader;
		
		public var pauseButton : SimpleButton;
		public var resumeButton : SimpleButton;
		
		public function Test()
		{
			init();
		}
		
		protected function init () : void
		{
			setDefaults();
			addListeners();
			batchItems();
		}
		
		protected function addListeners () : void
		{
			pauseButton.addEventListener(MouseEvent.CLICK, pauseHandler);
			resumeButton.addEventListener(MouseEvent.CLICK, resumeHandler);
			
			_batchLoader.addEventListener(BatchLoaderEvent.COLLECTION_PROGRESS, progressHandler);
			_batchLoader.addEventListener(BatchLoaderEvent.COLLECTION_COMPLETE, completeHandler);
		}
		
		protected function setDefaults () : void
		{
			_batchLoader = new BatchLoader();
			//_batchLoader.autoLoad = true;
			_batchLoader.maxConnections = 4;
			
			//_batchLoader.pause();
		}
		
		protected function batchItems () : void
		{
			
			//Add single item to queue
			//_batchLoader.addItem("images/001.jpg");
			
			//Inject content when it becomes ready
			//Overwrite prop set to true will overwrite any injection requests with the matching handler method. Note
			//this is on by default, just shown here for demonstration
			_batchLoader.injectContent("images/001.jpg", showContent, {overwrite:true, onReadyParams:["Test Arg1", "Test Arg2"]});
			
			//Add collection to queue
			_batchLoader.addCollection(["images/002.jpg", "images/003.jpg"]);
		}
		
		//This will close open connections and auto pause any newly added items
		protected function pauseHandler ( e : MouseEvent ) : void
		{
			_batchLoader.pause();
		}
		
		//Will restart any remaining queued items		
		protected function resumeHandler ( e : MouseEvent ) : void
		{
			batchItems();
			_batchLoader.resume();
		}
		
		//Fires each time a new item is ready for cosumption
		protected function progressHandler ( e : BatchLoaderEvent ) : void
		{
			trace("BatchLoader : Progress");
		}
		
		//Dispatched when all items in queue are finished
		protected function completeHandler ( e : BatchLoaderEvent ) : void
		{
			if(_batchLoader.hasItem("images/002.jpg")){
				var image : Bitmap = _batchLoader.getContent("images/002.jpg") as Bitmap;
				image.x = Math.random() * 20;
				addChild(image);
			}
		}
		
		//Sample injection handler
		protected function showContent ( p_content : Bitmap, p_arg1 : String, p_arg2 : String ) : void
		{
			p_content.x = Math.random() * 20;
			addChild(p_content);
			trace(p_arg1 + " : " + p_arg2);
		}
			

	}
}