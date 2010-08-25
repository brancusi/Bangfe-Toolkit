package 
{
	import bangfe.scrollbar.core.AbstractScrollbar;
	import bangfe.scrollbar.events.ScrollbarEvent;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class TestScrollBar extends MovieClip
	{
		
		public var scrollBar : AbstractScrollbar;
		public var test1 : Sprite;
		public var test2 : Sprite;
		
		public function TestScrollBar()
		{
			scrollBar.addEventListener(ScrollbarEvent.VALUE_CHANGE, changeHandler);
			
			//Changes size
			test1.addEventListener(MouseEvent.CLICK, test1Click);
			
			//Changes size
			test2.addEventListener(MouseEvent.CLICK, test2Click);
		}
		
		protected function changeHandler ( e : ScrollbarEvent ) : void
		{
			trace(e.value);
		}
		
		protected function test1Click ( e : MouseEvent ) : void
		{
			scrollBar.height = 100;
		}
		
		protected function test2Click ( e : MouseEvent ) : void
		{
			scrollBar.height = 300;
		}
	}
}