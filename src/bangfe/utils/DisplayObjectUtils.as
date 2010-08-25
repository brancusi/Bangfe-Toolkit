package bangfe.utils
{
	import flash.display.DisplayObject;

	public class DisplayObjectUtils
	{
		public function DisplayObjectUtils()
		{
		}
		
		/**
		 * Bring the supplied DisplayObject to the front
		 * @param p_displayObject
		 * 
		 */		
		public static function bringToFront ( p_displayObject : DisplayObject ) : void
		{
			if(!p_displayObject.parent)return;
			var topChild : DisplayObject = p_displayObject.parent.getChildAt(p_displayObject.parent.numChildren-1);
			p_displayObject.parent.swapChildren(p_displayObject, topChild);
		}
		
		/**
		 * Bring the supplied DisplayObject right under the front most object 
		 * @param p_displayObject
		 * 
		 */		
		public static function sendBelowFront ( p_displayObject : DisplayObject ) : void
		{
			if(!p_displayObject.parent)return;
			if(p_displayObject.parent.numChildren < 3)return;
			
			var secondChild : DisplayObject = p_displayObject.parent.getChildAt(p_displayObject.parent.numChildren-2);
			p_displayObject.parent.swapChildren(p_displayObject, secondChild);
		}
		
		/**
		 * Send the supplied DisplayObject to the back 
		 * @param p_displayObject
		 * 
		 */		
		public static function sendToBack ( p_displayObject : DisplayObject ) : void
		{
			if(!p_displayObject.parent)return;
			var bottomChild : DisplayObject = p_displayObject.parent.getChildAt(0);
			p_displayObject.parent.swapChildren(p_displayObject, bottomChild);
		}
		
		
	}
}