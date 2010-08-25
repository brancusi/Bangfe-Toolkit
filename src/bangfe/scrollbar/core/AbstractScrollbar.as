package bangfe.scrollbar.core
{
	import bangfe.scrollbar.events.ScrollbarEvent;
	
	import com.greensock.TweenMax;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	

	/**
	 * SimpleScrollBar 
	 * @author Will Zadikian
	 * 
	 */	
	 
	/**
	* Dispatched on value change.
	*
	* @eventType bangfe.scrollbar.events.ScrollBarEvent.VALUE_CHANGE
	*/			
	[Event(name="valueChange", type="bangfe.scrollbar.events.ScrollbarEvent")]
	
	public class AbstractScrollbar extends MovieClip
	{
		
		//--------------------------------------
		//  STAGE INSTANCES
		//--------------------------------------
		public var track : Sprite;
		public var base : Sprite;
		public var drag : Sprite;
		
		public var upArrow : Sprite;
		public var downArrow : Sprite;
		
		//--------------------------------------
		//  PROTECTED VARIABLES
		//--------------------------------------
		
		protected var _value : Number = 0;
		protected var _isDragging : Boolean = false;
		
		protected var _offsetTop : Number;
		protected var _offsetBottom : Number;
		
		//--------------------------------------
		//  PUBLIC METHODS
		//--------------------------------------
		
		/**
		 * Constructor 
		 * 
		 */		
		public function AbstractScrollbar()
		{
			init();
		}
		
		/**
		 * Destroy implementation 
		 * 
		 */		
		public function destroy () : void
		{
			removeListeners();
			removeDragListeners();
		}
		//--------------------------------------
		//  ACCESSOR METHODS
		//--------------------------------------
		
		public function get value () : Number
		{
			return _value;
		}
		
		public function set value ( p_value : Number ) : void
		{
		
			if(_value == Number(p_value.toFixed(2)))return;
			
			_value = Number(p_value.toFixed(2));
			draw();
			
			dispatchChange();
		}
		
		/**
		 * Is volume drag currently being dragged 
		 * @return 
		 * 
		 */		
		public function get isDragging () : Boolean
		{
			return _isDragging;
		}
		
		public function set isDragging ( p_isDragging : Boolean) : void
		{
			_isDragging = p_isDragging;
		}
		
		/**
		 * Offset the drag should be from the top of the base 
		 * @return 
		 * 
		 */		
		public function get offsetTop () : Number 
		{
			return _offsetTop; 
		}

		public function set offsetTop ( p_offsetTop : Number ) : void 
		{ 
			_offsetTop = p_offsetTop; 
		}
		
		/**
		 * Offset the drag should be from the bottom of base 
		 * @return 
		 * 
		 */				 
		public function get offsetBottom () : Number 
		{
			return _offsetBottom; 
		}

		public function set offsetBottom ( p_offsetBottom : Number ) : void 
		{ 
			_offsetBottom = p_offsetBottom; 
		}
		
		/**
		 * Height override 
		 * @return 
		 * 
		 */		
		override public function set height(value:Number) : void
		{
			base.height = value;
			track.height = value;
			draw();
		}
		
		//--------------------------------------
		//  PROTECTED METHODS
		//--------------------------------------
		
		protected function init () : void
		{
			setDefaults();
			addListeners();
		}
		
		protected function setDefaults () : void
		{
			track.mouseEnabled = false;
			track.mouseChildren = false;
			
			base.buttonMode = true;
			drag.buttonMode = true;
			
			offsetTop = drag.height/2;
			offsetBottom = drag.height/2;
		}
		
		protected function addListeners () : void
		{
			base.addEventListener(MouseEvent.MOUSE_DOWN, barDownHandler, false, 0, true);
			drag.addEventListener(MouseEvent.MOUSE_DOWN, dragMouseDown, false, 0, true);
		}
		
		protected function addDragListeners () : void
		{
			//drag.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler, false, 0, true);
			this.stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler, false, 0, true);
			this.stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler, false, 0, true);
		}
		
		protected function removeDragListeners () : void
		{
			//drag.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler, false);
			this.stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler, false);
			this.stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler, false);
		}
		
		protected function removeListeners () : void
		{
			base.removeEventListener(MouseEvent.MOUSE_DOWN, barDownHandler, false);
		}
		
		protected function draw () : void
		{	
			if(isDragging)return;
			
			var newY : Number = offsetTop + ((base.height - offsetTop - offsetBottom) * _value);
			TweenMax.killTweensOf(drag);
			TweenMax.to(drag, .3, {y:newY});
		}
		
		protected function dispatchChange () : void
		{
			var event : ScrollbarEvent = new ScrollbarEvent(ScrollbarEvent.VALUE_CHANGE, value);
			dispatchEvent(event);
		}
		
		//--------------------------------------
		//  HELPER METHODS
		//--------------------------------------
		
		/**
		 * Calculate volume based on a bar click 
		 * 
		 */		
		protected function calculateVolumeFromBar () : void
		{
			var unit : Number = 1/base.height;

			var offset : Number = this.mouseY - base.y;
			var percentage:Number = (offset * unit);
			
			if(percentage < 0)percentage = 0;
			if(percentage > 1)percentage = 1;

			value = percentage;
		}
		
		/**
		 * Calculate volume from current drag location 
		 * 
		 */		
		protected function calculateValueFromDrag () : void
		{
			var unit : Number = 1/(base.height - offsetTop - offsetBottom)
			var offset : Number = (drag.y-(base.y + offsetTop));
			var percentage:Number = (offset * unit);
			
			if(percentage < 0)percentage = 0;
			if(percentage > 1)percentage = 1;
			
			value = percentage;
		}
		
		protected function startBarDrag () : void
		{
			isDragging = true;
			
			addDragListeners();
			
			
			
			/*var dragRect : Rectangle = new Rectangle(drag.x, base.y+drag.height/2, 0, base.height-drag.height);
			drag.startDrag(true, dragRect);*/
		}
		
		protected function stopBarDrag () : void
		{
			isDragging = false;
			removeDragListeners();
			drag.stopDrag();
			calculateValueFromDrag();
		}
		
		//--------------------------------------
		//  PRIVATE METHODS
		//--------------------------------------
		private function updateDragPosition () : void
		{
			/*var newY : Number = base.mouseY; 
			
			if(newY < )*/
			drag.y = base.mouseY;
			
			if(drag.y < 0){
				drag.y = 0;
			}
			
			if(drag.y > base.height){
				drag.y = base.height;
			}
		}
		
		//--------------------------------------
		//  HANDLER METHODS
		//--------------------------------------
		
		protected function barDownHandler ( e : MouseEvent ) : void
		{
			//calculateVolumeFromBar();
			startBarDrag();
		}
		
		protected function dragMouseDown ( e : MouseEvent ) : void
		{
			startBarDrag();
		}
		
		protected function mouseUpHandler ( e : MouseEvent ) : void
		{			
			stopBarDrag();
		}
		
		protected function mouseMoveHandler ( e : MouseEvent ) : void
		{
			updateDragPosition();
			calculateValueFromDrag();
		}

	}
}