package 
{
	
	import bangfe.core.CoreDisplayObject;
	import bangfe.ui.dd.BaseDragDropItem;
	import bangfe.ui.dd.BaseDropZone;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;

	public class TestDD extends CoreDisplayObject
	{
		
		public var testDropZone : BaseDropZone;
		
		override protected function setDefaults():void
		{
			testDropZone.addChild(new TestDragDropItem1() as BaseDragDropItem);
			testDropZone.addItem(new TestDragDropItem1() as BaseDragDropItem);
			testDropZone.addItem(new TestDragDropItem1() as BaseDragDropItem);
			
		}
		
	}
}