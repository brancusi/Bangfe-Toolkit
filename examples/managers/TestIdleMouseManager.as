package 
{
	
	import bangfe.core.CoreDisplayObject;
	import bangfe.managers.IdleMouseManager;
	import bangfe.ui.BasicNavigation;
	import bangfe.ui.NavigationGroup;
	import bangfe.ui.NavigationItem;
	import bangfe.ui.ToggleButton;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;

	public class TestIdleMouseManager extends CoreDisplayObject
	{
		public var testObject : ToggleButton;
		public var testBase : Sprite;
		
		private var _idleMouseManager : IdleMouseManager;
		
		override protected function setDefaults():void
		{
			//Set the testBase as scope. Hovering and moving around testBase will reset elapsed time
			_idleMouseManager = new IdleMouseManager(testBase);
			
			//Will idle ifthe mouse stays idle for 1 second
			_idleMouseManager.idleTime = 1000;
			
			//While hovering this object, the idle signal will never be dispatched
			_idleMouseManager.addSafeChild(testObject);
		}
		
		override protected function addListeners():void
		{
			_idleMouseManager.idledSignal.add(idledHandler);
			_idleMouseManager.activatedSignal.add(activatedHandler);
			
			testObject.onRequestedSignal.add(turnOn);
			testObject.offRequestedSignal.add(turnOff);
		}
		
		override protected function postInit():void
		{
			//_idleMouseManager.start();
		}
		
		private function turnOn () : void
		{
			trace("Requested Start");
			_idleMouseManager.start();
		}
		
		private function turnOff () : void
		{
			trace("Requested Stop");
			_idleMouseManager.start();
			_idleMouseManager.stop();
		}
		
		//Will be called on mouse idle
		private function idledHandler () : void
		{
			trace("Idled");
		}
		
		//Will be called on reactivation
		private function activatedHandler () : void
		{
			trace("Activated");	
		}
		
		
		
	}
}