package bangfe.utils
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class CountDownTimer
	{
		
		private var _timer : Timer;
		private var _duration : Number = 4000;
		private var _repeat : Number = 1;
		private var _bindFunction : Function;
		
		public function CountDownTimer()
		{
			setDefault();
		}
	
		public function bind( p_handler : Function ) : void 
		{ 
			_bindFunction = p_handler;
		}
		
		public function unBind() : void 
		{ 
			_bindFunction = null;
		}

		public function start () : void
		{
			reset();
		}
		
		public function reset () : void
		{
			_timer.reset();
			_timer.start();
		}
		
		public function stop () : void
		{
			_timer.stop();
		}
		
		public function destroy () : void
		{
			removeListeners();
			_timer.stop();
		}
		
		public function get duration ( ) : Number { return _duration; }
		
		public function set duration ( p_duration : Number ) : void { _duration = p_duration; _timer.delay = _duration}
		
		public function get repeat  ( ) : Number { return _repeat ; }
		
		public function set repeat  ( p_repeat  : Number ) : void { _repeat = p_repeat ; _timer.repeatCount = _repeat }
		
		public function get isComplete () : Boolean
		{
			return (!_timer.running);
		}
		
		public function get running () : Boolean
		{
			return _timer.running;
		}
		
		protected function setDefault () : void
		{
			_timer = new Timer(_duration, _repeat);
			
			addListeners();
		}
		
		private function addListeners () : void
		{
			_timer.addEventListener(TimerEvent.TIMER, timerCompleteHandler, false, 0, true);
		}
		
		private function removeListeners () : void
		{
			_timer.removeEventListener(TimerEvent.TIMER, timerCompleteHandler);
		}
		
		private function timerCompleteHandler ( e : TimerEvent ) : void
		{
			_bindFunction.call();
		}
		
	}
}