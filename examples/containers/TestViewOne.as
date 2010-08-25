package
{
	import bangfe.core.CoreDisplayObject;
	import bangfe.core.ITransitionable;
	import bangfe.events.TransitionableEvent;
	
	import com.greensock.TweenMax;
	
	import flash.display.Sprite;
	
	public class TestViewOne extends CoreDisplayObject implements ITransitionable
	{
		public function TestViewOne()
		{
			super();
		}
		
		override public function destroy():void
		{
			super.destroy();
		}
		
		public function transitionIn():void
		{
			TweenMax.to(this, 3, {autoAlpha:1, onComplete:transitionInComplete});
		}
		
		public function transitionOut():void
		{
			TweenMax.to(this, 3, {autoAlpha:0, onComplete:transitionOutComplete});
		}
		
		public function transitionInComplete():void
		{
			this.dispatchEvent(new TransitionableEvent(TransitionableEvent.TRANSITION_IN_COMPLETE));
		}
		
		public function transitionOutComplete():void
		{
			this.dispatchEvent(new TransitionableEvent(TransitionableEvent.TRANSITION_OUT_COMPLETE));
		}
		
		override protected function setDefaults():void
		{
			this.alpha = 0;
		}
	}
}