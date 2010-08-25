package
{
	import bangfe.batchloader.BatchLoader;
	import bangfe.batchloader.events.BatchLoaderEvent;
	import bangfe.xmlmenu.XMLMenu;
	import bangfe.xmlmenu.events.XMLMenuItemEvent;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.text.StyleSheet;

	public class Test extends MovieClip
	{
		public var testPosition : Sprite;
		
		protected var _batchLoader : BatchLoader;
		protected var _menu : XMLMenu;
		
		public function Test()
		{
			var includeClasses : Array = [TestMenuItem];
			
			init();
		}
		
		protected function init () : void
		{
			
			_menu = new XMLMenu();
			
			_menu.addEventListener(XMLMenuItemEvent.SELECTED, itemSelectedHandler);
			
/*			_menu.x = 100;
			_menu.y = 100;*/
			
			addChild(_menu);
			
			_batchLoader = new BatchLoader();
			_batchLoader.addEventListener(BatchLoaderEvent.COLLECTION_COMPLETE, batchCompleteHandler);
			
			_batchLoader.addItem("menu.css");
			_batchLoader.addItem("menu.xml");
			
			_batchLoader.resume();
			
		}
		
		protected function buildMenu () : void
		{
			var xml : XML = new XML(_batchLoader.getContent("menu.xml"));
			
			var styleSheet : StyleSheet = new StyleSheet();
			styleSheet.parseCSS(_batchLoader.getContent("menu.css"));
			
            _menu.styleSheet = styleSheet;

			_menu.data = xml;
		}
		
		protected function itemSelectedHandler ( e : XMLMenuItemEvent ) : void
		{
			//trace(_menu.currentSelectedUID);
			
			var displayObject : * = e.target as DisplayObject;
			
			_menu.x = stage.stageWidth/2 - _menu.menuWidth/2;
			
			testPosition.x = displayObject.x;
		}
		
		protected function batchCompleteHandler ( e : BatchLoaderEvent ) : void
		{
			buildMenu();
		}
		
	}
}