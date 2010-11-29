package
{

	import bangfe.core.CoreDisplayObject;
	import bangfe.display.AutoImage;
	import bangfe.display.container.TransitionContainer;
	
	import com.greensock.layout.ScaleMode;
	
	import flash.display.DisplayObject;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class AutoImageTest extends CoreDisplayObject
	{
		
		
		private var _autoImage : AutoImage;
		
		//--------------------------------------
		//  PUBLIC METHODS
		//--------------------------------------	
		/**
		 * Constructor 
		 * 
		 */
		public function AutoImageTest()
		{
			super();
		}
		
		//--------------------------------------
		//  PROTECTED METHODS
		//--------------------------------------	
		override protected function setDefaults():void
		{
			_autoImage = new AutoImage(131, 100, AutoImage.FILL);
			
			addChild(_autoImage);
			//_autoImage.url = "large.jpg"
			_autoImage.url = "sample.jpg"
		}
		
		override protected function addListeners():void
		{
		
		}
		
		//--------------------------------------
		//  HANDLER METHODS
		//--------------------------------------	
				
	}
}