package
{
	import bangfe.xmlmenu.display.BasicMenuItem;
	
	import flash.display.Shape;
	import flash.text.TextFieldAutoSize;
	
	import gs.TweenMax;
	
	import pegas.draw.Direction;

	public class TestMenuItem extends BasicMenuItem
	{
		public var pipe : Shape = new Shape();
		
		public function TestMenuItem()
		{
			super();
		}
		
		override protected function setDefaults():void
		{
			super.setDefaults();
			
			//_style.border = true;
			
			pipe.visible = false;
			pipe.graphics.beginFill(0xFFFFFF);
			pipe.graphics.drawRect(0, 0, 1, 1);
			pipe.graphics.endFill();
			addChild(pipe);
		}
		
		override protected function draw():void
		{
			super.draw();
			//Should pipe show up
			if(parentDirection == Direction.HORIZONTAL && !isLast)pipe.visible = true;
	
			pipe.x = viewScope.x + viewScope.width + 10;
		}
		
		override protected function showOverState () : void
		{
			TweenMax.killTweensOf(pipe);
			TweenMax.killTweensOf(viewScope);
			TweenMax.to(viewScope, .5, {glowFilter:{color:0xFFFFFF, alpha:1, blurX:10, blurY:10}});
		}
		
		override protected function showOutState () : void
		{
			TweenMax.killTweensOf(pipe);
			TweenMax.killTweensOf(viewScope);
			TweenMax.to(viewScope, .5, {glowFilter:{color:0xFFFFFF, alpha:1, blurX:0, blurY:0}});
			TweenMax.to(pipe, 1, {height:viewScope.height});
		}
		
		override protected function showSelectedState () : void
		{
			TweenMax.killTweensOf(pipe);
			TweenMax.killTweensOf(viewScope);
			TweenMax.to(viewScope, .5, {glowFilter:{color:0xFFFFFF, alpha:1, blurX:10, blurY:10}});
			TweenMax.to(pipe, 1, {height:this.itemHeight});
		}
		

	}
}