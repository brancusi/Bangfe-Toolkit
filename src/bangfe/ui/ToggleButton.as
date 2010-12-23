package bangfe.ui
{
	import com.greensock.TweenMax;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import org.osflash.signals.Signal;

	/**
	 * A simple toggle button. Requires two stage instances:
	 * 		1) onIcon
	 * 		2) offIcon
	 *  
	 * @author Will Zadikian
	 * 
	 */	
	public class ToggleButton extends BasicButton
	{
		
		//--------------------------------------
		//  PUBLIC STATIC CONSTANTS
		//--------------------------------------
		public static const ON : String = "on";
		public static const OFF : String = "off";
		
		//--------------------------------------
		//  SIGNALS
		//--------------------------------------
		public var onRequestedSignal : Signal = new Signal();
		public var offRequestedSignal : Signal = new Signal();
		
		//--------------------------------------
		//  STAGE INSTANCES
		//--------------------------------------
		public var onIcon : Sprite;
		public var offIcon : Sprite;
		
		//--------------------------------------
		//  PRIVATE VARIABLES
		//--------------------------------------
		private var _currentState : String = OFF;
		
		//--------------------------------------
		//  PUBLIC METHODS
		//--------------------------------------
		public function toggle () : void
		{
			switch(state){
				case ON :
					setOff();
					break;
				case OFF :
					setOn();
					break;
			}
		}
		
		public function setOn ( p_dispatch : Boolean = true ) : void
		{
			if(_currentState == ON)return;
			
			_currentState = ON;
			showOnState();
			
			if(p_dispatch)onRequestedSignal.dispatch();
		}
		
		public function setOff ( p_dispatch : Boolean = true ) : void
		{
			if(_currentState == OFF)return;
			
			_currentState = OFF;
			showOffState();
			
			if(p_dispatch)offRequestedSignal.dispatch();
		}
		
		/**
		 * Is the toggle currently on 
		 * @return 
		 * 
		 */		
		public function isOn () : Boolean
		{
			return (state == ON);
		}
		
		//--------------------------------------
		//  ACCESSOR/MUTATOR METHODS
		//--------------------------------------
		/**
		 * Current state of the toggle. ToggleButton.ON or ToggleButton.OFF 
		 * @return 
		 * 
		 */
		public function get state () : String
		{
			return _currentState;
		}
		
		//--------------------------------------
		//  PROTECTED METHODS
		//--------------------------------------
		override protected function setGlobalDefaults () : void
		{
			onIcon.visible = true;
			offIcon.visible = false;
			super.setGlobalDefaults();
		}
		
		override protected function addGlobalListeners () : void
		{
			super.addGlobalListeners();
			addEventListener(MouseEvent.CLICK, clickHandler, false, 0, true);
		}
		
		override protected function removeGlobalListeners () : void
		{
			super.removeGlobalListeners();
			removeEventListener(MouseEvent.CLICK, clickHandler);
		}
		
		protected function showOnState () : void
		{
			TweenMax.to(onIcon, .25, {autoAlpha:1});
			TweenMax.to(offIcon, .25, {autoAlpha:0});
		}
		
		protected function showOffState () : void
		{
			TweenMax.to(onIcon, .25, {autoAlpha:0});
			TweenMax.to(offIcon, .25, {autoAlpha:1});
		}
		
		//--------------------------------------
		//  HANDLER METHODS
		//--------------------------------------
		private function clickHandler ( e : MouseEvent ) : void
		{
			toggle();
		}
		
	}
}