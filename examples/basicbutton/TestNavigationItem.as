package
{
	import bangfe.ui.NavigationItem;
	import bangfe.utils.DisplayObjectUtils;
	
	import com.greensock.TweenMax;
	
	public class TestNavigationItem extends NavigationItem
	{
		override protected function showDefaultState():void
		{
			//trace("Enetered Show Default : ", this.labelField.text);
			TweenMax.to(labelField, .5, {tint:0x000000});
		}
		
		override protected function showSelectedState():void
		{
			//trace("Enetered Show Selected : ", this.labelField.text);
			//DisplayObjectUtils.sendToFront(this);
			TweenMax.to(labelField, .5, {tint:0xFFFFFF});
		}
		
		override protected function showHoverState():void
		{
			//trace("Enetered Show Hover : ", this.labelField.text);
			TweenMax.to(labelField, .5, {tint:0xFFFFFF});	
		}
	}
}