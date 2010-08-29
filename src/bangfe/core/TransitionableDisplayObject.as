package bangfe.core
{
	import bangfe.events.TransitionableEvent;
	
	import com.greensock.TweenMax;
	
	import flash.display.DisplayObject;
	import flash.geom.Point;

	public class TransitionableDisplayObject extends CoreDisplayObject implements ITransitionable
	{

		//--------------------------------------
		//  PUBLIC METHODS
		//--------------------------------------

		/** @inheritDoc */
		public function transitionIn():void
		{
			TweenMax.to(this, 1, {autoAlpha:1, onComplete:transitionInComplete});
		}
		
		/** @inheritDoc */
		public function transitionOut():void
		{
			TweenMax.to(this, 1, {autoAlpha:0, onComplete:transitionOutComplete});
		}
		
		/** @inheritDoc */
		public function transitionInComplete():void
		{
			dispatchEvent(new TransitionableEvent(TransitionableEvent.TRANSITION_IN_COMPLETE));
		}
		
		/** @inheritDoc */
		public function transitionOutComplete():void
		{
			dispatchEvent(new TransitionableEvent(TransitionableEvent.TRANSITION_OUT_COMPLETE));
		}
	}
}