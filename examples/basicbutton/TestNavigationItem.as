package
{
	import bangfe.ui.NavigationItem;
	import bangfe.utils.DisplayObjectUtils;
	
	import com.greensock.TweenMax;
	import com.greensock.easing.Bounce;
	
	import flash.display.Sprite;
	
	public class TestNavigationItem extends NavigationItem
	{
		
		private var _defaultColor : Number = 0xFFFFFF;
		private var _hoverColor : Number = 0xe64097;
		
		public var base : Sprite;
		
		override protected function showDefaultState():void
		{
			if(this.hitTestPoint(stage.mouseX, stage.mouseY))return;
			//trace("DEFAULT");
			//trace("Enetered Show Default : ", this.labelField.text);
			TweenMax.to(labelField, .5, {tint:0x000000});
			
			//TweenMax.to(base, .5, {colorMatrixFilter:{colorize:_defaultColor, amount:1, brightness:1}});
			TweenMax.to(this, .5, {scaleX:1, scaleY:1, ease:Bounce.easeOut, dropShadowFilter:{color:0x000000, alpha:1, blurX:30, blurY:30, distance:0, strength:1}});
		}
		
		override protected function showSelectedState():void
		{
			//trace("Enetered Show Selected : ", this.labelField.text);
			//DisplayObjectUtils.sendToFront(this);
			TweenMax.to(labelField, .5, {tint:0xFFFFFF});
		}
		
		override protected function showHoverState():void
		{
			
			//trace("HOVER");
			//trace("Enetered Show Hover : ", this.labelField.text);
			TweenMax.to(labelField, .5, {tint:0xFFFFFF});	
			
			//TweenMax.to(base, .15, {colorMatrixFilter:{colorize:_hoverColor, amount:1, brightness:1}});
			
			//TweenMax.to(base, .5, {colorMatrixFilter:{colorize:_hoverColor, amount:1, brightness:1}});
			//TweenMax.to(this, .15, {dropShadowFilter:{color:0x000000,alpha:1, blurX:0, blurY:0,distance:0,strength:0, remove:true}});
			TweenMax.to(this, .25, {scaleX:1.2, scaleY:1.2});
			
			
		}
	}
}