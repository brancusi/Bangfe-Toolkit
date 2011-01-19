package
{
	import bangfe.core.CoreDisplayObject;
	import bangfe.ui.dd.BaseDragDropItem;
	import bangfe.ui.dd.IDropZone;
	
	public class TestDropZoneSimple extends CoreDisplayObject implements IDropZone
	{
		
		public function castShadow(p_item:BaseDragDropItem):Boolean
		{
			return false;
		}
		
		public function drop(p_item:BaseDragDropItem):void
		{
			trace(p_item);
		}
	}
}