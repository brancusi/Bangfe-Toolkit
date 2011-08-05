package
{

	import bangfe.core.CoreDisplayObject;
	import bangfe.display.AutoImage;
	import bangfe.display.container.TransitionContainer;
	import bangfe.sound.SoundPipeManager;
	
	import com.greensock.events.LoaderEvent;
	import com.greensock.layout.ScaleMode;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.MP3Loader;
	import com.greensock.loading.XMLLoader;
	
	import flash.display.DisplayObject;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class SoundTest extends CoreDisplayObject
	{
		
		//--------------------------------------
		//  STAGE INSTANCES
		//--------------------------------------	
		public var testButton1 : SimpleButton;
		public var testButton2 : SimpleButton;
		public var testButton3 : SimpleButton;
		public var testButton4 : SimpleButton;
		public var testButton5 : SimpleButton;
		
		public var resumeButton : SimpleButton;
		public var pauseButton : SimpleButton;
		
		//--------------------------------------
		//  PRIVATE VARIABLES
		//--------------------------------------	
		private var _soundPipeManager : SoundPipeManager = new SoundPipeManager();
		
		//--------------------------------------
		//  PROTECTED METHODS
		//--------------------------------------	
		override protected function setDefaults():void
		{
			testButton1.enabled = false;
			testButton1.alpha = .5;
			
			testButton2.enabled = false;
			testButton2.alpha = .5;
			
			testButton3.enabled = false;
			testButton3.alpha = .5;
			
			testButton4.enabled = false;
			testButton4.alpha = .5;
			
			testButton5.enabled = false;
			testButton5.alpha = .5;
			
			LoaderMax.activate([MP3Loader, XMLLoader]);
			
			loadSounds();
		}
		
		override protected function addListeners():void
		{
			testButton1.addEventListener(MouseEvent.CLICK, testButton1ClickedHandler);
			testButton2.addEventListener(MouseEvent.CLICK, testButton2ClickedHandler);
			testButton3.addEventListener(MouseEvent.CLICK, testButton3ClickedHandler);
			testButton4.addEventListener(MouseEvent.CLICK, testButton4ClickedHandler);
			testButton5.addEventListener(MouseEvent.CLICK, testButton5ClickedHandler);
			
			resumeButton.addEventListener(MouseEvent.CLICK, resumeButtonClickHandler);
			pauseButton.addEventListener(MouseEvent.CLICK, pauseButtonClickHandler);
		}
		
		//--------------------------------------
		//  PRIVATE METHODS
		//--------------------------------------	
		private function loadSounds () : void
		{
			var loaderMax : LoaderMax = new LoaderMax({onComplete:completeHandler});
			loaderMax.append( new MP3Loader("sounds/1.mp3", {name:"sound1", autoPlay:false}) );
			loaderMax.append( new MP3Loader("sounds/2.mp3", {name:"sound2", autoPlay:false}) );
			loaderMax.append( new MP3Loader("sounds/3.mp3", {name:"sound3", autoPlay:false}) );
			loaderMax.append( new MP3Loader("sounds/4.mp3", {name:"sound4", autoPlay:false}) );
			loaderMax.append( new MP3Loader("sounds/5.mp3", {name:"sound5", autoPlay:false}) );
			loaderMax.append( new MP3Loader("sounds/6.mp3", {name:"sound6", autoPlay:false}) );
			loaderMax.append( new MP3Loader("sounds/7.mp3", {name:"sound7", autoPlay:false}) );
			loaderMax.append( new MP3Loader("sounds/8.mp3", {name:"sound8", autoPlay:false}) );
			
			loaderMax.load();
		}
		
		private function enableUI () : void
		{
			testButton1.enabled = true;
			testButton1.alpha = 1;
			
			testButton2.enabled = true;
			testButton2.alpha = 1;
			
			testButton3.enabled = true;
			testButton3.alpha = 1;
			
			testButton4.enabled = true;
			testButton4.alpha = 1;
			
			testButton5.enabled = true;
			testButton5.alpha = 1;
		}
		
		//--------------------------------------
		//  HANDLER METHODS
		//--------------------------------------
		private function completeHandler ( e : LoaderEvent ) : void
		{
			enableUI();
		}
		
		private function testButton1ClickedHandler ( e : MouseEvent ) : void
		{
			_soundPipeManager.playSoundWithID("sound1");
		}
		
		private function testButton2ClickedHandler ( e : MouseEvent ) : void
		{
			_soundPipeManager.playSoundWithID("sound2");
		}
		
		private function testButton3ClickedHandler ( e : MouseEvent ) : void
		{
			_soundPipeManager.playSoundWithID("sound3");
		}
		
		private function testButton4ClickedHandler ( e : MouseEvent ) : void
		{
			_soundPipeManager.playSoundWithID("sound4");
		}
		
		private function testButton5ClickedHandler ( e : MouseEvent ) : void
		{
			_soundPipeManager.playSoundWithID("sound7");
		}
			
		private function resumeButtonClickHandler ( e : MouseEvent ) : void
		{
			_soundPipeManager.resumeAllSound();
		}
		
		private function pauseButtonClickHandler ( e : MouseEvent ) : void
		{
			_soundPipeManager.pauseAllSound();
		}
			
				
	}
}