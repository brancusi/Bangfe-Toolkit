package 
{
	
	import bangfe.core.CoreDisplayObject;
	import bangfe.ui.BasicNavigation;
	import bangfe.ui.NavigationGroup;
	import bangfe.ui.NavigationItem;
	
	import flash.display.MovieClip;

	public class TestBasicButton extends BasicNavigation
	{
		public var testButton1 : TestNavigationItem;
		public var testButton2 : TestNavigationItem;
		
		
		override protected function setDefaults():void
		{
			testButton1.label = "Button 1";
			testButton2.label = "Button 2";
			
			//testButton1.navigationGroup = this.navigationGroup;
		}
		
	}
}