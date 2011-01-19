package bangfe.ui.dd
{
	public interface IDropZone
	{
		function castShadow ( p_item : BaseDragDropItem ) : Boolean;
		function drop ( p_item : BaseDragDropItem ) : void;
	}
}