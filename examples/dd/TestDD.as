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

		override protected function addListeners():void
		{
			testDropZone.childCountChangedSignal.add(childCountChangedHandler);
			testDropZone.childSortingChangedSignal.add(childSortingChangedHandler);
			testDropZone.stateChangedSignal.add(childStateChangedHandler);
		}
		
		override protected function postInit():void
		{
			testDropZone.addChild(new TestDragDropItem1() as BaseDragDropItem);
			testDropZone.addItem(new TestDragDropItem1() as BaseDragDropItem);
			testDropZone.addItem(new TestDragDropItem1() as BaseDragDropItem);
		}
		
		private function childCountChangedHandler ( p_childCount : int ) : void
		{
			trace(p_childCount, " p_childCount");
		}
		
		private function childSortingChangedHandler () : void
		{
			trace("Sorting Changed");	
		}
		
		private function childStateChangedHandler ( p_state : String ) : void
		{
			trace(p_state, " p_state");
		}
		
	}
}