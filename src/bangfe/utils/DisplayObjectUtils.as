package bangfe.utils
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;

	public class DisplayObjectUtils
	{

		/**
		 * Send the supplied DisplayObject to the front index. Will push the other items back
		 * @param p_displayObject
		 * 
		 */		
		public static function sendToFront ( p_displayObject : DisplayObject ) : void
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
		
		/**
		 * Checks if the target is nested within a specific type of diplay object 
		 * @param p_displayObject The target to check
		 * @param p_validClassDefintion The type to check against
		 * @return 
		 * 
		 */		
		public static function isNestedWithinType ( p_displayObject : DisplayObject, p_validClassDefintion : Class ) : Boolean
		{
			if(!p_displayObject) return false;
			
			if(!p_displayObject.parent)return false;
			
			var targetCheck : DisplayObjectContainer = p_displayObject.parent;
			
			while(targetCheck){
				if(targetCheck is p_validClassDefintion)return true;
				targetCheck = targetCheck.parent;
			}	
			
			return false;
		}
		
		/**
		 * Gets the parent with the correct definition
		 * This is useful for getting a specific level of the display tree when dragging and dropping a display object
		 * It cycles up and returns the specified object definied by the p_validClassDefintion param
		 * 
		 * @param p_displayObject The DisplayObject to start from
		 * @param p_validClassDefintion The Class definition to validate against
		 * @return 
		 * 
		 */		
		public static function getParentWithDefinition ( p_displayObject : DisplayObject, p_validClassDefintion : Class ) : *
		{
			if(!p_displayObject) return null;
			
			if(p_displayObject is p_validClassDefintion)return p_displayObject;
			
			if(!p_displayObject.parent)return null;
			
			var targetCheck : DisplayObjectContainer = p_displayObject.parent;
			
			while(targetCheck){
				if(targetCheck is p_validClassDefintion)return targetCheck;
				targetCheck = targetCheck.parent;
			}	
			
			return null;
		}
		
		
	}
}